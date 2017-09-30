package com.hikvision.ga.seed.common.dto;

import com.hikvision.ga.common.BaseResult;

/**
 * ajax返回的基础类型
 * @author langyicong
 *
 * @param <T> 数据的泛型
 */
public class AjaxResult<T> extends BaseResult<T> {

  private static final long serialVersionUID = 3940003213432489715L;

  public AjaxResult() {
    super();
    // TODO Auto-generated constructor stub
  }

  public AjaxResult(int type, String code, String msg, T data) {
    super(type, code, msg, data);
    // TODO Auto-generated constructor stub
  }

  public AjaxResult(int type, String code, String msg) {
    super(type, code, msg);
    // TODO Auto-generated constructor stub
  }

  public AjaxResult(String code, String msg) {
    super(code, msg);
    // TODO Auto-generated constructor stub
  }

}
