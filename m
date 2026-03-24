Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230D35DA65;
	Tue, 24 Mar 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310408; cv=none; b=IVXdLnqwBIMVziALD7HPGrClJvu9wAxu3Ax/JLSZlIpjqwr8F5YyWaQZeIlGKVFwayHTvGdZvmb5kTNwYI2nRT+3bxoPBtpCo446VRAA/K2lA5mB54sWMSYso7AZBhE2hN/eVe6rRnGqOb3X7xhbEzS4xBw0CjoG0ZN3+eNQXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310408; c=relaxed/simple;
	bh=xkd+qy+GhCDGDhgTuwj6e0/qYvYNkCkopurJmUAIGhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hnyNLbkeRT34dRhpGtm5q6SMuN/wtE/8csLS/JRVS/9yiutoHsnMh/H20eY+txBzpXep3a8uNxXbwuqNN3oV3f294lvhjaDwFaiQfFZwywJI3iDaiY4YfSAyVSDQhW10juDuiFf05fvwTIzlA1hd3CJPZpn1WhJPaj2558WwFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBetPDSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBetPDSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4AFC4CEF7;
	Tue, 24 Mar 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310408;
	bh=xkd+qy+GhCDGDhgTuwj6e0/qYvYNkCkopurJmUAIGhg=;
	h=From:To:Cc:Subject:Date:From;
	b=tBetPDSgOw7XYlJhA6SXitsridXISQlqrgy2y45yQQNBPrM9Q/PX537B5anJegeNQ
	 DPsoi0tXwAljo28AAP0x+MrTN6L8aN+LAHRLzW2MUSPv+8iKFASGWj4skhkm3/xLnV
	 kFn5ZMeFgFvvI1ucJ6VJacTGupv0xOFc62KSVOBBSAguCWQN7S35f1+KwP6c+Sekz0
	 YCFiKLsD3pN2zMDwNm7GPa0nxGQMZ3ephSqmcK7wyjKkdwVoYAgM2p9I5Iib9FWhZK
	 fjyMq8RAV6JxTeqkzHx2l3Dps7mVUdFYt5Z7VRcLGO5Xb2lDQo2EAuwXDWQ4bMslYO
	 iK+KeHiQcTUDw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers robust
Date: Tue, 24 Mar 2026 09:00:03 +0900
Message-ID:  <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
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
