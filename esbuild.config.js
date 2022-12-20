#!/usr/bin/env node

let args = process.argv.slice(2);
let watch = args.includes('--watch')

const { build } = require("esbuild");
const { sassPlugin } = require("esbuild-sass-plugin");

build({
  entryPoints: [
    "app/assets/stylesheets/application.scss",
    "app/assets/stylesheets/application-cool.scss",
    "app/assets/stylesheets/rails_admin.scss",
  ],
  bundle: true,
  watch: watch,
  loader: {
    ".png": "dataurl",
    ".woff": "dataurl",
    ".woff2": "dataurl",
    ".eot": "dataurl",
    ".ttf": "dataurl",
    ".svg": "dataurl",
  },
  logLevel: "info",
  outdir: "app/assets/builds",
  plugins: [sassPlugin({ cssImports: true })],
})
  .then(() => console.log("⚡ Build complete! ⚡"))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
