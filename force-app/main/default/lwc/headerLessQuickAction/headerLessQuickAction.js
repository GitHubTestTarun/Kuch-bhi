import { LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createContact from '@salesforce/apex/HeaderLessQuickActionController.createContact';
import fetchContatcs from '@salesforce/apex/HeaderLessQuickActionController.fetchContatcs';

export default class HeaderLessQuickAction extends LightningElement {
    @api recordId;
    options = [];
    selectedContact;

    @api
   async invoke() {
        console.log('inside invoke method record id is ', this.recordId);
        await createContact({accountId : this.recordId})
        .then((res)=> {
            console.log(res);
           this.showToastMessage('done', 'contact created succesfully', 'success');
        })
        .catch((error)=> {
            console.log('error ', error);
            this.showToastMessage('not done', 'unable to create contact', 'error');
        })

       await fetchContatcs({accountId : this.recordId})
        .then((result) => {
            this.showToastMessage('done', ' succesfully', 'success');
            console.log('result con ', result);
        
                for(let i =0; i<= result.length; i++) {
                    if(this.result[i] != undefined) {
                        this.options.push({label:result[i].Name, value: result[i].Name});
                    }
                }
            
        })
        .catch((error) => {
            this.showToastMessage('not done',error, 'error');
            console.log('error ', error);
        })
    }

    showToastMessage(titleP, messageP, variantP){
        this.dispatchEvent(new ShowToastEvent({
            title: titleP,
            message: messageP,
            variant: variantP
        }));
    }
    
}