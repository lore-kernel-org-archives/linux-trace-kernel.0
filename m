Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F493175A86;
	Thu,  7 May 2026 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119375; cv=none; b=lTucWneBkhP/sf9MCmGOrTQTwoUQ6eL5o9wsWq0rujpDQ6wWwjR8AI+mCaUaSmnjK61dHiNRarQv5q0LVSTSw/eLEKf+BLjGpW7N19lItb5wGElPz4d28k25XstWpZGGy2l8lx7+/cSwjAHsMOnI3nmFZPy9AeG4e4cHZ5nxC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119375; c=relaxed/simple;
	bh=uF9Ma5v2WQGXJLFzsPqqa9d8Zlsvrsbmwvrq3hWuJQE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PuKscFSbVUhGxYSoIFgVq8vAG/A7UAHT50VEATwaoT58fKeA/+x4aCzWO8rGGcwZBPd+yu1Q3tZjTqVYSb6vmlp53mG2kBrmnCygP1FmgJCdufJ8CNT3zTQDyV/mqBE19M+Y8xWia7P5ucIQTcJ8v2NninigiNJU7rUQ5ylETHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB3kMItU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB3kMItU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDD9C2BCB2;
	Thu,  7 May 2026 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119375;
	bh=uF9Ma5v2WQGXJLFzsPqqa9d8Zlsvrsbmwvrq3hWuJQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jB3kMItU5YQUjcPJJTBE0x9zIZifPUMHFl6hHT362HPjw9F4zC6DBogWxkt1jgX1o
	 rRQWmgvaKuTUKbmAi6O++EAfLPOGpPAEQeY1OvGmbZ5jKi+n/bJ22ywMQSiax6aKLL
	 vRwmbpBtcX2r9ofrm6rNGfNvDhi56L5FgItCpC9GWpaL8HERbZqUqgtE6Zlvt5wuRi
	 fB9RxhdlVxIvwlXY2E+yx1oVpWSYMhsDPt5/czXh9YlvzaRM/KSeYlhepbgGQs/edI
	 mBZseFMvKvvAkPsngb41C24sxZat54eAk7B/UzN7d0mv8SKPsn0jnrGUePLbdBIzrG
	 PQ9tzdPcJj2tw==
Date: Thu, 7 May 2026 11:02:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous
 unregistration
Message-Id: <20260507110252.5d6a0e9b6067be74311bd532@kernel.org>
In-Reply-To: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
References: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 27 Apr 2026 21:09:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Currently, unregister_fprobe() removes the ftrace hooks but does not
> wait for the RCU grace period to expire. This is efficient for batch
> unregistration of multiple fprobes (to avoid multiple RCU grace period
> latencies), but it leaves a window where probe handlers might still be
> running on other CPUs after the function returns.
> If a caller needs to free the fprobe structure or unload the module
> immediately after unregistration, they must manually call
> synchronize_rcu() to prevent use-after-free issues.
> 
> To simplify this use case, introduce unregister_fprobe_sync(). This
> function unregisters the fprobe and waits for the RCU grace period to
> complete before returning.

BTW, as same as kprobes does, is it better to sync it by default as
the current documentation says? 
Considering the need for consistency in behavior with kprobes interfaces,
it might be better to introduce an asynchronous API eventually.

The first patch will fix the current issue (whose behavior differs from
the documentation and other APIs), and then introduce an asynchronous
version (the same as the current implementation) for internal use.

This can provide a mind model with more consistent behavior for *probes. 

Thank you,

