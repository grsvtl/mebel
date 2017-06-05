<?php
namespace controllers\front\article;
use modules\articles\lib\Article;

class VnMebelArticleFrontController extends \controllers\front\article\ArticleFrontController
{
	public function __call($name, $arguments)
	{
		if ($this->redirectToCatalogController())
			return;
		$this->defaultAction();
	}

	private function redirectToCatalogController()
	{
		if (isset($this->catalogRedirects[$this->getREQUEST()['action']])){
			$method = $this->catalogRedirects[$this->getREQUEST()['action']];
			if (isset($method)) {
				$this->catalogController->$method();
				return true;
			}
		}
		return false;
	}

	public function defaultAction()
	{
		if (!$this->action && $this->getSERVER()['REQUEST_URI']=='/')
			$this->action = 'viewIndex';
		if(isset ($this->getREQUEST()[0]))
			$this->action = $this->getREQUEST()[0];
		if ($this->actionExists($this->action)) {
			$action = $this->action;
			$this->$action();
		} else
			$this->viewArticle($this->action);
	}

	public function viewArticle($alias)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			if($this->checkFabricatorAlias($alias))
				return $this->viewFabricatorPage($alias);
			if ($this->checkArticleAlias($alias)) {
				$articles = new \modules\articles\lib\Articles();
				$article = $articles->getObjectByAlias($alias);
				if ($this->checkDomainAlias($article)){
					if ($article->isValidPath($this->getSERVER()['REQUEST_URI'])){
						ob_start();
						$this->setArticleLevel($article)
							->setContent('article', $article)
							->setMetaFromObject($article)
							->includeTemplate('articles/article');
						$contents = ob_get_contents();
						ob_end_clean();
						\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
					}
				}
				else
					return $this->redirect404();
			}
			else
				return $this->redirect404();
		}
		echo $contents;
	}

	private function checkFabricatorAlias($alias)
	{
		$fabricators = new \modules\fabricators\lib\Fabricators();
		return $fabricators->checkAlias($alias);
	}

	private function viewFabricatorPage($alias)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			$fabricators = new \modules\fabricators\lib\Fabricators();
			$fabricator = $fabricators->getObjectByAlias($alias);
			if ($fabricator->isValidPath($this->getSERVER()['REQUEST_URI'])){
				ob_start();
				$this->setArticleLevel($fabricator)
					->setContent('fabricator', $fabricator)
					->setMetaFromObject($fabricator)
					->includeTemplate('fabricator');
				$contents = ob_get_contents();
				ob_end_clean();
				\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
			}
			else
				return $this->redirect404();
		}
		echo $contents;
	}

	public function getTopMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('topMenu', $this->setMenuData(\modules\articles\lib\ArticleConfig::TOP_MENU_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID))
				 ->includeTemplate('articles/topMenu');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function getFooterMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('footerMenu', $this->setMenuData(\modules\articles\lib\ArticleConfig::TOP_MENU_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID))
				 ->includeTemplate('articles/footerMenu');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;

	}

	public function getServicesMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$servicesMenu = $this->setMenuData(\modules\articles\lib\ArticleConfig::SERVICES_MENU_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
			$this->setContent('servicesMenu', $servicesMenu)
				 ->includeTemplate('articles/servicesMenu');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function getFooterServicesMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			$servicesMenu = $this->setMenuData(\modules\articles\lib\ArticleConfig::SERVICES_MENU_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
			$this->setContent('footerServicesMenu', $servicesMenu)
				 ->includeTemplate('articles/footerServicesMenu');

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function articles()
	{
		if($this->isFirstRequestLevel())
			$this->viewArticle($this->getREQUEST()[0]);
		else
			$this->redirect404();
	}

	public function getNewsArticles($quantity = false)
	{
		$news = $this->setMenuData(\modules\articles\lib\ArticleConfig::NEWS_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
		$news->setOrderBy('`priority` DESC, `date` DESC, `id` DESC');
		if($quantity)
			$news->setLimit($quantity);
		return $news;
	}

	public function getInfoArticles($quantity = false)
	{
		$news = $this->setMenuData(\modules\articles\lib\ArticleConfig::INFO_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
		$news->setOrderBy('`priority` DESC, `date` DESC, `id` DESC');
		if($quantity)
			$news->setLimit($quantity);
		return $news;
	}

	public function info()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();

			if ($this->isZeroRequestLevel()) {
				$news = $this->getInfoArticles();
				$this->setLevel('Информация');
				$this->setContent('objects', $news->setQuantityItemsOnSubpageList(array(20))->setPager(2))
					 ->setMetaFromObject($news->getCategories()->getObjectById(\modules\articles\lib\ArticleConfig::INFO_CATEGORY_ID))
					 ->includeTemplate('articles/news');
			} elseif($this->isFirstRequestLevel()){
				$this->viewArticle($this->getREQUEST()[0]);
			} else {
				$this->redirect404();
			}

			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function getMainSmallImagesArticle()
    {
        return new Article(\modules\articles\lib\ArticleConfig::IMAGES_SMALL_MAIN_MEBEL);
    }

    public function getMainBigImagesArticle()
    {
        return new Article(\modules\articles\lib\ArticleConfig::IMAGES_BIG_MAIN_MEBEL);
    }
}
