// Extract function definition from MQL5 documentation

/**
 * Extract function definitions from MQL5 documentation
 * @param {Array} - Array of objects containing function names and descriptions
 */
function extractFunction() {
  const title = document.querySelector("#help > h1").textContent.trim();
  const descriptionP = document.querySelector("#help > h1").nextElementSibling;
  const description = descriptionP.querySelector("p span").textContent.trim();

  const definitionDiv = descriptionP.nextElementSibling;
  const definition = definitionDiv
    .querySelector("tbody tr td")
    .textContent.trim();

  const parameterNames = document.querySelectorAll(
    ".p_FunctionParameter .f_FunctionParameter",
  );

  const parameterDescriptions = document.querySelectorAll(
    ".p_ParameterDesrciption .f_ParameterDesrciption",
  );

  const parameters = [];

  for (const [i, parameterName] of parameterNames.entries()) {
    const name = parameterName.textContent.trim();
    let description = parameterDescriptions[i].textContent.trim();
    const linksInDescription = parameterDescriptions[i].querySelectorAll("a");
    for (const link of linksInDescription) {
      const linkText = link.textContent.trim();
      if (linkText.match(/^[A-Z0-9_]+$/)) {
        description = description.replace(linkText, `\`${linkText}\``);
      }
    }
    const inout = description.split(" ")[0];
    description = description.replace(inout, "").trim();
    parameters.push({ name, inout, description });
  }

  let returnValueSpan = document.querySelector(
    ".p_FunctionRemark .f_FunctionRemark",
  );
  let returnValue = returnValueSpan.textContent.trim();

  const linksInReturnValue = returnValueSpan.querySelectorAll("a");
  for (const link of linksInReturnValue) {
    const linkText = link.textContent.trim();
    if (linkText.match(/^[A-Z0-9_]+$/)) {
      returnValue = returnValue.replace(linkText, `\`${linkText}\``);
    }
  }

  return {
    title,
    description,
    definition,
    parameters,
    returnValue,
  };
}

/**
 * Output as a function definition including docstring for `.mqh`
 * @param {string} description - function description
 * @param {string} definition - function definition
 * @param {Array} parameters - function parameters
 * @param {string} returnValue - function return value
 * @returns {string} - function definition string
 */
function outputFunction(description, definition, parameters, returnValue) {
  let functionString = "/**\n";
  functionString += ` * @brief ${description}\n`;
  for (const param of parameters) {
    functionString += ` * @param${param.inout} ${param.name} ${param.description}\n`;
  }
  functionString += ` * @return ${returnValue}\n */\n`;
  functionString += `${definition}\n\n`;
  return functionString;
}

function main() {
  const { title, description, definition, parameters, returnValue } =
    extractFunction();
  if (!title) {
    return;
  }
  const functionString = outputFunction(
    description,
    definition,
    parameters,
    returnValue,
  );
  console.log(functionString);
}

main();
