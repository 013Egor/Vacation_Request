@IsTest
public class DateControllerTest {
	@IsTest
	static void validateGetWorkingDays() {
		Date startDate = Date.newInstance(2022, 7, 18);
		Date endDate = Date.newInstance(2022, 7, 21);
 		System.assertEquals(3, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 18);
		endDate = Date.newInstance(2022, 7, 24);
		System.assertEquals(5, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 18);
		endDate = Date.newInstance(2022, 7, 25);
		System.assertEquals(5, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 20);
		endDate = Date.newInstance(2022, 7, 26);
		System.assertEquals(4, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 20);
		endDate = Date.newInstance(2022, 7, 27);
		System.assertEquals(5, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 20);
		endDate = Date.newInstance(2022, 7, 28);
		System.assertEquals(6, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 18);
		endDate = Date.newInstance(2022, 7, 31);
		System.assertEquals(10, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 18);
		endDate = Date.newInstance(2022, 8, 1);
		System.assertEquals(10, DateController.getWorkingDays(startDate, endDate));

		startDate = Date.newInstance(2022, 7, 20);
		endDate = Date.newInstance(2022, 8, 5);
		System.assertEquals(12, DateController.getWorkingDays(startDate, endDate));
	}
}