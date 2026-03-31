#!/bin/bash

# Navigate to the folder this script lives in
cd "$(dirname "$0")"

# Kill any existing server on port 3000
lsof -ti:3000 | xargs kill -9 2>/dev/null

# Start the server in the background
python3 -m http.server 3000 &
SERVER_PID=$!

# Wait a moment for the server to start
sleep 1

# Open the app in the default browser
open http://localhost:3000

echo ""
echo "✅ LinkedIn Post Generator is running at http://localhost:3000"
echo "   Press Ctrl+C to stop the server."
echo ""

# Keep the terminal open and wait for Ctrl+C
wait $SERVER_PID
