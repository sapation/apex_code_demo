import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { api, LightningElement, track, wire } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import GENDER_IDENTITY_FIELD from '@salesforce/schema/Contact.GenderIdentity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
import saveMultipleContacts from '@salesforce/apex/addMultipleContactsController.saveMultipleContacts';

 
export default class AddMultipleContacts extends LightningElement {

    // gender = [
    //     { label: 'Male', value: 'male'},
    //     { label: 'Female', value: 'female'}
    // ]

    @api recordId; // retrieve the current record id and use in the componnent
    //@track is use to make non primitive data type reactive;
    @track contacts = [];
    isLoading = false;

    @wire(getObjectInfo, { objectApiName:  CONTACT_OBJECT })
    contactObjectInfo;

    @wire(getPicklistValues, {recordTypeId: '$contactObjectInfo.data.defaultRecordTypeId', fieldApiName: GENDER_IDENTITY_FIELD})
    genderPickListValues;

    get getGenderPicklistValues() {
        return this.genderPickListValues?.data?.values;
    }

    //Onload function hook
    connectedCallback() {
        this.addNewClickHandler();
    }

    addNewClickHandler(event) {
        this.contacts.push({
            tempId: Date.now()
        })
    }

    deleteClickHandler(event) {
        if (this.contacts.length == 1) {
            this.showToastEvent('You can not delete last contact.');
            return;
        }
        let tempId = event.target?.dataset.tempId;
        this.contacts = this.contacts.filter(contact => contact.tempId != tempId);
    }

    elementChaneHandler(event) {
       let contactRow = this.contacts.find(contact => contact.tempId == event.target?.dataset.tempId);
       if(contactRow) {
            contactRow[event.target.name] = event.target?.value;
       }
    }

    async submitClickHandler(event) {
        const allValid = this.checkControlsValidity();
        if (allValid) {
            this.isLoading = true;
            this.contacts.forEach(a => a.AccountId = this.recordId);
            let response = await saveMultipleContacts({contacts: this.contacts});
            if (response.isSuccess) {
                this.showToastEvent('Contacts saved successfully.', 'Success', 'success');
                this.dispatchEvent(new CloseActionScreenEvent());
            } else {
                this.showToastEvent('Something went wrong' + response.message);
            }
            this.isLoading = false;
        } else {
            this.showToastEvent('Please fill all the required fields.');
        }
    }

    // Checking for input validation
    checkControlsValidity() {
        let isValid = true,
            controls = this.template.querySelectorAll('lightning-input,lightning-combobox');

        controls.forEach(field => {
            if(!field.checkValidity()) {
                field.reportValidity();
                isValid = false;
            }
        });

        return isValid;
    }

    showToastEvent(message, title = 'Error', variant = 'error') {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}