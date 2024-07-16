import { MessageContext, publish } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import publisherAndSubscriberChannel from '@salesforce/messageChannel/publisherAndSubscriberChannel__c';

export default class PublisherExample extends LightningElement {
    firstName = '';
    laststName = '';

    @wire (MessageContext) messageContext;

    handleChangeFirstName(event) {
        this.firstName = event.target.value;
    }
    handleChangeLastName(event) {
        this.lastName = event.target.value;
    }

    handleClick(event) {
        let payload = {firstName: this.firstName, lastName: this.lastName};
        publish(this.messageContext, publisherAndSubscriberChannel, payload)
    }
}