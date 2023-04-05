trigger ContactTrigger on Contact (after insert, after update, after delete) {
    
    if(Trigger.isAfter) {

        if(Trigger.isInsert) {
            ContactTriggerHelper.afterInsert(Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isUpdate) {
            ContactTriggerHelper.afterUpdate(Trigger.newMap, Trigger.oldMap);
        }
        if(Trigger.isDelete) {
            ContactTriggerHelper.afterDelete(Trigger.newMap, Trigger.oldMap);
        }
    }
}