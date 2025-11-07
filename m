Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE1ACEAF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475552; cv=none; b=WFjTrKg0CqDDYuUN7ytcLIf6nwgqVySKbU8dMipTT2CEgFfSJECHaDmefOKMBBO8gl4bnWNot8JCvUqAl6p1mBKk2dLNQ1W7TFMXtKXUiTYCAPuzqrIZmgM4UwX6qSDXjVYB4+MVYbq3BmYmVWxKHj6jiyGkMlEuhDg++WGUzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475552; c=relaxed/simple;
	bh=kwn44RFmF+ScDQ88lnEFKYUpvFmZuUMwZzCJpYunGhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsXvybxUz/4yfY/nz2xgowaJrPUV6l2ik79crJhwp2zYT7lscF4peWWdjG4A/ttSp8p20IaqFvsCre12xPfLA+Bl2F6BqtQRiLw2T6fnrGmmP80mHIhvM9u/ZwRiGJp6ziAfQHLZYDvk5/Sni1NUPkK5009zkXpkOycQY9hPcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eNzBkg6K; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eNzBkg6K"
Date: Thu, 6 Nov 2025 16:32:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762475546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yS+MdoGbxE+vBEvrR0CnerAzSJJp4Z3mqFdZ5Yqa+T8=;
	b=eNzBkg6Kp9rQ0bVoqyfWj29RngbJ3M1n/97CJR9Q36ISS02qWfS1JkYlK+aDrdOwTdJH2i
	XjFHIdUCx4np7ciNjWCqoFw1MMs6lO4am2h3v3Wr+emlfOMM1TtBzEaqaNbgDUI2Ifzq5V
	O0JzIJJGDKpHnupigi96k+Bnz64SUro=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: kernel test robot <oliver.sang@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <liam.howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, christian.koenig@amd.com
Subject: Re: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-ID: <6hmgutxgdchs4qz6hprwsecwoygwszn5ywixxrvnereilegcsx@mxroaotaw2me>
References: <20251031144232.15284-3-mathieu.desnoyers@efficios.com>
 <202511061432.4e534796-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511061432.4e534796-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 06, 2025 at 02:53:09PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:kworker##Pid" on:
> 
> commit: 25ae03e80acad812e536694c1a07a3f57784ae23 ("[RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large many-core systems")
> url: https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/lib-Introduce-hierarchical-per-cpu-counters/20251031-224455
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20251031144232.15284-3-mathieu.desnoyers@efficios.com/
> patch subject: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large many-core systems
> 
> in testcase: boot
> 
> config: x86_64-randconfig-002-20251103
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> in fact, we observed various BUG:Bad_rss-counter_state_mm issues for this commit
> but clean on parent, as below
> 
> +------------------------------------------------------------------------+------------+------------+
> |                                                                        | 05880dc4af | 25ae03e80a |
> +------------------------------------------------------------------------+------------+------------+
> | BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val:#Comm:kworker##Pid | 0          | 10         |
> | BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:kworker##Pid | 0          | 17         |
> | BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:swapper_Pid  | 0          | 2          |
> | BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:modprobe_Pid | 0          | 3          |
> | BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val:#Comm:modprobe_Pid | 0          | 1          |
> +------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511061432.4e534796-lkp@intel.com
> 
> 
> [   14.858862][   T67] BUG: Bad rss-counter state mm:ffff8881000655c0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:67
> [   14.894890][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_FILEPAGES val:0 Comm:kworker/u9:0 Pid:69
> [   14.896108][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:69

Hmm this shows that percpu_counter_tree_precise_sum() is returning 0 but
percpu_counter_tree_approximate_sum() is off more than
counter->inaccuracy. I have not dig deeper to find why but this needs to
be resolved before considering this series for upstream.
