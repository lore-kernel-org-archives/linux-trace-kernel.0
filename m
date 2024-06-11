Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1817C21D;
	Tue, 11 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112641; cv=none; b=psd6Ik2iIl1InrNqvnZrL2F3eqbhiCqXJr9dNuonCBJHNm/YxEPIdJ8WI9Pgu/dbuP0+D1ErW8DsY/r38SLU86DK26sEsMh8A46dcHNygM+YZhWBnSN/DVZSRhY1ywXiwyBAezRW3I+TPKURW0sv3/VFzaV2zZFNYTTQnuvIVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112641; c=relaxed/simple;
	bh=ji4Ivs2ane44ktyLOzsBzzkIEC8flHJ4K9RLoZjnLnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gc76KqgTrFe+JjVUtxSMlV9fspoa8cGVdhddQ9NyQQAUd935DoOArFD0TDBaY46fVADzgInW7aW6XpXydQ5VQ89JY7gP4OtfNVFnY1+HxpvFMomii3lxw+dc7yA15J+J3jEQ4iGGrvKHSW9Bbm3MwDFM1vUS4UdBap6YiGCCrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX9G4aKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX9G4aKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AAC2BD10;
	Tue, 11 Jun 2024 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112641;
	bh=ji4Ivs2ane44ktyLOzsBzzkIEC8flHJ4K9RLoZjnLnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lX9G4aKjFEaykTYbb+vJiKQzM06QDEBijdm9RgA4W+Z7ymc9SryotOmw6X3MYwfKD
	 b68UAErcOCTIHz9Siml9q8LwCDnsecBR99W3ABiw65GU3IC9benlKX3OI7JKoWNI6R
	 DHxggzC35ZUZxj+YTv30GdPykyweGXmk7kvEGSlTQDwZKvdPhgPvhbaCLeVNU+SHMY
	 vugBOUWjjq/RthwS1eOdeOxZgF+IEVZhrndSGAxtpsBGKj94Xc0D3rYUXyeM8ETwA1
	 fdE/mQZ+EOyX4QfSpTLSy2sVH5bW7lsn7QkTWUw6Gq2YfdYWhE6AV+5QS1D50Y5kj2
	 b/Jqv3vGVZrXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3 1/3] tracing: Build event generation tests only as modules
Date: Tue, 11 Jun 2024 22:30:37 +0900
Message-Id: <171811263754.85078.5877446624311852525.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171811262833.85078.12421348187962271050.stgit@devnote2>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
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

The kprobes and synth event generation test modules add events and lock
(get a reference) those event file reference in module init function,
and unlock and delete it in module exit function. This is because those
are designed for playing as modules.

If we make those modules as built-in, those events are left locked in the
kernel, and never be removed. This causes kprobe event self-test failure
as below.

[   97.349708] ------------[ cut here ]------------
[   97.353453] WARNING: CPU: 3 PID: 1 at kernel/trace/trace_kprobe.c:2133 kprobe_trace_self_tests_init+0x3f1/0x480
[   97.357106] Modules linked in:
[   97.358488] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.9.0-g699646734ab5-dirty #14
[   97.361556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   97.363880] RIP: 0010:kprobe_trace_self_tests_init+0x3f1/0x480
[   97.365538] Code: a8 24 08 82 e9 ae fd ff ff 90 0f 0b 90 48 c7 c7 e5 aa 0b 82 e9 ee fc ff ff 90 0f 0b 90 48 c7 c7 2d 61 06 82 e9 8e fd ff ff 90 <0f> 0b 90 48 c7 c7 33 0b 0c 82 89 c6 e8 6e 03 1f ff 41 ff c7 e9 90
[   97.370429] RSP: 0000:ffffc90000013b50 EFLAGS: 00010286
[   97.371852] RAX: 00000000fffffff0 RBX: ffff888005919c00 RCX: 0000000000000000
[   97.373829] RDX: ffff888003f40000 RSI: ffffffff8236a598 RDI: ffff888003f40a68
[   97.375715] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   97.377675] R10: ffffffff811c9ae5 R11: ffffffff8120c4e0 R12: 0000000000000000
[   97.379591] R13: 0000000000000001 R14: 0000000000000015 R15: 0000000000000000
[   97.381536] FS:  0000000000000000(0000) GS:ffff88807dcc0000(0000) knlGS:0000000000000000
[   97.383813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.385449] CR2: 0000000000000000 CR3: 0000000002244000 CR4: 00000000000006b0
[   97.387347] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   97.389277] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   97.391196] Call Trace:
[   97.391967]  <TASK>
[   97.392647]  ? __warn+0xcc/0x180
[   97.393640]  ? kprobe_trace_self_tests_init+0x3f1/0x480
[   97.395181]  ? report_bug+0xbd/0x150
[   97.396234]  ? handle_bug+0x3e/0x60
[   97.397311]  ? exc_invalid_op+0x1a/0x50
[   97.398434]  ? asm_exc_invalid_op+0x1a/0x20
[   97.399652]  ? trace_kprobe_is_busy+0x20/0x20
[   97.400904]  ? tracing_reset_all_online_cpus+0x15/0x90
[   97.402304]  ? kprobe_trace_self_tests_init+0x3f1/0x480
[   97.403773]  ? init_kprobe_trace+0x50/0x50
[   97.404972]  do_one_initcall+0x112/0x240
[   97.406113]  do_initcall_level+0x95/0xb0
[   97.407286]  ? kernel_init+0x1a/0x1a0
[   97.408401]  do_initcalls+0x3f/0x70
[   97.409452]  kernel_init_freeable+0x16f/0x1e0
[   97.410662]  ? rest_init+0x1f0/0x1f0
[   97.411738]  kernel_init+0x1a/0x1a0
[   97.412788]  ret_from_fork+0x39/0x50
[   97.413817]  ? rest_init+0x1f0/0x1f0
[   97.414844]  ret_from_fork_asm+0x11/0x20
[   97.416285]  </TASK>
[   97.417134] irq event stamp: 13437323
[   97.418376] hardirqs last  enabled at (13437337): [<ffffffff8110bc0c>] console_unlock+0x11c/0x150
[   97.421285] hardirqs last disabled at (13437370): [<ffffffff8110bbf1>] console_unlock+0x101/0x150
[   97.423838] softirqs last  enabled at (13437366): [<ffffffff8108e17f>] handle_softirqs+0x23f/0x2a0
[   97.426450] softirqs last disabled at (13437393): [<ffffffff8108e346>] __irq_exit_rcu+0x66/0xd0
[   97.428850] ---[ end trace 0000000000000000 ]---

And also, since we can not cleanup dynamic_event file, ftracetest are
failed too.

To avoid these issues, build these tests only as modules.

Fixes: 9fe41efaca08 ("tracing: Add synth event generation test module")
Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 166ad5444eea..721c3b221048 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1136,7 +1136,7 @@ config PREEMPTIRQ_DELAY_TEST
 
 config SYNTH_EVENT_GEN_TEST
 	tristate "Test module for in-kernel synthetic event generation"
-	depends on SYNTH_EVENTS
+	depends on SYNTH_EVENTS && m
 	help
           This option creates a test module to check the base
           functionality of in-kernel synthetic event definition and
@@ -1149,7 +1149,7 @@ config SYNTH_EVENT_GEN_TEST
 
 config KPROBE_EVENT_GEN_TEST
 	tristate "Test module for in-kernel kprobe event generation"
-	depends on KPROBE_EVENTS
+	depends on KPROBE_EVENTS && m
 	help
           This option creates a test module to check the base
           functionality of in-kernel kprobe event definition.

