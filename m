Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B534A3C1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304625; cv=none; b=lVSA6rS/q1aFGOg18TyU9OeME8qxqUEIzUZgCC8KiYs79iozSDcU+01NpfpgXWw5ryoXLrhRgtrt0kSFftNSEnLfavz7+NanhKwJ1S0kdmE5QBSi6Z7vx6lznc3hdQeSQS9wTl6Epf/NaB9GxbAgmMm6cJO4UsTRR/peXrdaZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304625; c=relaxed/simple;
	bh=5rvObDIN8czZ/C/elar2Fvx7QmYdvRAC/uFOS3hUw1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMup3Iswb+NJbqga+9d2KQS9W7GVwJmA3yKPZIw1okDniwd3Q87HIaqx6iRSwUNUApf6Lb9sqmKPbLGOt/Af2dF2oJTGF/PPLfkDJ+Qyjg/5CWjg8uBYPZZDIAHn1prJqi0d9yqQd/WOji9hdihn6We+7KhWH/dNs2loXHTjskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOdns3u; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOdns3u"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43246af170aso3594886f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768304622; x=1768909422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM21RQhXIuohh0krzBpXtiZK7bFpsgchiu6kUOBfCdY=;
        b=LBOdns3u3JI0K4mrnN9mWprFn4GoHWJofIpeOBJ/rXpuCp+SM96+vwLuvtQF5Zf4QR
         sxoEKdDIzbRh7q+H7WEIOkba+PKlj7dTHWcyIsT3ug7Ee/doZBeYRSOBQWVXIR6+KSws
         4U6x8ruuXuZmscnROOtpQTLoDEeVk5wsWgh41zlaCTHmlMUpCEMywBRLrNhrXaJei2kH
         H+rXWkUURJ8nXdPN3a4PoPYWumzUh7wyvo1ehGErKZg+7z8ec5ycZugK2l6KfFGikNaI
         RNCOt1gMle8SloCNKvnwQ++TcYmHRc/sk23U/bUMCKixdTPHjlQJZr6u7bX1ss1uC+K5
         s7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768304622; x=1768909422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM21RQhXIuohh0krzBpXtiZK7bFpsgchiu6kUOBfCdY=;
        b=IEVmdX9OzgibcazJmmirdi7Df9a+BR0lP66vPAh7NfQmIAxZ12kW/hilhT3kohrwnD
         wjWr6Tlm3anzvXK/+DbWGddbNzk+osdmQbSoqTaQuJ/DJt7EUU8PyrGQ2GnGxIw2bndc
         1Lsa0vumV+/FM3266xwDm7pOtC4p+eOSAGD+TEbLIaJF64nCAoE8f12lKcEuSREK1WRn
         L7fKsdIBz7szDy9pD9NfPTYoVW9JsDXF2Keu/MwodXdhpbNhCTYwoLWJZJI3keYv7TET
         yaq2UO1gt0FW3eVeOe2iIn5FXFO5qsUOEVjhjxxqzTG45+NFiGc/eYVdqxgnLYvMkzc8
         BTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWgx1YFwS/M+9L6vNMR0v9Zz9jhiY2iiHWpnzJ0lfHsXGXivs0ofHVNGH53c6iSfjMyrxy2cg7dXhxDNOxtYyYhRas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKcTYO351772251iSW7udnaMLKfe5Gs0zWxni8uupLFEzd1S8
	GiuMDLhsqitYLMXtPPnUvnd0PULDmpTjMBpyp9BVnsLqnu8Zokq71XPf
X-Gm-Gg: AY/fxX6TKU23E8IqrdZJOB/iQ367mMR0v7/u5cuN6LSsXRDasgA1HypnNCB3zD4KJ4H
	igd5Iyb0LtUFGVooiLVD5mmXHCZ3n6n8PlD0SokBp9iRNWeu38t1XZTont07nUr5YOJ3mU37v8V
	a+KXTR65y2TrRtv8trfeApK4sVtXCoSWR7OYT8OHxxGESwcR/tRCrqWDtAkle+FeZgUrg00Qsl1
	6ApO/PALVIAJfP767IqHJkjXpYTKqpfUo9Y6t1nYLjFqx7buBE25ykFOYwOxoysO3MfPEFhyEsa
	o2+oV+9HVAXK6gm6mke/NhPAHKGh+Fylrj39dG2WwGXqHzAXlFbAZvQ9zXnb/0OYWZab08cCWHo
	748kJEyjOZF8ZGQhyHl4eHegiA5/AlBF/gy2p3yO78w9lQAFWy9lqsW7CAqgN
