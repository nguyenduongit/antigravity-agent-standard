# Antigravity Agent Standard (AAS)

> **Version:** 1.1.0  
> **Target Engine:** Google Antigravity  
> **Philosophy:** Strict Engineering Governance, Progressive Disclosure, Zero Vibe-Coding.

---

## 🚀 Hướng Dẫn Cài Đặt Nhanh Theo Từng Loại Dự Án

Chọn đúng loại dự án của bạn, mở Terminal tại **thư mục gốc của dự án** và dán 1 khối lệnh tương ứng:

---

### 🍎 1. Dành Cho Dự Án Swift macOS (Swift 6, SPM, SwiftUI)

> **Cài đặt:** AAS Core + Apple Platform Pack (`.agents/rules/`, `.agents/skills/`, `AGENTS.md` Swift Anchor, scripts kiểm tra SPM).

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-swift.sh | bash
```

*(Khối lệnh dự phòng qua Git):*
```bash
bash -c '
REPO_URL="https://github.com/nguyenduongit/antigravity-agent-standard.git"
TMP_DIR=$(mktemp -d)
git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
bash "$TMP_DIR/tooling/install-swift.sh"
rm -rf "$TMP_DIR"
'
```

---

### 🌐 2. Dành Cho Dự Án Web App (Next.js + Supabase Edge-First)

> **Cài đặt:** AAS Core + Web Platform Pack (`.agents/rules/`, `.agents/skills/`, `AGENTS.md` Web Anchor, Zod contracts standard, 100% RLS policies).

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-web.sh | bash
```

*(Khối lệnh dự phòng qua Git):*
```bash
bash -c '
REPO_URL="https://github.com/nguyenduongit/antigravity-agent-standard.git"
TMP_DIR=$(mktemp -d)
git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
bash "$TMP_DIR/tooling/install-web.sh"
rm -rf "$TMP_DIR"
'
```

---

### 🌍 3. Cài Đặt Toàn Cục Trên Máy Tính (Global Core Level)

> **Mục đích:** Kích hoạt kỷ luật Agent (Governance, Autonomy Levels, Zero Fake Proof, và 6 Workflow Skills chung) cho **MỌI dự án** (Swift, Web, Python, Go...) trên máy tính thông qua `~/.gemini/config/`.

Mở Terminal tại bất kỳ đâu và dán:

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-global.sh | bash
```

---

## 1. Tổng Quan Kiến Trúc Đa Nền Tảng của AAS

AAS được thiết kế theo mô hình **Onion Architecture 3 Tầng** nhằm tái sử dụng tối đa và không bao giờ vượt trần giới hạn ngữ cảnh:

```
┌────────────────────────────────────────────────────────────────────────┐
│ TẦNG 1: GLOBAL CORE (core/)                                            │
│ Kỷ luật Agent phổ quát (Dùng chung 100% cho Swift, Web, Python...):   │
│ • Governance (Thứ bậc ưu tiên) • Scope Control (Ranh giới phạm vi)     │
│ • Autonomy (Balanced Mode)     • Verification (Zero Fake Proof)        │
│ • Universal Workflow Skills (feature-dev, bug-fixing, refactoring...)  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Kế thừa
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ TẦNG 2: PLATFORM PACKS (platforms/)                                    │
│ Quy chuẩn kỹ thuật chuyên sâu theo từng ngăn xếp công nghệ:            │
│                                                                        │
│ • platforms/apple/ (Swift 6, SwiftUI 4-tier, SPM Clean Architecture)   │
│ • platforms/web/   (Next.js App Router, Supabase RLS, Zod Contracts)   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Kế thừa & Áp dụng
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│ TẦNG 3: PROJECT WORKSPACE ANCHOR (templates/)                          │
│ File AGENTS.md gọn nhẹ (< 120 dòng) neo trực tiếp tại từng repository: │
│ • templates/project-AGENTS.md     (Dành cho Swift macOS)               │
│ • templates/project-AGENTS-web.md (Dành cho Web Next.js)               │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Cấu Trúc Kho Lưu Trữ Chuẩn

```text
antigravity-agent-standard/
├── VERSION                          # Global SemVer specification (1.1.0)
├── CHANGELOG.md                     # Lịch sử phiên bản & migration notes
├── README.md                        # Hướng dẫn chọn lệnh theo dự án
│
├── tooling/                         # Bộ script cài đặt tự động cho từng stack
│   ├── install-swift.sh             # 🍎 Installer cho Swift macOS
│   ├── install-web.sh               # 🌐 Installer cho Web App (Next.js + Supabase)
│   └── install-global.sh            # 🌍 Installer toàn cục máy tính
│
├── core/                            # Layer 1: Universal governance (Dùng chung)
│   ├── rules/                       # 00-governance -> 06-reporting (< 24 KB)
│   └── skills/                      # 6 Workflow Skills (On-demand)
│
├── platforms/                       # Layer 2: Technology Platform Packs
│   ├── apple/                       # Apple Pack (macOS 14+, Swift 6)
│   │   ├── manifest.yaml
│   │   ├── rules/ & skills/
│   │   └── blueprints/macos-app/
│   └── web/                         # Web Pack (Next.js App Router, Supabase)
│       ├── manifest.yaml
│       ├── rules/ & skills/
│       └── blueprints/nextjs-supabase/
│
└── templates/                       # Layer 3: Templates neo dự án
    ├── project-AGENTS.md            # Swift Project Anchor (< 120 dòng)
    ├── project-AGENTS-web.md        # Web Project Anchor (< 120 dòng)
    ├── project-manifest.yaml        # Swift Manifest (.aas/project.yaml)
    ├── project-manifest-web.yaml    # Web Manifest (.aas/project.yaml)
    └── ADR.md                       # Mẫu Architecture Decision Record
```

---

## 3. Các Bất Biến Kỹ Thuật (Non-Negotiable)

1. **Giới hạn kích thước file:** Toàn bộ rule files đều nhỏ hơn **24 KB / 24,000 bytes** (ngưỡng giới hạn của Antigravity) để tránh bị cắt cụt nội dung ngầm.
2. **Progressive Disclosure:** Skills không bị nạp toàn bộ vào context mà chỉ nạp metadata (`name`, `description`); nội dung chi tiết chỉ được đọc khi bước thực thi yêu cầu.
3. **Balanced Autonomy Mode:**
   - **Level 1 (Fast Path):** Sửa lỗi nhỏ cục bộ $\le 2$ files $\rightarrow$ Agent tự làm.
   - **Level 2 (Plan Gate):** Feature mới, chạm $\ge 3$ files hoặc đổi ranh giới module $\rightarrow$ Bắt buộc lập kế hoạch và chờ duyệt.
   - **Level 3 (Hard Barrier):** Dependencies, Sandbox/RLS, xoá code/migrations $\rightarrow$ Tuyệt đối không tự làm.
4. **Bằng chứng Thực nghiệm (Zero Fake Proof):** Không chấp nhận câu nói suông "tests passed". Mọi báo cáo nghiệm thu bắt buộc phải đính kèm raw terminal output với exit code `0`.
