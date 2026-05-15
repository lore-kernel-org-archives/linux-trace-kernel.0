Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603046AF00;
	Fri, 15 May 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842643; cv=none; b=sw6GQVqbqCbdMArP366tHHLaVEO99KIN5R9nhSfCCmFkYE/WRa9JM3Kwm1+vpg2HhLMeMgF+UrHgVWHgwpJna7TScVRy7FOddtE68gk3C84s2rJzDJdSZr+u/O4qnYYuTyGwAehkBFQO7NxmgF4X3y1kcC2bMarmO0wskLHhNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842643; c=relaxed/simple;
	bh=LqXpU0eLoolNaYSGQGrBUswa+ZL27uaoziW+Ze/dzlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7a7Da32ozs/gvReWGkqPqIZfwbQ43P86ewqq952n1PN2yF67/oQqTay+f2RGSIBprJXewYzM/Y34+ltM1bGTdIEvvJi0fhSIYEI+I9RddLbbfEFc3BOMby2f6Buwc+GeZH65GaX3PkYJ6KL59aKdmcFAUvST+Q6n77erSsPWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A00PZxIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A00PZxIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF2C2BCB0;
	Fri, 15 May 2026 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778842642;
	bh=LqXpU0eLoolNaYSGQGrBUswa+ZL27uaoziW+Ze/dzlc=;
	h=From:To:Cc:Subject:Date:From;
	b=A00PZxIsj8/TWyEbTAGrK3daBUuy8Ept+yDveA7FOw4pkStY8/YnLTgQutYyCFyFl
	 oz8k092RwHbqxrxmCoa75nL8NliOs/RY25HQSLd22f5ugLgXCoM2/+oGejFl/tio4g
	 KIvbNWsldhwkImoeVlUC7ppOd6EQIe/u8AsNyVsrWCRem3J84QMN9JBcAjN8tCqvg8
	 2lbrkdflGQpBaBDWHLwpreQIv+eN76zA2o++Ax4WQZdEOMGzspxanPRVLQ6G46ErmA
	 bG5Jk47wBu2u3/V3Hq0lYOAKEOt9d8P9HB+ecDQyp3GI4Cx9NGEsKPHszVINXAnZBr
	 eonK0X7FfBspA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] [v2] tracing: samples: avoid unexpected symbol warnings (arm, s390)
Date: Fri, 15 May 2026 12:57:09 +0200
Message-Id: <20260515105717.1023007-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The now more verbose check found more architecture specific symbol
missing from the whitelist, during randconfig testing on s390
and 32-bit arm:

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
         U __aeabi_unwind_cpp_pr1

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
                 U __s390_indirect_jump_r1
                 U __s390_indirect_jump_r10
                 U __s390_indirect_jump_r14
                 U __s390_indirect_jump_r2
                 U __s390_indirect_jump_r5
                 U __s390_indirect_jump_r7
                 U __s390_indirect_jump_r8
                 U __s390_indirect_jump_r9
make[6]: *** [/home/arnd/arm-soc/kernel/trace/Makefile:160: kernel/trace/simple_ring_buffer.o.checked] Error 1

Add these to the list and keep it roughly sorted into sanitizer
and architecture symbols.

Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add both s390 and arm symbols
---
 kernel/trace/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 1decdce8cbef..9b0834134cae 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -143,8 +143,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 targets += undefsyms_base.o
 KASAN_SANITIZE_undefsyms_base.o := y
 
-UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
-		      __msan simple_ring_buffer \
+UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
+		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
 		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
-- 
2.39.5

