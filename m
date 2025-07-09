Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95272E62C8;
	Wed,  9 Jul 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069026; cv=none; b=le6AgbodGDjC21V07lHtfN/bpbm/mkESK7adn/Io7WjmGeyjUlZ7WufmTpWkJ+H5FHvYfnOwyb/WPlpgpwvCwkR8WT7ONWp2At9uD4BpZ2oI5+el3f0nGSLSy0NBZMSYNjWw5eLEkzg0G9YcqGCxCWkZL+kg9q7W+qVRPxE2d+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069026; c=relaxed/simple;
	bh=SO2FNTrKQArpvSkS2JHAbwQoeech8iUoJBHVmLqUzb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PakLiby5U8d2D9zjkVKxchjeqsj6Xvh396znaY/tukgi748Lhy4Z4rFmLAr2bWCcxasHlTZ/B3dc8+oetgz8FKDOoKNb1lNo73sbkGiL5d05R/VqKoA7s0SBTfjMOARvHyYbED/XTRAwE3dSh7YiLS+pMxYMrakb53DEk1v9KK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqq9DIDz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqq9DIDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1BAC4CEEF;
	Wed,  9 Jul 2025 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069025;
	bh=SO2FNTrKQArpvSkS2JHAbwQoeech8iUoJBHVmLqUzb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uqq9DIDz+u5Gldw6wG7ZfI5XM1w4kUYiculSQ3INMiGyieKvwEh9cIXiCTgI9TFDS
	 UfWy69dNPRBBsnLd/CEh8u5VjaJEPnEK8ftNLes5Kn6TWBQDVTU7Sdvo/1V8uU84QD
	 822WJtfCeFCn3SoVBSeTfWifNHrMd1COtMCVrvhtjfV+uLISYf+v38Q1SDEjtl8Bns
	 ZCZAjH6aI+3GjNS8w2eOH4HjgL4Lc11IigT2vA2/c13/GNHT/Al6w1vfeI4T7iKCpL
	 u36mcswSdiJU1B9TcboHT9zTshz5jGq/VQsYRs/rTTJrLioExSmdcdKcfJAE2LztRJ
	 dTcf4vXe7ZEdA==
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
Subject: [PATCH v2 7/8] x86/kprobes: enable EXECMEM_ROX_CACHE for kprobes allocations
Date: Wed,  9 Jul 2025 16:49:32 +0300
Message-ID: <20250709134933.3848895-8-rppt@kernel.org>
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

x86::alloc_insn_page() always allocates ROX memory.

Instead of overriding this method, add EXECMEM_KPROBES entry in
execmem_info with pgprot set to PAGE_KERNEL_ROX and  use ROX cache when
configuration and CPU features allow it.

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

