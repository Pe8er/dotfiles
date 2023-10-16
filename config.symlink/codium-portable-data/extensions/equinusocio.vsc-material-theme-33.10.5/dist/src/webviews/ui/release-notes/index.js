"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = __importDefault(require("@sanity/client"));
// eslint-disable-next-line @typescript-eslint/explicit-function-return-type
const getClient = () => client_1.default({
    projectId: 'v475t82f',
    dataset: 'production'
});
const getReleaseNotes = () => __awaiter(void 0, void 0, void 0, function* () {
    const query = '*[_type == "release"] | order(version desc)';
    const client = getClient();
    return client.fetch(query);
});
const renderTemplate = (posts) => {
    return `${posts.reduce((acc, { version, title, fixed, new: newItems, breaking }) => acc.concat(`<section class="Release">
    <header class="Release__Header">
      <span class="Release__Number">${version}</span>
      <h2 class="Release__Title">${title}</h2>
    </header>
    <ul class="Release-List">
      ${fixed.reduce((accc, src) => src.length > 0 ? accc.concat(`<li data-type="fixed">${src}</li>`) : '', '')}
      ${newItems.reduce((accc, src) => src.length > 0 ? accc.concat(`<li data-type="new">${src}</li>`) : '', '')}
      ${breaking.reduce((accc, src) => src.length > 0 ? accc.concat(`<li data-type="breaking">${src}</li>`) : '', '')}
    </ul>
  </section>`), '')}`;
};
getReleaseNotes().then((res) => {
    const normalized = res.reduce((acc, src) => acc.concat(Object.assign(Object.assign({}, src), { fixed: src.fixed ? src.fixed.map(item => item.children[0].text) : [], new: src.new ? src.new.map(item => item.children[0].text) : [], breaking: src.breaking ? src.breaking.map(item => item.children[0].text) : [] })), []);
    document.querySelector('.Container').innerHTML = renderTemplate(normalized);
});
//# sourceMappingURL=index.js.map