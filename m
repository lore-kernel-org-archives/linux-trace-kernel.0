Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445723EA94
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991216; cv=none; b=Pbmhirr9Jt9I1LsAg+2LATWql4h0PeDXEuXAt8fYUhqAMSipVF9fMU9ZvsBhwfSQwofmLpA8EmT+mS1z7k/RXMD8Les9HHfBLpUHY5H77g/8aHMZXw2eM/qumaK+a23cMpmY6Rq8kvXOsrtWbfh57s4vWubVNlapz8KlIOWDw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991216; c=relaxed/simple;
	bh=z9C3BJPkAeYT5N4zbegd7qbIDCHNspObjWmKPJz27pM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSga+3+GssQcz4XM2dYer0wDVfVLx8qa2q3qjbfUx0D4JUCOn+HuKewDlZNH6QihYdasabHsBRLAmaLRhK+Celma5kWkDdISMDZd7gKsSAk2XubruofcF5QyQLGIk9+OTaJB3g+E8Wo7VYbk6lQriN+qhgpvZa2I+sk8pvf+MEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNgpQ6KO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNgpQ6KO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-474560436c3so1563649f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782991212; x=1783596012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CiSMYxAAfWXzLBsuDt0wts0qfpoADcn2DxU3hQuJc2s=;
        b=FNgpQ6KOyfmnpg/Ovf5CgVA7nldMPD48zdnqJQtEou/v2p8/XSUIkK7WIrYFsGsvuo
         8VbRajV9xZScH+YZufhGJTz8ggRblK36rW5TCF5aV3p8yyQGy6eflWAVsyJcMXPXwxRw
         GHdTHkpqRwxrfOZBH8Kcd/Gvi9KhnW1lngbaZXGCSR1cirQaOw52RZBkGfiDI+A1bR76
         zrhhCu+maLtCwuEvDmlTnOgkmbmyzCE/N8BBbkpEpzaDf/4L58pkWlaM5a7eZGTkaxNh
         eJYyiidSfnfkG89eIW7CpdFh8Fd0kVmVgh3RAbm7q+IWR+pi3zg+X3l9T20tW9U3FOgH
         30Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782991212; x=1783596012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiSMYxAAfWXzLBsuDt0wts0qfpoADcn2DxU3hQuJc2s=;
        b=VPVZyjCp3SL/HQLUeFtJR90NhJoc4MqW6uaTCQ4ibsprsIqI4BAQ8TwtQ85Itpq7W7
         gv6t29i+lbKuSQUVolSYNib+RvMPvNumG1Cesb3nw7zRAQop91StczEvf4Z1B/bSx12y
         9nz09bvvLKlr/zM3t0g6Qj4tEMkU3OtqKGGzqigl/dOUieK9TLj60el5g5z9Y1g58C/W
         WotSyJFYDBBzoayRCRDZNyTJKMoM80BPnfmzdX1/Z43bUhD3+iW2zypDCSIo9p0/SUTv
         RxMhk/zWxglCK26Yc3XPD4XkWog/1xTrn2WsKcFLdUThqhI5Px+L1ejXQdha/hlheVem
         AnNQ==
X-Forwarded-Encrypted: i=1; AHgh+RphUFYpKmDxxp9KeO4zwYja5/7hqfG8aKKjFUNJ7tKXKb12CltC2zZl4Zl2CBRGbvkvo9hdMVR2IK0mcY2GvTIBD9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaKUtuTOqRHo2H6S68lM5CaJ45M7ALpP3wwK1upOlYjPG0Zyy
	vrHZx9FmKFb5N6hxj+oC+2Pr0CQKo2JOw+dEbOV2fUxDb7I7U7PoYIhY
