Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E52E4256;
	Thu,  3 Jul 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546353; cv=none; b=CYljzWEWqM+UyX1mPlX4RFNQyfbrUvshQXrTbROV9xsp8t7WFZFEFLmnm2fsWA0oUPQyVXOBinOwH+G429K39eavxgySIVu00WIFSrocNRoJ1fPjABQTb6fEJtqehO4yqG3RDVaH1xDVouhUZnvW5foy7G9ITyi+zD2g1rnqQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546353; c=relaxed/simple;
	bh=xcrXOaelxL04XilVAZ1JMakfSWcihwh5TW+sSTImz6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IjrwlgxST8lKh97jFb94Vh2kIwbwkHAqe3srlKw3nBV39+A6TZ9qZkh8eL3Drq/x4wp5HOn4DlxvMj+/xoYmdIs3aYT1OR3h8RfqohPDzS6cw2wAvApapmnmJYYxdeal7Wj8Z70OIs+wz1JBuwhWxe7fY9sE7DANsxMHMvYTEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1c3998tw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ENub7MT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1c3998tw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ENub7MT"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcx/so/3k8VD9Ap+AUgy3oJHi9GyHmwgfiWauDxMCYY=;
	b=1c3998twe8q2VIRZGXUR/TUVkdP35BAI8WhBf15U2vkd9nXv5KEnfkup3dzhQY7G9nuZ8o
	coo+ZPDsNLwR5oukURfgPBWEprha3AGcKcNAp2JhaHeHtuUPzyf0hBgAuXL813bjz09cYp
	fzhRDCgQZrL1fJ4y/2mI9hOfFDWZmq7vXvhyJVih4ysRDkqu/3Xi3/T32AW8CJBZm38yZ4
	bjxRBWIKwcR6B2+JLxGDQnK9mzl5GUlRISnR62kkuGdfvjrS9sFHj3Kb9fxxatP5NTehjd
	5GqHHDpYlkOObschA64X5Vbw9O4HeLo6Y8o4SqkeO8FQq+pb8wIArAhNOGRaug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcx/so/3k8VD9Ap+AUgy3oJHi9GyHmwgfiWauDxMCYY=;
	b=8ENub7MTQ9ozltCc8o8iylbEHeyl1FOJxDYI50zRsNIx9+so3PEL+4+CTZJNDWcluXdh8Q
	w1ehTLM1Trx6onCA==
Date: Thu, 03 Jul 2025 14:38:54 +0200
Subject: [PATCH 1/2] um/x86: Add system call table to header file
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-1-23c1d3808578@linutronix.de>
References: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
In-Reply-To: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=951;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xcrXOaelxL04XilVAZ1JMakfSWcihwh5TW+sSTImz6s=;
 b=4YZBROzuNLwLwf0oaRMm6LoaR/56kwmtURacuzbbceaAcHcpWk82d4D5oEOJTIXUnmTc+gYON
 9a0m1VkDCn3Dil7iYabU+S4ssnsrMg63dSMIo/n6vp+NCmVxMZDUgQ2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic system call tracing infrastructure requires access to the
system call table. The symbol is already visible to the linker but is
lacking a public declaration.

Add a public declaration.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 arch/x86/um/asm/syscall.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index 56a2f0913e3c0307958eb47815a7634447cb1390..d6208d0fad51a95f3d56879c1bceb50c3ec0f6b2 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -9,6 +9,8 @@ typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
 
+extern const sys_call_ptr_t sys_call_table[];
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_X86_32

-- 
2.50.0

