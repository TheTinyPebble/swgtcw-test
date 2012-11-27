/*
 * GCWManagerImplementation.cpp
 *
 *  Created on: Oct 22, 2012
 *      Author: root
 */
#include "GCWManager.h"
#include "server/zone/Zone.h"
#include "server/zone/ZoneServer.h"
#include "system/util/SortedVector.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "CheckGCWTask.h"

#include "server/zone/objects/building/components/DestructibleBuildingDataComponent.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "StartVulnerabilityTask.h"
#include "EndVulnerabilityTask.h"
#include "BaseDestructionTask.h"

#include "server/zone/objects/player/sui/messagebox/SuiMessageBox.h"
#include "server/zone/objects/player/sui/transferbox/SuiTransferBox.h"
#include "server/zone/objects/player/sui/inputbox/SuiInputBox.h"

#include "server/zone/objects/player/sui/callbacks/HQDefenseStatusSuiCallback.h"
#include "server/zone/objects/player/sui/callbacks/HQSendResetVerificationSuiCallback.h"
#include "server/zone/objects/player/sui/callbacks/JamUplinkSuiCallback.h"
#include "server/zone/objects/player/sui/callbacks/OverrideTerminalSuiCallback.h"
#include "server/zone/objects/player/sui/callbacks/PowerRegulatorSuiCallback.h"
#include "server/zone/managers/structure/StructureManager.h"

#define DEBUG_GCW

GCWManagerImplementation::GCWManagerImplementation(Zone* zne) {
	setLoggingName("GCWManager");
	info("GCWManager instantiated for " + zne->getZoneName(),true);
	gcwBaseList.setNoDuplicateInsertPlan();
	zone = zne;

	gcwStartTasks.setNoDuplicateInsertPlan();
	gcwStartTasks.setNullValue(NULL);

	gcwEndTasks.setNoDuplicateInsertPlan();
	gcwEndTasks.setNullValue(NULL);

	gcwDestroyTasks.setNoDuplicateInsertPlan();
	gcwDestroyTasks.setNullValue(NULL);
}

void GCWManagerImplementation::initialize(){
	// TODO: initialize things

	// TODO: add this to config file
	this->addDNAHash("A","T");
	this->addDNAHash("T","A");

	this->addDNAHash("C","G");
	this->addDNAHash("G","C");


}

void GCWManagerImplementation::start(){

	CheckGCWTask* task = new CheckGCWTask(_this.get());
	task->schedule(this->GCWCHECKTIMER * 1000);
	initialize();

}

void GCWManagerImplementation::loadFactionStructures(const String& zoneName){
	// load structures

	info("GCWManager Loading FACTION Structures for from factionstructures.db for zone " + zoneName,true);

	ObjectDatabaseManager* dbManager = ObjectDatabaseManager::instance();
	ObjectDatabase* factionStructuresDatabase = ObjectDatabaseManager::instance()->loadObjectDatabase("factionstructures", true);

	if (factionStructuresDatabase == NULL ) {
		error("Could not load the faction structures db");
		return;
	}

	int i = 0;

	try {

		ObjectDatabaseIterator iterator(factionStructuresDatabase);
		uint64 objectID;
		ObjectInputStream* objectData = new ObjectInputStream(2000);

		String zoneReference;

		while(iterator.getNextKeyAndValue(objectID, objectData)){

			if (!Serializable::getVariable<String>("SceneObject.zone", &zoneReference, objectData)) {
				objectData->clear();
				info("couldn't get zoneName in loadFactionStructures()");
				continue;
			}

			if (zoneName != zoneReference) {
				objectData->clear();
				continue;
			}

			ZoneServer* zoneServer = zone->getZoneServer();

			if(zoneServer==NULL)
			{
				error("ZoneServer is null when creating GCWObject in zone " + zone->getZoneName());
				return;
			}

			SceneObject* object = zoneServer->getObject(objectID);


			if (object != NULL) {
				++i;
				if (object->isBuildingObject())
				{	// does this need to be managed
					ManagedReference<BuildingObject*> buildingObject = cast<BuildingObject*>(object);

					if ( buildingObject != NULL)
					{	DestructibleBuildingDataComponent* data = getDestructibleBuildingData(buildingObject);
						if ( data != NULL) {
							/*info("Placmenet time from database is " + data->getPlacmenetTime().getFormattedTime(), true);
							info("Next Vuln time from database is " + data->getNextVulnerableTime().getFormattedTime(), true);
							info("LastReset from database      is " + data->getLastResetTime().getFormattedTime(),true);
							info("LastVulnTime from database is " + data->getLastVulnerableTime().getFormattedTime(), true);
							info("Next Vuln time from database is  " + data->getNextVulnerableTime().getFormattedTime(), true);
							info("Current tims is                  " + Time().getFormattedTime(),true);
							info("NextEndTime from the database is " + data->getVulnerabilityEndTime().getFormattedTime(), true);
							*/

						}
						else
						info("error getting datacomponent from DB", true);

						registerGCWBase(buildingObject, false);
					}
					else
						info("Unable to register gcwBuilding",true);

				}
				printf("\r\tLoading gcw structures [%d] / [?]\t", i);
			} else {
				error("Failed to deserialize gcw structure with objectID: " + String::valueOf(objectID) + "\r\n");
			}

			objectData->clear();
		}
		info("\r\nGCWMANAGER: Loaded " + String::valueOf(i) + " gcw buildings in " + zoneName,true);
		info("Registered " + String::valueOf(gcwBaseList.size()) + " bases on " + zoneName,true);
		delete objectData;
	} catch ( Exception& err) {
		error("Database error in gcwManager::loadfactionSTructures: " + err.getMessage());
	}

}

