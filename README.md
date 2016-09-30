# cRemoteDesktopGateway
This repository contains the **cRemoteDesktopGateway** PowerShell module, containing Microsoft Windows PowerShell Desired State Configuration (DSC) resources to manage Remote Desktop Gateway (RDG).

## Resources

* **ESNAD_cConnectionAccessPolicy** set connection access policy
* **ESNAD_cRemoteDesktopGatewayServer** set remote desktop gateway properties
* **ESNAD_cResourceAccessPolicy** set resource access policy
* **ESNAD_cSSLCertificate** set SSL certificate binding for Remote desktop Gateway

### ESNAD_cConnectionAccessPolicy

* **Ensure**: Wheter the rule should be present or removed
* **RuleName** Rule name
* **Usergroups** Contains user groups that are associated with the connection authorization policy (CAP).                                                                                                                      
* **Status** Specifies whether this connection authorization policy (CAP) will be used to evaluate a user for authorization. 0 - No, 1 - Yes.
* **AuthMethod**: Specifies how the RD Gateway server authenticates users. 0 - No authentication, 1 -  Password authentication, 2 - Smart card authentication, 3 - Password and smart card authentication.
* **AllowOnlySDRTSServers**: Specifies whether connections are allowed only to Remote Desktop Session Host servers that enforce Remote Desktop Gateway redirection policy. 0 - No, 1 - Yes.
* **IdleTimeout**: Specifies the time interval, in minutes, after which an idle session is disconnected. A value of zero specifies an infinite amount of time.
* **SessionTimeout**: Specifies the action the server takes when a session times out. 0 - Disconnect the session, 1 - Silently reauthenticate and reauthorize the session.
* **SessionTimeoutAction**: Specifies the action the server takes when a session times out. 0 - Disconnect the session, 1 - Silently reauthenticate and reauthorize the session. 
* **EvaluationOrder**: Specifies the evaluation order of the connection authorization policy (CAP). The CAP in which EvaluationOrder is set to a value of '1' is evaluated first.

### ESNAD_cRemoteDesktopGatewayServer

* **MaxConnections**: Specifies the maximum number of connections allowed by the administrator. If this item is set to zero, no new connections are allowed.
* **RequestSOH**: Specifies whether to request clients to send a statement of health. 0 - No, 1 - Yes.                                                  
* **SSLBridging**: Specifies whether to use SSL Bridging. 0 - No SSL bridging, 1 - HTTPS-HTTP bridging, 2 - HTTPS-HTTPS bridging.                        
* **CentralCAPEnabled** Specifies where to store connection authorization policies (CAPs). 0 - Local Network Policy Server, 1- Central Network Policy Server. 
* **EnableOnlyMessagingCapableClients** Specifies whether only clients that support logon messages and administrator messages can connect. 0 - No, 1 - Yes.                   

### ESNAD_cResourceAccessPolicy

* **Ensure**: Wheter the rule should be present or removed
* **RuleName**: Resource access policy rule name
* **Status**: Specifies whether this resource authorization policy (RAP) will be used to authorize a user. 0 - No, 1 - Yes.                                                                    
* **PortNumbers**: Specifies the port numbers for the ports through which connections are allowed for this policy. To allow connections through any port, specify '*' .                             
* **ComputerGroupType**: Specifies the computer group type. 0 - RD Gateway-managed group, 1 - Active Directory Domain Services network resource group, 2 - Allow users to connect to any network resource.
* **ComputerGroup**: Specifies the computer group that is associated with this resource authorization policy (RAP).                                                                                   
* **UserGroups**: Specifies the user groups that are associated with this resource authorization policy (RAP). A user must belong to one of these groups to access the RD Gateway server.   


### ESNAD_cSSLCertificate
* **Thumbprint**: Contains the thumbprint of the SSL certificate to use.

# Author
The author of this module is Bart Danse. 