> 
> Also, update the documentation of unregister_fprobe() to clarify its
> non-blocking behavior and suggest using unregister_fprobe_sync() for the
> last probe in a batch. Finally, update the fprobe sample module to use
> the synchronous version on exit to ensure safe module unloading.
> And add a fix to use synchronous version in the sample code and
> trace_fprobe (unexpected error case).
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/trace/fprobe.rst  |   15 ++++++++++++---
>  include/linux/fprobe.h          |    5 +++++
>  kernel/trace/fprobe.c           |   30 ++++++++++++++++++++++++++++++
>  kernel/trace/trace_fprobe.c     |    9 +++++++--
>  samples/fprobe/fprobe_example.c |    2 +-
>  5 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> index 95998b189ae3..eee4860ab29a 100644
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -65,6 +65,12 @@ To disable (remove from functions) this fprobe, call::
>  
>    unregister_fprobe(&fp);
>  
> +Or if you need to wait for the RCU grace period to ensure no handlers
> +are running on any CPU (e.g., before freeing the `fprobe` structure),
> +use::
> +
> +  unregister_fprobe_sync(&fp);
> +
>  You can temporally (soft) disable the fprobe by::
>  
>    disable_fprobe(&fp);
> @@ -81,9 +87,12 @@ Same as ftrace, the registered callbacks will start being called some time
>  after the register_fprobe() is called and before it returns. See
>  Documentation/trace/ftrace.rst.
>  
> -Also, the unregister_fprobe() will guarantee that both enter and exit
> -handlers are no longer being called by functions after unregister_fprobe()
> -returns as same as unregister_ftrace_function().
> +Also, the `unregister_fprobe_sync()` will guarantee that both enter and exit
> +handlers are no longer being called by functions after it returns.
> +On the other hand, `unregister_fprobe()` does not wait for the RCU grace period,
> +so handlers might still be running on other CPUs for a short time after it returns.
> +This is useful when you unregister multiple fprobes in a batch to avoid
> +waiting for the RCU grace period for each one.
>  
>  The fprobe entry/exit handler
>  =============================
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 0a3bcd1718f3..6ae452e250a1 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -94,6 +94,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
>  int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
>  int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
>  int unregister_fprobe(struct fprobe *fp);
> +int unregister_fprobe_sync(struct fprobe *fp);
>  bool fprobe_is_registered(struct fprobe *fp);
>  int fprobe_count_ips_from_filter(const char *filter, const char *notfilter);
>  #else
> @@ -113,6 +114,10 @@ static inline int unregister_fprobe(struct fprobe *fp)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int unregister_fprobe_sync(struct fprobe *fp)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline bool fprobe_is_registered(struct fprobe *fp)
>  {
>  	return false;
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index cc49ebd2a773..5f3e48385a47 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -1097,6 +1097,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
>   * @fp: A fprobe data structure to be unregistered.
>   *
>   * Unregister fprobe (and remove ftrace hooks from the function entries).
> + * Note: This function does not wait for RCU grace period, since user
> + * may use several fprobes (and then unregister them one by one). In that
> + * case, it is recommended to use unregister_fprobe_sync() for the last fprobe.
>   *
>   * Return 0 if @fp is unregistered successfully, -errno if not.
>   */
> @@ -1110,6 +1113,33 @@ int unregister_fprobe(struct fprobe *fp)
>  }
>  EXPORT_SYMBOL_GPL(unregister_fprobe);
>  
> +/**
> + * unregister_fprobe_sync() - Unregister fprobe synchronously with RCU grace period.
> + * @fp: A fprobe data structure to be unregistered.
> + *
> + * Unregister fprobe (and remove ftrace hooks from the function entries) and
> + * wait for the RCU grace period to finish. This is useful for preventing
> + * the fprobe from being used after it is unregistered.
> + *
> + * Return 0 if @fp is unregistered successfully, -errno if not.
> + */
> +int unregister_fprobe_sync(struct fprobe *fp)
> +{
> +	int ret;
> +
> +	guard(mutex)(&fprobe_mutex);
> +	if (!fp || !fprobe_registered(fp))
> +		return -EINVAL;
> +
> +	ret = unregister_fprobe_nolock(fp);
> +	if (ret)
> +		return ret;
> +
> +	synchronize_rcu();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_fprobe_sync);
> +
>  static int __init fprobe_initcall(void)
>  {
>  	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 9f5f08c0e7c2..fa5b41f7f306 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -845,8 +845,13 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  /* Internal unregister function - just handle fprobe and flags */
>  static void __unregister_trace_fprobe(struct trace_fprobe *tf)
>  {
> -	if (trace_fprobe_is_registered(tf))
> -		unregister_fprobe(&tf->fp);
> +	/*
> +	 * Here, @tf must NOT be busy, so it MUST be unregistered already.
> +	 * But if it is unexpectedly registered, unregister it synchronously.
> +	 */
> +	if (WARN_ON_ONCE(trace_fprobe_is_registered(tf)))
> +		unregister_fprobe_sync(&tf->fp);
> +
>  	if (tf->tuser) {
>  		tracepoint_user_put(tf->tuser);
>  		tf->tuser = NULL;
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index bfe98ce826f3..382d2f67672a 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -142,7 +142,7 @@ static int __init fprobe_init(void)
>  
>  static void __exit fprobe_exit(void)
>  {
> -	unregister_fprobe(&sample_probe);
> +	unregister_fprobe_sync(&sample_probe);
>  
>  	pr_info("fprobe at %s unregistered. %ld times hit, %ld times missed\n",
>  		symbol, nhit, sample_probe.nmissed);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
