# Contributing to Sanguine Host

Sanguine Host is maintained by Lucas Rose-Winters
([@paperboygold](https://github.com/paperboygold)). This policy applies to every repository in the
[sanguinehost](https://github.com/sanguinehost) organisation that does not have its own
`CONTRIBUTING.md`. Where a repository has its own policy, the stricter rule applies.

## Merge rights

Only @paperboygold holds human write, merge, release, and administrative rights. No other person or
team is granted those rights by contributing, reviewing, sponsoring, or discussing the work. A pull
request is a proposal. It does not transfer ownership, decision rights, or access. The maintainer may
accept, revise, defer, or close a pull request without giving a reason.

The maintainer may install automation, such as a coding agent, with write access. That automation acts
on his instruction. It does not hold independent merge rights, and its access is revoked when it is no
longer needed.

Contributors work from a fork and open a pull request against the default branch. Do not push to a
repository you do not own. Access is granted per repository, is revocable at any time, and creates no
employment, partnership, agency, equity, or right to continued access.

## Before you write code

- Open an issue for anything larger than a small fix. Agree the problem and the approach first.
- Keep a pull request to one concern. Include the tests, documentation, and receipt or benchmark that
  the change needs.
- Read the repository's `AGENTS.md`, `README.md`, and build instructions. They are part of the
  contribution terms.
- Do not include secrets, personal data, or code you do not have the right to submit.

## Sign your work

Every commit must carry a `Signed-off-by` line certifying the
[Developer Certificate of Origin 1.1](https://developercertificate.org/):

```text
Signed-off-by: Your Name <you@example.com>
```

Use `git commit -s`. The sign-off states that you wrote the contribution, or have the right to submit
it, and that you agree to the licence terms below. Do not sign work you did not write or cannot
license.

## Licensing

Contributions are accepted under the repository's existing `LICENSE` (inbound = outbound). You keep
copyright in your contribution; you do not assign it. No separate contributor agreement is required
beyond the DCO and this policy.

If a repository has no `LICENSE`, do not submit code. Open an issue and ask for the terms first.

Do not submit code copied from a repository with an incompatible licence. If you use generated code,
you are responsible for its provenance and for checking that it can be contributed under these
terms. Disclose the tool and the extent of generation in the pull request.

## Security

Report a suspected vulnerability privately to the maintainer, not in a public issue. If the repository
has a `SECURITY.md`, follow it. Do not open a public pull request that demonstrates an unfixed
vulnerability.

## Review and conduct

Review is technical and direct. Harassment, threats, doxxing, and sustained disruption are not
accepted. The maintainer may close a contribution or block an account without notice. Disagreement
about the code is welcome. Entitlement to a merge is not.

## Enforcement

- Organisation membership is limited to the maintainer. There are no outside collaborators and no
  teams with repository access.
- Every maintained, non-fork repository carries a `.github/CODEOWNERS` file naming `@paperboygold`.
- Where the GitHub plan supports branch rules, the default branch requires a pull request and
  code-owner review, blocks force pushes and deletion, and gives the maintainer the only bypass.
- On the current GitHub Free plan, private repositories do not have branch rules. There the control is
  repository permission: only @paperboygold has write or admin access. New collaborators receive
  read-only access, and merge rights require an explicit change to this policy.
- The maintainer audits members, outside collaborators, teams, deploy keys, and app installations
  before granting access and after any access change.
- Forks of upstream projects are not maintained here. Send changes upstream. This policy does not
  grant rights in a fork.

This policy is effective 2026-10-18. Only the maintainer may change it. The canonical copy is this
file: <https://github.com/sanguinehost/.github/blob/main/CONTRIBUTING.md>.
