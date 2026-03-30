Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F103D1CA4;
	Mon, 30 Mar 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874991; cv=none; b=UmUNq2AQ5kkPOSR5YSVQxtf0WBEuztPzzCEFmPI4ZW+E/CREp4UIUTAmRXpSO/bH8TZ3DqWc5Sz8n0N8lDbA3LEGAK+/d6uEpVFvK3CWkNSxLvMs8EjmCJ6bIpp04RrejlQGYt6F1dcAOZoNfXUK7XGXxELi5mYOQRchZnqQDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874991; c=relaxed/simple;
	bh=G/VIDBqSh4xil9WbZGAtAfRBXg+/JK//s4B34pIUHnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVcSpMg8TTUGkmELVG7ShbkT9+nQADEcuGh5MDaHEGbwacALKXcl3orRvtn2Fd4BaNojHZH7cdCMkhRXS7iUhotue2LHFNTuUtIFKCXqgSEm8l2KKg9V6l97Ar76ODQBvoDy4WOPEkEnbTKKEPgjHHn30kJuE/Vwb/pbQDvs3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s92XWz9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s92XWz9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFAFC4CEF7;
	Mon, 30 Mar 2026 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874991;
	bh=G/VIDBqSh4xil9WbZGAtAfRBXg+/JK//s4B34pIUHnk=;
	h=From:To:Cc:Subject:Date:From;
	b=s92XWz9GFC608jjTYKZ9ESM4HC1Xp55qLPI+xXACgrjINDbub7Hazbl2C/5YQW7ED
	 TfzoE5xLIEjfhoTXsPT6MEhtMniQ/ny+9502iDQzz2dowminUl9IU9JJ33l8uQUu3a
	 wuewCo2NyA6XygjEHGr+9UPjcDU9LCElzqdiy+QyowakE5klhSe1cUSsAX7GNwe+db
	 RhdheNrfKg3mlZeU+kQrAglc4wu5pGu4ZjRK8bApLkxV0mW2ZLFtkQ1HjXS8dwwAAr
	 HzG2TLMcJuqFryNTI40tdTbZ1k+pztM0szucN692t1Q7W/Lw8PpnvtwGJUbAX9Xj/C
	 60F3Z1ouvptrg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v14 0/5] ring-buffer: Making persistent ring buffers robust
Date: Mon, 30 Mar 2026 21:49:45 +0900
Message-ID:  <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
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

Here is the 14th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com/

This version adds a patch to reset RB_MISSED_* flags when validating
persistent ring buffer [4/5] and renames selftest config to
CONFIG_RING_BUFFER_PERSISTENT_INJECT, clears meta->nr_invalid/entry_bytes
after testing and adds test commands in config comment.[5/5]

I heard the first 3 patches are already under tested, but it is
not pushed yet. So I left those in this version.

Thank you,

---

Masami Hiramatsu (Google) (5):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Reset RB_MISSED_* flags on persistent ring buffer
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
 kernel/trace/Kconfig                 |   31 ++++
 kernel/trace/ring_buffer.c           |  240 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 260 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
