import {LightningElement, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getSObjectValue } from '@salesforce/apex';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

import NAME_FIELD from '@salesforce/schema/User.ManagerId';

import hasManager from '@salesforce/apex/ManagerController.hasManager';

export default class VacationRequest extends LightningElement {
    modelWindow = false;
    text = '';
    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];

    _title = 'Sample Title';
    message = 'Sample Message';
    variant = 'error';
    variants = 'success';

    @wire(hasManager) contact;

    openRequestWindow() {
        this.modelWindow = true;
    }

    get text() {
        return this.contact.data ? getSObjectValue(this.contact.data, NAME_FIELD) : '';
    }

    closeRequestWindow() {
        this.modelWindow = false;
    }

    completeRecord(event) {

        let isGood = setManager(event);
        if (isGood == true) {
            const evt = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variants,
            });
            this.dispatchEvent(evt);
        }
        this.modelWindow = false;
    }
}