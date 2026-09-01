Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF237FF6A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296063; cv=none; b=HIPmstrHNo4TU1gs5mKBV0FdCgiNNDzh39jrg5hUE3gkvIyKfyeO5Th6lEVI7ivyPdQa88ySHGXyYM8uOUcBSC7mlM+yyBqVVuOL+sgPtdyoyn1ksRfq2gy2AsCE6GolTJFeCZm/BXfax9WNohpNZbwV5b+mp5IM/wNfwTIYOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296063; c=relaxed/simple;
	bh=RkDATtYC3Ocr9UKBrWtLOhqjZQutyBzNcSgXvMumir4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/LcTl/cgEqDujoYQP0cK6y6G3z2/3f5hKLwbzWgSEQ+6hLKtzCi4QvsYcaoCobVA50xQ1egNSmPUvwe4RVFoPIoSO7ZnM7mNcBY1NMjJaLNoBJELN9fEHO/Z/0DoS0Ce1aEFfuX2OMwEPePISJMst/SC/YfLbTZGhZdAtojNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZaSN8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZaSN8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5832E1F000E9;
	Tue,  1 Sep 2026 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296061;
	bh=fIOUQs+8wur8dQ6Lsml2ZAkORcOxReP4Xa1zosvlmfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqZaSN8Nj8lrFFNfXR2Vbd8NyMPYtmRGTS+3zQE2rRTBRClGdiZge7Wt2HteUg8ra
	 oZt3dlRWgi/YraXSqC57uuYlqcvE/RrWtgXNpEu70z8KKUZXMTt5lgM+JTb+FdvzQY
	 k44zzn2x3MprdXH7L79InNV1S4BpSNf1YSMc1Te/fSHNYFz+KPF8O2K3QtNkhI/zIS
	 AHA2ouJ8X49ACq2NEJDBzkgFtCF+ufDPraDAH0kMlgCxWThB3yaQ/6iSyUH+U3Xq5Q
	 8emhypnrQX/O+1kBVkIPTXuMOn7cgYxCwXGUdtKUR6Bcrtinax1N0MWxPBJ895xUTS
	 GWsnKC+ZuFP+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Take trace_array reference when opening
 options file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901163620.6cbe0ada@gandalf.local.home>
References: <20260901163620.6cbe0ada@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:54:20 +0000
Message-Id: <20260901205421.5832E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Identifying trace arrays by raw memory address in `trace_array_opt=
ions_get()` introduces an ABA/pointer reuse vulnerability, allowing cross-i=
nstance manipulation.
- [Low] Call to undeclared function `__trace_array_get()` will break the bu=
ild.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch ad=
dresses a Use-After-Free for core option files while overlooking tracer-spe=
cific option files and other per-instance tracefs files, leaving them vulne=
rable to the exact same Use-After-Free.
--

commit a7557d52083622c7b02bffa097f88009b072e692
Author: Steven Rostedt <rostedt@goodmis.org>

tracing: Take trace_array reference when opening options file

This commit fixes a Use-After-Free vulnerability in trace options files
by ensuring the trace_array reference is taken when the file is opened.
It introduces trace_array_options_get() to safely acquire the reference.

Link: https://lore.kernel.org/linux-trace-kernel/20260828135858.2AC501F000E=
9@smtp.kernel.org/

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d9..3e001ed8cf376 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c

[ ... ]

> +static int trace_array_options_get(void *tr_index)
> +{
> +	struct trace_array *tr;
> +	int ret;
> +
> +	ret =3D security_locked_down(LOCKDOWN_TRACEFS);
> +	if (ret)
> +		return ret;
> +
> +	if (tracing_disabled)
> +		return -ENODEV;
> +
> +	guard(mutex)(&trace_types_lock);
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		if (tr_index >=3D &tr->trace_flags_index[0] &&
> +		    tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])

[Severity: High]
Does this raw memory address comparison account for reallocation of the
trace_array struct?

If a trace instance is deleted, its trace_array is freed. If a new instance
is subsequently created, it could be allocated at the exact same memory
address. Could a user holding an O_PATH file descriptor to a core options
file of the deleted instance reopen it and manipulate the tracer flags of
the newly allocated instance?

> +			return __trace_array_get(tr);

[Severity: Low]
Will this compile successfully? It appears __trace_array_get() is an
undeclared function, which might cause a build failure.

> +	}
> +	return -ENODEV;
> +}

[ ... ]

>  static const struct file_operations trace_options_core_fops =3D {
> -	.open =3D tracing_open_generic,
> -	.read =3D trace_options_core_read,
> -	.write =3D trace_options_core_write,
> -	.llseek =3D generic_file_llseek,
> +	.open		=3D trace_options_open,
> +	.read		=3D trace_options_core_read,
> +	.write		=3D trace_options_core_write,
> +	.llseek		=3D generic_file_llseek,
> +	.release	=3D trace_options_release,
>  };

[Severity: Critical]
This is a pre-existing issue, but does this same Use-After-Free
vulnerability also exist for tracer-specific options and other
per-instance files?

While this patch addresses core option files by replacing
tracing_open_generic with trace_options_open, files like
tracing_max_latency and tracer-specific options still appear to use
tracing_open_generic, which doesn't take a reference to the
trace_array.

For example, if a user opens a per-instance tracing_max_latency file,
keeps the descriptor open, and the instance is removed, could a
subsequent write dereference the freed memory?

kernel/trace/trace.c:tracing_max_lat_write() {
    ...
    return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
}

Where tracing_nsecs_write would perform an unlocked write to the
freed pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901163620.6cbe=
0ada@gandalf.local.home?part=3D1
