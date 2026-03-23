Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2720B80B;
	Mon, 23 Mar 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230839; cv=none; b=EP/X7yEAWIuAmTB6PrRIrKcR54JMUGnN35kCDI5nZrJc0Ub9hnRFPjjNJ5iXfYJg/clY/RYSSlTU5N96+YmHcvuxInoy1E1BrfJnkGQ7QlHcTqyMJNIrf+3ygwpgttbmc0eRIPj8he8LJYG2B3ooeS9GLFHTgaUBLvN8PKmG1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230839; c=relaxed/simple;
	bh=ruC9HWF9oEK5XETPcyJHTSXZVrQdPQPIQsXjSrBOX+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS2na2aTZTvNsZe9cp7kGMMckqyZra0hkPQvFVmGn1TXpBypNYosy8TfrpBo5ROsMyjP4FeKd7Uso8znsCGF8krSU6yBCOj1o+y6466m/tYhMv3dyoStgdN4F1KwJiFHVsx3zUbWC7nYrmPSWgCbuqR/hShIiFayTGqxBwQ7/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjOwOV8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjOwOV8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C0C19424;
	Mon, 23 Mar 2026 01:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774230839;
	bh=ruC9HWF9oEK5XETPcyJHTSXZVrQdPQPIQsXjSrBOX+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjOwOV8G1UiUJj0rYo3i3CjWTQsqdK4Y3ob3KXpGLF/fLE7rSmAwIbvrJqA/D9yrv
	 jJQYi6st2sdrgA9J31dkO5SIddorWAN15xloNrijFdByxAbJcv+4YFcMc3NK2GCMxW
	 tWrEA2wx6C1zknjNJo9sjNXJeTrl+Sj7ZY96gHqMD82AHbVlbt2BYKOynF4iRnnzJ2
	 5cCy3JyMbOoFb1iZHQ5PTGeuT8Oks/dnxp+VMab/esljySMyBH0s/SwmG9j2XPd7LI
	 eyDTNY1/G1JwNS1C+VI/Wl9m9bB7/WZVqlS95izhV8pqVx6DORMo2FTFLwzNDVp/kN
	 o75KfJ1c5h2rg==
Date: Mon, 23 Mar 2026 10:53:57 +0900
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
Message-ID: <acCdNX58PwLyDJON@hyeyoo>
References: <20260319233745.GA769346@ax162>
 <abzKcGiRSR_E8lLN@hyeyoo>
 <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
 <ab1J9ODkX5iChu-C@hyeyoo>
 <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
 <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>

On Fri, Mar 20, 2026 at 10:20:37AM -0400, Mathieu Desnoyers wrote:
> On 2026-03-20 09:31, Mathieu Desnoyers wrote:
> > On 2026-03-20 09:21, Harry Yoo (Oracle) wrote:
> > > On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
> > > > On 2026-03-20 00:17, Harry Yoo wrote:
> > > > [...]
> > > > > > [1]: https://lore.kernel.org/20260227153730.1556542-4-
> > > > > > mathieu.desnoyers@efficios.com/
> > > > > 
> > > > > @Mathieu: In patch 1/3 description,
> > > > > > Changes since v7:
> > > > > > - Explicitly initialize the subsystem from start_kernel() right
> > > > > >     after mm_core_init() so it is up and running before
> > > > > > the creation of
> > > > > >     the first mm at boot.
> > > > > 
> > > > > But how does this work when someone calls mm_cpumask() on
> > > > > init_mm early?
> > > > > Looks like it will behave incorrectly because get_rss_stat_items_size()
> > > > > returns zero?
> > > > 
> > > > It doesn't work as expected at all. I missed that all users of
> > > > mm_cpumask()
> > > > end up relying on get_rss_stat_items_size(), which now calls
> > > > percpu_counter_tree_items_size(), which depends on initialization from
> > > > percpu_counter_tree_subsystem_init().
> > > > 
> > > > If you add a call to percpu_counter_tree_subsystem_init in
> > > > arch/powerpc/kernel/setup_arch() just before:
> 
> [...]
> 
> One thing we could do to catch this kind of init sequence issue
> is to add a WARN_ON_ONCE in percpu_counter_tree_items_size:
> 
> size_t percpu_counter_tree_items_size(void)
> {
>         if (WARN_ON_ONCE(!nr_cpus_order))
>                 return 0;
>         return counter_config->nr_items * sizeof(struct percpu_counter_tree_level_item);

Looks good!

-- 
Cheers,
Harry / Hyeonggon