// PRE: Nothing needs to be locked
// should only be called by the startvulnerabilityTask or when loading from the db in the middle of vuln
void GCWManagerImplementation::startVulnerability(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );
	info("BASE " + String::valueOf(building->getObjectID()) + " IS NOW VULNERABLE " + Time().getFormattedTime(),true);

	renewUplinkBand(building);

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}

	Locker block(building);

	baseData->setLastVulnerableTime(baseData->getNextVulnerableTime());
	this->initializeNewVulnerability(baseData);

	block.release();

	if(!this->dropStartTask(building->getObjectID()))
		info("No starttask found to drop while starting vulnerability");

	this->scheduleVulnerabilityEnd(building);

}

// PRE:  building / objectdatacomponent are locked
void GCWManagerImplementation::initializeNewVulnerability(DestructibleBuildingDataComponent* baseData){
	baseData->setSliceRepairTime(Time(0));
	baseData->setTerminalDamaged(false);
	baseData->setSampleMatches(0);
	baseData->setTerminalDamaged(false);
	baseData->setState(DestructibleBuildingDataComponent::VULNERABLE);
	baseData->setSystemDNAString("");
	baseData->turnAllSwitchesOn();
}

// PRE: nothing needs to be locked!
void GCWManagerImplementation::scheduleVulnerabilityStart(BuildingObject* building){

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData(building);

	if(!this->hasBase(building)){
		//info("Not scheduling start task.  Building is not in the base list");
		return;
	}

	if(baseData == NULL)
		return;

	info("Scheduling next vuln in " + baseData->getNextVulnerableTime().getFormattedTime(),true);

	Time vulnTime = baseData->getNextVulnerableTime();
	int64 vulnDif = vulnTime.miliDifference();
	if(vulnDif >= 0){
		info("Cannot schedule start time.  IT has already passed");
		return;
	}

	Reference<Task*> newTask = new StartVulnerabilityTask(_this.get(), building);
	newTask->schedule(fabs(vulnDif));
	this->addStartTask(building->getObjectID(),newTask);


}

// changes timers and schedules nextVulnerabilityStart task
void GCWManagerImplementation::endVulnerability(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );
	if(baseData == NULL){
		return;
	}

	info("BASE " + String::valueOf(building->getObjectID()) + " IS NO LONGER VULNERABLE " + Time().getFormattedTime(),true);

	Locker block(building);

	baseData->setLastVulnerableTime(baseData->getNextVulnerableTime());

	Time nextTime;

	if (baseData->getLastVulnerableTime().getTime() == 0)
		nextTime = baseData->getNextVulnerableTime();
	else
		nextTime = baseData->getLastVulnerableTime();

	int64 intPeriodsPast = (fabs(nextTime.miliDifference())) / (this->VULNERABILITYFREQUENCY*1000);

	// TODO: use periodspast to get the amount of time to add and avoid the loop
	while(nextTime.isPast()){
		//info("adding time to nextvuln", true);
		nextTime.addMiliTime(GCWManager::VULNERABILITYFREQUENCY*1000);
	}

	baseData->setNextVulnerableTime(nextTime);
	nextTime.addMiliTime(GCWManager::VULNERABILITYDURATION*1000);
	baseData->setVulnerabilityEndTime(nextTime);
	baseData->setState(DestructibleBuildingDataComponent::INVULNERABLE);
	baseData->clearDNAProfiles();

	block.release();

	// TODO: check the destruction task list and remove the destruction task
	if(!this->dropEndTask(building->getObjectID()))
		info("No endtask found to remove while scheduling new startvulnerability task",true);

	// schedule
	this->scheduleVulnerabilityStart(building);

}

// only call if the last expired time has already past and we need the timers
// back up to date.  usually after a long server down or something
void GCWManagerImplementation::refreshExpiredVulnerability(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		return;
	}

	Time thisStartTime(baseData->getLastVulnerableTime());

#ifdef GCW_DEBUG
	   info("BEfore Refreshed Current time is  " + Time().getFormattedTime(),true);
		info("before Refreshed NextStart is     " + thisStartTime.getFormattedTime(),true);
		info("before Refreshed Next end time is " + baseData->getVulnerabilityEndTime().getFormattedTime(),true);
