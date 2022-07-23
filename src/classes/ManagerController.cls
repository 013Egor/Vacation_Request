public with sharing class ManagerController {

	@AuraEnabled(cacheable=false)
	public static User hasManager() {
		User me = [SELECT Name, ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];

		return me;
	}
}