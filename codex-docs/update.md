Codex Changelog
New features, fixes, and improvements to Codex in ChatGPT

Updated over a month ago
June 13, 2025
Best of N

 

Codex can now generate multiple responses simultaneously for a single task, helping you quickly explore possible solutions to pick the best approach.

 

Fixes & improvements
Added some keyboard shortcuts and a page to explore them. Open it by pressing ⌘-/ on macOS and Ctrl+/ on other platforms.

Added a “branch” query parameter in addition to the existing “environment”, “prompt” and “tab=archived” parameters.

Added a loading indicator when downloading a repo during container setup.

Added support for cancelling tasks.

Fixed issues causing tasks to fail during setup.

Fixed issues running followups in environments where the setup script changes files that are gitignored.

Improved how the agent understands and reacts to network access restrictions.

Increased the update rate of text describing what Codex is doing.

Increased the limit for setup script duration to 20 minutes for Pro, Team, and Business users.

Polished code diffs: You can now option-click a code diff header to expand/collapse all of them.

 

June 3, 2025
Agent internet access

Now you can give Codex access to the internet during task execution to install dependencies, upgrade packages, run tests that need external resources, and more.

Internet access is off by default. Plus, Pro, and Team users can enable it for specific environments, with granular control of which domains and HTTP methods Codex can access. Internet access for Enterprise users is coming soon.

Learn more about usage and risks in the docs.

 

Update existing PRs

Now you can update existing pull requests when following up on a task.

 

Voice dictation

Now you can dictate tasks to Codex.

 

Fixes & improvements
Added a link to this changelog from the profile menu.

Added support for binary files: When applying patches, all file operations are supported. When using PRs, only deleting or renaming binary files is supported for now.

Fixed an issue on iOS where follow up tasks where shown duplicated in the task list.

Fixed an issue on iOS where pull request statuses were out of date.

Fixed an issue with follow ups where the environments were incorrectly started with the state from the first turn, rather than the most recent state.

Fixed internationalization of task events and logs.

Improved error messages for setup scripts.

Increased the limit on task diffs from 1 MB to 5 MB.

Increased the limit for setup script duration from 5 to 10 minutes.

Polished GitHub connection flow.

Re-enabled Live Activities on iOS after resolving an issue with missed notifications.

Removed the mandatory two-factor authentication requirement for users using SSO or social logins.