X-Gm-Gg: AfdE7cncL5hF8cBmf2D38YZWKzYEGuAvt6FaPFHNP5v3+MNeXsn5z6KzTg6DeTF8JXK
	4DTymSFI2SUim8K9YcxEDZXco5F/oCOWiEBY2hGioxafmJmNq+7nAsd6NgB9aA7nKJ68u7dAWPs
	fVkeRk8XBvB2DRboNC9QchNyVjnQsosiPL2JIHbfykZWmB5kJUOTLPrbGi1P1SlPFahLnkPvU93
	uZM/GGXfbBwjQ4RmXm9cRDblDZ/lWAovmN0DvoZ5b0gQaiuvNHLBzcz7vRt5imfzjuWjz5k0w6z
	uXBibT59P8yU/OXaXqxrf5W/172h1vytUZaYebq5XIh/qSGdPlV0erLBXsBihzxbGWvSUSEM409
	ab8Ku2nX5mEcelPu5EUa9tDMn8cTFWAies4VXMecPVkPiuxYYrEBuLuVQaQC0DRyfR/NM1dyVo4
	/bSA5stDFLtMIG8mTzfj01xrUv
X-Received: by 2002:a05:6000:468c:b0:474:3b78:b229 with SMTP id ffacd0b85a97d-477aeb5c73bmr4793677f8f.11.1782991211989;
        Thu, 02 Jul 2026 04:20:11 -0700 (PDT)
Received: from krava (37-188-223-191.red.o2.cz. [37.188.223.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd0b1sm7943059f8f.35.2026.07.02.04.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:20:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Jul 2026 13:20:06 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <akZJZth3-fVUhADl@krava>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>

On Wed, Jul 01, 2026 at 04:13:26PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 1, 2026 at 4:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> >
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call.
> >
> > Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
> > if we decide to take this change.
> >
> > thanks,
> > jirka
> >
> >
> > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
> > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
> > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/
> > v4: https://lore.kernel.org/bpf/20260526205840.173790-1-jolsa@kernel.org/
> >
> > v5 changes:
> > - several selftests changes and reviewed-by tags [Jakub]
> > - add more comments in int3_update_unoptimize [Andrii]
> > - several other minor changes and acks [Oleg]
> > - move insn_decode out of uprobe_init_insn to simplify the code
> > - align uprobe_red_zone_test to 64 to make sure nop10 is not on page boundary
> >
> > v4 changes:
> > - do not use 2nd int3 (ont +5 offset) because the call instruction
> >   is allways the same for the given nop10 address [Andrii/Peter]
> > - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> > - small change to patch#2 moved user_64bit_mode earlier in the path
> >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> >   instead of gettting current->mm
> >   Andrii, keeping your ack, please shout otherwise
> >
> > v3 changes:
> > - use nop10 update suggested by Peter in [2]
> > - remove struct uprobe_trampoline object, use vma objects directly instead
> > - selftests fixes [sashiko]
> > - ack from Andrii
> >
> > v2 changes:
> > - several selftest fixes [sashiko]
> > - consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitnicki]
> > - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> > - added fork/clone tests
> > - I kept the selftest changes and nop5->nop10 changes in separate
> >   commits for easier review, we can squash them later if we want to keep
> >   bisect working properly
> >
> >
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> > ---
> 
> ASAN-enabled test_progs runs are not happy in CI, can you please check?

I failed to release link in test_uprobe_fork_optimized, fix is below
I can send new version or separate fix 


also there's 2 things to solve/discuss once kernel changes are acked:
- selftest changes depend on:
  selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
  that is taken from libbpf/usdt, I pushed the PR in here [1]

- as bots complained the patchset breaks bisection, because kernel
  changes break selftests.. not sure what's prefered solution, as for
  me I'd keep it that way rather than mixing kernel/user space changes

thanks,
jirka


[1] https://github.com/libbpf/usdt/pull/16
---
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index eb067f029a9f..e193206fc5d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -988,7 +988,6 @@ static noreturn int child_func(void *arg)
 static void test_uprobe_fork_optimized(bool clone_vm)
 {
 	struct uprobe_syscall_executed *skel = NULL;
-	struct bpf_link *link = NULL;
 	unsigned long offset;
 	int pid, status, err;
 	char stack[65535];
@@ -1001,9 +1000,9 @@ static void test_uprobe_fork_optimized(bool clone_vm)
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		goto cleanup;
 
-	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
-				-1, "/proc/self/exe", offset, NULL);
-	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
+	skel->links.test_uprobe = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					-1, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_uprobe, "attach_uprobe"))
 		goto cleanup;
 
 	skel->bss->pid = getpid();
