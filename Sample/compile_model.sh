#!/bin/sh

set -e

xcrun coremlcompiler compile ../LaMa.mlpackage Sources/Sample/
xcrun coremlcompiler generate ../LaMa.mlpackage Sources/Sample/ --language Swift
