**Committing Changes**

- **Small, atomic commits:** Focus each commit on a single, logical change. This improves change history readability and makes it easier to revert if needed.
- **Clear commit messages:** Write informative commit messages in the imperative present tense (e.g., "Add validation logic," "Fix error in calculation"). Include a brief summary and a more detailed explanation if necessary.
- **Reference issues:** If your commits address specific issues or tickets, include their IDs in your commit message (e.g., "#123" to link to issue number 123).

**Raising Pull Requests**

- **Complete work units:** Ensure your PR contains a cohesive set of changes that represent a logical feature or fix. Avoid partial implementations.
- **Descriptive titles:** Provide clear and concise PR titles that summarize the overall change.
- **Comprehensive descriptions:** Provide context in the PR description, explaining the problem solved, rationale behind choices, and any potential implications.
- **Link to issues:** Similarly to commit messages, reference any relevant issues in your PR description.
- **Request reviews:** Assign reviewers who have relevant context and knowledge to provide feedback.

**Additional Best Practices**

- **Review your own code:** Before submitting a PR, carefully review your changes to catch potential errors or improvements.
- **Utilize branches:** Use feature branches to isolate changes, enabling parallel development without disrupting the main branch.
- **Squash and rebase (if applicable):** If your feature branch accumulates many small commits, consider squashing them into fewer, meaningful commits and rebasing to a clean history before merging. This depends on your team's preferences.
- **Draft pull requests:** If you want early feedback, utilize GitHub's "Draft Pull Request" feature to signal work in progress.
- **Continuous integration (CI):** Set up CI pipelines to automatically run tests and checks on your pull requests, helping to catch errors early.

**Example Workflow**

1. Create a feature branch (`git checkout -b feature/new-login-form`)
2. Make focused commits (`git commit -m "Add new login form fields"`)
3. Push to your remote branch (`git push origin feature/new-login-form`)
4. Open a pull request on GitHub/GitLab/etc.
5. Provide a clear title, description, and reference any relevant issues.
6. Request code review from teammates.
7. Address feedback and make changes as needed.
8. Once approved, merge the pull request into the main branch.

#todo Check if "**Squash and rebase (if applicable):** If your feature branch accumulates many small commits, consider squashing them into fewer, meaningful commits and rebasing to a clean history before merging. This depends on your team's preferences." is needed when during PRs via Azure DevOps