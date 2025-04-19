Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B311465B4;
	Sat, 19 Apr 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061259; cv=none; b=j9qLdExdyJw9ZFzGI4WIC/QPyeRxeO6FcrguOhF49ZylszPa46JVquJ8GXms1RaCSvdL59SRoeORoD0Us7fxiGGCcfXNv+vlQ6Aneej8zuXM//YMWT+zC6+4TjRWIeITi+d9X/NuWd72UdYFskl2qokg67GiZLMS5k2UgaCY8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061259; c=relaxed/simple;
	bh=APWc4grnPuA6kcsjMvSMPXOhVagQmv1VtrP1a4NmFOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/PCseTFcOnUwh+CCjgeMEIqNCrWv/CMkN4s4tDdDrbpTdZSeGMhFLSVxQ7aC47RJ1QmCxZojbWaUnpMyIs0sND4q6UnLyGC9F8LY2Es0wkuD9604xtzgXp6nBbKer8OwiiFzCGJLhbtWltTzfqvi6In85vIW3niZkbaatite9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6+48xzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6+48xzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AA9C4CEED;
	Sat, 19 Apr 2025 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745061258;
	bh=APWc4grnPuA6kcsjMvSMPXOhVagQmv1VtrP1a4NmFOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6+48xzPBxS9tQTp55oCDih3fLT7Uzh+QubZ3dAoAgEG3NVEgoDU6ZrGxuwvzBzqr
	 veQvPDcvxip++K0KyH4xhF7gDBGFbQ2r4FKqtCNZh1DqUasydvaHk0zskRDb5wiRJX
	 nuOBb0dGORn8oWS0hai5ZHUhy/rPtCAZz68FfsHM4hXTmez8ANH7DshJa5n1Kw+Bug
	 UMD2BucwqFzKl/90mxruIZ7MsWDej2QiY1n3o1AHdrYFjueGJBUz44r66sT/MZ2mxR
	 7vPwDaD29cMVEGLjzDvbGvgX23U953+GpezVRb09h65fZXh+DLOkOYT7d3PlWN1Yd4
	 YLKlervkiJXnw==
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
Subject: [PATCH fixes v2 2/2] riscv: uprobes: Add missing fence.i after building the XOL buffer
Date: Sat, 19 Apr 2025 13:14:00 +0200
Message-ID: <20250419111402.1660267-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250419111402.1660267-1-bjorn@kernel.org>
References: <20250419111402.1660267-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The XOL (execute out-of-line) buffer is used to single-step the
replaced instruction(s) for uprobes. The RISC-V port was missing a
proper fence.i (i$ flushing) after constructing the XOL buffer, which
can result in incorrect execution of stale/broken instructions.

This was found running the BPF selftests "test_progs:
uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
uprobes tests randomly blew up.

Reviewed-by: Guo Ren <guoren@kernel.org>
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: Correct flush range (Samuel)
---
 arch/riscv/kernel/probes/uprobes.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..cc15f7ca6cc1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -167,6 +167,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long start = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -176,13 +177,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range(start, start + len);
 	kunmap_atomic(kaddr);
-
-	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
-	 */
-	flush_dcache_page(page);
 }
-- 
2.45.2

