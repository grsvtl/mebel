<?php
namespace controllers\front\article;
class DanaMebelArticleFrontController extends \controllers\front\article\ArticleFrontController
{
	public function __call($name, $arguments)
	{
		$this->defaultAction();
	}

	public function defaultAction()
	{
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
			if ($this->checkArticleAlias($alias)) {
				$articles = new \modules\articles\lib\Articles();
				$article = $articles->getObjectByAlias($alias);
				if($article->statusId != \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID)
					return $this->redirect404();
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

	public function getTopMenu()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('topMenu', $this->getTopMenuData())
				 ->includeTemplate('articles/topMenu');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function getTopMenuData()
	{
		return $this->setMenuData(\modules\articles\lib\ArticleConfig::TOP_MENU_DANA_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
	}

	public function reviews()
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setLevel('Отзывы')
				->setContent('reviews', $this->getReviewsArticles())
				->includeTemplate('articles/reviews');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	public function  getIndexReviews($limit = false)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('reviews', $this->getReviewsArticles(3))
				 ->includeTemplate('articles/reviewsIndexBlock');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	private function getReviewsArticles($limit = false)
	{
		$config = $this->getConfig();
		$articles = (new \modules\articles\lib\Articles())
					->setSubquery('AND mt.`categoryId` = ?d AND mt.`statusId` = ?d', $config::REVIEWS_DANA_CATEGORY_ID, $config::ACTIVE_STATUS_ID)
					->setOrderBy('`priority` DESC, `date` DESC, `id` DESC');
		return $limit ? $articles->setLimit($limit) : $articles;
	}

	public function sendReview()
	{
		$config = $this->getConfig();

		if(empty($_POST['text'])){
			$this->setObject($config->getObjectsClass())->modelObject->addError('text', 'Напишите ваш отзыв');
			if(empty($_POST['name']))
				$this->setObject($config->getObjectsClass())->modelObject->addError('name', 'Укажите ваше имя');
			return $this->ajax( $this->modelObject->getErrors() );
		}

		$data = array(
			'name' => $_POST['name'],
			'text' => $_POST['text'],
			'categoryId' => $config::REVIEWS_DANA_CATEGORY_ID,
			'statusId' => $config::BLOCKED_STATUS_ID,
			'lastUpdateTime' => '14-05-2016',
			'sitemapPriority' => 'default',
			'changeFreq' => 'always'
		);

		$res = $this->setObject($config->getObjectsClass())->modelObject->add($data);

		if($this->modelObject->errorExists('name'))
			$this->modelObject->removeError('name')->addError('name', 'Укажите ваше имя');
		return $this->ajax( $res );
	}

	public function news()
	{
		if($this->getUriLength() > 1)
			return $this->defaultAction();

//		$cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
//		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
//		if ($contents === false){
			ob_start();
			$this->setLevel('Новости')
				->setContent('news', $this->getNewsArticles())
				->includeTemplate('articles/news');
			$contents = ob_get_contents();
			ob_end_clean();
//			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
//		}
		echo $contents;
	}

	public function  getIndexNews($limit = false)
	{
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
		$contents = \core\cache\Cacher::getInstance()->get($cacheKey);
		if ($contents === false){
			ob_start();
			$this->setContent('news', $this->getNewsArticles(3))
				 ->includeTemplate('articles/newsIndexBlock');
			$contents = ob_get_contents();
			ob_end_clean();
			\core\cache\Cacher::getInstance()->set($contents, $cacheKey);
		}
		echo $contents;
	}

	private function getNewsArticles($limit = false)
	{
		$config = $this->getConfig();
		$articles = (new \modules\articles\lib\Articles())
					->setSubquery('AND mt.`categoryId` = ?d AND mt.`statusId` = ?d', $config::NEWS_DANA_CATEGORY_ID, $config::ACTIVE_STATUS_ID)
					->setOrderBy('`priority` DESC, `date` DESC, `id` DESC');
		return $limit ? $articles->setLimit($limit) : $articles;
	}
}
