// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

service on new http:Listener(9090) {

    resource function get [string objectType](map<string|string[]> headers = {}) returns CollectionResponsePropertyNoPaging {
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
        return response;
    }

    resource function post [string objectType](PropertyCreate payload) returns json {
        return {
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
        http:Response response = new;
        response.statusCode = http:STATUS_OK;
        response.setJsonPayload(responseBody);
        return response;
    }

    resource function delete [string objectType]/[string propertyName]() returns http:Response|error {
        http:Response response = new;
        response.statusCode = http:STATUS_NO_CONTENT;
        return response;
    }

    // batch

    resource function post [string objectType]/batch/read(BatchReadInputPropertyName payload) returns BatchResponseProperty {
        BatchResponseProperty response = {
            completedAt: "2025-01-02T06:33:12.365Z",
            requestedAt: "2025-01-02T06:33:12.365Z",
            results: [
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
                }
            ],
            startedAt: "2025-01-02T06:33:12.365Z",
            status: "PENDING"
        };
        return response;
    }

    resource function post [string objectType]/batch/create(BatchInputPropertyCreate payload) returns BatchResponseProperty {
        BatchResponseProperty response = {
            completedAt: "2025-01-02T06:33:12.365Z",
            requestedAt: "" +
            "2025-01-02T06:33:12.365Z",
            results: [
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
                }
            ],
            startedAt: "2025-01-02T06:33:12.365Z",
            status: "PENDING"
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

    resource function post [string objectType]/groups(PropertyGroupCreate payload) returns PropertyGroup {
        PropertyGroup response = {
            archived: true,
            name: payload.name,
            displayOrder: -1,
            label: payload.label
        };

        return response;
    }

    resource function patch [string objectType]/groups/[string propertyGroupName](PropertyGroupUpdate payload) returns PropertyGroup {
        PropertyGroup response = {
            archived: true,
            name: propertyGroupName,
            displayOrder: -1,
            label: ""
        };
        return response;
    }

    resource function delete [string objectType]/groups/[string propertyGroupName]() returns http:Response|error {
        http:Response response = new;
        response.statusCode = http:STATUS_NO_CONTENT;
        return response;
    }

};
