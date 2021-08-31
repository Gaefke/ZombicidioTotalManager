public with sharing class EditarCriaturaRecursoPAGEExtension {

    private Criatura__c criatura;


    public EditarCriaturaRecursoPAGEExtension(ApexPages.StandardController controller) {
        this.criatura = (Criatura__c) controller.getRecord();
    }

    public PageReference cancelar(){
        PageReference pg = new PageReference( '/' + this.criatura.Id);
        pg.setRedirect(true);
        return pg;
    }

}