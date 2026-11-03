#!/usr/bin/env bash
# ==============================================================================
# AAS (Antigravity Agent Standard) - Global Core Installer (~/.gemini/config/)
# ==============================================================================
set -euo pipefail

GITHUB_REPO="${AAS_REPO:-https://github.com/nguyenquocduong/antigravity-agent-standard.git}"
GLOBAL_CONFIG_DIR="${HOME}/.gemini/config"
CLEANUP_TMP=false

echo "🌐 [AAS] Đang cài đặt Global Core vào: ${GLOBAL_CONFIG_DIR}"

# 1. Xác định thư mục nguồn AAS
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -f "${SCRIPT_DIR}/../core/rules/00-governance.md" ]; then
    AAS_SRC="$(cd "${SCRIPT_DIR}/.." && pwd)"
elif [ -n "${AAS_SOURCE_DIR:-}" ] && [ -f "${AAS_SOURCE_DIR}/core/rules/00-governance.md" ]; then
    AAS_SRC="${AAS_SOURCE_DIR}"
else
    TMP_CLONE_DIR=$(mktemp -d)
    CLEANUP_TMP=true
    echo "📦 Đang tải mã nguồn AAS từ: ${GITHUB_REPO}..."
    git clone --depth 1 "$GITHUB_REPO" "$TMP_CLONE_DIR" >/dev/null 2>&1 || {
        echo "❌ Lỗi: Không thể tải repository từ ${GITHUB_REPO}."
        exit 1
    }
    AAS_SRC="${TMP_CLONE_DIR}"
fi

# 2. Tạo thư mục cấu hình toàn cục
mkdir -p "${GLOBAL_CONFIG_DIR}/rules"
mkdir -p "${GLOBAL_CONFIG_DIR}/skills"

# 3. Sao chép Core Rules (áp dụng cho mọi dự án trên máy)
echo "📋 Đang sao chép Global Core Rules vào ~/.gemini/config/rules/..."
cp -f "${AAS_SRC}/core/rules/"*.md "${GLOBAL_CONFIG_DIR}/rules/"

# 4. Sao chép Core Workflow Skills (áp dụng cho mọi dự án trên máy)
echo "⚡ Đang sao chép Global Workflow Skills vào ~/.gemini/config/skills/..."
cp -Rf "${AAS_SRC}/core/skills/"* "${GLOBAL_CONFIG_DIR}/skills/"

# 5. Dọn dẹp thư mục tạm
if [ "$CLEANUP_TMP" = true ] && [ -d "${TMP_CLONE_DIR}" ]; then
    rm -rf "${TMP_CLONE_DIR}"
fi

echo ""
echo "✅ [AAS] Cài đặt Global Core thành công!"
echo "📁 Kỷ luật chuẩn Agent đã được kích hoạt cho mọi workspace trên máy tính của bạn:"
echo "   - Global Rules:  ~/.gemini/config/rules/"
echo "   - Global Skills: ~/.gemini/config/skills/"
echo "🎉 Mọi phiên làm việc Antigravity giờ đây đều tự động tuân thủ kỷ luật AAS Core!"
