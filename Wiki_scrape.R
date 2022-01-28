{
#Dependencies
    library(tidyverse)
    library(lubridate)
    library(htmltools)
    library(rvest)
#get user input
    get_name <- as.character(readline(prompt = 'Please enter your name: '))
    get_age <- as.integer(readline(prompt = 'Please enter your age: '))
    get_bday <- as.Date(readline(prompt = 'Please enter your birthday (dd/mm/yy): '), format = '%d/%m/%y')
#calculate time diff between systime and user birthday
    next_bday <- as.Date(get_bday %m+% years(get_age + 1))
    get_systime <- as.Date(Sys.time())
#convert days, hours, min, sec to integers and print
    daysuntil <- as.integer(next_bday - get_systime)
    hoursuntil <- as.integer(daysuntil * 24)
    minutesuntil <- as.integer(hoursuntil * 60)
    secondsuntil <- as.integer(minutesuntil * 60)
    print(paste('Hi', paste(get_name, '!', sep = ''), 'It is', daysuntil, 'days until your next birthday!'))
    print(paste("That's ", hoursuntil, 'hours away...'))
    print(paste("or, ", minutesuntil, 'minutes away...'))
    print(paste("or, a whopping,", secondsuntil, 'seconds away!'))
#get user input
    readline(prompt = 'Press enter to continue...')
#get Wikipedia 'on this day'
    wikiurldate <- (paste(months(get_bday), '_', day(get_bday), sep = ''))
    wikiurl <- paste('https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/', wikiurldate, sep = '')
    content <- wikiurl %>%
            read_html() %>%
            html_node(xpath = '//*[@id="mw-content-text"]/div[1]/ul') %>%
            html_children() %>%
            html_text2()
    print(paste('Did you know that on the ', day(get_bday), ' ', months(get_bday), ' the following happened...', sep = ''))
    noquote(content)
}
