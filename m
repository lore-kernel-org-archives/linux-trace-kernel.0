Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7512BD11;
	Mon, 23 Mar 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230783; cv=none; b=reQli53PDH+NSFfU2pSMKv56jXSNy1G/6bGoJ/q84DNK8my9YA/Ydj5vrdwL/ixCSAY5gvSVgoyh0Gu/CeEu9d49LdhBZt7KWaC8DM/Kum7AydCHMzRcSKKMVXRa1Ym+aPTmuyNrcnmDQP259ZOqpOL/pYl35Vgp3cufmE8Av6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230783; c=relaxed/simple;
	bh=eUGwd2FAzA5WsiNrJdTb7+mmPtzV/iRzisXP37+yIOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDT6O2frohXU84cY2MQzIfOpxbKgi0suP+zXrdkz74gHpUGTmb7ELWcRGamMhHFkLBUhY6hhnuy2Vi/c/8SkAwhUpK9Am2rZfBmRGt6Me1BImQAZdQPg3tgB4Ajn7vhzWsBN+fzuGrhVTWJbPFQ7dbkXoAq8S3Vlw94qvfNz2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syGQ+FQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syGQ+FQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154BEC19424;
	Mon, 23 Mar 2026 01:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774230782;
	bh=eUGwd2FAzA5WsiNrJdTb7+mmPtzV/iRzisXP37+yIOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syGQ+FQnov4Tm8PYgxMjcq3vLADnywVtS9reKDajj0+znmyAerMZrH5Bmdg2FOQw2
	 XrwXDV4R6w20VOZUsdO8d/XtLjnP2PZImEb5d9iQ4Tp5qHQcqvO8JeiCiJ40EI2CNv
	 ghpLImDXY9r6GQe2cWOuYJFdSfySOPJNBKKqX5YqYJglvtSlYXGXV9PGSvickmseIR
	 sy9adD0LWiQEIIjeXZRnwq8SxXJ0mYKuMEuOM+sjPLlokP6XH9C0xno6sX0OmpBkBL
	 bfFA+Bw4VDchWqb2P/HHTW1XjNByKOytC+lK78FWi+R3zqsnqJb1AOLIXyL7UceCmA
	 +pgd2O+Uaif7A==
Date: Mon, 23 Mar 2026 10:53:00 +0900
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
Message-ID: <acCc_AJyxSS98r-P@hyeyoo>
References: <20260319233745.GA769346@ax162>
 <abzKcGiRSR_E8lLN@hyeyoo>
 <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
 <ab1J9ODkX5iChu-C@hyeyoo>
 <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>

On Fri, Mar 20, 2026 at 09:31:57AM -0400, Mathieu Desnoyers wrote:
> On 2026-03-20 09:21, Harry Yoo (Oracle) wrote:
> > On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
> > > On 2026-03-20 00:17, Harry Yoo wrote:
> > > [...]
> > > > > [1]: https://lore.kernel.org/20260227153730.1556542-4-mathieu.desnoyers@efficios.com/
> > > > 
> > > > @Mathieu: In patch 1/3 description,
> > > > > Changes since v7:
> > > > > - Explicitly initialize the subsystem from start_kernel() right
> > > > >     after mm_core_init() so it is up and running before the creation of
> > > > >     the first mm at boot.
> > > > 
> > > > But how does this work when someone calls mm_cpumask() on init_mm early?
> > > > Looks like it will behave incorrectly because get_rss_stat_items_size()
> > > > returns zero?
> > > 
> > > It doesn't work as expected at all. I missed that all users of mm_cpumask()
> > > end up relying on get_rss_stat_items_size(), which now calls
> > > percpu_counter_tree_items_size(), which depends on initialization from
> > > percpu_counter_tree_subsystem_init().
> > > 
> > > If you add a call to percpu_counter_tree_subsystem_init in
> > > arch/powerpc/kernel/setup_arch() just before:
> > > 
> > >          VM_WARN_ON(cpumask_test_cpu(smp_processor_id(), mm_cpumask(&init_mm)));
> > >          cpumask_set_cpu(smp_processor_id(), mm_cpumask(&init_mm));
> > > 
> > > Does the warning go away ?
> > 
> > Hmm it goes away, but I'm not sure if it is it okay to use nr_cpu_ids
> > before setup_nr_cpu_ids() is called?
> 
> AFAIU on powerpc setup_nr_cpu_ids() is called near the end of
> smp_setup_cpu_maps(), which is called early in setup_arch,
> at least before the two lines which use mm_cpumask.

Right.

> > > Alternatively, would could use a lazy initialization invoking
> > > percpu_counter_tree_subsystem_init from percpu_counter_tree_items_size
> > > when the initialization is not already done.
> > 
> > So this probably isn't a way to go?
> 
> I'd favor explicit initialization, so the inter-dependencies are clear.

Ack.

> > Hmm perhaps we should treat init_mm as a special case in
> > mm_cpus_allowed() and mm_cpumask().
> 
> I'd prefer not to go there if boot sequence permits and keep things
> simple.
> 
> I think we're in a situation very similar to tree RCU, here is what
> is done in rcu_init_geometry:
> 
>         static bool initialized;
> 
>         if (initialized) {
>                 /*
>                  * Warn if setup_nr_cpu_ids() had not yet been invoked,
>                  * unless nr_cpus_ids == NR_CPUS, in which case who cares?
>                  */
>                 WARN_ON_ONCE(old_nr_cpu_ids != nr_cpu_ids);
>                 return;
>         }
> 
>         old_nr_cpu_ids = nr_cpu_ids;
>         initialized = true;

Yeah, as long as nr_cpus_order doesn't change after init,
that will work for HPCC. powerpc seems to be a special case that calls
mm_cpumask() very early in the boot process, so explicitly calling the
init function seems to be fair.

By the way, thinking about it differently - it would probably be simpler
to just eliminate mm_cpumask's dependency on HPCC init dependency by
placing those cpumasks before percpu counter tree items... (but yeah,
that would make mm_struct a bit larger due to alignment requirements)

-- 
Cheers,
Harry / Hyeonggon
