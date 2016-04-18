module ApplicationHelper

  #returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Advanced Movie Recommendation System"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_comma_version(num)
    return if num.size < 4
    arr_num = num.to_s.split('')

    index = arr_num.size % 3
    if index == 0
      index += 3
    end

    while index < arr_num.size
      arr_num.insert(index, ',')
      index += 4 # 3+1 for added comma
    end

    arr_num.join('')
  end
end
