Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BD17993;
	Wed,  3 Dec 2025 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739482; cv=none; b=Qt9WMIZ/uzf78t6K9V6Rl4veXq/5x0Q/i7oerTV+V8J2Cyn0rpFJzIJgRN8FRyUS2h08YR4a3ntduCzzgKjxx/gZEouDI2aJ7ivPufJNdjmmI6J0T3nCKR3pY/XoHkWpxOI83InhAZDkPUyLEJTYd6BvSvufOikLZsFUfHzpiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739482; c=relaxed/simple;
	bh=nJiZ3Qqf40KuEWclLSX+VL52AtJ1jcdwMzXuwvKwKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EshkUzXF/HpB1t8E4j+kmf7XGXpx5Lgr33sXUi0P2gJq4f94kMOzL7FB70m/T+sSdK31rkacasJ0+bTr+PvsTO/uuOZbzPgJd9pCr5wMXPvUEpWE1fD+xKN51EX8dFq5oova/nBjV+1z19iAuJ3rmCsZmgSG/k5dd2grVfcIXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JraMUPoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JraMUPoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F86CC4CEFB;
	Wed,  3 Dec 2025 05:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764739482;
	bh=nJiZ3Qqf40KuEWclLSX+VL52AtJ1jcdwMzXuwvKwKvI=;
	h=From:To:Cc:Subject:Date:From;
	b=JraMUPoPD209tfhdFDnqz3rFDnMTVB0xV1iBPh0O04QMazopBdE8av58hOHBnH2R5
	 MaB50Vm1dLBOsxRiEvEF2EvDCGQQ5Ksx4Y7TSTGFK11pNn+tyGLzLwsdQEjuPLxSWv
	 sMsXezy+/WNBPvVTHPF8I10iqxndnFu0DgxlNhg6AJY6U2a0GAu+tfrBoOXUst3c4n
	 0mqr2mkSpg5Zk376/IV3XM4y/p9XTYy7CUO3Q2+lJGJEA7TimblynvbnKXzGN47DFd
	 qn+S01nq0ZNxaQB0Or29SkDs2eS47n00sY3G0gYiuLCHlCfizbbEhG1/m/gFMn3DPp
	 Ezuq4ec2R031Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Ye Bin <yebin@huaweicloud.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	yebin10@huawei.com
Subject: [PATCH] kprobes: avoid crash when rmmod/insmod after ftrace killed
Date: Wed,  3 Dec 2025 14:24:35 +0900
Message-ID:  <176473947565.1727781.13110060700668331950.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

After we hit ftrace is killed by some errors, the kernel crash if
we remove modules in which kprobe probes.

BUG: unable to handle page fault for address: fffffbfff805000d
PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
RIP: 0010:kprobes_module_callback+0x89/0x790
RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 notifier_call_chain+0xc6/0x280
 blocking_notifier_call_chain+0x60/0x90
 __do_sys_delete_module.constprop.0+0x32a/0x4e0
 do_syscall_64+0x5d/0xfa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is because the kprobe on ftrace does not correctly handles
the kprobe_ftrace_disabled flag set by ftrace_kill().

To prevent this error, check kprobe_ftrace_disabled in
__disarm_kprobe_ftrace() and skip all ftrace related operations.

Reported-by: Ye Bin <yebin10@huawei.com>
Closes: https://lore.kernel.org/all/20251125020536.2484381-1-yebin@huaweicloud.com/
Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..17d451553389 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1104,6 +1104,10 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
+	if (unlikely(kprobe_ftrace_disabled)) {
+		/* Now ftrace is disabled forever, disarm is already done. */
+		return 0;
+	}
 
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);

