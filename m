Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC93EFFA9;
	Tue, 21 Jul 2026 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593242; cv=none; b=ch0gz8RP97dYkkLbnOksjS/qLawMuJZ8yoAUmEm12of5BP3EO5/n3+l8qcmYLfqZHrcCXSC/HwjIenHqfBikw4I63pIC7tDH4D7+MWNEjGIVo3xeIr3VVweGqMgzU/5HmZBOVAz4S7mGUahDEM/XChMlAoDf/Zzgw3zDHGLm/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593242; c=relaxed/simple;
	bh=1h4JxwJyO8SIcXEX92WqeDuHL+4W9pfyCgXRgGwcH3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COMSU0d7g27oDwDYw09tIIZR+0KDuS8BQjEvYLmdCYLTGUS7xrUvyW1qEzdhLwLKIovFPghDld+ajvBPdKIYlvAAXCuD5QJ7lUDSkwh65nIqOtF1C/2p6BCSrbVweI/ipAHRailKU6aw+0BziUDFpdv5loAIlDzEEXe+3xtPbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfFKlArK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfFKlArK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BE51F000E9;
	Tue, 21 Jul 2026 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593241;
	bh=wFEXui/GukxLmbOyD/Rw1YoanC5pjuLSP/WS5Y5GA5M=;
	h=From:To:Cc:Subject:Date;
	b=ZfFKlArKTfxHH90NJ3L8nDSxc5eCQnriojq4jf05lLOyR8G/wC6Q6c4vsHpC5RDlw
	 8HEMSxWcSdTkJLVbYmYONZ0uHxFHqRf84OlGvvkN7ZEIQZl4iIxOgy01enh75IQU0Z
	 tEggriw6q4PK2OxUxttr658mE7XogpMUBMxlv4wHdnDroQ3TfGAxpTkOdrfYUPhAWB
	 o4BPTTkIeiRBMW0MXG/RHSHzfmCb53SLRFokOWCXfZz/498YhfK+il2W4MR6jKAhK9
	 8FMA8rLhZXd8lcbz+4LvTAT8V0E5yDCuQDnO1ZimPHtAyaoeoE2Ytd8peoza5fn4uA
	 2MuhAWzvPYtag==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	oliver.sang@intel.com
Subject: [PATCH] selftests/tracing: Fix flakiness in trigger-hist-poll.tc by waiting for task exit
Date: Tue, 21 Jul 2026 09:20:36 +0900
Message-ID: <178459323652.354837.10711230683477156733.stgit@devnote2>
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

Commit c5c413534d40 ("selftests/tracing: Have trigger-hist-poll.tc use
sched_process_exit") changed the target event from sched_process_free to
sched_process_exit to avoid timeouts under CONFIG_RCU_LAZY.

However, sched_process_exit fires inside do_exit() before the exiting task
completes teardown and before the parent shell reaps it. When poll unblocks
upon sched_process_exit, checking whether /proc/${BGPID} exists immediately
after poll returns causes a race condition between poll exiting and the
parent shell reaping the child process.

Fix this by waiting for the background sleep process (wait ${BGPID}) and
removing the fragile /proc/${BGPID} check. Checking whether the event was
logged in the trace buffer already verifies that poll did not exit before
the event occurred.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202607161651.ab0a5bf6-lkp@intel.com
Fixes: c5c413534d40 ("selftests/tracing: Have trigger-hist-poll.tc use sched_process_exit")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
index 04eb8546fc07..d54d54f9ec77 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
@@ -38,11 +38,7 @@ BGPID=$!
 ${POLL} -I -t 4000 ${EVENT}/hist
 echo 0 > tracing_on
 
-if [ -d /proc/${BGPID} ]; then
-  echo "poll exits too soon"
-  kill -KILL ${BGPID} ||:
-  exit_fail
-fi
+wait ${BGPID} 2>/dev/null ||:
 
 if ! grep -qw "sleep" trace; then
   echo "poll exits before event happens"
@@ -60,11 +56,7 @@ BGPID=$!
 ${POLL} -P -t 4000 ${EVENT}/hist
 echo 0 > tracing_on
 
-if [ -d /proc/${BGPID} ]; then
-  echo "poll exits too soon"
-  kill -KILL ${BGPID} ||:
-  exit_fail
-fi
+wait ${BGPID} 2>/dev/null ||:
 
 if ! grep -qw "sleep" trace; then
   echo "poll exits before event happens"
@@ -72,3 +64,5 @@ if ! grep -qw "sleep" trace; then
 fi
 
 exit_pass
+
+

