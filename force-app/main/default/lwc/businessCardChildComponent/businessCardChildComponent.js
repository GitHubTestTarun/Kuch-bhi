import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';
import { LightningElement , api} from 'lwc';

export default class BusinessCardChildComponent extends LightningElement {

    @api userDetails
    @api username = 'default'
    
    
    @api NameAlert(event) {
     
        window.alert(event.target.value);
    
    }

}