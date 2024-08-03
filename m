Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E451E498
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Aug 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722690758; cv=none; b=icxDJ/6ftgqM/r/sR55UXwNSFmEhTXY8rkx0LQjB5pYTion7UrmBUl4Xkh5vgswG1iBHaBIQb9vSZ4crNqGnSjN3fkuczs2WNNl5piQWkvyG20I2WWrQKJIoiHADplqcLs6UJ8PWtH6XdbhEbttZoj6zI26wgpvpaiPbqv1ibqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722690758; c=relaxed/simple;
	bh=c96LVhp9JoyNASjS2Of8M/+OVK3/PNhYFiwsAMYrMys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmDznITwWQ1bw4RdbEVsIs9Jt0KRG/W5mlysMhMKIsxit5/62q+xnqZkOevqy4A2HSIUIKsT3uR4mRJziTBM348lI/zmr8t7FewDX2MJjMteQgSBWxJssxvOcc/eNm84m8advsynQ2MtoQo1c+mp8ppU97cULjSCs/pOUMPHvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dRBZsBl6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dRBZsBl6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so12345932a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Aug 2024 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722690753; x=1723295553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDljJdIC24Z3yYuFdP8r14kP7tULTXlmZnFQLBifNiE=;
        b=dRBZsBl6zT4bWqC/E+BoapO69QP+bfb/CBzitCMIp+JgegbkFXUDLCyP3jO+QQ/LzJ
         /q4YminDow2jnCJWHnEWkMU2mKSfCjuDw1PtsjnYX+DbwtqvM4o2DRbBW/pcLaKo0HXx
         m81q7/Ra1tUg44EgoFhgy1fUvqxbRX4kbHUCHSpURTrgqOZQ3jh+LYdpIiVTTEN9XLqR
         rAuJp/+hCMg9mo6CziSSXih/nEvw8VSVS5xmSGjIOUx8y2dvpBHSEsi7A/s2Np8oBYiH
         8mZYTamJqnISnAzzzH+LBoqBxR2qRiE/3N1a9RK51WBy3bXs2Srbkc/MI5wme8Fu5XI7
         Exsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722690753; x=1723295553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDljJdIC24Z3yYuFdP8r14kP7tULTXlmZnFQLBifNiE=;
        b=C0BwBeJUrCEklpTwAsdY+jhxCc9zbKS03bFKRjS+yUbGWzOyhCBoCzarfeVofrr8bj
         emKj4V5dgA5J7Rm9jZCse0ngFPWqILWivXjskE8RI+II3rcW9sir/jGjxyBHWkxDxNxt
         Wzj1LW9QI/hjA4sfVaWH66OCLMkFDxAfLGc2o7TeJJAk617IKOEGce0p21ocPyrcYEVi
         CzHdzZ5hg3wC2aWhpCL2dl/9IOvZ3QMWBDuPjh8Jxulsxz49/526RcyfvIDg4nFb9TEO
         sMnU/n7Ce0oEKKEZ4OyrPrrsvS8RVqi09vPtfnuaok0DgT6SyS80yB7/zy+J/7JZGjj+
         yG2w==
X-Forwarded-Encrypted: i=1; AJvYcCX963tKwFQ4RyE/nwbuVj6dgrAOctOoGZB28pqSGgG2MrAAm7wUyFaxNXF197K2SjO9Y4bX0A7Fg+rrxlVKg8s52ZU1zd1hwT1c/4/oMKaMBoCZ
X-Gm-Message-State: AOJu0YxZQ6sY5eQ+d3K0D6h51Z+onVRJ5OMwDYiuUPKmFlzLiJKKP2p0
	A+S8RcWYEOIm41mpfGT6d1ilVWC44GynzXE7SV1+hrtKedBJ3/WG44PkfeOoYWA=
X-Google-Smtp-Source: AGHT+IGYpMfOxPqwJ64RtyyFZ5kTgG9ih53dCridRJnZ+fb5aD/sopJg2iloIbgto3jRSRHoKbfkLw==
X-Received: by 2002:a50:9fa4:0:b0:5b9:3eaf:5be with SMTP id 4fb4d7f45d1cf-5b93eaf0766mr2320420a12.15.1722690752819;
        Sat, 03 Aug 2024 06:12:32 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83c32be67sm2326487a12.97.2024.08.03.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 06:12:32 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: mbenes@suse.cz,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] function_graph: Fix the ret_stack used by ftrace_graph_ret_addr()
Date: Sat,  3 Aug 2024 15:09:26 +0200
Message-ID: <20240803131211.17255-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ftrace_graph_ret_addr() is invoked to convert a found stack return
address to its original value, the function can end up producing the
following crash:

