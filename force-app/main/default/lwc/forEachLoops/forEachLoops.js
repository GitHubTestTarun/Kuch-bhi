import { LightningElement ,wire, track} from 'lwc';
import footballs from '@salesforce/apex/ForEachLoopDemo.getFootBalls';
export default class ForEachLoops extends LightningElement {

        @wire(footballs)// via this we are calling the method defined above in import statement 
        
        footballsWeGet;//and automatically the list of footballs returned by getFootBalls method under name of footballs is stored in this variable 


}