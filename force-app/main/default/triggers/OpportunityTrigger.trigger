trigger OpportunityTrigger on Opportunity (after update) {

    if(Trigger.isAfter) {

        if(Trigger.isInsert) {
            OpportunityTriggerHandler.afterUpdate(Trigger.newmap, Trigger.oldMap); 
        }
        if(Trigger.isUpdate) {
                      
           OpportunityTriggerHandler.afterUpdate(Trigger.newmap, Trigger.oldMap); 
        }
        if(Trigger.isDelete) {

        }
       
    }
    else {

        if(Trigger.isInsert) {

        }
        if(Trigger.isUpdate) {
            
        }
        if(Trigger.isDelete) {
            
        }
    }
}