@IsTest
public class ManagerControllerTest {

	@IsTest
	static void validateHasManager() {

		User workerWithManager = [SELECT Id FROM User WHERE ManagerId != null LIMIT 1][0];
		User workerWithoutManager = [SELECT Id FROM User WHERE ManagerId =: null LIMIT 1][0];

		if (workerWithManager != null) {
			System.runAs(workerWithManager){
				System.assertEquals(true, ManagerController.hasManager());
			}
		}

		if (workerWithoutManager != null) {
			System.runAs(workerWithoutManager) {
				System.assertEquals(false, ManagerController.hasManager());
			}
		}
	}
}