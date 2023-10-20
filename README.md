# Verifiable Credentials schemas used in NexeraID

- The most recent and up-to-date VCs schemas are available in the [polygon-id](./polygon-id) folder.
- Schemas with uploaded jsonld to IPFS are available in the [ipfs](./ipfs) folder.

## Test

In order to test new vc-schemas on branch new-branch:

- in json, modify the jsonld url to point to the branch url (ex: "jsonLdContext": "https://raw.githubusercontent.com/NexeraProtocol/vc-schemas/new-branch/polygon-id/id3/id3.jsonld"
  )
- import credential in https://mumbai-issuer-node-ui-dev.nexera.id/schemas using the json
- In Nexera monorepo, change url to point to new branch in envToBranch in packages/libs/schemas/src/compliance/vc-schemas/vc-utils.ts
- run tests for issuer: `pnpm test:unit --filter @nexeraprotocol/vc-issuer-polygon-id`
