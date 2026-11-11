Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406406;
	b=Dy2I/j1Dbqdp42riRO/izfVmAkjSDyLICQeQi5BlNIC4T93fkwuNtQX62xyfScyWL7hv
	 40h4f1Js+FchD7ycRqLUwYctfwMZ1lp7W56xtA03qRZ701+3gmMNg/Fd8zvL8o4fZmHJh
	 nZXVUD1N6mC5+3/Khf3XumR6mPPdfEueCfLWBTW4k2GbZEEdZQ/F2TwRxDde8BqpfO3Gj
	 w3EjJD8fTqyh6t/vkD2yDFlTAI28y6xPoTkEf75aRFclC0bC/8akL96upg8DfGghDvTFX
	 mCRr8W58LAzI95kSjCDYh30sa6dJ+G+BJaSyR0xQREdqwesko5m6vnFHcsjvw66jbKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8GszRvtDCIS+dACxvFTN/06742InM9DLs/UoBhNugMI=;
	b=KhIuSCUmF0zA1QcIVSJ866lR8ZDweFmQhDLpptPNQvHdbHY7OR/mogWOvsH9HkDUZeHz
	 OqaxvxdNZmtxk+4PzIwAEy6qEmBlSMRezgEiBR51UxaUZxVJsQjDjodmR6WJOL5mw3hC5
	 hBPQbnS9yR5F+GogcbPJ9h8hEqe0++i7ITIQI1Qpx4fkAzrqASDg4N2rWjGsNkC0213U8
	 qdqs0u2iq0HXSXZX3hT+YK24sesNu1L+6cooUfNWKRsquNPBnybCUajgztzSMyS1dnS8W
	 Dc6bLoP/6vW0iSCX5Hg4KLQzpnx1LEwOT8be7VPhyuSHBprHtkx8+KZt6G5hUf+zKzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWr9LXUv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDF606A32D;
	Wed, 11 Nov 2026 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWr9LXUv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF01F00A05;
	Wed, 11 Nov 2026 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406405;
	bh=8GszRvtDCIS+dACxvFTN/06742InM9DLs/UoBhNugMI=;
	h=From:To:Cc:Subject:Date;
	b=OWr9LXUvt2J/w/ekfVPKHjVHxbYC5cHEefnv2bXNcfuBnnfwlJR7u3O4Mz4AJixY4
	 RZdYKfZwxsjfHKbVU3rzDmJFksqIYUPRZgLdFp2NrWvpe6QMjsIW5NGMyKZJFbTIhJ
	 Jv6h8NdzB8l28fe0Vp2zI08Awn3c0gi93sPlGnJ4hpE0a+zEY3qJ1rrm4iq0to6Lvd
	 CBcg3piEKko5MekbX94ZkwGc76ts0i0A4WGdZu96aQRGQNs7zsxewRHRz2JosTPfu8
	 pCFltrMd7YJyAXNmGXnBdnyEBs1rcz8iLM7YIbHBTZF8LZDwSioNuj7Jx90Dg8hq3c
	 /JI9yLip6L7Rg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 0/5] kprobes: Fixes for ftrace ops and optprobe state machine
Date: Wed, 11 Nov 2026 23:13:21 +0900
Message-ID: <179440640176.328088.17106877243326801914.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is v3 of the remaining bug fixes for kprobes and optprobes.
The previous version is here:

  https://lore.kernel.org/all/179427358690.291326.2078291446658598883.stgit@devnote2/

This version restores __arm_kprobe() fix as patch 3, and update the KUnit
test code to check it.
This includes following fixes.

1. Ftrace Ops Switching for Post-Handlers (Patch 1):
   - When adding a second probe with a post_handler to an existing ftrace
     kprobe, the aggregate probe's post_handler was set but remained armed
     on kprobe_ftrace_ops. Subsequent disarming attempted to disarm from
     kprobe_ipmodify_ops, failing with -ENOENT and leaking the armed probe.
     Switch ftrace ops safely in register_aggr_kprobe() outside of
     text_mutex and cpus_read_lock.

2. Optprobe State Machine & Tasks RCU Quiescence (Patches 2-4):
   - Forcibly unoptimized probes (unoptimize_kprobe(force = true)) were
     not queued to cooling_list, causing kprobe_disarmed() to return true
     prematurely and risking use-after-free in the optinsn detour buffer
     before Tasks RCU completed.
   - When re-arming a probe that is queued on unoptimizing_list before the
     optimizer thread runs, skip arch_arm_kprobe() in __arm_kprobe() so
     the active jump instruction is not overwritten with a breakpoint.
   - When a disabled cooling probe finishes cooling and transitions to
     safely disarmed in optprobe_finalize_generation(), re-optimize any
     blocked sibling probe whose jump range covers its address.

3. KUnit Regression Tests (Patch 5):
   - Add KUnit test cases to lib/tests/test_kprobes.c covering the recent
     kprobes, kretprobes, ftrace ops, and optprobe fixes.

Changes in v3:
[03/05]
 - Restore the __arm_kprobe() fix that was accidentally dropped in v2
   while omitting the reuse_unused_kprobe() hunk superseded by commit
   1ffd6efb1b58 ("kprobes: Arm reused optprobe on cooling list").
[05/05]
 - Check that the jump opcode at *opt_kp.addr is preserved across
   disable_kprobe() and enable_kprobe() in
   test_optprobe_rearm_unoptimizing().

Thank you,

---
base-commit: 1ffd6efb1b58e596ed70f660182803264a4c84d9

Masami Hiramatsu (Google) (5):
      kprobes: Switch ftrace ops when adding probe with post_handler
      kprobes: Fix UAF and queue cooling probes on forced unoptimization
      kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe
      kprobes: Re-optimize blocked sibling probe when cooling finishes
      kprobes: Add KUnit test cases for kprobes regressions


 kernel/kprobes.c         |  116 +++++++++++++++++++++++++++-----------
 lib/tests/test_kprobes.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 35 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
