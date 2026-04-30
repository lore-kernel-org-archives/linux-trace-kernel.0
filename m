Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2126A08F;
	Thu, 30 Apr 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519691; cv=none; b=OSg/vz8gsk2sFuHE65VseSrZPncg5sivPtejQ2NktnNtPWtSd4EOEFd6GWfGb+VL59d0clQw2bLbg0bx4FdhTTZax9bSM1GeEM4d62u796p370UdeJCJbZdscKCqi9vQNZh7H1FRlxA4pnwnzg7K+bYFHL7IVEyjNv7s8ufxysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519691; c=relaxed/simple;
	bh=k2A+kUVVRq4Ta7CpDmynAO3yQaUxHFRQg/EdEUOsSQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cs/owk6M2VdWScN4F7iCtNJhvVv3E214GAgUwGbbMUflaS1wzuZ1eN81rorODjZU/tSFKbQzXrPdydBiiW0JuLflDxyqkECXvzeMs2ODZ8PD4JagFcXF3Vjbm+ycUItTkOMOBpe1ZSH6R/vYJ8NGnTOqyrKWZqYPNp9ndXYbUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwnW3ZlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwnW3ZlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E02C2BCB8;
	Thu, 30 Apr 2026 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519690;
	bh=k2A+kUVVRq4Ta7CpDmynAO3yQaUxHFRQg/EdEUOsSQg=;
	h=From:To:Cc:Subject:Date:From;
	b=TwnW3ZlBdw/gKupgDdgPK/QWOkwACyys/Mwkd9jkswiXbo9nlZJTK3Y7QRuIxfT1W
	 Ud2wYYkTo1p5DTLBTZHmLW2hl8A1q1coyxXkLDJWz6d2ubD+8vly3xoo+JsjIsMHV9
	 l821ni6Ar2xfK7kYdIYQ+4wT0Rioy8vr+1CIfZaDlKkWMryis/jNmAyYSwPsUNKjFf
	 FhNvrplxUB4hRz0kGXAAaCkxpXdyUZrDF31rNDpESBEf372BkBNkoBdkCnWxBiv/z/
	 eY1zMbih658u8w1tn2CEnY0UVesy5E4xRFHZq05GPVhCiAWnfQz/DACVZ0pjb+Q9Vj
	 AhsQh+9+nwZkQ==
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
Subject: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers robust
Date: Thu, 30 Apr 2026 12:28:05 +0900
Message-ID:  <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
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

Here is the 19th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com/

This version rebased on v7.1-rc1 and cleanup code.

[2/7] Limit max number of loops to nr_pages in __rb_get_reader_page()
      and update comment.
[3/7] Cleanup rb_validate_buffer() so that it is more readable,
      and add a comment about the timestamp validation.
[6/7] Add a kerneldoc about rb_validate_buffer().

Thank you,

Masami Hiramatsu (Google) (7):
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
 kernel/trace/ring_buffer.c           |  490 +++++++++++++++++++++++-----------
 kernel/trace/trace.c                 |    4 
 26 files changed, 415 insertions(+), 157 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
