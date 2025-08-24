Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491B393DE3;
	Sun, 24 Aug 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756041713; cv=none; b=V7aqnDttKPI3e06XsNJ3IwE0Cj/bgSJmSg7HLjy9fY8oVYnVp23udMzFXPaSUgASXdniIF7eFefYxPcq35kMmtRjSm7ThOfvy4JpPKq8nDuR0TFuKwmxHVy19KfwGHYlQtX3f70C7g0cK4vdGZYOlRL13ATwkav3L/KO8JMliy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756041713; c=relaxed/simple;
	bh=h/fviW0PV8ZWdpkOUgzk2EMQr4RVTPreRibeYR+M034=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq9sEd2ntoP+f06SlXDESoEmdsVcGJc/6LmincvPK1zQRZtxkyZiaQRkSfMxSrw8kJKSQr2/Gqo8DJnnm5RQ6IS+0E8U+44Kv+zC91/H8sxx4iMQ1jd2USdNfAbZXSxvQgharv//3v1AjckAOoShzgdXnKx1Ysn2YuOqNhA5vK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D7D9F1D3744;
	Sun, 24 Aug 2025 13:21:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 2B6F620027;
	Sun, 24 Aug 2025 13:21:40 +0000 (UTC)
Date: Sun, 24 Aug 2025 09:21:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] init/main.c: fix boot time tracing crash
Message-ID: <20250824092150.0543aaa0@gandalf.local.home>
In-Reply-To: <20250824130759.1732736-1-rppt@kernel.org>
References: <20250824130759.1732736-1-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2B6F620027
X-Stat-Signature: t4wit6ifygc9okcd3tpk4ip19t3q47pw
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CaDAsUnPhVljwV0c6QyMcpf/ZM1Woxew=
X-HE-Tag: 1756041700-784371
X-HE-Meta: U2FsdGVkX18u0lEWRUBvW1xAvzyWq5RN2K62NHVU57qhJj2eVQcuYAQ/98QGVMIhryAWWE2g7NQDVWmPS71Db/jAVQuqjj08PcdhZkcsD4gVikQNUG+QzL6sB2mb5vlKQirP8VCxA4VI2whcjF7W3yjHtQM8y6JE+UfA3OG1AAjiCbPxQLCSe+JI59bVz+0EfZMSrufAw2EuVsTw6TtinzWp7fp9lNLdPqeBgORVmB+7YRnSXoItRzBId7el1Cbzwwd8HOqL0Sc8nMV2VObBv2q0QuKJX1HYFHeQsULk60TeKET3x0rHHEHjQwRrRnbIFC2QXFT4sAP2Rso9KYz7J+o6LgEWyaqlWMSVuks+6/aPtfdtJPv+BxQuhaGEdYiukA5aoteVfTHMGFZXX14qSA==

