class CLI
  def run
    puts "Welcome Broadway fan!".red
    Scraper.scrape_shows
    list_shows
    main_menu
    end
  end
  def list_shows
    Show.all.each.with_index(1) do |show, index| 
      puts "#{index}. #{show.name}"
    end
  end
  def main_menu
    puts "Please type a show's number to learn more or 'list' to see the list again. Type 'exit' to leave.".red
    input = gets.chomp
    if input == "exit"
      exit
    elsif input == "list"
      list_shows
    else
      show = Show.all[input.to_i - 1]
      if show
        Scraper.scrape_showtext(show)
        puts "Here is the summary for #{show.name}:".red
        puts "#{show.showtext}"
  
      else
        puts "Invalid input. Please try again!".red
      end
    end
    main_menu
  end
  