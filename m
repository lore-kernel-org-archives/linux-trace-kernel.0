Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24043DB630;
	Wed,  5 Aug 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910933; cv=none; b=sg/zkavMezMtfvd19S6Bd1btdWKqkMjYlQcfekOEtE5yZaN93Kywe9nsxnPR/m5qMLp8JNtTO/XdUiVPdRVUVy6/7EtBOJvKoOFrV84frISFWKfT62lDk6Ny6a0Cdo0jlJT1IsTQOe38553iWUOqyELN/krDeWxEJuZJo42dvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910933; c=relaxed/simple;
	bh=R2htAVORGjl7QftlxkTLbb2pEi9VrgJn+EJGK4KZJfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4+yzmmwsJEiH0zJcweWEgcWw9lZouyXxdIzXQA3uaGC6pQRzU+naQwLsEReGFzy8dbUFxYIKnne6WDuzzI6PymUtTR9DbK2OByosKvCvWGM1Lo7XLUlgjIQXAT2rQWIEgYEGajzpb3lJLLKMTgdod8ArB51nn1Se0wcoylRt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKL/KrDM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKL/KrDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785910930; x=1817446930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R2htAVORGjl7QftlxkTLbb2pEi9VrgJn+EJGK4KZJfU=;
  b=RKL/KrDM+MFanoKqnZdFlHFPkFS/qJrcl7/sCmaO2reXjfFM2uN4Qwsj
   rjpFvnWVf07vOtNicypym4+uOcsh2/PJLjgFlD/0iWQ0ZZ64HmgQrDB4l
   r5WEk3kC5axZQ6QKp/tUthYH4Dc54d9DbCuFGzOIyNjemSJuIHA17OO9R
   wN0L5oO6OAy2lely4ts3XLoRotrFUtzZZsaVbZ/LGaG1eJwZa8MN2Ux3y
   usCaSarcQHzCXj/X6xaQkUGMYWxyuKP3pcs/rNkG8plNqKzVZfgQ+wqQz
   ZlWPi2Tz2Ncg52/i+xkTsBKFL/CpmkjaqBruj4vUK8QDgY/z5L1YT+C2S
   A==;
X-CSE-ConnectionGUID: 2qtHVnseSMiKi4PdztrfXA==
X-CSE-MsgGUID: +Wa2PZH0QLONfS/7IYvzSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97980960"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97980960"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 23:22:07 -0700
X-CSE-ConnectionGUID: Zwulb0OzQPyil8ivhUNRzw==
X-CSE-MsgGUID: 8uv+kwUiRi6XVUOFhbN/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="285087436"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 04 Aug 2026 23:21:53 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrV0g-000000004M4-37Ok;
	Wed, 05 Aug 2026 06:21:50 +0000
Date: Wed, 5 Aug 2026 08:21:33 +0200
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <202608050839.Ip5dU0Jz-lkp@intel.com>
References: <20260701174829.67ab8a33@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701174829.67ab8a33@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Cleanup-event_enable_trigger_parse-by-using-__free/20260805-073956
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260701174829.67ab8a33%40gandalf.local.home
patch subject: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using __free()
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260805/202608050839.Ip5dU0Jz-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608050839.Ip5dU0Jz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608050839.Ip5dU0Jz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./include/linux/file.h:13,
                    from ./include/linux/kernel_read_file.h:5,
                    from ./include/linux/security.h:26,
                    from kernel/trace/trace_events_trigger.c:8:
   kernel/trace/trace_events_trigger.c: In function 'event_enable_trigger_parse':
>> ./include/linux/cleanup.h:228:22: warning: ignoring return value of '__must_check_fn' declared with attribute 'warn_unused_result' [-Wunused-result]
     228 |         ((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_trigger.c:1842:9: note: in expansion of macro 'no_free_ptr'
    1842 |         no_free_ptr(enable_data);
         |         ^~~~~~~~~~~


vim +228 ./include/linux/cleanup.h

85be6d84244706 Peter Zijlstra 2023-08-15  226  
54da6a0924311c Peter Zijlstra 2023-05-26  227  #define no_free_ptr(p) \
366fef794bd2b7 Ilpo Järvinen  2025-03-10 @228  	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
54da6a0924311c Peter Zijlstra 2023-05-26  229  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
