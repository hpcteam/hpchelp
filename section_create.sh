#!/bin/bash

PROJECT_ROOT="$(pwd)"
DOC_ROOT="$PROJECT_ROOT/documentation"

MODE="$1"          # home | documentation
SECTION_NAME="$2"
PAGES="$3"

if [ -z "$MODE" ] || [ -z "$SECTION_NAME" ]; then
  echo "❌ Usage:"
  echo "  Home section: ./create_docs.sh home <section> \"page1 page2\""
  echo "  Doc section : ./create_docs.sh documentation <section> \"page1 page2\""
  exit 1
fi

capitalize() {
  echo "$1" | sed -E 's/(^| )([a-z])/\U\2/g'
}

SECTION_TITLE=$(capitalize "$SECTION_NAME")

# ---------------- HOME LEVEL ----------------
if [ "$MODE" = "home" ]; then

  SECTION_MD="$PROJECT_ROOT/$SECTION_NAME.md"
  SECTION_DIR="$PROJECT_ROOT/$SECTION_NAME"

  NAV_ORDER=$(ls "$PROJECT_ROOT"/*.md 2>/dev/null | wc -l)

  echo "🏠 Creating HOME section: $SECTION_TITLE"

  cat > "$SECTION_MD" <<EOF
---
title: $SECTION_TITLE
nav_order: $NAV_ORDER
has_children: true
---

$SECTION_TITLE section.
EOF

  mkdir -p "$SECTION_DIR"

  PAGE_ORDER=1
  for PAGE in $PAGES; do
    PAGE_TITLE=$(capitalize "$PAGE")
    cat > "$SECTION_DIR/$PAGE.md" <<EOF
---
title: $PAGE_TITLE
parent: $SECTION_TITLE
nav_order: $PAGE_ORDER
---

# $PAGE_TITLE
EOF
    PAGE_ORDER=$((PAGE_ORDER + 1))
  done

  echo "✅ Home section created"

# ---------------- DOCUMENTATION LEVEL ----------------
elif [ "$MODE" = "documentation" ]; then

  SECTION_DIR="$DOC_ROOT/$SECTION_NAME"
  NAV_ORDER=$(find "$DOC_ROOT" -mindepth 1 -maxdepth 1 -type d | wc -l)

  echo "📁 Creating Documentation section: $SECTION_TITLE"

  mkdir -p "$SECTION_DIR"

  cat > "$SECTION_DIR/index.md" <<EOF
---
title: $SECTION_TITLE
parent: Documentation
has_children: true
nav_order: $NAV_ORDER
---

$SECTION_TITLE documentation section.
EOF

  PAGE_ORDER=1
  for PAGE in $PAGES; do
    PAGE_TITLE=$(capitalize "$PAGE")
    cat > "$SECTION_DIR/$PAGE.md" <<EOF
---
title: $PAGE_TITLE
parent: $SECTION_TITLE
nav_order: $PAGE_ORDER
---

# $PAGE_TITLE
EOF
    PAGE_ORDER=$((PAGE_ORDER + 1))
  done

  echo "✅ Documentation section created"

else
  echo "❌ Invalid mode: use 'home' or 'documentation'"
  exit 1
fi

