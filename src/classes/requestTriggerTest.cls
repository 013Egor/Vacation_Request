@IsTest
public class requestTriggerTest {

	@IsTest
	static void validateRequestTrigger() {
		User user = [SELECT Id, Name, ManagerId FROM User WHERE ManagerId != null limit 1][0];
		System.runAs(user) {
			Date startDate = Date.today();
			Date endDate = Date.today().addDays(10);
			Vacation_Request__c request = new Vacation_Request__c(
					Status__c = 'New', EndDate__c = endDate,
					StartDate__c  = startDate,
					RequestType__c = 'Sick'
			);

			insert request;

			request = [SELECT Id, Name, Manager__c, WorkingDays__c
									FROM Vacation_Request__c WHERE CreatedById =: user.Id];

			System.assertEquals('Request from ' + user.Name, request.Name);
			System.assertEquals(user.ManagerId, request.Manager__c);
			System.assertEquals(DateController.getWorkingDays(startDate, endDate), request.WorkingDays__c);
		}
	}
}