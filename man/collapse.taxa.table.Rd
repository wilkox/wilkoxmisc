\name{collapse.taxa.table}
\alias{collapse.taxa.table}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
collapse.taxa.table(TaxaTable, Taxon = "Phylum", N = 7, RelativeAbundance = "RelativeAbundance", CollapseName = "Minor/Unclassified", Omit = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{TaxaTable}{
%%     ~~Describe \code{TaxaTable} here~~
}
  \item{Taxon}{
%%     ~~Describe \code{Taxon} here~~
}
  \item{N}{
%%     ~~Describe \code{N} here~~
}
  \item{RelativeAbundance}{
%%     ~~Describe \code{RelativeAbundance} here~~
}
  \item{CollapseName}{
%%     ~~Describe \code{CollapseName} here~~
}
  \item{Omit}{
%%     ~~Describe \code{Omit} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (TaxaTable, Taxon = "Phylum", N = 7, RelativeAbundance = "RelativeAbundance", 
    CollapseName = "Minor/Unclassified", Omit = TRUE) 
{
    names(TaxaTable)[names(TaxaTable) == RelativeAbundance] <- "RelativeAbundance"
    names(TaxaTable)[names(TaxaTable) == Taxon] <- "Taxon"
    TopTaxa <- ddply(TaxaTable, .(Taxon), summarise, RelativeAbundance = mean(RelativeAbundance))
    TopTaxa <- arrange(TopTaxa, desc(RelativeAbundance))
    if (Omit) {
        TopTaxa <- na.omit(TopTaxa)
        TopTaxa <- TopTaxa[which(TopTaxa["Taxon"] != ""), ]
    }
    TopTaxa <- TopTaxa[1:N, ]
    TopTaxa <- TopTaxa$Taxon
    TaxaTable <- within(TaxaTable, Taxon <- ifelse(Taxon \%in\% 
        TopTaxa, as.character(Taxon), CollapseName))
    TaxaTable <- ddply(TaxaTable, .(Sample, Taxon), summarise, 
        RelativeAbundance = sum(RelativeAbundance))
    TaxaTable$Taxon <- factor(TaxaTable$Taxon)
    TaxaTable$Taxon <- move.to.end(TaxaTable$Taxon, CollapseName)
    names(TaxaTable)[names(TaxaTable) == "RelativeAbundance"] <- RelativeAbundance
    names(TaxaTable)[names(TaxaTable) == "Taxon"] <- Taxon
    return(TaxaTable)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
