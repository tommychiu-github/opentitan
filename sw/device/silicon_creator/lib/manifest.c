// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include "sw/device/silicon_creator/lib/manifest.h"

#include "sw/device/silicon_creator/lib/base/chip.h"

#if defined(OPENTITAN_IS_ENGLISHBREAKFAST)
#include "hw/top_englishbreakfast/sw/autogen/top_englishbreakfast.h"
#define EFLASH_SIZE_BYES TOP_ENGLISHBREAKFAST_EFLASH_SIZE_BYTES
#elif defined(OPENTITAN_IS_EARLGREY)
#include "hw/top_earlgrey/sw/autogen/top_earlgrey.h"
#define EFLASH_SIZE_BYES TOP_EARLGREY_EFLASH_SIZE_BYTES
#elif defined(OPENTITAN_IS_DARJEELING)
#include "hw/top_darjeeling/sw/autogen/top_darjeeling.h"
#define EFLASH_SIZE_BYES TOP_DARJEELING_RAM_MAIN_SIZE_BYTES
#else
#error unsupported top
#endif

static_assert(CHIP_ROM_EXT_SIZE_MIN >= CHIP_MANIFEST_SIZE,
              "`CHIP_ROM_EXT_SIZE_MIN` is too small");
static_assert(CHIP_ROM_EXT_SIZE_MAX >= CHIP_ROM_EXT_SIZE_MIN,
              "`CHIP_ROM_EXT_SIZE_MAX` is too small");
static_assert(CHIP_ROM_EXT_RESIZABLE_SIZE_MAX >= CHIP_ROM_EXT_SIZE_MAX,
              "`CHIP_ROM_EXT_RESIZABLE_SIZE_MAX` is too small");
static_assert(CHIP_BL0_SIZE_MIN >= CHIP_MANIFEST_SIZE,
              "`CHIP_BL0_SIZE_MIN` is too small");
static_assert(CHIP_BL0_SIZE_MAX >= CHIP_BL0_SIZE_MIN,
              "`CHIP_BL0_SIZE_MAX` is too small");
static_assert(CHIP_BL0_SIZE_MAX <=
                  ((EFLASH_SIZE_BYES / 2) - CHIP_ROM_EXT_SIZE_MAX),
              "`CHIP_BL0_SIZE_MAX` is too large");

// Extern declarations for the inline functions in the manifest header.
extern rom_error_t manifest_check(const manifest_t *manifest);
extern manifest_digest_region_t manifest_digest_region_get(
    const manifest_t *manifest);
extern epmp_region_t manifest_code_region_get(const manifest_t *manifest);
extern uintptr_t manifest_entry_point_get(const manifest_t *manifest);
extern rom_error_t manifest_ext_get_spx_key(
    const manifest_t *manifest, const manifest_ext_spx_key_t **spx_key);
extern rom_error_t manifest_ext_get_spx_signature(
    const manifest_t *manifest,
    const manifest_ext_spx_signature_t **spx_signature);
