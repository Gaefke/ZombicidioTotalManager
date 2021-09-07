public with sharing class FormularioNovasCriaturasController {

    Criatura__c criatura{get;set;}
    

    public FormularioNovasCriaturasController() {

        Id criaturaId = ApexPages.currentPage().getParameters().get('id');
        this.criatura = [SELECT ID FROM Criatura__c WHERE ID = criaturaId];
    }

    public static void save(){
        
    }
}
