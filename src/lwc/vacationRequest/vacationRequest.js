import {LightningElement} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

import hasManager from '@salesforce/apex/ManagerController.hasManager';

export default class VacationRequest extends LightningElement {
    modelWindow = false;
    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];

    _title = 'Sample Title';
    message = 'Sample Message';
    variant = 'error';
    variants = 'success';

    openRequestWindow() {
        if (hasManager()) {
            this.modelWindow = true;
        } else {
            const evt = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variant,
            });
            this.dispatchEvent(evt);
        }
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