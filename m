Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792430671;
	b=D16z1NzyNZvVfUcpnn3MONJEga9l6DcEqMJtn8ir8QT5rgjM8WyqjsSvLnGdITh9cJJC
	 eMX5lwjUZR2q9S7Gy7Mse8D0MDi+9CVYO7Jjp9nobnQOImLzEbbuxnIptfFzBTeJl1zhS
	 N/squL3wbc4Wis3YNm+8aS+8jh8NoNZhoZyeZq5uZhuFLXo6R/FMSuEYcRH0gICec5XtJ
	 QbWe+tgTT9ZJSkMGq+CB0QNB6HdBaTEFsk9XawxqAUTn9ZZ/EEnTIEfGo/DX+sMriCOY5
	 V6DknFh0RJEyFNec2vZ8sCM3ia9Py+9HqLk8tBEiuxXxYHA7dHgnA18IGZouLURXuvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v94IzSlD8GtecAHwnUus+qXwzP2P3DMytwGnQox52CE=;
	b=ApDwI0QP3eogGBi88k43WH3QZ6IWDHui5dz5NXTlkW0CsCL1eCW3GYtfCheIXXSk5wZS
	 0AYCBNBgBK3uRLjV03CE5bZ9anlfsiWi8TPFQN1QhIcdrkEh8Y2JjKBizaMfcBrAKRzbP
	 ZbQqoonumubZl59PtAdTbc/k6KcqpFtmEYb0wYwzIDOFhhZuNK1WzPunIkdRuLuiojxPr
	 oNxbf/45Dl1vLZZO3d3xrqDmheN2jhMX340WKc7rXvmiKoOHB4NvReuSS6PJvzlKS6f5m
	 /uVk4XB3a9sc1DNMOJbfYj5QD8m3qT4Ait4zK7gEJPIpoJuUYLBaf2n3EhWKI1Nr5dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q7QUxSOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525A606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 17:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C525A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q7QUxSOG
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6790844c9b0so1673643d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 10:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792430670; cv=none;
        d=google.com; s=arc-20260327;
        b=Xi/coiavaXA2o6h2Irt6VAtA+6hyBFI8FNooPkS8KwN58apJEj0cWE2w8v/hLBL6Nq
         XETGCnoXwVwt7Xs1KykMM3c90b/N3pPWd6fanxOT0IWRR36MIFAHxamJzNUD5sAsLfhN
         zbYvNDieygY7OzXWFt1hpFmKL2gU1yITQ/L4RB7bKyo//o1lcNKhL9yxny6fqg6g4Xaz
         LIjgXlLS99zrZCmmN1oNnbPfv2rEd66w16q//B/Dm4x2SpoGwy2OQaDcWxjdj7aIZL6H
         z1dtkQ83SWVgMERCbmNtl/miSp+MSe8q8vMfV6L9lnHNwA+aZDEHcF5L6Vm2abp5lf9u
         CC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v94IzSlD8GtecAHwnUus+qXwzP2P3DMytwGnQox52CE=;
        fh=/oeE/2ovOneV12bWZ3BgBcP29W+EC1wI1xtb08+2Hhk=;
        b=Kc1nlQ+hwhBz5VKlpGnRY1WuQSWo945RayzUVWQunWmBLCKswwjDkHVsimPnDkHzmQ
         5CqDzZcJiAxOXEUwsBfJ9t9mohvi4trX63NXEIQAfBnDfpjojKQvCt46ErmteryyVcId
         a8h2++dslJmOa819A3+G7Pp//U90MupJGVMe7XL9h1DCmeCFssCDsFjCf8BxNM3vf1Uh
         ZgyrovHBgAlkfDPIrB72g9+DLwcSpNRrwE8u+yem7Kz9h3D/VFOFEkFeRCUfLAVi5bzY
         AADv1RO4l0XQEYdqqBze1t15aGZhrKFYeyQUUyS5GVZbx8AP8SjFFOtDLJvrZ7ycOPCp
         Jzww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430670; x=1793035470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v94IzSlD8GtecAHwnUus+qXwzP2P3DMytwGnQox52CE=;
        b=q7QUxSOGk3KIF+Y6kBslawVtumMNsC4pSF5LlDTN+V7wpDO7X1mj5JfqcXPG0hsUA7
         htPG3egyEVa8LufE1Gx8YNN0faCBN72X9mdCdE7d+tJQOBk48D8w4KZEcFRZrPc4e2Oi
         FBah7xNi52jzD59CbdW8BcG8MxNAj/shn8rNs9NIYnQqUomyFTGqIwuKG8mit6lw1xru
         gm1m8+Z3YmXBwpS3iaFE8aWCb9Ssq9M3JiaGMlxJCzfHGyQpgwLTrTyfL6JV886s8W2Z
         au0+W21aMCqWW9VL+TeoTFPa4XuG3tOMtIUlp0MppSJtTCRnBYw7ad+tJvbcn2D4/4vw
         QnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430670; x=1793035470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v94IzSlD8GtecAHwnUus+qXwzP2P3DMytwGnQox52CE=;
        b=rvEv37ub0ykWt3xdahv56jtYdh3KJtzDToWH6qnqI9c+4uUIKZMh0ZdtikirM6ARwp
         hqdorhcUmWWNEL6b9JibKyeM7c75Qwrc46HPAy+dmOyn/FXldmdF4bZx2iJE5emX7PGR
         erxTb3olMDsG0MkLJ3OHIsdplkSJOZLi5Z3rAc9Uj9KDRaY1BNOZq7sb2gp2kQUOMDJv
         dPXRirOAP7Yg69n0nVIl6QB41nGrCaY5UpMwM00Xx4BnQz/EJBeUGjeUoqnWrN9qAImN
         WRnDObiEYhAhFX3FI6W4Pd8ODFOBkyKDCmhVk4XpaNQzB2SjduYt/O+2EjXCk+bqudBi
         i7MQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9iyoGk7ZlafmI9QKjPmmA79+2zjmnNXpidFRuQvdZbsKfTbTKHbU4HWpM33WX5cNrTav5LLcvwWQjjVifHwAZSOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIska9xh4WBeqV5fgW2tl2dQRm8nzYKfygKMI9BN3xNM19h6hfp
	Sc0psa/dZZdOAxkn1YR4KxaTYMbO56wRM7vol+x179xai3x/jSTKmK3e3JuRVpJMDVbwfWqDhxb
	24du1FDX5Eyie6Gnk0dEiBO3TUdASXYw=
