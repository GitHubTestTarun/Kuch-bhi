import { LightningElement, api, wire, track } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Account_Id_Field from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getsearchedAccounts from '@salesforce/apex/AccountController.getAccountData';
import {getRecordNotifyChange } from 'lightning/uiRecordApi';
import getOffsetAccounts from '@salesforce/apex/AccountController.getOffsetAccounts';
import updateAccoutns from '@salesforce/apex/AccountController.updateAccoutns';
//, type: 'clickableEmail', typeAttributes: { recordId:{fieldName: Account_Id_Field}, editable: true },
const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text'},
    { label: 'Annual Revenue', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency', editable: true },
    { label: 'Industry', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text', editable: true },
];

export default class Pagination extends LightningElement {

   
    columns = COLUMNS;
    recordsPerPage = [100, 200, 300, 400, 500];
    recordsToShow;
    BackupData;
    EditedValues = [];
    finalData;
    SearchValue;
    totalRecords;
    pageNumber;
    pageSize = 10;
    totalPages;
    recordsToDisplay = [];
    NextDisabled = false;
    PreviousDisabled = false;
    options = [];
    
    async handleSave(event) {
        const updatedFields = event.detail.draftValues;
        
        // Prepare the record IDs for getRecordNotifyChange()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
        console.log('notifyChangeIds >> ', notifyChangeIds);
        try {
            // Pass edited fields to the updateContacts Apex controller
            const result = await updateAccoutns({data: updatedFields});
            console.log(JSON.stringify("Apex update result: "+ result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Accounts updated',
                    variant: 'success'
                })
            );
    
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
            eval("$A.get('e.force:refreshView').fire();");
            // Display fresh data in the datatable
            await refreshApex(this.finalData);
                // Clear all draft values in the datatable
                this.EditedValues = [];
            
       } 
       catch(error) {
               this.dispatchEvent(
                   new ShowToastEvent({
                       title: 'Error updating or refreshing records',
                       message: error.body.message,
                       variant: 'error'
                   })
             );
        };
    }
  
    handleChange(event) {
        console.clear();
       
        this.NextDisabled = false;
        console.log('inside handlechange ', event.target.value);
        this.recordsToShow = parseInt(event.target.value);
        console.log('before this.pageNumber ', this.pageNumber);
        this.pageNumber = 1;
        console.log('after this.pageNumber ', this.pageNumber);
        console.log('inside handleChange after recordstoshow being Set a value ', this.recordsToShow);
        this.recordViewHandler();

    }

    connectedCallback() {
        this.recordsToShow = this.recordsPerPage[0];
        getAccounts()
        .then((result)=> {
            this.BackupData = this.finalData = result;
            this.totalRecords = result.length;
            console.log('finalData ', this.finalData);
            let dataToDisplay = [];
            this.pageNumber = 1;
            console.log('this.this.recordsPerPage[0] ', this.recordsPerPage[0]);
            if(this.pageNumber == 1) {
                this.PreviousDisabled = true;
            }
            this.recordViewHandler();
        })
        .catch((error) => {
            console.log('error occurred ', error);
        })
        for(let i = 0; i< this.recordsPerPage.length; i++ ){
            console.log('inside comboBox valueSets this.recordsPerPage[i] == ',this.recordsPerPage[i]);
            this.options.push({label:this.recordsPerPage[i], value: this.recordsPerPage[i]});
        }
    }

    recordViewHandler() {
        this.totalRecords = this.finalData.length;
        let data = [];
        console.log('this.pageNumber before LOOP ', this.pageNumber);
        console.log('Before LOOP this.totalRecords / this.recordsToShow ', this.totalRecords / this.recordsToShow);
        for(let i = this.recordsToShow * (this.pageNumber-1); i < this.recordsToShow * this.pageNumber ; i++) {
            if(this.finalData[i] != undefined) {
                data.push({Id: this.finalData[i].Id, Name: this.finalData[i].Name, AnnualRevenue : this.finalData[i].AnnualRevenue, Industry : this.finalData[i].Industry});
            }
        }
        this.recordsToDisplay = data;
    }

   previousAndNext(event) {
   
        if(event.target.value == 'previous') {
        
            if(this.pageNumber > 1) {
                this.NextDisabled = false;
                this.PreviousDisabled = false;
                console.log('pagenumber in previous block ', this.pageNumber);
                --this.pageNumber;
                console.log('previous');
                this.recordViewHandler();
            }
            if(this.pageNumber == 1) {
                this.PreviousDisabled = true;
            }
            console.log('pagenumber after previous block ', this.pageNumber);
        }
        if(event.target.value == 'Next') {
            console.log('inside next this.recordsToShow ', this.recordsToShow);
            console.log('Math.ciel(this.totalRecords / this.recordsToShow) ', Math.ceil(this.totalRecords / this.recordsToShow));
            console.log('pagenumber in next block ', this.pageNumber);

            if(this.pageNumber <= Math.ceil(this.totalRecords / this.recordsToShow)) {
                ++this.pageNumber;
                this.PreviousDisabled = false;
                console.log('next');            
                console.log('pagenumber after next block ', this.pageNumber);
            }
      
            if(this.pageNumber >= Math.ceil(this.totalRecords/ this.recordsToShow)) {
                this.NextDisabled = true;
                this.pageNumber = Math.ceil(this.totalRecords/ this.recordsToShow);
            }
            
            this.recordViewHandler();
        }
   }
  
    handleSearch(event) {

        this.pageNumber = 1;
        this.SearchValue = event.target.value;
        console.log('this.SearchValue is ', this.SearchValue);
        
        console.log('this.SearchValue len => ', this.SearchValue.length);
        if(this.SearchValue.length > 0 ) {
            console.log('calleing search() ');
            this.callSearch();
        }
        else {
            console.log('calling recordviewHandler() ');
            this.finalData = this.BackupData;
            this.pageNumber = 1;
            this.recordViewHandler();
        }
    }

    callSearch() {
        console.log('inside callSearch');
        getsearchedAccounts({accName : this.SearchValue})
        .then((result) => {
          //  console.clear();
            console.log('result is asdfasdfasdfasdf', result);
            this.finalData = result;
            // this.recordsToDisplay = result;
            this.totalRecords = result.length;
            this.recordViewHandler();
        })
        .catch((error) => {
            console.log('error occurred in search data ', error);
        })   
    }

    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        //displays that fieldName of the selected rows

        for(let i = 0; i< selectedRows.length; i++) {
            alert('you selected : '+selectedRows[i].Name);
        }
    }
}