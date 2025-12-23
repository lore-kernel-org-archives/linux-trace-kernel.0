Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA9266565;
	Tue, 23 Dec 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498829; cv=none; b=oWelUJpPwLc5xd0IN/0TOp+y4ROjzx8fV3fXlZu+vhiJIw1iyH0zNqB7EO6mjlS+PN72HMreiwYqazH9UM01kmEWeZv479gdE7vVoCZZkAJfHAY8OAeEnaSHFC2HdnUd4uu5dfPF3uAdvhQ2M1WSZc+rDjIiRRPXhNM1TPls4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498829; c=relaxed/simple;
	bh=e9d09gKSnz/LKxgtnozd0IchyxCDy9q0lUawpKboysA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRpneyeFO7F/O6dG8EvtRNBKeqoyfa2TX6ct5j3M2dGy1k+hMw2GUN53MZ5JHBygZnriFhTIN37S8c8f7nck/l92G5WmUEz2+WzCa7O5P9FCcrO0qC71uuoRmvRBEYPJtHHRrSKxiMWDYC2gz6eBc+yAdnwsnmzBfeUPmabhYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-009.092.208.pools.vodafone-ip.de ([92.208.105.9] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1vY2mn-003sEJ-2z;
	Tue, 23 Dec 2025 14:50:49 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] riscv: trace: fix snapshot deadlock with sbi ecall
Date: Tue, 23 Dec 2025 14:50:06 +0100
Message-ID: <20251223135043.1336524-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If sbi_ecall.c's functions are traceable,

echo "__sbi_ecall:snapshot" > /sys/kernel/tracing/set_ftrace_filter

may get the kernel into a deadlock.

(Functions in sbi_ecall.c are excluded from tracing if
CONFIG_RISCV_ALTERNATIVE_EARLY is set.)

__sbi_ecall triggers a snapshot of the ringbuffer. The snapshot code
raises an IPI interrupt, which results in another call to __sbi_ecall
and another snapshot...

All it takes to get into this endless loop is one initial __sbi_ecall.
On RISC-V systems without SSTC extension, the clock events in
timer-riscv.c issue periodic sbi ecalls, making the problem easy to
trigger.

Always exclude the sbi_ecall.c functions from tracing to fix the
potential deadlock.

sbi ecalls can easiliy be logged via trace events, excluding ecall
functions from function tracing is not a big limitation.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/riscv/kernel/Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 9026400cba10..cabb99cadfb6 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -3,12 +3,6 @@
 # Makefile for the RISC-V Linux kernel
 #
 
-ifdef CONFIG_FTRACE
-CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
-endif
 CFLAGS_syscall_table.o	+= $(call cc-disable-warning, override-init)
 CFLAGS_compat_syscall_table.o += $(call cc-disable-warning, override-init)
 
@@ -24,7 +18,6 @@ CFLAGS_sbi_ecall.o := -mcmodel=medany
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
 endif
 ifdef CONFIG_RELOCATABLE
 CFLAGS_alternative.o += -fno-pie
@@ -43,6 +36,14 @@ CFLAGS_sbi_ecall.o += -D__NO_FORTIFY
 endif
 endif
 
+ifdef CONFIG_FTRACE
+CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
+endif
+
 always-$(KBUILD_BUILTIN) += vmlinux.lds
 
 obj-y	+= head.o
-- 
2.43.7

