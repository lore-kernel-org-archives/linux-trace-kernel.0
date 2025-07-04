Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4C3093D9;
	Fri,  4 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637031; cv=none; b=ELANgKl+/XdFARMfLY0Ef+BZaaHteXxkslZw6v/wV2sPCd99/bl6z7KHopJOAc6WhSFTT7/MehfxHM08HjvkWr/37k2gmIp79xfX7ELCjsmEzVk4xlcNUWzfVo4j+NamsDvZPS2IqHDVpWm1+xpEhHIsKJjhKNiad/mLOVDU7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637031; c=relaxed/simple;
	bh=SO2FNTrKQArpvSkS2JHAbwQoeech8iUoJBHVmLqUzb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2ykH0gx4Q6gsBZ9xZMY5kjKR4vjo3pE5MNEfsul27Fo41LeWedtp1AKX4Y3zDcvkeTIHZSc6T3tNaQYOsCRlo0oqH7nV23dPY6+MNX5VZ6zcnUsdqGD7yj7lRoH5ucJn+9P7pQ5CjGTTlF4FVpemVVav3eZwuV7lAzQ54HiCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHM1CWKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHM1CWKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF94DC4CEE3;
	Fri,  4 Jul 2025 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637030;
	bh=SO2FNTrKQArpvSkS2JHAbwQoeech8iUoJBHVmLqUzb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHM1CWKRIwGWZdUruYiyIKa0OUcRBfg3/yYHwoPDkppKqzNudoUVAbFLF/tRhKr0S
	 CaHDLw94VcjhEZXPkjkaNKBhLod6IRa8FAO3dyQmsIOXgqwY/Xt4jRLLQCtY3PiGvT
	 +stoNpdu2LMmJ485ccLCwoaFcWU2EFmdafhIThmRHqPi85Uo98iaE3bgWRw/rW/Kt4
	 ETSjNnyi+t6NIn+uKzrK0QblgxieZnPffy+mg6WdJwc4Kbd5ayK0nhOVyZ79vPgxdt
	 nZUQT9Gf/EDIu5E88uuIkxvOULPIUuYGOf0TCxcYW3e9DEO2I//MjRqMtLQQ9iV3E+
	 M/sEU5hEqCVqQ==
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
Subject: [PATCH 7/8] x86/kprobes: enable EXECMEM_ROX_CACHE for kprobes allocations
Date: Fri,  4 Jul 2025 16:49:42 +0300
Message-ID: <20250704134943.3524829-8-rppt@kernel.org>
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

