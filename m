Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C457C9F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925540; cv=none; b=aGU5nnkrDHwAVI/Tts/EEqiazW8huQ2sgn0JvFD/8on08ttzLBs2LgtxMMl+qDApKFvM3uLpZcyDjdo8GaZ3A89P/TnrkWzqa9mEk4oFoTgBqG1FXNfPUIehvzOnbsOaAU4f/YzU/UWVDSzmNM6v7UMP68qUh/WTqfwjvc35wBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925540; c=relaxed/simple;
	bh=LS0osjMXDePnUP/Cry2skNZj5SUuVHwt80Vd/ZjCB7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oUd0cKORApKQFdohfx9pZAG+2OriZUDlTvqgXtYDZ4zKZPBn3EVKdN+Cl2wqpHXbdC7f3L/4uhxaUTkElBskHzqIR559ffdNMBH6dFiYxx2ajW/kxjrgGwZi7f5+7fsUTK/DHYdL1x282sDpek1ZR+F85tXRHU0h89FswOWJ7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYqZPBby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYqZPBby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC501F000E9;
	Fri, 28 Aug 2026 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787925538;
	bh=2oDomlgvtjVK8oRaHwtJzk8T294/I9oAAampEZwtly8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lYqZPBbys9Vy5B+i59sG6b+vJpt9R0sDXy31gU65CWyb4a+reNiBnt1NsG2WHQBxW
	 6mZSwWyXAiWzJ/UHDFtUpzUh3GlsMN4BOZAtgQUkOg1KsuY2yD89G6OFJCLcLbgLac
	 PYzOVM1sVAifLQfA529TF4cVyP1E5OAlsSOEq3Ebo8d2HOK2L4G3JSc/i9CgN3tLBj
	 3CKynjOBKJtZZLd/3Hc4H711d3tKF2/H50cyeHKLnPzaJ3YYOCsI8aBFqZO6HHl4K/
	 /GtNSvc0kUXnOa2aEukFbrz3QgRnw+1vgtUJMuKVeMsU/Nrj7janByztD3AQ7EjH9U
	 sAiJOuhPMefAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Have show_event_filters/triggers files take
 trace array ref
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260828094153.17b95037@gandalf.local.home>
References: <20260828094153.17b95037@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:58:57 +0000
Message-Id: <20260828135858.2AC501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-after-free in trace_options_core_read and trace_options_co=
re_write due to missing trace_array reference.
--

commit ea5806b528a93a9450975f8b2320a019a3fbc9c7
Author: Steven Rostedt <rostedt@goodmis.org>

tracing: Have show_event_filters/triggers files take trace array ref

This commit fixes a use-after-free issue when reading show_event_filters or
show_event_triggers files by ensuring their open operations take a reference
on the trace array. This prevents the trace array from being freed via rmdir
while a task is still reading the files.

Closes: https://lore.kernel.org/all/CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41=
NDbENpeu98jA@mail.gmail.com/

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9f8f2d02276ca..e676601943362 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c

[ ... ]

> @@ -2908,7 +2908,17 @@ ftrace_event_set_open(struct inode *inode, struct =
file *file)
>  static int
>  ftrace_event_show_filters_open(struct inode *inode, struct file *file)
>  {
> -	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
> +	struct trace_array *tr =3D inode->i_private;
> +	int ret;
> +
> +	ret =3D tracing_check_open_get_tr(tr);

[Severity: Critical]
This isn't a bug introduced by this patch, but since we are fixing missing
trace array references, does a similar use-after-free exist for the trace
options files?

Looking at trace_options_core_fops in kernel/trace/trace.c, it registers
tracing_open_generic() as the open handler. That function passes NULL
to tracing_check_open_get_tr(), bypassing the trace_array_get() call:

kernel/trace/trace.c:tracing_open_generic() {
	int ret;

	ret =3D tracing_check_open_get_tr(NULL);
	if (ret)
		return ret;

	filp->private_data =3D inode->i_private;
	return 0;
}

Because no reference is taken on the trace array, could a user remove the
trace instance via rmdir while holding the options file open, and then
trigger a use-after-free when reading or writing?

For example, trace_options_core_read() retrieves the freed trace_array
via get_tr_index() and immediately dereferences it:

kernel/trace/trace.c:trace_options_core_read() {
	...
	get_tr_index(tr_index, &tr, &index);

	if (tr->trace_flags & (1ULL << index))
	...
}

> +	if (ret)
> +		return ret;
> +
> +	ret =3D ftrace_event_open(inode, file, &show_show_event_filters_seq_ops=
);
> +	if (ret < 0)
> +		trace_array_put(tr);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828094153.17b9=
5037@gandalf.local.home?part=3D1
