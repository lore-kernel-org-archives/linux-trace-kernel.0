Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D80158A09;
	Tue, 10 Jun 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566872; cv=none; b=HxMA2ohRAsvgD4Pr5hqqeozFWJEeGuCJWnryhPUZYqyh23xFgMAmNRZn7Oc0Vc+cb4YuWUGSY06kjiGkfsmW5J99F6nJivQ3r/3W5Lv2hrK5fxsrCRGKuEThD9EAVsVPhQDJYvoSfxvA3tWErxzuhDpqKv4DO9WEFy4HpuZ4Db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566872; c=relaxed/simple;
	bh=PVyF3hdiNwt8SuMYpG8gWwjKQiPQ/7vnfrd2yGzwLIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is6xJmXZBT4mfom8UI6UV95lDlD/E3kcWAHIkE/+cV0WOfC4hKaXMqsTWNAOQAzNXECmmnNs9dGIbPcGtmNX3/Z/2cA3SDXSU2J2uASXIYN7ol6hh5dflf+Z2Y/LR59Jke5JWQzUapBhaXa5Ft6pxDyjgGmwr3CTDiB02hz6Hvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXv5ynaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXv5ynaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCFCC4CEED;
	Tue, 10 Jun 2025 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566871;
	bh=PVyF3hdiNwt8SuMYpG8gWwjKQiPQ/7vnfrd2yGzwLIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXv5ynaq+E/VDB7tRpKB/aVTFjUcncqVeDnOTYxUUwgc7qjCYfV5E6LtJuUHHZ54c
	 X8bh9KgDFabfGiaP8sDTdAqArFTJr6juInrDboRJvVbc8dwjb2KFIlXCQPyVrNcH08
	 3JvWsiyC9Xm+mNz23GH4w61fLwI7VOemj8ittb9de2Rs5TDdbDc0GhXXUP4Lr15BK5
	 MU8s1GU/mIunCTghwr0Zl4WAnLpuoiCi4hoyxpK/7fzZ/5TPzJY+dw91fI7VJU/99x
	 8bt6W9PStF1H+fyqFSfn68lyNufSkuJNbU3xrLJ2Yt+H5l+dMKkf3ajFhISZANAuNh
	 tNcxQSc84m40g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for updated instructions
Date: Tue, 10 Jun 2025 23:47:48 +0900
Message-ID:  <174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
In-Reply-To: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
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

Invalidate the cache after replacing INT3 with the new instruction.
This will prevent the other CPUs seeing the removed INT3 in their
cache after serializing the pipeline.

LKFT reported an oops by INT3 but there is no INT3 shown in the
dumped code. This means the INT3 is removed after the CPU hits
INT3.

 ## Test log
 ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
 starting test ftrace-stress-test (ftrace_stress_test.sh 90)
 <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
 <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
 6.15.0-next-20250605 #1 PREEMPT(voluntary)
 <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
 <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
 12 e4 fe

Maybe one possible scenario is to hit the int3 after the third step
somehow (on I-cache).

------
<CPU0>					<CPU1>
					Start smp_text_poke_batch_finish().
					Start the third step. (remove INT3)
					on_each_cpu(do_sync_core)
do_sync_core(do SERIALIZE)
					Finish the third step.
Hit INT3 (from I-cache)
					Clear text_poke_array_refs[cpu0]
Start smp_text_poke_int3_handler()
Failed to get text_poke_array_refs[cpu0]
Oops: int3
------

SERIALIZE instruction flashes pipeline, thus the processor needs
to reload the instruction. But it is not ensured to reload it from
memory because SERIALIZE does not invalidate the cache.

To prevent reloading replaced INT3, we need to invalidate the cache
(flush TLB) in the third step, before the do_sync_core().

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/alternative.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..1b606db48017 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2949,8 +2949,16 @@ void smp_text_poke_batch_finish(void)
 		do_sync++;
 	}
 
-	if (do_sync)
+	if (do_sync) {
+		/*
+		 * Flush the instructions on the cache, then serialize the
+		 * pipeline of each CPU.
+		 */
+		flush_tlb_kernel_range((unsigned long)text_poke_addr(&text_poke_array.vec[0]),
+				       (unsigned long)text_poke_addr(text_poke_array.vec +
+								text_poke_array.nr_entries - 1));
 		smp_text_poke_sync_each_cpu();
+	}
 
 	/*
 	 * Remove and wait for refs to be zero.

