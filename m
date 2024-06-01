Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0EB645;
	Sat,  1 Jun 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717205755; cv=none; b=VjBqyjtbdRocXDNu4uniZ2XpxFtdJNlqpfgYsTrGZ64odaYOOx8iaA5rWj1GE5jC73PSxRLGnWhvcZ5hiwtmOlwv86JuFv97GmAwrUAYctFAaHlX05gogVyzVeHq9BZNz+HtAtGRApoUAInyZl+E6AWFIX2KOnTemkjB7F3tn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717205755; c=relaxed/simple;
	bh=pm+Pa3NNlbtKgktm3W+jGGufJv5cuomBQKWgb866zbk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=skZiz2TmRApHjXBOoNRsNLzg8PJ49kW34DbWPpQQWq7K5t02mXeZxPezcsKIPFYfSCTa+B6MBqzUeTuZfQwoCQRlbb4B36Qt4ZHQlSDxiajqQQVXSBYRsuw1mAA3xxFN36W2NXwmgJD+5g4JuFbq9LbdR5bzlU6TOu73uQ2tjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM/3Pc57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM/3Pc57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8CFC116B1;
	Sat,  1 Jun 2024 01:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717205754;
	bh=pm+Pa3NNlbtKgktm3W+jGGufJv5cuomBQKWgb866zbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VM/3Pc57q2jCQe4jMoNFxSlA/0yFFxSbxYwak/mjuY/wOeDU99NycqHazcZAlff+9
	 2YLLr1vWxWQMNR3uiPvW6nUEaw+mBJqAyoU7gx9KUiwHGw8t7bh+s386sVxvmwH6oD
	 KmXxJCWQHGXzINajM/ywiCVTtpRh53ywqvXzBOS2MuR06TOlEjkmeCCeGQsoqg1nVf
	 IKgjJU2nzC2lAkvW43a9dRrt0a4+otP5Mf0i3HfK9MAlEytClqZtlNxEvRkRzZHDOP
	 J3pwExvGhSANyL8JK6N4FGAeWJWPMhuUNZ5I6iX/gI/NoxGlpegcsIP8yd0HvrgPOY
	 bUSVecZWxF/ZA==
Date: Sat, 1 Jun 2024 10:35:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, don <zds100@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Support raw tracepoint events on
 modules
Message-Id: <20240601103550.b2db29606319440d51af9753@kernel.org>
In-Reply-To: <202406010034.fsNP9Rsq-lkp@intel.com>
References: <171714888633.198965.13093663631481169611.stgit@devnote2>
	<202406010034.fsNP9Rsq-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 01:01:26 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.10-rc1 next-20240531]
> [cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-fprobe-Support-raw-tracepoint-events-on-modules/20240531-175013
> base:   linus/master
> patch link:    https://lore.kernel.org/r/171714888633.198965.13093663631481169611.stgit%40devnote2
> patch subject: [PATCH] tracing/fprobe: Support raw tracepoint events on modules
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20240601/202406010034.fsNP9Rsq-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010034.fsNP9Rsq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406010034.fsNP9Rsq-lkp@intel.com/

OK, I must be tired... let me fix that. And I'll add a selftest for this case.

Thanks!

> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/tracepoint.c:5:
>    In file included from include/linux/module.h:19:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/s390/include/asm/elf.h:173:
>    In file included from arch/s390/include/asm/mmu_context.h:11:
>    In file included from arch/s390/include/asm/pgalloc.h:18:
>    In file included from include/linux/mm.h:2253:
>    include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      501 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      508 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      520 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      529 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/tracepoint.c:751:34: error: no member named '__start___tracepoints_ptrs' in 'struct module'
>      751 |                 for_each_tracepoint_range(mod->__start___tracepoints_ptrs,
>          |                                           ~~~  ^
>    5 warnings and 1 error generated.
> 
> 
> vim +751 kernel/tracepoint.c
> 
>    738	
>    739	void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>    740					void *priv)
>    741	{
>    742		struct tp_module *tp_mod;
>    743		struct module *mod;
>    744	
>    745		if (!mod->num_tracepoints)
>    746			return;
>    747	
>    748		mutex_lock(&tracepoint_module_list_mutex);
>    749		list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
>    750			mod = tp_mod->mod;
>  > 751			for_each_tracepoint_range(mod->__start___tracepoints_ptrs,
>    752				mod->tracepoints_ptrs + mod->num_tracepoints,
>    753				fct, priv);
>    754		}
>    755		mutex_unlock(&tracepoint_module_list_mutex);
>    756	}
>    757	#endif /* CONFIG_MODULES */
>    758	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
