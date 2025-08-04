# PGSchema GitHub Actions Example

This repository demonstrates how to use [pgschema](https://www.pgschema.com/) with GitHub Actions to automatically run schema migration plans on pull requests. It includes examples for both single-file and multi-file schema approaches.

## Overview

This repository contains two workflows:
1. **Single File Workflow** - For projects with all schema definitions in one file
2. **Multi File Workflow** - For projects with schema split across multiple SQL files

Both workflows automatically:
- Run `pgschema plan` when a PR modifies schema files
- Post the migration plan as a comment on the PR
- Update the comment if the PR is synchronized with new changes

## Setup

### 1. Required GitHub Secrets

Configure the following secrets in your repository settings:

- `DB_HOST` - PostgreSQL database host (default: localhost)
- `DB_PORT` - PostgreSQL database port (default: 5432)
- `DB_NAME` - Database name
- `DB_USER` - Database username
- `DB_PASSWORD` - Database password

### 2. Schema Organization

#### Single File Approach
- Place your complete schema in `singlefile/schema.sql`
- All tables, indexes, functions, and triggers in one file
- Workflow: `.github/workflows/pgschema-plan-single.yml`

#### Multi File Approach
- Place SQL files in the `multifile/` directory
- Uses `main.sql` as the entry point with psql `\i` directives
- Organize files by type in subdirectories (tables/, functions/, views/, etc.)
- Each file contains a specific database object
- Workflow: `.github/workflows/pgschema-plan-multi.yml`

## Usage

1. Choose your schema approach (single file or multi file)
2. Create or update schema files in the appropriate directory
3. Open a pull request
4. The relevant workflow will automatically run and comment with the migration plan
5. Review the plan to understand what changes will be applied
6. The comment will be updated if you push more changes to the PR

## Example Schemas

### Single File Example
See `singlefile/schema.sql` for a complete schema with:
- Users and posts tables
- Foreign key relationships
- Indexes for performance
- Triggers for auto-updating timestamps

### Multi File Example
See `multifile/` directory for a comprehensive schema organization:
- `main.sql` - Entry file using psql `\i` directives to include other files
- `domains/` - Custom domain types (email_address, positive_integer)
- `types/` - Custom types (address, order_status, user_status)
- `sequences/` - Sequence definitions (global_id_seq, order_number_seq)
- `tables/` - Table definitions (users, orders)
- `functions/` - Database functions (get_user_count, update_timestamp)
- `procedures/` - Stored procedures (cleanup_orders, update_status)
- `views/` - Database views (order_details, user_summary)

This structure demonstrates how to organize complex schemas across multiple files and directories.

## Security Notes

- Database credentials are stored as encrypted GitHub secrets
- The workflow only has read access to your database (it runs `plan`, not `apply`)
- Consider using a read-only database user for additional security

## Next Steps

To apply migrations, you would typically:
1. Review and approve the PR
2. Run `pgschema apply` in your deployment pipeline
3. Consider using `--auto-approve` flag for automated deployments

For more information, visit the [pgschema documentation](https://www.pgschema.com/).