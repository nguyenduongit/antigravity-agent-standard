#!/usr/bin/env bash
# Backwards compatibility wrapper: redirects to install-swift.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [ -f "${SCRIPT_DIR}/install-swift.sh" ]; then
    exec bash "${SCRIPT_DIR}/install-swift.sh" "$@"
else
    # Remote fallback
    curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-swift.sh | bash -s -- "$@"
fi