#endif

	while( (thisStartTime.getTime() + VULNERABILITYFREQUENCY) <= Time().getTime() ){
		//info("looped",true);
		thisStartTime.addMiliTime(VULNERABILITYFREQUENCY*1000);
	}

	info("Looped starttime to get " + thisStartTime.getFormattedTime(),true);

	// test time is the vulnerability end time for this current period.  it can be past or presetnt.
	Time testTime(thisStartTime);
	testTime.addMiliTime(VULNERABILITYDURATION*1000);


	Locker block(building);

	if(!testTime.isPast()) {
		// if we're still in a vuln period

		info("Loaded while vulnerable in refresh",true);
		baseData->setLastVulnerableTime(thisStartTime);

		// testTime should the same thing as vEnd
		Time vEnd(thisStartTime);
		vEnd.addMiliTime((VULNERABILITYDURATION*1000));
		baseData->setVulnerabilityEndTime(vEnd);


		Time nStartTime(thisStartTime);
		nStartTime.addMiliTime(VULNERABILITYFREQUENCY*1000);
		baseData->setNextVulnerableTime(nStartTime);

		if(baseData == NULL){
			error("ERROR:  could not get base data for base");
			return;
		}

		baseData->setState(DestructibleBuildingDataComponent::VULNERABLE);
		this->initializeNewVulnerability(baseData);

		bool wasDropped = gcwStartTasks.drop(building->getObjectID());

		baseData->setState(DestructibleBuildingDataComponent::VULNERABLE);

		/*
		info("after Chaging data lastStart to      " + baseData->getLastVulnerableTime().getFormattedTime(),true);
		info("after Changing ddata current time is " + Time().getFormattedTime(),true);
		info("after Changing data nextStart to     " + baseData->getNextVulnerableTime().getFormattedTime(),true);
		info("after changing data nextEnd  to      " + baseData->getVulnerabilityEndTime().getFormattedTime(),true);
		*/

		block.release();

		this->scheduleVulnerabilityEnd(building);


	} else{
		info("Loaded " + String::valueOf(building->getObjectID()) + " while invulnerable between vuln and the next start",true);
		baseData->setLastVulnerableTime(thisStartTime);

		Time nStartTime(thisStartTime);
		nStartTime.addMiliTime(VULNERABILITYFREQUENCY*1000);
		baseData->setNextVulnerableTime(nStartTime);

		Time vEnd(nStartTime);
		vEnd.addMiliTime(VULNERABILITYDURATION*1000);
		baseData->setVulnerabilityEndTime(vEnd);

		baseData->setState(DestructibleBuildingDataComponent::INVULNERABLE);
		/*
		info("after Chaging data lastStart to  " + baseData->getLastVulnerableTime().getFormattedTime(),true);
		info("after changing current tm  is    " + Time().getFormattedTime(),true);
		info("after Changing data nextStart to " + baseData->getNextVulnerableTime().getFormattedTime(),true);
		info("after changing data nextEnd  to  " + baseData->getVulnerabilityEndTime().getFormattedTime(),true);
		*/

		block.release();

		this->scheduleVulnerabilityStart(building);
	}

	renewUplinkBand(building);

}

// PRE:  nothing needs to be locked... building NOT locked
void GCWManagerImplementation::scheduleVulnerabilityEnd(BuildingObject* building){

	if(!this->hasBase(building)){
		info("Not scheduling end task.  Building is not in the base list");
		return;
	}

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData(building);

	if(baseData == NULL)
		return;

	Time endTime = baseData->getVulnerabilityEndTime();
	int64 endDif = endTime.miliDifference();

	if (endDif >= 0){
		info("error scheduing end time.  it has already passed");
		return;
	}

	info("Scheduling end  vulnerability for " + String::valueOf(endDif));
	Reference<Task*> newTask = new EndVulnerabilityTask(_this.get(), building);

	newTask->schedule(fabs(endDif));

	this->addEndTask(building->getObjectID(),newTask);
}

// no locks needed
void GCWManagerImplementation::scheduleBaseDestruction(BuildingObject* building){
	info("Scheduling destruction",true);

	if(this->isBaseVulnerable(building) && !this->hasDestroyTask(building->getObjectID()) ){

		DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

		if(baseData == NULL){
			error("ERROR:  could not get base data for base");
			return;
		}
		//info("setting state of the building to SHUTDOWN",true);

		Locker block(building);

		baseData->setState(DestructibleBuildingDataComponent::SHUTDOWNSEQUENCE);

		Reference<Task*> newTask = new BaseDestructionTask(_this.get(), building);
		newTask->schedule(this->DESTRUCTIONTIMER*1000);
		block.release();

		this->addDestroyTask(building->getObjectID(),newTask);
	}
}

void GCWManagerImplementation::abortShutdownSequence(CreatureObject* creature, BuildingObject* building){

	if(this->isBaseVulnerable(building) && this->hasDestroyTask(building->getObjectID())){
		//Reference<Task*> oldDestroyTask = gcwDestroyTasks.get(building->getObjectID());
		Reference<Task*> oldDestroyTask = this->getDestroyTask(building->getObjectID());
		if(oldDestroyTask != NULL){
			info("deleting destroy task",true);
			oldDestroyTask->cancel();
			//gcwDestroyTasks.drop(building->getObjectID());
			this->dropDestroyTask(building->getObjectID());
		}

		DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

		if(baseData == NULL){
			error("ERROR:  could not get base data for base");
			return;
		}

		Locker block(building);
		baseData->setState(DestructibleBuildingDataComponent::OVERLOADED);
	}
}

void GCWManagerImplementation::doBaseDestruction(BuildingObject* building){


	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}
	Locker locker(_this.get());
	Locker block(building,_this.get());

	this->unregisterGCWBase(building);

	// need to lock both.  building must be locked for destroyStructure() and then _this is locked when it calls unregister.
	StructureManager::instance()->destroyStructure(building);
}

