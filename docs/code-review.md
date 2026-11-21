# Automated code review on pull requests

A pull request's checks list shows results from three kinds of sources. Only the first one is GitHub Actions.

| Source | Example | How it is set up | Where it runs |
|---|---|---|---|
| GitHub Actions jobs | `CI-1 / kavi-job-1`, `CI-1 / kavi-docker-job-1` | YAML files in `.github/workflows/` | GitHub's runners |
| GitHub features | CodeQL code scanning | Switched on in repository settings, no file | GitHub |
| GitHub Apps | CodeRabbit, other review bots | Installed on the account or organization once | The app's own servers |

A check row's name follows `workflow name / job name (event)` for GitHub Actions jobs. App checks show the app's name only.

## CodeRabbit in this repository

- Installed as a GitHub App on the `kaviyarasanss` account. No workflow or code is needed for it to run.
- A `.coderabbit.yaml` file in the repository root is optional and only changes review settings (for example how strict the review is, or which base branches get reviewed). This repository uses the defaults.
- GitHub notifies CodeRabbit when a pull request is opened and when new commits are pushed to it. CodeRabbit then posts a summary, line comments and a `CodeRabbit` check row.
- A commit or a push to a branch without a pull request does not trigger a review.

## Reporting vs blocking

| Check | Reports | Blocks the merge |
|---|---|---|
| `kavi-job-1`, `kavi-docker-job-1` | Yes | Yes, they are required checks in the `protect-main` ruleset |
| CodeRabbit | Yes, comments and a check row | Only if its check is added to the required checks, or if it requests changes on a branch that requires approvals |

In this repository CodeRabbit reports only; the decision to act on a finding stays with the author and reviewers.
