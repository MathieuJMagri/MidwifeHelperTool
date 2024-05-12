import java.sql.* ;
import java.util.Scanner;  // Import the Scanner class
import java.util.concurrent.ThreadLocalRandom;

class GoBabbyApp
{

    public static void main ( String [ ] args ) throws SQLException
    {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "Table1";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "mmagri1";
        String your_password = "";

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        //START OF PROJECT3 CODE
        String status = "Start";
        System.out.println("Welcome to the GoBabbyApp! ");

        while(status != "E"){

            Scanner myObj1 = new Scanner(System.in);
            System.out.println("Please enter your practitioner id [E] to exit: ");

            String input = myObj1.nextLine();

            if(input.equals("E")){
                System.out.println("Terminating Application ");
                status = "E";
                break;
            }

            int practitionerID = Integer.parseInt(input);  // Read user practitionerID


            if(verification(practitionerID)){

                while(status != "E"){

                    Scanner myObj2 = new Scanner(System.in);
                    System.out.println("Please enter the date for an appointment list [E] to exit: ");
                    String command = myObj2.nextLine();

                    if(command.equals("E")){
                        System.out.println("Terminating Application ");
                        status = "E";
                        break;
                    }

                    Date date = Date.valueOf(command);

                    if(appointments(date, practitionerID)){

                        while(status != "E"){

                            Scanner myObj3 = new Scanner(System.in);
                            System.out.println("Enter the appointment number that you would like to work on. ");
                            System.out.println("        [E] to exit [D] to go back to another date: ");
                            String option = myObj3.nextLine();

                            if(option.equals("E")){
                                System.out.println("Terminating Application ");
                                status = "E";
                                break;
                            }

                            if(option.equals("D")){
                                System.out.println("Heading back to date search ");
                                break;
                            }

                            int appointmentNumber = Integer.parseInt(option);
                            if(appointmentMod(appointmentNumber, date, practitionerID)){
                                System.out.println("Heading back to the appointments menu. ");
                                appointments(date, practitionerID);
                            }else{
                                System.out.println("You have entered an inappropriate appointment number. ");
                                System.out.println("Try another number. ");
                            }

                        }



                    }else{
                        System.out.println("No appointments were found on the requested date. ");
                        System.out.println("Try another date. ");
                    }

                }



            }else{
                System.out.println("As mentioned previously, practitioner ID was not found. ");
                System.out.println("Try again. ");
            };

        }

    }


    private static boolean verification(int practitionerID) throws SQLException {

        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "mmagri1";
        String your_password = "";

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        // Querying practitionerID from practitioner Table
        try
        {
            PreparedStatement preparedQuery = con.prepareStatement("SELECT PractitionerID from Midwife WHERE PractitionerID = ?");
            preparedQuery.setInt(1, practitionerID);
            java.sql.ResultSet rs = preparedQuery.executeQuery();
            while ( rs.next ( ))
            {
                int qpractitionerID = rs.getInt (1);
                if(practitionerID == qpractitionerID){
                    System.out.println ("practitionerID:  " + qpractitionerID);
                    System.out.println ("PractitionerID Found!");

                    // Finally but importantly close the statement and connection
                    statement.close ( ) ;
                    con.close ( ) ;
                    return true;
                }

            }

            System.out.println ("Search is finished, PractitionerID was not found.");

            // Finally, but importantly close the statement and connection
            statement.close ( ) ;
            con.close ( ) ;
            return false;
        }

        catch (SQLException e)
        {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            System.out.println("It seems like this ID does not exist. Try again.");

            // Finally but importantly close the statement and connection
            statement.close ( ) ;
            con.close ( ) ;
            return false;
        }


    }

