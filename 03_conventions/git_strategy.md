# Git Branching Strategy

So many ways are the right way to do Git branching that it seems that whatever you choose, you choose wrong, or at least one right among the other "n" right
choices.

Whatever choice... it can always be put in perspective and end up being the "wrong" choice for some.

It seems that even language choices are easier to make than Git branching strategies, as every dev will have the "truth" here.

## GitHub flow (momentarily)

### TL/DR:

In a GitHub Flow strategy, there is a main branch and short-lived branches for whatever work that will be later merged to the main branch.

For a detailed explanation, you can check GitHub's own documentation: [GitHub flow documentation](https://docs.github.com/en/get-started/quickstart/github-flow)

### How GitHubFlow is applied at BareMetalCode:

#### High-level view

GitHubFlow is applied by using the main branch as the production-ready code and short-lived branches for feature development, bug fixes, and
other tasks.

Once the work in a branch is completed, the branch is merged back to the main branch, and the feature or bug fix is released to the users.

## Why

It is a fast strategy, easy to understand and to follow.

Because of the nature of the project, this strategy fits well into the modular independent nature of microservices.

The low overhead of having short-lived "work branches" is a good balance in speed and safety as opposed to having cascading long-lived branches
(prod/stage/test/dev) or direct to trunk approaches.

It allows a quality / safety "gate" to happen on the short-lived branches and avoids the multiple deployment to long-lived environment-based branches approach.

## How

Below are explained the most common to the most conflicting cases.

### Simplest case: One developer works on some feature

1. create a branch from `main`
2. work on the given branch
3. merge the branch back to `main`

```mermaid
gitGraph:
    commit id: "create new branch" tag: "version 1.0.4"
    branch john/ticket_123/update_framework
    checkout john/ticket_123/update_framework
    commit id: "I did some work"
    commit id: "And I did another thing"
    commit id: "And I polished some details"
    checkout main
    merge john/ticket_123/update_framework id: "Merge into main" tag: "version 1.0.5"
```

### Simplest case: One developer works on some feature

1. create a branch from `main`
2. work on the given branch
3. merge the branch back to `main`

```mermaid
gitGraph:
    commit id: "new branch 01"
    branch developer_name/ticket_id/mini_description
    checkout developer_name/ticket_id/mini_description
    commit id: "I did some work"
    commit id: "And I did another thing"
    checkout main
    commit id: "new branch 02"
    branch hotfix/urgent_fix
    checkout hotfix/urgent_fix
    commit id: "And added more stuff"
    commit id: "Added final touches"
    checkout main
    merge hotfix/urgent_fix id: "Merge hotfix into main" tag: "version 1.1.6"
    checkout developer_name/ticket_id/mini_description
    merge main id: "Merge main into feature branch"
    commit id: "I did some work plus"
    commit id: "And I did another thing plus"
    checkout main
    merge developer_name/ticket_id/mini_description id: "Merge into main" tag: "version 1.0.5"
```

## What's Next

## References

- [GitHub flow documentation](https://docs.github.com/en/get-started/quickstart/github-flow)