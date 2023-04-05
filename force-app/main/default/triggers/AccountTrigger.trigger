trigger AccountTrigger on Account (after update, after delete, before update, before delete) {
	
    Boolean flag = false;

    if(Trigger.isBefore) {

        if(Trigger.isUpdate) {

            //AccountTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
           
        }
        if(Trigger.isDelete) {


        }
    }
    else {

        if(Trigger.isInsert) {

        }
        if(Trigger.isUpdate) {
            AccountTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
           
        }
        if(Trigger.isDelete) {

        }
    }
   
}