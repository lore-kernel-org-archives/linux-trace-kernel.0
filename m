Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB834253C;
	Tue, 10 Feb 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717257; cv=none; b=nRWrnaSYNQtU1T4VUnMlm/qJ3yutvg7gcNW3cXXz2f79ADUjbzUR3eTg0VhMlFhuNJVOxDkeXFJsn24EA96e6i/jKhIlMwUG1cxt0guGdDPqwGtnA+Sv+Drk8kSQbg/H7olwLPhnaXUR4tFr4AxDJlKwT+TCkeVQ3Msart5UM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717257; c=relaxed/simple;
	bh=F/LKCWFo88ew4oyZzRTInRnAbUm9ChGZiHCOXADEEXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dUxw6U7UxmIecAUWqtahbmE7uB4I+T7RGZ21w7QRIM7j/UVS4nNlor8MrjgSZr0jRNIvypzFcVwNQEdRfkkaqCxAkv25NPJqpT4dwP7Rs6C7q8OlwTFzg9PZnLCkI0e6QjTWb2PTiswdSKcvD3jcaW+u2nVYG3pWxHRoBDd9CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aryfLk3C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aryfLk3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE74CC116C6;
	Tue, 10 Feb 2026 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770717257;
	bh=F/LKCWFo88ew4oyZzRTInRnAbUm9ChGZiHCOXADEEXk=;
	h=From:To:Cc:Subject:Date:From;
	b=aryfLk3C8Q1oDnXgwabgfVC4o/WdgLK9/Hxt5CHV/1oNkOjFP/acC5h9llLx/dfvx
	 TkK/QkqErnSiul5/JpaE59uOya1UEQdK6cfvx+4mWpj8jBm0D2lMjeulVHwcQfzWqx
	 mV00BfMul2RzxBeTclFjEb9p8f4DCCHH8Xkvcxn2rCo6q3JrLJTYE6acOyi6A9psFO
	 mN7miDdMJuiSex1q8qxGBy1Geof/LUQvoxGruOGRGVU6M7DMkNM0p64lte+P7+v/tl
	 F0F8qZTjsTeJUsoJzTlaiJzTG44kbvnuEKJgU4ToG5NV72XehAzGJLmBH7pcBLMSv/
	 QUZ1XbAufxDBw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] selftests/tracing: Fix to make --logdir option work again
Date: Tue, 10 Feb 2026 18:54:12 +0900
Message-ID:  <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
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

Since commit a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to
use with RV") moved the default LOG_DIR setting after --logdir option
parser, it overwrites the user given LOG_DIR.
This fixes it to check the --logdir option parameter when setting new
default LOG_DIR with a new TOP_DIR.

Fixes: a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to use with RV")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 3230bd54dba8..0a56bf209f6c 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -130,8 +130,7 @@ parse_opts() { # opts
       shift 1
     ;;
     --logdir|-l)
-      LOG_DIR=$2
-      LINK_PTR=
+      USER_LOG_DIR=$2
       shift 2
     ;;
     --rv)
@@ -199,6 +198,7 @@ fi
 TOP_DIR=`absdir $0`
 TEST_DIR=$TOP_DIR/test.d
 TEST_CASES=`find_testcases $TEST_DIR`
+USER_LOG_DIR=
 KEEP_LOG=0
 KTAP=0
 DEBUG=0
@@ -210,12 +210,18 @@ RV_TEST=0
 # Parse command-line options
 parse_opts $*
 
+[ $DEBUG -ne 0 ] && set -x
+
+# TOP_DIR can be changed for rv. Setting log directory.
 LOG_TOP_DIR=$TOP_DIR/logs
 LOG_DATE=`date +%Y%m%d-%H%M%S`
-LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
-LINK_PTR=$LOG_TOP_DIR/latest
-
-[ $DEBUG -ne 0 ] && set -x
+if [ -n "$USER_LOG_DIR" ]; then
+  LOG_DIR=$USER_LOG_DIR
+  LINK_PTR=
+else
+  LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
+  LINK_PTR=$LOG_TOP_DIR/latest
+fi
 
 if [ $RV_TEST -ne 0 ]; then
 	TRACING_DIR=$TRACING_DIR/rv