X-Gm-Gg: AYBFou2gxr4pSDgA8yyhyZVIVz0gJ9z81Q2aLDhjqT/Z2ul3yhgTEgKNCJ42Tv1QnaL
	v4lS2N2Gn5gJaV1oe5iqVtdmKhJCcqN23vg95uFK7YYcxB+7jUEqI1g1A8TofUnvzY8o762kkzb
	fYyW/fiXxVpKqbU5UD+uw1Ha65tbZfMO2Dpfx0SXPvV3mVfNYNFCYXpXbHxO9BjzNnBov9jXS3I
	sJs7RSP2lGLC7HLgL0Rc1aXArBEJ/+Kx+DuBwIgrIgmATd91sAJdYkdhvlIn9lJt1GAt+cE0Mb8
	uR2IfoMr3WQvk3TFmKnuE+zrvgo+LFbyM6EV5enxFfrUGoXpzCuBkP4ChF1elQlD+Q==
X-Received: by 2002:a05:690e:d58:b0:676:863f:8ed2 with SMTP id
 956f58d0204a3-679ca83508fmr2653476d50.58.1792430669722; Mon, 19 Oct 2026
 10:24:29 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com> <20261019100029.32a09f71@gandalf.local.home>
In-Reply-To: <20261019100029.32a09f71@gandalf.local.home>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Mon, 19 Oct 2026 19:24:17 +0200
X-Gm-Features: AclHuK_oGHvZP8ZsUmOuB3mE6AE11B0H-Atozg5trQ0bWx9omrbaU2HKmEywW-o
Message-ID: <CALsPMBOKENath9-6pUoPrrSRbuudg0V9tc76bLcxsnkQJJkvgQ@mail.gmail.com>
Subject: Re: [PATCH v6] riscv: mm: Trace TLB flush requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 18 Oct 2026 13:14:59 +0200
> Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
>
> >  arch/riscv/include/asm/riscv_tlb.h | 103 +++++++++++++++++++++++++++++=
++++++++
> >  arch/riscv/mm/tlbflush.c           |  45 ++++++++++++++--
> >  2 files changed, 144 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/riscv_tlb.h b/arch/riscv/include/as=
m/riscv_tlb.h
> > new file mode 100644
> > index 000000000000..4d5f48112941
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/riscv_tlb.h
>
> Normal convention would be to have "trace" in the name. riscv_trace.h ?
>
> As riscv_tlb.h looks to be specific about tlb and not tracing.
>
> -- Steve
>

