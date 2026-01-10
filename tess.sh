#!/bin/bash

# --------------------------------------------------
# BASIC SETUP
# --------------------------------------------------
PROJECT_ROOT="$(pwd)"

capitalize() {
  echo "$1" | sed -E 's/(^| )([a-z])/\U\2/g'
}

echo "========================================="
echo "📁 UNIVERSAL SECTION & DOC CREATOR"
echo "========================================="
echo "1) Project root section (Home-level)"
echo "2) documentation/ section"
echo "3) Custom / Nested path (absolute or relative)"
echo "4) Only create directory"
echo "5) Exit"
echo "-----------------------------------------"
read -p "Select an option [1-5]: " OPTION

# --------------------------------------------------
# SELECT LOCATION
# --------------------------------------------------
case "$OPTION" in
  1)
    CONTEXT="home"
    BASE_PATH="$PROJECT_ROOT"
    ;;
  2)
    CONTEXT="documentation"
    BASE_PATH="$PROJECT_ROOT/documentation"
    ;;
  3)
    CONTEXT="custom"
    read -p "Enter path (absolute or relative): " CUSTOM_PATH

    # ✅ FIX: detect absolute vs relative path
    if [[ "$CUSTOM_PATH" = /* ]]; then
      BASE_PATH="$CUSTOM_PATH"
      echo "🔎 Absolute path detected"
    else
      BASE_PATH="$PROJECT_ROOT/$CUSTOM_PATH"
      echo "🔎 Relative path detected (project-based)"
    fi
    ;;
  4)
    CONTEXT="dir_only"
    read -p "Enter directory path (absolute or relative): " DIR_PATH

    if [[ "$DIR_PATH" = /* ]]; then
      FINAL_DIR="$DIR_PATH"
    else
      FINAL_DIR="$PROJECT_ROOT/$DIR_PATH"
    fi

    mkdir -p "$FINAL_DIR"
    echo "✅ Directory ensured: $FINAL_DIR"
    exit 0
    ;;
  5)
    echo "👋 Exiting..."
    exit 0
    ;;
  *)
    echo "❌ Invalid option"
    exit 1
    ;;
esac

# --------------------------------------------------
# USER INPUT
# --------------------------------------------------
read -p "Enter section/directory name: " SECTION_NAME
read -p "Enter page names (space separated, optional): " PAGES

if [ -z "$SECTION_NAME" ]; then
  echo "❌ Section name cannot be empty"
  exit 1
fi

SECTION_TITLE="$(capitalize "$SECTION_NAME")"
TARGET_DIR="$BASE_PATH/$SECTION_NAME"

echo "-----------------------------------------"
echo "📌 Context       : $CONTEXT"
echo "📌 Target dir    : $TARGET_DIR"
echo "📌 Section title : $SECTION_TITLE"
echo "📌 Pages         : ${PAGES:-None}"
echo "-----------------------------------------"

# --------------------------------------------------
# CREATE DIRECTORY (SAFE)
# --------------------------------------------------
if [ -d "$TARGET_DIR" ]; then
  echo "✅ Directory already exists"
else
  echo "🛠️  Creating directory: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
fi

# --------------------------------------------------
# CREATE SECTION FILES
# --------------------------------------------------
if [ "$CONTEXT" = "home" ]; then
  SECTION_MD="$BASE_PATH/$SECTION_NAME.md"

  if [ -f "$SECTION_MD" ]; then
    echo "⚠️  Section file already exists: $SECTION_MD"
  else
    echo "📝 Creating home section file"
    cat > "$SECTION_MD" <<EOF
---
title: $SECTION_TITLE
has_children: true
---

$SECTION_TITLE home section.
EOF
  fi

else
  INDEX_FILE="$TARGET_DIR/index.md"

  if [ -f "$INDEX_FILE" ]; then
    echo "⚠️  index.md already exists"
  else
    echo "📝 Creating index.md"
    cat > "$INDEX_FILE" <<EOF
---
title: $SECTION_TITLE
parent: Documentation
has_children: true
---

$SECTION_TITLE documentation section.
EOF
  fi
fi

# --------------------------------------------------
# CREATE PAGES
# --------------------------------------------------
PAGE_ORDER=1
for PAGE in $PAGES; do
  PAGE_FILE="$TARGET_DIR/$PAGE.md"
  PAGE_TITLE="$(capitalize "$PAGE")"

  if [ -f "$PAGE_FILE" ]; then
    echo "⚠️  Page already exists: $PAGE_FILE"
  else
    echo "📄 Creating page: $PAGE_FILE"
    cat > "$PAGE_FILE" <<EOF
---
title: $PAGE_TITLE
parent: $SECTION_TITLE
nav_order: $PAGE_ORDER
---

# $PAGE_TITLE
EOF
  fi

  PAGE_ORDER=$((PAGE_ORDER + 1))
done

# --------------------------------------------------
# SUMMARY
# --------------------------------------------------
echo "========================================="
echo "✅ OPERATION COMPLETED SUCCESSFULLY"
echo "📍 Created at : $TARGET_DIR"
echo "📂 Context   : $CONTEXT"
echo "📄 Pages     : ${PAGES:-None}"
echo "========================================="

