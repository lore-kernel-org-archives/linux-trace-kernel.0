Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15972143C69;
	Tue,  2 Sep 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822316; cv=none; b=uH0JmXq3t56sPtA2z1lDYMrShEY0iAZc8ZIA7mz3ZwKUz/pIPSBMuqL1q+5RLt+9d9SHQtaBLNHn3LDa74HJE8DfSboqeAXu+do5yYCxb60sBPFE4lUfRH0fyj46H8a821OoOFTBbEgyxvOcEcv7wFPNrgCKZ7sos8dDV54Cnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822316; c=relaxed/simple;
	bh=1xFBw0aYZ3pncn46SvO4NtUQ09sWcq0onAb9a8kbZ3Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G5M9DnJzDL4bS0E4QBcd9JbjMkq0kFZNI/kgu3mgFrc0WJdcqtXSX5+x1DnjudptT1TaOQ4gIle4SvSeP4rApp4kc/D7e8Lqzg42fOpQCtZ0AfHZxDwb9OfjtigOP50rKk/hk31zUV86BqzWfra/rCJy94DvmE3n/dvDyUlb/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uegviDeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uegviDeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEC5C4CEED;
	Tue,  2 Sep 2025 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756822315;
	bh=1xFBw0aYZ3pncn46SvO4NtUQ09sWcq0onAb9a8kbZ3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uegviDeSHU2tMUPDyq1CrblQFM0ye6D0fJm9e3Uxa8HbcBDCkCWN0PTjRX0VyQ4VQ
	 1kccY/Dp5e52/Ouqqmt3GrrMo7n/70mUGLvD9iMaiqbbrKNjfsx5awdDtjbh9Vswh7
	 yUv7PxIgHutWVZ/EvQSuqoK6SmH6I3PTHIdO04+rNR5cQiOYPN1RmXuvvABMqj2hXh
	 5U4mEtaJ07+78Lm1qi/yDnF7lNwziqOyYMTVPT/nALSp6Iv37XZv/5LQquxEMOZTxV
	 KKUlCEXL/7sCVE3lD0OaB5IEY0ZeiT3PdWVA5msHvssOPypbAVhpMA4NAs2qjPP+pr
	 oqFvDYU8Q+dbg==
Date: Tue, 2 Sep 2025 23:11:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
Message-Id: <20250902231152.442041a74774d888cec39201@kernel.org>
In-Reply-To: <284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
	<20250818122720.434981-2-wangjinchao600@gmail.com>
	<20250818122720.434981-3-wangjinchao600@gmail.com>
	<20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
	<284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 18:23:44 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
> > Hi Jinchao,
> > 
> Hi Masami,
> 
> > On Mon, 18 Aug 2025 20:26:07 +0800
> > Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > 
> >> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
> >> of hardware breakpoint parameters without deallocating and reallocating
> >> the breakpoint slot.
> >>
> >> The existing arch_install_hw_breakpoint() allocates a new debug register
> >> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
> >> use cases require modifying breakpoint parameters (address, length, type)
> >> atomically without losing the allocated slot, particularly when operating
> >> in atomic contexts where allocation might fail or be unavailable.
> >>
> >> This is particularly useful for debugging tools like kstackwatch that
> >> need to dynamically update breakpoint targets in atomic contexts while
> >> maintaining consistent hardware state.
> >>
> > 
> > I'm also trying to find this interface for my wprobe. So the idea is good.
> > But this looks hacky and only for x86. I think the interface should be
> > more generic and do not use this arch internal function directly.
> >
> 
> I agree with your point about the architectural dependency. I have been
> considering this problem not only for the hardware breakpoint 
> reinstallation,
> but also for other related parts of the series, such as canary finding and
> stack address resolving. These parts also rely on arch-specific code.

Yes, even though, the hw-breakpoint is an independent feature.
Directly using arch_*() functions (which are expected to be used
internally) introduces a hidden dependency between these two
components and looses maintainability.

> > It seems that the slot is allocated by "type", thus, if this reinstall
> > hwbp without deallocate/allocate slot, it must NOT change the type.
> > See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
> > whether the architecture support that interface.
> > 
> Regarding the slot allocation, I would like to clarify my point. I 
> believe the
> event->attr.type should not be changed when reinstalling a hardware
> breakpoint, as this defines the fundamental nature of the event. The type
> must always be PERF_TYPE_BREAKPOINT.
> 
> The event->attr.bp_type, however, can be changed. For example, from a
> HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
> reallocate the slot. This is useful for future applications, even though the
> current use case for KStackWatch only requires HW_BREAKPOINT_W.

I understand your point, so it also needs another wrapper which checks
the type is compatible on the architecture.

> 
> By the way, I have sent an updated series.
> https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/

Yeah, OK, let me review the series. Thanks for update!

> 
> Thank you again for your valuable review.
> -- 
> Best regards,
> Jinchao


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
