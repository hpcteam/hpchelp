#!/bin/bash

DOC_ROOT="documentation"

SECTION_NAME="$1"
PAGES="$2"

if [ -z "$SECTION_NAME" ]; then
  echo "❌ Section name required"
  echo "Usage: ./create_docs.sh <section-name> \"page1 page2 page3\""
  exit 1
fi

SECTION_DIR="$DOC_ROOT/$SECTION_NAME"

# Capitalize function
capitalize() {
  echo "$1" | sed -E 's/(^| )([a-z])/\U\2/g'
}

SECTION_TITLE=$(capitalize "$SECTION_NAME")

# Count existing sections for nav_order
SECTION_ORDER=$(find "$DOC_ROOT" -maxdepth 1 -type d | wc -l)

echo "📁 Creating section: $SECTION_TITLE"

mkdir -p "$SECTION_DIR"

INDEX_FILE="$SECTION_DIR/index.md"

# Create index.md
cat > "$INDEX_FILE" <<EOF
---
title: $SECTION_TITLE
parent: Documentation
has_children: true
nav_order: $SECTION_ORDER
---

$SECTION_TITLE documentation section.
EOF

echo "✅ Created index.md"

# Create pages if provided
PAGE_ORDER=1
for PAGE in $PAGES; do
  PAGE_FILE="$SECTION_DIR/$PAGE.md"
  PAGE_TITLE=$(capitalize "$PAGE")

  cat > "$PAGE_FILE" <<EOF
---
title: $PAGE_TITLE
parent: $SECTION_TITLE
nav_order: $PAGE_ORDER
---

# $PAGE_TITLE

Documentation for $PAGE_TITLE.
EOF

  echo "📄 Created page: $PAGE_TITLE"
  PAGE_ORDER=$((PAGE_ORDER + 1))
done

# Summary
SECTION_COUNT=$(find "$DOC_ROOT" -mindepth 1 -maxdepth 1 -type d | wc -l)
PAGE_COUNT=$(find "$SECTION_DIR" -type f | wc -l)

echo "----------------------------------"
echo "📊 Summary"
echo "Sections total : $SECTION_COUNT"
echo "Pages in $SECTION_TITLE : $PAGE_COUNT"
echo "----------------------------------"

