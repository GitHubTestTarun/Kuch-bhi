import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

        handleClick1(){
            this.template.querySelector("c-child-component").ChangeValue1();
        }

        handleClick2() {

            this.template.querySelector("c-child-component").ChangeValue2();
        }

}