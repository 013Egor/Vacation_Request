public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static boolean hasManager() {
		User manager = [SELECT ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		if (manager == null) {
			return false;
		} else {
			return true;
		}
	}
}