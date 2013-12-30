FactoryGirl.define do  
  factory :node do
    sequence(:title) { |n| "Lorem Ipsum Dolor Sit Amet #{n}" }
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
    icon do
      icons = %w(adjust align-center align-justify align-left align-right
        arrow-down arrow-left arrow-right arrow-up asterisk backward ban-circle
        barcode bell bold book)

      icons[rand(0..(icons.size-1))]
    end
  end
end