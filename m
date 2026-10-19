Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4365AAA60;
	Mon, 19 Oct 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418439; cv=none; b=dg5pn++76LtoBbUJegpe/Qk7OcTwomXG7hN7L4Ce7WZxZtOHUD1R7b/H63hA7AlqW+qFBYKhU0X0RuOqiansnWAVduDO3BKfGPdoFCy6Mi+1dLxOQDJ12gGCsgOZH7OT7x350xcO/8wYpyfLgRMstqsEOi5SDA7xcL/MfkTooQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418439; c=relaxed/simple;
	bh=Xo4FhfZNbwxym1bjmFgZ7LZ+RW9Tx7j81RSs3LuLLNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myRmVVvwHf4OY9i8HhxjIMvmN4RFLdvK+DSHgECKU9dLOZXLURgdWuICNWloL+ouH/TRGFwARq6nBle3wwDdNuBXn/RfVtx2eeIU3g8jbYOb6XxjEO3hA+PmC3IYCRzF8hUl4Sssl74E9Crpx7HJZsU0vXrvzycKNFS1PuKuuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Lmos5Y6L; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Lmos5Y6L"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 9A8D3C06E2;
	Mon, 19 Oct 2026 14:00:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 1BDF12002A;
	Mon, 19 Oct 2026 14:00:31 +0000 (UTC)
Date: Mon, 19 Oct 2026 10:00:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jisheng Zhang <jszhang@kernel.org>, Radim
 =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6] riscv: mm: Trace TLB flush requests
Message-ID: <20261019100029.32a09f71@gandalf.local.home>
In-Reply-To: <20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com>
References: <20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: 5pubec4aqzxei7q9mxjg793sodx8jm7i
X-Rspamd-Queue-Id: 1BDF12002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VnpD51C/65R975LMsQUhoJ8R47XCIdcw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Md1Xp/MJ+u1I7kDl4fR3TIwt8o/aEoevQ1DRTkwRLyI=; b=Lmos5Y6LbcqVIaCO52Q6pR6jCozH9zlNwy8tcOGXXj+VDM4qYjbfzZxvM49NJOxGh7Rf9lLrVXMIO4V/HhWZe0G+hgY4q8Gej5s9+cOE2UmTP6mCpR/kPLirAhsOMRcojQjCFM6C+vYVbiewCZxbFUCdF2K0BBupjisqak/SJUk=
X-HE-Tag: 1792418431-549104
X-HE-Meta: U2FsdGVkX18mtt+2O1f2lYb3qyXnPkGWL2mI/DC2Oh+M38uesxjX21DrdnEg3e9Yp7nihGC5HVBeRl8KGlpayigTBaKuiJMoLpxmF3FaLmvzPKBtB4yidzutezNUq77hh8i/RqL7FwLB2NzkcIRsoW2w9niCE2iLK4KI9lkPU3uuw/PH2Z2VyKorykumhJ1oio70Qhz4mVqdf9h7yYW1gHGW51rfLbUMiC7UXlS7dTb6qrGeJuTvQEMmL+UtVzpnhOqbNqep/M+l8s0oenOSxIX00MOy7dUR4GanWqxc+sZ2lo+CCEb1VioSi8byRB0LdVq5HBnuNHP4swOP7sN3vHvFLr0C+sit8ZOdfwcVKmNGmplzw1h9eY43ydwOL6tU

On Sun, 18 Oct 2026 13:14:59 +0200
Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:

>  arch/riscv/include/asm/riscv_tlb.h | 103 +++++++++++++++++++++++++++++++++++++
>  arch/riscv/mm/tlbflush.c           |  45 ++++++++++++++--
>  2 files changed, 144 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/riscv_tlb.h b/arch/riscv/include/asm/riscv_tlb.h
> new file mode 100644
> index 000000000000..4d5f48112941
> --- /dev/null
> +++ b/arch/riscv/include/asm/riscv_tlb.h

Normal convention would be to have "trace" in the name. riscv_trace.h ?

As riscv_tlb.h looks to be specific about tlb and not tracing.

-- Steve


> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM riscv_tlb
> +
> +#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RISCV_TLB_H
> +
> +#include <linux/cpumask.h>
> +#include <linux/tracepoint.h>
> +#include <linux/perf_event.h>
> +
> +#ifndef _TRACE_RISCV_TLB_ENUMS
> +#define _TRACE_RISCV_TLB_ENUMS
> +
> +enum riscv_tlb_flush_scope {
> +	RISCV_TLB_FLUSH_SCOPE_SINGLE,
> +	RISCV_TLB_FLUSH_SCOPE_RANGE,
> +	RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> +	RISCV_TLB_FLUSH_SCOPE_ALL,
> +};
> +
> +#endif /* _TRACE_RISCV_TLB_ENUMS */
> +
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> +
> +#define show_riscv_tlb_flush_scope(scope) \
> +	__print_symbolic(scope, \
> +		{ RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> +
> +/*
> + * Record the invalidation request received by the RISC-V architecture code
> + *
> + * The target CPU mask represents the CPUs Linux intends to cover for the
> + * request. It can be correlated with per-CPU activity, but does not describe
> + * which harts ultimately performed an invalidation.
> + *
> + * The ASID is hardware-visible and may be reused. It must not be treated as a
> + * persistent identifier for an mm.
> + *
> + * The stride describes the invalidation granularity supplied to the RISC-V
> + * implementation.
> + *
> + * The event records the invalidation request before it is dispatched. It does
> + * not describe the mechanism used to execute the request.
> + *
> + */
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
> +		__field(u32, scope)
> +	),
> +
> +	TP_fast_assign(__entry->start = start;
> +		__entry->size = size;
> +		__entry->stride = stride;
> +		__entry->asid = asid;
> +		__entry->has_mm = has_mm;
> +		__assign_cpumask(target_cpus, cpumask_bits(cmask));
> +		__entry->target_mask_weight = cpumask_weight((const struct cpumask *)
> +						     __get_cpumask(target_cpus));
> +		__entry->scope = scope;
> +	),
> +
> +	TP_printk("start=%#lx size=%#lx stride=%#lx asid=%#lx has_mm=%d target_mask_weight=%u target_cpus=%s scope=%s",
> +		  __entry->start, __entry->size, __entry->stride,
> +		  __entry->asid, __entry->has_mm,
> +		  __entry->target_mask_weight, __get_cpumask(target_cpus),
> +		  show_riscv_tlb_flush_scope(__entry->scope))
> +);
> +
