# GoBrain Presets

Repository ini berisi preset default untuk memulai proyek Go dengan GoBrain CLI.

## Panduan Preset GoBrain

Dokumen ini menjelaskan aturan preset, struktur repository preset, serta semua opsi yang bisa digunakan di `gob.yaml`.

## Apa Itu Preset
Preset adalah template proyek yang digunakan oleh `gob init` dengan `source-type: preset` atau `source-type: url`. Preset dapat berupa repository git atau folder lokal yang berisi template proyek.

Saat preset dipakai, GoBrain akan:
- Menyalin isi template ke folder proyek.
- Memastikan ada `gob.yaml` atau `gob.yml`.
- Menolak template yang berisi `go.mod`.
- Mengganti placeholder di file dengan nilai proyek.
- Menambahkan `.gob/` ke `.gitignore` secara terkelola.
- Membuat direktori dari `layout.dirs` (jika ada).
- Menginisialisasi `go.mod` serta `toolchain` sesuai konfigurasi.

## Aturan File dan Struktur Preset
Wajib:
- `gob.yaml` atau `gob.yml` di root template.

Dilarang:
- `go.mod` di dalam template. GoBrain akan membuatnya sendiri.

Boleh ada:
- Source code proyek (folder `cmd`, `internal`, dan lainnya).
- Folder `.template` untuk file generator.
- File `.gitignore` (akan digabungkan dengan `.gitignore` proyek).
- Folder/folder apa pun yang diperlukan proyek Anda.

Catatan:
- Folder `.git` di template akan diabaikan saat disalin.
- Placeholder otomatis diganti untuk semua file (kecuali folder yang di-skip).
- Folder yang di-skip dari proses placeholder: `.git`, `.gob`, `.template`, `vendor`, `bin`, `build`, `dist`, `.idea`, `.vscode`.

## Placeholder yang Didukung
Di dalam file template, gunakan placeholder berikut:
- `{{ .ProjectName }}` → diisi dengan nama proyek.
- `{{ .ModuleName }}` → diisi dengan module path Go.

## Struktur Preset: Repository
Contoh struktur repository preset:

```
my-preset/
  gob.yaml
  cmd/
  internal/
  .template/
  .gitignore
```

Jika Anda menyimpan beberapa preset dalam satu repo, gunakan subfolder:

```
gobrain-presets/
  minimal/
    gob.yaml
    cmd/
  api/
    gob.yaml
    internal/
```

Gunakan `path` pada konfigurasi preset untuk mengarah ke subfolder.

## Cara Membuat Preset Sendiri (Langkah demi Langkah)
1) Buat repository atau folder lokal untuk template.
2) Tambahkan `gob.yaml` atau `gob.yml` di root template.
3) Masukkan struktur kode sumber dan folder pendukung.
4) Hindari `go.mod` di template.
5) (Opsional) Tambahkan `.gitignore` dan folder `.template` untuk generator.
6) Uji dengan `gob init` menggunakan `source-type: url` atau `source-type: preset`.

Contoh penggunaan dengan URL:

```bash
gob init --source-type=url --source=https://github.com/you/your-preset.git
```

Jika template berada pada subfolder:

```bash
gob init --source-type=url --source=https://github.com/you/your-preset.git --path=api
```

## Daftar Preset (presets.yaml)
Format file preset:

```yaml
presets:
  - name: "minimal"
    source:
      repo: "https://github.com/Sch39/gobrain-presets.git"
      path: "minimal"
```

Lokasi yang didukung untuk `presets.yaml`:
- File custom lewat ENV `GOB_PRESET_FILE`.
- `presets.yaml` atau `presets.yml` di direktori kerja.
- `.presets/presets.yaml` atau `.presets/presets.yml` di direktori kerja.
- Default preset embedded di binary.

## Struktur dan Opsi `gob.yaml`
Semua opsi yang tersedia:

```yaml
version: "1.0.0"
debug: false
project:
  name: my-app
  module: github.com/user/my-app
  toolchain: 1.24.2
meta:
  template_origin: https://github.com/you/your-preset.git
  author: ""
  path: api
tools:
  - name: golangci-lint
    pkg: github.com/golangci/golangci-lint/cmd/golangci-lint@latest
scripts:
  build:
    - go build ./...
  test:
    - go test ./...
generators:
  requires:
    - github.com/Masterminds/sprig@latest
  commands:
    handler:
      desc: "Generate HTTP handler"
      args: ["name"]
      templates:
        - src: .template/handler.tmpl
          dest: internal/handlers/{{ pascal_case .Name }}.go
verify:
  fail_fast: true
  pipeline:
    - name: fmt
      run: go fmt ./...
    - name: vet
      run: go vet ./...
layout:
  dirs:
    - internal/handlers
    - internal/services
```

Ringkasan fungsi tiap bagian:
- `version`: versi format konfigurasi.
- `debug`: aktifkan log debug.
- `project`: metadata proyek (nama, module, toolchain).
- `meta`: asal template, author, dan path preset di repo.
- `tools`: daftar tool Go yang akan di-install ke `.gob/bin`.
- `scripts`: daftar perintah berurutan untuk `gob scripts run`.
- `generators`: definisi generator, argumen, serta template yang dirender.
- `verify`: pipeline pemeriksaan yang dijalankan `gob verify`.
- `layout`: daftar direktori yang akan dibuat saat inisialisasi.

## Tips
- Pastikan `gob.yaml` sudah siap sebelum dipublikasikan sebagai preset.
- Gunakan placeholder agar template bisa digunakan ulang untuk banyak proyek.
- Simpan generator di `.template` dan gunakan template function seperti `snake_case`, `pascal_case`, dan `camel_case`.

