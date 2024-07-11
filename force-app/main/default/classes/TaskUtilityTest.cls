@isTest
public class TaskUtilityTest {
    
    @isTest static void testTaskPriority()
    {
        String priority = TaskUtility.getTaskPriority('AU');
        System.assertEquals('Normal', priority);
    }

    @isTest static void testTaskPriorityInvalid()
    {
        String priority = TaskUtility.getTaskPriority('Ghana');
        System.assertEquals(null, priority);
    }

    @isTest static void testTaskPriorityNull()
    {
        String priority = TaskUtility.getTaskPriority('');
        System.assertEquals(null, priority);
    }

    @isTest static void testTaskHighPriority()
    {
        String priority = TaskUtility.getTaskPriority('US');
        System.assertEquals('High', priority);
    }
}