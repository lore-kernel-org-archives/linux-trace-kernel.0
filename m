Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D21465B4;
	Sat, 19 Apr 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061255; cv=none; b=rWWtZX80VSyJb69rFZwHaxvFP7vXbyLwOsuhH9Jam4GD+L82dpPPxd+In42mhjFDrd7Jf/ckNde8M3JAD0XEvFmY/85D9q8i8Y9OgpTscBiDideYwYD+pITO/bRahdVqGy3vifn0IV4arTeD/9M1qkYoQ6Hti+9onMVYY7TngnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061255; c=relaxed/simple;
	bh=segElHCdNM8ilr7pmILb8lXK5VF5TR88ipNEBHcLsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mEJHEmLwhxN5nuallqUUuB8UjOE54tjpjRogWD0QwLZq8yP8OPkwiY/IABBT/Sxn+5dYYy1Hcmg2NVEjcZT1fksZSAQrEKUF6UjrKUGtsTumBi1flWDXxAWNrz95fQ1lVuDP29LYiUNjqU3n3xDxCWzXD0E2SlUPOlgZ9BMcArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9I0MntS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9I0MntS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A0BC4CEE7;
	Sat, 19 Apr 2025 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745061254;
	bh=segElHCdNM8ilr7pmILb8lXK5VF5TR88ipNEBHcLsPc=;
	h=From:To:Cc:Subject:Date:From;
	b=p9I0MntSvW1uw/BeLSdDhPqUwYf/vaDyPZqOKL059Qh5TfLQcpVcr2zt5g6fsMogc
	 XPenoURL2fS3Z9oR5E6KDASQK4Sse4ycp5B42jRvE5uoUQ4pt66oBJMHV8xaqcggm1
	 jJgz6rsV6wlwGiuyfIXrcBgFc1F2jNclGv+A6XPAho4e5x8E93gvnh7O9ww2v17m3C
	 /zwWd6fjDfemXZoX/bET96HrOSIXfKPSGNitTUoLL46Z9fiAGgFGaYbblnUTMf7emb
	 6vxwVrHy6PJwcfqSCg4UuKjPI3dEjadY+h735liz2Q3Ii0bix/0dKTAh77pnDd/tPq
	 cWqForpJxz2Ow==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH fixes v2 1/2] riscv: Replace function-like macro by static inline function
Date: Sat, 19 Apr 2025 13:13:59 +0200
Message-ID: <20250419111402.1660267-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The flush_icache_range() function is implemented as a "function-like
macro with unused parameters", which can result in "unused variables"
warnings.

Replace the macro with a static inline function, as advised by
Documentation/process/coding-style.rst.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/cacheflush.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8de73f91bfa3..b59ffeb668d6 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -34,11 +34,6 @@ static inline void flush_dcache_page(struct page *page)
 	flush_dcache_folio(page_folio(page));
 }
 
-/*
- * RISC-V doesn't have an instruction to flush parts of the instruction cache,
- * so instead we just flush the whole thing.
- */
-#define flush_icache_range(start, end) flush_icache_all()
 #define flush_icache_user_page(vma, pg, addr, len)	\
 do {							\
 	if (vma->vm_flags & VM_EXEC)			\
@@ -78,6 +73,16 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+/*
+ * RISC-V doesn't have an instruction to flush parts of the instruction cache,
+ * so instead we just flush the whole thing.
+ */
+#define flush_icache_range flush_icache_range
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	flush_icache_all();
+}
+
 extern unsigned int riscv_cbom_block_size;
 extern unsigned int riscv_cboz_block_size;
 void riscv_init_cbo_blocksizes(void);

base-commit: 8560697b23dc2f405cb463af2b17256a9888129d
-- 
2.45.2

