Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8F1A5B9E;
	Sun, 19 Jul 2026 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440310; cv=none; b=dNXIKFFLHivbSXr7VP3yrP6IPxjguVoXbpycwuHVIui+P2oHEU4NQN6JvpxqeDh4nUAQTppyRW3WK4D8nIu4ERjfU5K62hIjVBIbCHaWKH92+Y/L9zKYSXYwdW/ITUTjIoOgrxJXkP7p9PE4OZqmLTO06i3XOz4PobiJWonC7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440310; c=relaxed/simple;
	bh=Wh8YPDl4O//a45oi0oi3nXHtKHeFrCwqRXHBMj5Hd9M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JhmrNEekwz+uYIRHUbdQVRNgSp0ClO6dbTSAMoIkQMIhY5SUCUEYTPql57EnMkvAwmOhZKxZtvTD98N2tBBJ0oq4AfxzRPvlMiPfMZ/n68XHMnLwZLOKN7FPZ52jFIbhRMiVKBc7BvyjhjuX+6iTTMl7uBxQn9aJTPrWZ12Uji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9ZueUne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9ZueUne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144311F000E9;
	Sun, 19 Jul 2026 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784440309;
	bh=BaUeI3qNp2QRpOOJEQpyY+Xbckyb97iqqtxaVt1svzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n9ZueUneYX4xhMusRkJGUDPB6+QxxLyPm1giQYPf07Kzu04p+N9LjDasWd0/tOfNB
	 lXeDkClJCu37tIk6F34XbMC3KQkIcw+hrCnuHeTudkfuBcBT311N+DlvSuY0m8wG7I
	 7Lk2qsTzEb2J2NY9ABGF7kxQXQ49yyY7djuPwdsAoIyZANDxmbRoxjdVK1BlOt9jnU
	 xbwJ37iVlmjU6Iq92hahEdtWUyP1jVeekgQj+IoamUVfOnCDdDd2rkZQtWKD2XQNZA
	 ORfCCeEodldqP9IggZHjEJp+OHVJsK6Lt0uNbq37C4Qcl3MZnqI7YJaSKKhQRBR9d2
	 FAKH+1s1omjCQ==
Date: Sun, 19 Jul 2026 14:51:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Will Deacon <will@kernel.org>, Pu Hu <hupu@transsion.com>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>, "ada.coupriediaz@arm.com"
 <ada.coupriediaz@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "davem@davemloft.net" <davem@davemloft.net>,
 Jiazi Li <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
 <naveen@kernel.org>, "yang@os.amperecomputing.com"
 <yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-Id: <20260719145143.78fdbc359174e1180a5646be@kernel.org>
In-Reply-To: <be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
	<20260710063242.228714-3-hupu@transsion.com>
	<aljbf_RmOd9U2KDT@willie-the-truck>
	<0f049d38-b7f6-47f0-a410-95ad2aee7fd4@transsion.com>
	<alj2uxE1M8mcMBhA@willie-the-truck>
	<e0e800f5-a6f8-48ae-b55c-5c3d928bf234@transsion.com>
	<aloLb0j8sg0usmAF@willie-the-truck>
	<be182a18-4cea-445d-a319-1ed3a6c17598@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 11:31:31 +0000
Hongyan Xia <hongyan.xia@transsion.com> wrote:

