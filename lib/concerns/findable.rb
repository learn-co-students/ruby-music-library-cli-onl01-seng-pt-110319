
module Concerns::Findable

    def find_by_name(find_this)
        all.detect {|x| x.name == find_this}
    end

    def find_or_create_by_name(find_or_create_this)
        if found_object = find_by_name(find_or_create_this) 
            found_object
        else
            create(find_or_create_this)
        end
    end
    
end
