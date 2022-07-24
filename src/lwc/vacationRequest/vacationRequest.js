import {LightningElement, wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

import hasManager from '@salesforce/apex/ManagerController.hasManager';
import getRequests from '@salesforce/apex/RequestsController.getRequests';

export default class VacationRequest extends LightningElement {
    modelWindow = false;

    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];

    @wire(hasManager) contact;

    @track requests;
    @track error;

    handleLoad() {
        getRequests().then(result => {
            this.requests = result;
        }).catch(error => {
            this.error = error;
        });
    }

    openRequestWindow() {
        if (this.contact.data) {
            this.modelWindow = true;
        } else {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Добавьте менеджера',
                variant: 'error'
            });
            this.dispatchEvent(evt);
        }
    }

    closeRequestWindow() {
        this.modelWindow = false;
    }

    showErrorMessage(event) {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: event.detail.message,
            variant: 'error'
        });
        this.dispatchEvent(evt);
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Request is sent',
            variant: 'Success'
        });
        this.dispatchEvent(evt);
    }
}