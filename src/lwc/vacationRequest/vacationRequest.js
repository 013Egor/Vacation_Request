import {LightningElement, wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from  'lightning/uiRecordApi';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

import hasManager from '@salesforce/apex/ManagerController.hasManager';
import getRequests from '@salesforce/apex/RequestsController.getRequests';
import { refreshApex} from '@salesforce/apex';

export default class VacationRequest extends LightningElement {
    modelWindow = false;

    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];
    status = true;

    @wire(hasManager) contact;
    @wire(getRequests, {status: '$status'}) requests;
    @track error;

    handleChange(event) {
        this.status = this.status ? false : true;
        refreshApex(this.requests);
    }

    removeRequest(event) {
        deleteRecord(event.target.value).then(() => {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: event.target.value,
                variant: 'success'
            })
            this.dispatchEvent(evt);
        }).catch(error => {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: event.target.value,
                variant: 'error'
            });
            this.dispatchEvent(evt);
        });
        refreshApex(this.requests);
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
        refreshApex(this.requests);

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

        refreshApex(this.requests);

        this.dispatchEvent(evt);
    }
}