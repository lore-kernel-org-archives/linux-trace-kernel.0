Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446554;
	b=IghJJvLFcbpGXFBNB9idAsk+PGtkLybuluSb08L5VxDNDR4C0NiA9YU8JQWwbxn7HuAN
	 gRpztZck6Vct/uqXO7HezicEDR5u4BEKcYrgAFvb780kEm51u5uk7GWh75woPXoFRYAnh
	 +YKp4tNQiBAE7NGFFtDKBYs55to+eIQA5wBPIoeF7Rp7CW2AiV5PxKA66o8ALsyyC6WJs
	 RA7219sDBXLGERuEczQI3PzL1qGjTACIj2e+v07zjBb++dtXha2Qi/PH+g9e4oevIb5q9
	 sUS6Ofa3VLY2fRhDtjIzG2+4Ukw2u0l+taPrrHRFKP2CS4s1iUzco/RZ09VZ0kOJ0zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uiuo7ZnY00zP445Je9zLEnYRUY6zzQ21kf+OCKEn2vM=;
	b=UXkbr4opHYSNmy40MJfVY61zs2VgIB30c8WhfUhQuE/k1Aq+vB3nP6iUvWWJ9wd6DzP3
	 X8S9bOYVKTxNqaV4ylDv3lOeI3xy2cF8NlQXCylnhERAVqiiKG8s53xcdIPx/HGhcj0fp
	 2dB0eSTYJ1l6u6WYIIkKARxxaLue3d2tqlpJyyVNyp2BedgJlZ1Z5tUYy1HR2iJ3qrPwz
	 qUmM0OHsDKuik7cv72ppn7e6R8xH3O/Rmy9awDvoOll9PcyqZePRanr/exUV4fWWjDzMv
	 eh/TgcRkh3HiIFS/jz9FwdbjR+PeKDyk3hWjNX6MrzBEglwdLamt4f9x29hB4QiuhVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLOsK9aQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56420606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLOsK9aQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C81F00A06;
	Thu, 12 Nov 2026 01:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446554;
	bh=uiuo7ZnY00zP445Je9zLEnYRUY6zzQ21kf+OCKEn2vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bLOsK9aQx8LqfVLTyunZWulFIGxJ3w1QWqW+XDB70sBjktlFddrxcHeita6oZiieW
	 Q92bfSSWQmw8JQkNFQ7u1FxC1JcUKQnylThl53IjxCVWHP2CokbPpNVwJPGaURz4kN
	 UUWZs0cx2huI8T9QbSi2/03k2lB+z0N7F3mCqc33UGmlwJ1UI7yofhS48qVMHot4qI
	 JRe73QSDL+/2om/96tSFsK+l19ZG6Potfq1xEo/s+jbjmMTPW4Vs625nu3BBPxJXPM
	 eleRLOy+pkHorH95OFJtb0PQl0LKvkbGj7XPGZEjmbOAvUj8J9Xnl+EiYVJqdvP4NN
	 ZJy7x7LaOv1LA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Thu, 12 Nov 2026 10:22:31 +0900
Message-ID: <undine-1794446551468718251-cc1df84c836b0c27@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-204254@kernel.org>
References: <179418408457.227715.1485179201014819821.stgit@devnote2> <179418411197.227715.5577722703946865281.stgit@devnote2> <sashiko-outbox-204254@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 00:45:45 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] tracing/probes: unaligned kflag=0 bitfields fail in
>   get_bitoffset_of_field()
> --
> 
> commit 2e4831ec2095ef67023431da46d322fba9d204db
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
> 
> This commit fixes BTF bitfield offset calculation, selects an unsigned fetch
> type wide enough to cover the bit offset and width, and derives the
> FETCH_OP_MOD_BF shift and basesize parameters from the selected fetch type.
> 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index a880a90642d7c..26e02929f1ffb 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> 
> [ ... ]
> 
> > @@ -653,6 +661,12 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  		/* Add anonymous structure/union offset */
> >  		bitoffs += anon_offs;
> >  
> > +		type = btf_type_skip_modifiers(btf, field->type, NULL);
> > +		if (!type) {
> > +			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > +			return -EINVAL;
> > +		}
> > +
> >  		/* Accumulate the bit-offsets of the dot-connected fields */
> >  		if (btf_type_kflag(container_type)) {
> >  			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
> > @@ -660,12 +674,15 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
> >  		} else {
> >  			bitoffs += field->offset;
> >  			ctx->last_bitsize = 0;
> > -		}
> > +			if (BTF_INFO_KIND(type->info) == BTF_KIND_INT) {
> > +				u32 intdata = btf_type_int(type);
> >  
> > -		type = btf_type_skip_modifiers(btf, field->type, NULL);
> > -		if (!type) {
> > -			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
> > -			return -EINVAL;
> > +				if (BTF_INT_OFFSET(intdata) ||
> > +				    BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size)) {
> > +					bitoffs += BTF_INT_OFFSET(intdata);
> > +					ctx->last_bitsize = BTF_INT_BITS(intdata);
> > +				}
> > +			}
> >  		}
> 
> [Severity: Medium]
> Does this leave ctx->last_bitsize as 0 when a kflag=0 bitfield has a bit
> width matching its underlying integer type size (such as an 8-bit bitfield
> backed by a 1-byte BTF_KIND_INT with BTF_INT_OFFSET(intdata) == 0) at a
> non-byte-aligned member offset (bitoffs % 8 != 0)?

Ah, good catch! Yeah, it might happen.

> 
> When that happens, parse_btf_field() sets a non-zero ctx->last_bitoffs while
> ctx->last_bitsize remains 0.  fetch_type_from_btf_type() then does not widen
> the fetch type to cover the unaligned field across the byte boundary, and
> parse_btf_bitfield() rejects the probe with BAD_BITFIELD (-EINVAL) because
> ctx->last_bitsize == 0 while ctx->last_bitoffs != 0.

Indeed.

> 
> Checking bitoffs % 8 != 0 alongside BTF_INT_OFFSET(intdata) and
> BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size) would record
> ctx->last_bitsize for unaligned byte-sized kflag=0 bitfields as well.

OK, let me add that check.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
