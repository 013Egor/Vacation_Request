public with sharing class Controller {
	@AuraEnabled(cacheable=true)
	public static List<Book__c> getBookList() {
		return [
				SELECT Id, Name, Price__c
				FROM Book__c
		];
	}
}