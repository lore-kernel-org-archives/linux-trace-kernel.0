Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15C56B78
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326970; cv=none; b=IAGUM+2VBUOZcN3gcKTMjiqmjlO1bvy7V1R9NMu/JCuyX70GNpTr8r12rKW45JVxxJUvtI/2NoIFYs9Dsuwutj9TYoD+yrzJXqvySnlmNDtReTGBvWzEZM5lAVbsUV8n6V9EwopgoSGwInvDBHTNRVH+1Vl8cQYIsb6KUG+/ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326970; c=relaxed/simple;
	bh=TGrXuKYKqikce7TVqIhLwWpcj04ZDAEWrxdVVfhjCTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYNfDDGPxL6y+Hg2gouqls/0zgYnhNJ0PuIR4HfK/fAx4gL3YFlryfpJN8uCr1BPE5zKXQeD2jUCyupcahaV3teyh8F0H0E+drPdJnQIAr7Ph3wnb+0w9TVztqIx46yf87dMZBfy7FHsYXkg+133qfwm8RHws0kxTIwhSwTFdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by michel.telenet-ops.be with bizsmtp
	id tZ2e2B0071TWuYv06Z2ewu; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gO-8m;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rK-2y;
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
Subject: [PATCH 06/20] sh: traps: Add missing #include <asm/setup.h>
Date: Fri,  1 Mar 2024 22:02:20 +0100
Message-Id: <a7750e57cc077ca6e27d0b9bd6b123d42894bc17.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/traps_32.c:735:6: warning: no previous prototype for ‘per_cpu_trap_init’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/traps_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 6cdda3a621a1e577..8cd4b05df75c3e07 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -27,6 +27,7 @@
 #include <asm/alignment.h>
 #include <asm/fpu.h>
 #include <asm/kprobes.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/bl_bit.h>
 
-- 
2.34.1

