Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2FE56B86
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326975; cv=none; b=WEXDfai/3pvbdvhPdnnClCDg+qJv53A6MlyM1tIjuxO8kSKdvsIG9ad/B/PPN0lzp71Fy7BlUSeAzFSDa/Smlg0aNiDq2oLXUJK0udnkKib6G9VRsqhIEFuFRnyhrZ3EJQg8YO7qIsoncm6kQPyZUJyRjU0HpUF5ZC6r6suk1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326975; c=relaxed/simple;
	bh=NsThTAdLO7OgfNZz5CNxYC6AYTZXGKyH/bMvLFNMAiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Do33lKJpiTQzrZ2kR3JmTkJFabJV/6Mnl9xZpBOUUhNx/KiKWkqywcKWSkUFk30Bsq+8rLoBm0vr8RVK4nTOmNkM65RFYUjMrepY1JUKWRAH44MN34kpvETCU6hZQQyY/wik+kg64OP40Cl32bBHwfneUm89NnGvrqBDmiYMKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by xavier.telenet-ops.be with bizsmtp
	id tZ2e2B00C1TWuYv01Z2eDe; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024h7-Gu;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8sK-B7;
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
Subject: [PATCH 18/20] sh: kprobes: Remove unneeded kprobe_opcode_t casts
Date: Fri,  1 Mar 2024 22:02:32 +0100
Message-Id: <fc22b990d869fc2005990159d8072ae2774b1396.1709326528.git.geert+renesas@glider.be>
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

There is no need to cast a kprobe_opcode_t pointer to a kprobe_opcode_t
pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index d8c2e399d6e50794..49c4ffd782d6d6c5 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -39,7 +39,7 @@ static DEFINE_PER_CPU(struct kprobe, saved_next_opcode2);
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
-	kprobe_opcode_t opcode = *(kprobe_opcode_t *) (p->addr);
+	kprobe_opcode_t opcode = *p->addr;
 
 	if (OPCODE_RTE(opcode))
 		return -EFAULT;	/* Bad breakpoint */
@@ -248,7 +248,7 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	p = get_kprobe(addr);
 	if (!p) {
 		/* Not one of ours: let kernel handle it */
-		if (*(kprobe_opcode_t *)addr != BREAKPOINT_INSTRUCTION) {
+		if (*addr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it. Another cpu has removed
-- 
2.34.1

