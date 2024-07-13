import { LightningElement, api, track } from 'lwc';

export default class ApiChildComponent extends LightningElement {

    @api headerLabel ='Hello Sumaila'; //@api make the property public and reactive
    @api jobTitle = 'Computer Engineering'
    @track counter = 0; //@track makes private property reactive 

    increment(event) {
        this.counter++;
    }

    decrement(event) {
        this.counter--;
    }

    /**
     * This is section is demostrating how to commumniate to parent component
     * by using custom event and invoking the event object
     * The parent component is ApiParentComponent
     * 
     * The parent component will listen for the event
     * using the eventname
     * 
     * it will get the name and phone information from the account information
     * 
     */
    name = '';
    firstName = '';
    lastName = '';
    handleChange(event) {
        this.name = event.target.value;
    }

    handleChangeFirstName(event) {
        this.firstName = event.target.value;
    }

    handleChangeLastName(event) {
        this.lastName = event.target.value;
    }

    handleClick(event) {
        const searchEvent = new CustomEvent('getsearchevent', {
            detail: {
                firstName: this.firstName,
                lastName: this.lastName
            }
        });
        this.dispatchEvent(searchEvent);
    }

}