# CODEX.md

## Project Context

This repository contains a compact NVDLA RTL variant. Most active work is in the
`nvdla/` tree, especially the register files and top-level partition wiring.

Important register/address reference:

- Software header: `e:\study2026\dehazer_FPGA\Qt_project\pciespeed\dla_selfsvd_mini_manual\opendla_small.h`
- Treat `opendla_small.h` as the source of truth when RTL register addresses
  disagree with software-visible addresses.

## Working Rules

- Preserve user changes. Do not revert unrelated edits.
- Keep RTL edits scoped to the affected block and its wiring.
- Use existing generated-style Verilog conventions in the repo.
- Prefer `rg` for searches.
- Use `apply_patch` for manual edits.
- Do not edit files outside this repository unless the user explicitly asks and
  permissions allow it.

## Register Group Policy

Recent design intent:

- `CSC`, `CMAC`, and `CACC` use `CDMA`'s `producer` for D register group
  selection.
- `CSC`, `CMAC`, and `CACC` use the rising edge of CDMA's per-group
  `d0_op_en`/`d1_op_en` to start their own local op-enable state.
- `CSC`, `CMAC`, and `CACC` clear their local op-enable state on their own
  `dp2reg_done`, and still maintain their own `consumer`.
- `SDP_RDMA` follows the same rule using `SDP`'s `producer` and per-group
  `d0_op_en`/`d1_op_en`.

When touching these blocks, keep register group selection tied to the upstream
producer, start local op-en from the upstream op-en rising edge, and keep
done-driven consumer/op-en clear local to the block.

## Address Alignment Notes

Use `opendla_small.h` for software-visible addresses. The current compact map
uses these main regions:

- `CDMA`: `0x3000`
- `CSC`: `0x4000`
- `CACC`: `0x7000`
- `SDP_RDMA`: `0x8000`
- `SDP`: `0x9000`

For duplicated D register groups, the D group selection threshold should match
the first D register address in the software map, not old generated thresholds.
For example:

- `CDMA` D group starts at `0x3040`
- `CSC` D group starts at `0x4040`
- `CACC` D group starts at `0x7040`
- `SDP_RDMA` D group starts at `0x8040`
- `SDP` D group starts at `0x9040`

## Useful Checks

Before committing RTL edits:

```powershell
git diff --check
git status --short
```

For quick address scans:

```powershell
rg -n "32'h[0-9a-fA-F]+" nvdla
rg -n "_MK_ADDR_CONST" "e:\study2026\dehazer_FPGA\Qt_project\pciespeed\dla_selfsvd_mini_manual\opendla_small.h"
```

For port wiring changes, scan both the module declaration and all instances:

```powershell
rg -n "module NV_NVDLA_|\\.sdp2reg_|\\.cdma2reg_|sdp_reg2dp_|cdma_reg2dp_" nvdla
```

## Git Notes

Remote:

```text
origin git@github.com:WongWangKit/rvd-acc.git
```

If pushing over SSH from this Windows environment, the intended GitHub key may be:

```powershell
$env:GIT_SSH_COMMAND = 'ssh -i C:/Users/16949/.ssh/id_rsa_github -o IdentitiesOnly=yes'
git push origin main
```
