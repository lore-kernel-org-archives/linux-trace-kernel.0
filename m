Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558556;
	b=vm78O9Vxfq4P8PGJkUCg/Oc/0OUEKL4JIw2nHre8ajacfBO+roDQEzxW27rtQ7mdn76e
	 YxfoqHOiziITQTpH5573m+kU4BhW506O/pQAFYtISLV0n/i8eCwvYLKQUvsMvkZV8t0ZZ
	 e1MCZeYIvobH6tGrcw6m65n513eqTng1/trB//jSWbNBwtV7G0GqIZcPa3QNlwWLnpa7c
	 YLD5fbdpA+SFAG1uYnp9mdEC8or46OVY4DkotKZ5C6WcNOj9uvgu00/qXfXLN4dOryD0C
	 84JWn9nox3piPG2A2J637g/3KJRnQ4XBeDpLkVquOmCj7cjBBPJiMwtutrSTAGLRL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1ADNqVjdWXJLkkcvPIA5z3CRhNbUm3fQXb7C1GT5FHE=;
	b=IV2nE0zlMWw9zLBFMvZX+MaDrmdqOpUt5X8nJ2F25Og05MFQCUvjDYJaxQMnSgZss/Tf
	 PoG81iiYbFISroTUq/Cgd98qeCNt3QDJ73ajBpiTLCAxg121I74j98W1K8G5kklpnKG1E
	 xv8Ov4bgt+Mu+kRNFDqrP32ThGZMDt/+Aa5e+gLd+AgZIRQlH7VwSzTXnhiJYQLNrIe59
	 hBiqjslv9tBSzNmQb6KqyJecDJhikIgAfsCkPLNdOhLUoFuG3kecBI4NvvloVq68b+fA5
	 5/MMh/FJdI9Ra84W5pCVrLmQvt95fpUPzZDLr4JkAi+aUdFjbp5/VeBzOTasvSpZkZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gD/FxJI+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5C606A336;
	Fri, 13 Nov 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gD/FxJI+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CD1F000C6;
	Fri, 13 Nov 2026 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558556;
	bh=1ADNqVjdWXJLkkcvPIA5z3CRhNbUm3fQXb7C1GT5FHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gD/FxJI+s/FN8fiYMgVCsrmylOhvMRBj+ROLXK7ttVlMkJEJIwobRdo8w8thtY8FT
	 wufWUIEAjlbzUPeJwuY0ePyZrjYBxyEf6cj+VIXNgK8Z6WEAq4NEs4GG4lAz4c1ncF
	 tlGy7gETDdSsCM7sJYJFnYX4zjZAo9p68Q5yTzSgyrG0Wva65bB1J5r6cBN88cdZHr
	 bvdYRFC5kDAJnsjTh30iyo4vWfFMggjlnwDxm1QIT+BqcFFu8uoCunu/a58Dvui8Kg
	 1qhOSi0QK8D4aHak6BOrJJwPPwJ0vYkcTIWYXOakP8c+gCzDh2YNF1hSpIsmtdStQM
	 a8JVPcztfyKdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
Subject: Re: [PATCH v3 0/5] kprobes: Fixes for ftrace ops and optprobe state machine
Date: Fri, 13 Nov 2026 17:29:13 +0900
Message-ID: <undine-1794558553054274015-44419a209398ea3e@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179440640176.328088.17106877243326801914.stgit@devnote2>
References: <179440640176.328088.17106877243326801914.stgit@devnote2>
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

On Wed, 11 Nov 2026 23:13:21 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> Hi,
> 
> Here is v3 of the remaining bug fixes for kprobes and optprobes.
> The previous version is here:
> 
>   https://lore.kernel.org/all/179427358690.291326.2078291446658598883.stgit@devnote2/
> 
> This version restores __arm_kprobe() fix as patch 3, and update the KUnit
> test code to check it.
> This includes following fixes.

I'll pick the first 4 of this series to probes/fixes and the last
test to probes/core.

Thanks,

> 
> 1. Ftrace Ops Switching for Post-Handlers (Patch 1):
>    - When adding a second probe with a post_handler to an existing ftrace
>      kprobe, the aggregate probe's post_handler was set but remained armed
>      on kprobe_ftrace_ops. Subsequent disarming attempted to disarm from
>      kprobe_ipmodify_ops, failing with -ENOENT and leaking the armed probe.
>      Switch ftrace ops safely in register_aggr_kprobe() outside of
>      text_mutex and cpus_read_lock.
> 
> 2. Optprobe State Machine & Tasks RCU Quiescence (Patches 2-4):
>    - Forcibly unoptimized probes (unoptimize_kprobe(force = true)) were
>      not queued to cooling_list, causing kprobe_disarmed() to return true
>      prematurely and risking use-after-free in the optinsn detour buffer
>      before Tasks RCU completed.
>    - When re-arming a probe that is queued on unoptimizing_list before the
>      optimizer thread runs, skip arch_arm_kprobe() in __arm_kprobe() so
>      the active jump instruction is not overwritten with a breakpoint.
>    - When a disabled cooling probe finishes cooling and transitions to
>      safely disarmed in optprobe_finalize_generation(), re-optimize any
>      blocked sibling probe whose jump range covers its address.
> 
> 3. KUnit Regression Tests (Patch 5):
>    - Add KUnit test cases to lib/tests/test_kprobes.c covering the recent
>      kprobes, kretprobes, ftrace ops, and optprobe fixes.
> 
> Changes in v3:
> [03/05]
>  - Restore the __arm_kprobe() fix that was accidentally dropped in v2
>    while omitting the reuse_unused_kprobe() hunk superseded by commit
>    1ffd6efb1b58 ("kprobes: Arm reused optprobe on cooling list").
> [05/05]
>  - Check that the jump opcode at *opt_kp.addr is preserved across
>    disable_kprobe() and enable_kprobe() in
>    test_optprobe_rearm_unoptimizing().
> 
> Thank you,
> 
> ---
> base-commit: 1ffd6efb1b58e596ed70f660182803264a4c84d9
> 
> Masami Hiramatsu (Google) (5):
>       kprobes: Switch ftrace ops when adding probe with post_handler
>       kprobes: Fix UAF and queue cooling probes on forced unoptimization
>       kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe
>       kprobes: Re-optimize blocked sibling probe when cooling finishes
>       kprobes: Add KUnit test cases for kprobes regressions
> 
> 
>  kernel/kprobes.c         |  116 +++++++++++++++++++++++++++-----------
>  lib/tests/test_kprobes.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 220 insertions(+), 35 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
