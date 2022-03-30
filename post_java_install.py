#!/usr/bin/env python3

import re
import subprocess
from typing import Dict, Set


# TODO: running this is resulting in error from python, but works when run manually.
# Optional for now.
def configure_jenv_maven():
    # ensure that JAVA_HOME is correct
    subprocess.run(["jenv enable-plugin export"], shell=True)
    # make Maven aware of the java version in use ( and switch
    # when your project does)
    subprocess.run(["jenv enable-plugin maven"], shell=True)


def add_jdk_versions_to_jenv(required_jdk_versions: Set[str]):
    # installed versions
    # > jenv versions
    # * system (set by /Users/naveenbabuede/.jenv/version)
    #   1.8
    #   1.8.0.322
    #   11
    #   11.0
    #   11.0.14.1
    #   openjdk64-1.8.0.322
    #   openjdk64-11.0.14.1
    jenv_versions_ret = subprocess.run(["jenv", "versions"], capture_output=True)
    if jenv_versions_ret.returncode != 0:
        raise Exception(f"Error executing 'jenv versions'. Error: {jenv_versions_ret.stderr}")
    added_jdk_versions: Set[str] = set()
    for v in jenv_versions_ret.stdout.decode("utf-8").splitlines():
        v = v.strip()
        if v.startswith("openjdk"):
            added_jdk_versions.add(v)

    missing_jdk_versions = required_jdk_versions.difference(added_jdk_versions)
    if not missing_jdk_versions:
        print()
        print(f"All jdk versions({required_jdk_versions} are added to jenv. Nothing to do.")
        print()
        return

    # Installed Jdk paths
    # > java_home -V
    # Matching Java Virtual Machines (2):
    #     11.0.14.1 (x86_64) "Eclipse Temurin" - "Eclipse Temurin 11" /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
    #     1.8.0_322 (x86_64) "Eclipse Temurin" - "Eclipse Temurin 8" /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home
    # /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
    java_home_ret = subprocess.run(["/usr/libexec/java_home", "-V"], capture_output=True)

    available_jdk_versions: Dict[str, str] = {}
    pattern = re.compile(r"^\s+(\d.*?)\s\(x86_64\).*?(/Library.*?)$")
    for l in java_home_ret.stderr.decode("utf-8").splitlines():
        match = re.search(pattern, l)
        if match:
            # to match the version numbers prefix with openjdk64-
            available_jdk_versions[f"openjdk64-{match.group(1)}"] = match.group(2)

    missing_from_available_jdk_versions = required_jdk_versions.difference(set(available_jdk_versions.keys()))

    if missing_from_available_jdk_versions:
        print(f"Required versions of java not installed on Mac are {missing_from_available_jdk_versions}")

    for version in missing_jdk_versions:
        if version in available_jdk_versions.keys():
            print(f"Adding {version} to jenv...")
            subprocess.run(["jenv", "add", available_jdk_versions[version]])

    print("Done adding required jenv.")


def global_java_version(version="11"):
    print(f"Setting up global java version to {version}")
    subprocess.run([f"jenv global {version}"], shell=True)
    print()


def main():
    # configure_jenv_maven()
    add_jdk_versions_to_jenv({"openjdk64-1.8.0.322", "openjdk64-11.0.14.1"})
    global_java_version()


if __name__ == "__main__":
    exit(main())



