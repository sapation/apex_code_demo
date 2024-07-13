import { LightningElement, api, track } from 'lwc';

export default class ApiChildComponent extends LightningElement {

    @api headerLabel ='Hello Sumaila'; //@api make the property public and reactive
    @track counter = 0; //@track makes private property reactive 

    increment(event) {
        this.counter++;
    }

    decrement(event) {
        this.counter--;
    }

}