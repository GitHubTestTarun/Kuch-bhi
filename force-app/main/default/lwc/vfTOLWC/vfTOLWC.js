import { LightningElement, api} from 'lwc';
import getBase64 from '@salesforce/apex/policyPageHandler.getBase64';


export default class VfTOLWC extends LightningElement {

    showPDF = false;
    pdfLink = '';

    connectedCallback(){
        // let temp = 'data:application/pdf;base64,'+pdf;
        getBase64()
        .then((result) => {
            console.log('result camed is ', result);
            this.showPDF = true;
            this.pdfLink = result;
            console.log('link is ', this.pdfLink);

            // 'data:application/pdf;base64,' + result + '#toolbar=0&navpanes=0&zoom=90';
            console.log('this.pdfLink is ', this.pdfLink);
            console.log('qqqqq ', this.template.querySelector('pdfFrame'));
        })
        .catch((error) => {
            console.log('error camed is ', error);
        })
    }
    clickHandler(event) {
        console.log('inside clickHandler event is ', event);
        console.log('inside clickHandler event.target is ', event.target);
        console.log('inside clickHandler event is ', event.querySelector);
    }
    //'https://playful-fox-rnbplj-dev-ed.lightning.force.com/lightning/o/ContentDocument/home'+
}