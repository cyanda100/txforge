#!/bin/bash

set -e

echo "🚀 TX Forge install start..."

# mappen
mkdir -p app/api/public/status app/status components lib types workers data public

# .gitignore
cat > .gitignore <<'EOF'
node_modules
.next
.env
data/latest-status.json
data/alert-state.json
EOF

# package.json
cat > package.json <<'EOF'
{
  "name": "txforge",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start -p 3000",
    "collector": "tsx workers/collector.ts",
    "alerts": "tsx workers/alerts.ts"
  },
  "dependencies": {
    "next": "15.1.6",
    "react": "19.0.0",
    "react-dom": "19.0.0",
    "zod": "3.24.1"
  },
  "devDependencies": {
    "@types/node": "22.10.2",
    "@types/react": "19.0.2",
    "@types/react-dom": "19.0.2",
    "tsx": "4.19.2",
    "typescript": "5.7.2"
  }
}
EOF

# tsconfig
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["dom", "es2022"],
    "strict": true,
    "noEmit": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "jsx": "preserve"
  }
}
EOF

# next config
cat > next.config.ts <<'EOF'
import type { NextConfig } from "next";
const nextConfig: NextConfig = {};
export default nextConfig;
EOF

# next-env
cat > next-env.d.ts <<'EOF'
/// <reference types="next" />
EOF

# env
cat > .env <<'EOF'
RPC_URL=http://127.0.0.1:26657
VALIDATOR_MONIKER=TX Forge
EOF

# layout
cat > app/layout.tsx <<'EOF'
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html>
      <body>{children}</body>
    </html>
  );
}
EOF

# css
cat > app/globals.css <<'EOF'
body {
  font-family: Arial;
  background: #07111f;
  color: white;
}
EOF

# homepage
cat > app/page.tsx <<'EOF'
export default function Home() {
  return (
    <div style={{padding:40}}>
      <h1>TX Forge</h1>
      <p>New validator site running 🚀</p>
    </div>
  );
}
EOF

echo "📦 Installing dependencies..."
npm install

echo "🏗️ Building..."
npm run build

echo "✅ DONE!"
