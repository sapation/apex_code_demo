import { MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import publisherAndSubscriberChannel from '@salesforce/messageChannel/publisherAndSubscriberChannel__c';

export default class SubscriberExample extends LightningElement {
    firstName = '';
    lastName = '';
    subscription = null;

    @wire (MessageContext) messageContext;

    connectedCallback() {
        this.handleSubscribe();
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    handleSubscribe() {
        if(!this.subscription) {
            this.subscription = subscribe(this.messageContext, publisherAndSubscriberChannel, 
                (parameter) => {
                this.firstName = parameter.firstName;
                this.lastName = parameter.lastName;
            });
        }
        // const messageContext = this.template.querySelector('c-message-context');
        // const channel = messageContext.getChannel('publisherAndSubscriberChannel');
    }

    handleUnsubscribe() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}