# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

load("//rules:ujson.bzl", "ujson_rust")
load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library")

package(default_visibility = ["//visibility:public"])

rust_binary(
    name = "harness",
    srcs = ["src/main.rs"],
    deps = [
        "//sw/host/cryptotest/ujson_lib:cryptotest_commands",
        "//sw/host/opentitanlib",
        "@crate_index//:anyhow",
        "@crate_index//:arrayvec",
        "@crate_index//:clap",
        "@crate_index//:humantime",
        "@crate_index//:log",
        "@crate_index//:num-bigint-dig",
        "@crate_index//:p256",
        "@crate_index//:p384",
        "@crate_index//:serde",
        "@crate_index//:serde_json",
    ],
)
