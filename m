Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EDD470116
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322415; cv=pass; b=I7W3HorqAiZtY+yKr6Dp/nTvGobwYQy/FAxPGiTE+N3LRsf/VGtaLyusjKOSLhCORCwCtW5rbgdl7/uGy+QM1xTyGn08gar5HFih2SLSu71aYRJFfWlPn5E+tJfnqoOcM4RdeIIgpxPPdXJL/EQYUbwbY6gxufDhck49SVx22Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322415; c=relaxed/simple;
	bh=irHCKQB2z1bHsMMxcKDg5V1DWLYT5ZU7L/md5rZRalg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIBxR1OjLI0Al1bc7/nbWp+3x0wouG1vDFlsTSSDT9TT4yNdbY03KnjbKiftuw/etLXxg0+Blab+4diW7QiRd/VLF+FPBPHHiwW4mdWWqSF54gZBdGo8lHe9WJSLKjH4FJPdrHZkMhv8E2D0A0lDRpAvXl/a5s8SxTHw++MFNo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3qg7HwN; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3qg7HwN"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-679334baa1fso1128115d50.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 04:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792322412; cv=none;
        d=google.com; s=arc-20260327;
        b=X9TawiWYjvq1zRrxbja1XJlryFTW17biOAI5BjMfe14WOQ4LzzN8aThTtnZp3EEYGR
         N48REaYzgReer9ttL4w90upKCsZkZel9/1hEfXZKDxIyJ1HhhgOoaTXf5mxAfwZPg/gR
         tDuFjBfL5pHk9rwlTXte/zP/mNyheZzO5WrHjOTGZTAXbpFBc/3A/ceNxglFEovutDh3
         J6/whkQb7sXns/hEKtb2VqSdB1IEJws5ToN4ivjScy1VFcqLxxQudOQiPQ6H4AnpNeMs
         mOkWi3W4neDsmRbAtvYWFNzOJkPWRSoJ5imQa5fCgfiGSG/8S6NbkEZn/FdhX++X/G6A
         4x1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5OqN8DzqFMYzYYkeWocgxlurDbJNlZedK8z3G8qJMo=;
        fh=bzS4lM/aJPXUVVzM7ZXP2ar0QUo2xn/bvWtI5toWN9Y=;
        b=b/zi5a36sxUmuCy0Qo3bacpBqMQ53wJYyYfUHW/GdwnaNQdhPOdgXFgYTVQKkObk9P
         MY/2uMtdvTnma5ikBJw4vuzmDpFhAWGjv30iX05lnLxeuliCDYYyXbt5Bz+sJpSdHrIX
         NncKr3KO5rOgfwA+b2279hWYyPuCMU2ltUD8wKJn3kqs38nOF/OtTdcxLTA1oEendPiw
         P/i9Nt0m+l0xn3PAIeu80yao+3wbYHGORdOabgwskTy7+fXdeuoWH0iOUmzgDhczs+yF
         vMyS2H153RfMMnQAnO406ur69GWfA6NVLABIlQebRbbhVWzKffUZtxFtq/kHS52GB8KK
         Pqzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792322412; x=1792927212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5OqN8DzqFMYzYYkeWocgxlurDbJNlZedK8z3G8qJMo=;
        b=B3qg7HwN3/1qSndQq6ftMNUNGG/xJR4UO39Uqnzvu/XFwJ4wfZHWmrF2C9/4c6uOhI
         R5gqW+rOOInDgyywHaV8gzqvAk6I+KKuKLrBvjD81SLJdxi6o/lrdstX2jDVehWoTi/9
         Vo4HWXNY5Lm+X8eOhduoKblHOTqHQ4DG9UQ4/K+Abes9FJwZ3vnArjvyPVAAaVfvXJmu
         1mU3/JCuGoyWTx7r7c0TzsF6542bd9F7FH/ljBwb6WznRbhSVWobJrUI2pfNfJloTxPO
         Gxb75esg4e41IVGxRPCtv7ct9gBuuxW1zMmImS6OKVNleENkR0beMBZ3D6C7gF4rgmcE
         e8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792322412; x=1792927212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5OqN8DzqFMYzYYkeWocgxlurDbJNlZedK8z3G8qJMo=;
        b=WCAsbUb9knnlout96LL2CNR1XoybNYZWHpJsAR9UkzTaaPoKhDHvghicoZW1C+ZqEr
         MSCV7mDXHTJ/CSmcdcWLpi4tjxUghr2JpUQgtfbImkL+a55AaCzLgbva3HZpddUNNhbi
         5319IvFdD18lzoXx6f9Oo9FH50QaeLYbB7ea8/r5a08W5m64nsB0GIuVY+N+ocmCWZwu
         CXKsLzcZVmMSLVs6kPPD1NcwjllLk969wfV2xyGgtRwcmg4hiROPq5JZ/OeVXAiNO9in
         VDmYsrkyPiJZ1XRjYLI7T5gDBgLv0MeMB1s0MU4B8tb4He4rURnC5nUMuXvLQkBlmtmq
         9jbA==
X-Gm-Message-State: AFq9FYIsybQ82h1yrlI9IXGA4P4LIauCq9WrotiSQ1r4P3EGzJcsEKD5
	b0AsUBssm3XHpJPpk8ThAHW6cNZmfpjEyfZTBRc8vzDkLZwpbh8znxZrkMZweUJf217oLr3jk1O
	fflldKDrnc5brUPc9wsGNeIjOSIwilp2+M/lE
