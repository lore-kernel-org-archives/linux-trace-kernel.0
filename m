Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A29481247
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630503; cv=none; b=rh4rMG0gaL23C3dpjSuvHLkZUsDFXXvPmsF9xdrycqZZuW3v6OKGKh1RkUdorIB7m7Y8+smlg5Gh9CW/15M2YF/2til+MYKl9fSKurNUTxbKHLz0YK91pWIuf1nFzkE29AxXpkuEV0XLg5PT9HU2REhdJI3KeNsCpdWDUHOr+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630503; c=relaxed/simple;
	bh=Vt2Kh4fYpLVYuxixNQuNzoVK9vwbXay8f1xbjIOdsx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UE1sWNpeLEeySGbAse74urwv8OOXOLKbo8DVg5x+XH3FbP2ktgPjYeVt239HxzS3VFJz/vizL1k/+UVMJ+y2/l4aueuX8u34lgEOjtmK3C3rgmpHjEfXrzPyvJ9Lq6qRJQzsB1I78cKUj2tbh7jhM+JZ/LizIon2jP5UYBwx6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUvmlrq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUvmlrq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347E21F000E9;
	Thu, 13 Aug 2026 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630501;
	bh=Z4Hmh/PeoGObsMfV6r92seq6SLx+8Uvxp+Sm01EN52Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUvmlrq+CkRz7W5NwvPiEdemI5t7+hNHp1AXiTTf/af+UucxMw7do/AcMaJ4+cX/z
	 PtY3qCVohEvU+n9be7i3uwQWgXNOGvHSmcrJAjfAx0qMTUXE2csN8rdBGIfEXfErjA
	 Sn34nQHUQYz2SEFqnkyyPV04nPYJDy37XTFaiV3A0Knqc4aNzZP6sfmwiDE2unmF+z
	 ibkZ6N3B8l8zebpqQwQ1IwMnjmv9ICigYVeatXK24Ceii1e4nBesrGzDBWcxKB+CFQ
	 nN/78hUgm0CGxQDRHSbUkJKW/wQKXLMeuZSP7lMXVweNRlJ7YnJ9fhNKD56mNFd/rk
	 vv5shvdtMC1Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
 <20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:15:00 +0000
Message-Id: <20260813141501.347E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid free (causing kernel panic) and memory leak due to `strsep=
()` modifying a pointer managed by `__free(kfree)`.
--

--- Patch [3]: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in =
ftrace_set_clr_event() ---
commit c968a27c39638474537de841b7e2191407463142
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

tracing: Stop modifying the input buffer in ftrace_set_clr_event()

This commit changes ftrace_set_clr_event() to copy its input buffer using
kstrdup() and manage it with __free(kfree). This removes the need to
restore the original buffer modifications before returning.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6aa32c4922807..c75a7f5b55def 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1411,14 +1411,17 @@ static int __ftrace_set_clr_event(struct trace_ar=
ray *tr, const char *match,
>  	return ret;
>  }
> =20
> -int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> +int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int s=
et)
>  {
>  	char *event =3D NULL, *sub =3D NULL, *match, *mod;
> =20
>  	if (!tr)
>  		return -ENOENT;
> =20
> +	char *buf __free(kfree) =3D kstrdup(_buf, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +

[Severity: High]
Will this lead to an invalid free or memory leak when buf is later modified=
?=20

Further down in ftrace_set_clr_event(), buf is passed to strsep(), which
modifies the pointer in place:

    match =3D strsep(&buf, ":");

If strsep() advances the pointer to the next token, the cleanup function
will call kfree() on an interior pointer, causing a slab corruption bug or
kernel panic upon scope exit. If buf is advanced to NULL (when no colon is
found), it will result in a memory leak of the duplicated string since
kfree(NULL) is a no-op.

Could a separate pointer be used to track the allocation for cleanup,
leaving buf free to be safely advanced by strsep()?

>  	/* Modules events can be appended with :mod:<module> */
>  	mod =3D strstr(buf, ":mod:");
>  	if (mod) {

[ ... ]

> @@ -1455,15 +1458,7 @@ int ftrace_set_clr_event(struct trace_array *tr, c=
har *buf, int set)
>  			match =3D NULL;
>  	}
> =20
> -	ret =3D __ftrace_set_clr_event(tr, match, sub, event, set, mod);
> -
> -	/* Put back the colon to allow this to be called again */
> -	if (buf)
> -		*(buf - 1) =3D ':';
> -	if (mod)
> -		*(mod - 5) =3D ':';
> -
> -	return ret;
> +	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-tracing-cl=
i-event-filter-v1-0-57c4e8029c86@linutronix.de?part=3D3
