// TODO: publish this file as a plugin for prettier

/**
 * @import { Plugin, Doc } from "prettier";
 */

import origPlugin from "prettier/plugins/markdown";

/** @type {Plugin["parsers"]} */
const parsers = origPlugin.parsers;

/** @type {Plugin["options"]} */
// prettier-ignore
const options = {
  emphasisKind: {
    category: "Markdown",
    description: "The character to use for emphasis/italics.",
    type: "choice",
    default: "underscore",
    choices: [
      { value: "underscore", description: "Use underscores (_) for emphasis." },
      { value: "asterisk", description: "Use asterisks (*) for emphasis." },
    ],
  },
  strongKind: {
    category: "Markdown",
    description: "The character to use for strong emphasis/bold.",
    type: "choice",
    default: "asterisk",
    choices: [
      { value: "asterisk", description: "Use asterisks (**) for strong emphasis." },
      { value: "underscore", description: "Use underscores (__) for strong emphasis." },
    ],
  },
  orderedListKind: {
    category: "Markdown",
    description: "The character to use for ordered list.",
    type: "choice",
    default: "period",
    choices: [
      { value: "period", description: "Use periods (.) for ordered list." },
      { value: "parenthesis", description: "Use parentheses ()) for ordered list." },
    ],
  },
  unorderedListKind: {
    category: "Markdown",
    description: "The character to use for unordered list.",
    type: "choice",
    default: "dash",
    choices: [
      { value: "dash", description: "Use dashes (-) for unordered list." },
      { value: "asterisk", description: "Use asterisks (*) for unordered list." },
      { value: "plus", description: "Use plus signs (+) for unordered list." },
    ],
  },
};

const emphasisKindMap = {
  underscore: "_",
  asterisk: "*",
};
const strongKindMap = {
  asterisk: "**",
  underscore: "__",
};
const orderedListKindMap = {
  period: ".",
  parenthesis: ")",
};
const unorderedListKindMap = {
  dash: "-",
  asterisk: "*",
  plus: "+",
};

const origPrinter = origPlugin.printers.mdast;
const origPrint = origPrinter.print;
/** @type {Plugin["printers"]} */
const printers = {
  ["mdast"]: {
    ...origPrinter,
    print: (path, options, print, args) => {
      const { node } = path;
      let doc = origPrint(path, options, print, args);

      if (node.type === "emphasis") {
        doc = modifyEmphasisKind(doc, emphasisKindMap[options.emphasisKind]);
      }

      if (node.type === "strong") {
        doc = modifyStrongKind(doc, strongKindMap[options.strongKind]);
      }

      if (node.type === "list" && node.ordered) {
        doc = modifyOrderedListKind(
          doc,
          orderedListKindMap[options.orderedListKind],
        );
      }

      if (node.type === "list" && !node.ordered) {
        doc = modifyUnorderedListKind(
          doc,
          unorderedListKindMap[options.unorderedListKind],
        );
      }

      return doc;
    },
  },
};

/**
 * @param {Doc} doc
 * @param {string} ch
 * @return {Doc}
 */
const modifyEmphasisKind = (doc, ch) => {
  if (ch === "_") return doc; // Do nothing for the default kind.
  doc = flatten(doc);

  const l = doc.findIndex(isString);
  const r = doc.findLastIndex(isString);
  if (
    l === -1 ||
    r === -1 ||
    !(doc[l].match(/^[_*]/) && doc[r].match(/[_*]$/))
  ) {
    // There maybe an upstream change.
    throw new Error("failed to resolve emphasis kind");
  }

  doc[l] = doc[l].replace(/^./, ch);
  doc[r] = doc[r].replace(/.$/, ch);

  return doc;
};

/**
 * @param {Doc} doc
 * @param {string} ch
 * @return {Doc}
 */
const modifyStrongKind = (doc, ch) => {
  if (ch === "**") return doc; // Do nothing for the default kind.
  doc = flatten(doc);

  const l = doc.findIndex(isString);
  const r = doc.findLastIndex(isString);
  if (
    l === -1 ||
    r === -1 ||
    !(doc[l].match(/^[_*][_*]/) && doc[r].match(/[_*][_*]$/))
  ) {
    // There maybe an upstream change.
    throw new Error("failed to resolve strong kind");
  }

  doc[l] = doc[l].replace(/^../, ch);
  doc[r] = doc[r].replace(/..$/, ch);

  return doc;
};

/**
 * @param {Doc} doc
 * @param {string} ch
 * @return {Doc}
 */
const modifyOrderedListKind = (doc, ch) => {
  if (ch === ".") return doc; // Do nothing for the default kind.
  doc = flatten(doc);

  for (let i = 0; i < doc.length; i++) {
    if (typeof doc[i] !== "string" || !doc[i].match(/^\d+[.)]/)) {
      continue;
    }
    // Alternate between consecutive list items.
    doc[i] = doc[i].replace(/\D/, (c) => (c === "." ? ch : "."));
  }

  return doc;
};

/**
 * @param {Doc} doc
 * @param {string} ch
 * @return {Doc}
 */
const modifyUnorderedListKind = (doc, ch) => {
  if (ch === "-") return doc; // Do nothing for the default character.
  doc = flatten(doc);

  for (let i = 0; i < doc.length; i++) {
    if (typeof doc[i] !== "string" || !doc[i].match(/^[-*]/)) {
      continue;
    }
    // Alternate between consecutive list items.
    doc[i] = doc[i].replace(/^./, (c) => (c === "-" ? ch : "-"));
  }

  return doc;
};

/**
 * @param {Doc} doc
 * @return {boolean}
 */
const isString = (doc) => typeof doc === "string";

/**
 * @param {Doc} doc
 * @param {Doc} result
 * @return {Doc[]}
 */
const flatten = (doc, result = []) => {
  if (Array.isArray(doc)) {
    for (const d of doc) {
      flatten(d, result);
    }
  } else if (doc !== "") {
    result.push(doc);
  }
  return result;
};

/** @type {Plugin} */
const markdownExtended = {
  parsers,
  options,
  printers,
};
export default markdownExtended;
