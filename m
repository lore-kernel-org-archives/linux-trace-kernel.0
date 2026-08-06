Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096B40DB51
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005097; cv=none; b=AbjzhlWsQoYShF9atrev0hQK3DptLaiuJsp1XHcaZ/Jk2XmfALl7arpPj3bqelAHxvKveL3yZa4l56FV6OTS84edOXN4nd0JyF4WBwNQ0r6A5sSgnepZwztCfMJUimdRF7jD7QAlln9giCoIKZcWvm169Z7tzh+fWRItNjuBU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005097; c=relaxed/simple;
	bh=rfAg9+vlZRSeBDERi47CIWrnDjrZUkZOOA7cBBlEE8Q=;
	h=Cc:In-Reply-To:To:From:Subject:Message-Id:References:Date:
	 Mime-Version:Content-Type; b=GfE0v909LN7Phuc25AyFW39nA1npHWJLnPNV9LrnlseDV1ZcQr92YBAmOopx5YyDzhfpiwTcBisL/IvmkMTcWy2EWPH5JkwmNrQ6bWeRPuVkim0z53cCBzW89WI48w4LrtNb4zbMsc3izEsUWTwAz0BJMfTq68hyQPl+bi0cZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bcPqDrc4; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bcPqDrc4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786005089; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TzwvI+eXJsGb/cAPo0rfIYUZtB1cCMLRnPpRkYG8Z0s=;
 b=bcPqDrc4BsrVxQQqv84RZ5X7TS6yX0axyhdBZaAh34219lv0faocuFqxa4cBaaoN9ahbj7
 jmIGKNnXrdxXOBY5hfIWM3K5mLKv7VSZK1R5+cL/nb/FicrwD+jQVNdvnWFpxmQOy/yPfO
 22+jqz6s70rbylpdeVaUt/DzoftFzHgGvyNLsDLRPdrmugoVjQ4R2+xKCwYYIc3iO6C9X9
 G2En7FFMoGy9U2sWvDkM93eVunkzyEGabr4r9IxG1yBUISkQEi5/sLbfuvHle2iIoE6FJ+
 rt1wXxjccy/vrl1ehmPHXN9qukmWsfjYW189jbG3mFMBekG7+3JkewqCQjUr0g==
Cc: "Heiko Carstens" <hca@linux.ibm.com>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
In-Reply-To: <20260806083101.2651025-1-qirui.001@bytedance.com>
To: "Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Shuah Khan" <shuah@kernel.org>
X-Lms-Return-Path: <lba+26a74465e+e934ec+vger.kernel.org+qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Original-From: Rui Qi <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH 2/2] selftests/ftrace: Convert ELF entry point to file offset in uprobe test
Message-Id: <20260806083101.2651025-2-qirui.001@bytedance.com>
References: <20260806083101.2651025-1-qirui.001@bytedance.com>
Date: Thu,  6 Aug 2026 16:31:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

The add_remove_uprobe test uses "readelf -h" to obtain the ELF entry
point (e_entry) and passes it directly as the offset to uprobe_events.
However, uprobe_events expects a file offset, not a virtual address.

For PIE binaries (ET_DYN), the virtual address happens to equal the file
offset because the first LOAD segment has p_vaddr == p_offset, so the
test works by coincidence. But for non-PIE executables (ET_EXEC),
e_entry is an absolute virtual address (e.g. 0x406ad0) that far exceeds
the file size (e.g. 0x7be60). When the probe is enabled, uprobe_register()
checks offset > i_size_read(inode) and rejects it with -EINVAL.

Fix this by converting the virtual address to a file offset using the
ELF program headers: scan readelf -lW output for the LOAD segment
containing the entry point, then compute file_offset = e_entry -
p_vaddr + p_offset. For PIE binaries the result is unchanged; for
non-PIE binaries the offset is correctly translated.

The conversion uses only POSIX shell primitives (printf, arithmetic
expansion) with no dependency on gawk or perl.

Fixes: dc4b165855f2 ("selftests/ftrace: Use readelf to find entry point in uprobe test")
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 .../test.d/dynevent/add_remove_uprobe.tc      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
index f33a863be68b..9207fd817aae 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -12,9 +12,32 @@ echo 0 > events/enable
 echo > dynamic_events
 
 REALBIN=`readlink -f /bin/sh`
-ENTRYPOINT=`LC_ALL=C readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
 
-echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
+# Get the entry point virtual address from ELF header
+ENTRY=`LC_ALL=C readelf -hW ${REALBIN} | grep "Entry point" | awk '{print $NF}'`
+
+# Convert virtual address to file offset: find the LOAD segment containing
+# the entry point, then compute file_offset = e_entry - p_vaddr + p_offset.
+# For PIE binaries this is a no-op (vaddr == file offset), but for non-PIE
+# executables the virtual address is much larger than the file size and
+# must be converted, otherwise uprobe_register() rejects it with -EINVAL.
+ENTRY_DEC=$(printf '%d' "$ENTRY")
+OFFSET=$ENTRY
+while IFS= read -r line; do
+    set -- $line
+    [ "$1" = "LOAD" ] || continue
+    VA_DEC=$(printf '%d' "$3")
+    OFF_DEC=$(printf '%d' "$2")
+    FSZ_DEC=$(printf '%d' "$5")
+    if [ "$ENTRY_DEC" -ge "$VA_DEC" ] && [ "$ENTRY_DEC" -lt "$((VA_DEC + FSZ_DEC))" ]; then
+        OFFSET=$(printf '0x%x' "$((ENTRY_DEC - VA_DEC + OFF_DEC))")
+        break
+    fi
+done << EOF
+$(LC_ALL=C readelf -lW ${REALBIN} | grep LOAD)
+EOF
+
+echo "p:myevent ${REALBIN}:${OFFSET}" >> uprobe_events
 
 grep -q myevent uprobe_events
 test -d events/uprobes/myevent
-- 
2.20.1
