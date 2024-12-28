import { LightningElement } from 'lwc';

export default class LifecycleParent extends LightningElement {
    error;
    stack;

    constructor() {
        super() // Calling the parent constructor of LightningElement
        console.log("In Parrent Constructor");
    }

    connectedCallback() {
        console.log("In Parent connectedCallback Method");
    }

    renderedCallback() {
        console.log("In Parent renderedCallback Method");
    }

    disconnectedCallback() {
        console.log("In Parent disconnectedCallback Method");
    }

    errorCallback(error) {
        console.log("In Parent errorCallback Method");
        this.error = error;
        this.stack = error.stack;
    }
}