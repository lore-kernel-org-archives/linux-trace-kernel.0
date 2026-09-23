Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE993ABD96
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161820; cv=none; b=IB1JPg1AZhLHeU4autUfWItQYZ/rK70cgW1kqraxjeQnaSMOhdaVs+fPtUkcNsDcH2ukM9Z8eRHLCvtmM0NNhVBJVIQR2H4q5Uld/+VisHMBk62RibToS7riDJNEdJ1/lZah/L9gFjfZwbZlVcZIDXsf0IQUKNwEwKHcCSe5IxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161820; c=relaxed/simple;
	bh=S/UwauSlZS1TD8xMkcLC23y+R3shEkIv6dk0h/U/Fi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qfYjsyCa1r10/zTRBarUkPsvX4UBpsED8k1uKaUfz50g2rcVicGLOVvur+iIYOBwkff1oLad8/WGwPhh1m03E2Fos/kB5Wqwio/CEloibEnQfHVTghUOqmzNfScdHtGuk+WDl4bIVZzka8Hodd8o6dWUnKOQy897vQcCFCEzrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iscCVr60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iscCVr60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17CD1F000FF;
	Wed, 23 Sep 2026 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790161818;
	bh=4Rtd0PLTUbHOooSKfpmgHqb7H+MyQhGdizSTSS8Vfrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iscCVr60kD6AQD386RO5HOT0LuvAdeDWW7wSLEzvROM4zUZeN+2Ev+Qge+9WFBLiQ
	 ikjvQ5Bg776AeWNHFCFua3MAQX8jZkUcUiJ5sdCgo+T913yzV5Qw6VJwvbh3aihDcr
	 eGg2JV6dD07+c9KQYPFAVLVRNeanIdhF/h7nXVvsQ3YAWXysmTaMlrYClz7s82Z0a3
	 CTbEb2Zfq/I28cu73TAKF9vPv/BGCNAmcK9h0xfnJYvbsOHWAV2KOssx6laW0ZgZi7
	 kWjNWdCKfGfijpRdQfpvVhq3c/mQqlSzE7SnnfMQjxaSuPFSt+1wU93ENs3nRTarct
	 qz4cB0brkuKBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922110955.363677-7-johannes@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
 <20260922110955.363677-7-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:10:17 +0000
Message-Id: <20260923111017.F17CD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing: show_print_fmt() string parsing breaks if value contain=
s ternary operator
--

commit deeb2ac9d2766875d27bd9a2d5d898875d56cc2a
Author: Johannes Berg <johannes.berg@intel.com>
tracing: add __print_sym() to replace __print_symbolic()

This commit introduces __print_sym() to replace the old __print_symbolic(),
making it more memory efficient and allowing dynamic updates. It relies on a
single dynamic list of items processed at the time userspace reads the
print_fmt, avoiding init-time fixups.

> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/s=
tages/stage7_class_define.h
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -45,6 +45,9 @@
>  #define __event_in_softirq()	(REC->common_flags & 0x10)
>  #define __event_in_irq()	(REC->common_flags & 0x18)
> =20
> +#undef __print_sym
> +#define __print_sym(value, symbol_id)	__print_sym(value:symbol_id)

[Severity: Medium]
Does this delimiter choice in the __print_sym() macro in
include/trace/stages/stage7_class_define.h cause issues for arbitrary C
expressions?

This macro transforms the arguments into a string format using a delimiter =
(:)
that is unsafe for arbitrary C expressions if parsed left-to-right. If a
kernel developer uses an expression containing a colon (such as a ternary
operator like a ? b : c) as the value argument, it seems the string
representation will contain multiple colons.

> +
>  /*
>   * The below is not executed in the kernel. It is only what is
>   * displayed in the print format for userspace to parse.

[ ... ]

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2109,6 +2109,102 @@ static void *f_next(struct seq_file *m, void *v, =
loff_t *pos)
[ ... ]
> +static void show_print_fmt(struct seq_file *m, struct trace_event_call *=
call)
> +{
[ ... ]
> +		if (in_print_sym && *ptr =3D=3D ':') {
> +			const char *name;
> +
> +			ptr++;
> +			name =3D ptr;
> +			/* skip the name */
> +			while (*ptr && *ptr !=3D ')')
> +				ptr++;

[Severity: Medium]
Will this parser in show_print_fmt() in kernel/trace/trace_events.c break
if the value expression contains a ternary operator?

It appears this logic naively splits at the first colon, destroying valid C
expressions like ternary operators that natively contain a colon. If a
tracepoint passes a ternary operator to __print_sym(), the parser incorrect=
ly
assumes the first ':' encountered uniquely separates the value expression f=
rom
the symbol ID.

This would cause tracing tools to fail parsing the exported print_fmt, brea=
king
event decoding for userspace.

Could a backward search for ':' from the closing parenthesis safely isolate
the symbol ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922110955.3636=
77-6-johannes@sipsolutions.net?part=3D1
