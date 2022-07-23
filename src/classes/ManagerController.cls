public with sharing class ManagerController {

	public static boolean setManager(Vacation_Request__c request) {
		User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		if (manager == null) {
			return false;
		}
		request.Manager__c = manager.ManagerId;
		request.WorkingDays__c = request.EndDate__c.day() - request.StartDate__c.day();
		return true;
	}
}