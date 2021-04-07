## Client

A *client* is responsible for querying all API *endpoints*, and returning *response*s from the API server.

You may instantiate a client in any one of following ways:

1. Using a pre-generated API token:

   ```crystal
   client = Cryflare.new(token: "api-token")
   ```

1. Using an account email and a pre-generated API key:

   ```crystal
   client = Cryflare.new(email: "email-address", key: "api-key")
   ```

1. Using a pre-generated user service key:

   ```crystal
   client = Cryflare.new(key: "api-key")
   ```

From here on, you are ready to query *endpoint*s using the `client` you just created.
