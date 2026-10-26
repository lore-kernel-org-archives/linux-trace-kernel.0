Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005668;
	b=LZ5XEUVrxHG8+N4/HQ3o+4FYziajYjgNtjXr6TCLA25WgkCsxz2DEpD7VznYkoGFCjSO
	 AEdASHxEuUdsaOV1SEec2WwV+apE1dNI0O4dVg8d7DQSmep1GGGEuQWh5KgHK519rYFQW
	 xe2PsawvqoZ+RPDPGI8Kzcrrjc+cRPciecoPx+GcA3PWHSWngdhQervbkV0kSF/DsOuch
	 tdpyoz108pIOxMf5A5k40YMt5X4wJXnVSJryMVQA8neBM4Y/pKhJ0xHkJ95Uu24bD9ndB
	 SWgz3KPO2KOS1fM4UfWeiw0EVGzM9p5UITw5FsK/+ir6h4W9VLnusmwyVZWOW3l75Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OaWdtGcgHCZDA7pcotcIA3ZUaeEYGXetKO7q4HM6HBw=;
	b=MpWBBffXlqB5xGZY37lmr01fJK309EIaxDWQX+HtJQU8v7CePE5/aaRyPI3Od2cpshC2
	 kYJ4bSJ6HAE7iofednOmWbb/6iVy5IOXKLDjCKZ1J70WgYQwgL3s5WD3X61oaUOSslbQ1
	 x5KfJbGX1x3pBdnQX5tIDSMc7Jn50Hm7ofq5XRIBlVyvR9VtAEDc/u1dll8Tx0tJfPZnb
	 sdeNfudICXKF7HPsbsZU1ljcksbdpyvEiDh0rWEIlnKI+6KtVxm2pK9uRSogJQvn+2ae/
	 4EDL1mXV3rTVOOetHhI+OPqm7GiyIi8+MdvHdkR5mbon6EgtfPGxsL96IiFP9BXzXPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKJtAVVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70B606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKJtAVVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19F11F01825;
	Mon, 26 Oct 2026 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005668;
	bh=OaWdtGcgHCZDA7pcotcIA3ZUaeEYGXetKO7q4HM6HBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KKJtAVVTOqVzvNNCihcmAkTJGyTUKlZfYobliQUEL0aSXhiR0wEVGReynp6iyRcPL
	 sTf4y6uSZOe/2Yj0MgoUbOECtt3UWIy1dURwnsIYurxP4aRMOM9KDqjiye694Cfc9n
	 2KN9IGIguE3ql6eDsY+idf9TzLCo/KvO57qAnUtcNrITrCAhrzAuL8U5aV70iZ5z85
	 L+VF8r2MtbKLWSyaXF/02x/f+qamRKPcJYcMekZgK18C2nDhfeYFvN/JA9K53lMUjT
	 LECfIw7RBmO4EPEV/2c9vgHJTomdieAEavetInZpPlO9Tytg3DxysPzccCATK5yHmX
	 LHHYpyj1TnxfQ==
Message-ID: <sashiko-outbox-184735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Reject filter expressions that end on an
 operator
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9uZ0h5dWsgS2ltIChNYWxIeXVrKQ==?= <malhyuk97@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026042540.2478566-1-malhyuk97@gmail.com>
References: <20261026042540.2478566-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:07:47 +0000
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
- [Medium] tracing: unreachable operator check in predicate_parse()
--

commit 6ada36f117f4b8f90eaf23b50ed6bf590c01cc94
Author: JongHyuk Kim (MalHyuk) <malhyuk97@gmail.com>

tracing: Reject filter expressions that end on an operator

This commit adds a check in predicate_parse() to reject event filter
expressions where a pending PROCESS_AND or PROCESS_OR flag remains on the
operator stack after parsing completes.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 5e74d2dae40a3..744e70668940f 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -611,6 +611,13 @@ predicate_parse(const char *str, int nr_parens, int =
nr_preds,
>  		goto out_free;
>  	}
> =20
> +	if (*top & (PROCESS_AND | PROCESS_OR)) {
> +		/* Expression ends on an operator */
> +		ret =3D -EINVAL;
> +		parse_error(pe, FILT_ERR_INVALID_OP, ptr - str);
> +		goto out_free;
> +	}

[Severity: Medium]
Can this check ever be reached with PROCESS_AND or PROCESS_OR set in *top?

In kernel/trace/trace_events_filter.c:predicate_parse(), PROCESS_AND and
PROCESS_OR are only set inside the inner loop after at least one predicate
has been parsed (N >=3D 1), and setting either flag immediately breaks out =
to
the outer while (*ptr) loop:

	if (*top & PROCESS_AND) {
		update_preds(prog, N - 1, invert);
		*top &=3D ~PROCESS_AND;
	}
	if (*next =3D=3D '&') {
		*top |=3D PROCESS_AND;
		break;
	}
	if (*top & PROCESS_OR) {
		update_preds(prog, N - 1, !invert);
		*top &=3D ~PROCESS_OR;
	}
	if (*next =3D=3D '|') {
		*top |=3D PROCESS_OR;
		break;
	}
	if (!*next)
		goto out;

If an expression ends on "&&" or "||" (such as
"common_pid=3D=3D1||common_pid=3D=3D1&&"), the outer while (*ptr) loop term=
inates and
hits the check added by commit 1fdc4164e488 ("tracing: Reject incomplete ev=
ent
filter expressions") right above the out label:

	/* Only the inner loop can complete a non-empty expression. */
	if (N) {
		ret =3D -EINVAL;
		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
		goto out_free;
	}
 out:

Because N >=3D 1 whenever PROCESS_AND or PROCESS_OR is set, falling out of =
the
outer loop always takes that goto out_free path before reaching out.

The only other way to reach out is via if (!*next) goto out inside the inner
loop, which only runs after both PROCESS_AND and PROCESS_OR have just been
cleared from *top in the same iteration.

Doesn't that make this new check (and FILT_ERR_INVALID_OP) unreachable dead
code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026042540.2478=
566-1-malhyuk97@gmail.com?part=3D1
