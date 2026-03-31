Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A0441021;
	Tue, 31 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979841; cv=none; b=BjvaZOM9N/A2CGhnVp6hPtAa4UbsMeWpFsT2z7KMNOue4x2h6874aYThc9kGglORl52W7OXV2PX34swOwLJITAPXsKPtOkxMhu/qGwoqBqeGrcN3hh6VjEiJylFCYA2ZvX2i4UhxYBF/CQHpHd8unFmySh8hhmUSY5VwmZbft7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979841; c=relaxed/simple;
	bh=E0eqte9sjXykp49wOweERJ+dgMceii7XBpHW2hEwIkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpNxGEfhWgNRcdSnZ2y/9BzvoPWhjC/C5sRPBfuSHV2tFH9FA1XNF9B2L3F/XRVxMs8c8HCpXU//YV193L3dDrNTtU97FLXv48aLEmKBKPWfQN0kpCwj6xD6cjWt9LObU7PTn4BZc+HBWTLllerSSmGjETqJv2dv8Cc4mPYqycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dQMS81yQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dQMS81yQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9667D22FC;
	Tue, 31 Mar 2026 10:57:12 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F853F915;
	Tue, 31 Mar 2026 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774979838; bh=E0eqte9sjXykp49wOweERJ+dgMceii7XBpHW2hEwIkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQMS81yQYo4mabe0D3goibtdFv8nXjVJQdN1tHpWkYWn1NJR8P/ZrDD16y1oPbb+l
	 o4QBWVnGYE4CQzHUrC4beKS/jvI1QuRC6rzaCA1FVa9SLpsicOSWBvcmsOmiqs5r2+
	 NUOPyAvHlF4hz5aiqb59iPTVcjNyY7kUb+REULwU=
Date: Tue, 31 Mar 2026 18:57:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v15 1/5] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-ID: <acwK-Xu-Mon2_6bT@arm.com>
References: <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
 <177494616630.71933.2941681397188791689.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177494616630.71933.2941681397188791689.stgit@mhiramat.tok.corp.google.com>

On Tue, Mar 31, 2026 at 05:36:06PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> On real hardware, panic and machine reboot may not flush hardware cache
> to memory. This means the persistent ring buffer, which relies on a
> coherent state of memory, may not have its events written to the buffer
> and they may be lost. Moreover, there may be inconsistency with the
> counters which are used for validation of the integrity of the
> persistent ring buffer which may cause all data to be discarded.
> 
> To avoid this issue, stop recording of the ring buffer on panic and
> flush the cache of the ring buffer's memory.
> 
> Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[...]
> diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
> new file mode 100644
> index 000000000000..62316c406888
> --- /dev/null
> +++ b/arch/arm64/include/asm/ring_buffer.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_ARM64_RING_BUFFER_H
> +#define _ASM_ARM64_RING_BUFFER_H
> +
> +#include <asm/cacheflush.h>
> +
> +/* Flush D-cache on persistent ring buffer */
> +#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
> +
> +#endif /* _ASM_ARM64_RING_BUFFER_H */

Adding Robin as he wrote the pmem support for arm64.

I assume the ring buffer here is cacheable memory, otherwise we'd also
need a dmb(osh) as in arch_wb_cache_pmem(). If that's correct:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
