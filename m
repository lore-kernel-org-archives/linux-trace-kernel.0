Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DA39F192;
	Mon, 23 Mar 2026 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269052; cv=none; b=BH9vji8gq7QNTnEYZeBNKbr0iw4tlvUvc7fwJfQP7K+Xs/GOuUmb7X/SFtszw4AI2PIlVnnVXAwZqik+fUy/xxUKJdJSpigNHJaTdHvr2aHcHvoHJa7Hn8/WJHSa5MEhga9aLd2r+fq1gXBR67v9G/c9khOdaX+JRU3nOlIxVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269052; c=relaxed/simple;
	bh=xkd+qy+GhCDGDhgTuwj6e0/qYvYNkCkopurJmUAIGhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oBvamAKz+8PSSOwUal7qcNA1svSgUoimGOt3fuTlFD+ONbv145+guIIgotOkpfp7+4Fvyh8oQqR6Xi8Ffq/2K6W1jtbjlsny6xtdMKAmA/GJDeYg/4yY8vA11GBT/ely9i49A1CDVoYcNWIfFaWhox16tV+TkwvyCaHjLxaULOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SousEdGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SousEdGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68326C2BC87;
	Mon, 23 Mar 2026 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774269051;
	bh=xkd+qy+GhCDGDhgTuwj6e0/qYvYNkCkopurJmUAIGhg=;
	h=From:To:Cc:Subject:Date:From;
	b=SousEdGruVhHjnLG3ia1MGy7Ub7xuDLe/rVEGuNtakOnGNbrgAoqzmR9uO4tldkor
	 2H54PadobuqhAXHv36w7/XMogpeZGe6DfXVkgTquaAfO4Ub+wAtFxzL5wWhIopc3RO
	 xrxelI/KtPs7Q0T7QFCzqpjzZvLNnU1iTc8fP3sYWJL4ueb8tFvBgnVKAofY3n9pW4
	 gkQiy1VEz/0vB6Wkv7IZ/I9nSqhSzivwXJpfiRShzw/v1nXKfrVz4HxHqCup/JWqUX
	 ejoJxueUY2wCoO0Q2K1ecC/AdM6fadk4N0/8q9XMlzUr6CTGc/ybO/dQ3vux2WUmwJ
	 TxBk7HQlWcMKw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v11 0/4] ring-buffer: Making persistent ring buffers robust
Date: Mon, 23 Mar 2026 21:30:45 +0900
Message-ID:  <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
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

Here is the 12th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com/


In this version, I rebased it on tracing/fixes branch (thus
the first fix patch has been removed) and fixed
a build error which came from a copy-paste mistake.

Thank you,

---

Masami Hiramatsu (Google) (4):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer selftest


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
 kernel/trace/Kconfig                 |   15 ++
 kernel/trace/ring_buffer.c           |  237 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 241 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
