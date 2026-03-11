Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430611A6836;
	Wed, 11 Mar 2026 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192736; cv=none; b=D4wyY4+aOqOkSJkCC2slV7YUYmwvS5Q1X5UDWP0bDWZv8A+DAj8s1STU703oNf3/RJEL/nSF0F/8oeX76uIJcdTLULSijWD4zQJtnOVIVOAjt84DeLDwS4b0K2gfDxl+J1oioS0lCB1HpF0MKJYpbEuA3Tx5ekgurIyqTRg+WrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192736; c=relaxed/simple;
	bh=1HO/vY+1IeyQdn0pKUFlC/kVALrZUNVkiHrQBOURaJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WxVcX+9IRp1rYKOSR+f1xvh2KaWR0NMNISUzdu9z7Pq7CiUTzJ5ExfGjm/O1zseEvjTc0QY6gk3JbPVFJ2I7vxhyllUVcpsJVJ38KUUem50jaCUdANxshuClckyU9vCa4pk6WO0sy6FdRQFUU0k7UzJjH765vHwg1GZGEs4E7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeYiNKtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeYiNKtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADAC2BC87;
	Wed, 11 Mar 2026 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773192736;
	bh=1HO/vY+1IeyQdn0pKUFlC/kVALrZUNVkiHrQBOURaJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=oeYiNKtvc9YLzuftEWpKgIKLrjDVgh0WFT9YdQhXHF8giW+Ehvq+q5Le6f0+pKzk4
	 PjfFtw8eXn7MZYF+vvIgiVsCwTNILcYdyz+PClrFrqysg20ZsbUru3HvIc5/PxrABT
	 CIenADs0B2rYFLJgoGbqc0jasUo5YQ35Ozief+baMv+qbssXuixOVj/6LXYfIes4X7
	 /lzgcag1Rs/KkTTKGn7nk3Y0Bq2CDNCi7EtLELBffQ5XXrxx804Ya+qmXyfyIk8+6u
	 EjJktvrkJ9cRGizboFLLnIQ7vC7EwBRdvI6hOrJcQoyjEUfi8mh7mygMKXfG9Fz2rU
	 FDegAoxeTQJjA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v9 0/4] ring-buffer: Making persistent ring buffers robust
Date: Wed, 11 Mar 2026 10:32:11 +0900
Message-ID:  <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
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

Here is the 9th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177303264034.767813.5345788067082238396.stgit@mhiramat.tok.corp.google.com/

In this version, I fixed bugs/typos in [2/4][3/4] and add a bugfix patch
[1/4] and a test[4/4]. Also, add a meta->subbuf_size validation[3/4].

Thank you,

---

Masami Hiramatsu (Google) (4):
      ring-buffer: Fix to update per-subbuf entries of persistent ring buffer
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
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
 include/asm-generic/ring_buffer.h    |   13 +++
 include/linux/ring_buffer.h          |    1 
 kernel/trace/Kconfig                 |   15 +++
 kernel/trace/ring_buffer.c           |  169 ++++++++++++++++++++++++++--------
 kernel/trace/trace.c                 |    4 +
 26 files changed, 192 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
