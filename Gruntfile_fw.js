'use strict';

module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-string-replace');
    grunt.registerTask('default', ['string-replace']);
    grunt.initConfig({
        'string-replace': {
            inline: {
              files: {
                'test/flpSandboxMockServer.html': 'test/flpSandboxMockServer.html',
              },
              options: {
                replacements: [
                  {
                    pattern: '<script src="../test-resources/sap/ushell/bootstrap/sandbox.js" id="sap-ushell-bootstrap"></script>',
                    replacement: '<script src="https://sapui5.hana.ondemand.com/test-resources/sap/ushell/bootstrap/sandbox.js" id="sap-ushell-bootstrap"></script>'
                  },
                  {
                    pattern: 'src="../resources/sap-ui-core.js"',
                    replacement: 'src="https://openui5.hana.ondemand.com/resources/sap-ui-core.js"'
                  },
                ]
              }
            }
          }
    });
};