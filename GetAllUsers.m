let
    resource = "https://graph.microsoft.com",
    tokenResponse = Json.Document(
        Web.Contents(
            "https://login.windows.net/",
            [
                RelativePath = #"Tenantid" & "/oauth2/token",
                Content = Text.ToBinary(
                    Uri.BuildQueryString(
                        [
                            client_id = #"ClientId",
                            resource = resource,
                            grant_type = "client_credentials",
                            client_secret = #"Secret"
                        ]
                    )
                ),
                Headers = [Accept = "application/json"],
                ManualStatusHandling = {400}
            ]
        )
    ),
    access_token = tokenResponse[access_token],
    GetAllPages = (url) =>
        OData.Feed(
            url,
            [Authorization = "Bearer " & access_token],
            [ExcludedFromCacheKey = {"Authorization"}, ODataVersion = 4, Implementation = "2.0"]
        ),
    Users = GetAllPages("https://graph.microsoft.com/v1.0/users?$select=id,displayName,userPrincipalName,jobTitle,department,officeLocation,employeeType,assignedLicenses"),
    #"Expanded assignedLicenses" = Table.ExpandTableColumn(Users, "assignedLicenses", {"disabledPlans", "skuId"}, {"assignedLicenses.disabledPlans", "assignedLicenses.skuId"})
in
    #"Expanded assignedLicenses"
