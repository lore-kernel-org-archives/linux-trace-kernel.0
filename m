Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891C273D8D;
	Wed, 22 Apr 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874589; cv=none; b=c8gffRaCgjd0wk6q4yEJc/Vn56paJ6GS2XwJDgeeZalB1ZyN3facq+YihRRKPn5TsEtvA4plnDVl1lef9s4yuo4MqrAnhPvrfQdDjjKgG3SVoaUho8vVDi5jIZwb4fSoxcD1/kWTKKVJuZ7UiShW2Nxdtlzg+vTNFTpgeeKhxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874589; c=relaxed/simple;
	bh=91iXZSQqUVdF83EUnHj44pw4JQSZtIFD+ygd3Gd6kGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KyyrZQveeGmMlhbMRgUTsJW64ZofBKDokQecD2Y34Hs20vtZvupRTzwirepw+S0esqN5rZ1/C5kwpXHzIzM3unl7DwgJ2EcG2p0+RfNaVL+owKexupzX5zKGkgXJKi1Tnf/dtCtihlbpY9MqXOgg00bYjyq38B7vr26r+rYUq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFV/1QJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFV/1QJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE114C19425;
	Wed, 22 Apr 2026 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874588;
	bh=91iXZSQqUVdF83EUnHj44pw4JQSZtIFD+ygd3Gd6kGE=;
	h=From:To:Cc:Subject:Date:From;
	b=IFV/1QJJBBQNztikppzmAh8hG4Ib/DwAARChOy6jDkjTPHZqDcGP9RnySdIEXOf3c
	 R+s8ZuJ/9FLmMnRpke7tizFZEpQoIWc0dYbkw9gRJP9wH1jRjS36XGcDPHl+/lCHjN
	 G64NF6P0mLfKL2d+GFm5pbQLf581lwgL95ledXFPWRKkNEZd4ttjzHYl0h/KI8o52K
	 r4oFN3kkPpLM+i9FEvNVMv3lRN1hReANtTbJFsWIu2bJQGUCoEnqBOv5hfUqmqjn1E
	 7J+zwejym7DQu027WTNzAcNbvHKRd6iFt24AmYlADJ3V+22csp8vS9nLGKIYC+DHwB
	 FCT7P1ZbjG5rQ==
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
Subject: [PATCH v17 0/5] ring-buffer: Making persistent ring buffers robust
Date: Thu, 23 Apr 2026 01:16:26 +0900
Message-ID:  <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
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

Here is the 17th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com/

This version fixes some review comments from Sashiko[1], which
includes:
[2/5] Fix to use rb_page_size() of rewound pages for entry_bytes.
[3/5] - Fix to verify head_page at first before using its timestamp.
      - Reset timestamp if the page is invalid.
[4/5] - In rb_test_inject_invalid_pages(), changed entry_bytes and
       idx to unsigned long
      - Added NULL checks for cpu_buffer and meta.
      - In allocate_trace_buffer(), added a NULL check for tr->name
       before comparing it with strcmp.
[5/5] Added NULL check for dpage in rbm_show in ring_buffer.c.

[1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com

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
 kernel/trace/ring_buffer.c           |  275 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 
 26 files changed, 290 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h


base-commit: 6170922f137231b98fc568571befef63e1edff3f
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
