Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365079F5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpKUA6UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B30C433C7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701421981;
	bh=/qbc5Hq5W5OzXbcxK7RyVxU9LuWBTsmlhNTQXShoFiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gpKUA6UIMP+ibfCWIwVJFzyEKNoQ9joezckZmFqJaJEGq9WTQ8NEI+JGoRTSDQC3W
	 824jfotbQyBVYMYzmxwEEf6u85WGNg6Oy6n63mTXC8ihqk159gOOLu+fouyPBErYSo
	 MOvCnncdBXR9+jxvfSEDQd4RQe+Qj9mNX7f5i98Vy5+wZGHP+5GfEMt2nay3bNgAxR
	 cumybEVz5JVjm4oqoWX1js7d4thsEjisiEBCzUd8YCXo0xt40KDoy0lgVhuyr21jEc
	 1uAhUlgxHZOT2K3NiG44QzjlddtzAdlGPKJJ6RT510v/8L5RzbeLmZe+fHnfONxsWQ
	 c0vdL6Mm3knjA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50bc8b7d8ffso2760049e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:13:01 -0800 (PST)
X-Gm-Message-State: AOJu0YxxQsfK6mKI6CvYp+OU4ZgI2+1ZErrZgUb6EC15XWQlWtFMB+8w
	suRFLiA39V57VP8nBt1Jnf57a28Do6Kzxhj7GZM=
X-Google-Smtp-Source: AGHT+IG/XYHh2cJBBkJDq2uRPyyGL6EQog2miA5iTtB26waIAWHnxtYZlIEon5vG8bqn6mL+SSeQpQDbD8/3NsWeWZU=
X-Received: by 2002:ac2:562d:0:b0:50b:d74e:d498 with SMTP id
 b13-20020ac2562d000000b0050bd74ed498mr315124lff.95.1701421979984; Fri, 01 Dec
 2023 01:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
In-Reply-To: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Dec 2023 10:12:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
Message-ID: <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Justin Chen <justin.chen@broadcom.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <doug.berger@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 00:48, Justin Chen <justin.chen@broadcom.com> wrote:
>
> Hello,
>
> Ran into an odd bug that I am unsure what the solution is. Tested a few
> kernels versions and they all fail the same.
>
> FUNCTION_GRAPH_FP_TEST was enabled with 953f534a7ed6 ("ARM: ftrace:
> enable HAVE_FUNCTION_GRAPH_FP_TEST"). This test fails when
> UNWINDER_FRAME_POINTER is enabled. Enable function_graph tracer and you
> should see a failure similar to below.
>
> [   63.817239] ------------[ cut here ]------------
> [   63.822006] WARNING: CPU: 3 PID: 1185 at kernel/trace/fgraph.c:195
> ftrace_return_to_handler+0x228/0x374
> [   63.831645] Bad frame pointer: expected d1e0df40, received d1e0df48
> [   63.831645]   from func packet_setsockopt return to c0b558f4
> [   63.843801] Modules linked in: bdc udc_core
> [   63.848246] CPU: 3 PID: 1185 Comm: udhcpc Not tainted
> 6.1.53-0.1pre-gf0bc552d12f8 #33
> [   63.856209] Hardware name: Broadcom STB (Flattened Device Tree)
> [   63.862227] Backtrace:
> [   63.864761]  dump_backtrace from show_stack+0x20/0x24
> [   63.869982]  r7:c031cd8c r6:00000009 r5:00000013 r4:c11c7fac
> [   63.875736]  show_stack from dump_stack_lvl+0x48/0x54
> [   63.880929]  dump_stack_lvl from dump_stack+0x18/0x1c
> [   63.886111]  r5:000000c3 r4:c11bd92c
> [   63.889764]  dump_stack from __warn+0x88/0x130
> [   63.894339]  __warn from warn_slowpath_fmt+0x140/0x198
> [   63.899631]  r8:d1e0deac r7:c11bd958 r6:c031cd8c r5:c11bd92c r4:00000000
> [   63.906431]  warn_slowpath_fmt from ftrace_return_to_handler+0x228/0x374
> [   63.913294]  r8:c3a8d840 r7:00000002 r6:d1e0df48 r5:c2377a94 r4:c269a400
> [   63.920095]  ftrace_return_to_handler from return_to_handler+0xc/0x18
> [   63.926699]  r8:c0cd8ed0 r7:00000008 r6:c418c500 r5:00000004 r4:00000107
> [   63.933500]  __sys_setsockopt from return_to_handler+0x0/0x18
> [   63.939415]  r8:c02002bc r7:00000126 r6:00000003 r5:00000000 r4:00000004
> [   63.946217]  sys_setsockopt from return_to_handler+0x0/0x18
> [   63.952053] ---[ end trace 0000000000000000 ]---
>
> Sure enough the top of the parent stack is off by 8. (Tested with
> gcc6.3/gcc8.3/gcc12.3)
> 00006dcc <packet_setsockopt>:
>      6dcc:       e1a0c00d        mov     ip, sp
>      6dd0:       e24dd008        sub     sp, sp, #8 <======
>      6dd4:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
> fp, ip, lr, pc}
>      6dd8:       e24cb00c        sub     fp, ip, #12
>      6ddc:       e24dd06c        sub     sp, sp, #108    @ 0x6c
>      6de0:       e52de004        push    {lr}            @ (str lr, [sp,
> #-4]!)
>      6de4:       ebfffffe        bl      0 <__gnu_mcount_nc>
>
> I'm not quite sure why gcc is putting this extra 8 byte frame (maybe
> some optimization?), but it isn't being accounted for thus the
> FUNCTION_GRAPH_FP_TEST for arm fails. Note that only some functions do
> this. Function graph works with FUNCTION_GRAPH_FP_TEST disabled, so it
> looks the test is hitting false positives.
>

Thanks for the report.

It appears the sub instruction at 0x6dd0 correctly accounts for the
extra 8 bytes, so the frame pointer is valid. So it is our assumption
that there are no gaps between the stack frames is invalid.

Could you try the following change please?

--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -235,8 +235,12 @@
                return;

        if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER)) {
-               /* FP points one word below parent's top of stack */
-               frame_pointer += 4;
+               /*
+                * The top of stack of the parent is recorded in the stack
+                * frame at offset [fp, #-8].
+                */
+               get_kernel_nofault(frame_pointer,
+                                  (unsigned long *)(frame_pointer - 8));
        } else {
                struct stackframe frame = {
                        .fp = frame_pointer,
