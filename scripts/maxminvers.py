#!/usr/bin/env python3

# Print the highest release number in each minor release series:
# ❯ git tag | python maxminvers.py
# 2.1.1
# 3.0.1
# 3.1.1
# 3.2.1
# 3.3.1
# 4.0.1
# 4.1.1
# 4.2.1
# 4.3.1
# 4.4.1

import sys

import semver


def main():
    versions = [x.strip().strip("v") for x in sys.stdin.readlines()]

    def verparse(versions):
        for ver in versions:
            try:
                version = semver.VersionInfo.parse(ver)
                if not version.prerelease:
                    yield version
            except ValueError:
                pass

    sorted_versions = list(verparse(versions))
    # print([str(x) for x in sorted_versions])

    max_minor_releases = []
    cursor = sorted_versions[0]
    for version in sorted_versions[1:]:
        if version.major > cursor.major or version.minor > cursor.minor:
            max_minor_releases.append(cursor)
            cursor = version
        elif version.patch > cursor.patch:
            cursor = version

    max_minor_releases.append(cursor)
    print("\n".join(str(x) for x in max_minor_releases))


if __name__ == "__main__":
    main()
