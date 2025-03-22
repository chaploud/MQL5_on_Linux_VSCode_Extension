// Script that scrape built-in functions and constants
// from MQL5 documents and generates header files (.mqh)

import puppeteer from "puppeteer";

const FUNCTIONS_URL = "https://www.mql5.com/en/docs/function_indices";
const CONSTANTS_URL = "https://www.mql5.com/en/docs/constant_indices";

// 多重に同じものを取得してしまわないように管理する

async function main() {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  await page.goto(FUNCTIONS_URL);

  const tableRows = await page.$$eval("#help tbody tr", (trs) =>
    trs.map((tr) => {
      const children = tr.children;
      const name = children[0]?.textContent?.trim();
      const link = children[0]?.querySelector("a")?.getAttribute("href");
      const description = children[1].textContent?.trim();
      return {
        name,
        link,
        description,
      };
    }),
  );
  console.log(tableRows);
}

main();
