Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931600;
	b=EAv1LkfdG9vBMW8VqIXI9ewODyjDtPyPSJ/D/jQOvKeno3wY1QCjWCgwOHy/snRn+iq1
	 GhRdHdvRKm59GJ2Jh1XC+DaMb3DQ/9TYrX9dyT95UA4/WbKAwhbl7SjitVL1v44XkDYmC
	 XbbVjejbIfv/MTB3TblO1ZIwEcVGEhngCgD4C4ULCyGCiKBQYEFxIE354GiLhZ8MXUpey
	 i6h+X7wC58wo3UBn83yiIizjp6SaBVzLBauOrdee96AC2HbuLWOCZkBAKsdWMFdaXTnj1
	 I7FFRjB1yXJLLxGOSTiHUotyW3kZiVwCV3Y54gRE1pAV+jeuvq4SgEZnuB2Apou1ThQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931600;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hkyEkHW2aSYCAKZGSXcAv5EZGu03B/o1UjQo/SIjPbs=;
	b=IdyAkfFymUz2laYoejfgiaRbbuKSodhc1Lhv0d1GIoBUcHvUIflHvNR9wDUMowIWONm7
	 kvotFKQkgkNKYhKNGAlD3/gm5sNmsqYin6r6BPRxdACpsewW6IrF8uFwdAJbidWyBrSyg
	 ZGKCGKFPAtlUsJwrW1WbC3KBRpJM0ZtOWUdEJWLVqRkzBqOqmjhjZLf29yg6FY0k2z3Am
	 mlJXuAWUs2YQhqOfgi2lCpF4dteKwShWmPTbp6zIqqQl24VyetwBQ8HaVMK6CDzVh+OPY
	 PaazVyf7STuqL5GMjFhJXbi8SW9sLcUHq2BlWcAJg4Qjb3IoFKidO6HK/Om6GMJlNuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCVa3ROx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE5606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCVa3ROx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CE41F0089F;
	Fri,  6 Nov 2026 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931599;
	bh=hkyEkHW2aSYCAKZGSXcAv5EZGu03B/o1UjQo/SIjPbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCVa3ROxO4zstJ0nmYuJ0d2UEpkHLCNYCESwSWrMAYuR0nS1/yDJFhcS/aTvwvULk
	 U/hUZVYhxa4nRzZcwAXury6zU0OLU579uR5TbfBLRsr8WSe3hjOl4+MJ1abDaY8nhM
	 Nv4hcNlFafhUYEPUcUj1u0vptFVKmcf7vQ1yV1my41PDeIDU6GMkTL0d50VnMlOVNj
	 gpxjNi3Rb9kB3DjamSlfRFO57/TzY6Ycsgv//u4lDY1YJUpzue6DkS68qs+hfK7hgk
	 Duh9cXzW6WGSPTCYXSzEou3LCvppo1s/T5tUf4CtDRYw0MjARbn1tVDXrsaWzBNJgo
	 bERh6ol0YryCA==
Message-ID: <sashiko-outbox-200586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: skip boot kprobe setup when no events were
 requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenwen Fu" <wenwfu@qti.qualcomm.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106021457.2648231-1-wenwfu@qti.qualcomm.com>
References: <20261106021457.2648231-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:19:58 +0000
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
- [Medium] tracing: redundant unreachable check in setup_boot_kprobe_events=
()
--

commit 2a160557ebac2d0dc5d93db740f4d45dcc8bd5e9
Author: Wenwen Fu <wenwfu@qti.qualcomm.com>

tracing: skip boot kprobe setup when no events were requested

This commit adds an early return to setup_boot_kprobe_events() when
kprobe_boot_events_buf is empty to avoid acquiring event_mutex in
enable_boot_kprobe_events() when no boot kprobe events were requested.

> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e41a7c113646b..6e0fff6b4d91f 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -2017,6 +2017,9 @@ static __init void setup_boot_kprobe_events(void)
>  	char *p, *cmd =3D kprobe_boot_events_buf;
>  	int ret;
> =20
> +	if (!kprobe_boot_events_buf[0])
> +		return;

[Severity: Medium]
Can this branch in setup_boot_kprobe_events() ever be reached?

In kernel/trace/trace_kprobe.c, init_kprobe_trace() is the sole caller of
setup_boot_kprobe_events(), and it already returns early when
kprobe_boot_events_buf[0] is NUL:

static __init int init_kprobe_trace(void)
{
	...
	/* If no 'kprobe_event=3D' cmd is provided, return directly. */
	if (kprobe_boot_events_buf[0] =3D=3D '\0')
		return 0;

	setup_boot_kprobe_events();

	return 0;
}

Furthermore, enable_boot_kprobe_events() also already checks
trace_kprobe_list_empty() before acquiring event_mutex:

static __init void enable_boot_kprobe_events(void)
{
	...
	if (trace_kprobe_list_empty())
		return;

	guard(mutex)(&event_mutex);
	...
}

Was the check in init_kprobe_trace() meant to be moved into
setup_boot_kprobe_events(), or is this patch redundant with existing checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106021457.2648=
231-1-wenwfu@qti.qualcomm.com?part=3D1
