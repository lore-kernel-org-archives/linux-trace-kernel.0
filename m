Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C131716B;
	Thu, 12 Mar 2026 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318985; cv=none; b=pPkuHk8K9WtfmFuk8MnGYriJac2EsPIoXloC+ogMSPg7lXQBSAvfg6QGwOLVrcYfP5yfiClOqN5B9My+n84nEC1+qj3q5UG9lQmJG2KoR9MePc8lnX6XGa65ig4pJlTAqqUNS3iGH7o8H+6yMS6qY5pNFHJQVWwqCRsbSenC8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318985; c=relaxed/simple;
	bh=eGKTH9bclj2QFTyb+C8Rs4M2oiivfolw4uthzMvx9Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkykyE1y3lMAnHEHeJKYWNJ8NirjgYoqc+sKgLIRsmx85C/EqPMTR77x4M/XBpOqD2FXMLsUHbI+eyzSjmQK8iwu4wyuBxJqPAmn7DLTPEEi5YFc80o4xaYjfl1UgwcxwdfpC2F3GjQlqPdUYqBWcjFvV2gJT1VwkeE+B6MsoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvt1HKY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvt1HKY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9109C4CEF7;
	Thu, 12 Mar 2026 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773318984;
	bh=eGKTH9bclj2QFTyb+C8Rs4M2oiivfolw4uthzMvx9Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvt1HKY+MYFZ0TTCwvkCC6P+5uVDL/xgDUC/ox8E4Js40mSdbdq3bq+rXMY8W+s5i
	 aSzcuatkRa9bRK3SnVvdr9yXc5PTxI+Fi9qveM5n/Gv32fzHj5lJUBAj5DJ/gyydhL
	 T5ABVHkr/9fsCJ/uu4rXqcUvAt5jo3jTjHRW8pXS3dZwQLGNl+4KzMidVa3TFn31mW
	 8VCgiC0WWn9XmxgidwJoXxg/AIjTzm7XDWupwUyI9Ww9rujy9B08POzOY1C9olHvTG
	 8VZOGFPNo5eh21pNrLQiVThQhbg50NPhPSl1i9jf/NkkxOZzb01gJyjGtwvOTvQM/2
	 fCzqR0c8cN08w==
From: Arnd Bergmann <arnd@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: add more symbols to whitelist
Date: Thu, 12 Mar 2026 13:35:43 +0100
Message-Id: <20260312123601.625063-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260312123601.625063-1-arnd@kernel.org>
References: <20260312123601.625063-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds show a number of cryptic build errors from
hitting undefined symbols in simple_ring_buffer.o:

make[7]: *** [/home/arnd/arm-soc/kernel/trace/Makefile:147: kernel/trace/simple_ring_buffer.o.checked] Error 1

These happen with CONFIG_TRACE_BRANCH_PROFILING, CONFIG_KASAN_HW_TAGS,
CONFIG_STACKPROTECTOR, CONFIG_DEBUG_IRQFLAGS and indirectly from WARN_ON().

Add exceptions for each one that I have hit so far on arm64, x86_64 and arm
randconfig builds.

Other architectures likely hit additional ones, so it would be nice
to produce a little more verbose output that include the name of the
missing symbols directly.

Fixes: a717943d8ecc ("tracing: Check for undefined symbols in simple_ring_buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 3182e1bc1cf7..e3f8d6e619d2 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -138,6 +138,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 #
 UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
 UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
+UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
+UNDEFINED_ALLOWLIST += warn_bogus_irq_restore warn_slowpath_fmt __stack_chk_guard
 UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
 
 quiet_cmd_check_undefined = NM      $<
-- 
2.39.5

