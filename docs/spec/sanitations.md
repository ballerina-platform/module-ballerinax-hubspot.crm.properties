_Author_:  @ManadaHerath \
_Created_: 07.01.2025 \
_Updated_: 08.01.2025 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Ballerina HubSpot CRM Properties Connector. 
The OpenAPI specification is obtained from [Hubspot API Reference](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/402616baec042e147306b92cd551b84d44708127/PublicApiSpecs/CRM/Properties/Rollouts/145899/v3/properties.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object
- **Original**: 
```https://api.hubspot.com```

- **Updated**: 
```https://api.hubapi.com/crm/v3/properties```

- **Reason**: This change of adding the common prefix `crm/v3/properties` to the base url makes it easier to access endpoints using the client.

2. Update the API Paths
- **Original**: Paths included common prefix above in each endpoint. (eg: ```/crm/v3/properties```)

- **Updated**: Common prefix is now removed from the endpoints as it is included in the base URL.
  - **Original**: ```/crm/v3/properties```
  - **Updated**: ```/```

- **Reason**: This change simplifies the API p aths, making them shorter and more readable.

3. Endpoint Conflict Resolution: Property Groups
- **Original**: Included an endpoint with the path `/{objectType}/groups` to read all property groups.

- **Updated**: Removed the `/{objectType}/groups` endpoint.

- **Reason**: This endpoint caused an ambiguous method error with the existing endpoint for reading a property. Removing it resolves the conflict and ensures clarity in method handling. 

4. Update the `date-time` into `datetime` to make it compatible with the ballerina type conversions
- **Original**: `foramt:date-time`
`
- **Updated**: `foramt:datetime`

- **Reason**: The date-time format is not compatible with the openAPI generation tool. Therefore, it is updated to datetime to make it compatible with the generation tool.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2025, change if necessary.
