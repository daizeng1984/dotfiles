#!/bin/bash
cargo build
cargo test
cargo install --root "$PREFIX"
