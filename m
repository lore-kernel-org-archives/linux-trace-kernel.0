Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59A17D9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C84EC433C9;
	Sun, 10 Dec 2023 04:04:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rCB3k-000000021SI-24ci;
	Sat, 09 Dec 2023 23:04:52 -0500
Message-ID: <20231210040452.274868572@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 09 Dec 2023 22:54:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 14/14] ringbuffer/selftest: Add basic selftest to test chaning subbuf order
References: <20231210035404.053677508@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a self test that will write into the trace buffer with differ trace
sub buffer order sizes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/ringbuffer_order.tc | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
new file mode 100644
index 000000000000..c0d76dc724d3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Change the ringbuffer size
+# requires: buffer_subbuf_order
+# flags: instance
+
+get_buffer_data_size() {
+	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+a="1234567890"
+
+make_str() {
+        cnt=$1
+        s=""
+        while [ $cnt -gt 10 ]; do
+                s="${s}${a}"
+                cnt=$((cnt-10))
+        done
+        while [ $cnt -gt 0 ]; do
+                s="${s}X"
+                cnt=$((cnt-1))
+        done
+        echo -n $s
+}
+
+test_buffer() {
+
+	size=`get_buffer_data_size`
+
+	str=`make_str $size`
+
+	echo $str > trace_marker
+
+	grep -q $a trace
+}
+
+ORIG=`cat buffer_subbuf_order`
+
+for a in `seq 0 4`; do
+	echo 0 > buffer_subbuf_order
+	test_buffer
+done
+
+echo $ORIG > buffer_subbuf_order
+
-- 
2.42.0


