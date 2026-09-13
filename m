Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE02D8370
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269032; cv=none; b=HH0h/6vx5b8qHm+hRWk3RKKZsHJQwcqNz5io5kkkJis6Vo/MwGWLojFbn1OOloTBzbqNL1Qzzig8BcFb0p+EtXD5H1C7QOa2apy/N3Oufor0K0I8PvQpfpmVS6CcOdv6qU6Qp/w7OzJ2MMRhNscLTCUcr+8KlGlBHxg1EOViNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269032; c=relaxed/simple;
	bh=bxce5jt+FgQ9jUz6tT4GatvNg9Mjo55T081ygcMwaoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXD0I2ogp4WnX8SPEeuvtK2PK9+0kHvUkqhkAX1bmaImLAXEjZpQant/HSWVtryu0G9LMJltQL7xsI3/o8u6+9AlyvhtBcDgytKnoqrbVFLRGwCSzX3WEhnXE249k3zoDRgsfX8QDA6xMr+fD+b5pvGItVHD1avHFP2G52SA0Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmVdHmjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmVdHmjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85191F000FF;
	Sun, 13 Sep 2026 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789269031;
	bh=oKRJBqejKfbjyrjz3q88Bv0bawEBvGiV/I2mANvYF0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmVdHmjvienjH3dwNoaujGHyA/HetQSaS1l90kj1KekLa8laHWrqbndIPsKMSR4Wx
	 YJBuoPMPP96de5iEwDVqlI1oZjB574dwUfq3rYCyB0b/dkMMIfDtiIPpkj834UY1kH
	 sHUVsdasD3rspnJcTkExVEnkMjA8k//ytK9kYnyFk1AWYi6vJwkW/hIAKkizm81Jg4
	 kVJHD530Yka9j+IwXQbJst9bqIBnCUFAkac5A5CnYNfeA+h3qPTO0F4zF0D24ScfvB
	 gzdJGTc2YiS9W+GQjCWQ4if5o4MhF9tgZTUGkfK4SOQsDtAvfd3LB7knSZss9ShdC1
	 7rK1xGk21o3Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] blktrace: build the synthesized v1 record from the
 entry's own layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913025827.457116-1-donggeunyoo.kernel@gmail.com>
References: <20260913025827.457116-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:10:30 +0000
Message-Id: <20260913031030.E85191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Size-based differentiation between v1 and v2 events causes v1 en=
tries with a large PDU (>=3D 16 bytes) to be misidentified as v2 entries, s=
crambling output fields and truncating the PDU.
--

commit 7a0e33d5f62e85ae6d055e44b6cd6349ae56c6ba
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

blktrace: build the synthesized v1 record from the entry's own layout

This commit addresses a bug where synthesized v1 blktrace events read from
incorrect offsets when handling a v2 entry. It attempts to fix this by
properly differentiating between v1 and v2 records using the entry's size,
and correctly assigning fields and PDU lengths based on the detected layout.

Closes: https://syzkaller.appspot.com/bug?extid=3Df179b16e13624138b0f1

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99e..455d761ff84e6 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c

[ ... ]

> @@ -1768,17 +1768,47 @@ static enum print_line_t blk_trace_event_print(st=
ruct trace_iterator *iter,
> =20
>  static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
>  {
> +	const struct blk_io_trace2 *t2 =3D te_blk_io_trace(iter->ent);
> +	const struct blk_io_trace *t1 =3D (const struct blk_io_trace *)iter->en=
t;
>  	struct trace_seq *s =3D &iter->seq;
> +	struct blk_io_trace old;
> +	const void *pdu;
> +
> +	if (iter->ent_size >=3D sizeof(*t2)) {

[Severity: Medium]
Will this size-based heuristic incorrectly classify v1 entries with a large
PDU as v2 entries?

If a user configures block tracing via BLKTRACESETUP, it uses v1 records
which have a 48-byte base size. If a BLK_TA_REMAP event is recorded, it
includes a 16-byte PDU (struct blk_io_trace_remap).

The total size of this event is exactly 64 bytes. Since
sizeof(struct blk_io_trace2) is also 64 bytes, iter->ent_size >=3D sizeof(*=
t2)
evaluates to true (64 >=3D 64), and the v2 branch is taken.

Does this result in the output being scrambled because fields like action,
pid, device, and cpu are read from incorrect offsets, and the PDU being
truncated because the calculated length clamps to 0?

> +		old =3D (struct blk_io_trace) {
> +			.sector   =3D t2->sector,
> +			.bytes    =3D t2->bytes,
> +			.action   =3D lower_32_bits(t2->action),
> +			.pid      =3D t2->pid,
> +			.device   =3D t2->device,
> +			.cpu      =3D t2->cpu,
> +			.error    =3D t2->error,
> +			.pdu_len  =3D min_t(size_t, t2->pdu_len,
> +					  iter->ent_size - sizeof(*t2)),
> +		};
> +		pdu =3D t2 + 1;
> +	} else if (iter->ent_size >=3D sizeof(*t1)) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913025827.4571=
16-1-donggeunyoo.kernel@gmail.com?part=3D1
