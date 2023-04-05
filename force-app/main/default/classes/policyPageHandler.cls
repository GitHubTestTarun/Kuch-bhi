public with sharing class policyPageHandler {
    public string showPdf{get; set;}
    public policyPageHandler() {
        ContentVersion dd = [select id, Title, ContentUrl,VersionData  from ContentVersion where id ='0685h00000JKwsaAAD'];
        String bodyEncoded = EncodingUtil.base64Encode(dd.VersionData);
        System.debug('bodyEncoded >> '+bodyEncoded);
        // System.debug('BodyDecoded >> '+ EncodingUtil.base64Decode(bodyEncoded).toString());
        showPdf = bodyEncoded;
    }
    
    @AuraEnabled
    public static string getBase64() {
        try {
            String pdf;
            ContentVersion cv = [select id, Title, ContentUrl, VersionData  from ContentVersion where id ='0685h00000JKwsaAAD'];
            System.debug('cv >> '+cv);

            ContentDistribution conDis = new ContentDistribution();
            conDis.Name = cv.Title;
            conDis.ContentVersionId = cv.Id;
            // conDis.PreferencesAllowPDFDownload = false;
            // conDis.PreferencesAllowOriginalDownload = false;

            insert conDis;
            System.debug('conDis >> '+conDis);
            System.debug(conDis.Name);
            ContentDistribution v= [SELECT PdfDownloadUrl, ContentDownloadUrl , ID,DistributionPublicUrl, ContentDocumentId,CreatedBy.Name,  ContentVersionId from ContentDistribution Where ContentVersionId =: cv.Id LIMIT 1];
            System.debug(v);
            System.debug('url is '+v.DistributionPublicUrl);
            System.debug('url is '+v.PdfDownloadUrl);
            
            String bodyEncoded = EncodingUtil.base64Encode(cv.VersionData);
            pdf = bodyEncoded;
            // return v.ContentDownloadUrl;
            //  return 'https://playful-fox-rnbplj-dev-ed.lightning.force.com/sfc/servlet.shepherd/document/download/'+ '0695h00000JKkLKAA1'+ '#toolbar=0&navpanes=0&zoom=90';
            return v.DistributionPublicUrl; //+ '#toolbar=0&navpanes=0&zoom=90';
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}