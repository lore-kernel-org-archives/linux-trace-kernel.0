Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D02DFA39;
	Wed,  9 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069031; cv=none; b=NsUdLYoG2j6k+5RNLND9f8IZGi3+bVnqfDn1dkg6u19bpz+FYkuv3nN6sU8bE4LLfMHUtvAUhlmtGzBT73TsWKAYjGZd/v4RaHwqPEW6u4oGfjPzRU5H74aXzxY0UK5esw71bspEBcJICVxubU3U58BcRC5+D0fpunp77cbvTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069031; c=relaxed/simple;
	bh=N93fx/HWGQ9/7LBI0Q5dx377OnCZ8CrZ/OhiD9v/Z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrlEDxYnn+0hrkxHutY8QWedbJtYI/XF/S4dvnVtFuZH2zVgXhdjdYRxjANc5gmPD0li+EeAfZo14kjOgv4AAkBP/7ksFUMRC9/nvVdJT7/T45OjXLaWpuBP2Hj607pfzolD4JkeLf1ZicYVXsVzDsfr3eM5IqufRLl0Th5W3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trlDt64N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trlDt64N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C52C4CEF1;
	Wed,  9 Jul 2025 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069031;
	bh=N93fx/HWGQ9/7LBI0Q5dx377OnCZ8CrZ/OhiD9v/Z/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trlDt64NjQr+YNI3YqHEnv8JUfRpoVlxLzQ/crT9viR4cVybY711yJ93jqAp8di1r
	 4ZnpoAlyw6iExKdqKuy6yItzaWCvmRURcnmZmz3E50KG1GeHIvoZYn/P1QLqb2tcT0
	 cURqdVH3el7dcyxuJ5ThweDaFxa+HNBfnY4351EyKawHIpbmZEEP/XZvM7wWf+4R8i
	 VPYsSyZiuU0050BIqiaeeE0xywTbJbJhD3aOv0l4iGMFrPZ7arogY31V7FBlNqmsGx
	 T2DjoS9fr0aqMNeafd/Rg9OkMwU4+KLfFx8b1dEl6oiYW5gH3ATdab8I/QR5+raALt
	 5PuN3SQtLb2ww==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 8/8] x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations
Date: Wed,  9 Jul 2025 16:49:33 +0300
Message-ID: <20250709134933.3848895-9-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

For the most part ftrace uses text poking and can handle ROX memory.
The only place that requires writable memory is create_trampoline() that
updates the allocated memory and in the end makes it ROX.

Use execmem_alloc_rw() in x86::ftrace::alloc_tramp() and enable ROX cache
for EXECMEM_FTRACE when configuration and CPU features allow that.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/ftrace.c | 2 +-
 arch/x86/mm/init.c       | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 252e82bcfd2f..4450acec9390 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -263,7 +263,7 @@ void arch_ftrace_update_code(int command)
 
 static inline void *alloc_tramp(unsigned long size)
 {
-	return execmem_alloc(EXECMEM_FTRACE, size);
+	return execmem_alloc_rw(EXECMEM_FTRACE, size);
 }
 static inline void tramp_free(void *tramp)
 {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 442fafd8ff52..bb57e93b4caf 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1105,7 +1105,14 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.pgprot	= PAGE_KERNEL_ROX,
 				.alignment = MODULE_ALIGN,
 			},
-			[EXECMEM_FTRACE ... EXECMEM_BPF] = {
+			[EXECMEM_FTRACE] = {
+				.flags	= flags,
+				.start	= start,
+				.end	= MODULES_END,
+				.pgprot	= pgprot,
+				.alignment = MODULE_ALIGN,
+			},
+			[EXECMEM_BPF] = {
 				.flags	= EXECMEM_KASAN_SHADOW,
 				.start	= start,
 				.end	= MODULES_END,
-- 
2.47.2

