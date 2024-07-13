import { LightningElement, wire, api } from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';

export default class WireExample extends LightningElement {
    @api recordId;
    @wire (getAccountList, {accId: '$recordId'}) accounts;

    name = 'Sumaila';

    handleClick(event) {
        this.name = this.template.querySelector('lightning-input').value;
    }
}

//WHERE Id=: accId
//accId: '$recordId'