void GCWManagerImplementation::unregisterGCWBase(BuildingObject* building){
	this->dropBase(building);

	Reference<Task*> oldStartTask = this->getStartTask(building->getObjectID());

	if(oldStartTask != NULL){
		oldStartTask->cancel();
		this->dropStartTask(building->getObjectID());
	}

	Reference<Task*> oldEndTask = this->getEndTask(building->getObjectID());
	if(oldEndTask != NULL){
		info("deleting the end task for building " + String::valueOf(building->getObjectID()), true);
		oldEndTask->cancel();
		this->dropEndTask(building->getObjectID());
	}

	Reference<Task*> oldDestroyTask = this->getDestroyTask(building->getObjectID());
	if(oldDestroyTask != NULL){
		info("deleting destroy task for building " + String::valueOf(building->getObjectID()),true);
		oldDestroyTask->cancel();
		this->dropDestroyTask(building->getObjectID());
	}
}

void GCWManagerImplementation::performGCWTasks(){


	Locker locker(_this.get());
	if(gcwBaseList.size() == 0)
		return;


	info("Performing gcw maintenance for "+ zone->getZoneName());
	int totalBase = gcwBaseList.size();
	int startCount = gcwStartTasks.size();
	int endCount = gcwEndTasks.size();
	int destroyCount = gcwDestroyTasks.size();

	info(String::valueOf(totalBase) + " bases ", true);
	//info("Size of start list is " + String::valueOf(startCount), true);
	//info("Size of end list is   " + String::valueOf(endCount),true);
	//info("Size of destroy list is   " + String::valueOf(destroyCount),true);



	uint64  thisOid;

	for(int i = 0; i< gcwBaseList.size();i++){
		thisOid = this->getBase(i)->getObjectID();
		info("Base " + String::valueOf(i) + " id: " + String::valueOf(thisOid) + " - " +   " Start: " + String::valueOf( this->hasStartTask(thisOid) )
				+ " End: " + String::valueOf(this->hasEndTask(thisOid)) + " DESTROY: " + String::valueOf(this->hasDestroyTask(thisOid)),true );
	}



	/*
	for(int i = gcwBaseList.size() -1; i >= 0; i--){
		// TODO Sanity check on the task lists etc.
	}
	*/

	CheckGCWTask* task = new CheckGCWTask(_this.get());
	task->schedule(this->GCWCHECKTIMER * 1000);
}

void GCWManagerImplementation::registerGCWBase(BuildingObject* building, bool initializeBase){
	info("Registering base");

	if ( !this->hasBase(building)){

		// initializebase should be for a first plant.
		if(initializeBase){
			DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData(building);

			if(baseData == NULL){
				info("baseData is null in initialize", true);
				return;
			}

			Locker block(building);
			this->initializeBaseTimers(building);

			block.release();

			this->addBase(building);
			this->startVulnerability(building);

		} else {
			//gcwBaseList.put(building);
			this->addBase(building);
			checkVulnerabilityData(building);

		}
	}else
		error("Building already in gcwBaseList");
}

// PRE: nothing locked
void GCWManagerImplementation::checkVulnerabilityData(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}

	info("checking vulnerability and verifying.  making necessary changes");
	Time currentTime;

	Time vulnTime = baseData->getNextVulnerableTime();
	Time nextEnd = baseData->getVulnerabilityEndTime();

	int64 vulnDif = vulnTime.miliDifference();
	int64 endDif = nextEnd.miliDifference();



	if(!vulnTime.isPast()) {
		info(zone->getZoneName() + " scheduling building " + String::valueOf(building->getObjectID()) + "vulnerability start " + String::valueOf(fabs(endDif)));
		this->scheduleVulnerabilityStart(building);
	} else if (vulnTime.isPast() && !nextEnd.isPast()) {
		info(zone->getZoneName() + " loading vulnerable base " + String::valueOf(building->getObjectID()) + " with vulnerability in progress");

		// TODO: use old state from the DB im the event of server restart during vuln.
		renewUplinkBand(building);
		this->startVulnerability(building);

	} else if (nextEnd.isPast()) {

		info(zone->getZoneName() + " base " + String::valueOf(building->getObjectID()) + " vuln end time has already passed... need to refresh next vuln times " + String::valueOf(vulnDif));
		this->refreshExpiredVulnerability(building);

	}



}

// PRE: no locks or only lock on building
// sets the bandwidth to guess during jamming of the uplink
void GCWManagerImplementation::renewUplinkBand(BuildingObject* building){

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL) {
		error("ERROR:  could not get base data for base");
		return;
	}

	// 10 possible codes bands to guess
	int secretCode = System::random(0x9);
	//info("New uplink band is " + String::valueOf(secretCode), true);

	Locker block(building);
	baseData->setUplinkBand(secretCode);


}

// pre: building is locked
// initializes times when a base is placed for the first time
void GCWManagerImplementation::initializeBaseTimers(BuildingObject* building){

	// THESE WORK IF YOU DONT WANT A BASE VULN ON PLANT
	// IT DOES THE NEXT ONE
	/*
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL) {
		error("ERROR:  could not get base data for base");
		return;
	}

	baseData->setPlacementTime(Time());
	baseData->setLastVulnerableTime(Time());

	Time nextTime;

	nextTime.addMiliTime(GCWManager::VULNERABILITYFREQUENCY*1000);
	baseData->setNextVulnerableTime(nextTime);

	nextTime.addMiliTime(GCWManager::VULNERABILITYDURATION*1000);
	baseData->setVulnerabilityEndTime(nextTime);

	baseData->setTerminalDamaged(false);
	baseData->setSliceRepairTime(Time(0)); //
	baseData->setLastResetTime(Time(0)); // set it to a long, long time ago
	*/

	// try to do initial vuln on plant
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL) {
		error("ERROR:  could not get base data for base");
		return;
	}

	baseData->setPlacementTime(Time());
	baseData->setLastVulnerableTime(Time());

	Time endTime(baseData->getPlacmenetTime());
	endTime.addMiliTime(this->VULNERABILITYDURATION*1000);
	baseData->setVulnerabilityEndTime(endTime);

	Time nextVuln(baseData->getPlacmenetTime());
	nextVuln.addMiliTime(this->VULNERABILITYFREQUENCY*1000);

	baseData->setTerminalDamaged(false);
	baseData->setSliceRepairTime(Time(0));
	baseData->setLastResetTime(Time(0)); // set it to a long, long time ago


}

