Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655A39A04D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290803; cv=none; b=Qa+f6vTOBk4ceALbj1XHm93qZm2t0/OqeQCsXLwuKDhcHVVec8ErWj3GyQbj8+GT7CRZCSxz+OBr4/KLmwCcfEkyx4siQT9sJC0tpAmhUmJ9qvrn2TkvwfO/5FZUv/Ycuay1Ee29BKx42ZCult0eewn8SljHSRmM/aILhmuJCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290803; c=relaxed/simple;
	bh=LyM7dLrBYjjJkmfTo43Jd8Tpzu6Z/4VzbLgukbW+9OE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N397CenF7AWRURb2gdDfqTqOcODQAa0AeGC7iwCsFj15QA0xms5HtYmXQwWBNjeg4j/D+7yfzMe6jDPqcv1DnZMAhWvAlj7k09rOwfa/Tg009G59dRI/JMUGIt1ixnp7fN1v8sQ8u/i8dbufMzvSz6R1wQTco5L36kk/YKzAaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnGpRDrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnGpRDrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C061F000FF;
	Sun, 13 Sep 2026 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789290801;
	bh=MjCgd4Gmh+u6DGXnp3R9Dm/j40PvaWzhFwlFffw+Skg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TnGpRDrXqLVDhPcBeXOb4Evuc3A83RLHLOyHgocpf7gcMu43JcgDYAZ3fc7n4ZgNX
	 DgPT8HYXA0aRisYWUgCYjTWkgUArW9uSWO8aD42Rg9GL6schCfnxFv0tycFuTq1Vcw
	 nzNks4noQOGTTJBMAW2bjx8x05Fvnr4M/yWUO1NoFfb+OCBi5SrIZ98q/A/d6fK6s6
	 AfBP05Gfo8KEK3bX888artOURLmI0ii4d4Y5rEmXwZH9PL4A+E9Tk0jji79hARMbxp
	 sC/G4EpowRaHHh6u8O0NK/Mcafjei8M3idEszoLKPM+i5BgENuIMH2yRHDnGlCGllj
	 r3TpK3u6RVLDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] blktrace: fix the field offsets of the synthesized
 v1 record
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913090232.715798-1-donggeunyoo.kernel@gmail.com>
References: <20260913090232.715798-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 09:13:21 +0000
Message-Id: <20260913091321.B3C061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] blk_trace_synthesize_old_trace unconditionally parses ring buffer =
entries as 64-byte blk_io_trace2 structures, resulting in an out-of-bounds =
read and info leak when processing 48-byte v1 entries because the required =
dependency patch is missing.
--

commit d247914d4d21399a0ee1cb2876aa1eda1b802a86
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

blktrace: fix the field offsets of the synthesized v1 record

This commit fixes the field offsets of the synthesized v1 record in
blk_trace_synthesize_old_trace(). It assigns each v1 field from its v2
counterpart and appends the pdu from the end of the v2 record to prevent
reading garbage data.

Link: https://lore.kernel.org/all/20260903202932.156278-1-adrianox@gmail.co=
m/

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99e..99c00cdae42b4 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1768,17 +1768,23 @@ static enum print_line_t blk_trace_event_print(st=
ruct trace_iterator *iter,
> =20
>  static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
>  {
> +	const struct blk_io_trace2 *t =3D te_blk_io_trace(iter->ent);
>  	struct trace_seq *s =3D &iter->seq;

[ ... ]

> +		.pdu_len  =3D t->pdu_len,
>  	};
> =20
> -	trace_seq_putmem(s, &old, offset);
> -	trace_seq_putmem(s, &t->sector,
> -			 sizeof(old) - offset + t->pdu_len);
> +	trace_seq_putmem(s, &old, sizeof(old));
> +	trace_seq_putmem(s, t + 1, old.pdu_len);

[Severity: High]
Does unconditionally parsing ring buffer entries as 64-byte blk_io_trace2
structures result in an out-of-bounds read and info leak?

If a user configures blktrace via the setup ioctl (which sets
bt->version =3D 1) enabling the block ftrace plugin, __blk_add_trace()
still allocates and writes 48-byte struct blk_io_trace events because
the required dependency patch is missing:

kernel/trace/blktrace.c:__blk_add_trace() {
    ...
    case 1:
        trace_len =3D sizeof(struct blk_io_trace);
        break;
    ...
}

When blk_trace_synthesize_old_trace() casts a 48-byte entry to a 64-byte
struct blk_io_trace2, reading t->pdu_len accesses offset 50 (which is out
of bounds and retrieves garbage). Then calling trace_seq_putmem()
starting at t + 1 reads from offset 64 (16 bytes out of bounds) for
old.pdu_len bytes.

If the random length pdu_len read from the out-of-bounds offset is large,
it copies up to 64KB of adjacent kernel memory from the ring buffer to
userspace, and crosses page boundaries which can trigger a kernel panic if
kasan is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913090232.7157=
98-1-donggeunyoo.kernel@gmail.com?part=3D1
