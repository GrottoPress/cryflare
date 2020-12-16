## Getting Started

*Cryflare* is a low-level API client for *Cloudflare&reg;* v4. It features an intuitive interface that maps perfectly to the *Cloudflare* API.

### Architecture

*Cryflare*'s architecture revolves around the following concepts:

1. ##### Client:

   A *Client* is responsible for querying all API *Endpoint*s, and returning *Response*s from the API server.

1. ##### Endpoint

   An *Endpoint* is a queryable path exposed by the API server, that returns a response.
   
   In *Cryflare*, an endpoint represents a single resource endpoint, with methods that operation on its individual sub-endpoints.

1. ##### Response:

   A *Response* is *Cryflare*'s representation of the raw response received from the API server. It is a type-safe wrapper around the JSON response object.

   A *Response* may contain a `result`, which may be an *Item* (a single resource object), or a *List* (an array of resource objects)

### Requirements

*Crystal* **v0.35.0** or newer: Learn to install Crystal [here »](https://crystal-lang.org/install/)

### References

- [*Cloudflare* API](https://api.cloudflare.com)
