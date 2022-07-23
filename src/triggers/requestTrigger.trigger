trigger requestTrigger on Vacation_Request__c (before insert) {

	User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
	for (Vacation_Request__c request : Trigger.new) {
		request.Manager__c = manager.ManagerId;
	}
}