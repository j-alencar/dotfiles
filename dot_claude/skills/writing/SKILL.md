---
name: writing
description: write documents, commits, issue tracking elements
---

## When to use

Use this skill when you need to write documents, commits, issue tracking elements, drafts

## Writing in general

Prefer correction and deletion over "additions of negatives". If we you discover something is not right, don't concatenate a "this is wrong, we do it like this" comment. Just correct the original.

I may not like the way you write prose, in general. If you notice a sudden edit it was me not resisting to edit. I'm write-heavy, so don't keep a cache or anything like that.

### Technical Writing

Be aware that D.R.Y applies to technical prose too and avoid writing debt. Take a Github Issue, for instance: it has a structure due to the first body and, later, the comments -- it forms a thread. Internally in this issue, you don't need to add summary tables of things if they're already linked via the structure of the issue's thread. Another example: don't say, for instance, "this has these four ADRs" when your list already lists them. These things change quite quickly and it's annoying to have to edit them.

Don't add things specific to the session, like Claude artifact links, file paths, the name of the environment you're testing in etc., unless it's relevant. The exceptions to this would be listing hardware info when doing a task about performance, or a specific bug or feature that may vary per machine.

When doing technical writing in English (usually, things related to a repository, or any subsections of this section), do a pass via the `/ste-writing` skill once you believe you're finished.

#### Markdown

A `README.md` is not paragraphs of explanation of what the code does. It's the face of the project or repo, and should be understandable for someone who's new to it.

When writing Markdown files, use [Semantic Line Breaks](https://sembr.org/)*

When separating non-continuing thoughts, prefer breaking the Markdown line like I did here (see the break above?)*

(*) *except when you're in Github Issues, where those don't behave like normal Markdown*

#### Commits

- Use the [Karma Commit Convention](https://gist.github.com/fil-lewis-barclay/746e7563808d38400b89) and keep it short and sweet.
- Don't try to truncate the message to get around the character limit for Karma. If you feel something important didn't fit in the commit message, you can do it in the last part of the PR description.
- The entire commit message must be in an imperative mood using the bare infinitive:
  - EN: `feat(...): migrate user authentication...`
  - PT: `feat(...): migrar autenticação de usuário...`
- Don't just add anything in the scope of a commit (type(scope)). Use common things like "db", "integrations", "ui", "logging", "errors", "api", etc. or proeminent domain names that are close to ubiquitous language in the codebase.
- Don't name branches or code-related stuff after Issue numbers or titles.

#### Issue Writing

Use the site's features: don't add comments in a an issue tracker to say that it's blocked by another. They have relationships built into the site. However, do comment on it if there is nuance on the relationship and it needs explicit clarification (like a block being "soft", for instance).

Remember that our session and the issue tracking are separate things:
  - don't add clarifications as decisions we made along the session that nobody would have thought of going with in the first place
  - if you DO need to add something, always remember that you're writing for other people and they have no idea (and should not have) of the session. It's expected for it to be abstracted and heavily diluted once materialized in the issue

#### Warning on coding vices

- Don't append implementation specifics to things that don't need it. If asked to make `foo()` work via ABC, don't add "via ABC" to the docstring or the function signature. Likewise, comments and docstrings of an implementation shouldn't mention its interface, if it has one.

- Don't add comments that only restate code in prose. Comment only to explain non-obvious decisions.

- If you are a smart model (Opus, GPT and above) you probably parenthesize without necessity, like I did here. It's fine in conversation, but revise comments and Markdown files for parentheses you introduced and remove them.

- Use the shortest accurate name for things. Do not make implementation details part of a term. Do not coin new compound nouns unless I define them first. Example:

  Bad:
  >the age-encrypted secret
  >
  >the age secret flow
  >
  >the age-backed secret payload
  >
  >the age-based decryption path

  Good:
  >the encrypted secret
  >
  >the decryption of the secret

 We only picked `age` as the binary we would use. It's not that important. The decryption is important.
