import ballerina/http;



service /crm/v3/properties on new http:Listener(9090) {

    resource function get [string objectType](map<string|string[]> headers = {})
    returns CollectionResponsePropertyNoPaging|http:Response {
        if objectType == "contacts" {
            return {
                "results": [
                    {
                    "createdUserId": "string",
                    "hidden": false,
                    "modificationMetadata": {
                        "readOnlyOptions": true,
                        "readOnlyValue": true,
                        "readOnlyDefinition": true,
                        "archivable": true
                    },
                    "displayOrder": 2,
                    "description": "string",
                    "showCurrencySymbol": true,
                    "label": "My Contact Property",
                    "type": "enumeration",
                    "hubspotDefined": true,
                    "formField": true,
                    "createdAt": "2024-12-17T06:07:44.134Z",
                    "archivedAt": "2024-12-17T06:07:44.134Z",
                    "archived": true,
                    "groupName": "contactinformation",
                    "referencedObjectType": "string",
                    "name": "my_contact_property",
                    "options": [
                        {
                        "hidden": false,
                        "displayOrder": 1,
                        "description": "Choice number one",
                        "label": "Option A",
                        "value": "A"
                        }
                    ],
                    "calculationFormula": "string",
                    "hasUniqueValue": false,
                    "fieldType": "select",
                    "updatedUserId": "string",
                    "calculated": true,
                    "externalOptions": true,
                    "updatedAt": "2024-12-17T06:07:44.134Z"
                    }
                ]
            };
        } else {
            return {
                "results": []
            };
        }
    }
};




