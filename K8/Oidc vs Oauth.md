---
tags:
  - Devops
---

OAuth 2.0 and OpenID Connect (OIDC) are related protocols but serve distinct purposes. Here's a clear breakdown of the differences between the two:

### **Purpose**
- **OAuth 2.0**: 
  - Primarily an *authorization* framework.
  - Focuses on allowing an application to obtain limited access to a resource on behalf of the user (e.g., accessing user data from an API like Google or Facebook).
  - It does not define how to authenticate the user.

- **OIDC**:
  - Built on top of OAuth 2.0.
  - Adds an *authentication* layer.
  - Designed to authenticate users and provide identity information (e.g., who the user is, via an ID token).

---

### **Scope**
- **OAuth 2.0**:
  - Grants access tokens for accessing APIs.
  - Does not include user identity information.
  - Used for delegated access (e.g., granting a third-party app access to a user’s Google Drive).

- **OIDC**:
  - Includes authentication details and identity information in the form of an ID token.
  - Designed for single sign-on (SSO) and identity sharing (e.g., logging into an app using your Google account).

---

### **Tokens**
- **OAuth 2.0**:
  - Issues *access tokens*.
  - Access tokens are used to access resources (like APIs).
  - The structure of the token is implementation-dependent (can be opaque or JWT).

- **OIDC**:
  - Issues both:
    1. *ID tokens* (for identity information).
    2. *Access tokens* (for resource access).
  - ID tokens are always JSON Web Tokens (JWT) and contain user identity claims.

---

### **Endpoints**
- **OAuth 2.0**:
  - Defines endpoints like `/authorize` and `/token` for obtaining access tokens.

- **OIDC**:
  - Adds additional endpoints to OAuth 2.0:
    1. `/userinfo`: For retrieving user profile information.
    2. `.well-known/openid-configuration`: For discovering OIDC server metadata.

---

### **User Identity**
- **OAuth 2.0**:
  - Does not provide user identity or authentication.
  - Applications can only get an access token tied to a user, but they cannot verify the user’s identity.

- **OIDC**:
  - Provides user identity via the ID token.
  - Allows verifying the user's identity with claims like `sub` (subject), `email`, `name`, etc.

---

### **Use Cases**
- **OAuth 2.0**:
  - Delegated authorization for third-party applications.
  - Example: Allowing a third-party app to access your Google Calendar.

- **OIDC**:
  - Authentication and identity sharing.
  - Example: Logging into a website using your Google account.

---

### **Interdependence**
- **OAuth 2.0**:
  - Can exist independently of OIDC.
  - OIDC cannot exist without OAuth 2.0, as it builds upon it.

---

### **Summary Table**

| Feature               | OAuth 2.0                                  | OIDC                                     |
|-----------------------|--------------------------------------------|-----------------------------------------|
| **Purpose**           | Authorization framework                   | Authentication protocol built on OAuth  |
| **Tokens**            | Access tokens                             | Access tokens + ID tokens              |
| **Identity Claims**   | No                                         | Yes (via ID token)                      |
| **Endpoints**         | `/authorize`, `/token`                    | Adds `/userinfo`, discovery endpoints   |
| **Use Cases**         | API access                                | Authentication & identity (SSO)         |
| **Dependency**        | Independent                               | Depends on OAuth 2.0                    |

---

### **In Practice**
- Use **OAuth 2.0** if you only need to delegate access to resources (e.g., API access).
- Use **OIDC** if you also need to authenticate users and access their identity information.