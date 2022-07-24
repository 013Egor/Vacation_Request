public with sharing class RequestsController {

	@AuraEnabled(cacheable=true)
	public static List<Vacation_Request__c> getRequests() {
		return [SELECT Id, Name from Vacation_Request__c];
	}

}