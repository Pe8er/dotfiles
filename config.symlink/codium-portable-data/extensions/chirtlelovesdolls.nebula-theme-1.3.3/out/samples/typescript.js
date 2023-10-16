"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.detectConfigChanges = void 0;
const index_1 = require("../src/themes/index");
const objects_1 = require("../src/helpers/objects");
const index_2 = require("../src/helpers/index");
const painter_1 = require("../scripts/helpers/painter");
/** Compare the workspace and the user configurations with the current setup of the theme. */
const detectConfigChanges = () => {
    const configs = Object.keys(index_2.getExtensionConfiguration())
        .map(c => c.split('.').slice(1).join('.'));
    return compareConfigs(configs).then(updatedOptions => {
        // if there's nothing to update
        if (!updatedOptions) {
            return;
        }
        // update theme json file with new options
        return index_1.createThemeFile(updatedOptions).then(() => {
            console.log(painter_1.green('New theme configuration file successfully created!'));
            index_2.promptToReload();
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
    return index_2.getColorThemeJson().then(json => {
        const defaults = index_1.getDefaultThemeOptions();
        configs.forEach(configName => {
            const configValue = index_2.getThemeConfig(configName).globalValue;
            const currentState = objects_1.getObjectPropertyValue(json.options, configName);
            const configDefault = objects_1.getObjectPropertyValue(defaults, configName);
            // If property is deleted, and it wasn't the default value, set it to the default value
            if (configValue === undefined && currentState !== configDefault) {
                objects_1.setObjectPropertyValue(json.options, configName, configDefault);
                updateRequired = true;
            }
            else if (configValue !== undefined && currentState !== configValue) {
                objects_1.setObjectPropertyValue(json.options, configName, configValue);
                updateRequired = true;
            }
        });
        return updateRequired ? json.options : undefined;
    });
};
//# sourceMappingURL=typescript.js.map