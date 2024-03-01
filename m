Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D856B64
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326969; cv=none; b=G6vsHyiVweYve6u1na8rMhsIBhs5IvTyUYOWkso2QCqxoZuxtJ1SFH9JNrM9rojyv0V5wpPsY9WFvJTLb2p0ZwXJUY9c90NJN4x9q28xcWJyAPSDDPwK2LNWbAykYhydYFcav+2QE3nuh1EWQwF99OnPhIpAH65zucXsLCszZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326969; c=relaxed/simple;
	bh=/tBZ2iSdN8OLbtFWmDoI6rwg+iFBUAwva2wRvq50svo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLCcDVf2uy7mowLj7R//8P9zaDdgujJs0QVhbuSQfvfGTa+tspUC7+JMm7ojFn1zEfDwGz0bWyzCVzIX/qDNUqAxIJAvS0sDZYZ225xnS4J37zjhz5bd32Y2KeFznV7WGENvwcbYRgX0B/2zDac8t7keSBu/E4huG7mI5vyK234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by albert.telenet-ops.be with bizsmtp
	id tZ2e2B00D1TWuYv06Z2eSm; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gt-EB;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8s0-8T;
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
Subject: [PATCH 14/20] sh: sh7786: Remove unused sh7786_usb_use_exclock()
Date: Fri,  1 Mar 2024 22:02:28 +0100
Message-Id: <a87c6c0edcf81937b8eb2c899d286d82d71ad513.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/cpu/sh4a/setup-sh7786.c:411:13: warning: no previous prototype for 'sh7786_usb_use_exclock' [-Wmissing-prototypes]

Upstream never had a user of sh7786_usb_use_exclock(), remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 74620f30b19badbd..c048842d8a589866 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -400,20 +400,6 @@ static struct platform_device *sh7786_devices[] __initdata = {
 	&usb_ohci_device,
 };
 
-/*
- * Please call this function if your platform board
- * use external clock for USB
- * */
-#define USBCTL0		0xffe70858
-#define CLOCK_MODE_MASK 0xffffff7f
-#define EXT_CLOCK_MODE  0x00000080
-
-void __init sh7786_usb_use_exclock(void)
-{
-	u32 val = __raw_readl(USBCTL0) & CLOCK_MODE_MASK;
-	__raw_writel(val | EXT_CLOCK_MODE, USBCTL0);
-}
-
 #define USBINITREG1	0xffe70094
 #define USBINITREG2	0xffe7009c
 #define USBINITVAL1	0x00ff0040
-- 
2.34.1