> On 7/17/2026 7:01 PM, Will Deacon wrote:
> > On Fri, Jul 17, 2026 at 01:51:12AM +0000, Hongyan Xia wrote:
> >> On 7/16/2026 11:20 PM, Will Deacon wrote:
> >>> On Thu, Jul 16, 2026 at 02:38:58PM +0000, Pu Hu wrote:
> >>>> On 7/16/2026 9:24 PM, Will Deacon wrote:
> >>>>> On Fri, Jul 10, 2026 at 06:32:55AM +0000, Pu Hu wrote:
> >>>>>> From: Pu Hu <hupu@transsion.com>
> >>>>>>
> >>>>>> A kprobe can be hit while another kprobe is in KPROBE_HIT_SS state. This
> >>>>>> can happen when tracing or perf code runs from the debug exception path
> >>>>>> while the first kprobe is preparing or executing its out-of-line
> >>>>>> single-step instruction.
> >>>>>
> >>>>> I don't understand this part. The single-step runs with debug exceptions
> >>>>> disabled (kprobes_save_local_irqflag() sets PSTATE.D) so how do we end
> >>>>> up taking one?
> >>>>
> >>>> You are right that the single-step runs with debug exceptions disabled.
> >>>> However, the case I was referring to is not a hardware breakpoint or a
> >>>> software-step exception, but another Breakpoint Instruction exception
> >>>> generated by executing a BRK instruction. A BRK instruction exception is
> >>>> not masked by PSTATE.D, so it can still be taken while handling a kprobe.
> >>>>
> >>>> As far as I understand the architecture, there are two different cases here:
> >>>>
> >>>>      - Breakpoint Instruction exceptions, generated by executing a BRK
> >>>>        instruction.
> >>>>      - Breakpoint exceptions, generated by the debug logic, for example by
> >>>>        programmed breakpoint registers.
> >>>>
> >>>> PSTATE.D masks debug exceptions such as hardware breakpoints,
> >>>> watchpoints and software-step exceptions, but it does not mask
> >>>> Breakpoint Instruction exceptions generated by BRK. This also seems
> >>>> consistent with the pseudocode for BRK,
> >>>> Arch64.SoftwareBreakpoint(imm16), which does not appear to check
> >>>> PSTATE.D before taking the exception.
> >>>>
> >>>> Therefore, even if kprobes_save_local_irqflag() sets PSTATE.D while
> >>>> handling the first kprobe, if the code executed from that path reaches
> >>>> another instruction patched with BRK, it can still take a Breakpoint
> >>>> Instruction exception. In other words, the nested case I mentioned is
> >>>> another kprobe BRK being hit, not a hardware debug exception or a
> >>>> software-step exception.
> >>>
> >>> Yes, that's correct, but if we're doing the out-of-line step, how do we
> >>> end up executing a BRK? Or are you saying that it's the kprobes
> >>> BRK64_OPCODE_KPROBES_SS instruction that we use to implement the
> >>> single-step that is the problem? If so, how does taking that exception
> >>> result in us executing tracing or perf code?
> >>>
> >>> Sorry for all the questions, I just haven't understood what's going on
> >>> here from the commit message.
> >>
> >> The key is that, when you use 'perf --call-graph dwarf' to sample
> >> certain events, kernel perf code will sample a piece of user stack each
> >> time those events are hit, and copy_to/from_user() triggers page faults.
> >> Say you are profiling preempt_enable events:
> >>
> >> 1st BRK -> preempt_disable() -> debug_exception() -> set SS state ->
> >> preempt_enable() -> triggers perf -> perf_sample() -> sample user stack
> >> using copy_to/from_user() -> page fault or 2nd BRK on the page fault path.
> >>
> >> The key is perf sampling the user stack while the 1st BRK is still
> >> running. When a page fault is hit, a can of worms is released, including
> >> a possible 2nd BRK.
> > 
> > Thanks. So perf is run synchronously from the debug exception entry path,
> 
> Yes, exactly.
> 
> > rather than because of a second exception taking place. Got it. But then
> > it sounds like we should really make the debug exception handling path (at
> > least, the part that runs for handling the kprobe step) noinstr to avoid
> > getting into this state to begin with. Is that practical?
> 
> Not sure about making the whole path noinstr (@Masami might have a 
> better opinion on this than me). Personally I don't mind either 
> disallowing it or making it correct.

Yeah I agree with making it noinstr. 

> 
> But it might be a good idea not to diverge too much between ISAs. This 
> patch is pretty much mirroring what the x86 side handles this situation.

I don't mind modifying how it is handled in each architecture, since
this part is too much depending on the ISA.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