On Sun, 24 Aug 2025 16:07:59 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Steven Rostedt reported a crash with "ftrace=function" kernel command
> line:
> 
> [    0.159269] BUG: kernel NULL pointer dereference, address: 000000000000001c
> [    0.160254] #PF: supervisor read access in kernel mode
> [    0.160975] #PF: error_code(0x0000) - not-present page
> [    0.161697] PGD 0 P4D 0
> [    0.162055] Oops: Oops: 0000 [#1] SMP PTI
> [    0.162619] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17.0-rc2-test-00006-g48d06e78b7cb-dirty #9 PREEMPT(undef)
> [    0.164141] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    0.165439] RIP: 0010:kmem_cache_alloc_noprof (mm/slub.c:4237)
> [ 0.166186] Code: 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 e4 f0 48 83 ec 20 8b 05 c9 b6 7e 01 <44> 8b 77 1c 65 4c 8b 2d b5 ea 20 02 4c 89 6c 24 18 41 89 f5 21 f0
> [    0.168811] RSP: 0000:ffffffffb2e03b30 EFLAGS: 00010086
> [    0.169545] RAX: 0000000001fff33f RBX: 0000000000000000 RCX: 0000000000000000
> [    0.170544] RDX: 0000000000002800 RSI: 0000000000002800 RDI: 0000000000000000
> [    0.171554] RBP: ffffffffb2e03b80 R08: 0000000000000004 R09: ffffffffb2e03c90
> [    0.172549] R10: ffffffffb2e03c90 R11: 0000000000000000 R12: 0000000000000000
> [    0.173544] R13: ffffffffb2e03c90 R14: ffffffffb2e03c90 R15: 0000000000000001
> [    0.174542] FS:  0000000000000000(0000) GS:ffff9d2808114000(0000) knlGS:0000000000000000
> [    0.175684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.176486] CR2: 000000000000001c CR3: 000000007264c001 CR4: 00000000000200b0
> [    0.177483] Call Trace:
> [    0.177828]  <TASK>
> [    0.178123] mas_alloc_nodes (lib/maple_tree.c:176 (discriminator 2) lib/maple_tree.c:1255 (discriminator 2))
> [    0.178692] mas_store_gfp (lib/maple_tree.c:5468)
> [    0.179223] execmem_cache_add_locked (mm/execmem.c:207)
> [    0.179870] execmem_alloc (mm/execmem.c:213 mm/execmem.c:313 mm/execmem.c:335 mm/execmem.c:475)
> [    0.180397] ? ftrace_caller (arch/x86/kernel/ftrace_64.S:169)
> [    0.180922] ? __pfx_ftrace_caller (arch/x86/kernel/ftrace_64.S:158)
> [    0.181517] execmem_alloc_rw (mm/execmem.c:487)
> [    0.182052] arch_ftrace_update_trampoline (arch/x86/kernel/ftrace.c:266 arch/x86/kernel/ftrace.c:344 arch/x86/kernel/ftrace.c:474)
> [    0.182778] ? ftrace_caller_op_ptr (arch/x86/kernel/ftrace_64.S:182)
> [    0.183388] ftrace_update_trampoline (kernel/trace/ftrace.c:7947)
> [    0.184024] __register_ftrace_function (kernel/trace/ftrace.c:368)
> [    0.184682] ftrace_startup (kernel/trace/ftrace.c:3048)
> [    0.185205] ? __pfx_function_trace_call (kernel/trace/trace_functions.c:210)
> [    0.185877] register_ftrace_function_nolock (kernel/trace/ftrace.c:8717)
> [    0.186595] register_ftrace_function (kernel/trace/ftrace.c:8745)
> [    0.187254] ? __pfx_function_trace_call (kernel/trace/trace_functions.c:210)
> [    0.187924] function_trace_init (kernel/trace/trace_functions.c:170)
> [    0.188499] tracing_set_tracer (kernel/trace/trace.c:5916 kernel/trace/trace.c:6349)
> [    0.189088] register_tracer (kernel/trace/trace.c:2391)
> [    0.189642] early_trace_init (kernel/trace/trace.c:11075 kernel/trace/trace.c:11149)
> [    0.190204] start_kernel (init/main.c:970)
> [    0.190732] x86_64_start_reservations (arch/x86/kernel/head64.c:307)
> [    0.191381] x86_64_start_kernel (??:?)
> [    0.191955] common_startup_64 (arch/x86/kernel/head_64.S:419)
> [    0.192534]  </TASK>
> [    0.192839] Modules linked in:
> [    0.193267] CR2: 000000000000001c
> [    0.193730] ---[ end trace 0000000000000000 ]---
> 
> The crash happens because on x86 ftrace allocations from execmem require
> maple tree to be initialized.
> 
> Move maple tree initialization that depends only on slab availability
> earlier in boot so that it will happen right after mm_core_init().
> 
> Fixes: 5d79c2be5081 ("x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations")

Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20250820184743.0302a8b5@gandalf.local.home/

-- Steve
