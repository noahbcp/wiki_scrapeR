{
#Dependencies
    library(lubridate)
    library(htmltools)
    library(rvest)

#Get user input
    get_name <- as.character(readline(prompt = 'Please enter your name: '))
    get_age <- as.integer(readline(prompt = 'Please enter your age: '))
    get_bday <- as.Date(readline(prompt = 'Please enter your birthday (dd/mm/yy): '), format = '%d/%m/%y')
#Calculate time diff between systime and user birthday
    next_bday <- as.Date(get_bday %m+% years(get_age + 1))
    get_systime <- as.Date(Sys.time())
#Convert days, hours, min, sec to integers and print
    daysuntil <- as.integer(next_bday - get_systime)
    hoursuntil <- as.integer(daysuntil * 24)
    minutesuntil <- as.integer(hoursuntil * 60)
    secondsuntil <- as.integer(minutesuntil * 60)
    print(paste('Hi', paste(get_name, '!', sep = ''), 'It is', daysuntil, 'days until your next birthday!'))
    print(paste("That's ", hoursuntil, 'hours away...'))
    print(paste("or, ", minutesuntil, 'minutes away...'))
    print(paste("or, a whopping,", secondsuntil, 'seconds away!'))
#Get user input for legibility reasons
    readline(prompt = 'Press enter to continue...')
#Get Wikipedia 'on this day'
    wikiurldate <- (paste(months(get_bday), '_', day(get_bday), sep = '')) 
        #url requires Month_D format
    wikiurl <- paste('https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/', wikiurldate, sep = '') #appends date
    content <- wikiurl %>% #%>% passes the vector on to each following command
            read_html() %>% 
                #Pulls html from wikiurl
            html_node(xpath = '//*[@id="mw-content-text"]/div[1]/ul') %>% 
                #Denotes where to 'look.' 
                #Specifically, references the 'past front page' section.
            html_children() %>%
                #Converts the {html_node} into a list
            html_text2()
                #Cleans up html formatting from text
    print(paste('Did you know that on the ', day(get_bday), ' ', months(get_bday), ' the following happened...', sep = ''))
    rand_fact <- noquote(sample(content, 1, replace = FALSE))
    print(rand_fact)
#Samples the content list; returns a single item


#Loops and returns a new (*not yet*) random fact.
        q_response <- as.character(readline(prompt = 'Do you want to hear another fact? (Y/N): '))
        while (q_response == 'Y') 
            {
            rand_fact <- noquote(sample(content, 1, replace = FALSE))
            print(rand_fact)
            q_response <- NULL
            q_response <- as.character(readline(prompt = 'Do you want to hear another fact? (Y/N): '))
            }
        
        if (q_response == 'N') 
            {
            readline(noquote(paste('Bye ', get_name, '!', sep = '')))
            }
}
