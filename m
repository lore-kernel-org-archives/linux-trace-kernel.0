Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80912393DEF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245835; cv=none; b=HYt102OadQx3dPsA1CcjFkn3v+auastfOjZT3kPDYsZeW8rCAJncJPvcZjgOqR4PwK9dWKLxPzmdsM7SVdHCRnrvE2uHRm8KSNr1i/pPkqc4oor1wa3uNF7cywXgOql0k5zpujfmKFzLoryL4z4MUZylAr8ztcIrlRCvE7BZRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245835; c=relaxed/simple;
	bh=1LMyCXm0SPQV0RaDE03dQA20Onw3vgmmTpVglQ1gawM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BIZ98sI/w5zdsOf4XrLf9+hSnpqzDS2YjxXF1i3xzN0Ta3uWPCD9Ai5Ghj5TQEjljwEyaBDt4HPPWvzUy/y3HjzxcbNyIeFM13HwzA3JLiJ2i3XIvf4GlIkBFbDj9ikM4iu/j1RGeb/rvRvH1JfEekcokIyaYb/PSDRaPRbdpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og9DPxx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og9DPxx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA721F000C4;
	Sat, 17 Oct 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792245834;
	bh=OECF/QxcClH1E7VxqH2g0amOV3Me7/iMIA48PKP6etM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=og9DPxx9Ox/rnsQ66pavgjxEOzWR6L9VbMn4efhZfhENvV4hRv5fCdIA8cwooVmE+
	 b5XbxsOcbUqpUxXon8SbPTX3NE1DEAU8XbvOm7thDFLutuB7uA1+TjXFuzwyq5HLe0
	 kOuU7O65oFdXbS+jo7OQxtOz0bAQO+Ft2gxz5FZlKSmTRpcbT6gBJjfMN2hBGOSib4
	 bHTgJ8JxmvwxMq7YTe0D5s88rv/i6Djmtf74ZL8/o7SSDWd1xe81px6sOO6uBJv9Mz
	 zBE0uIKglFuqeWaA2JCcBnpYtDGB46zct5AlhHrEJKRsK91Qw4fWsK5fuMJvGPqvTV
	 oE6ENcvxyXq4g==
Message-ID: <sashiko-outbox-175536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] riscv: mm: Trace TLB flush requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9tYW4gJ0hlZGluJyBTdG9yb3poZW5rbw==?= <romeusmeister@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261017-tlb_tracepoint-v5-1-256fb5393a7f@gmail.com>
References: <20261017-tlb_tracepoint-v5-1-256fb5393a7f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:03:53 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] riscv: mm: unaligned cpumask_weight() access in riscv_tlb_flush_re=
quest
--

commit d6aa8f46821c6cdff87980399804155c8220831a
Author: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>

riscv: mm: Trace TLB flush requests

This commit adds the riscv_tlb:riscv_tlb_flush_request tracepoint in
flush_tlb_all() and __flush_tlb_range() to record TLB invalidation
requests along with range, stride, ASID, target CPU mask, and derived
invalidation scope.

> diff --git a/arch/riscv/include/asm/riscv_tlb.h b/arch/riscv/include/asm/=
riscv_tlb.h
> new file mode 100644
> index 0000000000000..2c438f6bc0d42
> --- /dev/null
> +++ b/arch/riscv/include/asm/riscv_tlb.h
> @@ -0,0 +1,103 @@

[ ... ]

> +TRACE_EVENT(riscv_tlb_flush_request,
> +	    TP_PROTO(unsigned long start, unsigned long size,
> +		     unsigned long stride, unsigned long asid, bool has_mm,
> +		     const struct cpumask *cmask,
> +		     enum riscv_tlb_flush_scope scope),
> +
> +	TP_ARGS(start, size, stride, asid, has_mm, cmask, scope),
> +
> +	TP_STRUCT__entry(__field(unsigned long, start)
> +		__field(unsigned long, size)
> +		__field(unsigned long, stride)
> +		__field(unsigned long, asid)
> +		__field(bool, has_mm)
> +		__field(unsigned int, target_mask_weight)
> +		__cpumask(target_cpus)
> +		__field(u8, scope)
> +	),
> +
> +	TP_fast_assign(__entry->start =3D start;
> +		__entry->size =3D size;
> +		__entry->stride =3D stride;
> +		__entry->asid =3D asid;
> +		__entry->has_mm =3D has_mm;
> +		__assign_cpumask(target_cpus, cpumask_bits(cmask));
> +		__entry->target_mask_weight =3D cpumask_weight((const struct cpumask *)
> +						     __get_cpumask(target_cpus));
> +		__entry->scope =3D scope;
> +	),

[Severity: High]
Does casting __get_cpumask(target_cpus) to const struct cpumask * and
passing it to cpumask_weight() perform unaligned unsigned long loads?

In DECLARE_EVENT_CLASS() in include/trace/trace_events.h, char __data[]
immediately follows the fields declared in TP_STRUCT__entry():

    struct trace_event_raw_##name {
        struct trace_entry  ent;
        tstruct
        char                __data[];
    };

Because __field(u8, scope) is placed at the end of TP_STRUCT__entry(),
offsetof(struct trace_event_raw_riscv_tlb_flush_request, __data) is 53 on
RV64 (and 37 on RV32). In include/trace/stages/stage5_get_offsets.h,
__dynamic_array() places target_cpus at __data_size +
offsetof(typeof(*entry), __data) without aligning the offset to
sizeof(unsigned long). (Even without the trailing u8 field, the offset on
RV64 would be 52, and ring_buffer_event_data() only guarantees 4-byte
alignment rather than 8-byte alignment.)

When riscv_tlb_flush_request is enabled and triggered via flush_tlb_all()
or __flush_tlb_range(), TP_fast_assign() copies cmask into that unaligned
offset with memcpy() and then calls:

    cpumask_weight((const struct cpumask *)__get_cpumask(target_cpus))
      -> bitmap_weight(cpumask_bits(srcp), small_cpumask_bits)

which dereferences const unsigned long * from an odd byte address. In
addition to triggering UBSAN alignment warnings under
CONFIG_UBSAN_ALIGNMENT, on RISC-V systems without hardware unaligned
access support this raises a misaligned load trap on every tracepoint hit
(and during TP_printk() formatting via trace_print_bitmask_seq()), causing
a kernel oops in do_trap_misaligned() if handle_scalar_misaligned_load()
is disabled (CONFIG_RISCV_SCALAR_MISALIGNED=3Dn or unaligned_enabled=3D0).

[ ... ]

> +	TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx has_mm=3D=
%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s",
> +		  __entry->start, __entry->size, __entry->stride,
> +		  __entry->asid, __entry->has_mm,
> +		  __entry->target_mask_weight, __get_cpumask(target_cpus),
> +		  show_riscv_tlb_flush_scope(__entry->scope))
> +);

[ ... ]

> --=20
> 2.47.3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-tlb_tracep=
oint-v5-1-256fb5393a7f@gmail.com?part=3D1
