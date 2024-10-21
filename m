Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77A1E32D2;
	Mon, 21 Oct 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503893; cv=none; b=rDHluqNwvA4EXw+ajfkNv/zVHqNPwHtKNP5RnffPNr14Vq6NYVc718uw1hKGqTTWvhRRKrd/Jp1HCYzbgrY40oNPT+y9O90qgnKtv3nUTlsmddQJhqkiCG+7Wc0tmaJBkOqpUXGrGJuo9L1MCgAvQ3kh2fvn1sRVOOE1LXU4W5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503893; c=relaxed/simple;
	bh=Eg3VYep9FTvZM52AgKoib9dk0cgzF+BKiLID/GQd1kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZCbwY7K2dt+Hfprv1M1+dRmjR2BuD4G+e+7STv5+SxXk3yF0LOvZYVNzLKu4baL3b/xHqO+touBRLXDE3KoHzHHPqebniGemF3nm1QQlUrHfG2mRAdqKUKvZPWRHfFmR+AMzG/Y2l2aRAYX+tRx8leKCSpPxAUVomA4A5pK2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=CHvHWHKS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="CHvHWHKS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7A4C1C0011;
	Mon, 21 Oct 2024 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729503884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjRjnwkVauYT50JEMepn2mqWSlGTz06LaGBsZrBKJ0U=;
	b=CHvHWHKS+Kif2WOixzs6QVgT7zwAibwtIN1r9YQazoIedtq1KN0e8uFKyye14TFEFCyvcQ
	g652b7F06O7lXqE/WLcVgZKdKBsJ2hOOicInOCD8q3btcajg2W3HOryjJn4zg9QXqpaBiW
	zrg5kze8siecL19T5oovyxqAZPW3DC0doCbOWD3/e+oW6Z+lTzYfp8uUZOPCZs2kXylqLM
	3gZljBTXOhMtnCAmwzZYzcmWEuuGyWNd1wpiQiklv+eg+vrMMDgWCJ5vAE32QxzCvS50Db
	bezL7qBgmsaoAG9xW7PXLiQm+lM5mUYItJkluv9PkDp5c3Ia/K2eJhVTSTk3hw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 21 Oct 2024 11:44:42 +0200
Subject: [PATCH RFC 1/2] m68k: Add tracirqs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
In-Reply-To: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729503882; l=1262;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=Eg3VYep9FTvZM52AgKoib9dk0cgzF+BKiLID/GQd1kw=;
 b=MX2P5u2fu5WUs8IWxMeKGcp6VaHPCqfCM5H4nafqr0kvpcWwnsi1pN8rZTObwcUFjWpq+ioU5
 B04clN3RBEzDHjgatm/ltAO5B9UuCO3SSzw91MNQgth5fPKaQ7geQkW
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
index cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d 100644
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

