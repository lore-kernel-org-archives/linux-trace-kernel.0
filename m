Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2056B69
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326968; cv=none; b=jLXY1U8SiRavt7QQu2dGWM0IQInr0hEAqzFRM1vq1Grtdb2f6WNuFk+u4wvaUw9b2x0Yw3hxRIJSgx2CUDe0AC/YTcO2WCGpwfWSwvOLtEd6gd/rYHkPIj//lONyTZs82VT6mlmnin1SdKUNhP9CkwUotNnoHxPlSrgGDfTIO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326968; c=relaxed/simple;
	bh=4jwyfu63xDiy56cefdt9I7ChJJArBQFaMXCHxbmjD14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQT7jC5bg+dy6QFykERNnvnKt/F4j4sUJs6XVx3PWo0t5+3I3bofeO2W+H456u4c/6ydpjalGL05gIfO8ul7Us55DMLsKhW5Nuc3kmTC+yJDomoUq2HqNkqndZEd8hcpUL5ljHuAcxob+qhF5NDzCN7nfzdSC0teXMZboWAITEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by michel.telenet-ops.be with bizsmtp
	id tZ2e2B0091TWuYv06Z2eww; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gW-AB;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rW-4M;
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
Subject: [PATCH 08/20] sh: boot: Add proper forward declarations
Date: Fri,  1 Mar 2024 22:02:22 +0100
Message-Id: <2614d991c816ece903ef47c715bcc53881d34f3f.1709326528.git.geert+renesas@glider.be>
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

arch/sh/boot/compressed/cache.c:2:5: warning: no previous prototype for ‘cache_control’ [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for ‘ftrace_stub’ [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for ‘arch_ftrace_ops_list_func’ [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for ‘decompress_kernel’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boot/compressed/cache.c |  3 +++
 arch/sh/boot/compressed/cache.h | 10 ++++++++++
 arch/sh/boot/compressed/misc.c  |  8 +++-----
 arch/sh/boot/compressed/misc.h  |  9 +++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 arch/sh/boot/compressed/cache.h
 create mode 100644 arch/sh/boot/compressed/misc.h

diff --git a/arch/sh/boot/compressed/cache.c b/arch/sh/boot/compressed/cache.c
index 31e04ff4841ed084..95c1e73ccbb7e011 100644
--- a/arch/sh/boot/compressed/cache.c
+++ b/arch/sh/boot/compressed/cache.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "cache.h"
+
 int cache_control(unsigned int command)
 {
 	volatile unsigned int *p = (volatile unsigned int *) 0x80000000;
diff --git a/arch/sh/boot/compressed/cache.h b/arch/sh/boot/compressed/cache.h
new file mode 100644
index 0000000000000000..b622b68c87f59b97
--- /dev/null
+++ b/arch/sh/boot/compressed/cache.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef CACHE_H
+#define CACHE_H
+
+#define CACHE_ENABLE	0
+#define CACHE_DISABLE	1
+
+int cache_control(unsigned int command);
+
+#endif /* CACHE_H */
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index ca05c99a3d5b488d..5178150ca6650dcf 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -16,6 +16,9 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 
+#include "cache.h"
+#include "misc.h"
+
 /*
  * gzip declarations
  */
@@ -26,11 +29,6 @@
 #undef memcpy
 #define memzero(s, n)     memset ((s), 0, (n))
 
-/* cache.c */
-#define CACHE_ENABLE      0
-#define CACHE_DISABLE     1
-int cache_control(unsigned int command);
-
 extern char input_data[];
 extern int input_len;
 static unsigned char *output;
diff --git a/arch/sh/boot/compressed/misc.h b/arch/sh/boot/compressed/misc.h
new file mode 100644
index 0000000000000000..2b4534faa3052857
--- /dev/null
+++ b/arch/sh/boot/compressed/misc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MISC_H
+#define MISC_H
+
+void arch_ftrace_ops_list_func(void);
+void decompress_kernel(void);
+void ftrace_stub(void);
+
+#endif /* MISC_H */
-- 
2.34.1

