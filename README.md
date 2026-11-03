# Antigravity Agent Standard (AAS)

> **Version:** 1.0.0  
> **Target Engine:** Google Antigravity  
> **Philosophy:** Strict Engineering Governance, Progressive Disclosure, Zero Vibe-Coding.

---

## 🚀 Hướng Dẫn Cài Đặt Nhanh (Quick Start)

Bạn có thể cài đặt AAS vào dự án hoặc toàn bộ máy tính chỉ bằng cách **sao chép và dán 1 khối lệnh duy nhất** vào Terminal.

> [!TIP]
> Thay thế `<YOUR_GITHUB_USERNAME>` bằng tên tài khoản GitHub của bạn sau khi bạn đẩy repository này lên GitHub.

---

### CÁCH 1: Cài đặt vào một Dự án Swift macOS (Workspace Level)

> **Mục đích:** Thiết lập kỷ luật Agent, cấu trúc `.agents/rules/`, `.agents/skills/`, bộ script kiểm tra kiến trúc và Project Anchor `AGENTS.md` cho một dự án Swift macOS cụ thể.

Mở Terminal, di chuyển vào **thư mục gốc của dự án Swift macOS** của bạn, và dán khối lệnh sau:

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-workspace.sh | bash
```

*(Nếu repository ở chế độ Private hoặc bạn muốn dùng Git trực tiếp, chạy khối lệnh này):*

```bash
bash -c '
REPO_URL="https://github.com/nguyenduongit/antigravity-agent-standard.git"
TMP_DIR=$(mktemp -d)
echo "==> Đang tải AAS từ GitHub..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
bash "$TMP_DIR/tooling/install-workspace.sh"
rm -rf "$TMP_DIR"
'
```

#### Kết quả sau khi chạy khối lệnh:
Thư mục dự án của bạn sẽ lập tức có đầy đủ cấu trúc:
```text
MyMacApp/
├── AGENTS.md                  # Project Anchor rút gọn (< 120 dòng)
├── .agents/
│   ├── rules/                 # 12 Rules kỹ thuật (Core + Apple Platform)
│   └── skills/                # 11 Skills (Workflow Skills + Apple Technology Skills)
├── .aas/
│   └── project.yaml           # Manifest khai báo công nghệ và blueprint
├── docs/
│   └── adr/000-template.md    # Mẫu ghi nhận ngoại lệ kiến trúc
└── Scripts/
    ├── check_imports.sh       # Script kiểm tra cấm import chéo tầng SPM
    └── check_file_size.sh     # Script quét cảnh báo kích thước file
```

---

### CÁCH 2: Cài đặt Toàn cục trên máy tính (Global Level)

> **Mục đích:** Kích hoạt kỷ luật Agent (Governance, Autonomy Levels, Zero Fake Proof, và 6 Workflow Skills chung) cho **MỌI dự án** (Swift, React, Python, Go...) trên máy tính của bạn thông qua thư mục cấu hình `~/.gemini/config/`.

Mở Terminal tại bất kỳ đâu và dán khối lệnh sau:

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-global.sh | bash
```

*(Khối lệnh dự phòng qua Git):*

```bash
bash -c '
REPO_URL="https://github.com/nguyenduongit/antigravity-agent-standard.git"
TMP_DIR=$(mktemp -d)
echo "==> Đang cài đặt AAS Core toàn cục..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1
bash "$TMP_DIR/tooling/install-global.sh"
rm -rf "$TMP_DIR"
'
```

#### Kết quả sau khi chạy khối lệnh:
```text
~/.gemini/config/
├── rules/                     # 7 Core Rules (Governance, Conduct, Scope, Autonomy, Verification...)
└── skills/                    # 6 Universal Workflow Skills (feature-dev, bug-fixing, refactoring...)
```

---

### Cài đặt Trực tiếp từ Thư mục Local (Nếu đã clone repo về máy)

Nếu bạn đã clone thư mục `antigravity-agent-standard` về máy cá nhân:

```bash
# Đứng tại thư mục dự án của bạn và chạy:
bash /path/to/antigravity-agent-standard/tooling/install-workspace.sh

# Cài đặt toàn cục:
bash /path/to/antigravity-agent-standard/tooling/install-global.sh
```

---

