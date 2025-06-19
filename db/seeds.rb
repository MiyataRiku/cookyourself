tags_to_create = [
  { name: 'ごはんもの' },
  { name: '肉料理' },
  { name: '魚料理'},
  { name: 'サラダ'},
  { name: 'スープ'},
  { name: '麺'},
  { name: 'パン'},
  { name: 'お菓子'},
  { name: 'シーズン'},
  { name: '一品料理'}
]

tags_to_create.each do |tag_data|
  Tag.find_or_create_by(name: tag_data[:name])
end