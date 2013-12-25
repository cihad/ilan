FactoryGirl.define do  
  factory :node do
    title "Lorem ipsum dolor sit amet"
    description "Consectetur adipisicing elit."
    contact "Excepteur sint occaecat cupidatat non"
    email "example@example.com"
    city
    category

    factory :published_node do
      status "published"
    end
  end

  factory :city do
    sequence(:name) {|n| "Ankara #{n}" }
  end

  factory :category do
    sequence(:name) { |n| "Emlak #{n}" }
  end
end