import { LightningElement } from 'lwc';

export default class BindHtml extends LightningElement {

    handleChange(event) {
        this.showMe = event.target.checked;
    }
}