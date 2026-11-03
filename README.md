# Antigravity Agent Standard (AAS)

> **Version:** 1.2.0  
> **Target Engine:** Google Antigravity  
> **Philosophy:** Strict Engineering Governance, Spec-Driven Development (SDD), Zero Vibe-Coding.

---

## 🚀 Hướng Dẫn Cài Đặt Nhanh Theo Từng Loại Dự Án

Chọn đúng loại dự án của bạn, mở Terminal tại **thư mục gốc của dự án** và dán 1 khối lệnh tương ứng:

---

### 🍎 1. Dành Cho Dự Án Swift macOS (Swift 6, SPM, SwiftUI)

> **Cài đặt:** AAS Core + Apple Platform Pack + Native Spec-Kit Templates (`.agents/rules/`, `.agents/skills/`, `AGENTS.md` Swift Anchor, scripts kiểm tra SPM, templates SDD).

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

> **Cài đặt:** AAS Core + Web Platform Pack + Native Spec-Kit Templates (`.agents/rules/`, `.agents/skills/`, `AGENTS.md` Web Anchor, Zod contracts standard, 100% RLS policies, templates SDD).

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

> **Mục đích:** Kích hoạt kỷ luật Agent (Governance, Autonomy Levels, Zero Fake Proof, và 7 Workflow Skills chung bao gồm `spec-driven-development`) cho **MỌI dự án** (Swift, Web, Python, Go...) trên máy tính thông qua `~/.gemini/config/`.

Mở Terminal tại bất kỳ đâu và dán:

```bash
curl -fsSL https://raw.githubusercontent.com/nguyenduongit/antigravity-agent-standard/main/tooling/install-global.sh | bash
```

---

## ⚡ Tính Năng Mới: Spec-Driven Development (SDD Engine)
*(Tích hợp trực tiếp triết lý từ [github/spec-kit](https://github.com/github/spec-kit))*

AAS v1.2.0 tích hợp sẵn quy trình **Spec-Driven Development** giúp loại bỏ hoàn toàn tình trạng "vibe-coding" hoặc lập trình đoán mò khi xây dựng các tính năng lớn:

```
[ 1. SPECIFY ]             [ 2. PLAN ]                 [ 3. BREAK DOWN ]            [ 4. CONVERGE & VERIFY ]
User Stories (P1 MVP, P2) ──► Architecture Alignment ──► Actionable Task Checklist ──► AAS Quality Gates
Acceptance (Given-When-Then)  Interface Contracts (Zod/Swift) Parallel Flags [P]       Proof-First Raw Output
```

### Cách Sử Dụng SDD trong Chat với Antigravity:
Sau khi cài đặt AAS vào dự án, bạn chỉ cần yêu cầu:
> *"Hãy áp dụng skill `spec-driven-development` để lập đặc tả và triển khai tính năng [Tên tính năng]."*

Agent sẽ tự động:
1. Tạo file đặc tả nghiệp vụ `docs/specs/<feature>/spec.md` (chia rõ P1 MVP, P2, kịch bản Given-When-Then).
2. Tạo bản thiết kế kỹ thuật `docs/specs/<feature>/plan.md` (rõ ràng các file/module bị ảnh hưởng và hợp đồng interface).
3. Bẻ nhỏ thành danh sách task chi tiết `docs/specs/<feature>/tasks.md` kèm cờ thực thi song song `[P]`.
4. Triển khai từng task và kiểm chứng bằng test thực tế trước khi đánh dấu hoàn thành.

---

## 1. Tổng Quan Kiến Trúc Đa Nền Tảng của AAS

```
┌────────────────────────────────────────────────────────────────────────┐
│ TẦNG 1: GLOBAL CORE (core/)                                            │
│ Kỷ luật Agent phổ quát (Dùng chung 100% cho Swift, Web, Python...):   │
│ • Governance (Thứ bậc ưu tiên) • Scope Control (Ranh giới phạm vi)     │
│ • Autonomy (Balanced Mode)     • Verification (Zero Fake Proof)        │
│ • SDD Engine: spec-driven-development, feature-dev, bug-fixing...      │
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
│ • templates/spec-kit/             (Mẫu chuẩn: spec, plan, tasks)       │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Các Bất Biến Kỹ Thuật (Non-Negotiable)

1. **Giới hạn kích thước file:** Toàn bộ rule files đều nhỏ hơn **24 KB / 24,000 bytes** (ngưỡng giới hạn của Antigravity) để tránh bị cắt cụt nội dung ngầm.
2. **Progressive Disclosure:** Skills không bị nạp toàn bộ vào context mà chỉ nạp metadata (`name`, `description`); nội dung chi tiết chỉ được đọc khi bước thực thi yêu cầu.
3. **Balanced Autonomy Mode:**
   - **Level 1 (Fast Path):** Sửa lỗi nhỏ cục bộ $\le 2$ files $\rightarrow$ Agent tự làm.
   - **Level 2 (Plan Gate):** Feature mới, chạm $\ge 3$ files hoặc đổi ranh giới module $\rightarrow$ Bắt buộc lập kế hoạch và chờ duyệt.
   - **Level 3 (Hard Barrier):** Dependencies, Sandbox/RLS, xoá code/migrations $\rightarrow$ Tuyệt đối không tự làm.
4. **Bằng chứng Thực nghiệm (Zero Fake Proof):** Không chấp nhận câu nói suông "tests passed". Mọi báo cáo nghiệm thu bắt buộc phải đính kèm raw terminal output với exit code `0`.
