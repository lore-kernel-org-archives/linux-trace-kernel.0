Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179A1FA241;
	Tue,  3 Dec 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246513; cv=none; b=TG+HHVVBf0iy/HE97c28OhsiaLwCB2CS2BGsaDlQCOvfG7mBIR/bGB6sq46p1jTmogq2f3kzemgQET6GDgkXg3GvlAhkqreZeoG5ksmbLxgIZduD5oY2OkhYMSSURwdB7O3vAZv8iK5vTRfN4MGFRF8WdRpbcWiqQ7VPSA0oYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246513; c=relaxed/simple;
	bh=dPtvInl3dZDE6YJyE2VQcjQt7kOABVSw6IKmdkRd2Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7ZbxB6UiM+4lR9dZvgYbwqDr9wfi3eWX8Z4Ub/cd9ckCLUQ+iiETJX1Q/XHlFFzjCcRPblVee6mZVI4VZ2tasO5zBA4NEgos9hk9skKDR7ZVetfwrjML4xg32Yps5zLSTykKVQ0MYOriMxCRsmsQxODaPQWtqEGxfPgMysooEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=eK0uEHuu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="eK0uEHuu"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16EFB24000A;
	Tue,  3 Dec 2024 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733246504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPbF7+/TQfjwapydYgnIMDSNN4XoQOjgaOnk1RL58gs=;
	b=eK0uEHuuHKcCOYs2wZGnJ6cTEanr6NDSHGOgiRgXFMq7S1nvva5RJlSZhH5kWB1rWEtt9l
	Aw/GIJ7k/pkxNwvAvaqNKiIC0//Y2E+afnrMFMe/ANuh2BNDS5TsL9ZP3hjClrsJBhrS/N
	rWoMqkhtOLuwIFl8jIwFKwshRglSqLT/EcHg5H52SC6dXJEFKekmCuSZzTlf8BTSdSyqeZ
	+x2ta3PRyQCyl0ATvTLUhce6oXm5NfOaY6KOeffPuEpQuPMp3PncFQTSrMXv3RUuPGg+SA
	wu+sK3DSaUZz8GHIMuM+dvRzcoy51iGboGujadGLmrIsU4juw2zEYBlmmGaURA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 03 Dec 2024 18:21:38 +0100
Subject: [PATCH v2 1/2] m68k: Add tracirqs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-add-m68k-tracing-support-v2-1-77302097a9f4@yoseli.org>
References: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
In-Reply-To: <20241203-add-m68k-tracing-support-v2-0-77302097a9f4@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246503; l=1262;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=dPtvInl3dZDE6YJyE2VQcjQt7kOABVSw6IKmdkRd2Gc=;
 b=3HuE4HetkiuJhDi3mvX8t/0M2vN1pEGxIiIWEuitmya+htpSQbNCeB7Jh4jJbRRyC9+zkOlTN
 jLtM8UQv+Q4CWyT1Qb2K0eTOWvWgVcElHhps5MCcPQGSp7MXHu2sszJ
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
trace_hardirqs_off() when interrupts are disabled and
trace_hardirqs_on() when they are enabled.
Add those calls to do_IRQ function.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/Kconfig      | 1 +
 arch/m68k/kernel/irq.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 7c4f7bcc89d76326b9d7280a3bcba79412ead7d2..793ab1e2762609725bbf793f6dffecfa3ecfff0f 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -39,6 +39,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA
+	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
index 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711 100644
--- a/arch/m68k/kernel/irq.c
+++ b/arch/m68k/kernel/irq.c
@@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
 {
 	struct pt_regs *oldregs = set_irq_regs(regs);
 
+	trace_hardirqs_off();
 	irq_enter();
 	generic_handle_irq(irq);
 	irq_exit();
+	trace_hardirqs_on();
 
 	set_irq_regs(oldregs);
 }

-- 
2.39.5

