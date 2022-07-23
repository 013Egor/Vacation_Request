public with sharing class ManagerController {

	@AuraEnabled(cacheable=true)
	public static Boolean hasManager() {
		User me = [SELECT Name, ManagerId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
		if (me.ManagerId == null) {
			return false;
		} else {
			return true;
		}

	}
}