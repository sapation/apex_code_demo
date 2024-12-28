import { LightningElement } from 'lwc';

export default class LifecycleChild extends LightningElement {
    error;
    stack;

    constructor() {
        super() // Calling the parent constructor of LightningElement
        console.log("In Child Constructor");
    }

    connectedCallback() {
        console.log("In Child connectedCallback Method");
    }

    renderedCallback() {
        console.log("In Child renderedCallback Method");
    }

    disconnectedCallback() {
        
        console.log("In Child disconnectedCallback Method");
    }

    errorCallback(error) {
        console.log("In Child errorCallback Method");
        this.error = error;
        this.stack = error.stack;
    }
}