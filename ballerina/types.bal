// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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

public type StandardError record {
    record {} subCategory?;
    record {|string[]...;|} context;
    record {|string...;|} links;
    string id?;
    string category;
    string message;
    ErrorDetail[] errors;
    string status;
};

# An ID for a group of properties
public type PropertyGroup record {
    boolean archived;
    # The internal property group name, which must be used when referencing the property group via the API.
    string name;
    # Property groups are displayed in order starting with the lowest positive integer value. Values of -1 will cause the property group to be displayed after any positive values.
    int:Signed32 displayOrder;
    # A human-readable label that will be shown in HubSpot.
    string label;
};

public type CollectionResponsePropertyGroupNoPaging record {
    PropertyGroup[] results;
};

public type PropertyCreate record {
    # If true, the property won't be visible and can't be used in HubSpot.
    boolean hidden?;
    # Properties are displayed in order starting with the lowest positive integer value. Values of -1 will cause the property to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A description of the property that will be shown as help text in HubSpot.
    string description?;
    # A human-readable property label that will be shown in HubSpot.
    string label;
    # The data type of the property.
    "string"|"number"|"date"|"datetime"|"enumeration"|"bool" 'type;
    # Whether or not the property can be used in a HubSpot form.
    boolean formField?;
    # The name of the property group the property belongs to.
    string groupName;
    # Should be set to 'OWNER' when 'externalOptions' is true, which causes the property to dynamically pull option values from the current HubSpot users.
    string referencedObjectType?;
    # The internal property name, which must be used when referencing the property via the API.
    string name;
    # A list of valid options for the property. This field is required for enumerated properties.
    OptionInput[] options?;
    # Represents a formula that is used to compute a calculated property.
    string calculationFormula?;
    # Whether or not the property's value must be unique. Once set, this can't be changed.
    boolean hasUniqueValue?;
    # Controls how the property appears in HubSpot.
    "textarea"|"text"|"date"|"file"|"number"|"select"|"radio"|"checkbox"|"booleancheckbox"|"calculation_equation" fieldType;
    # Applicable only for 'enumeration' type properties.  Should be set to true in conjunction with a 'referencedObjectType' of 'OWNER'.  Otherwise false.
    boolean externalOptions?;
};

public type CollectionResponsePropertyNoPaging record {
    Property[] results;
};

public type ErrorDetail record {
    # A specific category that contains more specific detail about the error
    string subCategory?;
    # The status code associated with the error detail
    string code?;
    # The name of the field or parameter in which the error was found.
    string 'in?;
    # Context about the error condition
    record {|string[]...;|} context?;
    # A human readable message describing the error along with remediation steps where appropriate
    string message;
};

