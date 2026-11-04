Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809873;
	b=piCA2DXMuxHcnO7EO8W4EIl4djpVezPApmMaOFtiKHWR81xZpe8i7/TumSO3n15KbSQP
	 p2kHfzabyeWEX9reHsCStvoDuMBaJ7k06AB+sxOkrK0RCPM6Df5LA5FHpnaI/npOD0yaq
	 JGYva4/vKKNBcOrrW/oAI9F2ScD3TTnthpDpiP4PCUGXQi1nmNhd3AUWoiMr0re1GZDnS
	 KLF898AB6vwZFT+ldlvCUqZy0utOETdjojC3YN+998rvL0yHVHd+DvFwmPUUIY0/6B3NE
	 Al23PyXmVz5+RM1zTMPCrDHsHLGsmGq7lLLabE6T6127yDFKCPMBqeJ7W51DWa0fCfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XPP5Gc+PYevQgOmPpedXk4fHvQX+FkIrYpbHlEuBbXs=;
	b=Aw0CvLfvl1CZgRgUp4PKjf3jFQBgf6WACRUib/IH5bCtN+ISMV29rRfF75ygec4idV8k
	 z/PfHJU2KHtGiZExnoU0rWfAcw7hgRahGHr4DZkMjOEKbvd9DuEuMivX6GeweUiz0SwGY
	 zOYgXfvinCCeG5QmNu7grKrdZMFkptRoazCWoPeHf03Q8MS68ZB2KfiZHLJ9zqi1yOjVq
	 xyPnOY7Jjbm5YAhq9PtSo1ZtdekGzmfCaIcW2he6GlClchBewpX/4QFnVxRQFbi59rmTp
	 N78qBpKdqwsAkk3UWWa/fkMTqx105rEmrxBXbdYR6vYaUgnoiJj2QoluZtCd5vbGUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fu8MvGBg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD146606A31B;
	Wed,  4 Nov 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fu8MvGBg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCFA1F00A02;
	Wed,  4 Nov 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809872;
	bh=XPP5Gc+PYevQgOmPpedXk4fHvQX+FkIrYpbHlEuBbXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fu8MvGBgjIDM3kL17UEbTw+7P4sJe2J50/yr2b+DHEcTsvtoGtD0pdwZLrRWN/i0t
	 0CO+X2DAZZ5WKlND/66+IHD9boHTCL/zHS9No3hnG6RUifZI/FYPOqquIsqSfEDcd0
	 YnunH6OV3ZApLMeliTP7bys9PSdDzbXurXmjYREyn5tg+/Kq9H5c23uJQ5iLYINl8K
	 lGyRzdhAn6tCu81ZXx8qbvYFFUMG3e1Y5g4lFsMRB0cQf5T6XbA5MCD3fyp2EYx8QK
	 /KcpElE0Yg+1hP8z3NVUScddOkyZebt9+06SnDGBccPTSY9VxkxIcv/+xx38w/DiUf
	 QZyz6/05kwD0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] kprobes: Fixes for registration errors, ftrace ops and optprobe state machine
Date: Thu, 05 Nov 2026 01:31:09 +0900
Message-ID: <undine-1793809869181449246-6f60c1b614332955@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Nov 2026 08:58:18 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> Hi,
> 
> Here is a series of bug fixes for kprobes and optprobes, addressing error
> recovery, ftrace ops management, and optprobe asynchronous state machine
> edge cases:
> 
> 1. Registration & Unregistration Error Handling (Patches 1-3):
>    - In __register_kprobe(), when arm_kprobe() fails, the error code was
>      ignored and the instruction slot was leaked.
>    - In unregister_kretprobes(), failing __unregister_kprobe_top() still
>      invoked rethook/rph freeing, causing a double free or NULL deref.
>      Clearing rp->rh is also deferred until after synchronize_rcu() to
>      prevent racing with in-flight pre_handler_kretprobe() invocations.
>    - In register_kretprobe(), re-registration validation was skipped when
>      registered by symbol_name without an explicit addr, leading to
>      destruction of the live probe's rethook instance on failure.

I think these are urgent fixes. So I'll pick those to probes/fixes.

> 
> 2. Ftrace Ops Switching for Post-Handlers (Patch 4):
>    - When adding a second probe with a post_handler to an existing ftrace
>      kprobe, the aggregate probe's post_handler was set but remained armed
>      on kprobe_ftrace_ops. Subsequent disarming attempted to disarm from
>      kprobe_ipmodify_ops, failing with -ENOENT and leaking the armed probe.
>      Switch ftrace ops safely in register_aggr_kprobe() outside of
>      text_mutex and cpus_read_lock.

This should be updated to v2.

> 
> 3. Optprobe State Machine & Tasks RCU Quiescence (Patches 5-7):
>    - Forcibly unoptimized probes (unoptimize_kprobe(force = true)) were
>      not queued to cooling_list, causing kprobe_disarmed() to return true
>      prematurely and risking use-after-free in the optinsn detour buffer
>      before Tasks RCU completed.
>    - Re-arming an unoptimizing probe before the unoptimization pass ran
>      overwrote the first byte of the relative jump with a breakpoint,
>      corrupting the jump opcode in text.
>    - Probes killed at module unload while child probes were still active
>      were prematurely freed or improperly unhashed before Tasks RCU
>      quiescence elapsed.

I need to update these and rebase on Mani's fixes [1] after he fixed
problems, since that will fix the similar problems. These will be
probes/for-next branch.

[1] https://lore.kernel.org/r/20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu

> 
> In addition to the bugfixes, the last patch adds KUnit test cases for
> these bugs. (Patch 8)

This also needs to be updated, but it will also go to probes/for-next.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
