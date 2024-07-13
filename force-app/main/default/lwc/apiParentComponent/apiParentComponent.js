import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { LightningElement, api, wire } from 'lwc';

export default class ApiParentComponent extends LightningElement {

    @api recordId;
    jobName = 'Software Engineer';

    @wire(getRecord, {
            recordId: '$recordId',
            fields: [
                'Account.Name',
                'Account.Phone'
            ]
        }) accounts;

    get getName() {
        if(this.accounts.data)
            return getFieldValue(this.accounts.data, 'Account.Name');
        else if(this.accounts.error)
            return this.accounts.error;
    }

    get getPhone() {
        if(this.accounts.data)
            return getFieldValue(this.accounts.data, 'Account.Phone');
        else if(this.accounts.error)
            return this.accounts.error;
    }

    /**
     * This is section is demostrating how to commumniate to parent component
     * The parent component is listening for the event
     * using the eventname
     *
     */
    firstName = '';
    lastName = '';
    handleEvent(event) {
        this.firstName = event.detail.firstName;
        this.lastName = event.detail.lastName;
    }
}