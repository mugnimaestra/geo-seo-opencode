#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# GEO-SEO OpenCode Skill Uninstaller
# ============================================================

OPENCODE_DIR="${HOME}/.config/opencode"
SKILLS_DIR="${OPENCODE_DIR}/skills"
AGENTS_DIR="${OPENCODE_DIR}/agents"
COMMANDS_DIR="${OPENCODE_DIR}/command"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${YELLOW}GEO-SEO OpenCode Skill Uninstaller${NC}"
echo ""
echo "This will remove the following:"
echo ""

# List what will be removed
[ -d "$SKILLS_DIR/geo" ] && echo "  → ${SKILLS_DIR}/geo/"
for skill_dir in "$SKILLS_DIR"/geo-*/; do
    [ -d "$skill_dir" ] && echo "  → ${skill_dir}"
done
for agent_file in "$AGENTS_DIR"/geo-*.md; do
    [ -f "$agent_file" ] && echo "  → ${agent_file}"
done
for cmd_file in "$COMMANDS_DIR"/geo-*.md; do
    [ -f "$cmd_file" ] && echo "  → ${cmd_file}"
done

echo ""
read -p "Are you sure you want to uninstall? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""

# Remove main skill
if [ -d "$SKILLS_DIR/geo" ]; then
    rm -rf "$SKILLS_DIR/geo"
    echo -e "${GREEN}✓ Removed main skill${NC}"
fi

# Remove sub-skills
for skill_dir in "$SKILLS_DIR"/geo-*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        rm -rf "$skill_dir"
        echo -e "${GREEN}✓ Removed ${skill_name}${NC}"
    fi
done

# Remove agents
for agent_file in "$AGENTS_DIR"/geo-*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file")
        rm -f "$agent_file"
        echo -e "${GREEN}✓ Removed ${agent_name}${NC}"
    fi
done

# Remove commands
for cmd_file in "$COMMANDS_DIR"/geo-*.md; do
    if [ -f "$cmd_file" ]; then
        cmd_name=$(basename "$cmd_file")
        rm -f "$cmd_file"
        echo -e "${GREEN}✓ Removed ${cmd_name}${NC}"
    fi
done

echo ""
echo -e "${GREEN}GEO-SEO skill has been uninstalled.${NC}"
echo ""
echo "Note: Python dependencies were not removed."
echo "To remove them manually:"
echo "  pip uninstall beautifulsoup4 requests lxml playwright Pillow validators"
echo ""
