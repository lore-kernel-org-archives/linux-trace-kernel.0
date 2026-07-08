Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86543637A;
	Wed,  8 Jul 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519982; cv=none; b=QvwVSrStL+5KMXEQ86M0gXhdgzRv+hwZCbzXtbNDRn/Pnmtog5g+H+hzT3YCxPq8nCXWa3wKRXToCy24RohNJbZZHwAZjT7D3+iQOOCq7qW2FM3mohDQjednPcLYMRRN4tLReAAmdcZJ5AzVyJZqApGpA6XO2ax3jFUxCMONqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519982; c=relaxed/simple;
	bh=n596vK3umJZUl5Tq/5Xl7XjsQkE1SFapr/epqDkntQs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tr2+6yXeYuUBo1rZnrWcbbsgElyrq5sHXyfnOS1qOBXV8hqOGLJuppOwQEMm/VEFyB9A6px6i10tnqatIBFgdAPX3oWRoTUWZ5h7IT1mL7bPBBlN+sTmJo8rf8WUjLhTAFF0WNLxvRFimz4PcyiQUXrWqKfWaG4lIjVpeB2TwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LURa7VZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LURa7VZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A51F000E9;
	Wed,  8 Jul 2026 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519980;
	bh=DoDbn2USP7rhV4t6L+eml08WCJvJ3oAL0lApnhJ84Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LURa7VZD2J7mM+oWfn8gDUQhA8YEbMA3yGnJsR2SzmPa4o2NGjVSNkNcEdH3zaiia
	 bDw3ICsi9UD1I01KUr6EmwGJ1BwiesNT5wzR2Hzszl0p/v3ACYhZlNsnowUpPLcDkT
	 TRx7iWSW7YZ08PBqtZpehbvIruqAGQfkOIXsPqtawlUkjrR3p9CUrhj69qS8W3TrD1
	 BXZ4+8UTz4Mz2jHsUq/ThUki4yrH0mDW5FobotZZ7CkMilWn+HukbG1akPoZXg3rkW
	 mfpeHKTP64mGmLNvSFdkrXEWoJrZbad6veXU+sPfrnTCmkgxQsu6Yo6v4co3TpVUtR
	 zC22/06T0N0DA==
Date: Wed, 8 Jul 2026 23:12:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Pu Hu <hupu@transsion.com>, "ada.coupriediaz@arm.com"
 <ada.coupriediaz@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "davem@davemloft.net" <davem@davemloft.net>,
 Jiazi Li <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
 <naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-Id: <20260708231255.4162b7acfdb4a703aa076a33@kernel.org>
In-Reply-To: <68189403-9728-4938-8ee2-924e4702eab7@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
	<20260706083636.159883-1-hupu@transsion.com>
	<20260706083636.159883-3-hupu@transsion.com>
	<20260708095400.7582bc9589fd9da925aa9c1d@kernel.org>
	<68189403-9728-4938-8ee2-924e4702eab7@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 07:12:39 +0000
Hongyan Xia <hongyan.xia@transsion.com> wrote:

> On 7/8/2026 8:54 AM, Masami Hiramatsu wrote:
> > On Mon, 6 Jul 2026 08:36:49 +0000
> > Pu Hu <hupu@transsion.com> wrote:
> >
> >> From: Pu Hu <hupu@transsion.com>
> >>
> >> A kprobe can be hit while another kprobe is in KPROBE_HIT_SS state. This
> >> can happen when tracing or perf code runs from the debug exception path
> >> while the first kprobe is preparing or executing its out-of-line
> >> single-step instruction.
> >>
> >> Currently arm64 treats a kprobe hit in KPROBE_HIT_SS as unrecoverable,
> >> the same as a hit in KPROBE_REENTER. This is too strict. A hit in
> >> KPROBE_HIT_SS is still a one-level reentry and can be handled by saving
> >> the current kprobe state and setting up single-step for the new probe,
> >> just like reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.
> >>
> >> The truly unrecoverable case is hitting another kprobe while already in
> >> KPROBE_REENTER, because the reentry save area has already been consumed.
> >>
> >> Move KPROBE_HIT_SS to the recoverable reentry cases and leave
> >> KPROBE_REENTER as the unrecoverable nested reentry case.
> >>
> >> This mirrors the x86 fix in commit 6a5022a56ac3
> >> ("kprobes/x86: Allow to handle reentered kprobe on single-stepping").
> >
> > Can you also check the Sashiko comment?
> >
> > https://sashiko.dev/#/patchset/20260706083636.159883-1-hupu%40transsion.com?part=2
> >
> > This seems indicating potentially brakage of reenter kprobes on arm64.
> > But is it possible to hit another kprobe while SS on arm64? It is
> > the same question about the previous one, can NMI happens during
> > the single stepping? (maybe yes, because it is non-maskable)
> 
> It is possible as this is what we hit. There are
> preempt_enable/disable() calls during SS which can trigger perf events
> sampling the user stack, which may then trigger page faults and send the
> CPU into one more level of exception context. I believe this is what you
> saw in 6a5022a56ac3?

Ah, it was more generic perf NMI case, not only preempt_enable/disable().
But anyway, the result is same.

> > Anyway, for making it safer, we need to add saved_irqflags to prev_kprobe.
> 
> Yes, this seems to be a legit bug that needs to be fixed. Thank you.

OK, thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
