Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032B5677A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326967; cv=none; b=cccB7fzwXocUbE9cjig31+mj44ndTxcstVsV+dij1r5g+CJ1wa2WLk10Bh08pihhSxcg/wIfx7T5JkuXXOCQK6OyGktyg8wgdKTdLKapZnSX3kBXfFxXlAM8dvcMjdVJP5V0LG+NqbDzQuZIKDN2DptvkuabIyLV0bYRs8RxwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326967; c=relaxed/simple;
	bh=URqkyiSHZkMO/3vSWWbKavtNNGIsgwfUfwcUzGhcOHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvrQPCTfceVbYa3jDgx5hJ/kYvcJGaDmYFPTgGZegL1v74xe2pepPs9Yv3kn+J2M0FFztWajQYveW72MUTnFI2Rt0nR3FNZALSYOFuT4KzaRTd3g1iyPYLKgglirJgvKsqAIn0mBU0GrMYLxxP1XBpfBP3aKJlTvDvlAvhzGVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by albert.telenet-ops.be with bizsmtp
	id tZ2e2B00F1TWuYv06Z2eSn; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024hB-HR;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8sO-Bm;
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
Subject: [PATCH 19/20] sh: dwarf: Make dwarf_lookup_fde() static
Date: Fri,  1 Mar 2024 22:02:33 +0100
Message-Id: <55e8261a354e8ec4d375754e404c6c1d303af715.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/dwarf.c:347:19: warning: no previous prototype for 'dwarf_lookup_fde' [-Wmissing-prototypes]

There are no users outside this file, so make it static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bf8682e718303051..45c8ae20d10957db 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -344,7 +344,7 @@ static struct dwarf_cie *dwarf_lookup_cie(unsigned long cie_ptr)
  *	dwarf_lookup_fde - locate the FDE that covers pc
  *	@pc: the program counter
  */
-struct dwarf_fde *dwarf_lookup_fde(unsigned long pc)
+static struct dwarf_fde *dwarf_lookup_fde(unsigned long pc)
 {
 	struct rb_node **rb_node = &fde_root.rb_node;
 	struct dwarf_fde *fde = NULL;
-- 
2.34.1

