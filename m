Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A816360EF0;
	Mon, 10 Aug 2026 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349405; cv=none; b=SH5W5Bg/HVZ2il/En2xzNQZejbqX3H6FN8U3lje+CivgbVaxMprLKS/9cdlR8eev0ueU3IshqiUe5gB6UhmJr3RHGluNMEXLNgdINvdBs+1dLwU+Xzu4kEB9iceShNO8fP5De+z/4BZVo6RqW6k/I9kDw9QzCG2irAe46AhnWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349405; c=relaxed/simple;
	bh=wj2up3krv6ir+N7jNprjGhy9L8njqY2Fy8mPlGl/VaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFB/T2eQg+y57qazHKGyIDzhV4qvITPoncPjHx3X67MsM1m6rSOBfW6549mwclRdSSji7DdR4cnR01ujTVZBQCK3gc+1PZtnGlDxO0LiI0gDXIZZOaGWHShe+E9VkilGlgefG3yDE8olRkHo1Z+rEtG7dsREE8sltpOSR+6hNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtp.gmail.com (unknown [121.237.244.183])
	by APP-03 (Coremail) with SMTP id rQCowAB3fjxvhXlqEdJwBA--.3674S2;
	Mon, 10 Aug 2026 16:01:51 +0800 (CST)
From: daichengrong <daichengrong@iscas.ac.cn>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	daichengrong <daichengrong@iscas.ac.cn>
Subject: [PATCH v2] uprobes: Restore original return address in uretprobe context
Date: Mon, 10 Aug 2026 16:01:40 +0800
Message-Id: <20260810080140.96587-1-daichengrong@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3fjxvhXlqEdJwBA--.3674S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fJFW5tF48ur1rXr1DKFg_yoWrJr1xpa
	1vka43KFWDG34UurZxXr48Z3WFvrZ5Xw42kr1xK34fCw15KryfJr1I93y7ZF1rtrZagF13
	Ar4UtrWjvFZxJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUw0edUUUUU=
X-CM-SenderInfo: pgdluxxhqj201qj6x2xfdvhtffof0/

uretprobe replaces the original return address of a probed function with
a trampoline address to capture function return events.

After the trampoline is entered and the uretprobe handler completes, the
original return address needs to be restored in the user register context
to keep the register state consistent with the state before probing.

Add an architecture-specific hook for restoring the original return
address during uretprobe handling.

The initial implementation adds support for RISC-V. Other architectures
keep the default empty implementation until their corresponding restore
logic is implemented.

Signed-off-by: daichengrong <daichengrong@iscas.ac.cn>
---
Change in v2:
 - Rename arch_uretprobe_hijack_set_addr() to arch_uretprobe_restore_return_address() as suggested
 
v1: https://lore.kernel.org/all/20260717082331.27058-1-daichengrong@iscas.ac.cn/
---
 arch/riscv/kernel/probes/uprobes.c | 7 +++++++
 include/linux/uprobes.h            | 1 +
 kernel/events/uprobes.c            | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index eb177d0ce8ab..90ed8596e73f 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -139,6 +139,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 	return ra;
 }
 
+void
+arch_uretprobe_restore_return_address(unsigned long orig_ret_vaddr,
+				  struct pt_regs *regs)
+{
+	regs->ra = orig_ret_vaddr;
+}
+
 int arch_uprobe_exception_notify(struct notifier_block *self,
 				 unsigned long val, void *data)
 {
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f548fea2adec..af5b633f92dd 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -230,6 +230,7 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
 extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
+extern void arch_uretprobe_restore_return_address(unsigned long orig_ret_vaddr, struct pt_regs *regs);
 extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx, struct pt_regs *regs);
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6300b216012c..9a2e9ce4e398 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1748,6 +1748,10 @@ void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
+void __weak arch_uretprobe_restore_return_address(unsigned long orig_ret_vaddr, struct pt_regs *regs)
+{
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -2659,6 +2663,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 		valid = !next_chain || arch_uretprobe_is_alive(next_chain, RP_CHECK_RET, regs);
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
+		arch_uretprobe_restore_return_address(ri->orig_ret_vaddr, regs);
 		do {
 			/* pop current instance from the stack of pending return instances,
 			 * as it's not pending anymore: we just fixed up original
-- 
2.25.1

