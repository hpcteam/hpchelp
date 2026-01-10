#!/bin/bash

PROJECT_ROOT="$(pwd)"

capitalize() {
  echo "$1" | sed -E 's/(^| )([a-z])/\U\2/g'
}

echo "================================="
echo "📘 EASY DOCS CREATOR"
echo "================================="
echo "1) 📁 Create Section"
echo "2) 📄 Create File (page)"
echo "3) ❌ Exit"
echo "---------------------------------"
read -p "Choose option [1-3]: " ACTION

[ "$ACTION" = "3" ] && exit 0

# ---------------- ICON PICKER ----------------
echo ""
echo "Choose an icon:"
echo "1) 📜 Scripts"
echo "2) 🐧 Linux"
echo "3) 👤 User"
echo "4) 🚀 HPC"
echo "5) 🧬 Git"
echo "6) 🌐 Network"
echo "7) ✏️  No icon"
read -p "Select icon [1-7]: " ICON_CHOICE

case "$ICON_CHOICE" in
  1) ICON="📜";;
  2) ICON="🐧";;
  3) ICON="👤";;
  4) ICON="🚀";;
  5) ICON="🧬";;
  6) ICON="🌐";;
  *) ICON="";;
esac

# ---------------- LOCATION ----------------
echo ""
echo "Where do you want to create?"
echo "1) Project root (Home)"
echo "2) documentation/"
echo "3) Custom path"
read -p "Select location [1-3]: " LOCATION

case "$LOCATION" in
  1) BASE_PATH="$PROJECT_ROOT";;
  2) BASE_PATH="$PROJECT_ROOT/documentation";;
  3)
     read -p "Enter path (absolute or relative): " CUSTOM_PATH
     [[ "$CUSTOM_PATH" = /* ]] && BASE_PATH="$CUSTOM_PATH" || BASE_PATH="$PROJECT_ROOT/$CUSTOM_PATH"
     ;;
  *) echo "❌ Invalid location"; exit 1;;
esac

# ---------------- SECTION ----------------
read -p "Enter section/file name: " NAME
TITLE="$(capitalize "$NAME")"

# ---------------- CREATE SECTION ----------------
if [ "$ACTION" = "1" ]; then
  TARGET_DIR="$BASE_PATH/$NAME"

  mkdir -p "$TARGET_DIR"

  if [ "$BASE_PATH" = "$PROJECT_ROOT" ]; then
    FILE="$BASE_PATH/$NAME.md"
    PARENT=""
  else
    FILE="$TARGET_DIR/index.md"
    PARENT="Documentation"
  fi

  echo "🛠️  Creating section at $TARGET_DIR"

  cat > "$FILE" <<EOF
---
title: $ICON $TITLE
${PARENT:+parent: $PARENT}
has_children: true
---

$TITLE section.
EOF

  echo "✅ Section created: $ICON $TITLE"
fi

# ---------------- CREATE FILE ----------------
if [ "$ACTION" = "2" ]; then
  read -p "Enter parent section title (exact): " PARENT
  FILE="$BASE_PATH/$NAME.md"

  cat > "$FILE" <<EOF
---
title: $ICON $TITLE
parent: $PARENT
---

# $ICON $TITLE
EOF

  echo "✅ File created: $FILE"
fi

echo "================================="
echo "🎉 DONE"
echo "================================="

