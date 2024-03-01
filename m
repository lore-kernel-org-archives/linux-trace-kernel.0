Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A557302
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326974; cv=none; b=fsptVLoKlF2HiemhOHcE5FJ7nQoiEb5LUwqj1Ibz4tMGpJze5z5OYtWWso3aIcPj36qGsg6jWEeRtaSB1ywalQS6gXFvItlSs+Gr/pVotZAE42hRAtSdEdYcDpuqfIPndK3qEeDdQ2iwqcNrBYtoaLNh6OuT8XKs6tdylUuW6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326974; c=relaxed/simple;
	bh=vEl5nxIEuJjotrXH/NuuNutlo2SHKOIwPzsZzJtKDHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUZEq5Ice2aFqX5eUhvADs3jeay5Ygd/P0o4L6jwlk0gYCF7C3rtXKitA/Zfi21PgJDvYy6JkLj/FmYLwpq+y7+qq9NutW3Gwf8If+ZvD9KLUIpBJOwZMcTUBpE347eyseFY+hRWGWVTqoxudn238JY2gUUugH/5hzIWV8zJblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by xavier.telenet-ops.be with bizsmtp
	id tZ2e2B00B1TWuYv01Z2eDd; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gy-Ep;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8s4-98;
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
Subject: [PATCH 15/20] sh: smp: Fix missing prototypes
Date: Fri,  1 Mar 2024 22:02:29 +0100
Message-Id: <6b6b9a84b30ee56f57f409a7550c69d4aece5dc3.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/smp.c:173:17: warning: no previous prototype for 'start_secondary' [-Wmissing-prototypes]
arch/sh/kernel/smp.c:324:5: warning: no previous prototype for 'setup_profiling_timer' [-Wmissing-prototypes]

Make start_secondary() static, as it is only used in this file.
Include <linux/profile.h> to fix the other warning.

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 5cf35a774dc70082..b3ea50aabba3d7f2 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -21,6 +21,8 @@
 #include <linux/sched/hotplug.h>
 #include <linux/atomic.h>
 #include <linux/clockchips.h>
+#include <linux/profile.h>
+
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
@@ -170,7 +172,7 @@ void native_play_dead(void)
 }
 #endif
 
-asmlinkage void start_secondary(void)
+static asmlinkage void start_secondary(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct mm_struct *mm = &init_mm;
-- 
2.34.1

