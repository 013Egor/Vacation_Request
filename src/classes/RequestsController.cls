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
		public String userId {get; set;}
	}

	@AuraEnabled(cacheable=true)
	public static List<RequestWrapper> getRequests() {
		List<Vacation_Request__c> l = [SELECT Id, Name, CreatedById, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c];
		List<RequestWrapper> requestList = new List<RequestsController.RequestWrapper>();

		for (Vacation_Request__c v : l) {
			RequestWrapper temp = new RequestWrapper();
			temp.name = [SELECT Id, Name from User WHERE Id =: v.CreatedById].Name;
			temp.managerName = [SELECT Id, Name from User WHERE Id =: v.Manager__c].Name;
			temp.id = v.Id;
			temp.startDate = v.StartDate__c;
			temp.endDate = v.EndDate__c;
			temp.workingDays = v.WorkingDays__c;
			temp.userId = v.Id;

			requestList.add(temp);
		}

		return requestList;
	}

	@AuraEnabled(cacheable=true)
	public static List<RequestWrapper> getMyRequests() {
		List<Vacation_Request__c> l = [SELECT Id, Name, CreatedById, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c WHERE CreatedById =: UserInfo.getUserId()];
		List<RequestWrapper> requestList = new List<RequestsController.RequestWrapper>();

		for (Vacation_Request__c v : l) {
			RequestWrapper temp = new RequestWrapper();
			temp.name = UserInfo.getName();
			temp.managerName = [SELECT Id, Name from User WHERE Id =: v.Manager__c].Name;
			temp.id = v.Id;
			temp.startDate = v.StartDate__c;
			temp.endDate = v.EndDate__c;
			temp.workingDays = v.WorkingDays__c;
			temp.userId = v.Id;

			requestList.add(temp);
		}

		return requestList;
	}
}