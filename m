Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B813DB97A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327984; cv=none; b=VTszU30aD/4QRhR810gkknUsPbrwAzvfqGfKphgZoNVAOp2rAVgsFRJxtyRt3Kk2j5TOyWTK93OEEsM2BdpjoUPzPXMYEhNK5OGnMv5hZUiPkDdGaxFiyp1zuCrx7rodgmlVdB+SSFWPDRxauxbP0MiBpOD+qVbNlOLoI1umRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327984; c=relaxed/simple;
	bh=2SAJuzcYI9ojgD6/DgJ7aNVu2ZGXwVmYYeTuzHPq2XI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XlOMukw3a23FZFCvl+kIjx4hOo2y0Fb8jObJLTRqr9/EC2SiNha5a4Aud08bRQHo7c5wXeQQ5sSl8ZQDUT6B64sBbH/mFeAukHNr/+sYKrTP0C/bbI7gcU4qMwAd90YF/JSbKHrytj0Dfp1QT1MOrytdhIFQllCxnDNn10uf2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZCDy6Oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZCDy6Oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A771F0089B;
	Tue,  6 Oct 2026 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327984;
	bh=KnXLh+wo1IMc2WZ2UXT7QeRUvp1pfGjJecjhKqI0/Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZCDy6OjfmrjudAlq3hDOhLYDdJB4Ql+ZD+ncpjeLCx6oUX4qA0b4r0lYYcamxFGc
	 xgC9VqZaBq/xiHwl5+Xrvn28KV0dn4nUxcExDJOSrKTauSjgkeqhI5MZ09Gv5LJMN+
	 MXoMccaaZaLnAOKD6gBXbewj4ipJR7KDjn1whoy7Vr4DBVel0oSVas0uGrZD039tD5
	 rJUu9+gCKP9uOo85wfkFGfdrcFt+SWgIDl9rJ/hYe8O1nZdQ9wLY8fY+/AghaRvULx
	 JBxdrsIm4DUc3UrZSlPnD61fvNrgUEGBhNvhKGn5evGmlLfGFq5OFdx2+vsB/IAKjO
	 1Nr0d7jXGZz/A==
Message-ID: <sashiko-outbox-162502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before
 resolving .function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261006225112.53503-1-kylebot@openai.com>
References: <20261006225112.53503-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:06:23 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: perf string filters on pointer fields disclose kernel mem=
ory
--

commit 169e523d3d15d13ccfdf41ba6a65f6c9fb12fff8
Author: Kyle Zeng <kylebot@openai.com>
tracing/filters: Check perf permissions before resolving .function

This commit adds a permission check to the .function filter suffix in
perf counting filters to prevent exposing kernel symbol ranges. It closes
an oracle that could allow KASLR bypass via unprivileged tracing.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 2b46ca5360458..0f8c2054f4a72 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
[ ... ]
> @@ -1683,6 +1689,14 @@ static int parse_pred(const char *str, void *data,
> =20
>  	/* See if the field is a kernel function name */
>  	if ((len =3D str_has_prefix(str + i, ".function"))) {
> +		/* Even counting filters can disclose kernel addresses. */
> +		if (pdata->is_perf) {
> +			ret =3D perf_allow_tracepoint();
> +			if (ret) {
> +				parse_error(pe, ret, pos + i);
> +				return ret;
> +			}
> +		}
>  		function =3D true;
>  		i +=3D len;
>  	}

[Severity: High]
This successfully prevents KASLR bypass via the .function suffix, but does
it leave a similar memory disclosure oracle open for standard string matches
on pointer fields?

Later in parse_pred(), if the field is a pointer and the user omits the
.ustring suffix, the predicate is assigned FILTER_PRED_FN_PCHAR without
checking perf_allow_tracepoint():

kernel/trace/trace_events_filter.c:parse_pred() {
    ...
		if (ustring)
			pred->fn_num =3D FILTER_PRED_FN_PCHAR_USER;
		else
			pred->fn_num =3D FILTER_PRED_FN_PCHAR;
    ...
}

Could an unprivileged user create a counting perf event without
PERF_SAMPLE_RAW on a syscall tracepoint like sys_enter_openat (which is
allowed because syscall tracepoints have the TRACE_EVENT_FL_CAP_ANY flag)?

If they set a string wildcard filter (e.g., ~ "secret*") on a pointer field
like filename, wouldn't the filter engine read from the user-controlled
kernel_addr when evaluating FILTER_PRED_FN_PCHAR?

kernel/trace/trace_events_filter.c:test_string() {
    ...
	/* For safety, do not trust the string pointer */
	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
		return NULL;
    ...
}

If the kernel memory successfully matches the wildcard, the perf counter
increments, which could allow an attacker to extract arbitrary kernel memory
byte-by-byte.

Should perf_allow_tracepoint() also be checked before assigning
FILTER_PRED_FN_PCHAR to prevent this disclosure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006225112.5350=
3-1-kylebot@openai.com?part=3D1
