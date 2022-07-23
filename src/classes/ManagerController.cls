public with sharing class ManagerController {

	@AuraEnabled(cacheable=false)
	public static User hasManager() {
		User me = [SELECT Name, ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		User manager = [SELECT Name FROM User WHERE Id =: me.ManagerId][0];
		return manager;
	}
}