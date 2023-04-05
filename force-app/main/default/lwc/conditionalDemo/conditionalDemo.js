import { LightningElement, track } from 'lwc';

export default class ConditionalDemo extends LightningElement {

    @track onclickButtonLabel = 'Show';
    myTitle = "Salesforce Noob";
    @track cardVisible = false;

    HandleClick(event) {

            const label = event.target.label;
        

            if(label === 'Show') {

                this.onclickButtonLabel = 'Hide';
                this.cardVisible = true;
            }
            else if(label === 'Hide') {

                    this.onclickButtonLabel = 'Show';
                    this.cardVisible = false;
            }
    }
}