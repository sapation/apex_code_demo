# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.


# Tips and snipets for My Learning

## How to delete custom Lightning Web Component
1. Go to Developer Console -> Query Editor.

2. Write query 
    SELECT ID, DeveloperName FROM LightningComponentBundle

3. Select checkbox Use Tooling API.

4. Click on Execute button.

## Data Binding in LWC
Data Binding is the process by which values are bounded to the properties.

    <lightning-card>
        <div>Hello {employee.Fname} {employee.Lname}</div>
        <div>Age: {employee.Age}</div>
        <div>City: {employee.City}</div>
        <h1>Hello World</h1>
    </lightning-card>


    import { LightningElement } from 'lwc';

    export default class HelloWorld extends LightningElement {
        employee={
            Fname:'Parag',
            Lname:'Jambhulkar',
            Age:35,
            City:'Pune'
            }
    }


## Conditional Rendering in HTML in  LWC | How to apply if-else in LWC
Template Directives:
1.	if:true
2.	if:false
	
Program Code: (conditionalRendering.html)

    <lightning-card title="Conditional Rendering">
        <lightning-input type="checkbox" label="Show Details" onchange={handleChange}>
        </lightning-input>
        <template if:true={flag}>
            This is True Block!
        </template>
        <template if:false={flag}>
            This is False Block!
        </template>
    </lightning-card>

    <script>
        flag=false;
        handleChange(event)
        {
            this.flag=event.target.checked;
        }
    </script>

## Iterator loop in LWC
Like for each, it is used for Looping. Advantage of iterator loop is that if provides some special properties.

Template Directive used:
1.	iterator:iteratorName

It has some special properties:
1. iteratorName.value
	Returns value of the property. We need to call by iteratorName.value.propertyName
2. iteratorName.first
	Returns true if it is first record.
3. iteratorName.last
	Returns true if it is last record.


## Decorators in LWC - Introduction
The Lightning Web Components programming model has three decorators that add functionality to a property or function.
 
@api
@track
@wire

Syntax: 
@decorator Property/function;
e.g.
    @api msg=”Hello Parag”

@api
It is used to expose a variable or functions publicly and make properties reactive.
Kebab Case: Respective phrase will be transferred to all lowercase with hyphen(-) separating words.
e.g. headerLabel will be header-label

@track
It is used to make variable private but reactive. Tracked properties are also called private reactive properties.
Note: we can't access @track properties from outside as they are private and only accessible within its component only.
To use it @track we have to import it first from lwc Eg. 
    @track property_name=value

@wire
To read Salesforce data, Lightning web components use a reactive wire service. When the wire service provisions data, the component rerenders. Components use @wire in their JavaScript class to specify a wire adaptor or an Apex method. 

Syntax
    import { adapterId } from 'adapterModule';
    @wire (adapterId, adapterConfig) propertyOrFunction;

-adapterId (Identifier)—The identifier of the wire adapter.

-adapterModule (String)—The identifier of the module that contains the wire adapter function, in the format namespace/moduleName. Look at the format! To import a module in JavaScript, use lightning/ui*Api instead of lightning-ui-*-api.

-adapterConfig (Object)—A configuration object specific to the wire adapter. Configuration object property values can be either strings or references to objects and fields imported from @salesforce/schema. Properties in the {adapterConfig} object can’t be undefined. If a property is undefined, the wire service doesn’t provision data. Don’t update a wire adapter configuration object property in renderedCallback() as it can result in an infinite loop.

-propertyOrFunction—A private property or function that receives the stream of data from the wire service. If a property is decorated with @wire, the results are returned to the property’s data property or error property. If a function is decorated with @wire, the results are returned in an object with a data property and an error property.

## Use of querySelector()
The querySelector() method returns the first element that matches a CSS selector.

CSS Selectors:
1. By Tag
e.g. querySelector(‘tagname’)
2. By class name
e.g. querySelector(‘.classname’)
3. By Tag and class name
e.g. querySelector(‘tagname.classname’)

## Use of querySelectorAll()
1.	The querySelectorAll() method returns all elements that matches a CSS selector(s).
2.	The querySelectorAll() method returns a NodeList.
3.	The querySelectorAll() method throws a SYNTAX_ERR exception if the selector(s) is invalid.

Note: this also uses all the Css Selectors.


## Data Communication between LWC Components
There are three types of communication between LWC Components:

1.	Parent to Child Communication
2.	Child to Parent Communication
3.	Communication between unrelated components

1. Parent to Child Communication
	It is done by public properties using @api decorator.

2. Child to Parent Communication
	It is done by Custom Event.

3. Communication between unrelated components
It is done by Lightning Message Service (LMS).


## Two Components:
1. Publisher
	Component which sends data.
It calls following method:
    publish(this.messageContext, MessageChannel, payload)

2. Subscriber
	Component which receives data.
It calls following method:

    Subscribe(this.messageContext, MessageChannel, (parameter)=>{ Statements })

3. Message Channel
    i. Create folder messageChannels in dafault folder (force-app\main\default).
    ii. Create Message Channel messageChannelName.messageChannel-meta.xml in folder messageChannels.


## Salesforce LWC Lifecycle Hooks
A lifecycle hook is a callback method triggered at a specific phase of a component instance’s lifecycle.

  -Lifecycle Hooks:
1. constructor()
2. connectedCallback()
3. renderedCallback()
4. render()
5. disconnectedCallback()
6. errorCallback(error, stack)

Lifecycle Hook	When they are called	Description
1	constructor() ->	Called when the component is created.	Flows from parent component to child component
2	connectedCallback()	Called when the element is inserted into a document.	Flows from parent component to child component
3	renderedCallback()	Called when a component is completely rendered on UI.

This hook is called after the component gets rendered every time. Hence, it should be called cautiously.	Flows from child component to parent component
4	render()	This hook is used to override the standard rendering functionality in Lightning web components & to update the UI.	This hook is not technically a lifecycle hook. 

It is protected method on the LightningElement class.

Flows from parent component to child component
5	disconnectedCallback()	Called when the element is removed from a document or DOM.	Flows from parent component to child component
6	errorCallback(error, stack)	Called when the component throws error in one of the lifecycle hooks.	error and stack are the two arguments. error is javascript native error object whereas stack is a string which gives error information
