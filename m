Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6253A783B;
	Tue, 31 Mar 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946161; cv=none; b=kYviywQHi5F9BJvY0HNiRghzZIQFRG9ic0BQ9+lTZdmu3IrNau5L4OmgdhTnBhF+6r4Exw0qb82TQSWEpKTLZgZcHYd8rTtgbAHcDMKlHM2IlAbM0h7H59jPkESrlQM755xYhsVmcsLtaGjTkfgg3IL0diuGmery5YJm5n/bUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946161; c=relaxed/simple;
	bh=oeERGx74IOGltNC60r1Co69orfKTcrkSQWbL9r5xfaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXZQGKGML/OYwN9bkEbGN9F59L15ymydM5D6JNLs6CaN1CwQK+sZQKrs1G51+3xpqOoEO8tEneCZEcaPdMUf6wy/J+y5P8YuoS2SGuinukMVHl4RSeFAYgGtEoOt+dFpLMY2mevbFUYtyPgkXrjYDW57fprkz4TPiVIJ/bsXnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgNwe1tJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgNwe1tJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF19C19423;
	Tue, 31 Mar 2026 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946161;
	bh=oeERGx74IOGltNC60r1Co69orfKTcrkSQWbL9r5xfaU=;
	h=From:To:Cc:Subject:Date:From;
	b=UgNwe1tJoGXA3bt5bsQ2dQm/m6Wb6zypipr/Wt+bgLtb3DBt2a3sRABJQVa19hW45
	 zmQufn6LX6Oe4uKdt0hkdV/R2QO5FGmFevuy7IkgXQXg+cbDcm5PwcN7BxFAmshRJq
	 7JwifAZgdhk5yJFQN4ynWuh7IXvYaTGmu8o2Zo2WBGSsaY0xYVelh0Ycxb2dBN/vmM
	 +h8hWOPx+fIxvwgxUqu46B3K4kU7qBfbha1Q2DKuNIwYlNTZpFqhyObDMPKjZ7MnNI
	 wQSsDfjVLVV+tBIlvzmWuf/aWsgbWeGDekuz4bZFMlZlc4Dg9y2Qbi1X4gzptXd5UV
	 a48VQ8wyYQOpw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 0/5] ring-buffer: Making persistent ring buffers robust
Date: Tue, 31 Mar 2026 17:35:54 +0900
Message-ID:  <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 15th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com/

This version fixes warning if reader see contiguous multiple
empty (invalidated) pages on the recovered persistent ring buffer
[2/5], do not show discarded pages if it is 0 [2/5], use pr_warn()
for showing test result [4/5], and inject errors to the pages which
is multiples of 5 too[4/5].
This also drops "Reset RB_MISSED_* flags" patch, and add a patch
to show commit number on each data page [5/5] for debugging.

In this version, I added arm64 maitainers to request their
review for [1/5], which introduces asm/ring_buffer.h for flushing
the cache before reboot.

Thank you,

---

Masami Hiramatsu (Google) (5):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer invalid-page inject test
      ring-buffer: Show commit numbers in buffer_meta file


 arch/alpha/include/asm/Kbuild        |    1 
 arch/arc/include/asm/Kbuild          |    1 
 arch/arm/include/asm/Kbuild          |    1 
 arch/arm64/include/asm/ring_buffer.h |   10 +
 arch/csky/include/asm/Kbuild         |    1 
 arch/hexagon/include/asm/Kbuild      |    1 
 arch/loongarch/include/asm/Kbuild    |    1 
 arch/m68k/include/asm/Kbuild         |    1 
 arch/microblaze/include/asm/Kbuild   |    1 
 arch/mips/include/asm/Kbuild         |    1 
 arch/nios2/include/asm/Kbuild        |    1 
 arch/openrisc/include/asm/Kbuild     |    1 
 arch/parisc/include/asm/Kbuild       |    1 
 arch/powerpc/include/asm/Kbuild      |    1 
 arch/riscv/include/asm/Kbuild        |    1 
 arch/s390/include/asm/Kbuild         |    1 
 arch/sh/include/asm/Kbuild           |    1 
 arch/sparc/include/asm/Kbuild        |    1 
 arch/um/include/asm/Kbuild           |    1 
 arch/x86/include/asm/Kbuild          |    1 
 arch/xtensa/include/asm/Kbuild       |    1 
 include/asm-generic/ring_buffer.h    |   13 ++
 include/linux/ring_buffer.h          |    1 
 kernel/trace/Kconfig                 |   31 ++++
 kernel/trace/ring_buffer.c           |  258 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 273 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
