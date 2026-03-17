Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFF315D58;
	Tue, 17 Mar 2026 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740180; cv=none; b=F0YLL2MaWiJElmVtcZ8ymM6y0UKbSZ5lNHJW2ADulRf2buFpoapcBCja+IJzFWnZovBT43IAKlRU92wg6BQ0HNSJBkC9k79d0SBkk2EAIKYrPcwV4fTwDJjV1AUPIDDWxfLjHYsN0C1KD01Bp88dyZxeso21vPICYHAUaFWnulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740180; c=relaxed/simple;
	bh=ZrIRXzeCwdaHt9BYvjYI6HieIvtt0unayHDWHveDKsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qnmol5ydJpbafDc4XCeUkbc7f1KSKCz+D/1nqEPo3BPCfaXhFmaLBL56PtuWvt2jiBezZS1ZMOsk/pRG4qg5PW7YKm7HKA27tN/YuGFZOmWR6MK11mu9PrOK55v/w6c2mQvxsUcCfCJjngMLtV/PdL2L8eevCoTCtWXPiwy8mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt2pJroH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt2pJroH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F16EC4CEF7;
	Tue, 17 Mar 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740180;
	bh=ZrIRXzeCwdaHt9BYvjYI6HieIvtt0unayHDWHveDKsg=;
	h=From:To:Cc:Subject:Date:From;
	b=qt2pJroHUy76tGcWzrtuFGVzprYL2fuq1kWGeIGgQcfMDN+9KVqYvquizmF57OcAg
	 r0a45jjAXuaaWgtomQK01gylBFG5tWTF14SOe57hAmlI9lYwwxfS+9jAS82v40TgLQ
	 rkGU+YCRMCpZfkve9aujvdRh4ochszJv14H/M8iuGBqo/Cfd/EX0UDXo9a52bHGGGb
	 yJDiBW2KEVI0Z0RiEp5VMUsIJhdKqc+sTjuivd42K8Pjtv1UYYTyZ7jc7EQ4oVJRmN
	 zr0Zt15BQ/9+dPllTe7g1Q1Ge6jez71qzqxtv3IxGZCN0IzG7w0FEWnWRupteO4yPn
	 7ekeKhiYDnxQQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v10 0/5] ring-buffer: Making persistent ring buffers robust
Date: Tue, 17 Mar 2026 18:36:15 +0900
Message-ID:  <177374017536.2358053.12341235939816794384.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
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

Here is the 10th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com/

In this version, I added a new patch to skip invalid page in rewinding
process[4/5], add entry_bytes check in the test [5/5] and do not
compile test code when CONFIG_RING_BUFFER_PERSISTENT_SELFTEST=n[5/5].

Thank you,

---

Masami Hiramatsu (Google) (5):
      ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer selftest


 arch/alpha/include/asm/Kbuild        |    1 
 arch/arc/include/asm/Kbuild          |    1 
 arch/arm/include/asm/Kbuild          |    1 
 arch/arm64/include/asm/ring_buffer.h |   10 ++
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
 kernel/trace/ring_buffer.c           |  226 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 233 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
