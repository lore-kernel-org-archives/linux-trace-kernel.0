Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E03955EB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657835; cv=none; b=tzYwsTfgl972x/cHY7F2hDf4O9CXcZ+cUGAoMy377AY/D4f7CPnNnhoznhUbgr7Nq8bx2p+2HNbh2K0cqog2Sx4qo6AaupGAhHEP+dCR+l1U1QfvofMd+hmSJWyKsfju2TymXQc5s1YS7pIlPNI0NKfBwnjjYDhfX3QKOzKfH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657835; c=relaxed/simple;
	bh=p88jNLDw8MKjCxEZyKxgmetzligippCbZbtBU7YTYDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FppmnwsqofqndQJjQmadYmbvMbS8o7FybFHYNq0ZgrZu9TRxAqbRm8itjLji/s3PpnnlFS3TZfO7YvaurvgZoqrgG/u+BVZWGpbZXSyeXPLI6XN8kFdfjPruHYnfUwL0zzxHfPrFFVJrgqvieWS2f3AUhxNNNyO1igLn6RFT46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULbOd50U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULbOd50U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188131F000E9;
	Tue, 25 Aug 2026 11:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657834;
	bh=6JKrm3cyS9TlmttaGiGdfrmpMUVqJ+fDcokd4DrwAIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULbOd50U6ZDiEvJVAyh9QJkR2UfAlX75xLCpWoUXMq1gbORpeqf2GTX3Fb/94DD7b
	 C8v9qwVOkv6NcyuPsXkyKkxRmSq/PX6QJHnDxU1+iRCMhZVBs+/IZqsmsk2IdVhrz+
	 1cvSanE2rY9k3dgaMpR59/7q3HkqzosWKn31SVfGzoCHkFZiAVf6RNkEB21wz8aAMk
	 gzphKWQSMG4tPLvm+S/SNKopkq3/csUyyacZ81xrk46oE/643TrZfiqrP7atVDkDgx
	 WNQ69VCP0AxY+Z/tG7FxHuZJ+K8qmOktSPHQm75+iiITmvCK/RwxbeHXzo+AUMVg+8
	 3dEfapccyRb6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tracing/probes: Fix use-after-free on field
 name/type of multi-probe events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260825111210.3271443-1-bsdhenrymartin@gmail.com>
References: <20260824144356.1f61aea2@gandalf.local.home>
 <20260825111210.3271443-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:37:13 +0000
Message-Id: <20260825113714.188131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Error handling in `traceprobe_define_arg_fields()` does not clean =
up `tpe->field_strings` or reset `tpe->nr_field_strings` on failure, leadin=
g to a memory leak, slab out-of-bounds write, and arbitrary free upon retry.
--

--- Patch [1]: [PATCH v3] tracing/probes: Fix use-after-free on field name/=
type of multi-probe events ---
commit b40c9f727280d82f97af5f38c001f0fd57efcf5e
Author: Henry Martin <bsdhenrymartin@gmail.com>

tracing/probes: Fix use-after-free on field name/type of multi-probe events

This commit addresses a use-after-free issue where an event's fields might
reference freed memory after one of its probes is removed. It fixes this by
allocating a duplicate set of name and type strings directly owned by the
trace_probe_event, ensuring they outlive any individual probe.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 36dff277de464..3057d31c57376 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -965,19 +965,48 @@ int traceprobe_set_print_fmt(struct trace_probe *tp=
, enum probe_print_type ptype
>  int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  				 size_t offset, struct trace_probe *tp)
>  {
> +	struct trace_probe_event *tpe =3D trace_probe_event_from_call(event_cal=
l);
>  	int ret, i;
> =20
> +	/*
> +	 * A field created by trace_define_field() only stores the name and
> +	 * type pointers, it does not copy the strings. Here they point into
> +	 * the probe_arg of @tp, which is freed when @tp is removed. For a
> +	 * multi-probe event the field list is defined once by the first probe
> +	 * but kept alive by the surviving siblings, so removing that first
> +	 * probe would leave the fields referencing freed memory. Make the
> +	 * event own duplicates that live as long as the event call itself.
> +	 */
> +	if (tp->nr_args) {
> +		tpe->field_strings =3D kcalloc(tp->nr_args * 2, sizeof(char *),
> +					     GFP_KERNEL);
> +		if (!tpe->field_strings)
> +			return -ENOMEM;
> +	}
> +
>  	/* Set argument names as fields */
>  	for (i =3D 0; i < tp->nr_args; i++) {
>  		struct probe_arg *parg =3D &tp->args[i];
>  		const char *fmt =3D parg->type->fmttype;
>  		int size =3D parg->type->size;
> +		char *name, *type;
> =20
>  		if (parg->fmt)
>  			fmt =3D parg->fmt;
>  		if (parg->count)
>  			size *=3D parg->count;
> -		ret =3D trace_define_field(event_call, fmt, parg->name,
> +
> +		name =3D kstrdup(parg->name, GFP_KERNEL);
> +		type =3D kstrdup(fmt, GFP_KERNEL);
> +		if (!name || !type) {
> +			kfree(name);
> +			kfree(type);
> +			return -ENOMEM;
> +		}
> +		tpe->field_strings[tpe->nr_field_strings++] =3D name;
> +		tpe->field_strings[tpe->nr_field_strings++] =3D type;
> +
> +		ret =3D trace_define_field(event_call, type, name,
>  					 offset + parg->offset, size,
>  					 parg->type->is_signed,
>  					 FILTER_OTHER);
> +		if (ret)
> +			return ret;

[Severity: High]
If trace_define_field() fails, does this error path leak the newly allocated
strings and the tpe->field_strings array?

Looking at event_define_fields() in kernel/trace/trace_events.c, the return
value from this function is ignored:

    if (field->type =3D=3D TRACE_FUNCTION_TYPE) {
        field->define_fields(call);
        break;
    }

Since the return value is ignored and the event's field list remains empty
if the first argument fails, couldn't the system invoke this function again=
=20
on retry if there are multiple trace array instances?

If it is retried, the initial kcalloc() unconditionally overwrites=20
tpe->field_strings, leaking the old array.

Additionally, since tpe->nr_field_strings is not reset on failure, wouldn't=
=20
a retry start appending string pointers out of bounds of the new array? =20
This appears like it could eventually cause trace_probe_event_free() to rea=
d=20
out-of-bounds pointers and pass them to kfree().

>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825111210.3271=
443-1-bsdhenrymartin@gmail.com?part=3D1