    private static boolean appointments(Date date, int practitionerID) throws SQLException {
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "mmagri1";
        String your_password = "";

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        // Querying appointments from Appointments Table
        try
        {
            PreparedStatement preparedQuery = con.prepareStatement(
                    "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom, Appointment.PractitionerID AS primaryMidwife\n" +
                            "FROM Appointment, Pregnancy, Couple, BiologicalMom\n" +
                            "WHERE Appointment.PractitionerID = ? AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                            "UNION\n" +
                            "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom,  Appointment.PractitionerID AS primaryMidwife\n" +
                            "FROM Backups, Appointment, Pregnancy, Couple, BiologicalMom\n" +
                            "WHERE Backups.BackupMidwife = ? AND Appointment.PractitionerID =  Backups.PrimaryMidwife AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                            "ORDER BY Time\n");
            preparedQuery.setInt(1, practitionerID);
            preparedQuery.setDate(2, date);
            preparedQuery.setInt(3, practitionerID);
            preparedQuery.setDate(4, date);
            java.sql.ResultSet rs = preparedQuery.executeQuery();
            int count = 1;

            while ( rs.next ( ))
            {

                Time time = rs.getTime(1);
                String MomName = rs.getString(2);
                String QcMomCard = rs.getString(3);
                int midwifeStatus = rs.getInt(4);
                if(midwifeStatus == practitionerID){
                    System.out.println (count + ":" + " " + time + " " + "P" + " " + MomName + " " + QcMomCard + " ");
                }else{
                    System.out.println (count + ":" + " " + time + " " + "B" + " " + MomName + " " + QcMomCard + " ");
                }

                count++;

            }

            System.out.println ("Search is finished.");

            // Finally, but importantly close the statement and connection
            statement.close ( ) ;
            con.close ( ) ;

            if(count != 1){
                return true;
            }else{
                return false;
            }

        }

        catch (SQLException e)
        {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            //System.out.println("It seems like this ID does not exist. Try again.");

            // Finally but importantly close the statement and connection
            System.out.println ("Closing all database connections.") ;
            statement.close ( ) ;
            con.close ( ) ;
            return false;
        }


    }

    private static boolean appointmentMod(int appointmentNumber, Date date, int practitionerID) throws SQLException {
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "mmagri1";
        String your_password = "";

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        // Querying appointments from Appointments Table
        try
        {
            PreparedStatement preparedQuery = con.prepareStatement(
                    "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom, Appointment.PractitionerID AS primaryMidwife\n" +
                            "FROM Appointment, Pregnancy, Couple, BiologicalMom\n" +
                            "WHERE Appointment.PractitionerID = ? AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                            "UNION\n" +
                            "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom,  Appointment.PractitionerID AS primaryMidwife\n" +
                            "FROM Backups, Appointment, Pregnancy, Couple, BiologicalMom\n" +
                            "WHERE Backups.BackupMidwife = ? AND Appointment.PractitionerID =  Backups.PrimaryMidwife AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                            "ORDER BY Time\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            preparedQuery.setInt(1, practitionerID);
            preparedQuery.setDate(2, date);
            preparedQuery.setInt(3, practitionerID);
            preparedQuery.setDate(4, date);
            java.sql.ResultSet rs = preparedQuery.executeQuery();
            int count = 1;

            //Update count variable with all entries in the table
            while ( rs.next ( ))
            {
                count++;

            }

            if(appointmentNumber <= count){

                Connection con2 = DriverManager.getConnection (url,your_userid,your_password) ;
                Statement statement2 = con2.createStatement () ;
                PreparedStatement preparedQuery2 = con.prepareStatement(
                        "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom, Appointment.PractitionerID AS primaryMidwife, Appointment.PregnancyID, Appointment.AppointmentID\n" +
                                "FROM Appointment, Pregnancy, Couple, BiologicalMom\n" +
                                "WHERE Appointment.PractitionerID = ? AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                                "UNION\n" +
                                "SELECT Appointment.Time, BiologicalMom.Name, Couple.QcHealthCardMom,  Appointment.PractitionerID AS primaryMidwife, Appointment.PregnancyID, Appointment.AppointmentID\n" +
                                "FROM Backups, Appointment, Pregnancy, Couple, BiologicalMom\n" +
                                "WHERE Backups.BackupMidwife = ? AND Appointment.PractitionerID =  Backups.PrimaryMidwife AND Appointment.Date = ? AND Appointment.PregnancyID = Pregnancy.PregnancyID AND Pregnancy.CoupleID = Couple.CoupleID AND Couple.QcHealthCardMom = BiologicalMom.QcHealthCard\n" +
                                "ORDER BY Time\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                preparedQuery2.setInt(1, practitionerID);
                preparedQuery2.setDate(2, date);
                preparedQuery2.setInt(3, practitionerID);
                preparedQuery2.setDate(4, date);
                java.sql.ResultSet rs2 = preparedQuery2.executeQuery();

                //Select appropriate appointment from the list
                rs2.absolute(appointmentNumber);


                String MomName = rs2.getString(2);
                String QcMomCard = rs2.getString(3);
                int pregID = rs2.getInt(5);
                int appointmentID = rs2.getInt(6);

                System.out.println ("For " + MomName + " " + QcMomCard + " ");
                System.out.println ();
                System.out.println ("1. Review Notes");
                System.out.println ("2. Review tests");
                System.out.println ("3. Add a note");
                System.out.println ("4. Prescribe a test");
                System.out.println ("5. Go back to appointments");

                boolean optionStatus = false;
                while(optionStatus == false){
                    Scanner reader = new Scanner(System.in);
                    System.out.println ("Enter your choice of action: ");

                    int selectedOption = reader.nextInt();
                    if(option(selectedOption, pregID, appointmentID, practitionerID)){
                        optionStatus = true;
                        return true;
                    }

                    statement2.close ( ) ;
                    statement.close ( ) ;
                    con.close ( ) ;
                    con2.close ( ) ;

//                    System.out.println ("For " + MomName + " " + QcMomCard + " ");
//                    System.out.println ();
//                    System.out.println ("1. Review Notes");
//                    System.out.println ("2. Review tests");
//                    System.out.println ("3. Add a note");
//                    System.out.println ("4. Prescribe a test");
//                    System.out.println ("5. Go back to appointments");

                }

                return true;

            }else{
                // Finally, but importantly close the statement and connection
                System.out.println ("Closing all database connections.") ;
                statement.close ( ) ;
                con.close ( ) ;
                return false;
            }


        }

        catch (SQLException e)
        {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            //System.out.println("It seems like this ID does not exist. Try again.");

            // Finally but importantly close the statement and connection
            System.out.println ("Closing all database connections.") ;
            statement.close ( ) ;
            con.close ( ) ;
            return false;
        }


    }

    private static Boolean option(int selectedOption, int pregID, int appointmentID, int practitionerID) throws SQLException {

        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "mmagri1";
        String your_password = "";

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;

        // Querying appointments from Appointments Table
        try
        {

            int count = 1;

            if(selectedOption == 5){
                System.out.println ("Going back to the appointments menu. ") ;
                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return true;
            }

            if(selectedOption == 1){
                System.out.println ("Reviewing notes: ") ;
                PreparedStatement preparedQuery = con.prepareStatement(
                        "SELECT Note.Date, Note.Time, LEFT(Note.Observation, 50)\n" +
                                "FROM Note, Pregnancy, Appointment\n" +
                                "WHERE Pregnancy.PregnancyID = ? AND Pregnancy.PregnancyID = Appointment.PregnancyID AND Appointment.AppointmentID = Note.AppointmentID\n" +
                                "ORDER BY Note.Date DESC, Note.Time DESC\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                preparedQuery.setInt(1, pregID);
                java.sql.ResultSet rs = preparedQuery.executeQuery();

                while ( rs.next ( ))
                {
                    Date Date = rs.getDate(1);
                    Time Time = rs.getTime(2);
                    String observation = rs.getString(3);
                    System.out.println (Date + " " + Time + " " + observation + " ");

                }

                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return false;

            }

            else if(selectedOption == 2){
                System.out.println ("Reviewing tests: ") ;

                PreparedStatement preparedQuery = con.prepareStatement(
                        "SELECT MedicalTests.DateTestWasPrescribed, MedicalTests.TestType, LEFT(MedicalTests.TestResult, 50)\n" +
                                "FROM MedicalTests\n" +
                                "WHERE MedicalTests.PregnancyID = ?\n" +
                                "ORDER BY MedicalTests.DateTestWasPrescribed DESC\n" +
                                ";", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                preparedQuery.setInt(1, pregID);
                //preparedQuery.setString(2, QcMomCard);
                java.sql.ResultSet rs = preparedQuery.executeQuery();

                while ( rs.next ( ))
                {
                    Date Date = rs.getDate(1);
                    String TestType = rs.getString(2);
                    String TestResult = rs.getString(3);
                    System.out.println (Date + " " + "[" + TestType + "]" + " " + TestResult + " ");

                }

                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return false;
            }

            else if(selectedOption == 3){

                Scanner reader = new Scanner(System.in);
                System.out.println ("Adding a note, please type your observation: ") ;
                String observationToAdd = reader.nextLine();


                // Inserting Data into the table
                try
                {
                    String tableName = "Note";
                    Date date = Date.valueOf(java.time.LocalDate.now());
                    Time time = Time.valueOf(java.time.LocalTime.now());
                    String insertSQL = "INSERT INTO " + tableName + " VALUES (" + appointmentID + ", " +  "\'" + date + "\' , " + "\'" + time + "', " + "\'" + observationToAdd + "')";
                    //System.out.println ( insertSQL ) ;
                    statement.executeUpdate ( insertSQL ) ;
                    System.out.println ( "Note added." ) ;

                }
                catch (SQLException e)
                {
                    sqlCode = e.getErrorCode(); // Get SQLCODE
                    sqlState = e.getSQLState(); // Get SQLSTATE

                    // Your code to handle errors comes here;
                    // something more meaningful than a print would be good
                    System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                    System.out.println(e);
                }


                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return false;

            }

            else if(selectedOption == 4){

                //Might have to change this
                PreparedStatement preparedQuery = con.prepareStatement(
                        "SELECT MedicalTests.TestID\n" +
                                "FROM MedicalTests\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                java.sql.ResultSet rs = preparedQuery.executeQuery();
                int numberOfTests = 1;

                //Update count variable with all entries in the table
                while ( rs.next ( ))
                {
                    numberOfTests++;

                }
                int newTestID = numberOfTests + 1;

                //Might have to change this
                PreparedStatement preparedQuery2 = con.prepareStatement(
                        "SELECT Technician.TechnicianID\n" +
                                "FROM Technician\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                java.sql.ResultSet rs2 = preparedQuery2.executeQuery();
                int numberOfTechIDs = 1;

                //Update count variable with all entries in the table
                while ( rs2.next ( ))
                {
                    numberOfTechIDs++;

                }
                int selectedTechID = ThreadLocalRandom.current().nextInt(0, numberOfTechIDs);

                //Might have to change this
                PreparedStatement preparedQuery3 = con.prepareStatement(
                        "SELECT Lab.LabName\n" +
                                "FROM Lab\n", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                java.sql.ResultSet rs3 = preparedQuery3.executeQuery();
                String LabName = "Something";
                int numOfLabs = 1;

                //Update count variable with all entries in the table
                while ( rs3.next ( ))
                {
                    numOfLabs++;

                }

                int selectedLabNameNum = ThreadLocalRandom.current().nextInt(1, numOfLabs);
                rs3.absolute(selectedLabNameNum);
                LabName = rs3.getString(1);
                String selectedLabName = LabName;


                Scanner reader = new Scanner(System.in);
                System.out.println ("Prescribing a test, please enter the type of test: ") ;
                String prescriptionToAdd = reader.nextLine();


                // Inserting Data into the table
                try
                {
                    String tableName = "MedicalTests";
                    Date date = Date.valueOf(java.time.LocalDate.now());
                    String insertSQL = "INSERT INTO " + tableName + " VALUES (" + newTestID + ", " + "\' PENDING \'" + ", " +  "\'" + prescriptionToAdd + "\'" + ", " + null + ", " + "\'" + date + "\'" + ", " + null + ", " + selectedTechID + ", " + "\'" +  selectedLabName + "\'" + ", " + practitionerID + ", " + null + ", " + pregID + ")";
                    //System.out.println ( insertSQL ) ;
                    statement.executeUpdate ( insertSQL ) ;
                    System.out.println ( "Prescription added." ) ;

                }
                catch (SQLException e)
                {
                    sqlCode = e.getErrorCode(); // Get SQLCODE
                    sqlState = e.getSQLState(); // Get SQLSTATE

                    // Your code to handle errors comes here;
                    // something more meaningful than a print would be good
                    System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                    System.out.println(e);
                }


                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return false;
            }

            else{
                System.out.println ("Did you enter a number from 1 to 5? Try again. ") ;
                // Finally, but importantly close the statement and connection
                statement.close ( ) ;
                con.close ( ) ;
                return false;
            }


        }

        catch (SQLException e)
        {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
            //System.out.println("It seems like this ID does not exist. Try again.");

            // Finally but importantly close the statement and connection
            statement.close ( ) ;
            con.close ( ) ;
            return false;
        }

    }


}

