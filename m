Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC013B28A;
	Thu,  6 Jun 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676323; cv=none; b=W9vmEFBVuJnrQJfe6xj0SVfNyjOj9OsimcEMmG4wQ3wOt0AC0YhxRT9iwmsRBBy/Q2IvAsyzRpDLRiI0eor8vJWRaD7iIE4duAW2YvqD+/leK1IH4NhL7DCGTEyWGEvqhGuluq4+7mLpSkev8fkVDomIkJxUycj5CtALls0EUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676323; c=relaxed/simple;
	bh=SQNXTsj89MLWuzJf5l0TgCEvvxyzvDkvobR9izSokYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fc+52KeE63LyagkIS8L/52azcyhuTfttj8UdcIjjcxmzWxVe5Wqk4B5W9hW4qIjQxByYEmUTvItQfTZIp1ELAJ1+4nFmV5JzbpPOO2DaGEGkIE5BPwGdJpV7J4jULJ2c+IUv/uRCmrHbcsoiyD+7gZXXrheZxR7Ai8kBn3sNRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A9EC32782;
	Thu,  6 Jun 2024 12:18:42 +0000 (UTC)
Date: Thu, 6 Jun 2024 08:18:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] function_graph: Rename BYTE_NUMBER to CHAR_NUMBER in
 selftests
Message-ID: <20240606081846.4cb82dc4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function_graph selftests checks various size variables to pass from
the entry of the function to the exit. It tests 1, 2, 4 and 8 byte words.
The 1 byte macro was called BYTE_NUMBER but that is used in the sh
architecture: arch/sh/include/asm/bitops-op32.h

Just rename the macro to CHAR_NUMBER.

Fixes: 47c3c70aa3697 ("function_graph: Add selftest for passing local variables")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406061744.rZDXfRrG-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 369efc569238..adf0f436d84b 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -758,7 +758,7 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#define BYTE_NUMBER 123
+#define CHAR_NUMBER 123
 #define SHORT_NUMBER 12345
 #define WORD_NUMBER 1234567890
 #define LONG_NUMBER 1234567890123456789LL
@@ -789,7 +789,7 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
 
 	switch (size) {
 	case 1:
-		*(char *)p = BYTE_NUMBER;
+		*(char *)p = CHAR_NUMBER;
 		break;
 	case 2:
 		*(short *)p = SHORT_NUMBER;
@@ -830,7 +830,7 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 
 	switch (fixture->store_size) {
 	case 1:
-		expect = BYTE_NUMBER;
+		expect = CHAR_NUMBER;
 		found = *(char *)p;
 		break;
 	case 2:
-- 
2.43.0