X-Received: by 2002:a05:6000:1862:b0:432:5b18:2cc3 with SMTP id ffacd0b85a97d-43423e7458dmr3591770f8f.4.1768304621812;
        Tue, 13 Jan 2026 03:43:41 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe67csm43718308f8f.40.2026.01.13.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 03:43:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Jan 2026 12:43:39 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
Message-ID: <aWYv6864cdO2PWbb@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112170757.4e41c0d8@gandalf.local.home>

On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> On Mon, 12 Jan 2026 22:49:38 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > To recreate same stack setup for return probe as we have for entry
> > probe, we set the instruction pointer to the attached function address,
> > which gets us the same unwind setup and same stack trace.
> > 
> > With the fix, entry probe:
> > 
> >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> >   Attaching 1 probe...
> > 
> >         __x64_sys_newuname+9
> >         do_syscall_64+134
> >         entry_SYSCALL_64_after_hwframe+118
> > 
> > return probe:
> > 
> >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> >   Attaching 1 probe...
> > 
> >         __x64_sys_newuname+4
> >         do_syscall_64+134
> >         entry_SYSCALL_64_after_hwframe+118
> 
> But is this really correct?
> 
> The stack trace of the return from __x86_sys_newuname is from offset "+4".
> 
> The stack trace from entry is offset "+9". Isn't it confusing that the
> offset is likely not from the return portion of that function?

right, makes sense.. so standard kprobe actualy skips attached function
(__x86_sys_newuname) on return probe stacktrace.. perhaps we should do
the same for kprobe_multi

I managed to get that with the change below, but it's wrong wrt arch code,
note the ftrace_regs_set_stack_pointer(fregs, stack + 8) .. will try to
figure out better way when we agree on the solution

thanks,
jirka


---
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index c56e1e63b893..b0e8ce4934e7 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -71,6 +71,9 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
 
+#define ftrace_regs_set_stack_pointer(fregs, _sp)	\
+	do { arch_ftrace_regs(fregs)->regs.sp = (_sp); } while (0)
+
 
 static __always_inline unsigned long
 ftrace_regs_get_return_address(struct ftrace_regs *fregs)
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6279e0a753cf..b1510c412dcb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -717,7 +717,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 /* Retrieve a function return address to the trace stack on thread info.*/
 static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
-			unsigned long frame_pointer, int *offset)
+			unsigned long *stack, unsigned long frame_pointer,
+			int *offset)
 {
 	struct ftrace_ret_stack *ret_stack;
 
@@ -762,6 +763,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 
 	*offset += FGRAPH_FRAME_OFFSET;
 	*ret = ret_stack->ret;
+	*stack = (unsigned long) ret_stack->retp;
 	trace->func = ret_stack->func;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth;
@@ -810,12 +812,13 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long bitmap;
+	unsigned long stack;
 	unsigned long ret;
 	int offset;
 	int bit;
 	int i;
 
-	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, &stack, frame_pointer, &offset);
 
 	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
@@ -824,8 +827,11 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	if (fregs)
-		ftrace_regs_set_instruction_pointer(fregs, trace.func);
+	if (fregs) {
+		ftrace_regs_set_instruction_pointer(fregs, ret);
+		ftrace_regs_set_stack_pointer(fregs, stack + 8);
+	}
+
 
 	bit = ftrace_test_recursion_trylock(trace.func, ret);
 	/*
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index e1a9b55e07cb..852830536109 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -74,12 +74,20 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
 
 	load_kallsyms();
 
-	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 5,
-			     ksym_get_addr("bpf_testmod_stacktrace_test"),
-			     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
-			     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
-			     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
-			     ksym_get_addr("bpf_testmod_test_read"));
+	if (retprobe) {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	} else {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 5,
+				     ksym_get_addr("bpf_testmod_stacktrace_test"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	}
 
 cleanup:
 	stacktrace_ips__destroy(skel);
