#!/usr/bin/env python3
"""Create a pwntools exploit stub from the local template."""

from __future__ import annotations

import argparse
from pathlib import Path
import sys


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate an exploit scaffold from the dotfiles pwninit template."
    )
    parser.add_argument(
        "binary",
        help="Path to the vulnerable binary that will drive the template.",
    )
    parser.add_argument(
        "-o",
        "--output",
        default="exploit.py",
        help="Output file for the generated exploit (default: exploit.py).",
    )
    parser.add_argument(
        "-l",
        "--line",
        action="append",
        default=[],
        help="Additional binding line(s) inserted after `context.binary` (can be repeated).",
    )
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="Overwrite the output file if it already exists.",
    )
    return parser.parse_args()


def main() -> int:
    args = _parse_args()
    base = Path(__file__).resolve().parent
    template_path = base / "template.py"
    if not template_path.exists():
        print(f"missing template: {template_path}", file=sys.stderr)
        return 1

    binary_path = Path(args.binary)
    output_path = Path(args.output).expanduser()
    if output_path.exists() and not args.force:
        print(
            f"{output_path} already exists; rerun with --force to overwrite.",
            file=sys.stderr,
        )
        return 1

    binding_lines = [f'exe = context.binary = ELF({repr(str(binary_path))})']
    binding_lines.extend(args.line)
    bindings_block = "\n".join(binding_lines)

    template = template_path.read_text()
    content = template.format(bindings=bindings_block)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content)
    print(f"generated exploit stub -> {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
