Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853057083A;
	Wed,  5 Feb 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778575; cv=none; b=BnLaNGK/wplZ+sXs0TkrKaDn+6M7lS3AkYzES/d6iAXXGz916s4s/kT7KznPhEpg5c7cwra2raUGkje005OrGpwdzhG/sbT5GLgi1UE0ilxfusTPrvFRxHddythiO116c/J1w+zN1b16VC116ODr41GZUkSmC0AR4cl4pQWF0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778575; c=relaxed/simple;
	bh=PHU/NfVcsttQ72o5pN+qEZLaYIsGQyu0oU3I4xzGJvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRcu+xGtBykqhWkOXw6DE1tkKs6EmIND98coA1gzM8la+Drw0hVm4dVz8+JRBOAWVMzdwsnqiKQGp9dH7xlUDuW9BIHYzyu2AqdN7sc/sT+DsBACMTDF3VIgGjwNqomLQHmwjseblm7tRQRrkUJ40IazueggY2lu32udA9aeHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hAaEEkGY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hAaEEkGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=Dml9wWDOyFyVC02psZGYm1mepRSxmmbQx2D3qzg//A0=;
	b=hAaEEkGYIbhafCw4aHZA4Rrw1HRTB4rYUEcMjPRCufvAOHgAgeTFeb3GsyHxvF
	dQEcM2/wIovt++wKIFwtAmqD/mTs/I0Y7fQjyK610WNXQ1N9pq9TOFkpvr+uLH8k
	4DFbiBaHsfgtXaeO4PWK6VYpEFIdHipJz6GL+MMCu1K9I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3QQqCp6NniA_EKA--.28624S2;
	Thu, 06 Feb 2025 02:01:39 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: x86@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: samitolvanen@google.com,
	Haiyue Wang <haiyuewa@163.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS is enabled
Date: Thu,  6 Feb 2025 02:00:42 +0800
Message-ID: <20250205180116.88644-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3QQqCp6NniA_EKA--.28624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr18Kry7Cr43GF43Zw1kKrg_yoW8ArWfpF
	97Cr1kGay5uasrK34Du34Fvw1Uuw4DC34ayry2gr90vF42qFykGrsF9wnrCry7Ja98ta4F
	gay3uFn8GF1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEEdgJUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBfqa2ejLSUfNwABsT

When switching from CONFIG_GENKSYMS to CONFIG_GENDWARFKSYMS enabled, the
build is failed:

  AS      arch/x86/entry/entry.o
In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
                 from <stdin>:3:
./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of function ‘get_kernel_nofault’ [-Werror=implicit-function-declaration]
   46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
      |                     ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
adding the missed declaration header file can also fix the error:

 getasmexports =                                                        \
    { echo "\#include <linux/kernel.h>" ;                               \
      echo "\#include <linux/string.h>" ;                               \
+     echo "\#include <linux/uaccess.h>";                               \
      echo "\#include <asm/asm-prototypes.h>" ;                         \
      $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }

Fixes: 2bc56fdae1ba ("ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr")

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 arch/x86/include/asm/ftrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d07df58..063ce70837bb 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,6 +34,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+#ifdef CONFIG_X86_KERNEL_IBT
+#include <linux/uaccess.h>
+#endif
+
 static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 {
 #ifdef CONFIG_X86_KERNEL_IBT
-- 
2.48.1

