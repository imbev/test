#!/usr/bin/bash
set -euo pipefail

cat > /.buildstamp <<'EOF'
[Main]
Product=MyOS
Version=10
IsFinal=True
EOF
