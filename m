Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765356B73
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326969; cv=none; b=eQr/3Q7lR9+4xR4hzJDjDBOh3Jl0D6IEF/MhrJuzLzeeJ1fTcrQvqXbzmq13UfvIjsnIHpYLV7Ea5YPVb1C8pJJE8kpph4HB3Sa+S8koIPFv2C5+xrqKS9zKcGGTtA13KgvXi06nfusEvOSke88XpI0QAUhYgdicnetbpG9oTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326969; c=relaxed/simple;
	bh=0aZULtYZ6GoD8AAl1crVNkmdHv9J+FA0BCcJ19VNsRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W233DwtrGEC7pATGI2HzXQa3+dGF1H/93ythj7PzunhQSFriBKFVWHZyy67iMzF+KElfhRPOYCSoVIGSO5YURWLBliG4qlfMqGUzrl7EhB00gQm8gISjE7z9SI5mv8K2x5ywm/SC5u0dI2pg8dm22tMZfBqqGHVa5W5amsyB+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by michel.telenet-ops.be with bizsmtp
	id tZ2e2B0081TWuYv06Z2ewv; Fri, 01 Mar 2024 22:02:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gS-9a;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rP-3g;
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
Subject: [PATCH 07/20] sh: hw_breakpoint: Add missing forward declaration for arch_bp_generic_fields()
Date: Fri,  1 Mar 2024 22:02:21 +0100
Message-Id: <566af354bf51ddc38e9eb95eac51ec00c4e42024.1709326528.git.geert+renesas@glider.be>
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

arch/sh/kernel/hw_breakpoint.c:135:5: warning: no previous prototype for ‘arch_bp_generic_fields’ [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/hw_breakpoint.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 361a0f57bdebda6e..74a438cea6559efd 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -52,6 +52,8 @@ struct pmu;
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+extern int arch_bp_generic_fields(int sh_len, int sh_type, int *gen_len,
+				  int *gen_type);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
 				    struct arch_hw_breakpoint *hw);
-- 
2.34.1

