---
description: Pick an image from gallery and analyze it
argument-hint: [what to analyze, optional]
---

Open the Android file picker so the user can select an image, then analyze it.

Steps:
1. Run this bash command to open the Android file picker:
   `termux-storage-get ~/claude_picked_image`
   Wait for it to complete (user will pick a file in the Android UI).
2. Read the file at `~/claude_picked_image` using the Read tool.
3. Analyze the image based on the user's request: $ARGUMENTS

If no specific request was given in $ARGUMENTS, describe what you see in the image in detail.
After analysis, delete the temp file: `rm -f ~/claude_picked_image`
