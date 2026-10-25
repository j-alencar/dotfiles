---
name: dbml
description: Write and render database ERDs in DBML to jpg.
---

# DBML

Tool: [dbml-toolkit](https://github.com/jason-cairns/dbml-toolkit). If `dbml` is missing:

```bash
go install github.com/jason-cairns/dbml-toolkit/cmd/dbml@latest
```

## Source

- Save as `<name>.dbml`
- Format before rendering: `dbml fmt -w <name>.dbml`

## Render

Edges animate by default; disable for static images:

```bash
dbml render -animate=false -o <name>.svg <name>.dbml
npx -y sharp-cli@5 -i <name>.svg -o <name>.jpg --density 192
rm <name>.svg
```

Large schemas: try `-detail keys` or `-detail tables`. If the D2 layout tangles, try `-engine graphviz`.

## Check

Done when the jpg has no crossed or overlapping edges, no clipped or off-canvas tables, and every column is readable. With vision, open the jpg and check. Otherwise, `dbml render -format ascii <name>.dbml` gives a rough terminal view. On failure, change `-detail` or `-engine`, or split the schema, then re-render.

## Commit

Commit `<name>.dbml` and `<name>.jpg` side by side.
