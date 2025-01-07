## OAuth
A summary of the article [its time for oauth 2.1](https://aaronparecki.com/2019/12/12/21/its-time-for-oauth-2-dot-1).

OAuth is actually made of many different RFCs (Request For Comments), building upon each other and adding
features in different ways. 

The "core" OAuth spec, RFC 6749, isn't called a specification, it's technically
a "framework" you can use to build specifications from. Part of the reason for this is because it leaves a lot
of things optional, and requires that an implementer makes decisions about things like which grant types to 
support, whether or not refresh tokens are one-time use, and even whether access tokens should be Bearer tokens
or use some sort of signed token mechanism.