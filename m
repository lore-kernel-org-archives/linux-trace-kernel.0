Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6035959;
	Wed,  8 Jul 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539166; cv=none; b=ln4Dchf6up7wua2YIhKp/EQMuwrjyBl0a6BAhqSAlrPCM5p8uYz96NLPG0dfergzSqF2seiUQYDjn6ypK98v0vgqE7ZQ3/Tr/XvZkNTSGeFMRUY+nJwg3JvswzE579ZPaCpjeHqky1InyOiIQZ2m2MEAUvz7HyFzrd9GubU79fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539166; c=relaxed/simple;
	bh=v9hEdK7ccL/Br4fOnWNLLTTEFWkkKvXC2qQt1c7kEYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ns/BxB/x5kxEDxWVCZIc2SxQaftp0CZ6JFTuZ6VbCZyhcEk3kA8g3tOjugjh2+39iw+LKs/edyZyTBlCeRx0pfq9KvQo3JoV/qA1AUWosFVkeuySxa2puj6GvgpqIc5jIm/2Yy4eqe/b0OQQGoq3DorMxgNsAFrTtcvsV3dwGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 571A81A0299;
	Wed,  8 Jul 2026 19:32:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 865CA6000D;
	Wed,  8 Jul 2026 19:32:34 +0000 (UTC)
Date: Wed, 8 Jul 2026 15:32:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: [PATCH] selftests/ftrace: Fix reading enabled_functions in
 add_remove_fprobe_module test
Message-ID: <20260708153239.055d56dd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 865CA6000D
X-Stat-Signature: huzn7b6patbwzkijx4xm84ztdgaom1m3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+n/ySaWf43UDPFEsJ3v98FwEVEIy13QV0=
X-HE-Tag: 1783539154-577436
X-HE-Meta: U2FsdGVkX19O2YlSsS4HEzRZGjTMcJxdZEQM3EHEKir5CivE9h7Pw2XA/153+NaQpVWqCCldLovEgUSe9SYLFHuRWCkk7bQPz+wWxyNTHNbgQe/GHHYa1c589M+5aZ4nhltMboj6ZYe2/3/u/Ra8TxTT4aWpES+f7lkVmv7366dl5y/OFNFR+mm6Zj8j3k9WGm9xcuxNGswGqtSPLJbnbkFF2dKtQp4tOcgH+uBnya7evlV4Zj2YDbFkAoxqa4VPSnu1mPC+aagByQYL7dt8lm+cN29Sv4AD3qHSJzc/e5/0mO3ZgdZEdabasgxg9Sw3F8uQQa3XsUJaU1icEfvpEQGwQ8bnngJHCl3jbEnkTj5ajgOAtf5R08EO+sFYxVO/

From: Steven Rostedt <rostedt@goodmis.org>

The add_remove_fprobe_module test checks the number of functions added to
the enabled_functions file to make sure that the functions added or
removed is as expected. The issue is that it expects this file to be empty
on start up.

Now that systemd uses BPF that attaches to functions via ftrace, this file
is not empty in several systems:

 # cat /sys/kernel/tracing/enabled_functions
 bpf_lsm_file_open (1) R   D   M 	tramp: ftrace_regs_caller+0x0/0x61 (call_direct_funcs+0x0/0x50)
	direct(jmp)-->bpf_trampoline_6442529439+0x0/0xe9

Change the test to read the number of lines in enabled_functions at the
start of the test and subtract that from the value of the count for the
checks within the test.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../dynevent/add_remove_fprobe_module.tc      | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
index 2915206777b6..89660a9adf44 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
@@ -16,23 +16,32 @@ echo > dynamic_events
 FUNC1='foo_bar*'
 FUNC2='vfs_read'
 
+:;: "Save enabled functions count" ;:
+ecount=`cat enabled_functions | wc -l`
+
+count_enabled_functions() {
+    count=`cat enabled_functions | wc -l`
+    count=$(($count-$ecount))
+    echo $count
+}
+
 :;: "Add an event on the test module" ;:
 echo "f:test1 $FUNC1" >> dynamic_events
 echo 1 > events/fprobes/test1/enable
 
 :;: "Ensure it is enabled" ;:
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -ne 0
 
 :;: "Check the enabled_functions is cleared on unloading" ;:
 rmmod trace-events-sample
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -eq 0
 
 :;: "Check it is kept clean" ;:
 modprobe trace-events-sample
 echo 1 > events/fprobes/test1/enable || echo "OK"
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -eq 0
 
 :;: "Add another event not on the test module" ;:
@@ -40,19 +49,19 @@ echo "f:test2 $FUNC2" >> dynamic_events
 echo 1 > events/fprobes/test2/enable
 
 :;: "Ensure it is enabled" ;:
-ofuncs=`cat enabled_functions | wc -l`
+ofuncs=`count_enabled_functions`
 test $ofuncs -ne 0
 
 :;: "Disable and remove the first event"
 echo 0 > events/fprobes/test1/enable
 echo "-:fprobes/test1" >> dynamic_events
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $ofuncs -eq $funcs
 
 :;: "Disable and remove other events" ;:
 echo 0 > events/fprobes/enable
 echo > dynamic_events
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -eq 0
 
 rmmod trace-events-sample
@@ -63,12 +72,12 @@ echo "f:test1 $FUNC1" >> dynamic_events
 echo 1 > events/fprobes/test1/enable
 echo "f:test2 $FUNC2" >> dynamic_events
 echo 1 > events/fprobes/test2/enable
-ofuncs=`cat enabled_functions | wc -l`
+ofuncs=`count_enabled_functions`
 test $ofuncs -ne 0
 
 :;: "Unload module (ftrace entry should be removed)" ;:
 rmmod trace-events-sample
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -ne 0
 test $ofuncs -ne $funcs
 
@@ -77,7 +86,7 @@ echo 0 > events/fprobes/test2/enable
 echo "-:fprobes/test2" >> dynamic_events
 
 :;: "Ensure ftrace is disabled." ;:
-funcs=`cat enabled_functions | wc -l`
+funcs=`count_enabled_functions`
 test $funcs -eq 0
 
 echo 0 > events/fprobes/enable
-- 
2.53.0

