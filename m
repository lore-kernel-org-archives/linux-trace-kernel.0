Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E73C4165
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281868; cv=none; b=Aka+eLm1Ibj6QgpORoHtIAN076XyMAMeakGYb1YldaVVAxnQrlyFbw5qlM9xY1M8wdWNC7/33+N1dcGrgVXDPtsmuue8NdQYO95XE1ymG/jDxBg9ebhu3fJ6QleEVlanGZUE5V+wvwMj4mhyEZz59n5bkNkheZOITK8NxgwoKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281868; c=relaxed/simple;
	bh=SsWPnf1nIrvfBsPmbxE0xctDX9sVhjJ3cyjhQxkaVZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kk2lz22pxWOohy/Vd/g92XFxQXwr9/ZBchBvBZwxeVbL3Rcq4vx1XZh5/ZQvA5YtZJalRoGQJze3lk+uVjtzbk1I3Z+EvZppUMmBCGYcHa8c6VRiUS9smxPpdBKQoX6l1W08i+YXEN3R1m65k32EpY4ee9qjlaQkP/EhxyNXOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo0nO42a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo0nO42a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF31F00893;
	Sun, 13 Sep 2026 06:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789281854;
	bh=TQcIiIV+KaYhSze/r/DbhJbAM8PRX1kR9G/9MCwIqG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qo0nO42al3AE//UUZ7D+E2LpsZUzTyHq2HseURxiPSLUvPwgacD9uRi++FSEa5SQ1
	 eDIHibeVb1wI8Tq/Sc8mwvx8nds4aiIKcYXDkhG2HkTJ+qA7j9RVf52QqkurlbkCYF
	 zv8Tn/xoBZX1+hPR8zAowcm3RE2EUheBBrAuSSFOw+G33SH1Lobmus8XhjyDjWQipX
	 oFmXxL9U9QOyA2wmeQdMhHEuBttkTVWu0Q5GF5gpq53BY65WXm5/6Io6pMURl9w5Dy
	 LmQygdhpzwjccsaGGIn75bd3Eot9WkY9L0u+moqNOcZZQiWAcgc8Z0D/jAYLZb1duT
	 6hTd00zDQsqhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] blktrace: fix the field offsets of the synthesized
 v1 record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913063155.708520-1-donggeunyoo.kernel@gmail.com>
References: <20260913063155.708520-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 06:44:13 +0000
Message-Id: <20260913064414.01DF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer underflow in the `pdu_len` bounds check allows out-of-boun=
ds read and kernel memory disclosure when processing 48-byte v1 blktrace ev=
ents.
--

commit 1abcf72f1e975080a981a6233d954f5dd76e431f
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

blktrace: fix the field offsets of the synthesized v1 record

This commit corrects the field offsets when synthesizing a v1 blk_io_trace
from a v2 ring buffer entry. It assigns each v1 field from its v2 counterpa=
rt
and attempts to bound the appended PDU by the entry size.

Link: https://lore.kernel.org/all/20260903202932.156278-1-adrianox@gmail.co=
m/

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99e..da14e213dbcfe 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1768,17 +1768,24 @@ static enum print_line_t blk_trace_event_print(st=
ruct trace_iterator *iter,
> =20
>  static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
>  {
> +	const struct blk_io_trace2 *t =3D te_blk_io_trace(iter->ent);
>  	struct trace_seq *s =3D &iter->seq;
[ ... ]
>  	struct blk_io_trace old =3D {
>  		.magic	  =3D BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
>  		.time     =3D iter->ts,
> +		.sector   =3D t->sector,
> +		.bytes    =3D t->bytes,
> +		.action   =3D lower_32_bits(t->action),
> +		.pid      =3D t->pid,
> +		.device   =3D t->device,
> +		.cpu      =3D t->cpu,
> +		.error    =3D t->error,
> +		.pdu_len  =3D min_t(size_t, t->pdu_len,
> +				  iter->ent_size - sizeof(*t)),

[Severity: High]
Does this subtraction underflow when processing a 48-byte v1 blktrace event?

If iter->ent_size is 48, and sizeof(*t) is 64 (the size of struct
blk_io_trace2), the subtraction results in -16. Because min_t is casting
this negative value to size_t, it evaluates to a massive unsigned value.

While an unbounded out-of-bounds read existed in the baseline, this patch
attempts to bound the pdu_len but introduces an integer underflow instead.
This causes the bounds check to be completely bypassed, leaving the
vulnerability unresolved.

>  	};
> =20
> -	trace_seq_putmem(s, &old, offset);
> -	trace_seq_putmem(s, &t->sector,
> -			 sizeof(old) - offset + t->pdu_len);
> +	trace_seq_putmem(s, &old, sizeof(old));
> +	trace_seq_putmem(s, t + 1, old.pdu_len);

[Severity: High]
Because the bounds check above can underflow, does this trace_seq_putmem()
call perform an out-of-bounds read?

If the length is unvalidated due to the size_t cast of a negative number,
this will copy arbitrary adjacent kernel memory into the user-visible
trace sequence. This can potentially lead to information disclosure or a
kernel panic if the read crosses an unmapped page boundary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913063155.7085=
20-1-donggeunyoo.kernel@gmail.com?part=3D1
