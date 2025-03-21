from bs4 import BeautifulSoup
import json


def extract_constants_from_html(html_file_path):
    # HTMLファイルを読み込み
    with open(html_file_path, 'r', encoding='utf-8') as file:
        html_content = file.read()

    # BeautifulSoupで解析
    soup = BeautifulSoup(html_content, 'html.parser')

    # テーブルの行を全て取得
    rows = soup.select('table.EnumTable tbody tr')

    constants = []

    # 各行を処理
    for row in rows:
        # td要素を取得
        cells = row.find_all('td')

        # 行に3つのセルがあるか確認
        if len(cells) >= 3:
            # 名前の取得 (最初のtd)
            name_cell = cells[0].find('span', class_='f_fortable')
            name = name_cell.text.strip() if name_cell else ""

            # 説明の取得 (2番目のtd)
            desc_cell = cells[1].find('span', class_='f_fortable') or cells[1].find(
                'span', class_='f_EnumDesc')
            description = desc_cell.text.strip() if desc_cell else ""
            # 改行とその後の空白を1つの空白のみに変換
            description = ' '.join(description.split())

            # 使用法の取得 (3番目のtd)
            usage_cell = cells[2].find('span', class_='f_fortable')
            usage = ""
            if usage_cell:
                # リンクがある場合はリンクのテキストを使用
                links = usage_cell.find_all('a')
                if links:
                    usage = ", ".join([link.text.strip() for link in links])
                else:
                    usage = usage_cell.text.strip()

            # 空でない場合のみ追加
            if name:
                constants.append({
                    "name": name,
                    "description": description,
                    "usage": usage
                })

    return constants


# 使用例
if __name__ == "__main__":
    html_file_path = '/home/shota/Documents/MQL5_on_Linux_VSCode_Extension/data/docs/mql5_constants.html'
    constants = extract_constants_from_html(html_file_path)

    # 結果を確認
    print(f"抽出した定数の数: {len(constants)}")

    # 最初の数個の定数を表示
    for i, const in enumerate(constants[:5]):
        print(f"\n定数 {i+1}:")
        print(f"  名前: {const['name']}")
        print(f"  説明: {const['description']}")
        print(f"  使用法: {const['usage']}")

    # 結果をJSONファイルに保存
    with open('mql5_constants.json', 'w', encoding='utf-8') as f:
        json.dump(constants, f, ensure_ascii=False, indent=2)

    print("\nデータをmql5_constants.jsonに保存しました。")
