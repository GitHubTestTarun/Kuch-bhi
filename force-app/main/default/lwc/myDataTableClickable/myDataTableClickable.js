import LightningDatatable from 'lightning/datatable';
import clickableEmailTemplate from './clickableEmailTemplate.html';

export default class MyDataTableClickable extends LightningDatatable {

    static customTypes = {
        clickableEmail: {
            template: clickableEmailTemplate,
            standardCellLayout: true,
            //Provides template data between here if needed
            typeAttributes: ['recordId'],
        }
        //more custom types can be added here 
    };

}