
import java.util.Scanner;
import java.util.Random;

public class havasta 
{
	static final Scanner User = new Scanner(System.in);
	static int Rounds = 0;
	static int Wins = 0;
	static int Losses = 0;
	

	public static void GameStart()
	{
		System.out.println();
		System.out.println("Do you want to play? (Y/N)");
		String start = User.next();

		if (start.equalsIgnoreCase("Y") || start.equalsIgnoreCase("Yes"))
		{
			Rounds++;
			Havasta();
		}
	    else if (start.equalsIgnoreCase("N") || start.equalsIgnoreCase("No"))
	    {
	    	System.out.println("Thanks for Playing");
	    	System.out.println("Rounds Played: "+Rounds);
	    	System.out.println("	 Wins: "+Wins);
	    	System.out.println("       Losses: "+Losses);
	    	if (Wins > Losses)
	    	{
	    		System.out.println("You won " + Wins + "(W)-" + Losses + "(L).");
	    	}
	    	else if (Losses > Wins)
	    	{
	    		System.out.println("You lost " + Wins + "(W) to " + Losses + "(L).");
	    	}
	    	else if (Wins == Losses)
	    	{
	    		System.out.println("You tired" + Wins + "(W) to " + Losses + "(L).");
	    	}
	    	System.exit(0);
	    }
	    else
	    {
	    	System.out.println("Please Respond 'Yes' or 'No'");
	    	GameStart();
	    }
	}
	
	public static void Havasta()
	{
		int A=1;
		int B=4;
	    Random rnd = new Random();
	    int x = rnd.nextInt(B)+A;
	    String CPUmove = "";
	    
	    if(x == 1)
	    {
	    	CPUmove = "Applaro";
	    }
	    else if(x == 2)
	    {
	    	CPUmove = "Svartra";
	    }
	    else if(x == 3)
	    {
	    	CPUmove = "Tunholmen";
	    }
	    else if(x == 4)
	    {
	    	CPUmove = "Godafton";
	    }
	    
		System.out.println("Choose a move");
		String move = User.next();
		
		System.out.println("Your Move: "+move);
		System.out.println("CPU Move : "+CPUmove);
		
		if(move.equalsIgnoreCase("Applaro"))
		{
			UserApp(CPUmove);
			GameStart();
		}
		else if(move.equalsIgnoreCase("Svartra"))
		{
			UserSva(CPUmove);
			GameStart();
		}	
		else if(move.equalsIgnoreCase("Tunholmen"))
		{
			UserTun(CPUmove);
			GameStart();
		}	
		else if(move.equalsIgnoreCase("Godafton"))
		{
			UserGod(CPUmove);
			GameStart();
		}	
		else;
		{
			System.out.println("Please enter a legal move.");
			System.out.println("(Applaro, Svartra, Tunholmen, or Godafton)");
			Havasta();
		}
	}
	
// Methods for deciding who wins
	public static void UserApp(String CPUmove)
	{
		System.out.println("---------------------------------------------------------");
		if(CPUmove.equalsIgnoreCase("Svartra") || CPUmove.equalsIgnoreCase("Tunholmen"))
		{
			System.out.println("YOU WIN");
			Wins++;
		}
		else if(CPUmove.equalsIgnoreCase("Godafton") || CPUmove.equalsIgnoreCase("Applaro"))
		{
			System.out.println("YOU LOSE");
			Losses++;
		}
	}
	public static void UserSva(String CPUmove)
	{
		System.out.println("---------------------------------------------------------");
		if(CPUmove.equalsIgnoreCase("Tunholmen"))
		{
			System.out.println("YOU WIN");
			Wins++;
		}
		else if(CPUmove.equalsIgnoreCase("Godafton") || CPUmove.equalsIgnoreCase("Applaro") || CPUmove.equalsIgnoreCase("Svartra"))
		{
			System.out.println("YOU LOSE");
			Losses++;
		}
	}
	public static void UserTun(String CPUmove)
	{
		System.out.println("---------------------------------------------------------");
		if(CPUmove.equalsIgnoreCase("Godafton"))
		{
			System.out.println("YOU WIN");
			Wins++;
		}
		else if(CPUmove.equalsIgnoreCase("Svartra") || CPUmove.equalsIgnoreCase("Applaro") || CPUmove.equalsIgnoreCase("Tunholmen"))
		{
			System.out.println("YOU LOSE");
			Losses++;
		}
	}
	public static void UserGod(String CPUmove)
	{
		System.out.println("---------------------------------------------------------");
		if(CPUmove.equalsIgnoreCase("Applaro") || CPUmove.equalsIgnoreCase("Svartra"))
		{
			System.out.println("YOU WIN");
			Wins++;
		}
		else if(CPUmove.equalsIgnoreCase("Tunholmen") || CPUmove.equalsIgnoreCase("Godafton"))
		{
			System.out.println("YOU LOSE");
			Losses++;
		}
	}
	
	
	//////////////////////////////////////////////////
	
	public static void main(String args[]) 
	{
		System.out.println("Rules:");
		System.out.println("Applaro beats Svartra and Tunholmen");
		System.out.println("Svartra beats Tunholmen");
		System.out.println("Tunholmen beats Godafton");
		System.out.println("Godafton beats Applaro and Svartra");
		System.out.println("The computer wins ties");
		System.out.println();

		GameStart();
	}
}
