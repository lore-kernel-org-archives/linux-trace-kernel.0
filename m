Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAF2D6E5B;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903458; cv=none; b=rQX5QVLIlOceP4Pr/jr/9HwHxdyGEkyvUwtzEp2+4sq4JI93XRYi73OvU6lQp5oDd9LSxZmVWsK62p2vthbs4vJlxLbGPVCb/hM0+ZiqN7h/sqnCghRbOhYopYoZYc7GPKFsg0aoHuYALU3FDpK1svUqValUE/YjanLs2sSc68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903458; c=relaxed/simple;
	bh=OUFFj9AZqHaaEQJANSjC5PFp63yqEirX5OV3P3nO7UQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=czugFtF0PPzN3On7e53ksHYXPzRjUCm0LvdLTuiRJMreV9rYWPnKynw4QO8nfMsHtdsPUYrMUIQIoeWUy8FhSA9Hq9Guk6EqE5/mf4FaHoO3Lypk65RTRaPuqLG1QhDvot+i1kI4e39Lrqlh4uys/G6nTo57NfmeZ/Mwz8SBNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjSory1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjSory1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CBCC116B1;
	Tue, 11 Nov 2025 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762903457;
	bh=OUFFj9AZqHaaEQJANSjC5PFp63yqEirX5OV3P3nO7UQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jjSory1YK8IgJF6IFGDdgmvGBU9P2x5+yhlFoyZXih1wBQUlhf1EB3rhIjJ/gpI77
	 r3dGZtpJmw+8zPA10VqSBvSoFkPoNnzqQJRe3CQYhfKwwuelfpNhDHf5s8KRGUyPP6
	 8ApDjXCjXQh1A0P9BhhV6L7H64Y0bKjRQzo8CLjvP+bQkWj6P+OfVRPCKScZLBIOGY
	 4/RYryIUxBLiP29gNCelonM+HcJSmzCOsb3K0LMyEYqiGGRC8rKWxTZHdFRZIhXgO8
	 dmA9jMrz21XO5mgRiNvOL4CXH1utss1j6E9mPCw5aBsB3l23/ZbdcFMMlZDQCGqbkk
	 fLpL5V8Ttxvzw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vIxiv-00000000uSN-2bbZ;
	Tue, 11 Nov 2025 18:24:29 -0500
Message-ID: <20251111232429.470883736@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 11 Nov 2025 18:24:08 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/3] tracing: Have function tracer define options per instance
References: <20251111232406.183056289@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the function tracer's options are saved via a global mask when
it should be per instance. Use the new infrastructure to define a
"default_flags" field in the tracer structure that is used for the top
level instance as well as new ones.

Currently the global mask causes confusion:

  # cd /sys/kernel/tracing
  # mkdir instances/foo
  # echo function > instances/foo/current_tracer
  # echo 1 > options/func-args
  # echo function > current_tracer
  # cat trace
[..]
  <idle>-0       [005] d..3.  1050.656187: rcu_needs_cpu() <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656188: get_next_timer_interrupt(basej=0x10002dbad, basem=0xf45fd7d300) <-tick_nohz_next_event
  <idle>-0       [005] d..3.  1050.656189: _raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656190: do_raw_spin_lock(lock=0xffff8944bdf5de80) <-__get_next_timer_interrupt
  <idle>-0       [005] d..4.  1050.656191: _raw_spin_lock_nested(lock=0xffff8944bdf5f140, subclass=1) <-__get_next_timer_interrupt
 # cat instances/foo/options/func-args
 1
 # cat instances/foo/trace
[..]
  kworker/4:1-88      [004] ...1.   298.127735: next_zone <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127736: first_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127738: next_online_pgdat <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127739: fold_diff <-refresh_cpu_vm_stats
  kworker/4:1-88      [004] ...1.   298.127741: round_jiffies_relative <-vmstat_update
[..]

The above shows that updating the "func-args" option at the top level
instance also updates the "func-args" option in the instance but because
the update is only done by the instance that gets changed (as it should),
it's confusing to see that the option is already set in the other instance.

Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index d17c18934445..c12795c2fb39 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -154,11 +154,11 @@ static int function_trace_init(struct trace_array *tr)
 	if (!tr->ops)
 		return -ENOMEM;
 
-	func = select_trace_function(func_flags.val);
+	func = select_trace_function(tr->current_trace_flags->val);
 	if (!func)
 		return -EINVAL;
 
-	if (!handle_func_repeats(tr, func_flags.val))
+	if (!handle_func_repeats(tr, tr->current_trace_flags->val))
 		return -ENOMEM;
 
 	ftrace_init_array_ops(tr, func);
@@ -459,14 +459,14 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	u32 new_flags;
 
 	/* Do nothing if already set. */
-	if (!!set == !!(func_flags.val & bit))
+	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
 	/* We can change this flag only when not running. */
 	if (tr->current_trace != &function_trace)
 		return 0;
 
-	new_flags = (func_flags.val & ~bit) | (set ? bit : 0);
+	new_flags = (tr->current_trace_flags->val & ~bit) | (set ? bit : 0);
 	func = select_trace_function(new_flags);
 	if (!func)
 		return -EINVAL;
@@ -491,7 +491,7 @@ static struct tracer function_trace __tracer_data =
 	.init		= function_trace_init,
 	.reset		= function_trace_reset,
 	.start		= function_trace_start,
-	.flags		= &func_flags,
+	.default_flags	= &func_flags,
 	.set_flag	= func_set_flag,
 	.allow_instances = true,
 #ifdef CONFIG_FTRACE_SELFTEST
-- 
2.51.0