DestructibleBuildingDataComponent* GCWManagerImplementation::getDestructibleBuildingData(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = NULL;

	if (building != NULL){
		if(building->isGCWBase()){
			DataObjectComponentReference* data = building->getDataObjectComponent();

			if(data != NULL)
				baseData = cast<DestructibleBuildingDataComponent*>(data->get());
		}
	}

		return baseData;
}

// PRE: nothing is locked
// time of the day
void GCWManagerImplementation::resetVulnerability(CreatureObject* creature, BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL)
		return;

	if ( baseData->isVulnerable()){
		if(creature != NULL)
			creature->sendSystemMessage("Cannot reset vulnerability while base is vulnerable");

		return;
	}

	Time ttime = baseData->getLastResetTime();

	ttime.addMiliTime(this->RESETTIMER*1000);

	if(!ttime.isPast())
	{
		if(creature != NULL)
			creature->sendSystemMessage("Can't reset yet again.  You must wait " + String::valueOf(ttime.miliDifference()/1000));

		return;
	}

	Locker block(building);

	//info("Resetting vulnerability timer",true);
	baseData->setLastResetTime(Time());

	Time nextTime = Time();

	baseData->setLastVulnerableTime(nextTime);

	nextTime.addMiliTime(GCWManager::VULNERABILITYFREQUENCY*1000);
	baseData->setNextVulnerableTime(nextTime.getTime()); // working()

	nextTime.addMiliTime(GCWManager::VULNERABILITYDURATION*1000);
	baseData->setVulnerabilityEndTime(nextTime.getTime()); // (working)

	block.release();

	Reference<Task*> task = this->getStartTask(building->getObjectID());
	if(task == NULL)
		info("no task scheduled to get in cancel");
	else
	{
		task->cancel();
		this->dropStartTask(building->getObjectID());
	}


	this->scheduleVulnerabilityStart(building);

	if(creature != NULL)
		creature->sendSystemMessage("@hq:vulnerability_reset"); // the vulnerability of this structure has been reset

}

void GCWManagerImplementation::sendBaseDefenseStatus(CreatureObject* creature, BuildingObject* building){
	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );
	if(ghost==NULL || baseData == NULL)
		return;

	ghost->closeSuiWindowType(SuiWindowType::HQ_TERMINAL);

	ManagedReference<SuiListBox*> status = new SuiListBox(creature, SuiWindowType::HQ_TERMINAL);
	status->setPromptTitle("@hq:mnu_defense_status"); //Defense status
	status->setPromptText("DEFENSE \\#FF0000STATUS\\"); // DEfense status
	status->setUsingObject(building);
	status->setOkButton(true, "@refresh");
	status->setCancelButton(true, "@cancel");
	status->setCallback( new HQDefenseStatusSuiCallback(this->zone->getZoneServer()) );

	if(baseData->isVulnerable())
		status->addMenuItem("Base is vulnerable until " + baseData->getVulnerabilityEndTime().getFormattedTime() );
	else
		status->addMenuItem("Base will be vulnerable on " + baseData->getNextVulnerableTime().getFormattedTime());

	status->addMenuItem("X credits in reserve.");
	status->addMenuItem("X troops in reserve.");
	status->addMenuItem("X resources in reserve");
	status->addMenuItem("X turrets in reserve");

	ghost->addSuiBox(status);
	creature->sendMessage(status->generateMessage());
}

void GCWManagerImplementation::sendJamUplinkMenu(CreatureObject* creature, BuildingObject* building){
	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(ghost==NULL || baseData == NULL)
		return;

	if(!baseData->isVulnerable())
	{
		creature->sendSystemMessage("Cannot jam uplink now");
		return;
	}

	ManagedReference<SuiListBox*> status = new SuiListBox(creature, SuiWindowType::HQ_TERMINAL);

	if(!this->isBandIdentified(building)){

		status->setPromptTitle("@hq:mnu_defense_status"); //Defense status
		status->setPromptText("Select the correct channel"); // DEfense status
		status->setUsingObject(building);
		status->setOkButton(true, "@ok");
		status->setCancelButton(true, "@cancel");
		status->setCallback( new JamUplinkSuiCallback(this->zone->getZoneServer()) );

		for(int i =0;i<10;i++)
			status->addMenuItem("Channel: " + String::valueOf(i+1),9);

	} else{

		status->setPromptTitle("@hq:mnu_defense_status"); //Defense status
		status->setPromptText("Select the correct frequency bandwidth within the channel"); // DEfense status
		status->setUsingObject(building);
		status->setOkButton(true, "@ok");
		status->setCancelButton(true, "@cancel");
		status->setCallback( new JamUplinkSuiCallback(this->zone->getZoneServer()) );

		for(int i =0;i<10;i++)
			status->addMenuItem("Channel " + String::valueOf(i+1),9);

	}


	ghost->addSuiBox(status);
	creature->sendMessage(status->generateMessage());

}

