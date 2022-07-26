import {LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from  'lightning/uiRecordApi';
import { updateRecord } from  'lightning/uiRecordApi';
import { refreshApex} from '@salesforce/apex';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';
import VACATION_ID from '@salesforce/schema/Vacation_Request__c.Id';
import STATUS_FIELD from '@salesforce/schema/Vacation_Request__c.Status__c';

import hasManager from '@salesforce/apex/ManagerController.hasManager';
import getRequests from '@salesforce/apex/RequestsController.getRequests';

export default class VacationRequest extends LightningElement {
    modelWindow = false;

    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];
    status = false;

    @wire(hasManager) contact;
    @wire(getRequests, {status: '$status'}) requests;

    handleChange(event) {
        this.status = this.status ? false : true;
        refreshApex(this.requests);
    }

    showSuccessToast(title, message) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: 'success'
        })
        this.dispatchEvent(evt);
    }

    showErrorToast(title, message) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: 'error'
        })
        this.dispatchEvent(evt);
    }

    removeRequest(event) {

        deleteRecord(event.target.value).then(() => {

            this.showSuccessToast('Success', event.target.value);
            return refreshApex(this.requests);
        }).catch(error => {

            this.showErrorToast('Error', event.target.value);
        });
    }

    openRequestWindow() {

        if (this.contact.data) {
            this.modelWindow = true;
        } else {
            this.showErrorToast('Error', 'Add manager');
        }
    }

    approveRequest(event) {
        const fields = {};
        fields[VACATION_ID.fieldApiName] = event.target.value;
        fields[STATUS_FIELD.fieldApiName] = 'Approved';
        const recordInput = { fields };
        updateRecord(recordInput).then(() => {

            this.showSuccessToast('Success', 'Request is approved');
            return refreshApex(this.requests);
        }).catch(error => {

            console.log(error);
        });
    }

    submitRequest(event) {
        const fields = {};
        fields[VACATION_ID.fieldApiName] = event.target.value;
        fields[STATUS_FIELD.fieldApiName] = 'Submitted';
        const recordInput = { fields };
        updateRecord(recordInput).then(() => {

            this.showSuccessToast('Success', 'Request is submitted');
            return refreshApex(this.requests);
        }).catch(error => {

            console.log(error);
        });
    }

    closeRequestWindow() {

        refreshApex(this.requests);
        this.modelWindow = false;
    }

    showErrorMessage(event) {

        this.showErrorToast('Error', event.detail.message);
    }

    handleSuccess() {

        this.showSuccessToast('Success', 'Request is sent')
        refreshApex(this.requests);
    }
}