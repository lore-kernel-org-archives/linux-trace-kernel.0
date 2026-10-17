Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DB271A94
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245344; cv=pass; b=HkjPvUY6bL20AcjpbcR4bdpYcMMn0ff2uoRqHbm9Rbi2WGkf7fu0IofDk+NBfZlnPcXC1vjrdPZdfffofE7IKcp/EW216FUh9+nYEruHVlAQaK1CR14GEhqWd6Aq4b+DqSeelcdOVTf2ekbPt0+SP4UMK/ayBL3lyemWYyp7CVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245344; c=relaxed/simple;
	bh=zWHX8p90fyI2wrQohQMLz7MxpnAPTt65/a6eQwFYUwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFeG1E6oUKwPkGZtrVfejkMkWEUwF6GrOtOSq2tVBWoE52EcpAeJwqmju0NvfYy7++/2CD9orSBZbJOLkOkz8LkmXMj7BoNYt3CK9zgKnt/shofr6LMWd7nBNDKKAvCzu3xqwGor0O9LmMvPCZvx3NNOxxJv+EuPaft/RiDSx4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edum3t6n; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edum3t6n"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8871ada1a26so4776357b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 06:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792245342; cv=none;
        d=google.com; s=arc-20260327;
        b=VatRWA3JC0EOd39vgcs0xCq0d3jnShNlbMF5/6wkvbDaXuyiXDLOJ8FyUa+WZn12vh
         FG6KfybL3HYkK8hZhYf0x3faJg+BCHsPnhtAXNzEOosGGuKsx9h4zTbQDyZnshiagwT2
         DQ+MioubH7Wax6PCJRCQABKAuP7xliMchfkcKqPorwKNs8Pf2YafShSfmCdrWl9J8lHO
         CnGr3xB000GMWYmeYxjI5mCjhASGKe5V/QBgjXoebhL3w0hzQqcZI54RykSsv30xAgHG
         XEJlQccOkNGCLTTAXZSJfCaco8R12b/y48sUOcrIpMimIfjGTgi9m9BJF1RF3lGvgT6D
         hPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWHX8p90fyI2wrQohQMLz7MxpnAPTt65/a6eQwFYUwc=;
        fh=CrExkpWNJ4zbesxl25BPKd77+5njKLwSPveG08yGqf8=;
        b=KT7eLkaXIyc3tlky+crUNTyMWfxCTg2Lukzgu7IY49qPMZLa1kqJGtEEoxj0/XqxK3
         jqJPq+kT7q7x2D5XS4nDaq619JAp5JZ6W8MhnVVICvHxs8RPINrhJpdIGIUoomoSAbeL
         z7/K4+BOtZXFN3/sBW/fwmZaiC1Mih6yspGgXXn6HZdh621lN69fMZSSkBl2S2OsM46M
         yhDWlnAIum76cNGnWLA/UbXNZwemjuUMxJ0onIrSgqNpMBwMPl65RPB98I1ro+IO3ibc
         D5x0OS2bipNJvzqFFxrGrtJIZ7vCeJaoCYkodDwiG/b0uz+ebNSwzO3/7bvPStpK4cm/
         T6ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245342; x=1792850142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWHX8p90fyI2wrQohQMLz7MxpnAPTt65/a6eQwFYUwc=;
        b=edum3t6nWf0FTl/rcNXoQ4JRQxgECIo2zf3Loklny7CZmnJFerFO7Dup8zXODqlncx
         zYoKe+vdQvoAXXpoG6cchi6dcXxHP0NvXU+WqLyBIrIlwNsoULoxJtiTOiqzitzax+1Z
         RPTM4XuimbtlV1j3W5AcrF3TYaEZABE6aeS9Pn2S5WKBRLmmFGuOmypnrxFbsF9lBZ+M
         Kx9buQorqyWi2sqdIG+tobHYB7lDZ2MlCJvRf42Nqjd8VLtGP5SFg8Jp6WPv7uAx4XBw
         CO/YwBU6ByVcjTlQBKvzewF09RpPlCl9v8TNA/TJkLm4jDhyQQCN+JHRfZdnS4uSD2Ms
         mYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245342; x=1792850142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWHX8p90fyI2wrQohQMLz7MxpnAPTt65/a6eQwFYUwc=;
        b=fwmR6QEGOyHTF2Hro2fIZLH1GnL3g9hcVpgi6BvJXHOBhmhdGTrouY8PThlZBXbeGh
         ZTjNrSJ/d/KVY5a5e7qfET2no2GlPGTIWudaO20c49/5EcFfVJq9AjQEmkEwyBWRG2Lq
         ANBYT9h+RDdP0brhDGj0Wf42RmrBMoRLFZd8Ce6vECQGvUJ32bjO0hjqFPk75wu/Chdx
         xFG7VwIwgce8YqFk9cJZin2hx3zIJiedZTkn2XJu4fOTxNElRFAgueale66M574AoD+I
         lZbw3Alh0m6cP/dhqEkXWmiZ/jexDvg4DVN3N+RhUtz+AKuMGOIJQg/gbg9mIpQkB0hV
         DzaA==
