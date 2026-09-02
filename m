Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408F4A9D4C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364929; cv=none; b=UEJ7CV68VjhJClPfeScCk+vkKa3l5dSFyEJRaMXpQk2lPVvxSPmT8D+PwjFGzP9pkM1WeuHTiT6RZrIvjhYXM31sw7BjXn6LPR0eKmJYr5qZQy5D4F7pWVTuxviiIX1rrhFDBafJnaJ91FuzVEYrNsYJYfUkKunW9RTyXCuNrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364929; c=relaxed/simple;
	bh=wCyWO6igle3tHFb/WOM44Uj3t/2lzWLQU291SaAUKLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dt4kFS1ikJU3ftNfNdeHcAbF4/2IBlRclSvHgFjNW7otqfEWLhF3OJJG60wZYe0QFOQjFaDK5jkd+8Tgde6/n5qv42mJzwsP0fPU/puCCtMMeoVnmbvyFB/3kZaDbssejjtOnXJrI0ghoP6gB58DPQX6yq7fhjmukm343ej+LG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN+BN7E+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN+BN7E+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE51F000E9;
	Wed,  2 Sep 2026 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364928;
	bh=5qQn5hfh7wXNLaZK3qY2TfnIJ9twHYC5RCc3yPpr0zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PN+BN7E+CrknuyQ/s3OwQkTQr4o4Pf3KWHYUHn207tg+VCm5bhRdh7jM4o58UH2yy
	 ueib+gW4Oym6Rtl41kvrqeE1xCXkT7VPaLyDq4G5Ut7T5qR1DoDM8YFXjcU1McFxky
	 RBATdbBU010IQCSs351WUsJZI7NKab9NF6dPSVuiF2RJhOI9f8PM2OzgS1fuNTzmD4
	 ne4bKGJEud+FpH9RbTevhGyHs6BhdIXhL2Q7y/G90Jzt+Y/Svu7tN9Vz4dXmvH8ape
	 gg8I/WBqaVych/FwL1GVV5jqdx3Zb2QB1eWlKwN811TB0obhWzVbklJG8aYMRjhZuM
	 fjrda29ewpNLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: Take trace_array reference when opening
 options file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902114502.723d8243@gandalf.local.home>
References: <20260902114502.723d8243@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:02:07 +0000
Message-Id: <20260902160208.12BE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a call to `__trace_array_get()`, which is neit=
her declared nor defined anywhere in the kernel, causing a build failure.
- [Low] The commit message claims to have added a `(void *)` cast to fix a =
kernel test robot warning, but the cast is missing from the submitted patch.

Pre-existing issues:
- [Critical] The patch fixes the use-after-free for core options, but leave=
s tracer-specific options and other per-instance files vulnerable to the ex=
act same use-after-free.
- [Critical] The validation logic for the dangling trace_array pointer is v=
ulnerable to an ABA (Slab Reuse) problem, allowing cross-instance privilege=
 escalation.
--

commit 16f2151bdbc0994e69e88bb0c5631ea2027da7fa
Author: Steven Rostedt <rostedt@goodmis.org>

tracing: Take trace_array reference when opening options file

This patch addresses a use-after-free when an options file is opened by
one task and the underlying trace instance is removed by another. It adds
a new helper to validate the index element address and safely acquire a
reference to the trace_array.

Closes: https://lore.kernel.org/linux-trace-kernel/20260828135858.2AC501F00=
0E9@smtp.kernel.org/

> - Added (void *) typecast to comparison. (kernel test robot)

[Severity: Low]
Does the pointer comparison in the code still trigger a compiler warning?
The patch notes mention adding a (void *) typecast to fix a kernel test
robot warning, but the cast appears to be missing from the submitted code.

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

[Severity: Critical]
This is a pre-existing issue, but does this validation logic remain
vulnerable to an ABA (slab reuse) problem? If an unprivileged user holds
an O_PATH file descriptor to a freed instance's options file, the inode
is kept alive with a dangling i_private pointer.

If a new instance is created and allocated at the exact same memory
address, wouldn't this bounds check falsely succeed on the dangling
pointer, granting read and write access to the new (potentially root-create=
d)
trace_array options? This same ABA flaw seems to exist in the general
trace_array_get() function as well.

> +			return __trace_array_get(tr);

[Severity: Low]
Is __trace_array_get() defined anywhere in the kernel? It looks like
this might cause a build failure because the function is neither declared
nor defined.

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
This is a pre-existing issue, but by only updating trace_options_core_fops,
do tracer-specific options and other per-instance files remain vulnerable
to the exact same use-after-free?=20

Files like trace_options_fops, set_tracer_fops, and tracing_max_lat_fops
still use tracing_open_generic for their open callbacks, which fails to
take a reference to the instance's trace_array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902114502.723d=
8243@gandalf.local.home?part=3D1
