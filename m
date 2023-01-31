Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A6C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 16:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAaQRX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAaQRT (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14647577F0;
        Tue, 31 Jan 2023 08:16:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C77F161591;
        Tue, 31 Jan 2023 16:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63B3C433EF;
        Tue, 31 Jan 2023 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675181797;
        bh=Rr6xQgk50Y4ZGBCzUd1zUs+X3lNoqxnJIVxDwxiF6LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovS1IAcJaq5rm2GXEJBoC97hT0n627J8wB3KtRl8787HI8pSXaxxTxmRdTBnFUAhJ
         b7c68UDFNcEdm63Rqg7Oa7b3y78ggBp37URX7VaqtLkks5B6n96gteU5iAv7NndIAY
         7uVXl7H22f8m4p//1y7Xl4QhUNLCvVoSXMxIWGZOTFmpOOxNNOjWiV8lJe0Lg0gHX1
         wg2VHm0taAYaZtv3DX0nHuZxAG/1FReSVqX/YhkKJGJ+3CHBKFq5ikEPhmzpzbAXTh
         bWIrjVAAOdN7t1RQnwVC1CprVCoWuusljPf6vwdCAIiqdjx1nzmfB1/DbLhXurEnMa
         2G6rOOu16ICqQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 10/10] selftests/ftrace: Add fprobe related testcases
Date:   Wed,  1 Feb 2023 01:16:33 +0900
Message-Id:  <167518179358.336834.10474042635164261515.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
References:  <167518170369.336834.15310137713178284219.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add syntax error testcase and add-remove testcase for fprobe events.
This ensures that the fprobe events can be added/removed and parser
handles syntax errors correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 ++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   88 ++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
new file mode 100644
index 000000000000..53e0d5671687
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove fprobe events
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=$FUNCTION_FORK
+
+echo "f:myevent1 $PLACE" >> dynamic_events
+echo "f:myevent2 $PLACE%return" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/fprobes/myevent1
+test -d events/fprobes/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
new file mode 100644
index 000000000000..549daa162d84
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -0,0 +1,88 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event parser error log check
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
+
+check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
+check_error 'f^1a111 vfs_read'		# BAD_MAXACT
+check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+
+check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
+check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR
+check_error 'f:^/bar vfs_read'		# NO_GROUP_NAME
+check_error 'f:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
+
+check_error 'f:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
+check_error 'f:^ vfs_read'		# NO_EVENT_NAME
+check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
+check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
+
+check_error 'f vfs_read ^$retval'	# RETVAL_ON_PROBE
+check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
+
+check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
+
+check_error 'f vfs_read ^$none_var'	# BAD_VAR
+check_error 'f vfs_read ^%rax'		# BAD_VAR
+
+check_error 'f vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 'f vfs_read ^@+10'		# FILE_ON_KPROBE
+
+grep -q "imm-value" README && \
+check_error 'f vfs_read arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 'f vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
+check_error 'f vfs_read ^+0@0)'		# DEREF_NEED_BRACE
+check_error 'f vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 'f vfs_read +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 'f vfs_read +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 'f vfs_read ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 'f vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'f vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 'f vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
+check_error 'f vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
+check_error 'f vfs_read +0(@11):u8[^256]'	# ARRAY_TOO_BIG
+fi
+
+check_error 'f vfs_read @11:^unknown_type'	# BAD_TYPE
+check_error 'f vfs_read $stack0:^string'	# BAD_STRING
+check_error 'f vfs_read @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 'f vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 'f vfs_read ^=@11'			# NO_ARG_NAME
+check_error 'f vfs_read ^var.1=@11'		# BAD_ARG_NAME
+check_error 'f vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'f vfs_read arg1=^'			# NO_ARG_BODY
+
+
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo "f:fprobes/testevent $FUNCTION_FORK" > dynamic_events
+check_error '^f:fprobes/testevent do_exit%return'	# DIFF_PROBE_TYPE
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" "f:fprobes/testevent $FUNCTION_FORK abcd=\\1" > dynamic_events
+check_error "f:fprobes/testevent $FUNCTION_FORK ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^f:fprobes/testevent $FUNCTION_FORK abcd=\\1"	# SAME_PROBE
+fi
+
+# %return suffix errors
+check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
+
+exit 0

