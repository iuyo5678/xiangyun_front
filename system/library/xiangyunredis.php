<?php
/**
 * Created by PhpStorm.
 * User: zhangguhua
 * Date: 15/12/16
 * Time: 下午2:34
 */

use Predis\Client;

/**
 * \Redis
 */
class XiangyunRedis
{
    private $redis;
    private $redis_conf;
    public function __construct($redis_conf) {
        $this -> redis_conf = $redis_conf;
        $this -> redis = new Predis\Client($redis_conf);
    }

    public function set($key,$value,$time=null,$unit=null)
    {
        if ($time) {

            switch ($unit) {
                case 'h':
                    $time *= 3600;
                    break;
                case 'm':
                    $time *= 60;
                    break;
                case 's':
                    break;

                default:
                    throw new InvalidArgumentException('单位只能是 h m s ms');
                    break;
            }
            $client = new Predis\Client($this->redis_conf);
            self::_setex($key,$value,$time);


        } else {

            $this -> redis ->set($key,$value);

        }
    }

    public function get($key)
    {
        return $this -> redis ->get($key);
    }

    public function delete($key)
    {

        return $this -> redis ->del($key);
    }

    private function _setex($key,$value,$time)
    {
        $this -> redis ->setex($key,$time,$value);
    }

    private function _psetex($key,$value,$time)
    {
        self::psetex($key,$time,$value);
    }
}