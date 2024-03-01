Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F556B85
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326970; cv=none; b=eYfFV1ZaaqpHHdGKqHqa+TBr8M1+tA5+D1WSffu1nDccAPaH43hzAK8R9gX1Tq1uwJn+0McXYja/jgvyNfjK2xGjhH/iI7P4inSGUs4hj0WW/amFk4gs4pP1Oz434UgfYZqZ+knKjhwUn4VsYObyH6b11CVF9jH15jjNNX5Va3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326970; c=relaxed/simple;
	bh=1Synhu8Wj+iI/4pFeBUM+/X8uo4aR7TufZvYlYZi3oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWXZJ/o6VeDx7UBMOPQs60/ZLSldECzBeYfE3xzm8HT6OOOMrDUanDX+ysQfRmHRk07f+6ikq+ZxyCzAx/IdsYRV8FyrK7BX/dDFp40SpyHlAG/dGJVTY7A4FoLvlna7QQv0Yk3URTm0gXPcLLQjGKHlSoYTGhWvYmX3yQYZ4p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by andre.telenet-ops.be with bizsmtp
	id tZ2e2B0031TWuYv01Z2emx; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024g3-5U;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1d-00D8qz-Vn;
	Fri, 01 Mar 2024 22:02:37 +0100
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
Subject: [PATCH 01/20] sh: pgtable: Fix missing prototypes
Date: Fri,  1 Mar 2024 22:02:15 +0100
Message-Id: <aa1328ea3327d6685aab76d5787cb77c996052c0.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/mm/pgtable.c:12:6: warning: no previous prototype for 'pgd_ctor' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:34:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:39:6: warning: no previous prototype for 'pgd_free' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:45:6: warning: no previous prototype for 'pud_populate' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:50:8: warning: no previous prototype for 'pmd_alloc_one' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:55:6: warning: no previous prototype for 'pmd_free' [-Wmissing-prototypes]

Make pgd_ctor() static, as it is only used in this file.
Include <asm/pgalloc.h> to fix the other warnings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/mm/pgtable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index cf7ce4b5735954bf..3a4085ea0161fe56 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -2,12 +2,14 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
+#include <asm/pgalloc.h>
+
 static struct kmem_cache *pgd_cachep;
 #if PAGETABLE_LEVELS > 2
 static struct kmem_cache *pmd_cachep;
 #endif
 
-void pgd_ctor(void *x)
+static void pgd_ctor(void *x)
 {
 	pgd_t *pgd = x;
 
-- 
2.34.1

