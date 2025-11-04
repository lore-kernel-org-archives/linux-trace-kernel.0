Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B8E221FCC;
	Tue,  4 Nov 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265510; cv=none; b=fTX9gwsNq+NLJxNl942BmTi90pjx+2uFTyp3vGGwHrNXMOczi+ZtsRJohZU1wkLb2KSg8y9UeE8FHzJrbjQSmIIjBF0ZP15jNfCepPD+of0srduxWUhXs8zcnmomRFaJb0FuPH2XAwS9++OW63rXlaPLIl8zo28xflXZOvjytBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265510; c=relaxed/simple;
	bh=vgSAFsQ5mZtcfbqCzL1HWndwd6MsJi2B5H4Sz4vaoL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmEvuSS6J9EGuvH3PRupMHtU8kQG6T3w12OAAOM4FiAA9YsFMDi0X97U+mRh+Q8Atr5GMMnyfMrNBL9pwY8Bt5lcyVdiRuhTleJcl7HWplO8QKJUTny2O7kDhlVBjssvtZcEoEaGrbljw5s+fjdARTsOO5edCUinUxsy5b4GM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aou8+SmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aou8+SmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D24DC16AAE;
	Tue,  4 Nov 2025 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265509;
	bh=vgSAFsQ5mZtcfbqCzL1HWndwd6MsJi2B5H4Sz4vaoL8=;
	h=From:To:Cc:Subject:Date:From;
	b=Aou8+SmFjcXv0N0O8cd9sQpvjqjWIKdE3vZlQgVDm6Gy508fQUvweIo5+O81cjcgn
	 6+XR2w3DNF2ETPRt9/UQLqm5XVC1YJQY+Wvd2FT/cGBw9BgKSxm6dvsuYNobYYqx1G
	 XRVXGXyEXqrHH7sXE/fOMsW8czm7mdGItWVoc7AmfnME3czKVji/v7XuBNL3boESE+
	 t5UjULcuSVqM6ajksDvJhVp/8CD/xjHkWg3iFjok87ru3Ot0qlRB3fLTpgNmP3xDaN
	 OYgBK5AMipdGAL1QwsvAt1BWjNJApHZbQyPnYgcZ5FFfuw1MTannsL87lHxy0IjNC6
	 CblGWJI5iFoBA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper
Date: Tue,  4 Nov 2025 23:11:46 +0900
Message-ID: <176226550596.59499.18020648957674458755.stgit@devnote2>
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

Use a new seq_print_ip_sym_offset() wrapper function instead of
using TRACE_ITER(SYM_OFFSET) mask directly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_wprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 98605b207f43..eae952a4f9e9 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -20,6 +20,7 @@
 #include <asm/ptrace.h>
 
 #include "trace_dynevent.h"
+#include "trace_output.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
 #include "trace_probe_tmpl.h"
@@ -260,7 +261,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym_offset(s, field->ip, flags))
 		goto out;
 
 	trace_seq_putc(s, ')');

