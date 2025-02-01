import { defineConfig } from "vite";

export default defineConfig({
  build: {
    lib: {
      entry: "src/main.ts",
      name: "mql5-linux-vscode-extension",
      fileName: () => `main.min.js`,
    },
    outDir: "dist",
    rollupOptions: {
      external: ["vscode"],
    },
    sourcemap: true,
  },
});
