Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEC27CCF0;
	Fri, 21 Nov 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769242; cv=none; b=jyUdM0J7pbfZHGZj+Pu6JU/L5JlQmW8033DscLrKAkIzdgHQaMSBLv8i631FQgZ96dPPuMqZmKW56ClXbKiquo72RWB/o+8q+vvu7hzmsLCxk/e+DKfCSsPMwKIg6wBupTZ2sZt71dm4l8Hu8h33DEOGJ5ebEKts1wvJpVc/Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769242; c=relaxed/simple;
	bh=+Hg4/uQp+OeE7UO4Lhn7lv201SeLX6uGguDNgBxO6Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf2HmL9oSdssAJqU9GtsZjlZho/bhLnGqCeLlcmaTdoZbWWfGWkctHOrZdEnpsQWAJCBEHJHjApAu//bPlHCkiEqUcu0qmyABBB+HpD9qEI2ejuo1eKEE/3LTo57bh5IsgSBNBcNg0+rdUL0m4h0JPzMI0bDsst7nEM9cQCKbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JakpdGb7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JakpdGb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763769241; x=1795305241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Hg4/uQp+OeE7UO4Lhn7lv201SeLX6uGguDNgBxO6Ug=;
  b=JakpdGb74ZjCwPy8yFIqGgoCEKWSc1yGXBxcrnVEDqVZj128ORE8d+sG
   I+rd/xsqpaH9Kcr8uHVH9Yl8cJR8QJARgFlHbofqphHLVWCLATvyGo3eO
   u56+bFVn/aa+QLA3sKEzdXUqxvF5YyCYfroTzFEnUP+/5kMgv2P6bY4fW
   EJBCo4yLFpMTNuVGGvHs9lLhKeGNrbSv52I74czi2wqjwOUbbbNyuHfmy
   Ga09DBvZ4NjRPgvdBBthX/tT96tf54CLIwMbuk9gFf/BBPYHQN2P9hn0I
   +Aq24p2wH5H+kAsmFs5CY6P0b0sVtxd7zRJF6YZHjnFtqaJ6BIA5TLQ7M
   g==;
X-CSE-ConnectionGUID: /Olxr+U1Q9iUFYDaD08ZNg==
X-CSE-MsgGUID: eUEbuMcaS3+tItNHEhwI3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65899376"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="65899376"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 15:54:01 -0800
X-CSE-ConnectionGUID: q8dn3dlbReeo+c7icmGweQ==
X-CSE-MsgGUID: 0l7lTL8JSfqvktlDz7OQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="192076161"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 21 Nov 2025 15:53:58 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMawu-0006z5-0A;
	Fri, 21 Nov 2025 23:53:56 +0000
Date: Sat, 22 Nov 2025 07:53:36 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add system trigger file to enable triggers for
 all the system's events
Message-ID: <202511220730.PQFWRcck-lkp@intel.com>
References: <20251120160003.2fa33d80@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120160003.2fa33d80@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Add-system-trigger-file-to-enable-triggers-for-all-the-system-s-events/20251121-050454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251120160003.2fa33d80%40gandalf.local.home
patch subject: [PATCH] tracing: Add system trigger file to enable triggers for all the system's events
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20251122/202511220730.PQFWRcck-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220730.PQFWRcck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220730.PQFWRcck-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events_trigger.c:432:6: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     432 |         int len;
         |             ^
   1 warning generated.


vim +/len +432 kernel/trace/trace_events_trigger.c

   420	
   421	static ssize_t
   422	event_system_trigger_write(struct file *filp, const char __user *ubuf,
   423			    size_t cnt, loff_t *ppos)
   424	{
   425		struct trace_subsystem_dir *dir = filp->private_data;
   426		struct event_command *p;
   427		char *command, *next;
   428		char *buf __free(kfree) = get_user_buf(ubuf, cnt);
   429		bool remove = false;
   430		bool found = false;
   431		ssize_t ret;
 > 432		int len;
   433	
   434		if (!buf)
   435			return 0;
   436	
   437		if (IS_ERR(buf))
   438			return PTR_ERR(buf);
   439	
   440		/* system triggers are not allowed to have counters */
   441		if (strchr(buf, ':'))
   442			return -EINVAL;
   443	
   444		/* If opened for read too, dir is in the seq_file descriptor */
   445		if (filp->f_mode & FMODE_READ) {
   446			struct seq_file *m = filp->private_data;
   447			dir = m->private;
   448		}
   449	
   450		/* Skip added space at beginning of buf */
   451		next = buf;
   452		strim(next);
   453	
   454		command = strsep(&next, " \t");
   455		if (next) {
   456			next = skip_spaces(next);
   457			if (!*next)
   458				next = NULL;
   459		}
   460		if (command[0] == '!') {
   461			remove = true;
   462			command++;
   463		}
   464	
   465		len = strlen(command);
   466		if (next)
   467			len += strlen(next) + 1;
   468	
   469		guard(mutex)(&event_mutex);
   470		guard(mutex)(&trigger_cmd_mutex);
   471	
   472		list_for_each_entry(p, &trigger_commands, list) {
   473			/* Allow to remove any trigger */
   474			if (!remove && !(p->flags & EVENT_CMD_FL_SYSTEM))
   475				continue;
   476			if (strcmp(p->name, command) == 0) {
   477				found = true;
   478				ret = process_system_events(dir, p, buf, command, next);
   479				break;
   480			}
   481		}
   482	
   483		if (!found)
   484			ret = -ENODEV;
   485	
   486		if (!ret)
   487			*ppos += cnt;
   488	
   489		if (remove || ret < 0)
   490			return ret ? : cnt;
   491	
   492		return cnt;
   493	}
   494	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
