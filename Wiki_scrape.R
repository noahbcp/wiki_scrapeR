{
##Dependencies
    library(lubridate)
    library(htmltools)
    library(rvest)
##Get user name and birthday
    get_name <- as.character(readline(
                prompt = 'Please enter your name: ')
                )
    get_bday <- as.Date(readline(
                prompt = 'Please enter your birthday (dd/mm/yy): '), 
                format = '%d/%m/%y'
                )
##Scrape Wikipedia 'on this day' page
    wikiurl_date <- (paste(months(get_bday), '_', day(get_bday), sep = '')) 
    wikiurl <-  paste(
                'https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/', 
                wikiurl_date, sep = ''
                )
    content <- wikiurl %>%
            read_html() %>%
            html_node(xpath = '//*[@id="mw-content-text"]/div[1]/ul') %>% 
            html_children() %>%     #Converts the {html_node} into a list
            html_text2()    #Cleans up html formatting from text
    dyk_prompt <-   as.character(paste(
                    'Hi, ', get_name, '!', ' Did you know that on the ', 
                    day(get_bday), ' ', months(get_bday), 
                    ' the following happened...', ' [press enter]', sep = '')
                    )
    readline(dyk_prompt)
    rand_fact <- noquote(sample(content, 1, replace = FALSE))
    print(rand_fact)
    i <- match(rand_fact, content) #find printed rand_fact in the list
    content <- content[-i] #removes the printed rand_fact
    q_response <-   as.character(readline(
                    prompt = 'Do you want to hear another fact? (Y/N): ')
                    )
    while (q_response == 'Y' & length(content) > 0)
        {
        rand_fact <- noquote(sample(content, 1, replace = FALSE))
        print(rand_fact)
        i <- match(rand_fact, content)
        content <- content[-i]
        q_response <- NULL
        q_response <-   as.character(readline(
                        prompt = 'Do you want to hear another fact? (Y/N): ')
                        )
        }
    if (q_response == 'N') 
        {
        readline(noquote(paste('Bye ', get_name, '!', sep = '')))
        .StopQuietly <- function() {
            opt <- options(show.error.messages = FALSE)
            on.exit(options(opt))
            stop()
            }
        }
    if (length(content) == 0) 
        {
        readline(noquote(paste('Sorry, there are no more facts.')))
        readline(noquote(paste('Bye ', get_name, '!', sep = '')))
        .StopQuietly <- function() {
            opt <- options(show.error.messages = FALSE)
            on.exit(options(opt))
            stop()
            }
        }
}
