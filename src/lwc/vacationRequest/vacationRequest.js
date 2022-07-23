import {LightningElement} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

export default class VacationRequest extends LightningElement {
    modelWindow = false;
    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];

    _title = 'Sample Title';
    message = 'Sample Message';
    variant = 'error';
    variants = 'success';

    openRequestWindow() {

        this.modelWindow = true;
    }

    closeRequestWindow() {
        this.modelWindow = false;
    }

    completeRecord(event) {

        //let isGood = setManager(event);
        let isGood = true;
        if (isGood == true) {
            const evt = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variants,
            });
            this.dispatchEvent(evt);
        } else {
            const evt = new ShowToastEvent({
                title: this._title,
                message: this.message,
                variant: this.variant,
            });
            this.dispatchEvent(evt);
        }
        this.modelWindow = false;
    }
}