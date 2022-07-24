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
	}

	@AuraEnabled(cacheable=true)
	public static List<RequestWrapper> getRequests() {
		List<Vacation_Request__c> l = [SELECT Id, Name, CreatedById, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c];
		List<RequestWrapper> requestList = new List<RequestsController.RequestWrapper>();
		User[] allUsers = [SELECT Id, Name from User];
		for (Vacation_Request__c v : l) {
			RequestWrapper temp = new RequestWrapper();
			String userName = [SELECT Id, Name from User WHERE Id =: v.CreatedById].Name;
			temp.name = userName;
			temp.id = v.Id;
			for (User person : allUsers) {
				if (v.Manager__c == person.Id) {
					temp.managerName = person.Name;
				}
//				if (v.CreatedById == person.Id) {
//					temp.name = person.Name;
//				}
			}
			temp.startDate = v.StartDate__c;
			temp.endDate = v.EndDate__c;
			temp.workingDays = v.WorkingDays__c;

			System.debug(temp);
			requestList.add(temp);
		}
		System.debug(requestList);
		return requestList;
	}

	@AuraEnabled(cacheable=true)
	public static String getUserName(String index) {
		Id id = Id.valueOf(index);

		return [SELECT Name from User where Id =: id][0].Name;
	}
}