Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D1DE889;
	Thu, 17 Apr 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876205; cv=none; b=NRnS/De/1aQvAfUhbtodYnWYawKQYzh8D8L3ePcsg08vteZ2Uk0yRVWhI9iQQEzMAAmrPKZOvnd24WvVuZgi5ZThsxKuVLNKT3+YXS8EbvfyLT0QSCVDUlQNQKOO6EjevtQJXw9ow15lV5GkLqmuTlRRSvonFuMabyyXdV+coOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876205; c=relaxed/simple;
	bh=Sye1tJDPd/uimiJvlKKSnJsoABxzjc348sGOhJsGs+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MklSrD/3Jen0+F75aZsmOVZ18APhGn3bFn8etbezcpezFXvuov4PrWmDK6MQrNhJCkWQnpyZJ286Oeap1G5iZzE3lIS1WvO2V8WA0XDR/sTufCvPH8WWqIv3+xAURhm0eD3C+36NjObJszhGMs+k51E8bWNXQweHYL3gaDEQrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrcRw7Xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrcRw7Xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25047C4CEE4;
	Thu, 17 Apr 2025 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744876204;
	bh=Sye1tJDPd/uimiJvlKKSnJsoABxzjc348sGOhJsGs+4=;
	h=From:To:Cc:Subject:Date:From;
	b=nrcRw7XekbGfUAVDSfpBsKPyJ/5pPZ+vkENqqp9hDZx4nCUjRunZUyAn2nhLWPqUj
	 UWM8nqjiOu8bXCqqUG4MlWWJnv8GG4rxAVEwav5qk4pJarMMwQambB8J008Lwnc0MP
	 UGMjHHCmUEUu+4I69fvTRV+tbKslZY3lKwa+jw1lmzC68pQJrB+dISBf4+b7QQ3kSL
	 IkPPS51lNABVrtkHaI25xtt1wsUIz4UDlr/0es21HsByfvCeXulyBzn4bviGvFoVoa
	 2Dgd2L33FctkY7p3TByzs7/I3chEjn85GWehhrnL/ezwyW5rw/EEv+hJtZ/Hk81VX7
	 TEMhVWqWFki9w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH fixes] riscv: uprobes: Add missing fence.i after building the XOL buffer
Date: Thu, 17 Apr 2025 09:49:49 +0200
Message-ID: <20250417074952.1315641-1-bjorn@kernel.org>
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

The XOL (execute out-of-line) buffer is used to single-step the
replaced instruction(s) for uprobes. The RISC-V port was missing a
proper fence.i (i$ flushing) after constructing the XOL buffer, which
can result in incorrect execution of stale/broken instructions.

This was found running the BPF selftests "test_progs:
uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
uprobes tests randomly blew up.

Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/probes/uprobes.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..4faef92dd771 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -176,13 +176,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
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

base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
-- 
2.45.2

