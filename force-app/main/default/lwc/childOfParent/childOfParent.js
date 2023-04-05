import { LightningElement, api} from 'lwc';

export default class ChildOfParent extends LightningElement {

    @api message;
    @api className;

    get alertClassName() {

            console.log(`alert ${this.className}`);
            return this.className ? `alert ${this.className}`: `alert`

    }

}