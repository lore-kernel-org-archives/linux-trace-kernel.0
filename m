Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C036FC5;
	Thu,  4 Sep 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947755; cv=none; b=Hcy/tcUqfRAqGECt6q8eP8+ErPvxeBPXm4dZmj1y7MhUD5ly20PZPX/Jyr4sx8uBf+wm241emsHR9ko84qJPIFi2KeN2ailRCbz6rhBmYpncwsSlFu4/LFq1Ic2QR6eGRUXfNo/++sEcM/i9JPLZENPkJBzMrddnm3oiVfWnAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947755; c=relaxed/simple;
	bh=8nAczwppKWkmFx31kmIPa7xy1KYrypF3ToB6n147+gg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=icVdJPnPdb+dZjCe+4Ah/uogeXLKT7W0eO1zYdhca8DcBWSh9jkIVffj0wI5t6ZKrlLagJvob+hy+DqE6+W/8PIdk66y9T0UUzAdr6pRSFZcu0cMPOlIriW+Q5M06S9KloDjWHOLnlSZdShj8cq+EQA+wnpuC/A/tF9QbTg/8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cftMC5e3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cftMC5e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBABBC4CEE7;
	Thu,  4 Sep 2025 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756947755;
	bh=8nAczwppKWkmFx31kmIPa7xy1KYrypF3ToB6n147+gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cftMC5e3pTJknQ88YxQ8XMWYUvbmiioDE+LmlC6whHTtQihOKlFkD0DgXwRskIAQP
	 oipGG9uaqXtXJdE67auCilCzPxOQig5NUJI+BS4nyRf6nb4W7Dx1xYV1SC8eB+W1ug
	 GDhXKkTNEH89m60LLZBO6hE3rEMMmXYX839IJhrz0J8RTNXvM9M4p4FhKkK4Ybkl/l
	 hYzNeVNk/VXdO+zRuq6TpsM1Yn3NLAMgVaYOMEtnrYfF9+BFmLwmJU24PmNYvemT7x
	 54dxqqEu1B8w3MPckq4A/5dFhCIJtfOxcbyMYurVADyZivTq9O4hoAtM5sxa461dLh
	 qGpNidom8scKg==
Date: Thu, 4 Sep 2025 10:02:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
Message-Id: <20250904100231.e0bb08d069db31520a6e0435@kernel.org>
In-Reply-To: <5a6dde06-11ee-4ce7-9cb5-f0b8096e42ed@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
	<20250818122720.434981-2-wangjinchao600@gmail.com>
	<20250818122720.434981-3-wangjinchao600@gmail.com>
	<20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
	<284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
	<20250902231152.442041a74774d888cec39201@kernel.org>
	<5a6dde06-11ee-4ce7-9cb5-f0b8096e42ed@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Sep 2025 15:58:44 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On 9/2/25 22:11, Masami Hiramatsu (Google) wrote:
> > On Mon, 1 Sep 2025 18:23:44 +0800
> > Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > 
> >> On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
> >>> Hi Jinchao,
> >>>
> >> Hi Masami,
> >>
> >>> On Mon, 18 Aug 2025 20:26:07 +0800
> >>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> >>>
> >>>> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
> >>>> of hardware breakpoint parameters without deallocating and reallocating
> >>>> the breakpoint slot.
> >>>>
> >>>> The existing arch_install_hw_breakpoint() allocates a new debug register
> >>>> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
> >>>> use cases require modifying breakpoint parameters (address, length, type)
> >>>> atomically without losing the allocated slot, particularly when operating
> >>>> in atomic contexts where allocation might fail or be unavailable.
> >>>>
> >>>> This is particularly useful for debugging tools like kstackwatch that
> >>>> need to dynamically update breakpoint targets in atomic contexts while
> >>>> maintaining consistent hardware state.
> >>>>
> >>>
> >>> I'm also trying to find this interface for my wprobe. So the idea is good.
> >>> But this looks hacky and only for x86. I think the interface should be
> >>> more generic and do not use this arch internal function directly.
> >>>
> >>
> >> I agree with your point about the architectural dependency. I have been
> >> considering this problem not only for the hardware breakpoint
> >> reinstallation,
> >> but also for other related parts of the series, such as canary finding and
> >> stack address resolving. These parts also rely on arch-specific code.
> > 
> > Yes, even though, the hw-breakpoint is an independent feature.
> > Directly using arch_*() functions (which are expected to be used
> > internally) introduces a hidden dependency between these two
> > components and looses maintainability.
> 
> Yes, I am trying to improve this in the v3 series.
> 
> > 
> >>> It seems that the slot is allocated by "type", thus, if this reinstall
> >>> hwbp without deallocate/allocate slot, it must NOT change the type.
> >>> See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
> >>> whether the architecture support that interface.
> >>>
> >> Regarding the slot allocation, I would like to clarify my point. I
> >> believe the
> >> event->attr.type should not be changed when reinstalling a hardware
> >> breakpoint, as this defines the fundamental nature of the event. The type
> >> must always be PERF_TYPE_BREAKPOINT.
> >>
> >> The event->attr.bp_type, however, can be changed. For example, from a
> >> HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
> >> reallocate the slot. This is useful for future applications, even though the
> >> current use case for KStackWatch only requires HW_BREAKPOINT_W.
> > 
> > I understand your point, so it also needs another wrapper which checks
> > the type is compatible on the architecture.
> > 
> 
> I think the wrapper should handle the type by type_slot, something like[1]:
> 

Ah, that's a good idea!

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 1db2c5e24d0e..6fed9521baf2 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -752,6 +752,7 @@ modify_user_hw_breakpoint_check(struct perf_event 
> *bp, struct perf_event_attr *a
>   {
>   	struct arch_hw_breakpoint hw = { };
>   	int err;
> +	enum bp_type_idx old_type_idx, new_type_idx;
> 
>   	err = hw_breakpoint_parse(bp, attr, &hw);
>   	if (err)
> @@ -766,7 +767,9 @@ modify_user_hw_breakpoint_check(struct perf_event 
> *bp, struct perf_event_attr *a
>   			return -EINVAL;
>   	}
> 
> -	if (bp->attr.bp_type != attr->bp_type) {
> +	old_type_idx = find_slot_idx(bp->attr.bp_type);
> +	new_type_idx = find_slot_idx(attr->bp_type);
> +	if (old_type_idx != new_type_idx) {
>   		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
>   		if (err)
>   			return err;
> 
> For kernel breakpoints, we might also consider introducing a
> modify_kernel_hw_breakpoint() helper, similar to
> modify_user_hw_breakpoint(), to encapsulate the kernel-specific case.
> 
> [1]https://lore.kernel.org/all/20250903075144.3722848-3-wangjinchao600@gmail.com/

Hmm, it seems that there is *user_hw_breakpoint() and *wide_hw_breakpoint()
(maybe it means system-wide) so it is better to call modify_wide_hw_breakpoint().
(anyway it is only for kernel address space...)

Thank you!

> 
> >>
> >> By the way, I have sent an updated series.
> >> https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
> > 
> > Yeah, OK, let me review the series. Thanks for update!
> > 
> >>
> >> Thank you again for your valuable review.
> >> -- 
> >> Best regards,
> >> Jinchao
> > 
> > 
> 
> 
> -- 
> Best regards,
> Jinchao


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
