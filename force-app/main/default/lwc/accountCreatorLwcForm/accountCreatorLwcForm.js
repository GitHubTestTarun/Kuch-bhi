import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createNotesAndAttachments from '@salesforce/apex/AccountController.createNotesAndAttachments';
import { CloseActionScreenEvent } from "lightning/actions";

export default class AccountCreatorLwcForm extends LightningElement {
   
    uploadedFiles = [];
    objectName = 'Account';
    fileData;
    documentIds = [];

    get acceptedFormats() {
        return ['.pdf', '.png', '.jpeg', '.jfif', '.heic'];
    }

    handleUploadFinished(event) {

        try {
            console.log(event);
            // Get the list of uploaded files
           this.uploadedFiles = event.detail.files;
            console.log('uploadedFiles are ', this.uploadedFiles);
    
            for(let i = 0; i< this.uploadedFiles.length; i++) {
                console.log('documents id is ', this.uploadedFiles[i].documentId);
                this.documentIds.push(this.uploadedFiles[i].documentId);
            }
            console.log('this.documentIds are ', this.documentIds);
            console.log('this.documentIds length is ', this.documentIds.length);
    
            alert('No. of files uploaded : ' + this.uploadedFiles.length);
            const toastEvent = new ShowToastEvent({
                title: "Account created",
                message: "Record ID: ",
                variant: "success"
            });
            this.dispatchEvent(toastEvent);
            console.log('onsuccess event is ', event);
            console.log('event.target.value ',event.target.value);
    
            if( this.documentIds.length >0) {
                createNotesAndAttachments({objectName : this.objectName, files : this.documentIds})
                .then((result) => {
                    console.log('result is ', result);
                })
                .catch((error)=> {
                    console.log('error is ', error);
                })
            }
        }
        catch(error) {
            console.log('error occurred ', error);
        }
       
    }
   
    closeAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    objectNameHandler(event) {
        console.log('objectname is ', event.target.value);
        this.objectName = event.target.value;
    }
}