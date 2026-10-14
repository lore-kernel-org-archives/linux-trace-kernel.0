Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D53AD51C;
	Wed, 14 Oct 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971072; cv=none; b=NdqbjgX5gIRmYJNHsgoJ7jReQoocjEMwAxvo8sxpxunwC2GZrl451CalXaMefW19NsCOI7HRL7dJJt2t7qlDThe0KEQz0sCHKNxX5ciVZVc/TWlXuI2UxEsW5rP+jmHfgpVEIYe4p/lbonVBbYqk8UEaP+vH1iEEU44fq0MThxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971072; c=relaxed/simple;
	bh=jGQQd8DQS8UuyQfDaYk7tK9oDrfxKggilWhZKe7ggbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goP18zp3585oMIPgjQQ6T3XIIWz+GbemojwL0qMwUrt6c+4qWnoWQm6Vy5XPF/AyL9bjOEa4Noq7UUvyrcKDt67eJCXlwEF9fvU005kitIgMLETsB/3kO+OBOuHDG72qX6AgHIHLuUxSkH8UFx9AA2VXXeLxIqQ0w2Rk7MbC8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app1 (Coremail) with SMTP id TAJkCgCXKW7vTs9q6aSGAA--.43637S2;
	Wed, 14 Oct 2026 17:44:17 +0800 (CST)
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
Subject: [PATCH v5 0/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Wed, 14 Oct 2026 17:44:13 +0800
Message-Id: <20261014094415.374-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
References: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCXKW7vTs9q6aSGAA--.43637S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4ktF4fCF48JF1rWFyDKFg_yoW8ZF13pF
	Z5Cwn8tr4kWw1fCry3Gw48Z34Sya1rGr43Jr1kJw1jy3y5tr1rtFnxKw4Uur98GrZYgw13
	Zw10grZ8Wa47ZFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEAE2rOXTMYPwAAs+

A breakpoint trap taken in the middle of an LR/SC sequence clears the
load reservation, so an SC following the probed instruction always fails
and the enclosing retry loop re-enters the breakpoint, livelocking the
CPU.  This series makes the RISC-V kprobes implementation reject probes
placed on an LR/SC instruction or between them, following arm64's
approach for its equivalent exclusive load/store instructions.

Changes since v4:
- Reject the LR and SC instructions themselves in the decode stage
  (riscv_probe_decode_insn()), so a probe placed directly on them is
  caught independently of the kallsyms offset (fixes the case where the
  probe address is exactly the enclosing symbol's start).
- Bound the sequence scan by instruction count (MAX_LRSC_GAP = 16)
  instead of bytes, matching the Zalrsc "at most 16 instructions"
  constraint and avoiding ambiguity with compressed instructions.
- Fold the LR/SC scan into arch_check_kprobe() so the function is walked
  only once; arch_check_kprobe() now returns an error code.
- Use the existing GET_INSN_LENGTH() macro and a single unaligned 32-bit
  load instead of two separate loads.
- Extend the KUnit test to check a probe right before, on the LR, inside,
  on the SC, and right after the sequence, storing absolute probe
  addresses instead of offsets.

Verified by cross-compiling for RISC-V and running the kprobes KUnit
test in QEMU (ok 2 kprobes_riscv).

Xiaofeng Yuan (2):
  riscv: kprobes: reject probes inside LR/SC sequences
  riscv: kprobes: add KUnit test for LR/SC sequence rejection

 arch/riscv/include/asm/insn.h                 | 33 ++++++++++
 arch/riscv/kernel/probes/decode-insn.c        |  2 +
 arch/riscv/kernel/probes/kprobes.c            | 63 +++++++++++++++----
 .../kernel/tests/kprobes/test-kprobes-asm.S   | 24 +++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.c | 26 ++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.h |  3 +
 6 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.34.1

