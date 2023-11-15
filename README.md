# Verifiable Credentials schemas used in NexeraID

- The most recent and up-to-date VCs schemas are available in the [polygon-id](./polygon-id) folder.
- Schemas with uploaded jsonld to IPFS are available in the [ipfs](./ipfs) folder.

## Test

In order to test new vc-schemas on branch new-branch:

1. Legacy method: in json, modify the jsonld url to point to the branch url (ex: "jsonLdContext": "https://raw.githubusercontent.com/NexeraProtocol/vc-schemas/new-branch/polygon-id/id3/id3.jsonld"
   )
2. Legacy method: import credential in https://mumbai-issuer-node-ui-dev.nexera.id/schemas.
3. Alternatively to 1 & 2: just use the github action detailed below to save schema to ipfs with a special timestamped version.
4. Use the github action deploy-schemas-from-branch in vc-schemas repository. Click the action, then click "Run workflow". Most of the time you can use workflow from `development` and the polygon issuer as `dev`. Change the branch name to your `new-branch`. After this runs, a new set of schemas should appear in the issuer node. It will have a time-stamped version.
5. change the version that the vc-schemas `download-schemas` script is calling in the `package.json` then use `pnpm run update-schemas` in the root of the monorepo -- or the vc-schemas package.
6. In Nexera monorepo, change url to point to new branch in `packages/libs/schemas/src/compliance/vc-schemas/json_schema_map.json`
7. run tests for issuer: `pnpm test:unit --filter @nexeraprotocol/vc-issuer-polygon-id`
