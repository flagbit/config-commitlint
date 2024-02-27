module.exports = {
    extends: ["@flagbit/config-commitlint"],
    parserPreset: {
        parserOpts: {
            issuePrefixes: ["\\s[\\w\\d]{1,10}-"],
        },
    },
    rules: {
        'subject-case': [2, 'always', ['sentence-case']]
    }
};
