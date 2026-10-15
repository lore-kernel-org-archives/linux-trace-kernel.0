Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A44A0147
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052063; cv=none; b=Isef3dFIZ+xr8mN8HNY9bciS49ML7qKrMXfC07L3OkcJo40vH9nrO//iiCED+xWwOhz/hKKDpr/U7nXBszM8/y+yIGj7z4N25KQ6rTMvtdbh+B1X8qoPJt9jmSM2C1avn/jxnqI/UJfe0iuZOF5bFR3HhElv59mjxjbVQUJkFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052063; c=relaxed/simple;
	bh=fJujnb4UEBfy+LOR5hX19fHf/m7bw9cW8QhdGacPxZ4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dN6d1SuQ2B7QhD7FyGg8q2ibvyc0puMmSa3oMQ1Q6uTgYlzPFYnx2qAQVv5PN5PPl95ZN8HeT9wBXXpWv3pSFKy+DYGeJajgev+oCIbu1dMbnEI94npdxckHURe1z9Ubh0Zy87mx2lCrWTIpM0WyOek0q7+wRzXKIhcFlTXKWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHopWYLE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHopWYLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFA31F000C4;
	Thu, 15 Oct 2026 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052062;
	bh=y6G6yrHlbTaPqFgKSd5LQUMZc0Y561fQyxqTJRPXTAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHopWYLEp0aWz3FzuTdQZhGBJu3amCq/y8OEkzGHoRRYfChxmlJCU1Xdv+A3sQK8f
	 sTd6lqUfo9SC2FEFFmwjOlmEwZ9qk7FeKNOo4UL6McMpL89zHaNLFaniJ7SVDj8Uco
	 bVBVvzbKGjW1MTJ/zqMu2kB6WG+1DsSU+7odCxdp/5LXVktTMjtOpJWVt0Wu6psfqk
	 NPmcHWrJSvBSHZo92HP0H4FLNqxgVwJrazSKnq4MsqyHWTCCQ/81EqN0zJyq9qpbFK
	 N2VPvVkEqWNMy6NKCOV/1sLFPST9OiuV/ICcbDh/wMFP7FVykzywD2KaybMvMJzp34
	 jz9eVpkqCdzFA==
Message-ID: <sashiko-outbox-172455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: Fix crash in print_graph_function_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261015080351.121316-1-hao.ge@linux.dev>
References: <20261015080351.121316-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:14:21 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] trace: Transient NULL pointer deref in tracing_set_tracer() due to=
 non-atomic update
--

commit 8e34d0e2d1517b818cf24f9067ddfaa0e4b47cd2
Author: Hao Ge <hao.ge@linux.dev>

tracing: Fix crash in print_graph_function_event()

This commit attempts to fix a NULL pointer dereference in
print_graph_function_event() by ensuring tr->current_trace_flags is never
NULL. It provides a fallback to a static empty no_tracer_flags when a
selected tracer has no flags defined.

v1 Link: https://lore.kernel.org/all/20260920042139.70736-1-hao.ge@linux.de=
v/

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c8..fba9521d25115 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -1319,6 +1325,8 @@ static int run_tracer_selftest(struct tracer *type)
> =20
>  	tr->current_trace =3D type;
>  	tr->current_trace_flags =3D type->flags ? : type->default_flags;
> +	if (!tr->current_trace_flags)
> +		tr->current_trace_flags =3D &no_tracer_flags;

[Severity: High]
Does this non-atomic double assignment expose a transient NULL pointer to
concurrent lockless readers?

A concurrent reader might fetch tr->current_trace_flags during the brief
window between the first store (which writes NULL if the tracer lacks flags)
and the second store.

Could we compute the new flags pointer into a local variable first, and then
assign it to tr->current_trace_flags in a single store, perhaps using
WRITE_ONCE()?

[ ... ]
> @@ -5090,6 +5098,8 @@ int tracing_set_tracer(struct trace_array *tr, cons=
t char *buf)
>  	}
> =20
>  	tr->current_trace_flags =3D t->flags ? : t->tracer->flags;
> +	if (!tr->current_trace_flags)
> +		tr->current_trace_flags =3D &no_tracer_flags;

[Severity: High]
Can this similarly result in a regression with a transient NULL pointer
dereference?

While tracing_set_tracer() holds trace_types_lock, readers accessing the
trace file (via seq_read() -> s_show() -> print_trace_line() ->
print_graph_function_event()) iterate locklessly.

If a concurrent reader observes the intermediate NULL value, it will
dereference it (e.g., tr->current_trace_flags->val), leading to the exact
kernel panic this patch is meant to fix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015080351.1213=
16-1-hao.ge@linux.dev?part=3D1
