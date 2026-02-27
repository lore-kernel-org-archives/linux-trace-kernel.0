Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FB301465;
	Fri, 27 Feb 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184022; cv=none; b=sgmGTTUI9Zah981fxSUk7ySCczxT3V9xbCWbQ1vlH5lT8P7CCgK9yQn1cMN/cCkeGf5e6Te6oreh8OKT70iGUglUN9jBspTEj8ahFFB0Yad+AB2L7wmOXkXrWO7YbuviHRFdSNNN4PyLkdth1Rmve7taoRK5jZETmnMepyUxUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184022; c=relaxed/simple;
	bh=HWtyih9wJSCFaPx94m8b6z0CZmklBaebKHT2o3d49Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APAtYeMXSa2jrl7GeSMuHOHOzk512omPO6ZyqaYAyhJIN6C8lF01EYsTdXClcNnXGJu+eHKMv5mW4f6gEsXMjkRcqtqIUEyFF82kY4nIS26+XYlogABUVcBVFx669ssTUs+619JJDTAWK1+RHVTzpVdThcviZtFbA1MHDg35tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3bX6nau; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3bX6nau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C695C116C6;
	Fri, 27 Feb 2026 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772184022;
	bh=HWtyih9wJSCFaPx94m8b6z0CZmklBaebKHT2o3d49Nk=;
	h=From:To:Cc:Subject:Date:From;
	b=k3bX6nauw6SFPXHwnNutWvqTBrdRl3YkxN9WyCHvJlhURkjYJ3zd3DvjZ2hEROWKr
	 KSywRpmq+LT8/rknfw60YG0+5l1e6u0iVTi/h76YG6EahJERtLE90o1nViLm7dPoB7
	 nfb8BDXifN0fnwAp2Eb2MqD7WaxOR8JXZEmNoga5xWmHWW1sQ6RW4DaKzBcVbChZy0
	 Ckl7s7kyFbGAFJ9sVOEKf098h1dlIaPZfPN8Bm3yyitjLSdoO5UK3NJk1IWQNtSEMa
	 tFsNJ3rlU4v0V3Ce8eHs0ruH/tyis5Soy8iQBdRyFSRaqiyiHMOinXYS3EsqRKzAZh
	 jsEvETRPQWk+w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] ring-buffer: Making persistent ring buffers robust
Date: Fri, 27 Feb 2026 18:20:18 +0900
Message-ID:  <177218401821.1988514.5579163042147205021.stgit@mhiramat.tok.corp.google.com>
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

Here is the 6th version of improvement patches for making persistent
ring buffers robust to failures.
The previous version is here:

https://lore.kernel.org/all/177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com/

In this version, I introduced asm/ring_buffer.h file for wrapping
flush ring buffer function and use dcache_clean_pop() for arm64[1/3]
also, showing invalid page detection (first time for each cpu)
message when validating the persistent ring buffer[3/3]. 

Thank you,

---

Masami Hiramatsu (Google) (3):
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Handle RB_MISSED_* flags on commit field correctly
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer


 arch/alpha/include/asm/Kbuild        |    1 
 arch/arc/include/asm/Kbuild          |    1 
 arch/arm/include/asm/Kbuild          |    1 
 arch/arm64/include/asm/ring_buffer.h |   10 ++++
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
 include/asm-generic/ring_buffer.h    |   13 ++++++
 kernel/trace/ring_buffer.c           |   78 ++++++++++++++++++++++++----------
 23 files changed, 97 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
