Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60060440620
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163892; cv=none; b=M+M6VWTegd0UHPsi2rxjyJg2BKnNoETDb/j8NLaMJM+HmmQdg7Cw0uCDZv8GuNuTJ08EOwGw7+yh8c4FzzhSjf20MFN1VHdsZ+W6+yKIS1ZYZmbq3BAQydi0NouNmJ57e/JYen0JaZjnXa9y7QjGoenGoH4lyjFyEM7w3ZHwYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163892; c=relaxed/simple;
	bh=7N9jsImI3FyBNbhieyy0LR69731lB/JLE3R/Aqf7qLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LWi0Dkr2bRrbWG1go5EuehOL7TVCvpfHljeroekFyJXPNz1nIfWaB4lRZHO8kKvJ74G41Iq5k9x/PQWFCyvjugZPMbd4UfqvWYywt38dOTWy8SIiaCFt289zCnEc5oUo6JyVEnjzgCJg+cIVsw+GvGAz4PxtNdUaZFH2HOnmaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6GC1DXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6GC1DXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FD1F00A3A;
	Wed, 19 Aug 2026 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163891;
	bh=ToY1gD9JwNMy9zdoPrZIYeNqkddqChvQZriNV0fp5y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6GC1DXr1LAn0QA8UUxeVqozrE4l1MKcqWIzo9vE13TM0w0nPZLTY6IS8xXPyvx/r
	 o2SNxQe7pG5OLSrihW1WwA131bmw3tlJtTHcUX/2dOAJWVB9QBSK1Go3iV5KxqgxES
	 8nsEPD9kEKK0fILLAiyXO3IChmfY9Vz7uLMoSw6r1ANp0t576Omh6UkHaOWLoTm9uN
	 VSfqmqMwWUmFSDUhl/xcbqQsv3TokNtEinG9LVgsiCAM1BPPOpD9Lc/cnTiHJRhajK
	 Ndfj1runUnSvt1R7d1jk0f6HCfkAHdm8K/SbWaKIkYCBsbE4RX1CwU/pgMWxAMBUsf
	 4v5iTcZcJb2Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] rv: Add KUnit tests for the tlob monitor
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <31b0f05cbbb4859b510e247687e467bf2096b4f6.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <31b0f05cbbb4859b510e247687e467bf2096b4f6.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:24:50 +0000
Message-Id: <20260819182450.DF8FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing prototype declaration warning (-Wmissing-prototypes) when C=
ONFIG_KUNIT is enabled but CONFIG_TLOB_KUNIT_TEST is disabled.
--

--- Patch [7]: [PATCH v5 7/9] rv: Add KUnit tests for the tlob monitor ---
commit c187567361217a017982494c7c6e1a3021a25452
Author: Wen Yang <wen.yang@linux.dev>

rv: Add KUnit tests for the tlob monitor

This commit adds a KUnit test suite for the tlob monitor's uprobe-line
parsers. It modifies tlob_parse_uprobe_line and tlob_parse_remove_line
to be visible and exported when testing is enabled.

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monit=
ors/tlob/tlob.c
> index 99acd34726f10..e109390ba3ada 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.c
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -874,7 +874,7 @@ static ssize_t tlob_monitor_read(struct file *file,
>   * PATH may contain ':'; the last ':' separates path from offset.
>   * Returns 0, -EINVAL, or -ERANGE.
>   */
> -static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
>  					    char **path_out,
>  					    loff_t *start_out, loff_t *stop_out)

[ ... ]

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h b/kernel/trace/rv/monit=
ors/tlob/tlob.h
> index 94e7382c2130b..6ad9d5179ab60 100644
> --- a/kernel/trace/rv/monitors/tlob/tlob.h
> +++ b/kernel/trace/rv/monitors/tlob/tlob.h
> @@ -146,4 +146,10 @@ static const struct automaton_tlob automaton_tlob =
=3D {
>  /* Upper budget bound (1 hour): keeps the u64 ns accumulators far from o=
verflow. */
>  #define TLOB_MAX_THRESHOLD_NS	3600000000000ULL
> =20
> +#if IS_ENABLED(CONFIG_TLOB_KUNIT_TEST)
> +int tlob_parse_uprobe_line(char *buf, u64 *thr_out, char **path_out,
> +			   loff_t *start_out, loff_t *stop_out);
> +int tlob_parse_remove_line(char *buf, char **path_out, loff_t *start_out=
);
> +#endif /* CONFIG_TLOB_KUNIT_TEST */

[Severity: Low]
Will this cause a missing-prototypes build warning when CONFIG_KUNIT is
enabled but CONFIG_TLOB_KUNIT_TEST is disabled?

In tlob.c, VISIBLE_IF_KUNIT drops the static keyword whenever CONFIG_KUNIT
is enabled, making the functions global.

However, the prototype declarations here in tlob.h are strictly gated
behind CONFIG_TLOB_KUNIT_TEST.

If a kernel is built with CONFIG_KUNIT=3Dy but CONFIG_TLOB_KUNIT_TEST=3Dn, =
the
functions become global without a visible prototype, which will trigger
-Wmissing-prototypes build errors. Should this IS_ENABLED() check use
CONFIG_KUNIT instead to match the visibility macro?

> +
>  #endif /* _RV_TLOB_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D7
