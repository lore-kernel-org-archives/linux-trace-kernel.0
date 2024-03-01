Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845A56B87
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326969; cv=none; b=f/efw0xQja2aC92/zdA2j0uhCUqNcrifPju+56SYFoqsncnu6Fa8juu6PwZopmScatYLHYvvHiuyzszuUi0jqSi9teNdWzspw2qAOdWCenHkyv/umnanmupwP3ADpcyD3emn7UcSw/Ovwlyi3L7QIb7SB4wirdl0X1AmSSijy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326969; c=relaxed/simple;
	bh=+1TX2uH6QO5tL1EOUSBU0x1mpJCfTuOWxVFI4K9w8AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHqzSWwMx9JxQq7lWdvoxY97cOLp5b3N2OCG3T0ZiwdzMLy2s/TitS9hb/6WFghfIAV37ILwpPFzbP7s33ok3G8Cldc6VDlxx7bk6rssN6ci7eWNEV1t72iUu7j1izB+jkySJKCRmi/wJbGzNh/Fz9iwHpH0GX1XIHJ0y5ioOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by andre.telenet-ops.be with bizsmtp
	id tZ2e2B0041TWuYv01Z2emy; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gD-7H;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rC-1c;
	Fri, 01 Mar 2024 22:02:38 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 04/20] sh: tlb: Add missing forward declaration for handle_tlbmiss()
Date: Fri,  1 Mar 2024 22:02:18 +0100
Message-Id: <23ec2c88168bd5b7e294828221531eed2f3eede8.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sh/mm/tlbex_32.c:22:1: warning: no previous prototype for ‘handle_tlbmiss’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/tlb.h | 4 ++++
 arch/sh/mm/tlbex_32.c     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index aeb8915e92549609..ddf324bfb9a09721 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -24,6 +24,10 @@ static inline void tlb_unwire_entry(void)
 	BUG();
 }
 #endif /* CONFIG_CPU_SH4 */
+
+asmlinkage int handle_tlbmiss(struct pt_regs *regs, unsigned long error_code,
+			      unsigned long address);
+
 #endif /* CONFIG_MMU */
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_SH_TLB_H */
diff --git a/arch/sh/mm/tlbex_32.c b/arch/sh/mm/tlbex_32.c
index 1c53868632ee4c69..7d58578c15f4ef55 100644
--- a/arch/sh/mm/tlbex_32.c
+++ b/arch/sh/mm/tlbex_32.c
@@ -14,6 +14,7 @@
 #include <linux/kdebug.h>
 #include <asm/mmu_context.h>
 #include <asm/thread_info.h>
+#include <asm/tlb.h>
 
 /*
  * Called with interrupts disabled.
-- 
2.34.1

