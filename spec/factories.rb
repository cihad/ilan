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

    factory :node_with_images do
      ignore do
        images_count 3
      end

      after(:build) do |node, evaluator|
        node.images << FactoryGirl.build_list(:image, evaluator.images_count)
      end
    end
  end

  factory :image do
    image do
      r = rand(1..4)
      File.new(Rails.root.join("spec/support/images/0#{r}.png"))
    end

    node
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