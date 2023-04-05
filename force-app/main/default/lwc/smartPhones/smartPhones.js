import { LightningElement } from 'lwc';
export default class SmartPhones extends LightningElement {
  Product_name = 'Iphone 13';
  Product_description = 'Best Smartphone in terms of performance as well as cameras';
  Product_category = 'Smartphone';
  Product_price = '$1,700';
  Product_pictureUrl = 'data:image/jpeg;base64,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';

}