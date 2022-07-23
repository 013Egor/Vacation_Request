public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static Id hasManager() {
		User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];

		return manager.ManagerId;
	}
}