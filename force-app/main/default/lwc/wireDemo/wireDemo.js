import { LightningElement , wire, track} from 'lwc';
import FootBalls from '@salesforce/apex/wireDemoClassBySalesforceNoob.getFootBallList';
const col = [

        { label : "Name" , fieldName : "Name"},
        { label : "Player Record ID ", fieldName : "Id"},

];
export default class WireDemo extends LightningElement {

    @track columns = col;

    @track data = [];

    //@wire(apexMethodName, {apexmethodparameters})

    @wire(FootBalls)// it like it is calling the method defined in '@salesforce/apex/wireDemoClassBySalesforceNoob.getFootBallList' 

    wiredFootBalls({data , er}) { // we made a simple function which takes two parameters data and er But how and who is calling this function??

            if(data) {

                this.data = data;
            }
            else if(er) {

                    console.log("error occurred");
            }

    } //can be any name if data comes successfully than it will be get stored in 'data' else in error

    
    
}