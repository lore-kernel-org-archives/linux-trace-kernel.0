Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A4823DD;
	Fri, 24 Apr 2026 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013525; cv=none; b=qWZLC9FtdsJZgQCBc/ZZxW1N/n9vYewfYIbk/yUrLsrBjS6iBkAxz8iELs8sLt+HV7andS1gCPLSdl5AMm7L6pU0WugC8WEswkRERgGg6DSz59O7ONdd1XvDWUUm42IolcI7kHIDz+ztOKTMANfQtk0Mhadc9Vgn/QwaD0ARmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013525; c=relaxed/simple;
	bh=3Pkgxb3AaO1XuEUmAmnS4l7BYM6AORThEKZp5fWQTI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXjm0zklh9rnUHXQPp1EvGAc9tFI7woqgGYNRXwKDx+cC3+XD+z4HWLO5DGQedDGi4T1T3mDLiQyhEqUka12iW6djCXm149yu/wPleyrjkEJqlZ8UaLzCY0hFPoHgVuqTeSu+4zdv3d/oKmgCK4MZHGYW2KGAmqJ0tTWTvtNDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umEbRDaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umEbRDaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39244C19425;
	Fri, 24 Apr 2026 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013525;
	bh=3Pkgxb3AaO1XuEUmAmnS4l7BYM6AORThEKZp5fWQTI0=;
	h=From:To:Cc:Subject:Date:From;
	b=umEbRDaFAgKrUbp5k24rIFyf59WDdYS0hUE5hImkUf3jyg+J8yglF7Ow2FhkgHiS7
	 0sJmyxiyZMzYij5THZnDg+jv1DAjqpJYw+OsGJ9ZdMrPQYQrzuEr47q9uFRNT8OWcz
	 KzwP9RZ9Pm1GxSLKJX45PXv3XxNZ+TDVMV1wCVB6LswHuAw8I0vxG6Ot5w3gfYbRcW
	 DrJpzFGOFCXCPmlsUS9pLwoeWZncTV4D00LOeNcPNS93dGUtEIGALLQCs6R5XWdUmq
	 3DVShoF6wARZx7VzaIvzwcY2J6gF5z5/lK4wpOErypXdx8PNMWhtrn49bcQRL95Bd0
	 5ikQ6GFQNowMw==
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
Subject: [PATCH v18 0/8] ring-buffer: Making persistent ring buffers robust
Date: Fri, 24 Apr 2026 15:51:59 +0900
Message-ID:  <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
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

Here is the 18th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com/

This version fixes a newly found bug and some review comments from
Sashiko[1], also, add 2 cleanups, which includes:
[1/8] Do not double count the reader_page when verifying persistent
      ring buffer.
[2/8] Add Geert's Ack (Thanks!)
[3/8] Fix to substract BUF_PAGE_HDR_SIZE from meta->subbuf_size
      to make the limit of commit size.
[4/8] Reset timestamp of reader_page when the entire cpu_buffer is
      invalid.
[5/8] In rb_test_inject_invalid_pages(), changed entry_bytes and
      idx to unsigned long.
[7/8] Cleanup persistent ring buffer validation code.
[8/8] Cleanup buffer_data_page related code.

[1] https://sashiko.dev/#/patchset/177687458572.932171.10907864814735342737.stgit%40mhiramat.tok.corp.google.com

Thank you,

Masami Hiramatsu (Google) (8):
      ring-buffer: Do not double count the reader_page
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
      ring-buffer: Add persistent ring buffer invalid-page inject test
      ring-buffer: Show commit numbers in buffer_meta file
      ring-buffer: Cleanup persistent ring buffer validation
      ring-buffer: Cleanup buffer_data_page related code


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
 include/asm-generic/ring_buffer.h    |   13 +
 include/linux/ring_buffer.h          |    1 
 kernel/trace/Kconfig                 |   34 ++
 kernel/trace/ring_buffer.c           |  472 +++++++++++++++++++++++-----------
 kernel/trace/trace.c                 |    4 
 26 files changed, 395 insertions(+), 159 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h


base-commit: 6170922f137231b98fc568571befef63e1edff3f
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
