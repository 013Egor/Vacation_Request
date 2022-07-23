public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static String hasManager() {
		User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		if (manager == null) {
			return 'Nope';
		} else {
			return manager.toString();
		}
	}
}