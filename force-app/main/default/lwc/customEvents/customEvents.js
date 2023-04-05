import { LightningElement } from 'lwc';

export default class customEvents extends LightningElement {

    page = 1;

    previousHandler() {
       // this.dispatchEvent(new CustomEvent('previous'));
       if(this.page > 1) {
        this.page = this.page - 1;
       }
    }

    nextHandler() {
        //this.dispatchEvent(new CustomEvent('next'));
        this.page = this.page + 1;
    }
}