import { defineConfig } from "vite";

export default defineConfig({
  build: {
    lib: {
      entry: "src/main.ts",
      name: "mql5-on-linux",
      fileName: () => `main.js`,
    },
    outDir: "dist",
    rollupOptions: {
      external: ["vscode"],
    },
    minify: false,
  },
});
