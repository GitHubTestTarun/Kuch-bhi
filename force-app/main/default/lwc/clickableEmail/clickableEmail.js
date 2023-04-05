import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ClickableEmail extends NavigationMixin (LightningElement) {

    @api AccountName;
    @api recordId;
    navigateToRecord(event) {
        //Navigate to the record 
        event.preventDefault();

         // Navigate to the Account home page
         this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',// type = pageReference here we are using standard one but search for custom one 
            attributes: {
                recordId: this.recordId,
                actionName: 'View',
            },
        }).then(url => {window.open(url)});  // here .then is used to open the page in new tab 
    }
}