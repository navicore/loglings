default: test

# Run all CI checks (same as forgejo actions). Run before pushing.
ci: fmt-check lint test build
    @echo "Safe to push - CI will pass."

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
    cargo install --locked --path .

# Remove build artifacts
clean:
    cargo clean
