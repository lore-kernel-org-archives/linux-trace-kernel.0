Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DA203704;
	Tue,  3 Dec 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255796; cv=none; b=qygvy2wiN4R7vD8JbNMD4Z8Ssr1l2FFSp6K5dsGH2N5EwwdOxWOkfmbFT6Oxb0JGMuxkjvxlqYb4YZMXh6gjr7omKIcc4Ad4mLuccFeswIXl7antcKW64RWUw2SeR2iR0n4vVB9b6Cv1Acra5g4SAn4L+sRhYmT9hcpxkeLpC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255796; c=relaxed/simple;
	bh=dPtvInl3dZDE6YJyE2VQcjQt7kOABVSw6IKmdkRd2Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmOyOG4yaS/NENVgG4KKr94WydwGDX/3g3Tt25P82z7W3YbfdbzoxNAaraV5c3GxhD3cr3DDxKhe3K8w+mod1WNheIc6dyqqgZw3f/56oyXAo3/nRYwbOh2clSR1Fs66crlJ30QNnb7A0auVIKBdxpQi08hIhba8BE+AeIFfgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=NWt5wUxo; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="NWt5wUxo"
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED11D20008;
	Tue,  3 Dec 2024 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733255787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPbF7+/TQfjwapydYgnIMDSNN4XoQOjgaOnk1RL58gs=;
	b=NWt5wUxoHhHzRMRhe8r4rNxJRUs9Fs09AfqCcKxf6+ZFy9UGUb2aYGjux0S8abd6t4L0e4
	aZJJqYeEhoj3AKncBRqt3D14DxAcZyMfQTbzWLArUfOCAmaJ4WJ8X3Mcw77PGU2CNASAsA
	Y/VwR69t7dwDINOve2sBtqPLiP4KeXxwvaRi6Y+oKK9TYx1t6NnrS1NZReF/+wKZzygQuH
	XTLfwVv0t1yx5GdzPFB2y+dF5aTSz8cVMvB8Wb4P9H/aWim7dEy1HZYOogaZVVwtxZd58j
	ehPDi89l6SxWrSywJw8bG/g0IfSR5tfLYRJHTcJzOsneO+adxAPKx5PlQGVPuQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Tue, 03 Dec 2024 20:56:25 +0100
Subject: [PATCH v3 1/2] m68k: Add tracirqs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-add-m68k-tracing-support-v3-1-4de93f6cae55@yoseli.org>
References: <20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org>
In-Reply-To: <20241203-add-m68k-tracing-support-v3-0-4de93f6cae55@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255785; l=1262;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=dPtvInl3dZDE6YJyE2VQcjQt7kOABVSw6IKmdkRd2Gc=;
 b=rdDBprTiLuOTZodxLBQt+kKbJjksWJvpBhNLlSK1A81xqOF5znKta0LrQUTWvVWz+8SgFneOt
 7bkuZkuUbVUAZOmQo9BwfttyqqpOAfNgVlbBpn2sLJPNLpiwLX9pD8s
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

