Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE513093DD;
	Fri,  4 Jul 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637037; cv=none; b=Fl06bo51Ru7ALO8rA2GFnInHBkskmnqDa7YRn08yz4PIBLxLl75yYilth/Elcc9rvTtgPFVxTXCT1/iPpC3rLjJcUQbSp3MNXjoF3RCS/E2mzH+edMClqMXoVwLpOrEEYrid0h6VcIGrQdDGLpc+tU9ojJ9UOpB9HhsJ4bt6/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637037; c=relaxed/simple;
	bh=N93fx/HWGQ9/7LBI0Q5dx377OnCZ8CrZ/OhiD9v/Z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY6Nba9gmq/LFHKeOVjC5qwxO/c+rf+4nTTckwPVGCnTKOLZLkau3XIWYuRQZroS2zC6s42tFt8PoGmLzuvMvbxESJz7P/RMwGiRpBU9S8MSh+7uRyIXTuIpG4ODc9ucun/LAguDlD3jaBXXr+WO3NgxQVMW2TKp0Eqb4o5K01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IafJ5zhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IafJ5zhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F3C4CEEB;
	Fri,  4 Jul 2025 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637036;
	bh=N93fx/HWGQ9/7LBI0Q5dx377OnCZ8CrZ/OhiD9v/Z/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IafJ5zhzJJMzQ5RvGFz9jHElZlpQS/cEpbHiJxGptp5RZk2uaNXSUmlxru9vxG0Kb
	 my6sw81V2pUOKJO1VNXbXkyX54FcpSGrYkNlcQ/zC2JzREUevQHixwULxSwoZP/0Ao
	 L57ARhp2EwtWbNo4JI2cnYce4L0oAVLtG4KnJPruYzna/Ruxpq+TTi3Xed2SikeQCx
	 G0QZsiDA0BAqUNC0WiLG5StfJgJ7NHGRRJSNizFGe+xDAEuQrswFi0JvogCPgcbwwV
	 53cCDyXsz+5McRnjUaaNiAgEigDmHz7JsdAkKoJqHfzCVV1vqibVOyCx3Q6UJM33Dm
	 j1LzYJybqnstw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 8/8] x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations
Date: Fri,  4 Jul 2025 16:49:43 +0300
Message-ID: <20250704134943.3524829-9-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704134943.3524829-1-rppt@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
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

