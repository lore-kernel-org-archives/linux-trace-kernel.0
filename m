Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517B3E3D91
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167303; cv=none; b=VGEBaLrvl9tJI8eVaYPCLDtGn6HtDq2eHCb7Q2x57uU/ISLkUUdHP1DZssNBnusQmKTDlztyFVofxY1Ty43cF8VJXJgRI2ZH2o++xb3cpSUsVbm6Hb2Lw1ErOzGj1C8OqNE4fkmjpMnrs/JUoMJWxyH3jC3cC1TcIgzH74c8jgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167303; c=relaxed/simple;
	bh=oeem+Ud3nm5ioBpJp2KL8Nu2qrfTVVl1ppFm5CYlXxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K4OK0f7HCOvFf2j2/7Fusx8EeNjUDW2eDWDAnhU10cUh4uuctF/jHTHZZ0ycXbFN57EBVHFZoXhw3I6oVcJWxWTToPI1+AgnFxAtDzreR7uNbyLoqR4lDsX6KJ0DW1oQUK7GoN9nORydfXYEeJhroIngS4q3ibDbjDOl6XHD36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ8iD41j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ8iD41j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOLKnqkN3lriGbQvo7O/1UtI9sEeayBnWBcR41PD8ek=;
	b=DQ8iD41jPZn68rWIrwIsLKNbYGd8aB/dl5xk+ViThojYOoK+KjXZZ/Rvawg9FqErSNFF22
	KN8nQxv7Dp7Igm9lJGAfuDH/s9CFSGzpZX3/jJDTcLFli0ODgKkZWkjyBvI6AH6N/yyz0W
	IkGIpQvvF7cYozFB+J8dg9vfFxW/3J8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-GGUQI_VxN0Kx0I7vfJHHgw-1; Mon,
 31 Aug 2026 05:08:16 -0400
X-MC-Unique: GGUQI_VxN0Kx0I7vfJHHgw-1
X-Mimecast-MFC-AGG-ID: GGUQI_VxN0Kx0I7vfJHHgw_1788167295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C473195411C;
	Mon, 31 Aug 2026 09:08:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A365118005BB;
	Mon, 31 Aug 2026 09:08:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 19/20] tools/rv: Add selftest for rv bpf
Date: Mon, 31 Aug 2026 11:05:23 +0200
Message-ID: <20260831090524.106845-20-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 0aUxnmAo2KuPWcKcRnc4LkS_a1rZ2YwiLRG0R0pMybk_1788167295
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftest cases for the rv userspace tool BPF commands and monitors,
test BPF monitors registration, unregistration and functionality,
including traces and reactors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/tests/rv_bpf.t | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 tools/verification/rv/tests/rv_bpf.t

diff --git a/tools/verification/rv/tests/rv_bpf.t b/tools/verification/rv/tests/rv_bpf.t
new file mode 100644
index 000000000000..902343f0d3f1
--- /dev/null
+++ b/tools/verification/rv/tests/rv_bpf.t
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source ../tests/engine.sh
+test_begin
+
+set_timeout 30s
+
+RVDIR=/sys/kernel/tracing/rv
+
+check "verify bpf subcommand help" \
+	"$RV bpf --help" 0 "manage BPF monitor registration"
+
+if $RV bpf unregister 2>&1 | grep -q "kernel does not support BPF monitors"; then
+	test_end
+	exit 0
+fi
+
+if ! mount | grep -q /sys/fs/bpf; then
+	mount -t bpf bpf /sys/fs/bpf
+fi
+
+check "nohz does not exist before register" \
+	"$RV mon nohz" 1 "monitor nohz does not exist"
+
+check "tqueue does not exist before register" \
+	"$RV mon tqueue" 1 "monitor tqueue does not exist"
+
+check "register BPF monitors" \
+	"$RV bpf register" 0 "registered [0-9]\+ BPF monitor(s)"
+
+set_expected_timeout 2s
+
+header="^[[:space:]]\+\(\([][A-Z_x<>-]\+\||\)[[:space:]]*\)\+$"
+type="\(event\|error\)[[:space:]]\+"
+genpid="[0-9]\+[[:space:]]\+"
+selfpid="\$pid[[:space:]]\+"
+cpu="\[[0-9]\{3\}\][[:space:]]\+"
+state="[a-z_]\+ "
+trace_task="${genpid}${cpu}${type}${genpid}${state}"
+trace_task_self="${genpid}${cpu}${type}${selfpid}${state}"
+trace_cpu="${genpid}${cpu}${type}${state}"
+trace_cpu_self="${selfpid}${cpu}${type}${state}"
+
+check_if_exists "run a BPF monitor without parameters" \
+	"$RV mon nohz" "$RVDIR/monitors/nohz" "" "."
+
+check_if_exists "run a per-task BPF monitor without parameters" \
+	"$RV mon tqueue" "$RVDIR/monitors/tqueue" "" "."
+
+check_if_exists "run per-task BPF monitor with tracing" \
+	"$RV mon tqueue -t" "$RVDIR/monitors/tqueue" \
+	"$header" "$trace_task_self" "\($header\|$trace_task\)"
+
+check_if_exists "run per-task BPF monitor tracing also self" \
+	"$RV mon tqueue -t -s" "$RVDIR/monitors/tqueue" \
+	"$trace_task_self" "" "\($header\|$trace_task\)"
+
+check_if_exists "run per-cpu BPF monitor with tracing" \
+	"$RV mon nohz -t" "$RVDIR/monitors/nohz" \
+	"$header" "$trace_cpu_self" "\($header\|$trace_cpu\)"
+
+# This is unstable, we may never see events from self
+#check_if_exists "run per-cpu BPF monitor tracing also self" \
+#	"$RV mon nohz -t -s" "$RVDIR/monitors/nohz" \
+#	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
+
+lines_before=$(($(dmesg | wc -l) + 1))
+check_if_exists "run a BPF monitor with a reactor" \
+	"$RV mon nohz -r printk && dmesg | tail -n +$lines_before" "$RVDIR/monitors/nohz" \
+	"rv: monitor nohz does not allow event"
+
+set_timeout 30s
+
+check "already enabled monitor returns error" \
+	"echo 1 > $RVDIR/monitors/nohz/enable; $RV mon nohz" 1 \
+	"monitor nohz (BPF) is already enabled"
+[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/nohz/enable
+
+check "already enabled monitor prevents unregistration" \
+	"echo 1 > $RVDIR/monitors/nohz/enable; $RV bpf unregister" 1 \
+	"monitor nohz is enabled, cannot unregister" \
+	"unregistered [0-9]\+ BPF monitor(s)"
+[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/nohz/enable
+
+check "unregister BPF monitors" \
+	"$RV bpf unregister" 0 "unregistered [0-9]\+ BPF monitor(s)"
+
+check "nohz does not exist after unregister" \
+	"$RV mon nohz" 1 "monitor nohz does not exist"
+
+check "tqueue does not exist after unregister" \
+	"$RV mon tqueue" 1 "monitor tqueue does not exist"
+
+check "nothing left to unregister" \
+	"$RV bpf unregister" 0 "unregistered 0 BPF monitor(s)"
+
+# Error handling tests
+check "bpf without subcommand" \
+	"$RV bpf" 1 "usage: rv bpf"
+
+check "invalid bpf subcommand" \
+	"$RV bpf invalid" 1 "usage: rv bpf"
+
+test_end
-- 
2.55.0

