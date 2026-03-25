Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA026CE1E;
	Wed, 25 Mar 2026 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405497; cv=none; b=NBg9v3ANYuuf7nuS6Tvs/GZtral/XTrTUdSnwy+R8bEtIqci/PRcFiT5Bj90HO3jOSh7HMoW111X877D92I9hY7pcyW5+G5v8r89V+Z6oNgRyAXoqObXUYrZT9UZYmXMDCJ3k9jyqC9Mjuwant6J+CQsoluM053eJMpXNfI3Gdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405497; c=relaxed/simple;
	bh=EdwzNiOufKKen11BIke4WnuMNNTWzgjuKn7TyffWfJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ozSqBAn3DsjR51/9xDaW56yIlnBUC3urmb2D19F4WLY4LIzbqbnnKtNZ4xcRZkQu6Z7gcR8fWOBOWU3BDhOsdCmzQq+qqGQWn+mpNNStq5216kgGZ1OF/VViKgqd0OxruSFO+9PCbBbD0Wh6qKentn8qhG37RBNUzwbVdiPjGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSBsQF4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSBsQF4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E85C19424;
	Wed, 25 Mar 2026 02:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774405496;
	bh=EdwzNiOufKKen11BIke4WnuMNNTWzgjuKn7TyffWfJc=;
	h=From:To:Cc:Subject:Date:From;
	b=FSBsQF4SmAUutc4ZOAiup7gHXIFXr2EGm9Yzp5Ybg2Iq0AbA56ui99DfVxC100Hm8
	 gVB7hUmyrKvxYMt1q6tR0HrvfF40ZpBqn+ONeeVNUD6TYq37qbGetuOsL13owI5FOM
	 1N8ztEtC5sK8MAi8es37GDqXBLZstzUJ4+KF9LsColtCUM06iRkIVp/xNlJrP+qTR6
	 LzQPkeDAb9KWQrC6urOI9blIGvMov+DIUYJxnF3Jh9ySKSQPoIg9fEZHc1cPIJugu8
	 uwk3kISjpS9Ci5uiImETfHmK32IAP/y+IJHNJlizATTZsPgCqIFDtVhgnO+MmMdD6H
	 Pmch8a8D4d4Pg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v13 0/4] ring-buffer: Making persistent ring buffers robust
Date: Wed, 25 Mar 2026 11:24:51 +0900
Message-ID:  <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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

Here is the 13th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com/

In this version, I rebased it on ring-buffer/for-next.

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
