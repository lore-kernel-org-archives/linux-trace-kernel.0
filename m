Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9D37DEBC;
	Thu, 16 Apr 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334662; cv=none; b=N6xiLFR3smAls/3CkJrrHLyY83THicojJLo2+tEPihgpR0lof0KOsgPtmLlr2gr88K+Qh8nZ4EPM8DuU8czYv8D8XKCiGHm1DdVnp9QVLld8TdugJxf6ovmLASzGK3kXPADjQRgZwrDB6AJnihLO9a19nMfIl1g62xG5EFPXVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334662; c=relaxed/simple;
	bh=Eohmu4mW9zjBee6XRnym8+P1pEMi/WA65MRYY2VIZvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3s4xICOLzrHKBkEGwYHxqxP01bTFJ7LqrMCrsKI7ezaReFN77drmrb6Xg95SlKgeEMXyghn4KQQq4g0jnLdKl1nbyT3w0NfmUjpiVe+7dSg9BU3LaPO4nHVLWWhAOyeQZQNV1F4eidEs8fxm22FBaJvgGL6lnR4tWZndQipteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs7uOeJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs7uOeJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A348EC2BCAF;
	Thu, 16 Apr 2026 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334661;
	bh=Eohmu4mW9zjBee6XRnym8+P1pEMi/WA65MRYY2VIZvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fs7uOeJ0qqVQcm0F8AZqrIJ0eck8Go9JyFTXbqmIc7cgFOhTxOo++5ik4/YYp8X2f
	 tBhFdw65bPN/o7oZ3kF90mRVnWAWbrZ9ZuTvxvdt9gOu2bosZTYHM55yCXZaLoPNB/
	 +4NQMLj9raGi0ALsJafI6fCzE1SA7ih8gWx/VB2QUFX3FLEvLnaa+Ph1HPUTnNYFXu
	 PAsqK+vIzwDAPW2M9qpqbDbwFjCsdKyFury0JnrSMJcCl8rmxhBGmbIokLLmlulAqW
	 nepvLKmGZs7IOsAZIqDwI8yYuWCtfeM4l1wLEfOi0DJ+FjTpnXvi7QacHAsz2K5wIa
	 g6V/iAofljwyQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 7/8] selftests/ftrace: Add a testcase for fprobe events on module
Date: Thu, 16 Apr 2026 19:17:39 +0900
Message-ID:  <177633465902.3479617.16621806378405730791.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
References:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
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

Add a testcase for fprobe events on module, which unloads a kernel
module on which fprobe events are probing and ensure the ftrace
hash map is cleared correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/add_remove_fprobe_module.tc    |   61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
new file mode 100644
index 000000000000..500942e9d8d6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
@@ -0,0 +1,61 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove fprobe events on module
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README enabled_functions
+
+rmmod trace-events-sample ||:
+if ! modprobe trace-events-sample ; then
+  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
+  exit_unresolved;
+fi
+trap "rmmod trace-events-sample" EXIT
+
+echo 0 > events/enable
+echo > dynamic_events
+
+FUNC1='foo_bar*'
+FUNC2='vfs_read'
+
+:;: "Add an event on the test module" ;:
+echo "f:test1 $FUNC1" >> dynamic_events
+echo 1 > events/fprobes/test1/enable
+
+:;: "Ensure it is enabled" ;:
+funcs=`cat enabled_functions | wc -l`
+test $funcs -ne 0
+
+:;: "Check the enabled_functions is cleared on unloading" ;:
+rmmod trace_events_sample
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+:;: "Check it is kept clean" ;:
+modprobe trace-events-sample
+echo 1 > events/fprobes/test1/enable || echo "OK"
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+:;: "Add another event not on the test module" ;:
+echo "f:test2 $FUNC2" >> dynamic_events
+echo 1 > events/fprobes/test2/enable
+
+:;: "Ensure it is enabled" ;:
+ofuncs=`cat enabled_functions | wc -l`
+test $ofuncs -ne 0
+
+:;: "Disable and remove the first event"
+echo 0 > events/fprobes/test1/enable
+echo "-:fprobes/test1" >> dynamic_events
+funcs=`cat enabled_functions | wc -l`
+test $ofuncs -eq $funcs
+
+:;: "Disable and remove other events" ;:
+echo 0 > events/fprobes/enable
+echo > dynamic_events
+funcs=`cat enabled_functions | wc -l`
+test $funcs -eq 0
+
+
+rmmod trace-events-sample
+trap "" EXIT
+clear_trace

