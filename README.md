# Verifiable Credentials schemas used in NexeraID

- The most recent and up-to-date VCs schemas are available in the [polygon-id](./polygon-id) folder.
- Schemas with uploaded jsonld to IPFS are available in the [ipfs](./ipfs) folder.

## Change Process / Testing

In order to test new vc-schemas on branch new-branch:

1. Set the version in the json schema file. -- it should probably be different than the existing to keep things super clear, though it is not necessary. The scripts will always pick the most latest import of a given type/version combination.
2. Use the github action deploy-schemas-from-branch in vc-schemas repository. Click the action, then click "Run workflow". Most of the time you can use workflow from `development` and the polygon issuer as `dev`. Change the branch name to your `new-branch`. After this runs, a new set of schemas should appear in the issuer node. It will have a time-stamped version.
3. The schema version needs to be changed in `/packages/libs/schemas/scripts/schema_version.txt` file to allow the scripts to identify the active schema. Use the version that you have just used in the action script
4. Use `pnpm run update-schemas` in the root of the monorepo to update references to schemas throughout. This same should work also at the root of the schemas package.
5. Run tests for issuer: `pnpm test:unit --filter @nexeraprotocol/vc-issuer-polygon-id`

## Legacy Testing Process

The following should not be necessary at this time, but good maybe to remember how we used to do this without the github action.

1. In json, modify the jsonld url to point to the branch url (ex: "jsonLdContext": "https://raw.githubusercontent.com/NexeraProtocol/vc-schemas/new-branch/polygon-id/id3/id3.jsonld"
   )
2. Import credential at https://amoy-issuer-node-ui-dev.nexera.id/schemas.
