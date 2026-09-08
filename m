Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3C385509
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849338; cv=none; b=rniCzkHMA1eAlgTLwahw7h2MfC7pdR5Cm1z56KPBxlgr6dW/fn+5vTj8XAFrkuu+le1aJwGJdEzJDSQjn8OblRoPR7kYlwSQLDOnEzgu5SNDuyh9G8h8vP1k88hNXaCWLQ/XM11G327NNp/6RtoVb514Ks4J3AOl4gavxdRNM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849338; c=relaxed/simple;
	bh=SKOZ1axW/POPOpXWExkcHqLZw7sNzpAsspDntFOl9X0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4cjPFDc//ucC549oOIdFxFdvgpscNzOwhVA0nBnV5wCrVJTWHSRV65v980bSpv+cyEygVsuBm/fVwWpircgeogVQWIN0rLPqAk97MryqauGD3LIo3rYZpis3yXl2UveRp3uVhkOdmgpBhO47NLCPJlakW3AHeBqm6uqAb7kRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7yJ0srg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7yJ0srg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A4E1F00A3A;
	Tue,  8 Sep 2026 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849336;
	bh=S+gvlnLx95i9dOqJuKlTnLiXLpH9katBiJqo8SsNafo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7yJ0srg0r0QZG/pesjijz+dgLi36j29qGA0I5mBFv4TTobBzuF2CCXRCHOwTyCUq
	 +QsB26pAj1Iqsk/YYMKt4vYdhCOENnKpY8Q+GaN/6JHKkwKf9YIIh+SUN05TjNQG0t
	 Z5J5p6VqUx9eAmiM2lRM8rgQ7bzYXndkd+lVyFr/DyQGeFZ0fu0MkGFpRndWdaj3Vc
	 i0S70fIEeVS9pxEG+L7u1UoEPARz7+kSGPF7VPdS8WFe+pHC24INhkIoH8ctqxHeek
	 4B0KsBQ+GzfzE/XrzWh4AmKm/YRortwZPwePl8GSwvwbw5CMCSMavyAiuRv0zBefxD
	 EOpPc5GlIyCmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] tracing: Parse filter from boot event string
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260908-tracing-cli-event-filter-v2-7-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
 <20260908-tracing-cli-event-filter-v2-7-05396a3fb663@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:35:35 +0000
Message-Id: <20260908063536.D3A4E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Implicit pointer-to-bool conversion in `trace_events_test.c` preven=
ts testing `handle_filter=3Dtrue` without a filter.
--

commit 125cd0f8d3ca4f597f1025a42dc567d0ce8c0b36
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

tracing: Parse filter from boot event string

This patch enables specifying a trace event filter from the kernel command
line by parsing the :filter: keyword in the boot event string. It updates
the trace event parsing logic and the associated kunit tests to handle
the new syntax.

> diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events=
_test.c
> --- a/kernel/trace/trace_events_test.c
> +++ b/kernel/trace/trace_events_test.c

[ ... ]

> @@ -72,18 +91,19 @@ KUNIT_ARRAY_PARAM(parse_event_string, parse_event_str=
ing_test_cases, parse_event
>  static void parse_event_string(struct kunit *test)
>  {
>  	const struct parse_event_string_test_case *params =3D test->param_value;
> -	char *input, *match, *sub, *event, *mod;
> +	char *input, *match, *sub, *event, *mod, *filter;
> =20
>  	input =3D kunit_kstrdup(test, params->input, GFP_KERNEL);
>  	if (!input)
>  		kunit_skip(test, "ENOMEM");
> =20
> -	ftrace_parse_event_string(input, &match, &sub, &event, &mod);
> +	ftrace_parse_event_string(input, &match, &sub, &event, &mod, params->fi=
lter, &filter);

[Severity: Low]
Does this pass params->filter (a const char pointer) to the bool handle_fil=
ter
argument of ftrace_parse_event_string()?=20

This implicitly casts the pointer to a boolean, meaning handle_filter is on=
ly
true when a filter string is expected in the test case output.=20

Consequently, could the test suite miss coverage for the common early boot
path where handle_filter is set to true, but no :filter: keyword is actually
present in the input string?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-tracing-cl=
i-event-filter-v2-0-05396a3fb663@linutronix.de?part=3D7
