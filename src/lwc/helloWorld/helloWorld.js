// import { LightningElement, track } from 'lwc';
// import getBookList from '@salesforce/apex/Controller.getBookList';
//
// export default class HelloWorld extends LightningElement {
//     @track contacts;
//
//     createRequest() {
//         getBookList()
//             .then(result => {
//                 this.contacts = result;
//             })
//     }
// }

import { LightningElement, track, api } from 'lwc';
import helloWorld from './helloWorld.html';
import getBookList from '@salesforce/apex/Controller.getBookList';
import PRICE from '@salesforce/schema/Book__c.Price__c';
import NAME from '@salesforce/schema/Book__c.Name';


export default class HelloWorld extends LightningElement {
    templateOne = true;
    fields = [NAME, PRICE];

    createRequest() {

        this.templateOne = false;
    }

    save() {
        this.templateOne = true;
    }
}