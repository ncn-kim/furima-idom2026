class Brand < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ブランド無し' },
    { id: 2, name: 'トヨタ自動車' },
    { id: 3, name: '本田技研工業' },
    { id: 4, name: 'ソニー' },
    { id: 5, name: 'ユニクロ' },
    { id: 6, name: '日産自動車' },
    { id: 7, name: '任天堂' },
    { id: 8, name: 'パナソニック' },
    { id: 9, name: '三菱UFJフィナンシャル・グループ' },
    { id: 10, name: 'NTTドコモ' },
    { id: 11, name: 'ソフトバンク' },
    { id: 12, name: 'サントリー' },
    { id: 13, name: 'キヤノン' },
    { id: 14, name: 'リクルート' },
    { id: 15, name: 'SUBARU' },
    { id: 16, name: 'KDDI（au）' },
    { id: 17, name: 'アサヒグループ' },
    { id: 18, name: 'ブリヂストン' },
    { id: 19, name: 'ダイキン工業' },
    { id: 20, name: '三井住友フィナンシャルグループ' }
  ]

  include ActiveHash::Associations
  has_many :items
end
