Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543841;
	b=aXw3dnZlhSFTBlebfqz58kjUQbeDG/lvfFeiNobVro4y/NPeihkTnun6SZUU5QAwbGh3
	 LzUNGkUXLU8MHd2GsgxtePO5RysHAR3jNgVqukhXpZm+Pk0WNT8yaK1vKCYNq0bExGCSX
	 6DbbXwPTVSCYxMQkG0hOO7I5pEn8pBnF8OPhIQ8+Q/3mhh5mWfWTpx1ox99Csk8q1osmR
	 FwIWOceyWlAp+nxpDLnGVF+B47idtJqoV+bQaHmhcUwhC2mDD1G/h4OHKfh5iS8xz7o/D
	 GVb8bQQKBlreweYWgwKM7Hd/K+53Mao9uEyOcaXm9fv5L1RMnPRHdXYxoAJRJ1u1gcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gzqoe745QeOptXrgCOHl8A6oH8ajIqyYK3/iDvfFSMg=;
	b=Kq+/IJyblHAjVZZhU6L3Q3TN5IePUIgNviumbuEGf1r4RVM+GRe21+EcCsJDndheQGnX
	 AfVJemfxpgZwhp0w1YuM5UZAI/pkrMcjUfk6v3Kraj5Z4r7n/1nzYuQ8owCxpr6gty+10
	 GTvCVqXa4cX3IHJR82Ti8bjjDhzjM2NL2sUi+EaS1YsgeJCpf8+THdLo2GppkHJGtxAdr
	 C1jT0YhGVocnKZ9QR/I3wbnFKoBp4OVyhrMhR9t6XcPsQurLl5/ZDlvHcZ1K5TPjd6lPp
	 NuLgleHDC+mDhYjyRRzxbKKgloQ1qfDbezKS8Lgp35iBgaqS3cCph83F8+pwoDygnPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbZ+Jkj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEB606A337;
	Tue, 24 Nov 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbZ+Jkj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9162D1F000D0;
	Tue, 24 Nov 2026 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543840;
	bh=gzqoe745QeOptXrgCOHl8A6oH8ajIqyYK3/iDvfFSMg=;
	h=From:To:Cc:Subject:Date;
	b=nbZ+Jkj4H1L1lWFy3wN1OgJBx39lrNyQJ6gjP7g1jhj+P2MeaeACi5B1A52KPB46T
	 oD3lua2wtKY3mj4nhoKK91kEmOoiTqPRcOodORly2b0q6ppPDH2vx7c9QsfIswA8m6
	 VqclsG3svi9yvTVW1NXORDP9HEmW4+oDhmQYwm7rFAUHF8Ik90UYzwLcCUnPU8UpCR
	 Ej82EWhdWahYDnPw3qNTbM//LAt1bUy9Y+BDEM5HaCpdytCmNw9ZYpNAu9ZWs3qA1q
	 TAc4BxCdeNhbLfhaQRNzlgdfDxF5sB9iE2F1TkMMmiC7kScaCoTXo897DmWDoS+n5B
	 AdKBmni6l4Xkg==
From: Sasha Levin <sashal@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Skip the sample module BTF probes without module BTF
Date: Tue, 24 Nov 2026 13:10:38 -0500
Message-ID: <20261124181038.2362595-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_probe_event.tc and btf_typecast_accepted.tc probe sample_timer_cb()
in the trace-events-sample module and cast its argument to struct
foo_timer_data, so they need the BTF of that module. Without
CONFIG_DEBUG_INFO_BTF_MODULES the module has no BTF, the probe is
rejected with "No BTF entry for this probe point" and both tests fail.

A "make kselftest-merge" config can end up without module BTF. The net
and drivers/net selftest configs set CONFIG_DEBUG_INFO_BTF_MODULES=n,
and only CONFIG_DEBUG_INFO_BTF_INLINE from the bpf config turns it back
on, which needs pahole 1.32. KernelCI builds its kselftest kernels this
way with pahole 1.31, and both tests fail on all the boards that run
them.

Check for /sys/kernel/btf/trace_events_sample. Without it
btf_probe_event.tc is unsupported and btf_typecast_accepted.tc skips
only the sample_timer_cb() probes.

Fixes: 7d8d6ad659c0 ("tracing/probes: Add a new testcase for BTF typecasts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ftrace/test.d/dynevent/btf_probe_event.tc |  3 +++
 .../test.d/dynevent/btf_typecast_accepted.tc  | 22 ++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
index bf71368c31a4a..d832eca058de1 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
@@ -8,6 +8,9 @@ if ! lsmod | grep -q trace_events_sample; then
   modprobe trace-events-sample || exit_unresolved
 fi
 
+# The typecast below needs the BTF of the module
+[ -e /sys/kernel/btf/trace_events_sample ] || exit_unsupported
+
 echo 0 > events/enable
 echo > dynamic_events
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
index dd5552727054c..50d303f7acc9f 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
@@ -25,6 +25,12 @@ if ! lsmod | grep -q trace_events_sample; then
   modprobe trace-events-sample || exit_unresolved
 fi
 
+# The sample_timer_cb() probes need the BTF of the module
+SAMPLE_BTF=
+if [ -e /sys/kernel/btf/trace_events_sample ] ; then
+  SAMPLE_BTF=yes
+fi
+
 if [ "$FPROBES" ] ; then
   # 1. Test basic typecast on fprobe
   echo 'f:fpevent1 vfs_read name=(file)file->f_path.dentry->d_name.name:string' >> dynamic_events
@@ -42,8 +48,10 @@ if [ "$FPROBES" ] ; then
   echo 'f:fpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
 
   # Test this_cpu_read and this_cpu_ptr on fprobe
-  echo 'f:fpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
-  echo 'f:fpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  if [ "$SAMPLE_BTF" ] ; then
+    echo 'f:fpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
+    echo 'f:fpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  fi
 fi
 
 if [ "$KPROBES" ] ; then
@@ -63,8 +71,10 @@ if [ "$KPROBES" ] ; then
   echo 'p:kpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
 
   # Test this_cpu_read and this_cpu_ptr on kprobe
-  echo 'p:kpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
-  echo 'p:kpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  if [ "$SAMPLE_BTF" ] ; then
+    echo 'p:kpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
+    echo 'p:kpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  fi
 fi
 
 # Verify the events exist in dynamic_events
@@ -77,7 +87,7 @@ if [ "$FPROBES" ] ; then
   grep -q "fpevent6 " dynamic_events
   grep -q "fpevent7 " dynamic_events
   grep -q "fpevent8 " dynamic_events
-  if lsmod | grep -q trace_events_sample; then
+  if [ "$SAMPLE_BTF" ] ; then
     grep -q "fpevent9 " dynamic_events
     grep -q "fpevent10 " dynamic_events
   fi
@@ -92,7 +102,7 @@ if [ "$KPROBES" ] ; then
   grep -q "kpevent6 " dynamic_events
   grep -q "kpevent7 " dynamic_events
   grep -q "kpevent8 " dynamic_events
-  if lsmod | grep -q trace_events_sample; then
+  if [ "$SAMPLE_BTF" ] ; then
     grep -q "kpevent9 " dynamic_events
     grep -q "kpevent10 " dynamic_events
   fi

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.53.0

