import java.io.File;
import java.io.FileNotFoundException;
import java.util.Collection;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *  The full representation of a configuration in the TentsAndTrees puzzle.
 *  It can read an initial configuration from a file, and supports the
 *  Configuration methods necessary for the Backtracker solver.
 *
 *  @author: Sean Strout @ RIT CS
 *  @author: Brian Landy
 */
public class TentConfig implements Configuration {
    // INPUT CONSTANTS
    /** An empty cell */
    public final static char EMPTY = '.';
    /** A cell occupied with grass */
    public final static char GRASS = '#';
    /** A cell occupied with a tent */
    public final static char TENT = '^';
    /** A cell occupied with a tree */
    public final static char TREE = '%';

    // OUTPUT CONSTANTS
    /** A horizontal divider */
    public final static char HORI_DIVIDE = '-';
    /** A vertical divider */
    public final static char VERT_DIVIDE = '|';




    //state constants
    private int dim;

    private int[] rowvalsnum;
    private int[] colvalsnum;
    private char[][] board;

    private int rowpoint;
    private int colpoint;

    /**
     * Construct the initial configuration from an input file whose contents
     * are, for example:<br>
     * <tt><br>
     * 3        # square dimension of field<br>
     * 2 0 1    # row looking values, top to bottom<br>
     * 2 0 1    # column looking values, left to right<br>
     * . % .    # row 1, .=empty, %=tree<br>
     * % . .    # row 2<br>
     * . % .    # row 3<br>
     * </tt><br>
     * @param filename the name of the file to read from
     * @throws FileNotFoundException if the file is not found
     */
    public TentConfig(String filename) throws FileNotFoundException {
        Scanner in = new Scanner(new File(filename));
        String[] rowvals;
        String[] colvals;
        this.rowpoint=0;
        this.colpoint=-1;
        // TO DO
        //Read in dimension, and row/col values
        this.dim=Integer.parseInt(in.nextLine());

        String row=in.nextLine();

        rowvals=row.split(" ");
        this.rowvalsnum=new int[dim];
        for (int i=0; i<dim;i++)
        {
            this.rowvalsnum[i]=Integer.parseInt(rowvals[i]);
        }

        String col=in.nextLine();

        colvals=col.split(" ");
        this.colvalsnum=new int[this.dim];
        for (int i=0; i<this.dim;i++)
        {
            this.colvalsnum[i]=Integer.parseInt(colvals[i]);
        }



        this.board=new char[dim][dim];




        int rowpos=0;
        while(rowpos<this.dim)
        {
            row=in.nextLine();
            row=row.replaceAll(" ","");

            int colpos=0;
            while (colpos<this.dim)
            {



                {
                    this.board[rowpos][colpos]=row.charAt(colpos);
                    colpos++;

                }


            }
            rowpos++;

        }


//        System.out.println();
//        for(int i=0;i<dim;i++)
//        {
//            for(int j=0;j<dim;j++)
//            {
//                System.out.print(board[i][j]);
//            }
//            System.out.println();
//        }




        in.close();

    }

    /**
     * Copy constructor.  Takes a config, other, and makes a full "deep" copy
     * of its instance data.
     * @param other the config to copy
     */
    public TentConfig(TentConfig other)
    {
        // TO DO
        this.rowpoint=other.rowpoint;
        this.colpoint=other.colpoint;
        this.dim=other.dim;
        this.rowvalsnum=new int[other.dim];
        this.colvalsnum=new int[other.dim];
        board=new char[other.dim][other.dim];


        System.arraycopy(other.rowvalsnum,0,this.rowvalsnum,0,other.rowvalsnum.length);
        System.arraycopy(other.colvalsnum,0,this.colvalsnum,0,other.colvalsnum.length);


        for( int i =0; i<dim; i++)
        {
            for( int j =0; j<dim; j++)
            {
                this.board[i][j]=other.board[i][j];
            }
        }
    }

