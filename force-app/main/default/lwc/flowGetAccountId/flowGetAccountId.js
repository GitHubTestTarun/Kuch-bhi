import { LightningElement, api } from 'lwc';

export default class FlowGetAccountId extends LightningElement {
    @api recordIds= [];
   
    renderedCallback() {
        console.log('recordId is ', this.recordIds.originalTarget);
        console.log('JSON.stringify(this.recordIds) >> ', JSON.stringify(this.recordIds));
        console.log('recordId is ', this.ids);
    }
}