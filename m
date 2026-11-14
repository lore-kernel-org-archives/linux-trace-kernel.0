Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794687159;
	b=XSD3EstIGWUQu9Zx5ubFa63CHvHdGfbOTqsW4QMnCb0XjZIGY4eBMBaqu3gfttZMw/WF
	 SJMsLZxpBTJtBxn2BIgaWkenV9zCl9/UyPVgShNiK0jBEFBkS/KZYSde8Bj4Ofh77LyOb
	 QKLZjIb/I6EdUV3CyiJYB9Zxg8A9t7kcjl0btn+3M0AxA+/YrMUjjy0zMaEAoCaskwSxk
	 tYpvR/hbzxdVfRkWo4plD9bWuLsIrh/GM3oBYdVspTWfEo2Cd9CLCxA3duW0iaofpl/m5
	 IGyKQ1n/jFF9+nince+8/rsGWeAeFPtkO0/33UXK6YLMQGUS8Ki8A/kPFbTJ2E1wQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794687159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+816doUeVPXfistAeMVbDToCFsLaxBc2ryrT4rbGSWY=;
	b=Q87fA0nKUCqkuiDAnEAUN/sHVFiVSQq3yF5jtLz0WGLcvUsZUq6rmigkxhPzfgaGXUFA
	 /fVzb9TTcKsf9GQxwW6z1diDgVEMnpwgTZbiXpe5llCjQPhGcYBEAhc69wmPowog6H1O1
	 DpGB3KpdsNXY+BSPCkimxX6MCLJ0Q5bMwuezvE13Ba2dLVKRqa3W6ork8MtDkmBSWR1tj
	 C68lKgt128qcGcaqHsFvx2aH0MCHQZbyp/qUVNsibe+wNLNmV6gSQGh3xfYAZdcop+xvV
	 MBBSmwGOFPNpkbWtKMenigBmLiLhjJOhRU3wArnmwVeExIxvr+vw4eYoU5PHmVKFLoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2ayYzhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE8606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q2ayYzhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9BF1F000C4;
	Sat, 14 Nov 2026 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794687158;
	bh=+816doUeVPXfistAeMVbDToCFsLaxBc2ryrT4rbGSWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2ayYzhNj86CWDxmeMnWYvySW0Auc3cmsQKDKxZsO6ptzpflZqjiASczRyAeusg+6
	 4Hxe25qnd2gzYxL+74fhv9xU1vycimDFPE6oXzVoA11ziFmRVai8cBFDhsgTqM4G1D
	 SYIxTL3UZmY1I7+sO2rxG3IG2i7FKv4YRGrZlcJ6mS79rdDgyW0BNuNhjBdMTQrqjT
	 t8rDxMq+K6NggLWMJCY2UsqQl5i3yKo4rdtBEjrPhyIVPCfLfvx9aBhwA7YpqcnjW7
	 HyCWgcJf5Ew9rikIAMSbYCF3LC5EFtlJk+oulA6kXLWKgQzz1Ny+yUacOe6MTlApKa
	 1harSEI8+2ZQg==
Message-ID: <sashiko-outbox-214993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Reject .function on the function trace event
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261114195914.2678414-1-devnexen@gmail.com>
References: <20261114195914.2678414-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 20:12:37 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] tracing: out-of-bounds read in parse_pred() on empty
  function filter operand [1]
--

commit e67c952556cf8df0fc74a91895fdbea1c0dd54b5
Author: David Carlier <devnexen@gmail.com>

tracing: Reject .function on the function trace event

This commit rejects the .function filter suffix on the function trace
event so that parse_pred() does not build a predicate with a NULL regex.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 5e74d2dae40a3..9c807191166ba 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1744,6 +1744,12 @@ static int parse_pred(const char *str, void *data,
>  	pred->op =3D op;
> =20
>  	if (function) {
> +		/* Function events already take a function name on 'ip' */
> +		if (ftrace_event_is_function(call)) {
> +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> +			goto err_free;
> +		}
> +
>  		/* The field must be the same size as long */
>  		if (field->size !=3D sizeof(long)) {
>  			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);

[Severity: Critical]
This problem wasn't introduced by this patch, but can the paired
ftrace_event_is_function(call) branch in parse_pred() read past the end
of str [1] when the filter has no operand after the operator (for
example, "ip =3D=3D")?

kernel/trace/trace_events_filter.c:parse_pred() {
	...
	} else if (ftrace_event_is_function(call)) {
		...
		if (str[i] =3D=3D '\'' || str[i] =3D=3D '"')
			q =3D str[i];
		else
			q =3D 0;

		for (i++; str[i]; i++) {
	...
}

When str ends after the operator and optional whitespace, str[i] is the
terminating NUL byte and q is set to 0.  The loop initializer i++ then
advances i one byte past the NUL terminator before checking str[i], so
parse_pred() scans out-of-bounds slab memory, copies it into
pred->regex->pattern, and returns the out-of-bounds offset to
predicate_parse().

[1] https://sashiko.dev/#/bug/linux-911099f1-cea5-4f84-ba41-25fbcbb66dad

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114195914.2678=
414-1-devnexen@gmail.com?part=3D1
