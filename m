Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51776288517;
	Mon,  6 Apr 2026 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471061; cv=none; b=LbCT/yPU21jq3YNYCahrZknp99Qk8ouJzQJdRfIHrlnyXdmuAkXEcJjwc60aKrNg99ZpdXR/NQMSoW+yR7p55KV1/HN6rmvghFc+aXESq/MBqzrueCcd1MeEkzbmmonnn+Q5glkjKvxFfi5Q/uOz80RT2zsJXi+pZebhSzctJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471061; c=relaxed/simple;
	bh=ubGAF3hmNHjU6MfkJrHCEAvksWtUTwkbDSHXUbQhCAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhK6qDxdJuFF4AsIi93PRsSDZZSUqpMuJOk8G2XXzY4fRq3ar1NsqeY38Nclc0dnt+1n1LfrVaEiDEw9aIombTbrgy8Wl9ePBAgS1ZLCgIY3Y2zQm11Mw8Rw8D5Ji34NzP6F4ucNg04h0wrcR0jrdGE3uBPsT6+BiPoJ1js8KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFHrsq/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFHrsq/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38BDC4CEF7;
	Mon,  6 Apr 2026 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471060;
	bh=ubGAF3hmNHjU6MfkJrHCEAvksWtUTwkbDSHXUbQhCAU=;
	h=From:To:Cc:Subject:Date:From;
	b=QFHrsq/q2wpxQuzvj1SsFmhxmS9D2n8LP5jIdj1HElrFvEaGTh86cH0aMzRqJdEK0
	 OQZDQaoWG94eXEYJWUuiVGmiQ724LFQt5tZRGIYNTjkFTwMypQETM98y8s1pzitxJo
	 /cLQxHntDJriW923zOV3VM7JC7tVd+7w2E2Ldk5R8+36/Mwi56Zhb9+FtvqR0PAOnh
	 iGHflaVZA44Ke7RqLK48ti5OShDY61C9CO7G1n1E3FOt/t8zm82cmesLu8ZA46CZp7
	 ITdjGTb9Pr+VXKJP8pr+weNk+gXyX+LNy1HiWQTWj2PFLASAjko3nhas7lttqPKUkm
	 QcXfLAE4/5WLw==
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
Subject: [PATCH v16 0/5] ring-buffer: Making persistent ring buffers robust
Date: Mon,  6 Apr 2026 19:24:15 +0900
Message-ID:  <177547105523.259641.14385891517704197263.stgit@mhiramat.tok.corp.google.com>
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

Hi,

Here is the 16th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com/

This version adds Catalin's Ack [1/5] and update description and
document[4/5][5/5]. Also, rebased on ring-buffer/for-next.

Thank you,

---

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

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
