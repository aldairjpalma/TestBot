import Main.BotDriver;
import net.dv8tion.jda.api.entities.Activity;

import javax.security.auth.login.LoginException;

public class TestBot extends BotDriver {
    @Override
    protected void setup() {
        VERSION = "1.0";
        activity = Activity.watching("Test runs!!!");
        TOKEN = "TEST_BOT";
    }
    public TestBot() throws LoginException {
        super();
        shardManager.addEventListener(new TestMain(VERSION));
    }
    public static void main(String[] args) {
        try {
            TestBot bot = new TestBot();
        } catch (LoginException e) {
            System.out.println("ERROR: provided bot token is invalid");
        }
    }
}
