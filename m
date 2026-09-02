Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51630DD1B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367185; cv=none; b=cYsNsQ6sohwtkuTikWmNhq7NqRNMTgwAZ2MwtPnmoge5mi15G9HwzxkjxSSxWkt2ELwi85Ab1rr9IPXBOHrQN4QRrKfNPhH8Trni69oU91NcAvINgZFD6AYcQj9xh1yyiw8MoNVf7DhYEJQrn+IfAQR75BsF+JifstU40c4K26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367185; c=relaxed/simple;
	bh=wh28chnauxouUX8+LkHoI7SO7Youv01psukOZpgom/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmqV2iWKsQCI3s2bCEoogOB/S+mYsyAbp677bjW49wyG95J94LcUcii+HTvA2/OrPauoGe/B6r6rOPTwj22k7iWNtdVjDSmS914Eyy/NBsXuHelptSGbADBtAkvT2BcwCP+W0BYj+9ZuqjzQwxTn8R8ZWRM7e7Ln+4Rm+SQ54MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpQLtwPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpQLtwPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C21F000E9;
	Wed,  2 Sep 2026 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367184;
	bh=+lGDFnXaTwpAe9/NXZgUcrmQWj49u2dG8zpyUeGHKHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpQLtwPZTlD95Qg45Rgu8OYnmTOUEy+kW1oLTPgd6kLl3CvaisGfhzNxpcO4g/dvz
	 rccu4Y+FAz9MMaxh04PWdEvwsKPrOMzzLl4U8L0J3fLxmzMJ9zfZ6QD1YQSjv9vkma
	 NzMt1C8bqlQ9Syw8w8HAyEMIouPIENbIFFBOYkRkWWNyiKIPXHrMh+Ui6xyNOUszcP
	 Vt4w8Ur1ZdQE94U2eYuSEV94qFztvqTcvv52FhtVFOHHp1CqfpeuraY5m3QKMp9xV8
	 zeXSb2qOVONUDhK8+lYaEBI6DtUWcOB/5rq+NemQGna4PQJSnGCvjRaJ4XRLxDLP8w
	 vuB+8/b2LDcFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tracing: Take trace_array reference when opening
 options file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902121918.5a9e9d1b@gandalf.local.home>
References: <20260902121918.5a9e9d1b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:39:43 +0000
Message-Id: <20260902163943.E66C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Cross-instance privilege escalation via SLAB reuse in `trace_array=
_options_get`.
- [Low] Missing definition of `__trace_array_get()`, causing a compilation =
failure.

Pre-existing issues:
- [Critical] The patch only fixes the use-after-free for core options files=
 (`trace_options_core_fops`), leaving other instance files vulnerable to th=
e exact same UAF.
--

commit 692e0bd47e6544a583d3d3e1c5faabd7a045c813
Author: Steven Rostedt <rostedt@goodmis.org>

tracing: Take trace_array reference when opening options file

The options files do not take the trace_array reference for the options
they represent. This could cause a use-after-free kernel crash if one of
these files is opened by one task and another task removes the instance
that the option is for. Because it doesn't take a reference upon opening,
it will not stop the removal which will free the options descriptor that
is being used.

Closes: https://lore.kernel.org/linux-trace-kernel/20260828135858.2AC501F00=
0E9@smtp.kernel.org/

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d9..f172946edcb23 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -8809,11 +8809,70 @@ trace_options_core_write(struct file *filp, const=
 char __user *ubuf, size_t cnt,
>  	return cnt;
>  }
> =20
> +/*
> + * The tr_index is the address of a trace_array->trace_flags_index[]
> + * element that holds the index of the trace flag. But since the
> + * trace_array reference has not been taken yet, it cannot be referenced
> + * as it could have been freed by a rmdir of the instance the trace_array
> + * represents.
> + *
> + * Search the list of trace_arrays and compare the tr_index to the
> + * address of the entire trace_array trace_flags_index array for each
> + * trace_array in the list. If one is matched, then take the reference
> + * and return it. If not, the trace_array no longer exits.
> + */
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
> +		if (tr_index >=3D (void *)&tr->trace_flags_index[0] &&
> +		    tr_index < (void *)&tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])

[Severity: High]
Can this raw memory address validation in trace_array_options_get() be spoo=
fed
if a trace instance is removed and its memory is reused by the SLAB allocat=
or
for a new, potentially more privileged trace instance?

If an unprivileged user starts opening an option file for instance A, but
instance A is removed and its memory is reallocated to instance B before th=
is
check runs, could the stale tr_index match the new instance B's memory boun=
ds
and grant unauthorized access to its options?

> +			return __trace_array_get(tr);

[Severity: Low]
Is __trace_array_get() defined anywhere?

Will this cause a compilation failure because of an implicit function
declaration or undefined reference when compiling the kernel with tracing
enabled?

> +	}
> +	return -ENODEV;
> +}
> +
[ ... ]
> +static int trace_options_release(struct inode *inode, struct file *filp)
> +{
> +	void *tr_index =3D filp->private_data;
> +	struct trace_array *tr;
> +	unsigned int index;
> +
> +	get_tr_index(tr_index, &tr, &index);
> +
> +	trace_array_put(tr);
> +
> +	return 0;
> +}
> +
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
This is a pre-existing issue, but since we are fixing the use-after-free for
core option files by changing .open to trace_options_open here, do we also
need to fix other instance files like trace_options_fops, set_tracer_fops,
and tracing_max_lat_fops?

These structures still use tracing_open_generic, which does not take a
reference on the trace array.

Could they be vulnerable to the same use-after-free if another task removes
the trace instance while their files are held open?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902121918.5a9e=
9d1b@gandalf.local.home?part=3D1
