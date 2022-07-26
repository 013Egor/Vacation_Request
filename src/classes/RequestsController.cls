public with sharing class RequestsController {

	public with sharing class RequestWrapper {
		@AuraEnabled
		public Id id {get; set;}
		@AuraEnabled
		public String name {get; set;}
		@AuraEnabled
		public Date startDate {get; set;}
		@AuraEnabled
		public Date endDate {get; set;}
		@AuraEnabled
		public Decimal workingDays {get; set;}
		@AuraEnabled
		public String managerName {get; set;}
		@AuraEnabled
		public Id userId {get; set;}
		@AuraEnabled
		public Boolean isManager {get; set;}
		@AuraEnabled
		public Boolean isUser {get; set;}
		@AuraEnabled
		public Boolean isNew {get; set;}
		@AuraEnabled
		public Boolean isSubmitted {get; set;}
		@AuraEnabled
		public Boolean isApproved {get; set;}
	}

	@AuraEnabled(cacheable=true)
	public static List<RequestWrapper> getRequests(Boolean status) {
		List<Vacation_Request__c> requestList;
		if (status) {
			requestList = [SELECT Id, Name, CreatedById, StartDate__c, EndDate__c, WorkingDays__c, Manager__c, Status__c from Vacation_Request__c WHERE CreatedById =: UserInfo.getUserId()];
		} else {
			requestList = [SELECT Id, Name, CreatedById, StartDate__c, EndDate__c, WorkingDays__c, Manager__c, Status__c from Vacation_Request__c];
		}

		List<RequestWrapper> result = new List<RequestsController.RequestWrapper>();

		for (Vacation_Request__c v : requestList) {
			RequestWrapper temp = new RequestWrapper();
			User[] tempUser = [SELECT Id, Name from User WHERE Id =: v.CreatedById];
			if (tempUser.size() > 0) {
				temp.name = tempUser[0].Name;
				tempUser = null;
			}
			tempUser = [SELECT Id, Name from User WHERE Id =: v.Manager__c];
			if (tempUser.size() > 0) {
				temp.managerName = tempUser[0].Name;
			}
			temp.id = v.Id;
			temp.startDate = v.StartDate__c;
			temp.endDate = v.EndDate__c;
			temp.workingDays = v.WorkingDays__c;
			temp.userId = v.CreatedById;
			temp.isManager = v.Manager__c == UserInfo.getUserId();
			temp.isUser = v.CreatedById == UserInfo.getUserId();
			temp.isNew = v.Status__c == 'New';
			temp.isSubmitted = v.Status__c == 'Submitted';
			temp.isApproved = v.Status__c == 'Approved';

			result.add(temp);
		}

		return result;
	}

}