import { LightningElement , track} from 'lwc';
import getFootBalls from '@salesforce/apex/imperativeDemo.getFootBalls';
const col = [

        { label : "foot ball record id ", fieldName: "Id"},
        { label : "Football Name ", fieldName: "Name"},
        { label : "Number of balls are ", fieldName: "Quantity__c"},// here api namme comes inside double or sungle quotes 

];
export default class ImperativeDemo extends LightningElement {

        @track columns = col;
        @track data = [];

        //it is an lifecycle method of LWC

        connectedCallback() {

                getFootBalls() // here we called imperative method of an apex class which will either return an promise if data is found  which will be handled by .then(result) block 
                                //and if data is not found then it will through an error which is handle by catch block 
                        .then(result => {

                                this.data = result;
                        })
                        .catch( error => {
                                console.log("error occurred  ");
                        } )
                
        }

}