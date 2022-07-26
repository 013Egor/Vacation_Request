@IsTest
public class RequestControllerTest {

	@IsTest
	static void validateGetRequests() {

		User user = [SELECT Id, Name FROM User LIMIT 1][0];

		User manager;
		for (User temp : [SELECT Id, Name FROM User]) {
			if (temp.Id != user.Id) {
				manager = temp;
				break;
			}
		}

		Vacation_Request__c r = new Vacation_Request__c();
		r.Status__c = 'New';
		r.EndDate__c = Date.newInstance(2022, 8, 23);
		r.StartDate__c  = Date.newInstance(2022, 8, 2);
		r.RequestType__c = 'Sick';
		r.Manager__c = manager.Id;
		r.Manager__r = manager;

		insert r;

		System.runAs(user) {

			for (Integer i = 0 ; i < 3; i++) {
				Vacation_Request__c request = new Vacation_Request__c(
						Status__c = 'New', EndDate__c = Date.newInstance(2022, 8, 23),
						StartDate__c  = Date.newInstance(2022, 8, 2),
						RequestType__c = 'Sick',
						Manager__c = manager.Id,
						Manager__r = manager
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

				System.assertEquals(false, allWithSameUser);
			}
		}
	}
}