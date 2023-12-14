Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6006108
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCdOhjUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332EAC433C7;
	Thu, 14 Dec 2023 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702531152;
	bh=LVMi+Y5VUaqqVncvLYXRxiyjMyHiWYY1uMv92cnuaJw=;
	h=From:To:Cc:Subject:Date:From;
	b=cCdOhjUhtrnh68iq1vuGawYw9QePyYjEHzbZfUs8QMRy5ypRKGn1W7aDc7j9HzIhB
	 r4mZcWFgNUTnmxKYuHjNjyCi4lIufS5+7rDs4++i2KLCURi1JBMENv7nUF92tVHCLm
	 wZlM7xI5ppszUO/kcrQj0lEftXEIxP5cN2EiyI/4+Xe57+ln6XpmETgixjH2RAqjuF
	 o8hlKIXW48jr/P0HhUzS4qpkS4aKWW8p/kmqSb9sFYGnaDDywktqdDOlCQubL2v693
	 gGPrPWddXgHG6JMoejOkniIjD/pTZN7aqX+8n8auZ28n+2P3QyjeNHNtdvmHOROKN0
	 Y7CL9+/wre17g==
From: Naveen N Rao <naveen@kernel.org>
To: <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH v4] trace/kprobe: Display the actual notrace function when rejecting a probe
Date: Thu, 14 Dec 2023 10:47:02 +0530
Message-ID: <20231214051702.1687300-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to probe update_sd_lb_stats() using perf results in the below
message in the kernel log:
	trace_kprobe: Could not probe notrace function _text

This is because 'perf probe' specifies the kprobe location as an offset
from '_text':
	$ sudo perf probe -D update_sd_lb_stats
	p:probe/update_sd_lb_stats _text+1830728

However, the error message is misleading and doesn't help convey the
actual notrace function that is being probed. Fix this by looking up the
actual function name that is being probed. With this fix, we now get the
below message in the kernel log:
	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
v4: Use printk format specifier %ps with probe address to lookup the 
symbol, as suggested by Masami.

 kernel/trace/trace_kprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d7a180a8427..0017404d6e8d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -487,8 +487,8 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		return -EINVAL;
 
 	if (within_notrace_func(tk)) {
-		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+		pr_warn("Could not probe notrace function %ps\n",
+			(void *)trace_kprobe_address(tk));
 		return -EINVAL;
 	}
 

base-commit: 4758560fa268cecfa1144f015aa9f2525d164b7e
-- 
2.43.0

