Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1331328E;
	Tue, 16 Jun 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628138; cv=none; b=prLwFgBbh1XrwoRmAxguhUDhCzbqS/mQOyoYRBRdThh/r+EVzQPP4E4ItywZSic0SF5zpQQzO6B347nfJJanZJnev7VTjz/bX788r2Le/p3+NQkXpNyN7VkAnpKgqI//qpk0OdcEbtS4RrjCJ7cTozKFFmLn/09wgM91sjhS/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628138; c=relaxed/simple;
	bh=sO6Rq1HFjWDOC9JKKlYka0EEACZ6aTS/VbjLiITeHpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyldcuA+7+Oh5d3Mf7EWVCNstNz66MThPljvXNjt1U0vH88AMhc7LnikXhbKOe+uENmYt8smYyo6mzNXaaXIMCRCFKcMrsmPd7HdjS2DeEDpf2FGHVwveBpVD0U8AdB+5RotRI6YD9wOPvlSpomEh0076AdN1iUCDWL/GK+o+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhSql8sh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhSql8sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F631F00A3A;
	Tue, 16 Jun 2026 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628137;
	bh=WaY/rbS420Gmc1Tqy6etdzSmMfvQbWA42QK9YPs6A5U=;
	h=From:To:Cc:Subject:Date;
	b=XhSql8sh87/tp6TBHWKqpN65v4P0k4fKzWPMNKZKHC4GWdtUj1s6vUatd/ORqqHCL
	 5H9Z19S7QpU4FlllNqKEvNYD4eOUHzCbTcxzTpIpkzCJPGYuCjjKYtFhOTudPc1Pal
	 FuMgfBteJs6CIzTHTHdLR7mnEykAOGMLn2gKhJxPhqPAN6DIjr1Ts4V/tla4D4wfXm
	 00OdL62+6f/bteUmNxQVdwtqR27yxqfVg1oVgHfuz1UKFWebeqiMKxksI5i8DzmX0J
	 Ke9mUnSxGwVP76pxFjnLbdqK9xBldd7urmc0tDnaOSYsKRIHEFyv0Bhev7COTYAiuJ
	 5HgGsUAxUydsQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] tracing: ring-buffer: allowlist clang-generated symbols
Date: Tue, 16 Jun 2026 18:42:03 +0200
Message-Id: <20260616164211.3733326-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In randconfig build testing using clang-22, I came across two
sets of extra symbols in the ring buffer code that may get
inserted by the compiler:

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
         U memset

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
                 U llvm_gcda_emit_arcs
                 U llvm_gcda_emit_function
                 U llvm_gcda_end_file
                 U llvm_gcda_start_file
                 U llvm_gcda_summary_info
                 U llvm_gcov_init

Add all of these to the allowlist.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..aa8564fb8ff4 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -146,6 +146,7 @@ KASAN_SANITIZE_undefsyms_base.o := y
 
 UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
 		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
+		      memset llvm_gcda llvm_gcov \
 		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
-- 
2.39.5

