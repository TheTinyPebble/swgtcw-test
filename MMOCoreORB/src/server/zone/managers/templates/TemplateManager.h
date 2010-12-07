/*
 * TemplateManager.h
 *
 *  Created on: 31/01/2010
 *      Author: victor
 */

#ifndef TEMPLATEMANAGER_H_
#define TEMPLATEMANAGER_H_

#include "engine/engine.h"

#include "engine/util/ObjectFactory.h"
#include "server/zone/templates/SharedObjectTemplate.h"

class TemplateCRCMap;
class ClientTemplateCRCMap;
class PortalLayoutMap;
class FloorMeshMap;
class MeshAppearanceMap;

class FloorMesh;
class PortalLayout;
class MeshAppearanceTemplate;

class TemplateManager : public Singleton<TemplateManager>, public Logger {
	TemplateCRCMap* templateCRCMap;

	ObjectFactory<SharedObjectTemplate* (), uint32> templateFactory;
	ClientTemplateCRCMap* clientTemplateCRCMap;
	PortalLayoutMap* portalLayoutMap;
	FloorMeshMap* floorMeshMap;
	MeshAppearanceMap* meshAppearanceMap;

public:
	static Lua* luaTemplatesInstance;

public:
	TemplateManager();
	~TemplateManager();

	void registerTemplateObjects();

	void loadLuaTemplates();

	void addTemplate(uint32 key, const String& fullName, LuaObject* templateData);

	String getTemplateFile(uint32 key);

	SharedObjectTemplate* getTemplate(uint32 key);

	IffStream* openIffFile(const String& fileName);

	FloorMesh* getFloorMesh(const String& fileName);
	PortalLayout* getPortalLayout(const String& fileName);
	MeshAppearanceTemplate* getMeshAppearanceTemplate(const String& fileName);

	bool existsTemplate(uint32 key);

	// LUA
	void registerFunctions();
	void registerGlobals();
	static int includeFile(lua_State* L);
	static int crcString(lua_State* L);
	static int addTemplateCRC(lua_State* L);
	static int addClientTemplate(lua_State* L);

};


#endif /* TEMPLATEMANAGER_H_ */
