# ビルドステージ
FROM node:20-alpine as builder

# pnpm インストール
RUN npm install -g pnpm

# 必要なツールのインストール
RUN apk add --no-cache git sed

# アプリケーションのソースコードを取得
WORKDIR /app
RUN git clone -b main https://github.com/livekit-examples/meet.git .

# standaloneモードの設定を追加
RUN if ! grep -q "output: 'standalone'" next.config.js; then \
      sed -i "/^const nextConfig = {/a \  output: 'standalone'," next.config.js; \
    fi

# 依存関係をインストール
RUN pnpm install

# アプリケーションをビルド
RUN pnpm run build

# 実行ステージ
FROM node:20-alpine
WORKDIR /app

# ビルドされたファイルと必要なリソースをコピー
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# 環境変数を設定
ENV PORT 3000
EXPOSE 3000

# アプリケーションを起動
CMD ["node", "server.js"]
