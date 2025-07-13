Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623321E22E6;
	Sun, 13 Jul 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391104; cv=none; b=QFnx6H6uXQuto9/9B0tzkCUhR+HlnQF8cgWsLfsiMm5jWjm1MwLUIKGKW7QUtuj7WIceuGsylxuZFDfVbMxuyCtfhJ5mCONKlmgHf9YAWs42DiqBQlPZzJCjf5ZRIiSPTHCZDQ0nv86h+Y6JKDQJw0B0T/6P5tBo/45Ltj4hvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391104; c=relaxed/simple;
	bh=9YZfDECqQGQ531UjogQBUu7pWagY+AKXs1wDqpr/qhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrZI3DUvY8of4T23rLfKtY4/gq3nYaEIS6V4RhIwQI7pgKHRef6SO0OfkilqQvIxMDo6LAURuNc8HIoCvVjLL879Jf1OffcJ+/tPfcgoX+Ijw8H0AZkeD92fPDParmXwwmJzK0nHBoeqgupzPMvXWljoITCyLpqU6z8YNE+d2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KamgB060; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KamgB060"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D6FC4CEF1;
	Sun, 13 Jul 2025 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752391103;
	bh=9YZfDECqQGQ531UjogQBUu7pWagY+AKXs1wDqpr/qhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KamgB060Bvsoix98TZWks50/I13lZhrhFcsv9XHufF9YHPir24VlIQe5VkT51CH4Z
	 AeUD3eAP+47gTJeIkA3ABhZ7bbzEsShNDKHcGpJPq55trM7HD7fWewlpUaw5bFpAzO
	 zT/Ld6lcfyFAOc4uWlHlzn1rHlCVB6vsTk6gxwhCu3dfSJHU2LYsHLfSBraWFIFaCr
	 xGRjaCyOt4iwAE7pLT/gIFx9WUkXhIZLigZNwfxL1nMdOC+N+2Qym6UAyA2UJcrsTf
	 xsdpneO8e3DVCZI9ht9+RQ2V63FSsOrr2amroBsSJKgkIU3wWO4ekDAQ2kUkCfpuA9
	 tAcv5E/0mTyJg==
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
Subject: [PATCH v3 7/8] x86/kprobes: enable EXECMEM_ROX_CACHE for kprobes allocations
Date: Sun, 13 Jul 2025 10:17:29 +0300
Message-ID: <20250713071730.4117334-8-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713071730.4117334-1-rppt@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

x86::alloc_insn_page() always allocates ROX memory.

Instead of overriding this method, add EXECMEM_KPROBES entry in
execmem_info with pgprot set to PAGE_KERNEL_ROX and  use ROX cache when
configuration and CPU features allow it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 18 ------------------
 arch/x86/mm/init.c             |  9 ++++++++-
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 47cb8eb138ba..6079d15dab8c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -481,24 +481,6 @@ static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
 	return len;
 }
 
-/* Make page to RO mode when allocate it */
-void *alloc_insn_page(void)
-{
-	void *page;
-
-	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
-	if (!page)
-		return NULL;
-
-	/*
-	 * TODO: Once additional kernel code protection mechanisms are set, ensure
-	 * that the page was not maliciously altered and it is still zeroed.
-	 */
-	set_memory_rox((unsigned long)page, 1);
-
-	return page;
-}
-
 /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
 
 static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dbc63f0d538f..442fafd8ff52 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1098,7 +1098,14 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.pgprot	= pgprot,
 				.alignment = MODULE_ALIGN,
 			},
-			[EXECMEM_KPROBES ... EXECMEM_BPF] = {
+			[EXECMEM_KPROBES] = {
+				.flags	= flags,
+				.start	= start,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL_ROX,
+				.alignment = MODULE_ALIGN,
+			},
+			[EXECMEM_FTRACE ... EXECMEM_BPF] = {
 				.flags	= EXECMEM_KASAN_SHADOW,
 				.start	= start,
 				.end	= MODULES_END,
-- 
2.47.2

