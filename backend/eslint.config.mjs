import js from "@eslint/js";
import tseslint from "typescript-eslint";
import prettierConfig from "eslint-config-prettier";

export default [
  // Ignore deps/build/config files
  { ignores: ["node_modules/**", "dist/**", "eslint.config.*"] },

  // Base rules
  js.configs.recommended,

  // TS rules (no type-checking)
  ...tseslint.configs.recommended,

  // Turn off rules that conflict with Prettier
  prettierConfig,

  // Apply to TS only
  {
    files: ["**/*.ts"],
    languageOptions: {
      parser: tseslint.parser,
      parserOptions: { ecmaVersion: "latest", sourceType: "module" },
    },
    rules: {
      "@typescript-eslint/no-unused-vars": [
        "warn",
        { argsIgnorePattern: "^_" },
      ],
    },
  },
];
