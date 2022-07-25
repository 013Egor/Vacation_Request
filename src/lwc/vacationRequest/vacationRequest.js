import {LightningElement, wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from  'lightning/uiRecordApi';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

import hasManager from '@salesforce/apex/ManagerController.hasManager';
import getRequests from '@salesforce/apex/RequestsController.getRequests';
import getMyRequests from '@salesforce/apex/RequestsController.getMyRequests';

export default class VacationRequest extends LightningElement {
    modelWindow = false;

    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];
    status = true;

    @wire(hasManager) contact;

    @track requests;

    connectedCallback() {
        getRequests().then(result => {
            this.requests = result;
            console.log(this.requests);
        });
    }

    updateList() {
        if (this.status == true) {
            getMyRequests().then(result => {
                this.requests = result;
                console.log(result);
            });
        } else {
            getRequests().then(result => {
                this.requests = result;
                console.log(result);
            });
        }
    }

    handleChange(event) {
        this.status = this.status ? false : true;
        this.updateList();
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
        this.updateList();

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

        this.updateList();

        this.dispatchEvent(evt);
    }
}