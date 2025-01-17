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

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.properties as hsproperties;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

hsproperties:OAuth2RefreshTokenGrantConfig auth = {
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};
final hsproperties:Client hubSpotProperties = check new ({ auth });

const TEST_OBJECT_TYPE = "Contact";
const GROUP_NAME = "marketing_preference";
const EMAIL_PROPERTY_NAME = "email_subscription";
const SMS_PROPERTY_NAME = "sms_subscription";
const CONTACT_TIME_PROPERTY_NAME = "preferred_contact_time";

public function main() returns error? {
    // Step 1: Create a property group for marketing preferences
    hsproperties:PropertyGroupCreate propertyGroupInput = {
        name: GROUP_NAME,
        displayOrder: 1,
        label: "Marketing Preferences"
    };
    hsproperties:PropertyGroup groupResponse = check hubSpotProperties->/[TEST_OBJECT_TYPE]/groups.post(payload = propertyGroupInput);
    io:println("Property group created: ", groupResponse);

    // Step 2: Create Email Subscription and SMS Subscription properties in batch
    hsproperties:BatchInputPropertyCreate batchInputPropertyCreate = {
        inputs: [
            {
                "name": EMAIL_PROPERTY_NAME,
                "label": "Email Subscription",
                "groupName": GROUP_NAME,
                "type": "enumeration",
                "fieldType": "checkbox",
                "description": "Track email subscription status",
                "options": [
                    {
                        "label": "Subscribed",
                        "value": "subscribed",
                        "hidden": false,
                        "description": "Subscribed users",
                        "displayOrder": 1
                    },
                    {
                        "label": "Unsubscribed",
                        "value": "unsubscribed",
                        "hidden": false,
                        "description": "Unsubscribed users",
                        "displayOrder": 2
                    }
                ],
                "hidden": false,
                "formField": true,
                "displayOrder": 1
            },
            {
                "name": SMS_PROPERTY_NAME,
                "label": "SMS Subscription",
                "groupName": GROUP_NAME,
                "type": "enumeration",
                "fieldType": "checkbox",
                "description": "Track SMS subscription status",
                "options": [
                    {
                        "label": "Subscribed",
                        "value": "subscribed",
                        "hidden": false,
                        "description": "Subscribed users",
                        "displayOrder": 1
                    },
                    {
                        "label": "Unsubscribed",
                        "value": "unsubscribed",
                        "hidden": false,
                        "description": "Unsubscribed users",
                        "displayOrder": 2
                    }
                ],
                "hidden": false,
                "formField": true,
                "displayOrder": 2
            }
        ]
    };
    hsproperties:BatchResponseProperty batchResponse = check hubSpotProperties->/[TEST_OBJECT_TYPE]/batch/create.post(payload = batchInputPropertyCreate);
    io:println("Batch properties created: ", batchResponse);

    // Step 3: Create a Preferred Contact Time property
    hsproperties:PropertyCreate contactTimeProperty = {
        "name": CONTACT_TIME_PROPERTY_NAME,
        "label": "Preferred Contact Time",
        "groupName": GROUP_NAME,
        "type": "enumeration",
        "fieldType": "radio",
        "description": "Track customer's preferred contact time",
        "options": [
            {
                "label": "Morning",
                "value": "morning",
                "hidden": false,
                "description": "Preferred contact time: Morning",
                "displayOrder": 1
            },
            {
                "label": "Afternoon",
                "value": "afternoon",
                "hidden": false,
                "description": "Preferred contact time: Afternoon",
                "displayOrder": 2
            },
            {
                "label": "Evening",
                "value": "evening",
                "hidden": false,
                "description": "Preferred contact time: Evening",
                "displayOrder": 3
            }
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 3
    };
    hsproperties:Property contactTimeResponse = check hubSpotProperties->/[TEST_OBJECT_TYPE].post(payload = contactTimeProperty);
    io:println("Property created: ", contactTimeResponse);

    // Step 4: Update Email Subscription property to include a new "Paused" status
    hsproperties:PropertyUpdate emailUpdate = {
        options: [
            {label: "Subscribed", value: "subscribed", displayOrder: 1, hidden: false},
            {label: "Unsubscribed", value: "unsubscribed", displayOrder: 2, hidden: false},
            {label: "Paused", value: "paused", displayOrder: 3, hidden: false}
        ]
    };
    hsproperties:Property updatedProperty = check hubSpotProperties->/[TEST_OBJECT_TYPE]/[EMAIL_PROPERTY_NAME].patch(payload = emailUpdate);
    io:println("Property updated: ", updatedProperty);

}
