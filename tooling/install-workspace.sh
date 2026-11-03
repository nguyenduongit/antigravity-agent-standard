#!/usr/bin/env bash
# ==============================================================================
# AAS (Antigravity Agent Standard) - Workspace Installer for Swift macOS
# ==============================================================================
set -euo pipefail

REPO_OWNER="${AAS_OWNER:-nguyenduongit}"
REPO_NAME="${AAS_NAME:-antigravity-agent-standard}"
GITHUB_REPO="${AAS_REPO:-https://github.com/${REPO_OWNER}/${REPO_NAME}.git}"
TARBALL_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/main.tar.gz"

TARGET_DIR="${PWD}"
CLEANUP_TMP=false

echo "🚀 [AAS] Đang cài đặt Antigravity Agent Standard vào Workspace: ${TARGET_DIR}"

# 1. Xác định thư mục nguồn AAS
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -f "${SCRIPT_DIR}/../core/rules/00-governance.md" ]; then
    AAS_SRC="$(cd "${SCRIPT_DIR}/.." && pwd)"
elif [ -n "${AAS_SOURCE_DIR:-}" ] && [ -f "${AAS_SOURCE_DIR}/core/rules/00-governance.md" ]; then
    AAS_SRC="${AAS_SOURCE_DIR}"
else
    # Tải qua tarball hoặc git clone
    TMP_CLONE_DIR=$(mktemp -d)
    CLEANUP_TMP=true
    echo "📦 Đang tải mã nguồn AAS từ GitHub (${REPO_OWNER}/${REPO_NAME})..."
    
    DOWNLOAD_SUCCESS=false
    # Cách 1: Tải nhanh qua Tarball archive (không cần git)
    if curl -fsSL "$TARBALL_URL" 2>/dev/null | tar -xz -C "$TMP_CLONE_DIR" --strip-components=1 2>/dev/null; then
        DOWNLOAD_SUCCESS=true
    fi
    
    # Cách 2: Dự phòng bằng git clone nếu tarball thất bại
    if [ "$DOWNLOAD_SUCCESS" = false ]; then
        if git clone --depth 1 "$GITHUB_REPO" "$TMP_CLONE_DIR" >/dev/null 2>&1; then
            DOWNLOAD_SUCCESS=true
        fi
    fi

    if [ "$DOWNLOAD_SUCCESS" = false ]; then
        echo "❌ Lỗi: Không thể tải repository từ ${GITHUB_REPO}."
        echo "   Vui lòng kiểm tra lại URL hoặc đặt biến môi trường: AAS_REPO=https://github.com/USER/REPO.git"
        exit 1
    fi
    AAS_SRC="${TMP_CLONE_DIR}"
fi

# 2. Tạo cấu trúc thư mục đích
mkdir -p "${TARGET_DIR}/.agents/rules"
mkdir -p "${TARGET_DIR}/.agents/skills"
mkdir -p "${TARGET_DIR}/.aas"
mkdir -p "${TARGET_DIR}/Scripts"
mkdir -p "${TARGET_DIR}/docs/adr"
mkdir -p "${TARGET_DIR}/docs/architecture"

# 3. Sao chép Rules (Core + Apple Platform)
echo "📋 Đang sao chép Rules vào .agents/rules/..."
cp -f "${AAS_SRC}/core/rules/"*.md "${TARGET_DIR}/.agents/rules/"
cp -f "${AAS_SRC}/platforms/apple/rules/"*.md "${TARGET_DIR}/.agents/rules/"

# 4. Sao chép Skills (Workflow Skills + Apple Technology Skills)
echo "⚡ Đang sao chép Skills vào .agents/skills/..."
cp -Rf "${AAS_SRC}/core/skills/"* "${TARGET_DIR}/.agents/skills/"
cp -Rf "${AAS_SRC}/platforms/apple/skills/"* "${TARGET_DIR}/.agents/skills/"

# 5. Sao chép Project Anchor (AGENTS.md)
if [ -f "${TARGET_DIR}/AGENTS.md" ]; then
    echo "⚠️  Phát hiện AGENTS.md cũ, đang sao lưu thành AGENTS.md.bak..."
    mv "${TARGET_DIR}/AGENTS.md" "${TARGET_DIR}/AGENTS.md.bak"
fi
echo "⚓ Đang tạo Project Anchor AGENTS.md..."
cp -f "${AAS_SRC}/templates/project-AGENTS.md" "${TARGET_DIR}/AGENTS.md"

# 6. Sao chép Manifest, ADR template & Tooling scripts
echo "🛠️  Đang cài đặt Manifest, ADR Template và Validation Scripts..."
cp -f "${AAS_SRC}/templates/project-manifest.yaml" "${TARGET_DIR}/.aas/project.yaml"
if [ ! -f "${TARGET_DIR}/docs/adr/000-template.md" ]; then
    cp -f "${AAS_SRC}/templates/ADR.md" "${TARGET_DIR}/docs/adr/000-template.md"
fi
cp -f "${AAS_SRC}/Scripts/"*.sh "${TARGET_DIR}/Scripts/"
chmod +x "${TARGET_DIR}/Scripts/"*.sh

# 7. Dọn dẹp thư mục tạm (nếu có)
if [ "$CLEANUP_TMP" = true ] && [ -d "${TMP_CLONE_DIR}" ]; then
    rm -rf "${TMP_CLONE_DIR}"
fi

echo ""
echo "✅ [AAS] Cài đặt Workspace thành công!"
echo "📁 Các file đã được đặt vào đúng vị trí:"
echo "   - Project Anchor:       ./AGENTS.md (< 120 dòng)"
echo "   - Workspace Rules:      ./.agents/rules/ (12 rules)"
echo "   - Workspace Skills:     ./.agents/skills/ (11 skills)"
echo "   - Project Manifest:     ./.aas/project.yaml"
echo "   - Architecture Scripts: ./Scripts/*.sh"
echo "🎉 Agent Antigravity đã sẵn sàng làm việc với kiến trúc chuẩn AAS!"
