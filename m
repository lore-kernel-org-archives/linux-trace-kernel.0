Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CA57305
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326973; cv=none; b=Sv7f/r0tMx57MIbqJBN5BRb1+DcFecg1A94zCHzR8iHukxlkAj1JBVmzuhwPp6wqOhAuL6Ap5dsQubY2MLCmGWvubP7eThJWTRhx+1B0wHEdqdmiAwc/KMw2GgN9Wo8fmf/TrbJbJB/sMVk8wRlTPmZ3QOhd6cBF+QGZuErY/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326973; c=relaxed/simple;
	bh=v+444xnXxm36FIpSo81QsrCLOG8RoDU8XmcZ0Zk0Ylg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZ0P24f6HcznA6F7feQsVChVqra+XQUJFNGsJfMYT0syVVXAGszmmpBiIccSIIZl+8WZMKDgT0tpGYYW/nPBfprZcETcjV7Psa4hm3+bi8fFXD4cdT1K2Kr0OWzccbaFqbGru4EQf40xsWeHIFDpAu/sw+JTfuWMf/OkhBIom0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by xavier.telenet-ops.be with bizsmtp
	id tZ2e2B00A1TWuYv01Z2eDc; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gq-DV;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8ru-7o;
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
Subject: [PATCH 13/20] sh: sh2a: Add missing #include <asm/processor.h>
Date: Fri,  1 Mar 2024 22:02:27 +0100
Message-Id: <8314dd9a966394dd1fd82d88095c57d9778fcfc9.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/cpu/sh2a/opcode_helper.c:34:14: warning: no previous prototype for 'instruction_size' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh2a/opcode_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh2a/opcode_helper.c b/arch/sh/kernel/cpu/sh2a/opcode_helper.c
index c509081d90b9affe..fcf53f5827eb286c 100644
--- a/arch/sh/kernel/cpu/sh2a/opcode_helper.c
+++ b/arch/sh/kernel/cpu/sh2a/opcode_helper.c
@@ -8,6 +8,8 @@
  */
 #include <linux/kernel.h>
 
+#include <asm/processor.h>
+
 /*
  * Instructions on SH are generally fixed at 16-bits, however, SH-2A
  * introduces some 32-bit instructions. Since there are no real
-- 
2.34.1

