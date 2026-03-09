Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857313B5AE;
	Mon,  9 Mar 2026 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032646; cv=none; b=IRAbSvUCjFsX5YbOEMd7jkmH6k1TNhA+JEg/KFcCL7pCEJGtHTy9Y59rVecH/UDKcGuniDR1D+psLebmidO4Am/L6IdGs4HX8EAfG/oXVS1nRv35AIjJ7iYkRJ97sWbgw/IxqDBT5d7v3ESUOQt1QqUBZtZnrdnh+74lCy+Tjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032646; c=relaxed/simple;
	bh=0V566kUojQFoiJdd3pYhva4g/zVIXa7w/0u0q9IVY9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YaoBOjJ0uOTxjOCKYaA8odfC7GswqLl2jj0fH2XTDTPYUl4QRPjOGftIk4GxaetB0RlXKaKr40/e3eexJWtPhJbJnHrekA+ZNzuxdpnghNoBtNLVh09rST5rtBKD6xpFGqaeIvWGaSwLrRqzGr9DMVFh+fWdvub4fOeGq4zVZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b31f9xtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b31f9xtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F2C2BC86;
	Mon,  9 Mar 2026 05:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773032645;
	bh=0V566kUojQFoiJdd3pYhva4g/zVIXa7w/0u0q9IVY9s=;
	h=From:To:Cc:Subject:Date:From;
	b=b31f9xtMmsxFh+E36W+W25IatjGTpG4cICLsKidXxZkKQZplbILZGrr7/e4r/M06k
	 VfX0oB+FUrIdV2lteut7eeXaRiME43O7wTxazULEL5cqU9alIdxw52x05k8mX6kVhZ
	 TQPp9/UbbIm3LtitykfaPrFjtaI4q/jCpn8HYOAmRftxbdUTjCvrT3NBcdjIQMCiO6
	 uNMNLdQ3MHBgF9M2+ssOz5nAlDz/HmfmCBFKDkhkrDl7904THB5njUg8Dy44QRuNa6
	 GTh0f3ZRLp3BhpXfTtRTn3wTmoaDQG4Y70pDFpGNoSPDnMcM/UN78frNVy1EcpOd7A
	 HRoYzbYfS/Vjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] ring-buffer: Making persistent ring buffers robust
Date: Mon,  9 Mar 2026 14:04:00 +0900
Message-ID:  <177303264034.767813.5345788067082238396.stgit@mhiramat.tok.corp.google.com>
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

Here is the 8th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177289358078.248514.14947007976699929481.stgit@devnote2/

In this version, I cleaned up and add comments, remove unused var,
and clear RB_MISSED_* flags when reading recovered subbufs.[1/2]

Thank you,

---

Masami Hiramatsu (Google) (2):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer


 arch/alpha/include/asm/Kbuild        |    1 
 arch/arc/include/asm/Kbuild          |    1 
 arch/arm/include/asm/Kbuild          |    1 
 arch/arm64/include/asm/ring_buffer.h |   10 +++
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
 include/asm-generic/ring_buffer.h    |   13 ++++
 kernel/trace/ring_buffer.c           |  102 ++++++++++++++++++++++------------
 23 files changed, 109 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
