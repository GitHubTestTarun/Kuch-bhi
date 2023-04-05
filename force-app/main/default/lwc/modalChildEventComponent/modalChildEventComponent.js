import { LightningElement , api} from 'lwc';

export default class ModalChildEventComponent extends LightningElement {
    @api HeaderText
    @api bodyText

    CLoseHandler() {
        this.dispatchEvent(new CustomEvent('CloseEvent'))
    }
}