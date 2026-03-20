Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB463AC0EE;
	Fri, 20 Mar 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012918; cv=none; b=hY21Apnz/WyLsCkNCKi81/EFNo7/uVxjxT4QkfCRJdgZIYbNIOaXfWu+UfHT7RdPi86aD9J9A/GZ+OTkL47mgkj1wyi4DDTGeYWyaUef5Ty9o2cjxob1oclWDjnAYYKoyPYs1X8dg4gw7OTK5aZXybK6GvFeJUldCb4eOl3tdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012918; c=relaxed/simple;
	bh=MOZqXSoMb5xgzqgJiD9GpmF7ivqWpyudHypDRzlzmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAc1xjRLyylhMocZWP8pVeS2EDPbnkuLX7xzdsEYJky3DjlXcQ5kI6p96SJyK39kqw21imKYf6BzCakp1qF7tvXLuSeT0ZZBywlppqKJwFbjYAdIDFHldqcMr56yTwOT1KAk6ECInzEPHvwOF9D0w1YTkfHFqZFEBu4070lOoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH1bvS66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH1bvS66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA160C19425;
	Fri, 20 Mar 2026 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774012917;
	bh=MOZqXSoMb5xgzqgJiD9GpmF7ivqWpyudHypDRzlzmWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sH1bvS66tYWyssScB5U5W+6yI64kW9PEgpfUF/sWtKjITnZDYvB9r9QWkxb43jfGM
	 zenGTMnJrUvbUYr7BSjNH3xYrX4QeMHcdJAG7n0vfv6vC/IDPMlmvZxw/BlGXhfnew
	 1vxTLMpqKhkujwTmBBc249LCJkqMOZnddRHtuPmR+4mEei4v9vGfiCX0WOveVD5mqE
	 sBmQz/YP2sxDQxTC+6T+ielbgQmhmOE6GuOPD+Pu/cot6sy7RANs08qGzCmHWcwXja
	 /XVffeAKWummLz4xiHeuy1RW2l6/RTQxM2PKsI7m5/9UNTGBCav96JgY0HLDtUTu/u
	 H8NCahNA8DG4Q==
Date: Fri, 20 Mar 2026 22:21:56 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Michal Clapinski <mclapinski@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
Message-ID: <ab1J9ODkX5iChu-C@hyeyoo>
References: <20260319233745.GA769346@ax162>
 <abzKcGiRSR_E8lLN@hyeyoo>
 <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>

On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
> On 2026-03-20 00:17, Harry Yoo wrote:
> [...]
> > > [1]: https://lore.kernel.org/20260227153730.1556542-4-mathieu.desnoyers@efficios.com/
> > 
> > @Mathieu: In patch 1/3 description,
> > > Changes since v7:
> > > - Explicitly initialize the subsystem from start_kernel() right
> > >    after mm_core_init() so it is up and running before the creation of
> > >    the first mm at boot.
> > 
> > But how does this work when someone calls mm_cpumask() on init_mm early?
> > Looks like it will behave incorrectly because get_rss_stat_items_size()
> > returns zero?
> 
> It doesn't work as expected at all. I missed that all users of mm_cpumask()
> end up relying on get_rss_stat_items_size(), which now calls
> percpu_counter_tree_items_size(), which depends on initialization from
> percpu_counter_tree_subsystem_init().
> 
> If you add a call to percpu_counter_tree_subsystem_init in
> arch/powerpc/kernel/setup_arch() just before:
> 
>         VM_WARN_ON(cpumask_test_cpu(smp_processor_id(), mm_cpumask(&init_mm)));
>         cpumask_set_cpu(smp_processor_id(), mm_cpumask(&init_mm));
> 
> Does the warning go away ?

Hmm it goes away, but I'm not sure if it is it okay to use nr_cpu_ids
before setup_nr_cpu_ids() is called?

> Alternatively, would could use a lazy initialization invoking
> percpu_counter_tree_subsystem_init from percpu_counter_tree_items_size
> when the initialization is not already done.

So this probably isn't a way to go?

Hmm perhaps we should treat init_mm as a special case in
mm_cpus_allowed() and mm_cpumask().

-- 
Cheers,
Harry / Hyeonggon
