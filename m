Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9724FC351;
	Mon, 19 Oct 2026 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417310; cv=none; b=risrKZovph49X+FE1a/3wpVgTebnIqyXxO1M3qW1Aq0Z0oRjFj2wPOd1q8THb5I0L7TqYiBew/K+yokrtxTMEo72j2SFo0zkArX7cC9HC8Wfeie+GHP6a6csP9/b4iBJhHL7+HvvTauIlA2tJtqlreErluwEM1UfdoelXTTS/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417310; c=relaxed/simple;
	bh=dHlxksc39cqObwcpsa5gcUtcmvdaORHVjaytyS4cqYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTBqBmge0wXUqQj0qh6AcHt5d0rKoyINkSLk/UTDFABEmfvWy+ArbkijBmvgRu0Kh/+Lbsk9KJjW2GU4D1g1WNr6ScLmMDw4xzSkdvU6o7tu/cGXRp501i/oKnEghisNDB9Z7t3mloTSvrppGkucoaovABBLj7DINcmxAHGe9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.100.71.120])
	by app2 (Coremail) with SMTP id TQJkCgAHDpwBHtZqOjWHAA--.44594S2;
	Mon, 19 Oct 2026 21:41:23 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Nam Cao <namcao@linutronix.de>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Subject: [PATCH v7 0/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Mon, 19 Oct 2026 21:41:19 +0800
Message-Id: <20261019134121.1763-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHDpwBHtZqOjWHAA--.44594S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4ktF4fCF48JF1rWFyDKFg_yoW8ZrWfpF
	s5Cw15JrWkX39xGry3Xw4kZrWSya1rCr43GF1xJw10y3yUtr13tFnIg3yUAr1DG39Yvw1f
	Zr40qr98WFy7ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgEFE2rU9SooKQABs0

A breakpoint trap taken in the middle of an LR/SC sequence clears the
load reservation, so an SC following the probed instruction always fails
and the enclosing retry loop re-enters the breakpoint, livelocking the
CPU.  This series makes the RISC-V kprobes implementation reject probes
placed on an LR/SC instruction or between them, following arm64's
approach for its equivalent exclusive load/store instructions.

Changes since v6:
- Fix an off-by-one in the LR/SC tracking window: a constrained loop
  holds at most 16 instructions (the LR, the SC, and up to 14 between
  them), and the walk now stops tracking after 14 intermediate
  instructions, as the spec requires.
- Use the existing RV_EXTRACT_FUNCT3()/RV_EXTRACT_RS2_REG() helpers and
  add RV_EXTRACT_FUNCT5() in riscv_insn_is_lr()/riscv_insn_is_sc() to
  avoid code duplication.
- Rename test_kprobes_lrsc_offsets[] and split it into separate
  test_kprobes_lrsc_allowed_addresses[]/test_kprobes_lrsc_rejected_
  addresses[] so that adding an entry does not force a change in a
  parallel reject[] table.
- Add a KUnit boundary case pinning the 16-instruction tracking window:
  the 15th instruction after an LR must be rejected and the 16th must be
  accepted (this fails without the off-by-one fix).

Verified by cross-compiling for RISC-V and running the kprobes KUnit
test in QEMU (ok 2 kprobes_riscv).

Xiaofeng Yuan (2):
  riscv: kprobes: reject probes inside LR/SC sequences
  riscv: kprobes: add KUnit test for LR/SC sequence rejection

 arch/riscv/include/asm/insn.h                 | 63 ++++++++++++++----
 arch/riscv/kernel/probes/decode-insn.c        |  2 +
 arch/riscv/kernel/probes/kprobes.c            | 65 +++++++++++++++----
 .../kernel/tests/kprobes/test-kprobes-asm.S   | 60 +++++++++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.c | 34 ++++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.h |  6 ++
 6 files changed, 207 insertions(+), 23 deletions(-)

-- 
2.34.1

