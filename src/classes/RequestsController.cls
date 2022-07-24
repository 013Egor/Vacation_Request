public with sharing class RequestsController {

	public class RequestWrapper {
		public Id id {get; set;}
		public String name {get; set;}
		public Date startDate {get; set;}
		public Date endDate {get; set;}
		public Decimal workingDays {get; set;}
		public String managerName {get; set;}
	}

	@AuraEnabled(cacheable=true)
	public static List<RequestWrapper> getRequests() {
		List<Vacation_Request__c> l = [SELECT Id, Name, OwnerId, StartDate__c, EndDate__c, WorkingDays__c, Manager__c from Vacation_Request__c];
		List<RequestWrapper> requestList = new List<RequestsController.RequestWrapper>();

		for (Vacation_Request__c v : l) {
			String userName = [SELECT Name from User where Id =: v.CreatedById limit 1][0].Name;
			String managerName = [SELECT Name from User where Id =: v.Manager__c limit 1][0].Name;
			RequestWrapper temp = new RequestWrapper();
			temp.id = v.Id;
			temp.name = userName;
			temp.startDate = v.StartDate__c;
			temp.endDate = v.EndDate__c;
			temp.workingDays = v.WorkingDays__c;
			temp.managerName = managerName;
			System.debug(temp);
			requestList.add(temp);
		}

		return requestList;
	}

	@AuraEnabled(cacheable=true)
	public static String getUserName(String index) {
		Id id = Id.valueOf(index);

		return [SELECT Name from User where Id =: id][0].Name;
	}
}