public with sharing class RequestsController {

	@AuraEnabled(cacheable=true)
	public static List<Vacation_Request__c> getRequests() {
		return [SELECT Id, RequestType__c, WorkingDays__c from Vacation_Request__c];
	}

}