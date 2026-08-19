# Contributing

Thanks for contributing to the **Karukera Security Kit** (open source).

## Ground rules

1. **Authorized targets only** — never use this kit against systems you do not own or lack written authorization for.
2. **No exploit payloads / attack PoCs** in PRs. Defensive findings, configs, and fix prompts only.
3. **Never commit secrets** — API keys, tokens, `.env`, customer reports with sensitive data.
4. Prefer small PRs with a clear problem statement and how you tested.

## Local use

Start at `START-HERE.md`, then `USAGE.md`. Follow `RULES/` 00→07 before running agents.

## Pull requests

- Describe the change and test steps.
- Update `CHANGELOG.md` for user-visible changes.
- Do not weaken anti-injection or authorization gates without an explicit design discussion.

## Security issues

See [SECURITY.md](./SECURITY.md).
