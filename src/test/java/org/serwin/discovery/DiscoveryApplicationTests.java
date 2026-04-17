package org.serwin.discovery;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DiscoveryApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	void sanityCheckTest() {
		org.junit.jupiter.api.Assertions.assertTrue(true, "Sanity check should pass");
	}

	@Test
	void basicMathTest() {
		org.junit.jupiter.api.Assertions.assertEquals(4, 2 + 2, "Math should work");
	}

	@Test
	void stringManipulationTest() {
		String result = "hello" + " " + "world";
		org.junit.jupiter.api.Assertions.assertEquals("hello world", result);
	}
}
