module.exports = {
  extends: ["./index.js"],
  parserPreset: {
    parserOpts: {
      issuePrefixes: ["\\s[\\w\\d]{1,10}-"],
    },
  },
};
