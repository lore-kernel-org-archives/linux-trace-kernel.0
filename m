Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FB229B28;
	Thu,  1 May 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128698; cv=none; b=CBKKU0mD+We7Sxymhu1u/DKEt5+Omv5AQ5rbgkTB1vaFywloLAnpx7b247edqjV3C/ER7/Tm0aSEyt1OOSTcFBaEzcBz1K9sSyClQw1Caouq598fn5udhZjIetHopD5E5HNyg63GSojqAOwyQwohv6seYsFbRPxvcARjih9KOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128698; c=relaxed/simple;
	bh=HpxDL6ZEq/oUohRZHvp0vdmMaJS85URSzY0FtPADCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFy0WdK8zydlVi68PvfID3vgkpZEEcageteCDYAkGpTVCqeA0GFaiKdepPfSKTRMnyum56RvEnCeFzxONO12Sxp304KyMcxDmmy73BL1gvVLv9uLEXVrkIQHbL4EzjepmgwAii9jxyGTAHub83V2L5NMCEwGF24529k7i0N+B0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701CAC4CEE9;
	Thu,  1 May 2025 19:44:57 +0000 (UTC)
Date: Thu, 1 May 2025 15:45:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Cc: paulcacheux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix race when creating trace probe log error
 message
Message-ID: <20250501154503.2308f177@gandalf.local.home>
In-Reply-To: <20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com>
References: <20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 20:33:13 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>

Sorry for the late reply, I just noticed this patch.

> 
> When creating a trace probe a global variable is modified and this
> data used when an error is raised and the error message generated.
> 
> Modification of this global variable is done without any lock and
> multiple trace operations will race, causing some potential issues
> when generating the error.
> 
> This commit moves away from the global variable and passes the
> error context as a regular function argument.
> 
> Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
> 
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> ---
> As reported in [1] a race exists in the shared trace probe log
> used to build error messages. This can cause kernel crashes
> when building the actual error message, but the race happens
> even for non-error tracefs uses, it's just not visible.
> 
> Reproducer first reported that is still crashing:
> 
>   # 'p4' is invalid command which make kernel run into trace_probe_log_err()
>   cd /sys/kernel/debug/tracing
>   while true; do
>     echo 'p4:myprobe1 do_sys_openat2 dfd=%ax filename=%dx flags=%cx mode=+4($stack)' >> kprobe_events &
>     echo 'p4:myprobe2 do_sys_openat2' >> kprobe_events &
>     echo 'p4:myprobe3 do_sys_openat2 dfd=%ax filename=%dx' >> kprobe_events &
>   done;
> 
> The original email suggested to use a mutex or to allocate the
> trace_probe_log on the stack. The mutex can cause performance
> issues, and require high confidence in the correctness of the
> current trace_probe_log_clear calls. This patch implements
> the stack solution instead and passes a pointer to using
> functions.
> 
> [1] https://lore.kernel.org/all/20221121081103.3070449-1-zhengyejian1@huawei.com/T/

Honestly, I don't like either approach.

What could be done is wrap the internals of the function in a mutex so they
are not re-entrant (using guard(mutex)). If two error codes are happening
together, just let it get corrupted. There should never be two additions at
the same time, and if the admin is doing that then they deserve what they
get.

I don't care if the error log gets garbage if there's multiple accesses at
the same time. The fix should only prevent it from crashing.

-- Steve


-- Steve

