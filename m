Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEE56B7B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326969; cv=none; b=TAXxAxwFvlCiOYM+OWANe0wby2o1h0ZfVp/3zO1f3KxrQvO2mz3NlrcE0sZRrwZqHguUpaQYkWg0SeREyp02swyofOW3Gas0SQv/pvmQ2yYPLJmAqCsi86FDkrQXBe7MGTPNSA+5/M6GEr2sQeCiddL2ZSYAkvjps39Sw80lIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326969; c=relaxed/simple;
	bh=9LG2z7aDdp+/GoNUFPZ5luzTqo5E7LF1IVqFSiF/FFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAfLOkLs1j6niwwj+biwdS4E/hT5yB2z/swPtv2uKKv0XQZNx2lcKq83UTwJi+u+7QdANzM8BHfJr98k44iINanni2LqyBRfCbOO+tmYl9EDDXEftc+iXta4m0NvEgUqqxHqb/1gGNA1Gdzb2GUsiMtWiDwKqNLhjwxyd3wWGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by andre.telenet-ops.be with bizsmtp
	id tZ2e2B0051TWuYv01Z2emz; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gi-CF;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rk-6Q;
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
Subject: [PATCH 11/20] sh: math-emu: Add missing #include <asm/fpu.h>
Date: Fri,  1 Mar 2024 22:02:25 +0100
Message-Id: <cfda1ba2eadb75e2793e67d43df42fe4c04e4fcf.1709326528.git.geert+renesas@glider.be>
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

arch/sh/math-emu/math.c:492:5: warning: no previous prototype for 'do_fpu_inst' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/math-emu/math.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index cdaef6501d764a0c..b65703e065735663 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -15,6 +15,8 @@
 #include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
+
+#include <asm/fpu.h>
 #include <asm/processor.h>
 #include <asm/io.h>
 
-- 
2.34.1