X-Gm-Gg: AYBFou22TAR/71LIpexUBfHM+7qc06w7ru6zXkrDrSWV2DK1qlRrK5LL9z+PtTagyKx
	mLRP6Ozg9XjLdcwQXrDI/KvbDr7VCHRNQev1u4j6uCrs9BQZ1mhVJ4/TOq2zTTNs6f+SxHaXfwp
	pcvZuwES5ETDzdT08cFQXHklaifdxD8f2c7g3DZqxQwe4oT+XGyWa3Q4Q2TjEAYgHxe6+dIu8NH
	BsCm0rWzEHJ+aHVSVF8HSXINIF1jBgGaRBoTmRqtyPI0zY0cmkSyKFzRGXUUyGJH/rWjU9m1LIG
	KoGSYr1Y+OlMrw/1EoMrNylJf1ECs3TEGVU76R22JAhCC1mqeUmsK/I=
X-Received: by 2002:a05:690e:d50:b0:679:ab13:553a with SMTP id
 956f58d0204a3-679ca57396cmr771420d50.19.1792322412470; Sun, 18 Oct 2026
 04:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017-tlb_tracepoint-v5-1-256fb5393a7f@gmail.com> <sashiko-outbox-175536@kernel.org>
In-Reply-To: <sashiko-outbox-175536@kernel.org>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 18 Oct 2026 13:20:01 +0200
X-Gm-Features: AclHuK_93C-1wMX6QkhfFIP9wqslv3ZvZJFJ8JZmaBMm3GHpWQbN2VeyMLuuGvA
Message-ID: <CALsPMBM7GcOhQG+nNsE+hSsi63FY+Ywr7U2znhYsM+kmJAAurw@mail.gmail.com>
Subject: Re: [PATCH v5] riscv: mm: Trace TLB flush requests
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 4:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] riscv: mm: unaligned cpumask_weight() access in riscv_tlb_flush_=
request
> --
>
> commit d6aa8f46821c6cdff87980399804155c8220831a
> Author: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
>
> riscv: mm: Trace TLB flush requests
>
> This commit adds the riscv_tlb:riscv_tlb_flush_request tracepoint in
> flush_tlb_all() and __flush_tlb_range() to record TLB invalidation
> requests along with range, stride, ASID, target CPU mask, and derived
> invalidation scope.
>
> > diff --git a/arch/riscv/include/asm/riscv_tlb.h b/arch/riscv/include/as=
m/riscv_tlb.h
> > new file mode 100644
> > index 0000000000000..2c438f6bc0d42
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/riscv_tlb.h
> > @@ -0,0 +1,103 @@
>
> [ ... ]
>
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
> > +             __field(u8, scope)
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
>
> [Severity: High]
> Does casting __get_cpumask(target_cpus) to const struct cpumask * and
> passing it to cpumask_weight() perform unaligned unsigned long loads?
>
> In DECLARE_EVENT_CLASS() in include/trace/trace_events.h, char __data[]
> immediately follows the fields declared in TP_STRUCT__entry():
>
>     struct trace_event_raw_##name {
>         struct trace_entry  ent;
>         tstruct
>         char                __data[];
>     };
>
> Because __field(u8, scope) is placed at the end of TP_STRUCT__entry(),
> offsetof(struct trace_event_raw_riscv_tlb_flush_request, __data) is 53 on
> RV64 (and 37 on RV32). In include/trace/stages/stage5_get_offsets.h,
> __dynamic_array() places target_cpus at __data_size +
> offsetof(typeof(*entry), __data) without aligning the offset to
> sizeof(unsigned long). (Even without the trailing u8 field, the offset on
> RV64 would be 52, and ring_buffer_event_data() only guarantees 4-byte
> alignment rather than 8-byte alignment.)
>
> When riscv_tlb_flush_request is enabled and triggered via flush_tlb_all()
> or __flush_tlb_range(), TP_fast_assign() copies cmask into that unaligned
> offset with memcpy() and then calls:
>
>     cpumask_weight((const struct cpumask *)__get_cpumask(target_cpus))
>       -> bitmap_weight(cpumask_bits(srcp), small_cpumask_bits)
>
> which dereferences const unsigned long * from an odd byte address. In
> addition to triggering UBSAN alignment warnings under
> CONFIG_UBSAN_ALIGNMENT, on RISC-V systems without hardware unaligned
> access support this raises a misaligned load trap on every tracepoint hit
> (and during TP_printk() formatting via trace_print_bitmask_seq()), causin=
g
> a kernel oops in do_trap_misaligned() if handle_scalar_misaligned_load()
> is disabled (CONFIG_RISCV_SCALAR_MISALIGNED=3Dn or unaligned_enabled=3D0)=
.
>
> [ ... ]

I've posted v6 with an additional fix for
the alignment of the dynamically stored CPU mask.

The trace event definition remains under
arch/riscv/include/asm/riscv_tlb.h, as in v5.

The updated patch is available here:
https://lore.kernel.org/linux-riscv/20261018-tlb_tracepoint-v6-1-1447642787=
0f@gmail.com/T/#u

>
> > +     TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx has=
_mm=3D%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s",
> > +               __entry->start, __entry->size, __entry->stride,
> > +               __entry->asid, __entry->has_mm,
> > +               __entry->target_mask_weight, __get_cpumask(target_cpus)=
,
> > +               show_riscv_tlb_flush_scope(__entry->scope))
> > +);
>
> [ ... ]
>
> > --
> > 2.47.3
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-tlb_trac=
epoint-v5-1-256fb5393a7f@gmail.com?part=3D1



--=20
Kind regards,
Roman 'Hedin' Storozhenko
