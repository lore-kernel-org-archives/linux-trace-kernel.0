Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659C3BBA0B;
	Fri, 16 Oct 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138647; cv=none; b=MB8Qa32c2C0M6OEmEfU9PRaLsxKo7/QEmE0HYRkXCciCIa0LfDS2PPWMiibPy17arDvxQ+IRh59/TDTQ9jV/QHUUhhJqQfsdMFLv/+Dpo6Tt8Ef7gzqP03390VlCvMskU6NamYgwkB6KHhb1QZlBuyGzcDQmKiCveY2yuERXBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138647; c=relaxed/simple;
	bh=PXbdo6UoHANfswwl8HlHaF9jjaFQs6Fu+VHLrg/jY+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OgOkHxORfRn01jYYPK5/3BEjt8x0oB2inRqdR5Z8ic/pUcEuHu7wXg9oJq1QLYgrYE8E2JWuBykKQADnQoIWFi6BAInQ5Itw4/u3Ujfn6yNBljpNE77MyVyabKIU2ISuv/CqQkQof4HDg4nLzm02jTQGolit9PTlUa1V9WMNCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app2 (Coremail) with SMTP id TQJkCgAXLqGD3dFqtNKGAA--.25396S2;
	Fri, 16 Oct 2026 16:17:08 +0800 (CST)
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
Subject: [PATCH v6 0/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Fri, 16 Oct 2026 16:17:04 +0800
Message-Id: <20261016081706.1085-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAXLqGD3dFqtNKGAA--.25396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4ktF4fCF48JF1rWFyDKFg_yoW8Xr43pF
	s5Gwn8KrWkXw4fGry3uw4kZryft3yrJw43JFnrCw1jy3yUAr13tFnag3yUG34kCrZ0q34a
	vr18XrZ8WFy7ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgECE2rRAKkT-wAAss

A breakpoint trap taken in the middle of an LR/SC sequence clears the
load reservation, so an SC following the probed instruction always fails
and the enclosing retry loop re-enters the breakpoint, livelocking the
CPU.  This series makes the RISC-V kprobes implementation reject probes
placed on an LR/SC instruction or between them, following arm64's
approach for its equivalent exclusive load/store instructions.

Changes since v5:
- Fix a dangling stack pointer in the KUnit test: a probe that was
  expected to be rejected but was unexpectedly registered stayed on
  a stack-allocated kprobe.
- Add Acked-by: Masami Hiramatsu to the implementation patch.
- Annotate that test_kprobes_lrsc() is never executed and that
  reject[] must match the length of test_kprobes_lrsc_offsets[].

Verified by cross-compiling for RISC-V and running the kprobes KUnit
test in QEMU (ok 2 kprobes_riscv).

Xiaofeng Yuan (2):
  riscv: kprobes: reject probes inside LR/SC sequences
  riscv: kprobes: add KUnit test for LR/SC sequence rejection

 arch/riscv/include/asm/insn.h                 | 33 ++++++++++
 arch/riscv/kernel/probes/decode-insn.c        |  2 +
 arch/riscv/kernel/probes/kprobes.c            | 63 +++++++++++++++----
 .../kernel/tests/kprobes/test-kprobes-asm.S   | 30 +++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.c | 31 +++++++++
 .../riscv/kernel/tests/kprobes/test-kprobes.h |  3 +
 6 files changed, 150 insertions(+), 12 deletions(-)

-- 
2.34.1

