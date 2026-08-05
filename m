Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68889397E64;
	Wed,  5 Aug 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958160; cv=none; b=aC9/T4m4iYxAZCP9mBwF5EJlOJ7jFhRCxHUXhtUQNKQLCkLyuiafVAxL5mnh++4fkxNjOPM3WEIOMixTMwaOQJD6mod3OeMGBxMSgmWPGBDDDFVFk1QFhS/O/6JGACS7dFZN7qj32zKIGYyp49LKB5gra4JpCuOT2stfo5qGIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958160; c=relaxed/simple;
	bh=IGo0DsIUIVQY+Em4SA7KaXmLO0bkUukIUEwRnp6SRjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLcCTtkknBgB4L4KTElaVYn7YeWFGSG6ZDaqx+myPXCygrpDQHw/1EwSg670BUdAcdW3ZuuQZvd2eeH+9mg4MZ/vJT8OqlA3c2rey7WTpwz2b2hklYWuHBdYbrhXDGBK5QCAGyk0pHhl5uwcHuwtpEF+MF0tw8o5I6Zi4qg+JJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C85621A05C7;
	Wed,  5 Aug 2026 19:29:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id C826B18;
	Wed,  5 Aug 2026 19:29:14 +0000 (UTC)
Date: Wed, 5 Aug 2026 15:30:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix off-by-one fentry site disable in
 ftrace_free_mem()
Message-ID: <20260805153005.0bbc428a@gandalf.local.home>
In-Reply-To: <d0a6a1deda9836c614a11c458fef2c8cf321333a.1785726456.git.jpoimboe@kernel.org>
References: <d0a6a1deda9836c614a11c458fef2c8cf321333a.1785726456.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sucbi9eduaw58uqxtcs4kx9r1bmgujpg
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: C826B18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VXgCXhh1lMd6Rg67zRgoNQv1HeKU5wo0=
X-HE-Tag: 1785958154-461527
X-HE-Meta: U2FsdGVkX1/Hnwv5rGtFgJS5mknaxT9zg1JRXVAQ2Educj9BXWvyzvGFlu97ekAiVVDuT2dZYZTfmZnNDrcSOGpV9jpSPA6Xr6vbsoDqDiOaTFEX6BgIfW+Ibqtc7gET5zjjqTn6Ubt0IKCu3HvXJuS8ZxXh9dpReN5ZGL6z02z5d2LN9akvhx73wWOLUc5Td9nAECfpTEDsbTR+cCDP+FZmgHzsCHML+q0AkRk3rWNYN+S5IIRYmNSIiite0D5UQI97EehQszSmdZAYFBWDGGs7ZzbC5STDFJzuORRieo3fha9vvSDSWvze4+HOpnsOj4ncyexRbOixNZB0R3fGPK8HsY9QlVZG

On Sun,  2 Aug 2026 20:08:35 -0700
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

Nice catch.


> 
> Fixes: 42c269c88dc1 ("ftrace: Allow for function tracing to record init functions on boot up")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  kernel/trace/ftrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f93e34dd2328..7d8b736f0d86 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8293,8 +8293,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  	struct ftrace_init_func *func, *func_next;
>  	LIST_HEAD(clear_hash);
>  
> +	if (start >= end)
> +		return;
> +
>  	key.ip = start;
> -	key.flags = end;	/* overload flags, as it is unsigned long */
> +	key.flags = end - 1;	/* overload flags, as it is unsigned long */

I'd like to keep this consistent with lookup_rec().

>  
>  	mutex_lock(&ftrace_lock);
>  

Can you do this instead?

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6c47a94f5924..dbb0fc2928d8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8296,7 +8296,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
