Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3F48B373;
	Wed,  1 Jul 2026 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913433; cv=none; b=PnIuln6syry6wLryELjDtInQixHB9pKRzWmGuGQ2jQXnDjWKKXHbw2TdNZEjkif0L3GbkGjdrc2aknxh/IbKDTHbF8OiGDDyRJ3Dhz3eYMvJRuujvej3yA5+AdvrQ1Ou2xdW5sISK+hcphnJTJRwta6Lw90+qATc6D1BGza0PZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913433; c=relaxed/simple;
	bh=/30Yj7H1FHQfhfxQYcPsMvuuvw+xOIFAm0C0qPD8LoI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hXHrPa1H0Azg5ojOvUvGYE6VDP2dAXRf3GTpD8wKyaYkKeGVK/Fb+uIszOFpD2hGHNccedFhVbtEmHUeVAoRsKVU3O1zYGGSR8UV+kxyCH0GTp4Oe1bKoauB16agpM+KN4O9dHtVpXaAKSCgyVinclSXyqbYFTm2MlS9oQtqqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGzX4siZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGzX4siZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243751F000E9;
	Wed,  1 Jul 2026 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913430;
	bh=VNkJszifhKgsSezlW4/esiesLs+zqM8RUBr857pL8GQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cGzX4siZIUtycMFZon6aJ5LtvjxT4GuGWBSlVT6YvDkXUNhV7BCSoRUh1lM9JGuyJ
	 NH/5heNyhlZxohPM59DtftljlXMIjldWm63pLzus+N5EELFUX56g32OubETdTRrZE0
	 DkN9xIurQjq/ZL6GGetl2EmfsYRNo3U2onslufiZqHX29g5IAMwnffjpe17IZSHVje
	 1PiutciaCW5qrJ9dESiK8MvaY98lfhM6GrynLEhYAE5X79tdkncuvoxsrJpxwjIdcy
	 c3LjT/APSyohfFhXpO0dGySUtl3RyP5u5s5wromgRzImY8YitQX3VwxB3uGb++T4i5
	 zl/vqzmZTTo8Q==
Date: Wed, 1 Jul 2026 22:43:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pu Hu <hupu@transsion.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
 <will@kernel.org>, "naveen@kernel.org" <naveen@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "yang@os.amperecomputing.com"
 <yang@os.amperecomputing.com>, Hongyan Xia <hongyan.xia@transsion.com>,
 Jiazi Li <jiazi.li@transsion.com>, "ada.coupriediaz@arm.com"
 <ada.coupriediaz@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] arm64: kprobes: Fix single-step fault and reentry
 handling
Message-Id: <20260701224345.c3a215ece3660a0cbae67645@kernel.org>
In-Reply-To: <20260701121448.3926-1-hupu@transsion.com>
References: <20260701121448.3926-1-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 12:14:54 +0000
Pu Hu <hupu@transsion.com> wrote:

> From: hupu <hupu@transsion.com>
> 
> This series fixes two arm64 kprobes issues observed when running
> simpleperf with preemptirq tracepoints and dwarf callchains while a
> kprobe is active on a frequently executed kernel function.
> 
> The crash happens in the kprobe debug exception path. While a kprobe is
> preparing or executing its XOL single-step instruction, perf/trace code
> can run in the same window. That code may either take a fault of its own
> or hit another kprobe.
> 
> Patch 1 makes kprobe_fault_handler() handle a fault in
> KPROBE_HIT_SS/KPROBE_REENTER only when the faulting PC points at the
> current kprobe's XOL instruction. Otherwise the fault is left to the
> normal fault handling path.
> 
> Patch 2 allows a kprobe hit in KPROBE_HIT_SS to be handled as a
> recoverable one-level reentry. Only a hit while already in
> KPROBE_REENTER remains unrecoverable.
> 
> This follows the same logic as the existing x86 fixes:
>   6381c24cd6d5 ("kprobes/x86: Fix page-fault handling logic")
>   6a5022a56ac3 ("kprobes/x86: Allow to handle reentered kprobe on single-stepping")

Good catch!! 
The series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

But it should be reviewed by arm64 maintainers too.

BTW, if you are "Pu Hu", the Signed-off-by tag should be
"Pu Hu <...>" instead of "hupu <...>".

Thank you,

> 
> Reproducer:
> 
>   simpleperf record -p <pid> -f 10000 \
>     -e preemptirq:preempt_disable \
>     -e preemptirq:preempt_enable \
>     --duration 9 --call-graph dwarf \
>     -o /data/local/tmp/perf.data
> 
> Before this series, the crash reproduced frequently. With both patches
> applied, it was no longer reproduced in our testing.
> 
> hupu (2):
>   arm64: kprobes: Do not handle non-XOL faults as kprobe faults
>   arm64: kprobes: Allow reentering kprobes while single-stepping
> 
>  arch/arm64/kernel/probes/kprobes.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
