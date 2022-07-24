public with sharing class RequestsController {

	@AuraEnabled(cacheable=true)
	public static List<Vacation_Request__c> getRequests() {

		return [SELECT Id, Name, OwnerId, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c];
	}

	@AuraEnabled(cacheable=true)
	public static String getUserName(String index) {
		Id id = Id.valueOf(index);

		return [SELECT Name from User where Id =: id][0].Name;
	}
}