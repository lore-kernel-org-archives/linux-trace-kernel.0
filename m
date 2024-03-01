Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BB56740
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326968; cv=none; b=RefpWAnvOPJVNa943c9kH0alzhstz74g1+Yy2ph3TFiz5vg0v6sLxUiVh9b7yT/mG9ulJ+Sq0txcmQOePh42NDkxfyuxXB6L6AzsFSdppSHpjh4MXHGTcabkUnkqBeVemx0ukhQQw2GyCJYAYDCevp038CsdjuoXjgpiFU1y4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326968; c=relaxed/simple;
	bh=BPPrtYYkG1jISGkKN9c8XXBC80WiPKn1mQRJLvAiIsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2mRVOGzdk75QsFb70yDTHOULzvOwTFXtJJt7ELKxH3mKDxKcm/KW7raTXiDII3N+CPpKAt0sxjfWKV/YYT0ChQH33VpP/sNs132CO2Zt6tHxp6BpXgDo4c8lZFsAQZLAiTH/5PLh+EROE/5B79zr2TMT99M6zlBWJVoWMGC0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by albert.telenet-ops.be with bizsmtp
	id tZ2e2B0071TWuYv06Z2eSl; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024g6-6X;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8r8-0s;
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
Subject: [PATCH 03/20] sh: syscall: Add missing forward declaration for sys_cacheflush()
Date: Fri,  1 Mar 2024 22:02:17 +0100
Message-Id: <b1c218986fb77d78303626b43c97925809045018.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/sys_sh.c:58:16: warning: no previous prototype for ‘sys_cacheflush’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/syscalls.h b/arch/sh/include/asm/syscalls.h
index 387105316d2882fe..39240e06e8aa5f6b 100644
--- a/arch/sh/include/asm/syscalls.h
+++ b/arch/sh/include/asm/syscalls.h
@@ -8,6 +8,7 @@ asmlinkage int old_mmap(unsigned long addr, unsigned long len,
 asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 			  unsigned long prot, unsigned long flags,
 			  unsigned long fd, unsigned long pgoff);
+asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op);
 
 #include <asm/syscalls_32.h>
 
-- 
2.34.1

