default: test

# A clean run is the validation: fmt + clippy, a release build, and the
# curriculum suite — every solution passes its hidden test and every starter
# parses on the real plgc compiler. No errors == the whole corpus is valid.
# Run all CI checks (same as forgejo actions). Run before pushing.
ci: fmt-check lint test build
    @echo "✓ Safe to push — CI will pass."
    @echo "  fmt + clippy clean · release build ok · all $(grep -c '^\[\[exercises\]\]' exercises/info.toml) exercises validated against plgc (each solution passes, each starter parses)."

# Format all code
fmt:
    cargo fmt --all

# Check formatting without modifying files
fmt-check:
    cargo fmt --all -- --check

# Lint with clippy (warnings are errors)
lint:
    cargo clippy --locked --workspace --all-targets -- -D warnings

# Run the test suite
test:
    cargo test --locked --workspace --all-targets

# Build in release mode
build:
    cargo build --locked --release

# Install the loglings binary to ~/.cargo/bin
install:
    cargo install --path . --locked --force

# Remove build artifacts
clean:
    cargo clean

# Requires `scc` (brew install scc · or · cargo install scc) and
# `cargo-modules` (cargo install cargo-modules) — both are dev-only,
# not in Cargo.toml. The cargo-modules call falls back to a hint if
# the tool is missing so the recipe still prints something useful.
# Quick code stats: LOC, largest files, module tree.
stats:
    @echo "=== LOC ==="
    @scc src --no-cocomo
    @echo ""
    @echo "=== Largest Rust source files (top 15) ==="
    @scc src --by-file --no-cocomo -s lines -i rs | head -20
    @echo ""
    @echo "=== Module tree ==="
    @cargo modules structure --bin loglings 2>/dev/null \
      || echo "(install cargo-modules for the module tree: cargo install cargo-modules)"
