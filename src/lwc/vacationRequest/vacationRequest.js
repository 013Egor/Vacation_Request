import {LightningElement} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import  REQUEST_TYPE_FIELD from '@salesforce/schema/Vacation_Request__c.RequestType__c';
import START_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.StartDate__c';
import END_DATE_FIELD from '@salesforce/schema/Vacation_Request__c.EndDate__c';

export default class VacationRequest extends LightningElement {
    modelWindow = false;
    fields = [REQUEST_TYPE_FIELD, START_DATE_FIELD, END_DATE_FIELD];

    openRequestWindow() {

        this.modelWindow = true;
    }

    closeRequestWindow() {
        this.modelWindow = false;
    }

    completeRecord() {
        this.modelWindow = false;
        const evt = new ShowToastEvent({
            title: 'Успешно',
            message: 'dfdfsdfdsfdsfds',
            variant: 'success',
        });
        // this.dispatchEvent(evt);
        // let isGood = setManager(event);
        // if (isGood == true) {
        //     const evt = new ShowToastEvent({
        //         title: 'Успешно',
        //         message: 'success',
        //         variant: 'success',
        //     });
        //     this.dispatchEvent(evt);
        // } else {
        //     const evt = new ShowToastEvent({
        //         title: 'Ошибка',
        //         message: 'error',
        //         variant: 'error',
        //     });
        //     this.dispatchEvent(evt);
        // }
        // this.modelWindow = false;

    }
}