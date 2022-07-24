public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static boolean hasManager() {
		User me = [SELECT Name, ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		User[] manager = [SELECT Id, Name FROM User WHERE Id =: me.ManagerId];

		return manager.size() != 0;
	}

	public static String getUserId() {
		return UserInfo.getUserId();
	}
}