X-Forwarded-Encrypted: i=1; AKwUvBxPIv+SQ7kfdRKcJvABwjNFNAkuprq6632BvihFZx2wHX2FJWyjZIEAPO99lCvnmAs7FWW5+28DZqfkPAp6LRtosKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZrU2TFw1YLgINaOjtm5AU8ei+DRd/R+6uMAdlIbawE0sEqcsK
	qWYre/j6iSlB8DdB6qxh4BgGTIl/WTPbeGajNl9sE5JCl9hVIve/wbY2AFDtQ759qYEk6WbOLOj
	Z51Ca59p4j77ySng9hifpavFXeArEcOg=
X-Gm-Gg: AYBFou2vEoOV6boGG41gvhdSjNpoUP+iXGeatnMesjPfE0se9ZJw3P64HmdIuD8WnHW
	BOFIB1y4sNoRHIutMSk8Exso++YAnuntoJ3ZDmACu6vWLjmwf3OFxDGEsMtUfYotD1IzOk1NeOA
	gw3FY025HT4Ltq60naouE7s/r1pcrCqoMA/FAuAhROHg3XMmFcWyaJ4oAV7ZQ4mcGwUiQUnQlW1
	s8mody2+o4QYFio1JUdJli3xWCvvSvC5H2cscrzZGZtWBH50dZzOtSV4D7095rFmTRy8GC0s5Aj
	h7sewmlyZBitNI4h1kwzfM5o4XPi2PalgI29aN16nShEcdkbf9ioFVg=
X-Received: by 2002:a05:690c:39a:b0:8b0:a8ce:5794 with SMTP id
 00721157ae682-8b0f216360emr9898317b3.26.1792245342432; Sat, 17 Oct 2026
 06:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com> <20261016103630.6e8fbaa5@gandalf.local.home>
In-Reply-To: <20261016103630.6e8fbaa5@gandalf.local.home>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 17 Oct 2026 15:55:31 +0200
X-Gm-Features: AclHuK-2Q3jw5htyblPTbANoT7rDStvHfnCBo-DhiyiYGqRfnGspVuTujsxRsgk
Message-ID: <CALsPMBPnp8W68tFQKCtx=kxce4bUPx=MR_NwarOmKUJgC5_EPA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 30 Aug 2026 16:36:37 +0200
> Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
>
> > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/ri=
scv_tlb.h
>
> Please do not put architecture specific events in include/trace.
>
> They belong in the architecture.
>
> See the example code in samples/trace_events/trace-events-sample.[ch]
> as well as the Makefile there on how to put trace events in directories
> outside of include/trace/
>
> Thanks,
>
> -- Steve
>

Hi Steve,

Thanks for the review.

I've moved the trace event definition to
arch/riscv/include/asm/riscv_tlb.h in v5, following the existing
RISC-V tracepoint convention.

The updated patch is available here:
https://lore.kernel.org/linux-riscv/20261017-tlb_tracepoint-v5-1-256fb5393a=
7f@gmail.com/

Thanks for pointing this out.

--=20
Kind regards,
Roman 'Hedin' Storozhenko
