Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF571FBEA2;
	Thu, 17 Apr 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744928906; cv=none; b=S8baYGCSHJmJsJkQ37URv1XF+ELnMQ4knNRrPOrR4LqQcwAzOSnQlk1wy9D8dVINpE1OksIrov9w+UB04IVu04KRKW+crFn4J7fBPZs3T1/XFuH+9GIWQJqmiX+hUEuC8s/jOQQyAz8/LxV/iD1tz4fuML3xaB3PzJ2dEU4TnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744928906; c=relaxed/simple;
	bh=LUxes0u84hfgI+/C68y4xKDFHbrXB3K7ZMDX8LMqB7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BDij/prZWlPV/fHrNuOdcbbvUrNLT/pn07NACoynzmJUCQuvcI+2fWlfkd4Iy/eQDpA0FzApDNA7GNlcd/SNKVK/ianJDrq1deQjVHdLzc9khqL8U4wT1Zep1+AXi0XQWx4bM+REjhUUNT0rybDdJ/W5psAxFhCGSSawfU3dCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF04C4CEE4;
	Thu, 17 Apr 2025 22:28:23 +0000 (UTC)
Date: Thu, 17 Apr 2025 18:30:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Fix filter string testing
Message-ID: <20250417183003.505835fb@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The filter string testing uses strncpy_from_kernel/user_nofault() to
retrieve the string to test the filter against. The if() statement was
incorrect as it considered 0 as a fault, when it is only negative that it
faulted.

Link: https://lore.kernel.org/all/CAEf4BzbVPQ=BjWztmEwBPRKHUwNfKBkS3kce-Rzka6zvbQeVpg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: 77360f9bbc7e5 ("tracing: Add test for user space strings when filtering on string pointers")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reported-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0993dfc1c5c1..2048560264bb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -808,7 +808,7 @@ static __always_inline char *test_string(char *str)
 	kstr = ubuf->buffer;
 
 	/* For safety, do not trust the string pointer */
-	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
 		return NULL;
 	return kstr;
 }
@@ -827,7 +827,7 @@ static __always_inline char *test_ustring(char *str)
 
 	/* user space address? */
 	ustr = (char __user *)str;
-	if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+	if (strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE) < 0)
 		return NULL;
 
 	return kstr;
-- 
2.47.2

