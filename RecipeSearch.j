RecipeSearchCache.java (JD wrote this)
import java.util.List;
// Google Guava Cache
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
public class RecipeSearchCache {
	static Cache<String, List<Recipe>> cache = CacheBuilder.newBuilder()
		.maximumSize(10000)
		.build();
	static List<Recipe> getRecipesByIngredients(String ingredient1, String ingredient2, String
ingredient3, String ingredient4, String ingredient5, String ingredient6, String ingredient7, String
ingredient8) {
		String key = ingredient1 + ingredient2 + ingredient3 + ingredient4 + ingredient5 +
ingredient6 + ingredient7 + ingredient8;

		List<Recipe> recipeList = cache.getIfPresent(key);
		if (recipeList == null) {
			recipeList = RecipeSearch.getRecipesByIngredients(ingredient1, ingredient2,
ingredient3, ingredient4, ingredient5, ingredient6, ingredient7, ingredient8);
			cache.put(key, recipeList);
		}
		return recipeList;
	}
}

RecipeSearchCacheTest.java (JD wrote this)
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertTrue;
public class RecipeSearchCacheTest {
	@Test
	public void getRecipeByIngredientCache() {
		List<Recipe> recipeList1 = RecipeSearchCache.getRecipesByIngredients("chicken", null,
null, null, null, null, null, null);
		List<Recipe> recipeList2 = RecipeSearchCache.getRecipesByIngredients("chicken", null,
null, null, null, null, null, null);
		// Validate that recipeList1 and recipeList2 are the same object
		assertTrue(recipeList1 == recipeList2);
	}
}
