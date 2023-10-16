"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Import accentsSelector from './lib/accents-selector';
const run = () => {
    bind();
    const { config, defaults } = window.bootstrap;
    // AccentsSelector('[data-setting="accentSelector"]', defaults.accents, config.accent);
    console.log(defaults);
    console.log(config);
};
const bind = () => {
    document.querySelector('#fixIconsCTA').addEventListener('click', () => {
        console.log('Test click');
    });
};
run();
//# sourceMappingURL=index.js.map