Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41662E425D;
	Thu,  3 Jul 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546354; cv=none; b=GbvC5qtA1AYInRSB2K6uhkzMV/e2rAxKZN83awLVWcV5RF8LtFOtvmVoDwOqoeurcBbpAt7KtHgDlYY7BOK/dvWO6VbNtpey6l4eLH6s1DUgwN8Qj12U0TDi1+RP8LBKDNRTptZRVUZdWQ5vv3DjIcE26HPhm+0F04eGRMf3te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546354; c=relaxed/simple;
	bh=gcPU5yNDPFqYdoGHNrDVKHuSQLTjAociMfApXx2sB5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=joRj/PJbiIPPklMN1ihGTK99C9DTdi40jxYTb0gCtRNNZU6RAbdPGhXUBq6eKm81jT/9tSF1EucqlScsrE7eLdPMMP5Qke2GOUXs0VMAl91+e8wybg5PNymipy0k/ne/aMqln7iuCTHREg0oWy7WB42xft0VK42CmsBq+syEAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pK1oQdue; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/G1z44rc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pK1oQdue";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/G1z44rc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7q+/Yxe5jR0gp3Z+FWT0TLKGPQbK+ZdKZXrnfhsktc=;
	b=pK1oQduea0z5iukfeqiAd27WGS6wK1DAloPSgSXS4yz8n+n6KK0GyQbvAlnY8eP4t9YjIr
	faUR7ZTvj/37LLMDpNdex8/L5GNtEhS6eXvWVn0cb18eLPQfjZFq2bi7BsEVWUZ/MhitYn
	QdaBcsbrsT5LQfahna7pFreBV8mIXQKo/qwOl7Bj9BAQ69gFyT0vr2LZek8xR7jKeMBY/p
	xUsVA48VIPSLGzTTBOgA+RjlDIFkobZ1F0y6T44+uKhSzD9XITuS8F/ATKVDhCFvASfCe+
	nn/BN+vAAE22spMHKtx9Eia62pJ49rmPpSLn8tu3+DTY60YHX0tU6wy4jecuYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7q+/Yxe5jR0gp3Z+FWT0TLKGPQbK+ZdKZXrnfhsktc=;
	b=/G1z44rcqxr8n4lqnZWlF0rkeM9B3WC8nj9r5wovZSLCw2wAEbTbmPTaEX4R6jJ5qtIM7T
	2RiWGy1DHBF2q3AQ==
Subject: [PATCH 0/2] um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
Date: Thu, 03 Jul 2025 14:38:53 +0200
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN15ZmgC/x3M3QpAMBQA4FfRubaaIT+vImnNGadmtINI3t1y+
 d18DzAGQoY2eSDgSUyrj8jSBMys/YSCxmhQUpWykkocixOzPnHgm412btiDNrit5HcWjS3GrFb
 W5LKGWGwBLV1/3/Xv+wHfw+03bgAAAA==
X-Change-ID: 20250702-uml-have_syscall_tracepoints-9f4d182fc308
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=896;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gcPU5yNDPFqYdoGHNrDVKHuSQLTjAociMfApXx2sB5o=;
 b=sOZ4Tue0bWL3LYqcryt9GKTmOvWQah3xZCtEyF1VD05gblm/OzycjztsqW0shMEHBuTLM5XuT
 sYaIg8SS6kGDlZdFwpyNFH9qTjYBk9hU7rNxvme2v/h65fe5N6jURBC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Implement syscall tracepoints through the generic tracing infrastructure.

We want to use this to run realtime validation monitors [0] inside UML,
to test applications for PREEMPT_RT compliance.

[0] https://lore.kernel.org/lkml/cover.1749547399.git.namcao@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      um/x86: Add system call table to header file
      um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS

 arch/um/Kconfig                   | 1 +
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 9 +++++++++
 arch/x86/um/asm/syscall.h         | 2 ++
 4 files changed, 14 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250702-uml-have_syscall_tracepoints-9f4d182fc308

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

