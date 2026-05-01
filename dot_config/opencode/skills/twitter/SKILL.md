---
name: twitter
description: Read-only Twitter/X lookup for tweets, users, replies, engagement, and trends.
license: MIT
compatibility: opencode
metadata:
  source: starchild-ai-agent/official-skills
  upstream: https://skills.sh/starchild-ai-agent/official-skills/twitter
---

## When to use

Use this skill when you need to research current discussion on Twitter/X, including:

- searching tweets about a topic
- looking up user profiles and recent tweets
- checking replies, retweeters, and quote tweets
- getting trending topics

## Key constraints

- Treat this as read-only research guidance.
- Prefer direct tweet/user lookups over webpage scraping.
- Use at most a few targeted lookups, then summarize.
- Avoid pagination unless explicitly requested.

## Core workflow

1. Convert user question into a focused search query.
2. Fetch the smallest necessary result set.
3. Extract evidence (tweet/user IDs, counts, timestamps).
4. Summarize sentiment and concrete claims.
5. Report confidence and any data gaps.

## References

- https://skills.sh/starchild-ai-agent/official-skills/twitter
