trigger requestTrigger on Vacation_Request__c (before insert) {

	User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId()][0];
	for (Vacation_Request__c request : Trigger.new) {
		request.Manager__c = manager.ManagerId;
		request.WorkingDays__c = DateController.getWorkingDays(request.StartDate__c, request.EndDate__c);
	}
}