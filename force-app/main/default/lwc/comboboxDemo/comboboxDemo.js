import { LightningElement , track, api} from 'lwc';
import getAccounts from  '@salesforce/apex/AccountAndContacts.getAccounts';
import getContacts from '@salesforce/apex/AccountAndContacts.getContacts';

const Col = [

            { label : "Name " , fieldName : "Name"},
            { label : "Record Id ", fieldName : "Id" },
];

export default class ComboboxDemo extends LightningElement {

        @track Accounts = [];
        @track Value ='';
        @track Columns = Col;
        @track Data = [];
        @api recordId;

        connectedCallback() {

                getAccounts()
                    .then(result => {

                            console.log("result camed is "+result);
                            let arr = [];
                            for(var i = 0; i<result.length; i++) {

                                arr.push({label : result[i].Name , value : result[i].Id})//why thi.Accounts.push is not working here 
                                
                            }
                            this.Accounts = arr;
                    })
                    .catch(error => {

                            console.log("error occurred "+error);
                    })
            
        }
        get Options() {
            return this.Accounts;
        }

         handleChange(event) {

                    this.Value = event.detail.value;

                        console.log("inside handleChange function value of this.Value is ",this.Value);
                    getContacts({accountId  : this.Value}) // here we have to pass arguments like this only 
                                                    //accountId is the same name defined in the AccountAndContacts class 
                                                    // then we made this accountId value equals to this.Value  
                        .then( result => {

                            this.Data = result;
                            console.log("inside handlechange result  = "+result);

                        })
                        .catch(error => {

                                console.log("some error occurred inside getContacts block ",error);
                        })

        }

        handleRowSelection(event) {
                
                console.log("inside handleROWSElection ");
                console.log(event.detail.row);
               // location.href = 'https://playful-fox-rnbplj-dev-ed.lightning.force.com/lightning/r/Contact/'+this.Value+'/view';
        }

}