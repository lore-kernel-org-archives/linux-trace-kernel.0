Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402A33F385;
	Thu,  6 Aug 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024720; cv=none; b=KoFmIg3jYJtkcj2/LMRLSiSjYX9z1aIlleyDkFYi1xzaPmn5Nj99oBw95KDQz7EgggpnunaPRt5RCLFpZWogRpc1KKWbY53kudg/Vvs3EwokTeQhRPN8VqR5YYIZ3JVy8Rrcl0gAuqofVPjglT2lXciUcNhhvY4uo67B0/uoFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024720; c=relaxed/simple;
	bh=jlNF1/gTJiuNt9aYwkNT4i989+l8aw0tKF6HssSvdOc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AMgD/m3xLWM958vUh5gm/dOQ6N3sgF58FPNfcGUO70e0ATX5338rt6R8JFsAs3K0+qRioadfxYoBREgM6HhN3dxF1BQVUwLrgXubQJASNWg30aNZ4G4ThXgkqnDbvWt08ICFGXGTcBMyVS5i3ptzMzRm2wtFK6JoCSa4nGAXBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4hFIKtr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4hFIKtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFC1F00A3A;
	Thu,  6 Aug 2026 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024719;
	bh=pqjc3XrcksOIjFw/0npkQJ2JqWUfGvQAgYKF2YA/2fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g4hFIKtrNVekfsmLvhju5m4jz4Jo+tqIOakT7NWfWwtu4Oy1M92zUBxdetR1Fe8aE
	 ABuvlmiw2ndlSZHC+dLp8GBZeTGQNpXTSWi+zsCKm28tsRsJIA+Jd0Z39XmhQJONgD
	 47M3mVkCNnfc2BnWd4asIG0WefxaRHhk+rvwldGl1DdgBTtCGCXxPz70a9JACOM7t3
	 z+SkuPaEZ2GQo8SLH/cNuU5X+JWf7t+GubhmRpwUja+5NzdcjEwmEyQ7TnPU+7fWcE
	 GK6x0yDsB6U5mRqqUeuXAlWdc9GM2YV0SJn/ptdtkd/s1G1pMl8dN57U8ax6Fgnl18
	 aOKVG6WhIvjZA==
Date: Thu, 6 Aug 2026 22:58:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Fix off-by-one fentry site disable in
 ftrace_free_mem()
Message-Id: <20260806225835.8b96b6422aa93a1d0dccd71b@kernel.org>
In-Reply-To: <1b5ccfa8095bdb1277f84af1c2c2e2205aca03ae.1785992188.git.jpoimboe@kernel.org>
References: <1b5ccfa8095bdb1277f84af1c2c2e2205aca03ae.1785992188.git.jpoimboe@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 21:56:46 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> When a module's init text is freed, do_init_module() calls
> ftrace_free_mem() with a half-open [start, end) range.  However the
> ftrace_cmp_recs() comparator treats the upper bound as inclusive, as all
> its other users do, passing 'ip + size - 1'.  So ftrace_free_mem() can
> delete a record sitting exactly at 'end', which is outside the freed
> range.
> 
> For a kernel without CFI or IBT, the first record of a function is at
> the function start, which for the first function in a module is also the
> base of its text allocation.  As the module allocator packs its regions,
> that address is often the 'end' passed by a neighboring module's
> do_init_module(), causing the first function's ftrace location to get
> disabled, preventing an attempt to livepatch it:
> 
>   livepatch: failed to find location for function 'pcspkr_probe'
> 
> Convert the exclusive end to the inclusive 'end - 1' the comparator
> expects, and return early for an empty range to avoid the subtraction
> from underflowing when the init text size is zero.
> 
> Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/trace/ftrace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f93e34dd23288..6bde28d56f41b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8283,7 +8283,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
>  void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  {
>  	unsigned long start = (unsigned long)(start_ptr);
> -	unsigned long end = (unsigned long)(end_ptr);
> +	/* end is inclusive and end_ptr is exclusive */
> +	unsigned long end = (unsigned long)(end_ptr) - 1;
>  	struct ftrace_page **last_pg = &ftrace_pages_start;
>  	struct ftrace_page *tmp_page = NULL;
>  	struct ftrace_page *pg;
> @@ -8293,6 +8294,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  	struct ftrace_init_func *func, *func_next;
>  	LIST_HEAD(clear_hash);
>  
> +	if (start_ptr >= end_ptr)
> +		return;
> +
>  	key.ip = start;
>  	key.flags = end;	/* overload flags, as it is unsigned long */
>  
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
