Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14639098F;
	Mon, 23 Mar 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263412; cv=none; b=IdqjjiAmed+oAG9bQVbx3anRl4o+IJJWSAW4u7vLtPZS1AybNiv+qD+lMd5iaF7Vx2WwikaccAdKZxTRe97/IvIEjUyABl0rFe6CKs/Lwi9X+XsF/+mNiRuF4ufcT8EIihqzzHYrwmXg3Xhf5dtdbVZE43QvwW1UI416BZRVDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263412; c=relaxed/simple;
	bh=z1xhwzaARyNzuXX3osp8vX55EEiIeSnvx60kQvGXFXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeCyh6ekYj1yvKqB3ZKktZ5ItZSwocMt59fTSdsufhLUQNFZkHSfQE2eXoSpOpri/htwU/Nbc8v+Gol46iLXh0McTUuPbZSm844z+MLeRpLdIpGC4fsSQHuUWKH7H4po+rLjDkCBXvXjXmWjhIstwSZWelZJU6Mp/cQYFPE+Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNlKCnmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNlKCnmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4BC4CEF7;
	Mon, 23 Mar 2026 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263411;
	bh=z1xhwzaARyNzuXX3osp8vX55EEiIeSnvx60kQvGXFXo=;
	h=From:To:Cc:Subject:Date:From;
	b=VNlKCnmC+m4HxNRedUUp9sCW7E9GaLd4XZLf0Ubw64l61GxrL7ak/CeVMyWnloB+B
	 JOFd2LMClPf+YtPnW/6NFnKdE/v3YqTkes6vC3SQsn5zIhfeo8DmA4GED5noMUp/W3
	 lgjellLGmhW+I4vl66rWvyGzcwvBgh6Bv+q4ZASJLXARW2IeUhqsQb6FnhFQtjhM1i
	 mvhDx29Sc4Jhab0mGwtB+es4F1kk444OqH2LZqIQayN7YXIZQD4uLeTGyjQe9eitge
	 cU1UUL0GUpFq7BteyiimIjtVW2ppkhmkFdv1Pqxtl+mTbs+3eAqF5ekHdEtvVca8fd
	 tAgVs+ti1lZGA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: samples: avoid warning about __aeabi_unwind_cpp_pr1
Date: Mon, 23 Mar 2026 11:56:41 +0100
Message-Id: <20260323105646.590718-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The now more verbose check found another symbol missing from the whitelist:

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
         U __aeabi_unwind_cpp_pr1

Add this to the Makefile.

Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index d662c1a64cd5..aba6a25db17b 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -169,8 +169,8 @@ targets += undefsyms_base.o
 # because it is not linked into vmlinux.
 KASAN_SANITIZE_undefsyms_base.o := y
 
-UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
-		      __msan simple_ring_buffer \
+UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
+		      __x86_indirect_thunk __aeabi_unwind_cpp simple_ring_buffer \
 		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
 
 quiet_cmd_check_undefined = NM      $<
-- 
2.39.5

