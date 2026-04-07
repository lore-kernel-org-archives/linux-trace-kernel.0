Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4432C8B;
	Tue,  7 Apr 2026 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524328; cv=none; b=slUI5BfNNeINcXK8wg8xRfOeSrCNoApIavtzpFGphk8jLnsSWnA5bbVdsct2w2hYmt763KZO7Pm31K4PTbSWPSa49belntX59YgkL8wJ4pG0U1zGs+rKive4bY50a+h9rew/fnatRVBuuzUMVlIqfP5VP5n0qu3yQO3PaBd7WhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524328; c=relaxed/simple;
	bh=nO7MSi9KtSPql9LxwJNNyWYq2uXlPbYAE6DXi5GoDx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R3Bvcm5ybSLD1Ux0JEBDreAz7sxVMtE0t4dM7vBoK3JtqYlmXjolGgZ+CQ4G0xBs/pMJPMNd4TmHu8xWWRUjZQ8oIFuM3hJl8EdTKdl/2oMGSujUCZzeCRB6AeYG52fa+YiW0p431IiiBN+uoInQFE2usKpESgW3gxSwaZ75nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0nS6YpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0nS6YpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752AC4CEF7;
	Tue,  7 Apr 2026 01:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524327;
	bh=nO7MSi9KtSPql9LxwJNNyWYq2uXlPbYAE6DXi5GoDx8=;
	h=From:To:Cc:Subject:Date:From;
	b=q0nS6YpIn/XY95Dc9c0JScdEgow0GNgFoWvCABNhSQumiHD1IqI1RCBPYx05FwwiL
	 rIvBaEg4vTLqa9OXswbZpB2eFpD8V8yIqy7BFEe7ScVehxNV4EVk6Cgnd1mVP5QRt6
	 HJClY0bilwHd8L4fjK+Pci1G8lKnxVmWzpbz7nxdG4d89gMGNRIeLw2+/q0C/vGAS3
	 OsDtOMyMDUcNfGisAm3lGHMwy0p8Cw1qvrX0OC5KQ2hqpHhQcU+OMzEmrkRVT4/mYK
	 5OKtFBwV3IkE/FX3ZusEwjypxvUHbcM/MMCJoGzpOLIxYeZ8+NnZcMND4PbdW1STb8
	 92ofE7IOfgeaw==
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
Subject: [RESEND PATCH v16 0/5] ring-buffer: Making persistent ring buffers robust
Date: Tue,  7 Apr 2026 10:12:02 +0900
Message-ID:  <177552432201.853249.5125045538812833325.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

[Resend this series with base-commit tag so that bot can apply this correctly]

Hi,

Here is the 16th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com/

This version adds Catalin's Ack [1/5] and update description and
document[4/5][5/5]. Also, rebased on ring-buffer/for-next.

Thank you,

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
 kernel/trace/Kconfig                 |   34 ++++
 kernel/trace/ring_buffer.c           |  258 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 276 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h


base-commit: 3515572dd068895ffd241b8a69399a0ebfac7593
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