void GCWManagerImplementation::verifyUplinkBand(CreatureObject* creature, BuildingObject* building, int band){
	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );
	if(ghost==NULL || baseData == NULL)
		return;

	if( band == baseData->getUplinkBand()){

		Locker block(building);

		if(this->isBandIdentified(building))
			baseData->setState(DestructibleBuildingDataComponent::JAMMED);
		else
			baseData->setState(DestructibleBuildingDataComponent::BAND);

		this->renewUplinkBand(building);
		creature->sendSystemMessage("SUCCESS");
		block.release();


	} else if ( band < baseData->getUplinkBand()) {
		if(this->isUplinkJammed(building))
			creature->sendSystemMessage("The selected bandwidth is too low");
		else
			creature->sendSystemMessage("The selected channel is too low");

	} else {
		if(this->isUplinkJammed(building))
			creature->sendSystemMessage("The selected bandwidth is too high");
		else
			creature->sendSystemMessage("The selected channel is too high");
	}

}

void GCWManagerImplementation::sendResetVerification(CreatureObject* creature, BuildingObject* building){

	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );
	if(ghost==NULL || baseData == NULL)
		return;

	if(baseData->isVulnerable())
		{
		creature->sendSystemMessage("Cannot reset vulnerability while base is vulnerable");
			return;
		}
	ManagedReference<SuiMessageBox*> suiBox = new SuiMessageBox(creature, SuiWindowType::HQ_TERMINAL);
	suiBox->setCallback(new HQSendResetVerificationSuiCallback(this->zone->getZoneServer()));
	suiBox->setPromptTitle("@hq:mnu_reset_vulnerability");
	suiBox->setPromptText("@hq:mnu_reset_vulnerability");
	suiBox->setUsingObject(building);
	suiBox->setCancelButton(true, "@cancel");
	suiBox->setOkButton(true, "@yes");

	ghost->addSuiBox(suiBox);
	creature->sendMessage(suiBox->generateMessage());
}

bool GCWManagerImplementation::isBaseVulnerable(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return false;
	}

	return (baseData->getState() > DestructibleBuildingDataComponent::INVULNERABLE);
}

bool GCWManagerImplementation::isBandIdentified(BuildingObject* building) {
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return false;
	}

	return (baseData->getState() >= DestructibleBuildingDataComponent::BAND);
}
bool GCWManagerImplementation::isUplinkJammed(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return false;
	}

	return (baseData->getState() >= DestructibleBuildingDataComponent::JAMMED);
}

bool GCWManagerImplementation::isSecurityTermSliced(BuildingObject* building){

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

		if(baseData == NULL){
			error("ERROR:  could not get base data for base");
			return false;
		}

		return (baseData->getState() >= DestructibleBuildingDataComponent::SLICED);
}

bool GCWManagerImplementation::isDNASampled(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return false;
	}

	return (baseData->getState() >= DestructibleBuildingDataComponent::DNA);

}

bool GCWManagerImplementation::isPowerOverloaded(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return false;
	}

	return(baseData->getState() >= DestructibleBuildingDataComponent::OVERLOADED);
}

bool GCWManagerImplementation::isShutdownSequenceStarted(BuildingObject* building){
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		info("ERROR:  could not get base data for base",true);
		return false;
	}
	//info("State of the base is " + String::valueOf(baseData->getState()),true);

	return(baseData->getState() == DestructibleBuildingDataComponent::SHUTDOWNSEQUENCE);
}

void GCWManagerImplementation::startSlice(CreatureObject* creature, BuildingObject* building){


}

void GCWManagerImplementation::completeSecuritySlice(TangibleObject* securityTerminal){
	ManagedReference<BuildingObject*> building = cast<BuildingObject*>(securityTerminal->getParentRecursively(SceneObjectType::FACTIONBUILDING).get().get());

	if(building == NULL)
		return;

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}

	Locker block(building);
	baseData->setState(DestructibleBuildingDataComponent::SLICED);
}

bool GCWManagerImplementation::isTerminalDamaged(TangibleObject* securityTerminal){
	ManagedReference<BuildingObject*> building = cast<BuildingObject*>(securityTerminal->getParentRecursively(SceneObjectType::FACTIONBUILDING).get().get());

	if(building == NULL)
		return true;

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return true;
	}

	if(!baseData->isTerminalDamanged())
		return false;

	// check to see if it's cooled down
	Time t = baseData->getSliceRepairTime();
	t.addMiliTime(this->SLICECOOLDOWN*1000);

	// if cooldown hasn't passed since repairing, then it's still damaged
	if(t.isPast()) {
		// repair time has past... change it back to false
		Locker block(building);
		baseData->setTerminalDamaged(false);
		baseData->setTerminalBeingRepaired(false);
		return false;
	}
	else
		return true;

}

