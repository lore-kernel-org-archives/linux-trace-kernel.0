Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149230;
	b=AYIxLpxxBNnhvV+RZW7chQ4l0DpBdJZrHUb7MQuCAQJiJk2mjBdaxU3Tbp21t+f3fwXS
	 BohW9kVRQ/MeZFj8TrDZfF/kCQq/i4GISoFHmN6dzdzWk7DI/NnN57hTZujb6zQWUPBRd
	 hhpC+aI8BhM1a6xe47rZUtMsGipZacgD2FMHSXFguHV0T3p/FPyJ6ekUjbezFuBh1t9l1
	 y7156xnXVAtrK6/2DqLvLfegqtcg/uTa7e2C+8kVchlHidP+21ryxKXwcGOvhm8STFjky
	 DO3Tn1nOCBjAMtP6Nv5fI4GuJ7u2dYE7CTc1tg9XpV1TM8mXmazpMMEXuyGSgcrTpZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0dQOwYdE5ByoLjcl/jg92NRQrV/xKvRLu+ZqjDeTH+4=;
	b=KooN4xpAZ1JLvgIAYPUl+OFv/Wk3NO2zD2vgwv7fgoBGk79YuHq7gmnkDhk4SJ4xp9Te
	 /bPRhV5CIf5goq05Dhz0M55QWoXUCFRCgxla+ZZJCfRTwSsOkjEaDxaq3WlpPseget9Ri
	 It/k3aaiPIUltMDr3y8MHUDjXk7iqEkKzcHviPWpxMjSckWkx2u1pKkMWmlCxlULQex2q
	 UGH2jkpUixBzDvfAa5KWq7nkwfO9leIWqEFp6snvEmFKv4EHFhDuCl5XjYOCBYoghUEDd
	 zwifbyIbfezgv2mUNFp9P+YQR9xpBk4yIm7ER/LKKe4VKLrPhNz8WOkDpextHUSdFwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxe25K+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A58606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxe25K+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2CE1F01825;
	Wed, 28 Oct 2026 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149229;
	bh=0dQOwYdE5ByoLjcl/jg92NRQrV/xKvRLu+ZqjDeTH+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lxe25K+NL6YWVgW01Y8D3kvArfPzUDhgh4966AVvfZD3gXpOenP1eMkImSo9HhGs4
	 K4ALoniZs/xfByhqh5o5BMyEQppcQeHWE534HRCVKYl/DServJg4lyBTx6sg1InHPx
	 n9yKqnjKi/dZEV+CiRG6tOYnaCsLTQTyPj5vkB/oXBomYIfg5RAeS+XKm3rBQBuWjz
	 iVB1Ax6QkzZVl1SJI+EaSHc+EVrYONdbyqsecjSJgEDISEHdeBY085S/RQyQxF69mw
	 bTRpatWyEP6P0xIEvfhnQpK3lcjf77mUuW/hdeYfAz8FuH6Wx85KpdNpx4LidrUHzM
	 nBN6WIxIE1AlQ==
Message-ID: <sashiko-outbox-187296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] tracing/filters: Check for trailing characters
 after newline in filter string
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179314830681.684037.17927533770192828788.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
 <179314830681.684037.17927533770192828788.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:00:29 +0000
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
- [Medium] tracing/filters: in-place truncation on error in filter_check_ne=
wline()
--

commit 8f43e3c8d713c8d0669d239d3455b033bcd6f4f2
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Check for trailing characters after newline in filter stri=
ng

This commit introduces filter_check_newline() to truncate the filter string
at the first newline and reject inputs that contain non-whitespace
characters after that newline with -EINVAL.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 9d1446464058a..f3c18324b07a8 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2441,6 +2441,31 @@ static int process_system_preds(struct trace_subsy=
stem_dir *dir,
>  	return -ENOMEM;
>  }
> =20
> +/*
> + * Convert the first newline to '\0' and check that the rest of the input
> + * contains no non-whitespace characters.
> + */
> +static int filter_check_newline(char *str)
> +{
> +	char *p;
> +
> +	if (!str)
> +		return 0;
> +
> +	p =3D strchr(str, '\n');
> +	if (!p)
> +		return 0;
> +
> +	*p++ =3D '\0';
> +	while (*p) {
> +		if (!isspace(*p))
> +			return -EINVAL;
> +		p++;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should filter_check_newline() verify that all trailing characters are
whitespace before writing '\0' to str?

Because *p++ =3D '\0' mutates str in-place before the loop checks the remai=
ning
characters, returning -EINVAL leaves str truncated at the newline.

When __ftrace_set_clr_event_nolock() in kernel/trace/trace_events.c iterates
over matching events and passes the same filter buffer to apply_event_filte=
r():

kernel/trace/trace_events.c:__ftrace_set_clr_event_nolock() {
	list_for_each_entry(file, &tr->events, list) {
		...
		if (filter)
			ret =3D apply_event_filter(file, filter);

		if (!filter || !ret)
			ret =3D ftrace_event_enable_disable(file, set);
	}
}

a multi-line filter string with non-whitespace characters after the newline
fails with -EINVAL on the first matching event, but truncates filter in-pla=
ce.
On subsequent matching events in the loop, filter_check_newline() no longer
sees the newline and returns 0, causing the truncated filter to be applied =
and
those events to be enabled.

Similarly, in trace_boot_init_one_event() in kernel/trace/trace_boot.c:

		else if (apply_event_filter(file, buf) < 0)
			pr_err("Failed to apply filter: %s\n", buf);

the error message logs the truncated prefix in buf instead of the full
invalid filter string.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179314820431.684037=
.4147763044424284198.stgit@devnote2?part=3D11
