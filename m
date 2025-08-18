Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE532C2349;
	Mon, 18 Aug 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513633; cv=none; b=lF2GhjDcvLpxdBXNFcrgxbb6/fYBne7jsbeKH9AUBsVF3JCY446f8XqhrRLiPNBiHAoSm9GaswVpTvBmUA7ZGPkdHlxhhIhUD1pYPvpwhG01G5CCS8Vgq63qASlcvkqf42x6fKlPa+bkUP8707mMOfV98myq/WDV4ZwrUzcPVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513633; c=relaxed/simple;
	bh=vFsO6afpA1B3sq8HSREJ5Mmp3y+vkY0W7YJhMxwDHqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uY7vKqmLIfNkmwdG0ODqMEyScoVYFzM97qOdMWsEW9OyJ3J5QzjvGind+OfTPKDiB78EM5+7e++HUm/3D1FnAklqiGzvoSoDfLCdV3ItueVGIZzCUXBDg6iHyV+HvKxkxssOFFRIWgOv8yCfgGrWNk3r6Q2Tr/GGrXmOD0YVekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 62F0E2C14A8;
	Mon, 18 Aug 2025 12:40:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iSWXF7Fpd1ob; Mon, 18 Aug 2025 12:40:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1AD252C14B1;
	Mon, 18 Aug 2025 12:40:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AWLKFLZ-QJAt; Mon, 18 Aug 2025 12:40:21 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 83D7C2C14A8;
	Mon, 18 Aug 2025 12:40:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux@armlinux.org.uk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com
Cc: ardb@kernel.org,
	ebiggers@kernel.org,
	nathan@kernel.org,
	linus.walleij@linaro.org,
	dave@vasilevsky.ca,
	ruanjinjie@huawei.com,
	liuyuntao12@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
Date: Mon, 18 Aug 2025 12:39:31 +0200
Message-ID: <20250818103931.1100084-1-richard@nod.at>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable support for ftrace's funcgraph-retval feature by capturing r0-r3
and fp.
Since ARM does not provide its own __arch_ftrace_regs structure,
we instead populate pt_regs with the registers required by ftrace.

Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
I noticed that funcgraph-retval is not available on ARM.
There was a patch [0] to enable the feature, but it never made it
upstream. Since then, the infrastructure around
CONFIG_FUNCTION_GRAPH_RETVAL has changed, so I have
reimplemented the original patch.

Donglin Peng, your change also captured the link register, but it
seems it was never used. Therefore, I skipped storing LR.

Thanks,
//richard

[0]: https://lore.kernel.org/all/c61eb9290c3e817d4d70c429c0e987e3ec51a3c4=
.1680954589.git.pengdonglin@sangfor.com.cn/
---
 arch/arm/Kconfig               |  1 +
 arch/arm/kernel/entry-ftrace.S | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1f3df39ed406..ba84c6f7f5f7a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -108,6 +108,7 @@ config ARM
 	select HAVE_GUP_FAST if ARM_LPAE
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V=
7)
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrac=
e.S
index bc598e3d8dd23..e24ee559af81d 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -257,11 +257,21 @@ ENDPROC(ftrace_graph_regs_caller)
=20
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(return_to_handler)
-	stmdb	sp!, {r0-r3}
-	add	r0, sp, #16		@ sp at exit of instrumented routine
+	mov	ip, sp				@ sp at exit of instrumented routine
+	sub	sp, #PT_REGS_SIZE
+	str	r0, [sp, #S_R0]
+	str	r1, [sp, #S_R1]
+	str	r2, [sp, #S_R2]
+	str	r3, [sp, #S_R3]
+	str	ip, [sp, #S_FP]
+	mov	r0, sp
 	bl	ftrace_return_to_handler
-	mov	lr, r0			@ r0 has real ret addr
-	ldmia	sp!, {r0-r3}
+	mov	lr, r0				@ r0 has real ret addr
+	ldr	r3, [sp, #S_R3]
+	ldr	r2, [sp, #S_R2]
+	ldr	r1, [sp, #S_R1]
+	ldr	r0, [sp, #S_R0]
+	add	sp, sp, #PT_REGS_SIZE		@ restore stack pointer
 	ret	lr
 ENDPROC(return_to_handler)
 #endif
--=20
2.50.1