void GCWManagerImplementation::repairTerminal(CreatureObject* creature, TangibleObject* securityTerminal){
	if(securityTerminal == NULL)
			return;
	ManagedReference<BuildingObject*> building = cast<BuildingObject*>(securityTerminal->getParentRecursively(SceneObjectType::FACTIONBUILDING).get().get());

	if(building == NULL){
		info("Bulding is null while failing slice",true);
		return;
	}

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}

	if(!this->isBaseVulnerable(building))
		return;

	Time repairFinishTime = baseData->getSliceRepairTime();
	repairFinishTime.addMiliTime(this->SLICECOOLDOWN*1000);

	//info("Repair finish time is " + repairFinishTime.getFormattedTime());

	if(baseData->isTerminalDamanged()) {

		if(baseData->isTerminalBeingRepaired())
		{
			creature->sendSystemMessage("Terminal is already in the process of being repaired.");
			return;
		} else {
			//info("repairing slice",true);
			Locker block(building);
			baseData->setSliceRepairTime(Time());
			baseData->setTerminalBeingRepaired(true);
		}

	}
}

void GCWManagerImplementation::failSecuritySlice(TangibleObject* securityTerminal){

	if(securityTerminal == NULL)
		return;

	ManagedReference<BuildingObject*> building = cast<BuildingObject*>(securityTerminal->getParentRecursively(SceneObjectType::FACTIONBUILDING).get().get());

	if(building == NULL)
	{
		info("Bulding is null while failing slice",true);
		return;

	}

	if(!this->isBaseVulnerable(building))
		return;

	Locker block(building);

	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}
	//info("Failing slice",true);
	baseData->setTerminalBeingRepaired(false);
	baseData->setSliceRepairTime(baseData->getVulnerabilityEndTime()); // set it to the future
	baseData->setTerminalDamaged(true);

}
void GCWManagerImplementation::sendDNASampleMenu(CreatureObject* creature, BuildingObject* building){
	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(ghost==NULL || baseData == NULL)
		return;

	if(!this->isBaseVulnerable(building))
		return;

	ManagedReference<SuiListBox*> status = new SuiListBox(creature, SuiWindowType::HQ_TERMINAL);
	status->setPromptTitle("@hq:mnu_dna"); //Defense status

	status->setUsingObject(building);
	status->setOkButton(true, "@ok");
	status->setCancelButton(true, "@cancel");



	Locker block(building);

	// TODO: use with dnaHash


	//baseData->setDNASample(tstring.toString());
	//tstring.deleteAll();

	char providedSequence[] = "CGAT";
	//info("The existing system data string is " + baseData->getSystemDNAString(),true);

	if(baseData->getSystemDNAString() == "") {
		this->refreshDNA(baseData);
	}


	status->setCallback( new OverrideTerminalSuiCallback(this->zone->getZoneServer(), baseData->getSystemDNAString()) );


	StringBuffer dnaString;

	String controlSequence = ""; // display string for full 23 characters

	if(!baseData->isDNAInitialized()){

		//info("initializing and populating menu",true);
		// add menu items to suibox
		for(int i =0; i < TOTALDNASAMPLES; i++) {
			dnaString << providedSequence[System::random(0x3)];
			baseData->addDNAProfile(i,dnaString.toString());   // add one of 4 random letters one at a time
			status->addMenuItem( dnaString.toString(),i);      // add them to the menu
			controlSequence = controlSequence + dnaString.toString();
			dnaString.deleteAll();
		}

	} else {
		// populate the user chains to match
		//info("populating meneu",true);
		for(int i =0; i < TOTALDNASAMPLES; i++) {
			String chain = baseData->getDNAProfile(i);
			String seq = baseData->getDNAProfile(i);

			if(chain.length() > 1)
			{
				chain = "\\#008000" + chain;
				StringBuffer tstring;
				tstring << "\\#008000" << seq.charAt(0) << "\\#FFFFFF";
				seq = tstring.toString();
			}
			status->addMenuItem( chain,i);

			controlSequence = controlSequence + seq;
			chain = "";
			seq = "";
			dnaString.deleteAll();
		}
	}

	String pairString = "\\#FFFFFFSuitable Pairs: AT,TA,GC,CG	\r\n";
	String completed = "Matched Pairs: " + String::valueOf(baseData->getSampleMatches()) + "\r\n";
	String sampleChain = "Sampled Chain: " + baseData->getSystemDNAString() + "\r\n";
	controlSequence = "Control Sequence: " + controlSequence + "\r\n";


	String instructionString = "\r\nSelect a DNA marker in the control sequence as the starting point for where the sampled chain will be sliced onto it.\r\n";
    String dashes = "--------------------\r\n";
	String notes = "\r\nRESEARCH NOTES: \r\n You must match the DNA markers provided in the control sequence with the DNA from a sampled chain in order to form suitable pairs.  Continue until all of the DNA markers in the control sequence have been paired.\r\n\r\n";

	String example = "For example, if the control sequence was ATGGTTCGCA and the sample chain was GATGA, you could chooose to splice the sampled chain to the following section of the control sequence:";
	String example2 = "ATG\\#FF0000GTTCG\\#FFFFFFCA.  This would result in the splice shown below and \\#008000 2 suitable pair\\#FFFFFF:\r\n";
	String example3 = "\r\nA\r\nT\r\nG\r\n\\#FF0000GC\r\n\\#008000TA\r\n\\#FF0000TT\r\n\\#008000CG\r\n\\#FF0000GA\\#FFFFFF\r\nC\r\nA";


	status->setPromptText(pairString + completed + controlSequence + sampleChain + instructionString + dashes + dashes + notes + example + example2 + example3);
	//status->setPromptText("DNA Sequence Processing... \r\nComplete the missing pairs: AT, TA, GC, CG \r\n Matched Pairs: " +
	//		String::valueOf(baseData->getSampleMatches()) + "\r\nSampled Chain: " + baseData->getSystemDNAString());

	ghost->addSuiBox(status);
	creature->sendMessage(status->generateMessage());

}
void GCWManagerImplementation::processDNASample(CreatureObject* creature, BuildingObject* building, const  int indx){
	//info("processing DNA sample",true);
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(creature==NULL || baseData == NULL)
			return;

	if(baseData == NULL){
		error("ERROR:  could not get base data for base");
		return;
	}


	if(!this->isBaseVulnerable(building))
		return;

	String dnaString = baseData->getSystemDNAString();

	// multiple people can be doing this.  maybe lock both?
	Locker lock(_this.get());
	Locker block(building, _this.get());


	int currentMatchCount = 0;
	int j = -1;

	// don't enter loop if user didn't select anything
	for(int i = indx; i < indx+3 && i >= 0;i++){
		j++;

		String userProvidedSample = baseData->getDNAProfile(i);

		if(userProvidedSample.length() == 1){

			String transLatedUserString = this->getDNAHash(userProvidedSample);
			char systemLetter = dnaString.charAt(j);
			StringBuffer newstring;
			newstring << systemLetter;

			//info("SELCECTED : TRANSLATED : SYSTEM : " + userProvidedSample + " : " +  transLatedUserString + " : " + newstring.toString(), true);

			if(systemLetter == transLatedUserString.charAt(0)){
				baseData->modifySampleAt(i,userProvidedSample + transLatedUserString);
				baseData->incrementSampleMatches();
				currentMatchCount++;
			} else {
				//no match exit the loop
				//break;
			}

		} else {
			// selected one with two values.  going to change th system string
			this->refreshDNA(baseData);
			break;
		}

	}

	if(currentMatchCount || indx == -1){
		this->refreshDNA(baseData);
	}
	//info("New Matches: " + String::valueOf(currentMatchCount));

	//info("There are a total of " + String::valueOf(baseData->getSampleMatches()) + " matches",true);

	if ( baseData->getSampleMatches() <  DNAMATCHESREQUIRED)
	{
		this->sendDNASampleMenu(creature, building);
	}
	else
	{
		creature->sendSystemMessage("DNA Profiles complete");
		baseData->setState(DestructibleBuildingDataComponent::DNA);
	}

}

