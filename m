Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB883803F2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630982; cv=none; b=s7cRPJKXWv4X3+QKaSD+29GQSEYC18Xf8UJ8pIPYW+7WrBCk+iENuWvyzHVsZa37rEt4ZAkhCzIQ3WAQKJqVLUcJiwuMEhXODZd7oIU9Mj53jqIilKR+inTs0R6ueoprufQ6hBY/Dzc0SKegFkpu4QHsxz/nsOcOnSK3/asNucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630982; c=relaxed/simple;
	bh=MdkYpj9ghrEf1ZYch9mCt8yXWujDFqapMNPyTkhuuoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWER2dS82h54xq3gETT0FbI1/374e8JdCHkJ0RuhTRivW0xl805fE9o0N4IR1JO58L5Ks5FwvRJz4+jJOm5EVULKjIjYl9s/gMavJkcja0slyqV9HtpLXoQb/xW7VNwxbqBOwmFqo9flq98HoqfLZ8hp5a8vbtpJU9lFfBEoen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4lF0or5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4lF0or5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D4F1F000E9;
	Thu, 13 Aug 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630979;
	bh=K+6eZQuobTdwv2dXF4f4g+QjN0VHLjLHTehC9y52jIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4lF0or5uUVjZIHZsZQaQYVLXVkO/hJZp6cDzK0uBf+ocm5rmkxWU/j0rnx9CA0C9
	 7nnjpY7ZarcIPtMaD2ZxXsSMvDGM17T7+DQnilbZcAsmPKilR65HWlOqb/BoXaFOJp
	 pEB0E9yHQ2Ow9/yHeDEWJcGa+NOHLD+uA4QTyORz8qumU/b74nhEpAjNMBHHxE/H7n
	 igws/QmHhGdOxzDr04jgLJI5J24US6WMwn8Bp8Y6AFESF/9SbSFSLtLRp0e8m9+jGi
	 7i74A96DDGQrQyiHlRdZEJEq3TWdZfdQWRx0GbLCdA9cmXRJE4wVljamFZNlN0oTnD
	 nItKIBl57zyhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 7/7] tracing: Parse filter from event string
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-tracing-cli-event-filter-v1-7-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
 <20260813-tracing-cli-event-filter-v1-7-57c4e8029c86@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:22:58 +0000
Message-Id: <20260813142258.D2D4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `:mod:` suffix parsing using `strstr` is broken by the introdu=
ction of filter expressions, which can legitimately contain `:mod:` within =
string literals.
- [Medium] Unintended userspace ABI change for the debugfs `set_event` inte=
rface by exposing event string filter parsing.
--

--- Patch [7]: [PATCH RFC 7/7] tracing: Parse filter from event string ---
commit d99b1133b250a61ac85f36416d5a9f5e175d37f9
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

tracing: Parse filter from event string

This commit makes it possible to specify a trace event filter from the kern=
el
command line by extracting it from the event string.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c24929d003dd6..d4c46b24c3829 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1426,10 +1426,12 @@ static int __ftrace_set_clr_event(struct trace_ar=
ray *tr, const char *match,
>  }
> =20
>  VISIBLE_IF_KUNIT void
> -ftrace_parse_event_string(char *buf, char **match, char **sub, char **ev=
ent, char **mod)
> +ftrace_parse_event_string(char *buf, char **match, char **sub, char **ev=
ent, char **mod,
> +			  char **filter)
>  {
>  	*event =3D NULL;
>  	*sub =3D NULL;
> +	*filter =3D NULL;
> =20
>  	/* Modules events can be appended with :mod:<module> */
>  	*mod =3D strstr(buf, ":mod:");

[Severity: High]
Does this code incorrectly match the module string inside the filter string?

If a filter expression is provided that legitimately contains the literal
string ":mod:" (for example, comm =3D=3D "my:mod:app"), strstr() will match=
 it
here before the buffer is tokenized.=20

This could truncate the filter and falsely extract a module name, causing
event enablement to fail.

[ ... ]

> @@ -1471,7 +1476,7 @@ EXPORT_SYMBOL_IF_KUNIT(ftrace_parse_event_string);
> =20
>  int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int s=
et)
>  {
> -	char *event, *sub, *match, *mod;
> +	char *event, *sub, *match, *mod, *filter;
> =20
>  	if (!tr)
>  		return -ENOENT;
> @@ -1480,9 +1485,9 @@ int ftrace_set_clr_event(struct trace_array *tr, co=
nst char *_buf, int set)
>  	if (!buf)
>  		return -ENOMEM;
> =20
> -	ftrace_parse_event_string(buf, &match, &sub, &event, &mod);
> +	ftrace_parse_event_string(buf, &match, &sub, &event, &mod, &filter);
> =20
> -	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, NULL);
> +	return __ftrace_set_clr_event(tr, match, sub, event, set, mod, filter);
>  }

[Severity: Medium]
Will this unintentionally alter the ABI for the set_event debugfs file?

Since ftrace_set_clr_event() is called by the debugfs set_event file write
handler, this change exposes the filter parsing to userspace writes.=20

Writing strings with colons directly to set_event will now attempt to parse
them as filters, changing the expected ABI behavior and error semantics of
the interface.=20

As mentioned in the patch notes, shouldn't this be limited to only apply to
the command line path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-tracing-cl=
i-event-filter-v1-0-57c4e8029c86@linutronix.de?part=3D7
