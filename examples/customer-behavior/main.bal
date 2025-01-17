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

const GROUP_NAME = "customer_behavior";
string customPropertyName = "purchase_frequency_property";
string dependantPropertyName = "preferred_channel_property";

public function main() returns error? {

    // Step 1: Create a property group for Customer Behavior
    hsproperties:PropertyGroupCreate behaviorGroupInput = {
        name: groupName,
        displayOrder: 1,
        label: "Customer Behavior"
    };
    hsproperties:PropertyGroup behaviorGroupResponse = check hubSpotProperties->/Contact/groups.post(payload = behaviorGroupInput);
    io:println("Property group created: ", behaviorGroupResponse);

    // Step 2: Create a custom property to track purchase frequency
    hsproperties:PropertyCreate purchaseFrequencyProperty = {
        "name": customPropertyName,
        "label": customPropertyName,
        "groupName": groupName,
        "type": "enumeration",
        "fieldType": "select",
        "description": "How often the customer makes purchases",
        "options": [
            {"label": "Daily", "value": "daily", "hidden": false, "description": "Purchases made daily", "displayOrder": 1},
            {"label": "Weekly", "value": "weekly", "hidden": false, "description": "Purchases made weekly", "displayOrder": 2},
            {"label": "Monthly", "value": "monthly", "hidden": false, "description": "Purchases made monthly", "displayOrder": 3}
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 1
    };
    hsproperties:Property purchaseFrequencyResponse = check hubSpotProperties->/Contact.post(payload = purchaseFrequencyProperty);
    io:println("Property created: ", purchaseFrequencyResponse);

    // Step 3: Create a dependent property for preferred communication channel
    hsproperties:PropertyCreate preferredChannelProperty = {
        "name": dependantPropertyName,
        "label": dependantPropertyName,
        "groupName": groupName, // Corrected groupName
        "type": "enumeration",
        "fieldType": "radio",
        "description": "Customer's preferred communication channel",
        "options": [
            {"label": "Email", "value": "email", "hidden": false, "description": "Communicate via Email", "displayOrder": 1},
            {"label": "SMS", "value": "sms", "hidden": false, "description": "Communicate via SMS", "displayOrder": 2},
            {"label": "Phone", "value": "phone", "hidden": false, "description": "Communicate via Phone", "displayOrder": 3}
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 2
    };
    hsproperties:Property preferredChannelResponse = check hubSpotProperties->/Contact.post(payload = preferredChannelProperty);
    io:println("Property created: ", preferredChannelResponse);

    // Step 4: Dynamically update an existing property to include a new option
    hsproperties:PropertyUpdate purchaseFrequencyUpdate = {
        options: [
            {"label": "Daily", "value": "daily", "displayOrder": 1, "hidden": false},
            {"label": "Weekly", "value": "weekly", "displayOrder": 2, "hidden": false},
            {"label": "Monthly", "value": "monthly", "displayOrder": 3, "hidden": false},
            {"label": "Quarterly", "value": "quarterly", "displayOrder": 4, "hidden": false} // New option added
        ]
    };
    hsproperties:Property updatedPurchaseFrequency = check hubSpotProperties->/Contact/[customPropertyName].patch(payload = purchaseFrequencyUpdate);
    io:println("Updated property: ", updatedPurchaseFrequency);

    // Step 5: Log all created properties and groups
    io:println("Customer behavior group and associated properties created successfully.");
}
