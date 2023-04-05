import { LightningElement } from 'lwc';
import { ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class Products extends LightningElement {

        Product_name = 'Toy Car';
        Product_color = 'red';
        Product_price = '$10';
        Product_category = 'Toys';
        Product_pictureURL = 'data:image/jpeg;base64,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';

        connectedCallback(){
               let result = this.myFuntion1(4,2);
                window.alert("4/2 is "+result);
                window.alert("4*2 is "+this.myFunction2(4,2));
        }
       Click(){

        window.alert('helll');
        this.showToast(this.Product_name);
      }
      showToast( name){
         const event = new ShowToastEvent({

                title: name,
                message: 'want to display toast example',
                variant: 'success'
        })
        this.dispatchEvent(event);
      }
      myFuntion1(dividend,divisor){

        return (dividend/divisor);
      }
      //arrow function

      myFunction2 = (no1,no2) =>{

                return (no1*no2);

      }
}