public type BatchInputPropertyCreate record {
    PropertyCreate[] inputs;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

public type PropertyGroupUpdate record {
    # Property groups are displayed in order starting with the lowest positive integer value. Values of -1 will cause the property group to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A human-readable label that will be shown in HubSpot.
    string label?;
};

public type Property record {
    # The internal user ID of the user who created the property in HubSpot. This field may not exist if the property was created outside of HubSpot.
    string createdUserId?;
    # Whether or not the property will be hidden from the HubSpot UI. It's recommended this be set to false for custom properties.
    boolean hidden?;
    PropertyModificationMetadata modificationMetadata?;
    # Properties are shown in order, starting with the lowest positive integer value.
    int:Signed32 displayOrder?;
    # A description of the property that will be shown as help text in HubSpot.
    string description;
    # Whether or not the property will display the currency symbol set in the account settings.
    boolean showCurrencySymbol?;
    # A human-readable property label that will be shown in HubSpot.
    string label;
    # The property data type.
    string 'type;
    # This will be true for default object properties built into HubSpot.
    boolean hubspotDefined?;
    # Whether or not the property can be used in a HubSpot form.
    boolean formField?;
    # 
    string createdAt?;
    # When the property was archived.
    string archivedAt?;
    # Whether or not the property is archived.
    boolean archived?;
    # The name of the property group the property belongs to.
    string groupName;
    # If this property is related to other object(s), they'll be listed here.
    string referencedObjectType?;
    # The internal property name, which must be used when referencing the property via the API.
    string name;
    # A list of valid options for the property. This field is required for enumerated properties, but will be empty for other property types.
    Option[] options;
    # Represents a formula that is used to compute a calculated property.
    string calculationFormula?;
    # Whether or not the property's value must be unique. Once set, this can't be changed.
    boolean hasUniqueValue?;
    # Controls how the property appears in HubSpot.
    string fieldType;
    # The internal user ID of the user who updated the property in HubSpot. This field may not exist if the property was updated outside of HubSpot.
    string updatedUserId?;
    # For default properties, true indicates that the property is calculated by a HubSpot process. It has no effect for custom properties.
    boolean calculated?;
    # For default properties, true indicates that the options are stored externally to the property settings.
    boolean externalOptions?;
    # 
    string updatedAt?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

public type PropertyName record {
    # The name of the property to read or modify.
    string name;
};

# Represents the Queries record for the operation: get-/crm/v3/properties/{objectType}_getAll
public type GetCrmV3PropertiesObjecttype_getallQueries record {
    # Whether to return only results that have been archived.
    boolean archived = false;
    string properties?;
};

public type BatchResponseProperty record {
    string completedAt;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    Property[] results;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

public type OptionInput record {
    # Hidden options won't be shown in HubSpot.
    boolean hidden;
    # Options are shown in order starting with the lowest positive integer value. Values of -1 will cause the option to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A description of the option.
    string description?;
    # A human-readable option label that will be shown in HubSpot.
    string label;
    # The internal value of the option, which must be used when setting the property value through the API.
    string value;
};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

public type PropertyUpdate record {
    # The name of the property group the property belongs to.
    string groupName?;
    # If true, the property won't be visible and can't be used in HubSpot.
    boolean hidden?;
    # A list of valid options for the property.
    OptionInput[] options?;
    # Properties are displayed in order starting with the lowest positive integer value. Values of -1 will cause the Property to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A description of the property that will be shown as help text in HubSpot.
    string description?;
    # Represents a formula that is used to compute a calculated property.
    string calculationFormula?;
    # A human-readable property label that will be shown in HubSpot.
    string label?;
    # The data type of the property.
    "string"|"number"|"date"|"datetime"|"enumeration"|"bool" 'type?;
    # Controls how the property appears in HubSpot.
    "textarea"|"text"|"date"|"file"|"number"|"select"|"radio"|"checkbox"|"booleancheckbox"|"calculation_equation" fieldType?;
    # Whether or not the property can be used in a HubSpot form.
    boolean formField?;
};

public type PropertyModificationMetadata record {
    boolean readOnlyOptions?;
    boolean readOnlyValue;
    boolean readOnlyDefinition;
    boolean archivable;
};

public type PropertyGroupCreate record {
    # The internal property group name, which must be used when referencing the property group via the API.
    string name;
    # Property groups are displayed in order starting with the lowest positive integer value. Values of -1 will cause the property group to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A human-readable label that will be shown in HubSpot.
    string label;
};

public type BatchReadInputPropertyName record {
    boolean archived;
    PropertyName[] inputs;
};

public type BatchInputPropertyName record {
    PropertyName[] inputs;
};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

public type BatchResponsePropertyWithErrors record {
    string completedAt;
    int:Signed32 numErrors?;
    string requestedAt?;
    string startedAt;
    record {|string...;|} links?;
    Property[] results;
    StandardError[] errors?;
    "PENDING"|"PROCESSING"|"CANCELED"|"COMPLETE" status;
};

public type Option record {
    # Hidden options will not be displayed in HubSpot.
    boolean hidden;
    # Options are displayed in order starting with the lowest positive integer value. Values of -1 will cause the option to be displayed after any positive values.
    int:Signed32 displayOrder?;
    # A description of the option.
    string description?;
    # A human-readable option label that will be shown in HubSpot.
    string label;
    # The internal value of the option, which must be used when setting the property value through the API.
    string value;
};

# Represents the Queries record for the operation: get-/crm/v3/properties/{objectType}/{propertyName}_getByName
public type GetCrmV3PropertiesObjecttypePropertyname_getbynameQueries record {
    # Whether to return only results that have been archived.
    boolean archived = false;
    string properties?;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string private\-app\-legacy;
    string private\-app;
|};
