# pgsql-test + Drizzle Integration

<p align="center">
  <img src="https://raw.githubusercontent.com/launchql/launchql/refs/heads/main/assets/outline-logo.svg" width="250"><br />
    Drizzle ORM with pgsql-test
</p>

This package demonstrates how to integrate [Drizzle ORM](https://orm.drizzle.team/) with [pgsql-test](https://www.npmjs.com/package/pgsql-test) for fast, isolated PostgreSQL testing.

## Overview

`pgsql-test` provides isolated PostgreSQL databases for testing with transaction-based cleanup. By combining it with Drizzle, you get:

- Fast test execution with transaction-based isolation
- Proper cleanup between tests
- Full Drizzle ORM capabilities in your tests
- Type-safe database queries

## Example

See `__tests__/basic.test.ts` for a complete example. The key pattern is:

```typescript
import { drizzle } from 'drizzle-orm/node-postgres';
import { getConnections, PgTestClient } from 'pgsql-test';

let db: PgTestClient;
let pg: PgTestClient;
let teardown: () => Promise<void>;

beforeAll(async () => {
  ({ pg, db, teardown } = await getConnections());
});

afterAll(async () => {
  await teardown();
});

beforeEach(async () => {
  await db.beforeEach();
});

afterEach(async () => {
  await db.afterEach();
});

describe('your tests', () => {
  it('should work', async () => {
    const drizzleDb = drizzle(db);
    const result = await drizzleDb.execute('select 1 as num');
    expect(result.rows[0].num).toBe(1);
  });
});
```


## Running Tests

```sh
pnpm test
# or
pnpm test:watch
```

## Credits

🛠 Built by LaunchQL — if you like our tools, please checkout and contribute to [our github ⚛️](https://github.com/launchql)


## Disclaimer

AS DESCRIBED IN THE LICENSES, THE SOFTWARE IS PROVIDED “AS IS”, AT YOUR OWN RISK, AND WITHOUT WARRANTIES OF ANY KIND.

No developer or entity involved in creating this software will be liable for any claims or damages whatsoever associated with your use, inability to use, or your interaction with other users of the code, including any direct, indirect, incidental, special, exemplary, punitive or consequential damages, or loss of profits, cryptocurrencies, tokens, or anything else of value.
