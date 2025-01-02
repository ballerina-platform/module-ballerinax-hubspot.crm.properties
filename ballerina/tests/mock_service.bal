import ballerina/http;

service /crm/v3/properties on new http:Listener(9090) {

    resource function get [string objectType](map<string|string[]> headers = {}) returns CollectionResponsePropertyNoPaging|http:Response {
        if objectType == "Contact" {
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

    resource function get [string objectType]/[string propertyName]() returns json {
    // Prepare the mock response data.
    json response = {
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
        "createdAt": "2025-01-02T06:33:12.365Z",
        "archivedAt": "2025-01-02T06:33:12.365Z",
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
        "updatedAt": "2025-01-02T06:33:12.365Z"
        };

    // Return the mock response.
    return response;
    }
    
    resource function post [string objectType](PropertyCreate payload) returns http:Response|error {
    // Prepare the response JSON directly using the payload.
    json responseBody = {
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
        "createdAt": "2025-01-02T06:33:12.405Z",
        "archivedAt": "2025-01-02T06:33:12.405Z",
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
        "updatedAt": "2025-01-02T06:33:12.405Z"
        };

    // Create the HTTP response with status code 201.
    http:Response response = new;
    response.statusCode = http:STATUS_CREATED;
    response.setJsonPayload(responseBody);
    return response;
    }

    resource function patch [string objectType]/[string propertyName](@http:Payload json payload) returns http:Response|error {

    json responseBody = {
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
        "createdAt": "2025-01-02T06:33:12.418Z",
        "archivedAt": "2025-01-02T06:33:12.418Z",
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
            },
            {
                "hidden": false,
                "displayOrder": 2,
                "description": "Choice number two",
                "label": "Option B",
                "value": "B"
            }
        ],
        "calculationFormula": "string",
        "hasUniqueValue": false,
        "fieldType": "select",
        "updatedUserId": "string",
        "calculated": true,
        "externalOptions": true,
        "updatedAt": "2025-01-02T06:33:12.418Z"
    };

    // Create the HTTP response with status code 200.
    http:Response response = new;
    response.statusCode = http:STATUS_OK;
    response.setJsonPayload(responseBody);
    return response;
    }

    resource function delete [string objectType]/[string propertyName]() returns http:Response|error {
    // Create an HTTP response with status code 204 (No Content).
    http:Response response = new;
    response.statusCode = http:STATUS_NO_CONTENT;
    return response;
    }   

    resource function post [string objectType]/batch/create() returns BatchResponseProperty {
    // Prepare the BatchResponseProperty type response.
    BatchResponseProperty response = {
        "completedAt": "2025-01-02T06:33:12.227Z",
        "requestedAt": "2025-01-02T06:33:12.227Z",
        "startedAt": "2025-01-02T06:33:12.227Z",
        "links": {
            "additionalProp1": "string",
            "additionalProp2": "string",
            "additionalProp3": "string"
        },
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
            "createdAt": "2025-01-02T06:33:12.227Z",
            "archivedAt": "2025-01-02T06:33:12.227Z",
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
            "updatedAt": "2025-01-02T06:33:12.227Z"
            }
        ],
        "status": "PENDING"
        };

    return response;
    }
    resource function post [string objectType]/batch/archive(@http:Payload json payload) returns http:Response|error {
    http:Response response = new;
    if payload.inputs is json[] && payload.inputs != null {
        response.statusCode = http:STATUS_NO_CONTENT;
    } else {
        response.statusCode = http:STATUS_BAD_REQUEST;
    }
    return response;
    }

// group
    resource function get [string objectType]/groups/[string groupName]() returns http:Response {
    json responseData = {
        archived: true,
        name: "propertygrouptest1",
        displayOrder: -1,
        label: "My Property Group"
    };
    http:Response response = new;
    response.statusCode = 200;
    response.setJsonPayload(responseData);
    return response;
    }
    
    resource function post [string objectType]/groups(PropertyGroupCreate payload) returns http:Response {
    json responseData = {
        archived: true,
        name: payload.name,
        displayOrder: payload.displayOrder,
        label: payload.label
    };

    http:Response response = new;
    response.statusCode = 201;
    response.setJsonPayload(responseData);

    return response;
    }

};




