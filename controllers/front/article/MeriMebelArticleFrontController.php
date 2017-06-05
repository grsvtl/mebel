<?php
namespace controllers\front\article;
use core\modules\images\Images;
use modules\articles\lib\ArticleConfig;
use modules\articles\lib\Articles;

class MeriMebelArticleFrontController extends \controllers\front\article\ArticleFrontController
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
                    else
                        return $this->redirect404();
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
		return $this->setMenuData(\modules\articles\lib\ArticleConfig::TOP_MENU_MERI_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
	}

	public function reviews()
	{
        if($this->getSERVER()['REQUEST_URI'] != '/reviews/')
            if($this->getSERVER()['REQUEST_URI'] != '/reviews/?')
                $this->redirect404();

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
        return $this->setContent('reviews', $this->getReviewsArticles($limit))
				    ->includeTemplate('articles/reviewsIndexBlock');
	}

	private function getReviewsArticles($limit = false)
	{
		$config = $this->getConfig();
		$articles = (new \modules\articles\lib\Articles())
					->setSubquery('AND mt.`categoryId` = ?d AND mt.`statusId` = ?d', $config::REVIEWS_MERI_CATEGORY_ID, $config::ACTIVE_STATUS_ID)
					->setOrderBy('`priority` DESC, `date` DESC, `id` DESC');
		return $limit ? $articles->setLimit($limit) : $articles;
	}

	public function view404()
    {
	    if($this->getSERVER()['REQUEST_URI'] != '/404/'){
            header('Location: /404/');
            die();
        }
        $cacheKey = md5($this->getCurrentDomainAlias().'-'.__METHOD__.serialize($this->getREQUEST()->getArray()));
        $contents = \core\cache\Cacher::getInstance()->get($cacheKey);
        if ($contents === false){
            ob_start();
            $this->setLevel('404')
                ->includeTemplate('articles/404');
            $contents = ob_get_contents();
            ob_end_clean();
        }
        echo $contents;
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

	public function sendReviewPhoto()
    {
        $article = (new Articles())->getObjectById($this->getPOST()['reviewId']);
        if(!$article)
            return $this->ajaxResponse(0);
        if(!count($_FILES))
            return $this->ajaxResponse(1);

        $fileName = $_FILES[0]['name'];
        move_uploaded_file($_FILES[0]["tmp_name"], DIR.'/tmp/images/'.$fileName);

        $image = array(
            'name' => $fileName,
            'tmpName' => '/tmp/images/'.$fileName,
            'title' => '',
            'alias' => '',
            'statusId' => 1,
            'categoryId' => 1,
            'description' => ''
        );
        $this->getObject('\core\modules\images\Images', $article)->add($image);

        $this->ajaxResponse(1);
    }
}
