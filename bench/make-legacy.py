#!/usr/bin/env python3
"""Create an isolated copy of the PHP aliases using the pre-optimization code."""
import pathlib
import sys

source, destination = map(pathlib.Path, sys.argv[1:])
text = source.read_text()
start_marker = "    # Read installed kegs directly instead of launching Homebrew"
end_marker = "    # create alias for every version of PHP installed with HomeBrew"
if text.count(start_marker) != 1 or text.count(end_marker) != 1:
    raise SystemExit("PHP discovery markers changed; review the legacy benchmark")
start = text.index(start_marker)
end = text.index(end_marker, start)
legacy = r"""    # Historical implementation, before shell startup optimization.
    installedPhpVersions=($(brew ls --versions | ggrep -E 'php(@.*)?\s' | ggrep -oP '(?<=\s)\d\.\d' | uniq | sort))

"""
destination.write_text(text[:start] + legacy + text[end:])
