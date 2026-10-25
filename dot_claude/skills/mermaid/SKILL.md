---
name: mermaid
description: Write and render Mermaid diagrams (flowcharts, architecture, sequence, state) to jpg.
---

# Mermaid

## Source

- Save as `<name>.mmd`
- Use ELK layout for flowcharts, and for any diagram that renders tangled:

    ```
    ---
    config:
      layout: elk
    ---
    flowchart TD
      A --> B
    ```

## Render

Mermaid SVGs put labels in `foreignObject`, which SVG rasterizers drop. Go through PNG:

```bash
npx -y @mermaid-js/mermaid-cli@11 -q -i <name>.mmd -o <name>.png -s 2 -b white
npx -y sharp-cli@5 -i <name>.png -o <name>.jpg
rm <name>.png
```

## Check

Done when the jpg has no crossed or overlapping edges, no clipped or off-canvas nodes, and every label is readable. With vision, open the jpg and check. Otherwise, keep the diagram small enough to reason about. On failure: add ELK, split the diagram, or regroup with `subgraph`, then re-render.

## Commit

Commit `<name>.mmd` and `<name>.jpg` side by side.
