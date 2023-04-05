public class metadata1 {

    public metadata1(){
    	Metadata.DeployContainer container = new Metadata.DeployContainer();
    	Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    	
    	customMetadata.fullName = 'Price_Tag.';//here this line is must and Price_Tag requires some delimiter so i applies '.' here 
    	customMetadata.label = 'DefaultPriceTag2';
    	
    	Metadata.CustomMetadataValue customField1 = new Metadata.CustomMetadataValue();
    	customField1.field = 'Discount__c';
    	customField1.value = 100;
        
    	customMetadata.values.add(customField1);
        container.addMetadata(customMetadata);
        
        Metadata.CustomMetadataValue customField2 = new Metadata.CustomMetadataValue();
        customField2.field = 'Rate__c';
        customField2.value = 222;
       	
		customMetadata.values.add(customField2);
		container.addMetadata(customMetadata);
        
        //Till here we have created an custom metadata and its values now
        //we have to deploy this customMetadta we have created  using Metadata.Operations.enqueueDeployment(Metadata.container, Metadata.callback) function
        //here Metadata.callback is used to notify the status of the customMetadata deployment
        
        
        Id assyncResultId = Metadata.Operations.enqueueDeployment(container, null);
    }
    
}