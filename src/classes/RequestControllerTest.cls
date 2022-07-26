@IsTest
public class RequestControllerTest {

	@IsTest
	static void validateGetRequests() {

		User manager;
		User user;
		User[] all = [SELECT Id, Name, ManagerId FROM User];

		for (User userTemp : all) {
			for (User managerTemp : all) {
				if (userTemp.ManagerId == managerTemp.Id) {
					user = userTemp;
					manager = managerTemp;
					break;
				}
			}
		}

		System.runAs(manager) {
			Vacation_Request__c r = new Vacation_Request__c();
			r.Status__c = 'New';
			r.EndDate__c = Date.newInstance(2022, 8, 23);
			r.StartDate__c  = Date.newInstance(2022, 8, 2);
			r.RequestType__c = 'Sick';

			insert r;
		}

		System.runAs(user) {

			for (Integer i = 0 ; i < 3; i++) {
				Vacation_Request__c request = new Vacation_Request__c(
						Status__c = 'New', EndDate__c = Date.newInstance(2022, 8, 23),
						StartDate__c  = Date.newInstance(2022, 8, 2),
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