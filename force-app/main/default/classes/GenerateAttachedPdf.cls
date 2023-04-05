public class GenerateAttachedPdf {

    public static void makePdfAttachment(Id recordId) {
       	
        Attachment pdfGeneratedByVfPage = new Attachment();
        PageReference vfPageReference = Page.HelloWorld;
      	System.debug('vfPageReference '+vfPageReference);
        System.debug('url  '+vfPageReference.getUrl());
        pdfGeneratedByVfPage.ParentId = recordId;//Id of the object to which the page is attached
        pdfGeneratedByVfPage.name = 'record.pdf';
      	pdfGeneratedByVfPage.Body = vfPageReference.getContentAsPdf();
        System.debug('pdfGeneratedByVfPage  '+pdfGeneratedByVfPage);
		insert pdfGeneratedByVfPage;
       
    }
}