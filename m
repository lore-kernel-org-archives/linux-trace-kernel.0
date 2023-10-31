Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53022307
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CE3C433C7;
	Tue, 31 Oct 2023 19:10:35 +0000 (UTC)
Date: Tue, 31 Oct 2023 15:10:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] tracing: Have the user copy of synthetic event address use
 correct context
Message-ID: <20231031151033.73c42e23@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A synthetic event is created by the synthetic event interface that can
read both user or kernel address memory. In reality, it reads any
arbitrary memory location from within the kernel. If the address space is
in USER (where CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE is set) then
it uses strncpy_from_user_nofault() to copy strings otherwise it uses
strncpy_from_kernel_nofault().

But since both functions use the same variable there's no annotation to
what that variable is (ie. __user). This makes sparse complain.

Quiet sparse by typecasting the strncpy_from_user_nofault() variable to
a __user pointer.

Cc: stable@vger.kernel.org
Fixes: 0934ae9977c2 ("tracing: Fix reading strings from synthetic events");
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311010013.fm8WTxa5-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 14cb275a0bab..846e02c0fb59 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -452,7 +452,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
-			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+			ret = strncpy_from_user_nofault(str_field, (const void __user *)str_val, STR_VAR_LEN_MAX);
 		else
 #endif
 			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
-- 
2.42.0

