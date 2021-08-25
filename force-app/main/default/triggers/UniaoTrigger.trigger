trigger UniaoTrigger on Criatura__c (after insert, after update) 
{
    //Verificar se o bunker da criatura foi adicionado

    List<Criatura__c> CriaturasBunker = new List<Criatura__c>();
    List<Criatura__c> NovasCriaturas = trigger.new;
    Map<id, Criatura__c> MapaCriaturasAntigas = trigger.oldMap;

    for(Criatura__c cr: NovasCriaturas)
    {
        if((cr.bunker__c != null) && (cr.bunker__c != trigger.oldMap.get(cr.id).bunker__c))
        {
            CriaturasBunker.add(cr);
        }
    }

    //Montar uma lista com os recursos das criaturas

    List<Criatura__c> dadosCri = new List<Criatura__c>();
    List<recursoBunker__c> recursosInsert = new List<recursoBunker__c>();
    List<recursoCriatura__c> recursosCriaturaDelete = new List<recursoCriatura__c>();
    dadosCri = [SELECT id, bunker__c, (SELECT id, Quantidade__c, Recurso__c FROM RecursosCriatura__r) FROM criatura__c WHERE id IN :CriaturasBunker];
    //Fazer for
    for(Criatura__c cr : dadosCri)
    {
        for(RecursoCriatura__c rc : cr.RecursosCriatura__r)
        {
            RecursosInsert.add(new recursoBunker__c(Recurso__c = rc.Recurso__c, Quantidade__c = rc.Quantidade__c, bunker__c = cr.bunker__c));
            RecursosCriaturaDelete.add(rc);
        }
    }

    insert recursosInsert;
    delete recursosCriaturaDelete;
}