Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149174;
	b=Aw4LOOqJenGLc7lPruk27v0/qXfQTSb68zGQb4EggQCO74SHAEP0IeV+HUlp8/CX+Ag3
	 B65x/C7odj+wl4FWsJ2s+/z9X7FkMrkljUEWKpbRfyCMaF5xBkg50SK0J+odWkTk6CNQ9
	 rrjbGqKeZIyA6izQmSEL3LiBzPBBb7QY+a7DmF4nHobM9n7hm+E95Hg2/BFAOqwoKa7Iz
	 b2yQ3wS/ah0GQtZEWVC/yT8lA518y007dCS6ygHyKz/I2lKcIH0ukeW3V+rc0zEmlsqw/
	 TJ6k78BrSY7Nbn6ecOSeO4ZJzo9kd924RVH6G+i8dZHxceITbLHAlCqKFVCBv14zc7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ml2xjQJmqz5iCIqIJIRvH+MPhWkpy3JYO1E2rR6asSA=;
	b=jAVepPxADOx89hnjp1AEeuGx7DZuUeFaM3cJ379ZpxYXQDY0nAEtTsEFR76oet+D1Qwo
	 y8PKKXObC0aDJupakB3wlENNVqQP/tqdthijp3LZEuspQCS0P/8ZzNIf5enzwI0tpo1Q3
	 yS9HEA+NDYFkvSKIvOXnkj9mUDF9IhuxYri27PPgepQD7jyaCM7LoBpWPpKb4DHOQBFbp
	 a+DAVnsCgZ3suyOCYEPsIkqWZY/K+986pJlKC/WLj4ch09wUkUcTiboCitzp17IJR5wRr
	 BzdHRphltTJoChzhNsB1/MB3gO9mBdY89myx5TVt4Gjg1PIbJ1H7u4HWioqf+myd3vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhMdMNog;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C4606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhMdMNog
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50AC1F01825;
	Wed, 28 Oct 2026 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149173;
	bh=ml2xjQJmqz5iCIqIJIRvH+MPhWkpy3JYO1E2rR6asSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhMdMNogOMsmNlDgYxnFsBsdzyWGoJUDEnRO8blXqGnHHqSCX2OSZ0GdPeyfA6Eoy
	 g+v6MZC/ruNtaqVoC1rrwnV2l4zQc4m5VNhSvaeduVGAFBLRDuF2Y14e4uwwboEiN5
	 dEgekodtGnLFTU2OLqJHK0fj4Yzyz+J5lv2//Esmt1ijT948/00D55+MwDiTIsLn/0
	 7GUl49MuWrVy6x204daU5ppdh4n7oVRxLydxT5Cx15F9mURGOzj+8ZmoPJ1ZPtPOlB
	 CRhtz9qKqJrdG1XHyQyG4fzUqa5qZd3gQzp7xwuKkxWbE8w/EDimeX0wIsfBcSg/ta
	 HzW26pTtH7mzg==
Message-ID: <sashiko-outbox-187295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/16] tracing/filters: Fix regex_match_end() for
 zero-length strings
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179314821463.684037.6329696159956371930.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
 <179314821463.684037.6329696159956371930.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:59:33 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing/filters: redundant check in regex_match_end() makes patc=
h a no-op
--

commit 8e400c22f46c7fff9d91b8c8e837ab24dfa0f5cd
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Fix regex_match_end() for zero-length strings

This commit adds an early return in regex_match_end() when len <=3D r->len =
to
avoid underflowing len - 1 and accessing the input string when len is 0 or
smaller than the pattern.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 5e74d2dae40a3..59a0d3ba72740 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1075,8 +1075,12 @@ static int regex_match_middle(char *str, struct re=
gex *r, int len)
> =20
>  static int regex_match_end(char *str, struct regex *r, int len)
>  {
> -	int strlen =3D len - 1;
> +	int strlen;
> =20
> +	if (len <=3D r->len)
> +		return 0;
> +
> +	strlen =3D len - 1;
>  	if (strlen >=3D r->len &&
>  	    memcmp(str + strlen - r->len, r->pattern, r->len) =3D=3D 0)
>  		return 1;

[Severity: Medium]
Does this change have any functional effect in regex_match_end() in
kernel/trace/trace_events_filter.c?

In regex_match_end(), len, strlen, and r->len (defined in struct regex in
kernel/trace/trace.h and initialized from strlen(search) >=3D 0 in
filter_build_regex()) are all signed int variables.

When len is 0, strlen =3D len - 1 evaluates to -1. Because both strlen and
r->len are signed ints and r->len >=3D 0, the existing check:

	if (strlen >=3D r->len &&
	    memcmp(str + strlen - r->len, r->pattern, r->len) =3D=3D 0)

evaluates -1 >=3D r->len, which is false and short-circuits before calling
memcmp() or dereferencing str.

More generally, for signed integers len >=3D 0 and r->len >=3D 0, the new c=
heck
len <=3D r->len is equivalent to (len - 1) < r->len (i.e. strlen < r->len),
which is the exact negation of the existing strlen >=3D r->len check. With =
the
early return in place, strlen >=3D r->len is also unconditionally true and
redundant.

Since the pre-existing condition already prevented out-of-bounds access when
len =3D=3D 0 or len <=3D r->len, is this patch (along with the Fixes and st=
able
tags) necessary, or was a different change intended here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179314820431.684037=
.4147763044424284198.stgit@devnote2?part=3D1
