Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68632480DEC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630491; cv=none; b=bCAeIEPBxnc03YFoC5n6dKOZ14bqejGZBCsfrm9ZBX8NuxD1TaQWZjfbeoRkuSADZJ5mUU0wiOr9bwDq0yU1ke27/fV5YSRjHDxpYjxNFuNkjNkQ8Smxmd0TyGzpiVSB0XIVp//OoHJXyhe9IRqO4jUZEb9C+pbjMPuKP1vhd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630491; c=relaxed/simple;
	bh=OxGc9GRqld02HXfZDQ6SLkMsFfCEBYC0F3OfZ8Z3mfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mWHLyBbOme34F1Wc9BsPWputEEMw7+A1sl9Kj4HGgMzeCGBPQcjoRjXNJGLRQKILl5QSB5IYHpqeXsNuww1e8zSl1v/s8RamkeEsQB8nq+1nWOddj2k/CkblE4UtN0VWSiVPeIbLZfG5GdRzTACnwCAnIw5uSagmDBoN/ir8/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnfBzpD7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnfBzpD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8251F000E9;
	Thu, 13 Aug 2026 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630490;
	bh=wO/y2V9T/UgiZDZM5X8RnOlDBigVHb1DudpHTjwIYws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnfBzpD7AjLUJ9NTx047liRlCLx5iuScCd1yP3yjITyc6aoYjZhEcG74CyK8D/IEM
	 0UVkTj400oUBkXI2WnSAOHXdUJ2mt6nQ8/tf4mLE4GjDPe1iDU9oMJDdQu5Rtbjsmg
	 KBUCV96FWpq3PevX4ImVQ9xIbBrebiq2MVQOTYSlIBQcuQekYiPLwe3t50Fw2ZRqZl
	 DOaIFyOawCHf0xHHEjgcb5mOj9Iu79zcc33TF/cAukMUC4DIpi6bOgw7Pmn7DmRBly
	 rg3VuuHy6iWgA+v0swHwZxI35gGDucYjQUppRWLg8zbHH/bwYw4L7374bRusTYgbB8
	 ojNtl6wCL+nsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/7] tracing: Add a test for
 ftrace_parse_event_string()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-tracing-cli-event-filter-v1-5-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
 <20260813-tracing-cli-event-filter-v1-5-57c4e8029c86@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:14:49 +0000
Message-Id: <20260813141450.2D8251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added module `trace_events_test.c` lacks a `MODULE_DESCRI=
PTION()` declaration. Since `CONFIG_EVENT_TRACING_TEST` is a tristate confi=
g, the code can be compiled as a module. Recent Linux kernels strictly enfo=
rce module descriptions, and omitting it results in a modpost warning (`WAR=
NING: modpost: missing MODULE_DESCRIPTION() in kernel/trace/trace_events_te=
st.o`). In automated CI environments that enforce zero warnings or build wi=
th `-Werror`, this will cause build failures.
--

--- Patch [5]: [PATCH RFC 5/7] tracing: Add a test for ftrace_parse_event_s=
tring() ---
commit 509c596a834391e59b26327382138635d44f58c9
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

tracing: Add a test for ftrace_parse_event_string()

This commit adds a KUnit test for the ftrace_parse_event_string() function
to prevent regressions as the parsing logic is updated.

> diff --git a/kernel/trace/trace_events_test.c b/kernel/trace/trace_events=
_test.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/trace/trace_events_test.c

[ ... ]

> +static struct kunit_suite trace_events_test_suite =3D {
> +	.name =3D "trace-events",
> +	.test_cases =3D trace_events_test_cases,
> +};
> +kunit_test_suite(trace_events_test_suite);
> +
> +
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

[Severity: Low]
Since CONFIG_EVENT_TRACING_TEST is a tristate config and this can be compil=
ed
as a module, should a MODULE_DESCRIPTION() be added here?

Recent kernels emit a modpost warning (WARNING: modpost: missing
MODULE_DESCRIPTION() in kernel/trace/trace_events_test.o) when this is
omitted, which could cause build failures in automated CI environments that
enforce zero warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-tracing-cl=
i-event-filter-v1-0-57c4e8029c86@linutronix.de?part=3D5
