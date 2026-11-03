#!/usr/bin/env bash
set -euo pipefail

echo "==> Running AAS Architecture Import Validator..."

ERRORS=0

# 1. Domain must not import UI or Infrastructure frameworks
if grep -rnE "import (SwiftUI|AppKit|CoreData|SwiftData|GRDB|Infrastructure)" Sources/Domain/ 2>/dev/null; then
    echo "ERROR: Domain module contains forbidden imports (SwiftUI, AppKit, Infra, or DB ORM)."
    ERRORS=$((ERRORS + 1))
fi

# 2. Features must not import Infrastructure directly
if grep -rnE "import Infrastructure" Sources/Features/ 2>/dev/null; then
    echo "ERROR: Feature modules must not import Infrastructure directly. Depend on Domain protocols."
    ERRORS=$((ERRORS + 1))
fi

# 3. UIComponents must not import Domain
if grep -rnE "import Domain" Sources/UIComponents/ 2>/dev/null; then
    echo "ERROR: UIComponents (Design System C0/C1) must not import Domain entities."
    ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
    echo "FAILED: $ERRORS architectural boundary violations found."
    exit 1
else
    echo "PASSED: All architectural import boundaries verified."
    exit 0
fi
