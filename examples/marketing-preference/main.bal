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

final string testObjectType = "Contact";
final string groupName = "marketing_preference";
final string emailPropertyName = "email_subscription";
final string smsPropertyName = "sms_subscription";
final string contactTimePropertyName = "preferred_contact_time";

hsproperties:ConnectionConfig config = {auth: auth};

final hsproperties:Client hubspot = check new (config);

public function main() returns error? {
    // Step 1: Create a property group for marketing preferences
    hsproperties:PropertyGroupCreate propertyGroupInput = {
        name: groupName,
        displayOrder: 1,
        label: "Marketing Preferences"
    };
    hsproperties:PropertyGroup groupResponse = check hubspot->/[testObjectType]/groups.post(payload = propertyGroupInput);
    io:println("Property group created: ", groupResponse);

    // Step 2: Create an Email Subscription property
    hsproperties:PropertyCreate emailSubscriptionProperty = {
        "name": emailPropertyName,
        "label": "Email Subscription",
        "groupName": groupName,
        "type": "enumeration",
        "fieldType": "checkbox",
        "description": "Track email subscription status",
        options: [
            {
                label: "Subscribed",
                value: "subscribed",
                hidden: false,
                description: "Subscribed users",
                displayOrder: 1
            },
            {
                label: "Unsubscribed",
                value: "unsubscribed",
                hidden: false,
                description: "Unsubscribed users",
                displayOrder: 2
            }
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 1
    };
    hsproperties:Property emailResponse = check hubspot->/[testObjectType].post(payload = emailSubscriptionProperty);
    io:println("Property created: ", emailResponse);

    // Step 3: Create an SMS Subscription property
    hsproperties:PropertyCreate smsSubscriptionProperty = {
        "name": smsPropertyName,
        "label": "SMS Subscription",
        "groupName": groupName,
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
    };
    hsproperties:Property smsResponse = check hubspot->/[testObjectType].post(payload = smsSubscriptionProperty);
    io:println("Property created: ", smsResponse);

    // Step 4: Create a Preferred Contact Time property
    hsproperties:PropertyCreate contactTimeProperty = {
        "name": contactTimePropertyName,
        "label": "Preferred Contact Time",
        "groupName": groupName,
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
    hsproperties:Property contactTimeResponse = check hubspot->/[testObjectType].post(payload = contactTimeProperty);
    io:println("Property created: ", contactTimeResponse);

    // Step 5: Update Email Subscription property to include a new "Paused" status
    hsproperties:PropertyUpdate emailUpdate = {
        options: [
            {label: "Subscribed", value: "subscribed", displayOrder: 1, hidden: false},
            {label: "Unsubscribed", value: "unsubscribed", displayOrder: 2, hidden: false},
            {label: "Paused", value: "paused", displayOrder: 3, hidden: false}
        ]
    };
    hsproperties:Property updatedProperty = check hubspot->/[testObjectType]/[emailPropertyName].patch(payload = emailUpdate);
    io:println("Property updated: ", updatedProperty);
}