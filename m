Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD21D3590;
	Mon, 21 Oct 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514368; cv=none; b=H246lQv+t9xiuToz/V67ts4BmG3pLMAofdIZHtB4IS8kJnt4FF0Z+sS3bJoIJd7GaPwQ9lPVfzpBGRGrvyooSa8TthBv/Dm9gciBkIxDqXpBOD5p0JYO/mQVym1Q91UL/FziQDmxbf372diOZ9M0WFSo7LdMyJRv8iO5UF4uA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514368; c=relaxed/simple;
	bh=UJohLTk3ngvcaNviWbvpljvgtu0o3NnL5UktcNqod6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNUrA240Fj68G4twEgVi31IuWx6i9oWFtA9RjhWK+2TYdC6zOn+PFtLqhDCKDYb2uoOqS+rLYdXQMMzJEIm+035lbHak/aFKNCUr75AEcJQnveGmbagMHfN8cRsN0x8KJOly/Ng+KOAR+BJH4iMOPE3TjL6a0r9+a6HethYluZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c89jvIpS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c89jvIpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE735C4CEC3;
	Mon, 21 Oct 2024 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514367;
	bh=UJohLTk3ngvcaNviWbvpljvgtu0o3NnL5UktcNqod6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=c89jvIpSmquVbt/INjj+OvxECAQ0eO7HULL741B5Qz6zx06vFckwWtFEAhDvtb2Wu
	 CZNbaQcOSiQM7k00dgmBPuH33AAepkE1VmBv1USQKxXwlOKojvCGwqHfafh4TlOXBI
	 9tFa26iQrK4/HFkba+E2ooo7zWV2aOY+YHirMz2+qnbpaysDFkPQcaCac9mBwjZ2Ne
	 Yi0MItdn4tc4LTdld8suIsU4h6lInFPwzniVcuLyxs9R8PGFD07IgiVEX4tfvErIY4
	 m9jxuMb0KVsThXUyIRhhVuDNXi0JOYG+8VqgpHaNZysfAKRDvCmmRFJDXUpfcrbZdd
	 VlQp/v0QroSHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] x86/kprobes: Cleanup kprobes on ftrace code
Date: Mon, 21 Oct 2024 21:39:22 +0900
Message-ID: <172951436219.167263.18330240454389154327.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cleanup kprobes on ftrace code for x86.
 - Set instruction pointer (ip + MCOUNT_INSN_SIZE) after pre_handler only
   when p->post_handler exists.
 - Use INT3_INSN_SIZE instead of 1.
 - Use instruction_pointer/instruction_pointer_set() functions instead of
   accessing regs->ip directly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/ftrace.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 15af7e98e161..2be55ec3f392 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -9,6 +9,7 @@
 #include <linux/hardirq.h>
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
+#include <asm/text-patching.h>
 
 #include "common.h"
 
@@ -36,23 +37,25 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_ip = regs->ip;
+		unsigned long orig_ip = instruction_pointer(regs);
+
 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
-		regs->ip = ip + sizeof(kprobe_opcode_t);
+		instruction_pointer_set(regs, ip + INT3_INSN_SIZE);
 
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			/*
-			 * Emulate singlestep (and also recover regs->ip)
-			 * as if there is a 5byte nop
-			 */
-			regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
 			if (unlikely(p->post_handler)) {
+				/*
+				 * Emulate singlestep (and also recover regs->ip)
+				 * as if there is a 5byte nop
+				 */
+				instruction_pointer_set(regs, ip + MCOUNT_INSN_SIZE);
 				kcb->kprobe_status = KPROBE_HIT_SSDONE;
 				p->post_handler(p, regs, 0);
 			}
-			regs->ip = orig_ip;
+			/* Recover IP address */
+			instruction_pointer_set(regs, orig_ip);
 		}
 		/*
 		 * If pre_handler returns !0, it changes regs->ip. We have to

