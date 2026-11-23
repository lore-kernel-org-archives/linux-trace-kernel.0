Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463976;
	b=GRGhUe19GV1CwB5vzO8BraPGoeOT7bN+bBivzoGXATpg7SsKUkn84nT9R7xLpChliuQi
	 VKZh4Kj9lbgUZbXwo4Vfn4t8OEHPjhtxuxYFS/gDNM8cFYLFCoV6igsyvGvoPuCknJBuA
	 0Fw3PUVaeP/YWGvDXQ0COH97gnIja3Ab/h5Zncd3BFqhao0ZNFBdMYiEAnkDyySEfzSjL
	 8vsqiZ5gn24u2FyNeeTPuCQodvt1uyLf1xCbOyNUkkJEFGqVntjAY3u817Uu3mUwDAOqq
	 IQK7pWwa5jZ6aQgkls5UePCHau8ADA6rzs54iXNwM9HczTujtWmQM8VOEWMNv44qu7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463976;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ZNbXBfNTO0fkyqJpgqenKi8rMrZeuWlZGWMB2B9tSTE=;
	b=KoUVH0NaXhNqEVgZA1dp+xkZ51gSS6faYppl2e2pTPKQkUVbA3vhMAIaey03elzSGh0i
	 5a5DApjHfnKOaXT+iqdHq9kdJ/YYeqQKe/UG/TJivqevFGes3HsJcpUMWjMjbHzpiXKAF
	 QQr6ra5BL1IBJNus7NcPglJ72F0z3HVUC/Z7ccU66Og38uH2CbeZ8nyBasiTndgMKb3Kz
	 oBQpjD06eeqMLRJEbljBAwX/ccgm7WBJoAsiyVBclF0+wjLwsu25zv1cQSzAdB8kynqjy
	 Ah5m9hNingbEx8MJEjFAxbbTpo8mzjpS+qMYY7KtT07gY5naYpkcAtRh2+pq9aKBC4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=tmEBZJIm;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A4606A31E;
	Mon, 23 Nov 2026 19:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=tmEBZJIm
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DFFC680971;
	Mon, 23 Nov 2026 19:59:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 28CA13D;
	Mon, 23 Nov 2026 19:59:26 +0000 (UTC)
Date: Mon, 23 Nov 2026 14:59:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest
 <linux-kselftest@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] tracing/selftests: Make sure trace_printk is set to top
 instance
Message-ID: <20261123145918.0d7f3728@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28CA13D
X-Stat-Signature: hgrz3uyr311sg5h7isysrg7czimairt3
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sdHlsPREMg0Mr5WaqVHQMrbDKAwQwaTE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ZNbXBfNTO0fkyqJpgqenKi8rMrZeuWlZGWMB2B9tSTE=; b=tmEBZJImdXo0GlRBLGG9UucuYerRP7qQXPM/VqlM3JI5h/BKGl0HacyXXbB6Cp5fNvwy4QizO6syEULY5+Hn0aDM9Kwmr/o5HrQDt7CNGMFsFmXbjEJjXn6dFOTQ9ONCQoYIEsm0pEPwRGfEsmeV16zOpz6Dq8XiGv6AdZR/p5E=
X-HE-Tag: 1795463966-961497
X-HE-Meta: U2FsdGVkX19diIAY0Lc1gKibLW6OutddK+lv8YadxSDrdEKf8H01kTg48u7G3f4YYSJCufAKYGelbTq3s8C1IebOzb3GOXFzcZo8HANhbomsTAQ7Sh+4MNoVpkdE47AjhhfzGNXFVfMG7g1I3/+1Td6FoDDCw+sU9lg3AJNHjZe/g2vFWKta8eXjuWTUB8wB0E87klMORXprRaoDYPyJ2iGTCFO3Y/yIZpz2X0gHzyrQ7f2MsRUhK46pldMDyrb1KcA3bQ3XQIjZbW1IzpWbRqbDQB0WdcLsuyO4YWeNhXbsq/p+EYiaNxFNFu8gB/xLG086SEwckL44CZrG/XX5eWIbw/iJJkRFEkvonr4KfH+ny0Aey6V+lZnvTMuhD8mg8wXNDZ08b4g43lc5sl3ZZpVJyuScBQ84

From: Steven Rostedt <rostedt@goodmis.org>

In order to debug a kernel crash, the boot command line added
the traceprintk flag to have trace_printk() go to the persistent ring
buffer. When the fix was found, the command line wasn't updated.

Later, when running the ftrace selftests, the direct function tests were
failing. The reason for this was because these tests would load the
ftrace-direct.ko module which would add a trampoline that did a
trace_printk. The test would then search the top level instance buffer for
the trace_printk output. The issue is that the kernel command line had
moved the destination to the persistent ring buffer causing the writes of
trace_printk to go there and not the top level instance and because the
tests did not find the output it was looking for, they failed.

Update the tests to set the trace_printk destination to the top level
instance at the start of the tests to force the output to go there so that
the tests will not fail in such a case again.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 5 +++++
 .../testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index d75a8695bc21..359257123e6d 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -2,6 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: Test ftrace direct functions against tracers
 
+# Make sure trace_printk goes to the main buffer
+if [ -f options/trace_printk_dest ]; then
+	echo 1 > options/trace_printk_dest
+fi
+
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index e52e470a1f8f..b22e3fb1c468 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -3,6 +3,11 @@
 # description: Test ftrace direct functions against kprobes
 # requires: kprobe_events
 
+# Make sure trace_printk goes to the main buffer
+if [ -f options/trace_printk_dest ]; then
+	echo 1 > options/trace_printk_dest
+fi
+
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
-- 
2.53.0

