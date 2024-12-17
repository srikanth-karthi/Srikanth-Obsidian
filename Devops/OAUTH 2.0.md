---
tags:
  - Devops
---
***=***  
- What's OAUTH 2.0?  
  1. Auth request   
    - The client app redirects the user to the authorization server with these details   
      - `response_type=code` (asking for an authorization code)  
      - `client_id` (identifier of the app)  
      - `redirect_uri` (where to send the user back after authorization)  
      - `scope` (permissions being requested)  
      - `state` (to prevent CSRF attacks and ensure request integrity)

  2. The authorization server shows the consent page for the users  
    - if approved   
      - user is redirect to `redirect_uri` given by client with data  
        -  `code`: A temporary authorization code.  
        - `state`: The same value sent in step 1 (for verification).

  3. Token Exchange  
    - Client gives the `code` to authorization server with `client_id` & `client_secret` & `grant_type=authorization_code` on *token_endpoint*  
    - The server gives the tokens  
      - `access_token` - lets accessing the resource  
      - `refresh_token` - (Optional) to refresh the access token, without the need of users.

  4. Accessing the protected resources  
    - Client uses the `access_token` to make requests to the resource server

  5. Token rotation  
    - Client rotates the `acces_token`

- What's OIDC  
  - OIDC extends on OAuth2.0  
  - On step 3 (Token exchange), the authorization server gives `id_token` along with `access_token`, which the client uses to establish *authentication*  
  - The `id_token` will contain what's called a `claims`, which are list of claims that a bearer can make, similar concept to `SAML assertion`

***>***  
- Why Companies opt of ***OAuth2.0 + OIDC*** over ***SAML***  
- *SAML* is a authentication mechanism, and *OIDC* too, so they're now complementing  
- The reasons  
  1. REST based, better support for Mobile, Web, CLI apps whereas ___  
  2. OIDC uses JWTs, lightweight, fast and easier than large XML files # Notes  
- Not to be confused with ADFS, ADMS, ADCS, AD(Directory)S  
generally when we people ***say AD, its AD(Domain)S***

- ADDS follows what's called **x.500** directory structure, where everything is objects with some unique names, and these objects can be organised into Organisational units.

- The directory structure has to be *accessed* **via LDAP** (ligthweight) protocol. x.500 did have a **DAP**, but its large and cumbersome.

- With some **LDAP tool** you can connect as a certain identity to the directory

- Azure AD uses **cloud protocol** for authN and authZ, whereas ADDS uses protocols like LDAP, Kerboros, NTLM for authentication

- **Group policy** is a feature in AD DS, that's not in cloud AD, that enforces some rules based on the given policy and also we can link different OUs

- Schema is a blueprint for objects in active directory, that defines object's artibutes. for example user, groups, person all has a schema defined

- **Physical Instances** - The domain controller(s)  
  - The DC has full copy of their domain database  
  - You want more than one domain controller  
    - For scale purposes  
    - For Resiliency  
    - Performance for the end user  
      - Location based provisioning of servers  
       ![[Screenshot 2024-12-15 at 7.56.38 PM.webp]]  
    - All of these are RW (multi-master)  
    - Replication happens bi-directed  
  - **FSMO - Flexible Single Master Operator** role