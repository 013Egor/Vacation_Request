public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static SObjectType hasManager() {
		User me = [SELECT Name, ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		return  me.ManagerId.getSobjectType();

	}
}