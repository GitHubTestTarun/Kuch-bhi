@isTest
public class OppoProcessorBatchTest {

    @isTest
    private static void testBatchClass() {
        
        List<Opportunity> Opportunities = new List<Opportunity>();
        
        for(Integer i=0; i<10; i++) {
            	
            Opportunities.add(new Opportunity(Name = 'Test-'+i, StageName = 'Prospecting', CloseDate = System.today() ));
        }
        insert Opportunities;
        Test.startTest();
        OppoProcessorBatch obj  = new OppoProcessorBatch();
        Id batchId = Database.executeBatch(obj,10);    
        Test.stopTest();
        
        List<Opportunity> UpdatedOpportunities = [SELECT Id FROM Opportunity WHERE LeadSource = 'Web'];//always write WHERE condition here which will check the condition or field schanged in apex batch class 
        System.assertEquals(10, UpdatedOpportunities.size());
        	
    }
}