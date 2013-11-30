FactoryGirl.define do  
  factory :node do
    title "Lorem ipsum dolor sit amet"
    description "Consectetur adipisicing elit."
    contact "Excepteur sint occaecat cupidatat non"
    email "example@example.com"
  end

  factory :city do
    sequence(:name) {|n| "Ankara #{n}" }
  end
end