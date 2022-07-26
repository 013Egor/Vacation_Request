@IsTest
public class RequestControllerTest {

	@IsTest
	static void validateGetRequests() {

		User user = [SELECT Id, Name, ManagerId FROM User WHERE ManagerId != null][0];
		User manager = [SELECT Id, Name, ManagerId From User WHERE Id =: user.Id];

		System.runAs(manager) {
			Vacation_Request__c request = new Vacation_Request__c();
			request.Status__c = 'New';
			request.EndDate__c = Date.newInstance(2022, 8, 23);
			request.StartDate__c  = Date.newInstance(2022, 8, 2);
			request.RequestType__c = 'Sick';

			insert request;
		}

		System.runAs(user) {

			for (Integer i = 0 ; i < 3; i++) {
				Vacation_Request__c request = new Vacation_Request__c(
						Status__c = 'New', EndDate__c = Date.today().addDays(10),
						StartDate__c  = Date.today(),
						RequestType__c = 'Sick'
				);

				insert request;
			}

			List<RequestsController.RequestWrapper> allRequests = RequestsController.getRequests(false);
			List<RequestsController.RequestWrapper> myRequests = RequestsController.getRequests(true);

			System.assertEquals(true, allRequests.size() >= myRequests.size());

			if (myRequests.size() >= 1) {
				Boolean allWithSameUser = true;
				Id prevRequest = myRequests.get(0).userId;
				for (RequestsController.RequestWrapper myRequest : myRequests) {
					if (prevRequest != myRequest.userId) {
						allWithSameUser = false;
						break;
					}
				}

				System.assertEquals(true, allWithSameUser);
			}
		}
	}
}