## 1. Tổng quan Kiến trúc AAS

**Antigravity Agent Standard (AAS)** là bộ tiêu chuẩn kỹ thuật phân tầng giải quyết triệt để vấn đề "Monolithic Instruction Bloat":

* **Layer 1: Global Core (`core/`)** — Kỷ luật hành vi, kiểm soát phạm vi, 3 cấp độ tự chủ (Balanced Mode), ma trận kiểm chứng thực nghiệm (Zero Fake Proof), và các kỹ năng quy trình (Workflow Skills) độc lập công nghệ.
* **Layer 2: Platform Standards (`platforms/`)** — Quy chuẩn công nghệ chuyên sâu, kỹ năng thực thi nền tảng (Swift 6, SwiftUI 4-tier components, SPM architecture, App Sandbox).
* **Layer 3: Project Workspace Anchor (`templates/project-AGENTS.md`)** — Điểm neo điều hướng dự án nhẹ nhàng (< 120 dòng), liên kết manifest `.aas/project.yaml` và quản trị ngoại lệ qua ADR.

---

## 2. Cấu trúc Kho lưu trữ Chuẩn

```text
antigravity-agent-standard/
├── VERSION                          # Global SemVer specification (1.0.0)
├── CHANGELOG.md                     # Lịch sử phiên bản & migration notes
├── README.md                        # Tài liệu hướng dẫn & lệnh cài đặt
├── tooling/                         # Bộ script cài đặt tự động
│   ├── install-workspace.sh         # Installer cho dự án cụ thể
│   └── install-global.sh            # Installer toàn cục máy tính
├── core/                            # Layer 1: Universal governance
│   ├── rules/                       # Core invariants (< 24 KB per file)
│   │   ├── 00-governance.md
│   │   ├── 01-agent-conduct.md
│   │   ├── 02-scope-control.md
│   │   ├── 03-autonomy-levels.md
│   │   ├── 04-verification.md
│   │   ├── 05-security-baseline.md
│   │   └── 06-reporting.md
│   └── skills/                      # Universal workflow skills (On-demand)
│       ├── feature-development/
│       ├── bug-fixing/
│       ├── refactoring/
│       ├── code-review/
│       ├── testing/
│       └── technical-planning/
├── platforms/                       # Layer 2: Technology packs
│   └── apple/                       # Apple Platform Pack (macOS 14+, Swift 6)
│       ├── manifest.yaml
│       ├── rules/
│       ├── skills/
│       └── blueprints/
├── templates/                       # Layer 3: Project workspace templates
│   ├── project-AGENTS.md            # Lightweight Project Anchor (< 120 dòng)
│   ├── project-manifest.yaml        # .aas/project.yaml schema
│   ├── ADR.md                       # Architecture Decision Record template
│   └── agent-report.md              # Verification report template
└── Scripts/                         # Automated validation & architecture linting
    ├── check_imports.sh
    └── check_file_size.sh
```

---

## 3. Các Bất Biến Kỹ Thuật (Non-Negotiable)

1. **Giới hạn kích thước file:** Toàn bộ rule files đều nhỏ hơn **24 KB / 24,000 bytes** (ngưỡng giới hạn của Antigravity) để tránh bị cắt cụt nội dung ngầm.
2. **Progressive Disclosure:** Skills không bị nạp toàn bộ vào context mà chỉ nạp metadata (`name`, `description`); nội dung chi tiết chỉ được đọc khi bước thực thi yêu cầu.
3. **Balanced Autonomy Mode:**
   - **Level 1 (Fast Path):** Sửa lỗi nhỏ cục bộ $\le 2$ files $\rightarrow$ Agent tự làm.
   - **Level 2 (Plan Gate):** Feature mới, chạm $\ge 3$ files hoặc đổi ranh giới module $\rightarrow$ Bắt buộc lập kế hoạch và chờ duyệt.
   - **Level 3 (Hard Barrier):** Dependencies, Sandbox, xoá code $\rightarrow$ Tuyệt đối không tự làm.
4. **Bằng chứng Thực nghiệm (Zero Fake Proof):** Không chấp nhận câu nói suông "tests passed". Mọi báo cáo nghiệm thu bắt buộc phải đính kèm raw terminal output với exit code `0`.
