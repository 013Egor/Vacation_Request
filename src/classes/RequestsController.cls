public with sharing class RequestsController {

	@AuraEnabled(cacheable=true)
	public static List<Vacation_Request__c> getRequests() {
		return [SELECT Id, Name, OwnerId, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c];
	}

}