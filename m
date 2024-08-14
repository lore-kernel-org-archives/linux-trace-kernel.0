Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21413ACC;
	Wed, 14 Aug 2024 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600897; cv=none; b=iPcXO0jFXMMgPIT9T6/8mpnFxk/Nf+EjeLNVpo1r96v+F8BDCJMEjp1GUWMNu1+AoY8mN8OFv8GIC6RyrHiLnK8grl0/5X06vHf2hp1vw00jyESEIbtP/Yb8Qt+EPPBTBVJ8IVpw0xB2T5PALJC3AGO0ywzjcjjs5FDJLkRRCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600897; c=relaxed/simple;
	bh=o9LK2bWmdRXLeyaxH7Xcgpvn578ms+I2SRBxO0CgZX4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cyLgTFQyIWv/ktIe03Z0IdecAU+kXoeiFwHBe+T6fmpt/n/WdbSrsL26Fg2nVxG3ma5wuzc5aG/oi4S2ehxNz/DYiABK1qB7i0yf03FWp4QUBSOLfig4Mt27YRjVRYurtUvgiagpebUwUl0xZVYCKcJPATeSF9+QcVlYCia7/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBCWXnQF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBCWXnQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AA0C32782;
	Wed, 14 Aug 2024 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723600896;
	bh=o9LK2bWmdRXLeyaxH7Xcgpvn578ms+I2SRBxO0CgZX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jBCWXnQFt9iDxmBCxL5/yxMSSPc/VusU3ol3hPO+ihIuyxllPGOYLOGBG44tfHvH6
	 Lr30oFasMMQ7i/235qlad0bUdKYtN7LEyfeJtLE/uNT/KYf2jOxwFOT+uMU7CSRvkw
	 d4xTHcM/S4KIVdGZ0cj3u99jdg0cCAmoD3ZX3Mif4+S6Ju+79iFh7bkbHhGr13nB62
	 Qe9R78bOkft7NoC6LvNvzws5d+h12GhgaUMPUepKgAI+QUNxIC4ESpI9ZMwfBxkfRO
	 fjzSLjJDl6fNYcqjJexkQagTaBg/wJ7q+Jm8V0VQLu64DFWDSthGtFRTB6b0rD5yS+
	 15A60LwPT9j1g==
Date: Wed, 14 Aug 2024 11:01:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, don <zds100@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
Message-Id: <20240814110132.088d5acbd2df5dc5aeb63de3@kernel.org>
In-Reply-To: <5fc7a866-ecd9-4b57-9740-369544df1264@efficios.com>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
	<171723016594.258703.1629777910752596529.stgit@devnote2>
	<fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
	<20240604084955.29b9440687522a1347e0e7cd@kernel.org>
	<419b80da-9cbf-4bb2-aabb-dc04f0fb0f37@efficios.com>
	<20240604123418.22e16e97@gandalf.local.home>
	<5fc7a866-ecd9-4b57-9740-369544df1264@efficios.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sorry I missed this thread. Thanks for your comments.

On Tue, 4 Jun 2024 14:03:05 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-06-04 12:34, Steven Rostedt wrote:
> > On Tue, 4 Jun 2024 11:02:16 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> I see.
> >>
> >> It looks like there are a few things we could improve there:
> >>
> >> 1) With your approach, modules need to be already loaded before
> >> attaching an fprobe event to them. This effectively prevents
> >> attaching to any module init code. Is there any way we could allow
> >> this by implementing a module coming notifier in fprobe as well ?
> >> This would require that fprobes are kept around in a data structure
> >> that matches the modules when they are loaded in the coming notifier.
> > 
> > The above sounds like a nice enhancement, but not something necessary for
> > this series.
> 
> IMHO it is nevertheless relevant to discuss the impact of supporting
> this kind of use-case on the ABI presented to userspace, at least to
> validate that what is exposed today can incrementally be enhanced
> towards that goal.
> 
> I'm not saying that it needs to be implemented today, but we should
> at least give it some thoughts right now to make sure the ABI is a
> good fit.

OK, let me try to update to handle module loading. I also need to add
a module which has a test tracepoint in init function.

> 
> >>
> >> 2) Given that the fprobe module going notifier is protected by the
> >> event_mutex, can we use locking rather than reference counting
> >> in fprobe attach to guarantee the target module is not reclaimed
> >> concurrently ? This would remove the transient side-effect of
> >> holding a module reference count which temporarily prevents module
> >> unload.

See trace_kprobe_module_callback()@kernel/trace/trace_kprobe.c. I think
we can filter the MODULE_STATE_COMING flag before locking event_mutex.
We anyway don't check the module is going because it would be a waste to
disarm the raw tracepoint events from the going module.

Thank you,

> > 
> > Why do we care about unloading modules during the transition? Note, module
> > unload has always been considered a second class citizen, and there's been
> > talks in the past to even rip it out.
> 
> As a general rule I try to ensure tracing has as little impact on the
> system behavior so issues that occur without tracing can be reproduced
> with instrumentation.
> 
> On systems where modules are loaded/unloaded with udev, holding
> references on modules can spuriously prevent module unload, which
> as a consequence changes the system behavior.
> 
> About the relative importance of the various kernel subsystems,
> following your reasoning that module unload is considered a
> second-class citizen within the kernel, I would argue that tracing
> is a third-class citizen and should not needlessly modify the
> behavior of classes above it.
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
