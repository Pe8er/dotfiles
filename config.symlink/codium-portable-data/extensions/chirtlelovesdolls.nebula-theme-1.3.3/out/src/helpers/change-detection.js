"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.detectConfigChanges = void 0;
const index_1 = require("../themes/index");
const objects_1 = require("./objects");
const _1 = require(".");
const painter_1 = require("../../scripts/helpers/painter");
/** Compare the workspace and the user configurations with the current setup of the theme. */
const detectConfigChanges = () => {
    const configs = Object.keys(_1.getExtensionConfiguration())
        .map(c => c.split('.').slice(1).join('.'));
    return compareConfigs(configs).then(updatedOptions => {
        // if there's nothing to update
        if (!updatedOptions) {
            return;
        }
        // update theme json file with new options
        return index_1.createThemeFile(updatedOptions).then(() => {
            console.log(painter_1.green('New theme configuration file successfully created!'));
            _1.promptToReload();
        }).catch(err => {
            console.error(err);
        });
    });
};
exports.detectConfigChanges = detectConfigChanges;
/**
 * Compares a specific configuration in the settings with a current configuration state.
 * The current configuration state is read from the theme json file.
 * @param configs List of configuration names
 * @returns List of configurations that needs to be updated.
 */
const compareConfigs = (configs) => {
    let updateRequired = false;
    return _1.getColorThemeJson().then(json => {
        configs.forEach(configName => {
            let configValue = _1.getThemeConfig(configName).globalValue;
            if (configValue === undefined) {
                configValue = _1.getThemeConfig(configName).defaultValue;
            }
            const currentState = objects_1.getObjectPropertyValue(json.options, configName);
            // If property is deleted, and it wasn't the default value, set it to the default value
            if (JSON.stringify(configValue) !== JSON.stringify(currentState)) {
                objects_1.setObjectPropertyValue(json.options, configName, configValue);
                updateRequired = true;
            }
        });
        return updateRequired ? json.options : undefined;
    });
};
//# sourceMappingURL=change-detection.js.map