    @Override
    public Collection<Configuration> getSuccessors()
    {
        // TO DO
        //two children possible, tent and no tent



        ArrayList<Configuration> jeff = new ArrayList<Configuration>();

        if (this.colpoint==dim-1 & this.rowpoint==dim-1)
            return jeff;
        else
        {
            if (this.colpoint == dim - 1)
            {
                this.colpoint = 0;
                this.rowpoint += 1;
            } else {
                this.colpoint++;
            }

            if (this.board[rowpoint][colpoint] == '%') {
                TentConfig child1 = new TentConfig(this);

                jeff.add(child1);


            }

            else
            {

                TentConfig child1 = new TentConfig(this);
                child1.board[rowpoint][colpoint] = '^';


                TentConfig child2 = new TentConfig(this);
                child2.board[rowpoint][colpoint] = '#';




                //if is valid?
                jeff.add(child1);

                //if is valid?
                jeff.add(child2);
            }

            return jeff;
        }
    }

    @Override
    public boolean isValid() {
        // TO DO
        boolean valid=true;
        int tcount=0;


            //check row for total val-->


        for(int i=0; i<dim;i++)
        {
            if (this.board[rowpoint][i]=='^')
            {
                tcount++;
            }

            if (tcount>this.rowvalsnum[this.rowpoint])
            {
                valid=false;

            }
        }
        if (colpoint==dim-1)
        {
            if (tcount != this.rowvalsnum[this.rowpoint]) {
                valid = false;
            }
        }



            tcount=0;

            //check col for total val v

            for(int i=0; i<dim;i++)
            {
                if (this.board[i][colpoint]=='^')
                {
                    tcount++;
                }


                if (tcount>this.colvalsnum[this.colpoint])
                {
                    valid=false;

                }
            }
        if (rowpoint==dim-1)
        {
            if (tcount != this.colvalsnum[this.colpoint]) {
                valid = false;
            }
        }



boolean isTree=false;
//check no double tents and every % has 1 tent in 4 directions
        for(int i=0;i<=this.rowpoint;i++)
        {

            for(int j=0;j<=this.colpoint;j++)
            {
                if(i==0& j==0)
                {



                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }





                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }




                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }

                }
                else if (i==0 & j==dim-1)
                {


                    if (this.board[i][j]==this.board[i+1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }







                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }


                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }




                }
                else if (i==dim-1&j==0)
                {

                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }



                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }



                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }








                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }

                }
                else if (i== dim-1& j==dim-1)
                {
                    if (this.board[i][j]==this.board[i-1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }






                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }



                }
                else if (i==0)
                {


                    if (this.board[i][j]==this.board[i+1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }






                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }


                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }

                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }

                }
                else if(j==0)
                {
                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }



                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }




                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }

                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }



                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                }
                else if(i==dim-1)
                {
                    if (this.board[i][j]==this.board[i-1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }



                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }






                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }





                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }

                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }
                }
                else if (j==dim-1)
                {
                    if (this.board[i][j]==this.board[i-1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i+1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }


                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }





                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }



                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }


                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }



                }
                else
                {

                    if (this.board[i][j]==this.board[i-1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i-1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i+1][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }
                    if (this.board[i][j]==this.board[i+1][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i][j-1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }

                    if (this.board[i][j]==this.board[i][j+1] & this.board[i][j]=='^')
                    {
                        valid=false;
                    }



                    //check 1 per tree

                    if (this.board[i-1][j]=='%')
                    {
                        isTree=true;
                    }



                    if (this.board[i+1][j]=='%')
                    {
                        isTree=true;
                    }


                    if (this.board[i][j-1]=='%')
                    {
                        isTree=true;
                    }

                    if (this.board[i][j+1]=='%')
                    {
                        isTree=true;
                    }





                }









            }




        }


















        return valid;              // replace
    }

    @Override
    public boolean isGoal() {
        // TO DO
        return ((this.colpoint==dim-1&this.rowpoint==dim-1)&&this.isValid());









    }

    @Override
    public String toString() {
        // TO DO
        String ret ="";
        ret+=" ";
        for(int i=0;i<this.dim*2-1; i++)
        {
            ret+=("-");
        }
        ret+=(" \n");

        //rows


        for(int i=0;i<dim;i++)
        {
            ret+="|";
            for(int j=0;j<dim;j++)
            {
                ret+=(board[i][j]+" ");
            }
            ret=ret.substring(0,ret.length()-1)+"|"+rowvalsnum[i]+"\n";


        }


        //bottom layers
        ret+=" ";
        for(int i=0;i<this.dim*2-1; i++)
        {
            ret+=("-");
        }
        ret+=(" \n");
        for(int i=0;i<this.dim; i++)
        {
            ret+=(" "+colvalsnum[i]);
        }




        return ret;                 // replace
    }
//
}
