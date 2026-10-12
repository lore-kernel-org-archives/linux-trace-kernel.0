Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E63F8707;
	Mon, 12 Oct 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807956; cv=none; b=uH9fFBU11AqhfNSqvfV6s6H225FRlpYpfy1arFRfLwlAZLZpsaGyXc4Z+5p+52tZA0Wq7j3VTXPxNrrSOpRyO4+i1YDhHbDd+xPjdSxHNYLl+dxhBDOCZfLeP+2l8EEWg7RvAqi8Hy9I8ozXJa9I1bWeSl6oCpK5DjVZC7+J4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807956; c=relaxed/simple;
	bh=ls+fPlVIKZx64wvAXNgsJznol3yq4hINaZBdIlP34mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4iR3fbNXhqdOAD77LKn5nMePQs87u4frtZ15gMtTUoqtMLXyJSh3mJzcwwu5yMJRPLRGgrtA54C/WimZY6eksdbOsjuzIvFqH1cLiMEZt07oyFUM0am1vrSUcoiGSd5MHUht/cfOXo8c8ocx5tMg4E6wfaWO/DVZiSu8lxQqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-185-035.092.209.pools.vodafone-ip.de ([92.209.185.35] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1xGF66-00000001gj8-0tXr;
	Mon, 12 Oct 2026 14:25:42 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Martin Kaiser <martin@kaiser.cx>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] ftrace: remove unused make_call_t0
Date: Mon, 12 Oct 2026 14:24:40 +0200
Message-ID: <20261012122516.90961-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The make_call_t0 macro has been unused since commit b21cdb9523e5
("riscv: ftrace: support direct call using call_ops"). Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/riscv/include/asm/ftrace.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index e5026cd8f022..61849c1d71f5 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -95,14 +95,6 @@ struct dyn_arch_ftrace {
 	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_T0) :	\
 	((offset & AUIPC_OFFSET_MASK) | AUIPC_T0))
 
-#define make_call_t0(caller, callee, call)				\
-do {									\
-	unsigned int offset =						\
-		(unsigned long) (callee) - (unsigned long) (caller);	\
-	call[0] = to_auipc_t0(offset);					\
-	call[1] = to_jalr_t0(offset);					\
-} while (0)
-
 /*
  * Only the jalr insn in the auipc+jalr is patched, so we make it 4
  * bytes here.
-- 
2.43.7

