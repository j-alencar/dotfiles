# Browser in the shot

Drive the browser with the `/playwright-cli` skill, headless.
Missing skill: `playwright-cli install --skills claude --global`.

- Use the session in `PLAYWRIGHT_CLI_SESSION`; leave other sessions alone.
- Open your own browser; `attach` and `--cdp` would hijack a user's or agent's browser.

## Browser only

Record with `playwright-cli video-start take/browser.webm --cursor`, one `video-chapter` per beat of the shot list, then `video-stop`.
Steps 1, 7 and 8 of the skill still apply; chapters replace captions.

## Beside a terminal take

The browser goes on the right at 768x1080, the terminal on the left at 1152.

```bash
screencast record take/term --width 1152 &
until [ -s take/term.start ]; do sleep 0.3; done
playwright-cli resize 768 1080
date +%s.%N > take/browser.start
playwright-cli video-start take/browser.webm --size 768x1080 --cursor
# drive both, marking beats on take/term
playwright-cli video-stop
screencast end "$Operator"; wait
```

Add `browser: take/browser.webm` to the timeline part; `edit` aligns it by `take/browser.start`.
