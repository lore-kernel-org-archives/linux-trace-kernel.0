Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1D3BBFCB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787947992; cv=none; b=UtvQU2EEJTbPyQn8cZhnTvf6ytlLil8d/IRj8Hsd5nf0SaN+jNX7RRgGYn3rqSH3p8NG+zoH976LgnirEEJKBwIZck7rGQTWt9NnWJTcRnMpnrbMQ0xSGc6w0UEfjbMoYKQkd7y1eOmfzqJIZy5qwAaZPZ3s1GmzyV1Gh0p7VVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787947992; c=relaxed/simple;
	bh=WmZnQN5FYkvsWVepZqtQx5kNm0nDxk6PJ3x/eXsUdbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P1Z6O/58+jjaUhC+CKR4vZukNulPVhSVzZ2HkfxTKWK9e1VPmXSZfkk/c9wd9uVTjuBQr+AL+YrP+ME7ELUnVHkjxGq2HaQywM14tD7sWYp2zy+b+OAbGr+veq6nabFc8lT9HOMk1MfIvHDEAWUN/YUyH9tW/EFs42b1iBhDhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzonGHfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzonGHfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18721F000E9;
	Fri, 28 Aug 2026 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787947990;
	bh=wOqftIHB4YX4D6VRLBDx+VRs0vqUC+ExlF+uh3PYsF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzonGHfPuGUcxLQ26nKdCil27044tCNyZDUqfLLd/OfvttICSO6pXk9+cSxjYlU+p
	 jE9xbqA7Cfkx60a8i6H9McJqCgHRbywg6JXXQSFIqzpTVa399V4WuQGwi1ow/sGxTN
	 EnvShgvBvSmcQxsHF4ZFvW5JUCZOhQyEVrz7DNIPmxTgGt/07cSiR/vGbANGO5c6yC
	 P6jezCBh5hLtLYqw9mxka6UzCGVFNJketbfnq3AjS8lSaSM4JQhK1GJDUC/4VqA+Hf
	 oOKin+CXQ4uDkh4WY+lZ0avqZKPHr3/nLegx1rfSqU0ruFlyQ/t5j6SaHmXiNlx6kg
	 VJs5ZESJM4fzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ftrace: Take trace_array reference before accessing its
 ftrace_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260828155942.445f46e5@gandalf.local.home>
References: <20260828155942.445f46e5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 20:13:09 +0000
Message-Id: <20260828201309.C18721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Tracefs lockdown and tracing_disabled checks are bypassed for =
the global ftrace instance and stack tracer.
- [High] Module and probe filters for the global ftrace instance cannot be =
cleared or read.
--

commit 42c008f904dcd516dc1681a548fae6a4bba9a162
Author: Steven Rostedt <rostedt@goodmis.org>

ftrace: Take trace_array reference before accessing its ftrace_ops

The trace instance files set_ftrace_filter and set_ftrace_notrace are
updated to work with specific trace instances (trace_arrays). This
patch passes the trace_array as the file private data to allow incrementing
its reference before touching the ftrace_ops, preventing a use-after-free.

Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9d80c7bd9f16..4babd86c7be00 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

>  int
> -ftrace_regex_open(struct ftrace_ops *ops, int flag,
> +ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int fl=
ag,
>  		  struct inode *inode, struct file *file)
>  {
> -	struct ftrace_iterator *iter;
> +	struct ftrace_iterator *iter =3D NULL;
>  	struct ftrace_hash *hash;
>  	struct list_head *mod_head;
> -	struct trace_array *tr =3D ops->private;
> -	int ret =3D -ENOMEM;
> -
> -	ftrace_ops_init(ops);
> +	int ret =3D -ENODEV;
> =20
>  	if (unlikely(ftrace_disabled))
>  		return -ENODEV;
> =20
> -	if (tracing_check_open_get_tr(tr))
> +	if (tr && tracing_check_open_get_tr(tr))
>  		return -ENODEV;

[Severity: Critical]
By adding the `tr &&` short-circuit here, does this cause a regression
where tracefs lockdown and tracing_disabled checks are bypassed for the
global ftrace instance and the stack tracer?

Since `tr` is explicitly passed as `NULL` for these instances,
`tracing_check_open_get_tr(NULL)` is never called.

[ ... ]

> @@ -4788,21 +4801,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int fla=
g,
>  static int
>  ftrace_filter_open(struct inode *inode, struct file *file)
>  {
> -	struct ftrace_ops *ops =3D inode->i_private;
> +	struct trace_array *tr =3D inode->i_private;
> =20
> -	/* Checks for tracefs lockdown */
> -	return ftrace_regex_open(ops,
> -			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> -			inode, file);
> +	return ftrace_regex_open(tr, NULL,
> +				 FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> +				 inode, file);
>  }

[Severity: High]
For the global ftrace instance, `tr` is `NULL`. Does passing `NULL` for `tr`
break the module and probe filters?

In `ftrace_regex_open()`, the `mod_head` pointer is initialized like this:

    mod_head =3D tr ? &tr->mod_trace : NULL;

Because `tr` is `NULL`, `mod_head` will also be `NULL`. When opening the
file with `O_TRUNC`, `clear_ftrace_mod_list(mod_head)` will do nothing,
failing to clear the module filters.

Additionally, `iter->tr` is set to `NULL`. When reading the file,
`t_mod_start()` relies on `iter->tr` and will return early:

    /* probes are only available if tr is set */
    if (!iter->tr)
        return NULL;

Could this skip the enumeration of active module and probe filters for the
global instance entirely?

[ ... ]

> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 0aa2514a6593b..e7f4e523587d0 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -499,7 +499,7 @@ stack_trace_filter_open(struct inode *inode, struct f=
ile *file)
>  	struct ftrace_ops *ops =3D inode->i_private;
> =20
>  	/* Checks for tracefs lockdown */
> -	return ftrace_regex_open(ops, FTRACE_ITER_FILTER,
> +	return ftrace_regex_open(NULL, ops, FTRACE_ITER_FILTER,
>  				 inode, file);
>  }

[Severity: Critical]
The stack tracer explicitly passes `NULL` for the trace array. Due to the
short-circuit mentioned earlier, doesn't this also bypass the lockdown
check documented in the comment right above this call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828155942.445f=
46e5@gandalf.local.home?part=3D1
