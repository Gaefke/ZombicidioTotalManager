trigger CriaturaTrigger on Criatura__c (after insert, after update, after delete, before update) 
{
   //new CriaturaTriggerHandler().run();
   Map<id,Bunker__c> bunkersUpdateMap = new Map<id,Bunker__c>();

   for(Criatura__c cr: trigger.new)
   {
      if(trigger.isInsert && cr.bunker__c != null){
         bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.bunker__c));
      }
      Criatura__c nova = cr;
      if(!trigger.isInsert){
         // Criatura__c antiga = trigger.oldMap.get(nova.id);
         if((nova.Bunker__c != trigger.oldMap.get(nova.id).Bunker__c))
         {
             if (nova.Bunker__c != null){
               bunkersUpdateMap.put(nova.Bunker__c, new Bunker__c(id = nova.bunker__c));
               System.debug('bugou');
             }

             if (trigger.oldMap.get(nova.id).Bunker__c != null)
                 bunkersUpdateMap.put(trigger.oldMap.get(nova.id).Bunker__c, new Bunker__c(id = trigger.oldMap.get(nova.id).bunker__c));
  
             bunkersUpdateMap.put(cr.Bunker__c,new Bunker__c(id = cr.bunker__c));    
         }
      }

   }
   if(!trigger.isInsert){
      for(Criatura__c cr: trigger.old)
      {
          if(trigger.isDelete && cr.Bunker__c != null)
              bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.bunker__c));
      }
   }

   if(trigger.isDelete){
       update bunkersUpdateMap.values();  
   }
   system.debug(bunkersUpdateMap);

   List<Bunker__c> bkList = [SELECT id, (SELECT id FROM Criaturas__r) FROM bunker__c WHERE id in :  bunkersUpdateMap.keySet()];
   for(Bunker__c bk : bkList)
   {
       bunkersUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
   }

   update bunkersUpdateMap.values();   
}