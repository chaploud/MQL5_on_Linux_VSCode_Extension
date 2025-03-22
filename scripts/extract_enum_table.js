/**
 * Extract constant names and descriptions from the ENUM description table in MQL5
 * @param {string} title - Table Title
 * @returns {Array} - Array of objects containing enum names and descriptions
 */
function extractEnumTable(title) {
  const allSpans = document.querySelectorAll("p.p_Text > span.f_Text");
  let titleP = null;
  for (const span of allSpans) {
    if (span.textContent.trim() === title) {
      titleP = span.parentElement;
    }
  }
  if (!titleP) {
    return;
  }

  let rows = titleP.nextElementSibling.querySelectorAll("tbody tr");

  const enums = [];
  for (const row of rows) {
    const cells = row.querySelectorAll("td");
    if (cells.length < 2) {
      continue;
    }
    const enumName = cells[0].textContent.trim();
    let enumDescription = cells[1].textContent.trim();
    let linksInEnumDescription = cells[1].querySelectorAll("a");
    for (const link of linksInEnumDescription) {
      const linkText = link.textContent.trim();
      if (linkText.match(/^[A-Z0-9_]+$/)) {
        enumDescription = enumDescription.replace(linkText, `\`${linkText}\``);
      }
    }

    enums.push({ name: enumName, description: enumDescription });
  }

  return enums;
}

/**
 * Output as an enum definition including docstring for `.mqh`
 * @param {string} title - enum name
 * @param {string} description - enum description
 * @param {object} enums - enum values
 * @returns {string} - enum definition string
 */
function outputEnum(title, description, enums) {
  let enumString = `// @brief ${description}\n`;
  enumString += `enum ${title} {\n`;
  for (const enumObj of enums) {
    // \nを含む場合は後ろではなく、前に改行でわけてつける
    if (enumObj.description.includes("\n")) {
      const lines = enumObj.description.split("\n");
      for (const line of lines) {
        const ln = line.trim() === "" ? "//" : `// ${line.trim()}`;
        enumString += `  ${ln}\n`;
      }
      enumString += `  ${enumObj.name},\n`;
    } else {
      enumString += `  ${enumObj.name}, // ${enumObj.description}\n`;
    }
  }
  enumString += "};\n\n";
  return enumString;
}

function main(title, description) {
  const enums = extractEnumTable(title);
  if (!enums) {
    return;
  }
  const enumString = outputEnum(title, description, enums);
  console.log(enumString);
}

main(
  "ENUM_ACCOUNT_INFO_INTEGER",
  "Account Properties for the function `AccountInfoDouble()`",
);