// PRE: basedata /building is locked
void GCWManagerImplementation::refreshDNA(DestructibleBuildingDataComponent* baseData){
	//info("Refreshing the string given by the system");
	char providedSequence[] = "CGAT";
	StringBuffer tstring;
	tstring << providedSequence[System::random(0x3)] << providedSequence[System::random(0x3)] << providedSequence[System::random(0x3)];
	baseData->setSystemDNAString(tstring.toString());
}

void GCWManagerImplementation::sendPowerRegulatorControls(CreatureObject* creature, BuildingObject* building){
	ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(ghost==NULL || baseData == NULL)
				return;

	if(!this->isBaseVulnerable(building))
		return;

	// TODO: CHange type
	ManagedReference<SuiListBox*> status = new SuiListBox(creature, SuiWindowType::HQ_TERMINAL);
	status->setPromptTitle("@hq:mnu_set_overload"); //Set to Overload

	status->setUsingObject(building);

	status->setOkButton(true, "OFF");
	status->setCancelButton(true, "OFF");

	status->setPromptText("Power this bitch down");
	status->setCallback( new PowerRegulatorSuiCallback(this->zone->getZoneServer()) );

	for(int i =0; i < 8; i++) {

		if(baseData->getPowerPosition(i))
			status->addMenuItem("Power Switch " + String::valueOf(i+1) + ": ON",i);
		else
			status->addMenuItem("Power Switch " + String::valueOf(i+1) + ": OFF",i);
	}

	ghost->addSuiBox(status);
	creature->sendMessage(status->generateMessage());

}

void GCWManagerImplementation::handlePowerRegulatorSwitch(CreatureObject* creature, BuildingObject* building, int indx){

	//ManagedReference<PlayerObject* > ghost = creature->getPlayerObject();
	DestructibleBuildingDataComponent* baseData = getDestructibleBuildingData( building );

	if(baseData == NULL)
		return;

	if(!this->isBaseVulnerable(building))
			return;

	Locker block(building);

	if(indx > -1){
		int change = System::random(0x2); // 0-2 to give a little more weight to the switch changing
		//info("handlign the switch ... change another = " + String::valueOf(change), true);

		baseData->turnSwitchOff(indx);

		if(change){
			int impactedSwitch = System::random(0x7);
			if(impactedSwitch != indx) {
				//info("Move switch " + String::valueOf(impactedSwitch) + " back",true);
				//info("The value of that switch is " + String::valueOf(baseData->getPowerPosition(indx)),true);
				if(!baseData->getPowerPosition(impactedSwitch)){
					baseData->turnSwitchOn(impactedSwitch);
				}
			}
			//else
			//	info("random came up with the same switch so ignore it");
		}
	}

	if(baseData->getOnSwitchCount() == 0) {
		creature->sendSystemMessage("SUCESSFULLY OVERLOADED POWER REGULATOR");
		baseData->setState(DestructibleBuildingDataComponent::OVERLOADED);
	}
	else {
		block.release();
		this->sendPowerRegulatorControls(creature,building);
	}

}
