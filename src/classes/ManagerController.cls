public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static User hasManager() {
		User manager = [SELECT Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];

		return manager;
	}
}