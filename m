Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066419E96A;
	Tue, 22 Oct 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603939; cv=none; b=Md56gVwHrveKyP6zOUp/Sg/soS6K3/kLqXZ+Ra2/yUOOi38F+q1rj2otpwcKUcOTDyAURbMdnaSIJx5Z1bb7ZSBi6ZLmoHu7wTx6yu4YyRXayE1dHkup3nhHitoAdKVTj9OJ7u4GdhyeC/5EICqnxpJN8EgH9qZVssBMqmzWyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603939; c=relaxed/simple;
	bh=U4dsUYhZ063WkaEF3QJNt0zHy44yQkLJluKG43H5NKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VMwaeCkVHLstR6JNPWRbzemEZFWfvH23u4l39UIVIlF4tRXVlfSCGJ64etxYQVcH7BkdF60RmVqi/Jbka4Ec9ygSYMtx6SoZMh3zLl/TxSYddl5ldiFkSwx53pXUeDXH+yJaVepLHVreSxRLr3CT4b4JMtImWUg6FQ5DFHIc0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2/SL2IH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2/SL2IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF2BC4CEE6;
	Tue, 22 Oct 2024 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603937;
	bh=U4dsUYhZ063WkaEF3QJNt0zHy44yQkLJluKG43H5NKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S2/SL2IHG5AAN2FDOxMoLAlgihi8kM3zsckArXcHTxmrvc3wOdutOJaQm3QGiVli6
	 oLIvjizMiEjet5K41o3wJNEJPgmcRg5NT1vUDcylRPW9+EQU8nhkiOjKLXBj8Y7sUo
	 bF2CIiPSrrEKE9Lid/vJQgbaLvTKBWs54PXfUgqgsZgnmIf1xeXLf8oY5dsR55bX4R
	 mzhKe0hr7U27gpYkQYWiwA5iiCnEdZETg3kFP3drWTsJUW+gpgDwliQBMvfVLs+8jH
	 JY96Lsklf/g3z4qbK5ue9deLVacWs7xY46ccTipIp0dbyNT1cOXBYMabcLZca6/7f9
	 z1V7JL78v1zYQ==
Date: Tue, 22 Oct 2024 22:32:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mikel Rychliski <mikel@mikelr.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Message-Id: <20241022223214.f2e6f5d314e09d54a64c0d5f@kernel.org>
In-Reply-To: <20240930202656.292869-1-mikel@mikelr.com>
References: <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
	<20240930202656.292869-1-mikel@mikelr.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 16:26:54 -0400
Mikel Rychliski <mikel@mikelr.com> wrote:

> When creating a trace_probe we would set nr_args prior to truncating the
> arguments to MAX_TRACE_ARGS. However, we would only initialize arguments
> up to the limit.
> 
> This caused invalid memory access when attempting to set up probes with
> more than 128 fetchargs.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000020
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 1769 Comm: cat Not tainted 6.11.0-rc7+ #8
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
>   RIP: 0010:__set_print_fmt+0x134/0x330
> 
> Resolve the issue by applying the MAX_TRACE_ARGS limit earlier. Return
> an error when there are too many arguments instead of silently
> truncating.

Yeah, looks good to me. Let me pick it.

Thanks!

> 
> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
> Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
> ---
> V1 -> V2: Return error instead of dropping excessive arguments
> 
>  kernel/trace/trace_eprobe.c | 7 ++++++-
>  kernel/trace/trace_fprobe.c | 6 +++++-
>  kernel/trace/trace_kprobe.c | 6 +++++-
>  kernel/trace/trace_uprobe.c | 4 +++-
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index b0e0ec85912e..ebda68ee9abf 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -912,6 +912,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  		}
>  	}
>  
> +	if (argc - 2 > MAX_TRACE_ARGS) {
> +		ret = -E2BIG;
> +		goto error;
> +	}
> +
>  	mutex_lock(&event_mutex);
>  	event_call = find_and_get_event(sys_name, sys_event);
>  	ep = alloc_event_probe(group, event, event_call, argc - 2);
> @@ -937,7 +942,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  
>  	argc -= 2; argv += 2;
>  	/* parse arguments */
> -	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> +	for (i = 0; i < argc; i++) {
>  		trace_probe_log_set_index(i + 2);
>  		ret = trace_eprobe_tp_update_arg(ep, argv, i);
>  		if (ret)
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index a079abd8955b..c62d1629cffe 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1187,6 +1187,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		argc = new_argc;
>  		argv = new_argv;
>  	}
> +	if (argc > MAX_TRACE_ARGS) {
> +		ret = -E2BIG;
> +		goto out;
> +	}
>  
>  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
>  	if (ret)
> @@ -1203,7 +1207,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	}
>  
>  	/* parse arguments */
> -	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> +	for (i = 0; i < argc; i++) {
>  		trace_probe_log_set_index(i + 2);
>  		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 61a6da808203..263fac44d3ca 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1013,6 +1013,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		argc = new_argc;
>  		argv = new_argv;
>  	}
> +	if (argc > MAX_TRACE_ARGS) {
> +		ret = -E2BIG;
> +		goto out;
> +	}
>  
>  	ret = traceprobe_expand_dentry_args(argc, argv, &dbuf);
>  	if (ret)
> @@ -1029,7 +1033,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	}
>  
>  	/* parse arguments */
> -	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> +	for (i = 0; i < argc; i++) {
>  		trace_probe_log_set_index(i + 2);
>  		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c3df411a2684..f0273b4d4a7b 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -565,6 +565,8 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  
>  	if (argc < 2)
>  		return -ECANCELED;
> +	if (argc - 2 > MAX_TRACE_ARGS)
> +		return -E2BIG;
>  
>  	if (argv[0][1] == ':')
>  		event = &argv[0][2];
> @@ -690,7 +692,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  	tu->filename = filename;
>  
>  	/* parse arguments */
> -	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> +	for (i = 0; i < argc; i++) {
>  		struct traceprobe_parse_context ctx = {
>  			.flags = (is_return ? TPARG_FL_RETURN : 0) | TPARG_FL_USER,
>  		};
> 
> base-commit: 886f3732878dc92fb0ad6d8b6740b66410d1d50a
> -- 
> 2.46.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
