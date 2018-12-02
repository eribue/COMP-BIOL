#ggtree package
#November 28 2018

#installing ggtree
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree", version = "3.8")

library(ggtree)
#allows you to visualize phylogenetic trees
#diagrams that represent evolutionary relationships amonf organisms
#node- common ancestors, tips, species, branch length, evolutionary time
#ggtree- designed by extending ggplot

set.seed(112818)
tree<- rtree(n=15, tip.label = LETTERS[seq(1:15)]) #random tree of 15 tips

#to visualize the tree
ggtree(tree)

#layouts- slanted, circular, fan
ggtree(tree, layout = "slanted")
ggtree(tree, layout = "circular")
ggtree(tree, layout = "fan", open.angle = 120)

#unrooted trees
ggtree(tree, layout = "daylight")

#cladograms
ggtree(tree, layout = "slanted", branch.length = "none")

#to display nodes and tips- geom_nodepoint and geom_tippoint
p<- ggtree(tree)+
  geom_nodepoint(color="blue", alpha=0.5, size=4)
p

#not tips
p+ geom_tippoint(color="red", shape=5, size=3)

#manipulate a tree
p +
  geom_text2(aes(subset=!isTip, label=node), hjust=-.5) + geom_tiplab()

#single out a clade- node and all of its descendants
viewClade(p+ geom_tiplab(), node=26)

#group clades
tree<- groupClade(tree, .node=c(21,25)) 
geom_tiplab(aes(subset(group, linetype=group)) + 
              geom_tiplab(aes(subset=(group==1)))

#collapse a clase
cp<- collapse(p, node=21)
cp +
  geom_point2(aes(subset=(node=21)), size=5, shape=23, fill="steelblue")

#expand a collapsed clade
cp %>% expand(node=21)

#tree annotations
p+ geom_cladelabel(node=21, label="my clade")+
  geom_cladelabel(node=25, label="your clade")

p+ geom_cladelabel(node=21, label="my clade", align=T, offset=-1, color="red")+
  geom_cladelabel(node=25, label="your clade", align=T, offset=-0.5, color="blue")

#change the font size
p+ geom_cladelabel(node=21, label="my clade", align=T, offset=-1, color="red", barsize = 1.5, fontsize = 5)+
  geom_cladelabel(node=25, label="your clade", align=T, offset=-0.5, color="blue", barsize = 2, fontsize = 5)

#phylomoji
library(emojifont)
p+
geom_cladelabel(node=21, label="chicken", parse="emoji", fontsize = 12, align = T, color="firebrick")+
  geom_cladelabel(node=25, label="duck", parse="emoji", fontsize = 12, align = T, color="steelblue")

tree_text<- "(((((cow, (whale, dolphin)), (pig, boar)), camel),  fish), seedling);"

x<- read.tree(x, linetype="dashed", color="firebrick") + xlim(NA,7), ylim(NA, 8.5)+
  geom_tiplab(aes(color=label), parse="emoji", size=14, vjust=0.25) +
  labs(title= "exploring cool emoji in phylo"), caption= "meh")






