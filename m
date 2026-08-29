Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BB221DB6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Aug 2026 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787972130; cv=none; b=Xn0SoQpSPn6DW2Zl//35y81jzuHfxuTYlFUJqxVO0qf0A6jJURp8ls7TINi79rEGOAtbC8ywP4TVesjNN7gmkrLnlZA1u5WEH7x1qb189GNYSLrt4fSm8Zr08D3aKtjiGGDXDPjsx0SDN2YqwtZag6oD/WCGkhH/ORb0JUvQFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787972130; c=relaxed/simple;
	bh=JNWDhP/CGHCUyh0VHfuP1wUUjIiBoRHnMQ/ghWYO69k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRO/2BX8AetBGpaDtY4Hiwl2BidaaQx8jmOmCnIGLVv+7QihJdksKyfNxzLJpJoBH1hjk3zH9aAh5LU/L/znnF+Vs4aE5iOe+4d6HH31PIutYjT56TkWc+GLu9iGoUHT7wX3LGFjYJAHt6JAZsogiTpwAczTvuYhcWBrsOs9CSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsWi4peN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsWi4peN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A831F000E9;
	Sat, 29 Aug 2026 02:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787972128;
	bh=r2avW06UerwO75Go7RyAQeYXr7XuOnHfovLNF2K6FHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsWi4peNtbVwyMmns49kgpedo+0SHByy08jIWk5JFC2G5jXPn21x20k69nZe8sas3
	 7Q6BDanqaq0mfoZR7R8Yp8TvEUv4+f7tsQjCHQZzLnUCQnEIAKzdHz6tzjWFNx9XM7
	 ZmBTo5cLDL8Yp+vBM57U5m9gBkmStspo3rnBakZIwcdXLRskJeyjZcAsY2qUOoqTLS
	 jUGyKJiYEQdP1q/kSLOkub0N3LuUUeKjNec2gW+mgt0bnIoP92LRFF/uDmLDNOELMt
	 /TMk310uCVQXACvvZtqicKzeKmGQ5dIpFbI7DFOCneUfPlMPfVZSc1FvE3PchoXWMg
	 ea1DqOoYyDgUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ftrace: Take trace_array reference before accessing
 its ftrace_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260828223901.29e26edb@robin>
References: <20260828223901.29e26edb@robin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 02:55:27 +0000
Message-Id: <20260829025528.49A831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] ABA problem in trace_array lookup allows a file descriptor to atta=
ch to a newly created trace instance instead of failing.

Pre-existing issues:
- [High] If `allocate_fgraph_ops` fails in `ftrace_create_function_files`, =
`tr->ops` is freed but not set to `NULL`. During instance removal, this dan=
gling pointer causes a Use-After-Free and Double Free.
- [High] Concurrent lockless calls to `ftrace_ops_init` can lead to double =
`mutex_init` and list corruption.
--

commit f37f9bc71afd70bff68b27fdd3afcdd0c07c7ae7
Author: Steven Rostedt <rostedt@goodmis.org>

ftrace: Take trace_array reference before accessing its ftrace_ops

The trace instance files set_ftrace_filter and set_ftrace_notrace was
updated to work with specific trace instances (trace_arrays). This patch
changes the files to pass the trace_array as the file private data,
allowing the trace_array reference to be incremented before touching
the ftrace_ops.

Fixes: 591dffdade9f0 ("ftrace: Allow for function tracing instance to filte=
r functions")
Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9d80c7bd9f16..c7cf36f2dd7be 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
[ ... ]
> @@ -4691,26 +4692,45 @@ ftrace_avail_addrs_open(struct inode *inode, stru=
ct file *file)
[ ... ]
>  int
> -ftrace_regex_open(struct ftrace_ops *ops, int flag,
> +ftrace_regex_open(struct trace_array *tr, struct ftrace_ops *ops, int fl=
ag,
>  		  struct inode *inode, struct file *file)
>  {
[ ... ]
> +	if (!ops)
> +		ops =3D tr->ops;
> +
> +	if (WARN_ON_ONCE(!ops))
> +		goto out;
> +
> +	ftrace_ops_init(ops);

[Severity: High]
This is a pre-existing issue, but can concurrent lockless calls to
ftrace_ops_init() lead to double mutex initialization?

In ftrace_regex_open(), this function is called locklessly in the VFS open
path. Inside ftrace_ops_init(), it checks if the initialized flag is set:

kernel/trace/ftrace.c:ftrace_ops_init() {
    if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
        mutex_init(&ops->local_hash.regex_lock);
        INIT_LIST_HEAD(&ops->subop_list);
        ops->func_hash =3D &ops->local_hash;
        ops->flags |=3D FTRACE_OPS_FL_INITIALIZED;
    }
}

If multiple threads concurrently open the filter file on a newly created
trace instance, both could observe the flag as unset.

Could one thread lock the newly initialized mutex just as the second thread
calls mutex_init() on it, potentially corrupting the mutex wait list?

[ ... ]
> @@ -4788,21 +4808,19 @@ ftrace_regex_open(struct ftrace_ops *ops, int fla=
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

[Severity: High]
Does this lockless trace_array pointer retrieval introduce an ABA problem?

If a thread pauses after reading tr from inode->i_private, a concurrent
instance removal could free the original trace_array. If a subsequent mkdir
allocates a new trace instance at the exact same memory address, the paused
thread would resume with the old address.

When ftrace_regex_open() calls tracing_check_open_get_tr(tr), it ultimately
validates the pointer in trace_array_get() by comparing the raw pointer
against the global list:

kernel/trace/trace.c:trace_array_get() {
    ...
    list_for_each_entry(this_tr, &ftrace_trace_arrays, list) {
        if (tr =3D=3D this_tr) {
            return __trace_array_get(tr);
        }
    }
}

Because the new instance was allocated at the same address, this comparison
would succeed, incorrectly attaching the file descriptor to the new trace
instance.=20

Could this lead to cross-instance state corruption?

>  }
[ ... ]
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_function=
s.c
> index cd37f20137581..c879d43a5fbb2 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -101,7 +101,7 @@ int ftrace_create_function_files(struct trace_array *=
tr,
>  		return ret;
>  	}
> =20
> -	ftrace_create_filter_files(tr->ops, parent);
> +	ftrace_create_filter_files(tr, parent);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does a failure in allocate_fgraph_ops()
leave a dangling tr->ops pointer?

Just above this hunk in ftrace_create_function_files(), if
allocate_fgraph_ops() fails, it frees tr->ops but doesn't set it to NULL:

kernel/trace/trace_functions.c:ftrace_create_function_files() {
    ret =3D allocate_fgraph_ops(tr, tr->ops);
    if (ret) {
        kfree(tr->ops);
        return ret;
    }
}

Since tracefs setup ignores the error, the instance creation succeeds but
leaves a dangling pointer inside the active trace_array.

Later, when the instance is removed, ftrace_destroy_function_files() will c=
all
ftrace_destroy_filter_files(tr->ops) and ftrace_free_ftrace_ops(tr), which =
might
result in a use-after-free and a double free.=20

Should tr->ops be set to NULL after kfree(tr->ops)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828223901.29e2=
6edb@robin?part=3D1