[   95.442712] BUG: kernel NULL pointer dereference, address: 0000000000000028
[   95.442720] #PF: supervisor read access in kernel mode
[   95.442724] #PF: error_code(0x0000) - not-present page
[   95.442727] PGD 0 P4D 0-
[   95.442731] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   95.442736] CPU: 1 UID: 0 PID: 2214 Comm: insmod Kdump: loaded Tainted: G           OE K    6.11.0-rc1-default #1 67c62a3b3720562f7e7db5f11c1fdb40b7a2857c
[   95.442747] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
[   95.442750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   95.442754] RIP: 0010:ftrace_graph_ret_addr+0x42/0xc0
[   95.442766] Code: [...]
[   95.442773] RSP: 0018:ffff979b80ff7718 EFLAGS: 00010006
[   95.442776] RAX: ffffffff8ca99b10 RBX: ffff979b80ff7760 RCX: ffff979b80167dc0
[   95.442780] RDX: ffffffff8ca99b10 RSI: ffff979b80ff7790 RDI: 0000000000000005
[   95.442783] RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
[   95.442786] R10: 0000000000000005 R11: 0000000000000000 R12: ffffffff8e9491e0
[   95.442790] R13: ffffffff8d6f70f0 R14: ffff979b80167da8 R15: ffff979b80167dc8
[   95.442793] FS:  00007fbf83895740(0000) GS:ffff8a0afdd00000(0000) knlGS:0000000000000000
[   95.442797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.442800] CR2: 0000000000000028 CR3: 0000000005070002 CR4: 0000000000370ef0
[   95.442806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   95.442809] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   95.442816] Call Trace:
[   95.442823]  <TASK>
[   95.442896]  unwind_next_frame+0x20d/0x830
[   95.442905]  arch_stack_walk_reliable+0x94/0xe0
[   95.442917]  stack_trace_save_tsk_reliable+0x7d/0xe0
[   95.442922]  klp_check_and_switch_task+0x55/0x1a0
[   95.442931]  task_call_func+0xd3/0xe0
[   95.442938]  klp_try_switch_task.part.5+0x37/0x150
[   95.442942]  klp_try_complete_transition+0x79/0x2d0
[   95.442947]  klp_enable_patch+0x4db/0x890
[   95.442960]  do_one_initcall+0x41/0x2e0
[   95.442968]  do_init_module+0x60/0x220
[   95.442975]  load_module+0x1ebf/0x1fb0
[   95.443004]  init_module_from_file+0x88/0xc0
[   95.443010]  idempotent_init_module+0x190/0x240
[   95.443015]  __x64_sys_finit_module+0x5b/0xc0
[   95.443019]  do_syscall_64+0x74/0x160
[   95.443232]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   95.443236] RIP: 0033:0x7fbf82f2c709
[   95.443241] Code: [...]
[   95.443247] RSP: 002b:00007fffd5ea3b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   95.443253] RAX: ffffffffffffffda RBX: 000056359c48e750 RCX: 00007fbf82f2c709
[   95.443257] RDX: 0000000000000000 RSI: 000056356ed4efc5 RDI: 0000000000000003
[   95.443260] RBP: 000056356ed4efc5 R08: 0000000000000000 R09: 00007fffd5ea3c10
[   95.443263] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[   95.443267] R13: 000056359c48e6f0 R14: 0000000000000000 R15: 0000000000000000
[   95.443272]  </TASK>
[   95.443274] Modules linked in: [...]
[   95.443385] Unloaded tainted modules: intel_uncore_frequency(E):1 isst_if_common(E):1 skx_edac(E):1
[   95.443414] CR2: 0000000000000028

The bug can be reproduced with kselftests:

 cd linux/tools/testing/selftests
 make TARGETS='ftrace livepatch'
 (cd ftrace; ./ftracetest test.d/ftrace/fgraph-filter.tc)
 (cd livepatch; ./test-livepatch.sh)

The problem is that ftrace_graph_ret_addr() is supposed to operate on the
ret_stack of a selected task but wrongly accesses the ret_stack of the
current task. Specifically, the above NULL dereference occurs when
task->curr_ret_stack is non-zero, but current->ret_stack is NULL.

Correct ftrace_graph_ret_addr() to work with the right ret_stack.

Reported-by: Miroslav Benes <mbenes@suse.cz>
Fixes: 7aa1eaef9f42 ("function_graph: Allow multiple users to attach to function graph")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index fc205ad167a9..d1d5ea2d0a1b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -902,7 +902,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 	i = *idx ? : task->curr_ret_stack;
 	while (i > 0) {
-		ret_stack = get_ret_stack(current, i, &i);
+		ret_stack = get_ret_stack(task, i, &i);
 		if (!ret_stack)
 			break;
 		/*

base-commit: 17712b7ea0756799635ba159cc773082230ed028
-- 
2.43.0

