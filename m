Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE156B90
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326976; cv=none; b=AbzVIE9ecB5IfYIFDD0Wy0rY3lTytUbldQoVF+89lmzEiK/9MWlB/CXahVHMg1r8r6fHEWIc3+g0P9cVzEBHKvCUOfShonhRkBZvDeJCmFrtnzlKgxTP7dPtA24ENEduEpGaUr3n4tqIyp4JDmOvsfyT9HZOivoPXqkSqedpVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326976; c=relaxed/simple;
	bh=XQY+hwm/pWBlN5cYBxNabpimlfOZYJcYfzShDnZXI5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUWKHQGHkUU8Ueo5670woFI4/cmzz/5Equ1zMpopWX/lBKH/CchFXx6toQOOi5Hpo+nfhJrxCFmcLUeA1pUFAfx3YuSZUyPBtY9EJeDxUqkIl6THWf0NyxZ57UDx1l00QzfZoGrWwJIRj49f3C0li1Hignf1xpCnN9Z4G6joxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by baptiste.telenet-ops.be with bizsmtp
	id tZ2e2B0041TWuYv01Z2eXk; Fri, 01 Mar 2024 22:02:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gJ-80;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rG-2I;
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
Subject: [PATCH 05/20] sh: return_address: Add missing #include <asm/ftrace.h>
Date: Fri,  1 Mar 2024 22:02:19 +0100
Message-Id: <45685f62c9132aca5dc3c028471218393b51f34c.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/return_address.c:49:7: warning: no previous prototype for ‘return_address’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/return_address.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/return_address.c b/arch/sh/kernel/return_address.c
index 8838094c9ff9444f..2ce22f11eab37839 100644
--- a/arch/sh/kernel/return_address.c
+++ b/arch/sh/kernel/return_address.c
@@ -7,7 +7,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+
 #include <asm/dwarf.h>
+#include <asm/ftrace.h>
 
 #ifdef CONFIG_DWARF_UNWINDER
 
-- 
2.34.1

