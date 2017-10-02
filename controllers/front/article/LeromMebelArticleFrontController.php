<?php
namespace controllers\front\article;
use core\modules\categories\Category;
use modules\articles\lib\ArticleConfig;

class LeromMebelArticleFrontController extends \controllers\front\article\ArticleFrontController
{
    public function __call($name, $arguments)
    {
        $this->defaultAction();
    }

    public function defaultAction()
    {
        if (isset ($this->getREQUEST()[0]))
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
                        $config = new ArticleConfig();
                        if($article->categoryId == $config::TOP_MENU_LEROM_CATEGORY_ID)
                            $this->setLevel($article->category->getName(), $article->category->getPath());
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
        return $this->setMenuData(\modules\articles\lib\ArticleConfig::TOP_MENU_LEROM_CATEGORY_ID, \modules\articles\lib\ArticleConfig::ACTIVE_STATUS_ID);
    }

    public function getTopMenuArticles()
    {
        return $this->getTopMenuData();
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
}