Hi Steve,

Thanks for the suggestion.

I've renamed the header to arch/riscv/include/asm/tlb_trace.h
in v7. I prefer this over riscv_trace.h because the latter
sounds too generic for a header dedicated to TLB tracing.

Did you have a broader use in mind, such as including other
RISC-V tracepoints in this header?

If you still prefer riscv_trace.h, I'm happy to reconsider.

The updated patch is available here:

https://lore.kernel.org/linux-riscv/20261019-tlb_tracepoint-v7-1-4cc3e99d38=
7a@gmail.com/

>
> > @@ -0,0 +1,103 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM riscv_tlb
> > +
> > +#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_RISCV_TLB_H
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/perf_event.h>
> > +
> > +#ifndef _TRACE_RISCV_TLB_ENUMS
> > +#define _TRACE_RISCV_TLB_ENUMS
> > +
> > +enum riscv_tlb_flush_scope {
> > +     RISCV_TLB_FLUSH_SCOPE_SINGLE,
> > +     RISCV_TLB_FLUSH_SCOPE_RANGE,
> > +     RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> > +     RISCV_TLB_FLUSH_SCOPE_ALL,
> > +};
> > +
> > +#endif /* _TRACE_RISCV_TLB_ENUMS */
> > +
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> > +
> > +#define show_riscv_tlb_flush_scope(scope) \
> > +     __print_symbolic(scope, \
> > +             { RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" },=
 \
> > +             { RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> > +
> > +/*
> > + * Record the invalidation request received by the RISC-V architecture=
 code
> > + *
> > + * The target CPU mask represents the CPUs Linux intends to cover for =
the
> > + * request. It can be correlated with per-CPU activity, but does not d=
escribe
> > + * which harts ultimately performed an invalidation.
> > + *
> > + * The ASID is hardware-visible and may be reused. It must not be trea=
ted as a
> > + * persistent identifier for an mm.
> > + *
> > + * The stride describes the invalidation granularity supplied to the R=
ISC-V
> > + * implementation.
> > + *
> > + * The event records the invalidation request before it is dispatched.=
 It does
> > + * not describe the mechanism used to execute the request.
> > + *
> > + */
> > +TRACE_EVENT(riscv_tlb_flush_request,
> > +         TP_PROTO(unsigned long start, unsigned long size,
> > +                  unsigned long stride, unsigned long asid, bool has_m=
m,
> > +                  const struct cpumask *cmask,
> > +                  enum riscv_tlb_flush_scope scope),
> > +
> > +     TP_ARGS(start, size, stride, asid, has_mm, cmask, scope),
> > +
> > +     TP_STRUCT__entry(__field(unsigned long, start)
> > +             __field(unsigned long, size)
> > +             __field(unsigned long, stride)
> > +             __field(unsigned long, asid)
> > +             __field(bool, has_mm)
> > +             __field(unsigned int, target_mask_weight)
> > +             __cpumask(target_cpus)
> > +             __field(u32, scope)
> > +     ),
> > +
> > +     TP_fast_assign(__entry->start =3D start;
> > +             __entry->size =3D size;
> > +             __entry->stride =3D stride;
> > +             __entry->asid =3D asid;
> > +             __entry->has_mm =3D has_mm;
> > +             __assign_cpumask(target_cpus, cpumask_bits(cmask));
> > +             __entry->target_mask_weight =3D cpumask_weight((const str=
uct cpumask *)
> > +                                                  __get_cpumask(target=
_cpus));
> > +             __entry->scope =3D scope;
> > +     ),
> > +
> > +     TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx has=
_mm=3D%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s",
> > +               __entry->start, __entry->size, __entry->stride,
> > +               __entry->asid, __entry->has_mm,
> > +               __entry->target_mask_weight, __get_cpumask(target_cpus)=
,
> > +               show_riscv_tlb_flush_scope(__entry->scope))
> > +);
> > +



--=20
Kind regards,
Roman 'Hedin' Storozhenko
