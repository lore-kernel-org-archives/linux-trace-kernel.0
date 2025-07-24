Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67E13A41F;
	Thu, 24 Jul 2025 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324823; cv=none; b=AWO9eu/5eXuLcIT2Hp0chRtb31pEVzpysnzfHf+QKz1Dp5ZZvoHzAAtT8LZWZI0yAG8WUFmIgvkpE6LuExNEOofuZkz9YeZEAv/PL5t0TmT6ynlAnOZ+IYVv2c64TfpbeIqGZL6mMZ+gfs3WdHSnv5Caj1F9bL+P43IP6JxdPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324823; c=relaxed/simple;
	bh=e1IWKLfwf+Gm+vS9RnjIYq35KCV+QHS/5qqAru5oyLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMawFMCVI8D+veaK4WJP2X+I9awM6MgHQZIWe2jLhqyWPmw9sehhIqqjC9OlTSVwJ8aXqL1GB4klm9UaqFjVhVvpSqbk2fl9EADkKqcpcp+XxrE4W0mnBhzUTO4XISv/NBD26Sl2fM4WWC32Is1wHcUiAHlscT1ngEpvZhGWyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kig69IgF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kig69IgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753324821; x=1784860821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1IWKLfwf+Gm+vS9RnjIYq35KCV+QHS/5qqAru5oyLM=;
  b=Kig69IgF1FyvyLZ0VQmgrC2bcMsyI1jQWj00jx38hothNyGrUswMKM7/
   BgSIDcUaUdGDktDdxACwynNe1pQlbdBAibUy6p8BEwlFDWRdWDTwOrU6l
   VgRValcEezVHgc2zfOEcrwkZY/t748nZRMqD0SR74balh/Ss1xQ5pMj7I
   sLpIENtsHLozcf7F+aTrj0GCthliGcaQPOJKtFGEyHSHI3sZId8ms7V/y
   HJPlGU7WkQ2E0wEe1qJ5sj3UvBHrP94G7kk23ICd8LBJuCYVSPFRK6yTm
   C5aWlqjLV90wNriP2Zu5p+WPr/623/p4RXAsxcsn4BZzkZ8q1/C4BfHQY
   g==;
X-CSE-ConnectionGUID: ROcsxAKfSoK4IsdBSLgCKw==
X-CSE-MsgGUID: 9R46eQ4qTRG5yygGaFIGPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59280766"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="59280766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 19:40:21 -0700
X-CSE-ConnectionGUID: K5b91yXgSJm5kM4pKUbkdw==
X-CSE-MsgGUID: /7sTt8BpTLi1waAcTH2B2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159647355"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2025 19:40:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uelsW-000K15-2k;
	Thu, 24 Jul 2025 02:40:16 +0000
Date: Thu, 24 Jul 2025 10:39:38 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH v2 5/5] rv: Remove struct rv_monitor::reacting
Message-ID: <202507241015.Qun68uPH-lkp@intel.com>
References: <58c63faec76ffb36552fcd1fdcc4b9dd841efd94.1753252872.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c63faec76ffb36552fcd1fdcc4b9dd841efd94.1753252872.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on next-20250723]
[cannot apply to linus/master v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/rv-Remove-unused-field-in-struct-rv_monitor_def/20250723-144825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/58c63faec76ffb36552fcd1fdcc4b9dd841efd94.1753252872.git.namcao%40linutronix.de
patch subject: [PATCH v2 5/5] rv: Remove struct rv_monitor::reacting
config: arc-randconfig-002-20250724 (https://download.01.org/0day-ci/archive/20250724/202507241015.Qun68uPH-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507241015.Qun68uPH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507241015.Qun68uPH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/rv/rv_reactors.c: In function 'monitor_reactors_write':
>> kernel/trace/rv/rv_reactors.c:211:14: warning: variable 'enable' set but not used [-Wunused-but-set-variable]
     211 |         bool enable;
         |              ^~~~~~


vim +/enable +211 kernel/trace/rv/rv_reactors.c

cb85c660fcd4b3a Gabriele Monaco            2025-03-05  201  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  202  static ssize_t
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  203  monitor_reactors_write(struct file *file, const char __user *user_buf,
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  204  		      size_t count, loff_t *ppos)
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  205  {
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  206  	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
98b2531fbe93031 Nam Cao                    2025-07-23  207  	struct rv_monitor *mon;
aef8790cfb7b07f Nam Cao                    2025-07-23  208  	struct rv_reactor *reactor;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  209  	struct seq_file *seq_f;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  210  	int retval = -EINVAL;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29 @211  	bool enable;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  212  	char *ptr;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  213  	int len;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  214  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  215  	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 1)
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  216  		return -EINVAL;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  217  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  218  	memset(buff, 0, sizeof(buff));
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  219  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  220  	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  221  	if (retval < 0)
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  222  		return -EFAULT;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  223  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  224  	ptr = strim(buff);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  225  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  226  	len = strlen(ptr);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  227  	if (!len)
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  228  		return count;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  229  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  230  	/*
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  231  	 * See monitor_reactors_open()
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  232  	 */
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  233  	seq_f = file->private_data;
98b2531fbe93031 Nam Cao                    2025-07-23  234  	mon = seq_f->private;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  235  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  236  	mutex_lock(&rv_interface_lock);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  237  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  238  	retval = -EINVAL;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  239  
aef8790cfb7b07f Nam Cao                    2025-07-23  240  	list_for_each_entry(reactor, &rv_reactors_list, list) {
aef8790cfb7b07f Nam Cao                    2025-07-23  241  		if (strcmp(ptr, reactor->name) != 0)
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  242  			continue;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  243  
aef8790cfb7b07f Nam Cao                    2025-07-23  244  		if (strcmp(reactor->name, "nop"))
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  245  			enable = false;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  246  		else
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  247  			enable = true;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  248  
a96356e99938184 Nam Cao                    2025-07-23  249  		monitor_swap_reactors(mon, reactor);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  250  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  251  		retval = count;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  252  		break;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  253  	}
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  254  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  255  	mutex_unlock(&rv_interface_lock);
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  256  
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  257  	return retval;
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  258  }
04acadcb4453cf8 Daniel Bristot de Oliveira 2022-07-29  259  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
