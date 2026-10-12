Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B314AB1CF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821636; cv=none; b=KsdJwl4EgZymezPj02nhI395j3kqT1067oL47XYDL28E6IUDnAcLZAw8O2F57uOP1i/vdgEFqEsJg+2pg8GlZQqikRvHEgldvMEEBDO6Ej4syCdS0/4mXTUYB8+IWUOOQNf0CP9cIED+gvDD+AVFcrS9eyuo0499YU6LKHQGQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821636; c=relaxed/simple;
	bh=2DVCguiOk+NFFi948SLdrInDWdH6lU0WKxW4EvZcpjc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mfhZmvClbhB1J9Uz8zbN38hDQaJZ8rOvMNAMOLisIEwYfeTp+USHWnqLNem0TBr8rhEpCwgV9E5k/wBr1IJMjnVzwwNWvBe9B/JKY5ncaz5P2ot4Z1cnLpmkEefIV3GvGv5RwPQNDXZPl2d7qE1HmCTQcabWkrRFhv8Xu3xV2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwOrkmLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwOrkmLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB4B1F0089B;
	Mon, 12 Oct 2026 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821635;
	bh=Qxpg6wfZNxFnFMuf2Dcv5BmA4QtXpySUuf34yzQCT3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwOrkmLF5+4s2itB2VTgXjBYozMscSlskMR+T7RA7YsWlxRSUz1TxjCq4r3bKIB31
	 PHshwDeG+zh7/2pXIlpREmWqAQsJmvF09rCTOJ/zjuAmDwSqM4l83N1c0dJURxqRgp
	 C7lUsHNTRLhNHZWd1s3EWxpyiZ2xkl2jXWsnCUrUrv/q62oZ63GoZQyLx2vZTXaU3y
	 YpQPEZsgem+mmiv1+G/sRAsX2RiBw+v3LHXxLVBILeT9BXn34v9rFn3pPuvzerQ/nX
	 gdaeuOQmI+WwzjLCOuk6xtFgNswCD4n+QaRx+dHiNub641Oc20Tnbk57OueLK4DGqd
	 rYxjkzitL5jhg==
Message-ID: <sashiko-outbox-168379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/histograms: Reject non-stacktrace fields for
 synthetic stacktrace fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261012155805.1103972-1-lee@kernel.org>
References: <20261012155805.1103972-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:13:54 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tracing: check_synth_field regression for __bitmask and stacktraces
- [High] tracing: arbitrary memory read via scalar to string synthetic fiel=
d mapping
--

commit 4813d717e995df13871068dd6fd996711ca8965d
Author: Lee Jones <lee@kernel.org>

tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace f=
ields

In check_synth_field(), when a synthetic event field is a stacktrace
and the histogram field is not a "long[" stacktrace array, validation falls
through to the generic size and signedness comparison.  This allows any
8-byte signed scalar histogram field to pass the fallback check and be
dereferenced as a kernel stacktrace pointer.  This commit attempts to reject
these mismatches by enforcing that field->is_stack matches the "long[" type.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 8af97fd4ee2d5..b09f5043e1543 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3946,7 +3946,10 @@ static int check_synth_field(struct synth_event *e=
vent,
>  	    && field->is_dynamic)
>  		return 0;
> =20
> -	if (strstr(hist_field->type, "long[") && field->is_stack)
> +	if (!!strstr(hist_field->type, "long[") !=3D field->is_stack)
> +		return -EINVAL;

[Severity: High]
Does this heuristic falsely match the long[ substring in __data_loc unsigned
long[] from __bitmask and __cpumask fields?

If is_stack =3D=3D false, this logic seems to falsely reject valid mappings.

If is_stack =3D=3D true, this appears to bypass validation and allow a 32-b=
it
__data_loc integer to be passed as the field value. Could this 32-bit integ=
er
then be cast to a pointer and dereferenced in
trace_events_synth.c:get_field_size() and trace_stack(), potentially causing
a kernel panic?

> +
> +	if (field->is_stack)
>  		return 0;
> =20
>  	if (strcmp(field->type, hist_field->type) !=3D 0) {
>  		if (field->size !=3D hist_field->size ||
>  		    (!field->is_string && field->is_signed !=3D hist_field->is_signed))
>  			return -EINVAL;
>  	}

[Severity: High]
It looks like this fallback logic fails to reject a scalar-to-string mappin=
g.

When creating a dynamic string synthetic field, its size is set to sizeof(u=
64)
and is_string is true.  Because field->size equals hist_field->size (8 byte=
s)
and !field->is_string short-circuits the type/signedness check, will an 8-b=
yte
scalar successfully map to a dynamic string?

If an attacker-controlled scalar is passed, can it be cast to a kernel poin=
ter
in trace_events_synth.c:trace_string() and used with fetch_store_strlen() to
arbitrarily read kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012155805.1103=
972-1-lee@kernel.org?part=3D1
