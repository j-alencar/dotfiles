---
name: writing
description: write documents, commits, issue tracking elements
---

## When to use

Use this skill when you need to write documents, commits, issue tracking elements, drafts

## Writing in general

### Surgery over "concatenation of negatives"

If you discover something is not right, don't concatenate a "this is wrong, we do it like this" comment. Just correct the original. Remove a little, add a little.

### I may not like the way you write prose, in general

If you notice a sudden edit it was me not resisting to edit. I'm write-heavy, so don't keep a cache or anything like that.

### Technical writing

Be aware that D.R.Y applies to technical writing too, so avoid writing debt.

#### Platform as a prose harness

Your platform of prose artifacts can give you many benefits that make writing debt less likely to happen, but you need to use them.

Take a Github Issue, for instance:
  - it has a structure due to the one body and, then, the comments -- it forms a thread. People read from bottom to top if they want to look at what's new. Internally in this issue, you don't need to add summary tables of things if they're already explicitly linked via the structure of the thread. If you were to do that, you would need to keep updating the table, which no one will read, since they read from bottom to top.
  - you don't need to add prose in a an issue tracker to say that it's blocked by another. Issue trackers have relationships built into the site.
    * However, do comment on it if there is nuance on the relationship and it needs explicit clarification (like a block being "soft", for instance).
  - you don't need to say that you've updated the prose in a comment or a body, since it already has a revision feature.

Or, Markdown files in a repository:
  - Instead of using prose to reference a section in another file, in the same file you're in, why not just use Markdown's native hyperlinks? "See [section-foo-of-that-file](section-foo-of-that-file)" Now it's easier to edit.
  - Or a markdown numbered list: if you index every item as "0.", the whole list will render in Markdown Preview every time as 0, 1, 2, 3 and so on. Now it's easier to edit.

In prose artifacts, don't add things specific to the session or its environment, like Claude artifact links, Claude session URLs, file paths, the name of the environment you're testing in etc., unless it's relevant. The exceptions to this would be listing hardware info when doing an Issue or PR about performance or specific bug/feature that varies per platform.

When doing technical writing in English, do a pass of the `/ste-writing` skill once you believe you're finished*.

(*) *not necessary if you're an OpenAI model*

#### Markdown

A `README.md` is not paragraphs of explanation of what the code does. It's the face of the project or repo, and should be understandable for someone who's new to it.

When writing Markdown files, use [Semantic Line Breaks](https://sembr.org/)*.

When separating non-continuing thoughts, prefer breaking the Markdown line like I did here (see the break above?)*.

(*) *except when you're in Github Issues, where those don't behave like normal Markdown*

#### Commits

- Use the [Karma Commit Convention](https://gist.github.com/fil-lewis-barclay/746e7563808d38400b89) and keep it short and sweet.
- The entire commit message must be in an imperative mood using the bare infinitive:
  - EN: `feat(auth): migrate user authentication...`
  - PT: `feat(auth): migrar autenticação de usuário...`
- Don't name branches or code-related stuff after Issue numbers or titles.

#### More "don't"s

- Comments and docstrings of an implementation shouldn't mention its interface, if it has one.

- Don't append implementation specifics to things that don't need it. If asked to make `foo()` work via driver `bar`, don't add "via driver bar" to the docstring or the function signature.

- Don't add comments that only literally restate code in prose. Comment only to explain non-obvious decisions.

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
