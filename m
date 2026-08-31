Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E343A7F7;
	Mon, 31 Aug 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198127; cv=none; b=V+6cmGeT1bcKG24EZzd5/z3YIrpU2uWatuBjQ4XzFJea0w0Sfqrx6s2JO05hf749wbVkk0VjINEZ100Zwy5ha6PUhlbk5O9AsNYRs1aas1g+AQ9QZSkZAROu/zTUXTje80IIo08DYYlFYvIyKBMzZkP4byhtPCd9L54oH6f3wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198127; c=relaxed/simple;
	bh=so8IkYrIFJkKsVHjdJM0GxDIu1LdB+E9VAEbkhZ61ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf9szwgly0ftprc3QzC1+gwS0dTMlzFgaciBDWIwvnxQhrkaA5cYETsTuQErDgOxy/K8OJSeMmm9KegtNQcpegiOg4T73DemX8HjyI/EuyfX0wWWYndHwwPWNv/n8aRMRyFmGW8yyEdgZI5nKXhdW+FbbM8w6FPY38OKy8AUbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xu6RyNmF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xu6RyNmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788198125; x=1819734125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=so8IkYrIFJkKsVHjdJM0GxDIu1LdB+E9VAEbkhZ61ok=;
  b=Xu6RyNmFDon9UDIXi49XVknRMtYleOAglZ9egq4tWn8eW6lN2GV32FbQ
   DfxrWOa0UNmdoB7T/IHZXm8TfKTu4hkpx0xQnAE+/PLF4BlxBHIPRSkMf
   OKFAc39cSJFxdNqkbGrdrUX7gv63vJIbxywMoEUIm8LOpJ6aOU26d5wSy
   Ql46xtVMmq70H63BFMalQQafDlpC2gnWoPI4Xma6x461vQlgJNP07R46P
   jj9Cj41X2WTgYL0YNqYs/8Ma+fgp5KbctH72IBuWeW8WFzHzvMGx+YsiE
   zlsPXH9zC1H7FRfAj5H/hB7IUDOI16iYvVud0bHuDN1KyVtVWh/MHcwCI
   w==;
X-CSE-ConnectionGUID: 1Inxxrg3SueQSEPTVhRupQ==
X-CSE-MsgGUID: AkkGx/UYRPuSaEzSzeFkxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88464527"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88464527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:42:05 -0700
X-CSE-ConnectionGUID: flHojNHIQGebNubr/skqfg==
X-CSE-MsgGUID: 0LietNoWT86T3ePcjh/C2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="265620148"
Received: from igk-lkp-server01.igk.intel.com (HELO 32268bdb9915) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 31 Aug 2026 10:42:02 -0700
Received: from kbuild by 32268bdb9915 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1619-000000000Yf-2gGQ;
	Mon, 31 Aug 2026 17:41:59 +0000
Date: Mon, 31 Aug 2026 19:41:59 +0200
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, tj@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jianshanlai@mail.com,
	rostedt@goodmis.org, mhiramat@kernel.org, osandov@osandov.com,
	atomlin@atomlin.com, neelx@suse.com, sean@ashe.io,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] workqueue: Add workqueue_bh_budget_yield tracepoint
Message-ID: <202608311949.TSPVREg4-lkp@intel.com>
References: <20260829230517.42468-4-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829230517.42468-4-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-wq/for-next]
[also build test ERROR on linus/master v7.3-rc1 next-20260831]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/workqueue-Add-workqueue_cpu_intensive-tracepoint/20260829-190515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20260829230517.42468-4-atomlin%40atomlin.com
patch subject: [PATCH 3/3] workqueue: Add workqueue_bh_budget_yield tracepoint
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260831/202608311949.TSPVREg4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260831/202608311949.TSPVREg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608311949.TSPVREg4-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/workqueue.o: in function `wq_worker_tick':
>> kernel/workqueue.c:1561:(.text+0xa0b6): undefined reference to `__udivdi3'


vim +1561 kernel/workqueue.c

  1522	
  1523	/**
  1524	 * wq_worker_tick - a scheduler tick occurred while a kworker is running
  1525	 * @task: task currently running
  1526	 *
  1527	 * Called from sched_tick(). We're in the IRQ context and the current
  1528	 * worker's fields which follow the 'K' locking rule can be accessed safely.
  1529	 */
  1530	void wq_worker_tick(struct task_struct *task)
  1531	{
  1532		struct worker *worker = kthread_data(task);
  1533		struct pool_workqueue *pwq = worker->current_pwq;
  1534		struct worker_pool *pool = worker->pool;
  1535		u64 dur;
  1536	
  1537		if (!pwq)
  1538			return;
  1539	
  1540		/*
  1541		 * @pwq is shared across CPUs for unbound wqs and this advisory stat is
  1542		 * bumped outside pool->lock, so the update is intentionally racy.
  1543		 */
  1544		data_race(pwq->stats[PWQ_STAT_CPU_TIME] += TICK_USEC);
  1545	
  1546		if (!wq_cpu_intensive_thresh_us)
  1547			return;
  1548	
  1549		/*
  1550		 * If the current worker is concurrency managed and hogged the CPU for
  1551		 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
  1552		 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
  1553		 *
  1554		 * Set @worker->sleeping means that @worker is in the process of
  1555		 * switching out voluntarily and won't be contributing to
  1556		 * @pool->nr_running until it wakes up. As wq_worker_sleeping() also
  1557		 * decrements ->nr_running, setting CPU_INTENSIVE here can lead to
  1558		 * double decrements. The task is releasing the CPU anyway. Let's skip.
  1559		 * We probably want to make this prettier in the future.
  1560		 */
> 1561		dur = (READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at) /
  1562		      NSEC_PER_USEC;
  1563		if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
  1564		    dur < wq_cpu_intensive_thresh_us)
  1565			return;
  1566	
  1567		raw_spin_lock(&pool->lock);
  1568	
  1569		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
  1570		wq_cpu_intensive_report(worker->current_func);
  1571		pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
  1572	
  1573		if (kick_pool(pool))
  1574			pwq->stats[PWQ_STAT_CM_WAKEUP]++;
  1575	
  1576		raw_spin_unlock(&pool->lock);
  1577	
  1578		trace_workqueue_cpu_intensive(pwq, worker->current_work,
  1579					      worker->current_func, dur);
  1580	}
  1581	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
