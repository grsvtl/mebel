<?php
namespace controllers\front\article;
class ArticleFrontController extends \controllers\base\Controller
{
	use	\core\traits\Pager,
		\core\traits\controllers\Meta,
		\core\traits\controllers\Templates,
		\core\traits\controllers\ControllersHandler,
		\core\traits\controllers\RequestLevels,
		\core\traits\UriHandler,
		\core\traits\controllers\Breadcrumbs;

	private $articleObject;

	public function __construct()
	{
		parent::__construct();
	}

	protected function checkDomainAlias($article)
	{
		return $article->getCategory()->domainAlias == $this->getCurrentDomainAlias();
	}

	protected function setArticleLevel($article)
	{
		$category = $article->getCategory();
		if(in_array($category->id, array(\modules\articles\lib\ArticleConfig::NEWS_CATEGORY_ID, \modules\articles\lib\ArticleConfig::INFO_CATEGORY_ID)))
			return $this->setLevel($category->name, $category->getPath())
				->setLevel($article->name);

		return $this->setLevel($article->name);
	}

	protected function checkArticleAlias($alias)
	{
		return $this->getArticleObject()->checkAlias($alias);
	}

	public function getArticle ($alias) {
		$articles = new \modules\articles\lib\Articles();
		return new \modules\articles\lib\Article($articles->getIdByAlias($alias));
	}

	protected function getArticleObject()
	{
		if (!isset($this->articleObject))
			$this->setArticlesObject();
		return $this->articleObject;
	}

	protected function setArticlesObject()
	{
		$this->articleObject = new \modules\articles\lib\Articles();
	}

	protected function setMenuData($category, $status)
	{
		$filters = new \core\FilterGenerator();
		$filters->setSubquery('AND mt.`categoryId` = ?d AND mt.`statusId` = ?d',$category,$status);
		$filters->setOrderBy('`priority` ASC');
		$articles = new \modules\articles\lib\Articles();
		$articles->setFilters($filters);
		return $articles;
	}

	protected function getConfig()
	{
		return $this->getObject('\modules\articles\lib\ArticleConfig');
	}

	protected function getArticlesObject()
	{
		if (empty($this->articles))
			$this->articles = new \modules\articles\lib\Articles();
		return $this->articles;
	}

	public function ajaxGetHeaderPhoneAllocaBlock()
    {
        ob_start();
        $this->includeTemplate('headerPhoneAllocaBlock');
        $contents = ob_get_contents();
        ob_end_clean();
        echo $contents;
    }

    public function ajaxGetFooterPhoneAllocaBlock()
    {
        ob_start();
        $this->includeTemplate('footerPhoneAllocaBlock');
        $contents = ob_get_contents();
        ob_end_clean();
        echo $contents;
    }
}
