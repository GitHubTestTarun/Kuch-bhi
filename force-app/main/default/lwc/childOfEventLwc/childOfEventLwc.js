import { LightningElement, api, track } from 'lwc';

export default class ChildOfEventLwc extends LightningElement {

    @api headerText = 'I CHANLLENGE YOU THAT YOU CANNOT WIN THE GAME IF YOU SUCCESSFULLY "CLICKED ON Click To Save" Button THen YOU WIll WIN THE GAME IF NOT THEN YOU WILL LOOSE THE GAME START BY CLICKING HERE ↓';
    @api bodyText
     CloseValue = 'Click To Save';

    MouseOverHandler(event) {
       this.CloseValue  ="DON'T SAVE"
        //window.alert(this.CloseValue);
       // this.dispatchEvent(new CustomEvent('close'));
    }
    MouseOutHandler(event) {
        this.CloseValue  = 'Click To Save';
    }
    ClickHandler(event) {
        let i = false;
        if(event.target.value == 'Click To Save') {
            window.alert("you clicked on Save Button");
            i = true;

        }
        else{

            window.alert("You Clicked on DON'T Save Button");
            
        }
        if(i == true) {
            window.alert("You WIN The GAME ");
        }
        else {
            window.alert("YOU LOST The GAME");
        }
    }
}