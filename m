Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010413DB338
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792855; cv=none; b=VDgKZHx4INBFARtB6rCg+5yR1hDoRe4+2tipnvAg6Y4fnMh2x4DY6sqSECkEwmvrGYrh+fb0wvL2S4UBw64XAZbbv1ypSH0gCEpFAmTS4l/IgqEW5UW1XxZ+qFiBAJuk59pyooC3jWUT6L/FHyOnl9lJSqrQNPKZX+xx7V8hRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792855; c=relaxed/simple;
	bh=T2lbyT/yM7x1H71zHyiVIbknJvhnpix0X4z2hlwzwLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=m0WBNGo/f8Y3hnV5lgPxZ8nNs2wS74rk+X/RBSOXdzCNbUZGaI++smITAz0HAxyA+su6FN3J/qLXieVn9Lg80LqwG6mTy3F1fWkmlphSJgSUnTkou6Hzc2blU383M9s42BFZUOArNtZinIrHbBAUjXyVgK1dsJdmHisVFvTVgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7j4Ms9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7j4Ms9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izA3D0CqoZEPLiW5dd3Cu7GNT4gzd8+KLF5CAaXCB1E=;
	b=G7j4Ms9arhGe+7BeRQkRZB3/SNA9kION5ws5rUqunr8jK6ougkYa9qhqVOe0sBRoyciNV8
	craHG4aJC3BREvZ3wL5WJwQ/UpQT86CtG+xYbn6Rd6OvGr76D9UdpbsgaaP9ul1np3X1/s
	wbxFkcL6CcR2id6QC5oYgU4+br07nS8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-NFarALcyPWOja-sJBvn8tQ-1; Thu,
 23 Jul 2026 03:47:29 -0400
X-MC-Unique: NFarALcyPWOja-sJBvn8tQ-1
X-Mimecast-MFC-AGG-ID: NFarALcyPWOja-sJBvn8tQ_1784792848
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2656F197753F;
	Thu, 23 Jul 2026 07:47:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84600180029A;
	Thu, 23 Jul 2026 07:47:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 17/17] selftests/verification: Add selftests for deadline and stall monitors
Date: Thu, 23 Jul 2026 09:45:34 +0200
Message-ID: <20260723074534.43521-18-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: D_z0nyFMhtO2drwGgFyL5biYzuuJxSHTnu6AW50K2dk_1784792848
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftests to verify deadline monitors don't fail under expected
conditions and the stall monitor report violations only when expected.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Restore original stall threshold after selftest

 .../verification/test.d/rv_deadline.tc        | 23 +++++++++++++
 .../selftests/verification/test.d/rv_stall.tc | 33 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc

diff --git a/tools/testing/selftests/verification/test.d/rv_deadline.tc b/tools/testing/selftests/verification/test.d/rv_deadline.tc
new file mode 100644
index 000000000000..fc95267dbb82
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_deadline.tc
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test deadline monitors trigger no reaction
+# requires: available_reactors deadline:monitor printk:reactor stress-ng:program
+
+load() { # returns true if there was a reaction
+	local lines_before
+	lines_before=$(dmesg | wc -l)
+	stress-ng --cpu 2 --sched deadline --sched-period 100000000 \
+		--sched-deadline 100000000 --sched-runtime 20000000 -t 5 &
+	stress-ng --cpu 2 --sched rr --sched-prio 50 --cyclic 1 \
+		--cyclic-policy rr --cyclic-prio 50 -t 5 &
+	wait
+	dmesg | tail -n +$((lines_before + 1)) | grep -q "rv: monitor [a-z]\+ does not allow event"
+}
+
+echo 1 > monitors/deadline/enable
+echo printk > monitors/deadline/reactors
+
+! load || false
+
+echo nop > monitors/deadline/reactors
+echo 0 > monitors/deadline/enable
diff --git a/tools/testing/selftests/verification/test.d/rv_stall.tc b/tools/testing/selftests/verification/test.d/rv_stall.tc
new file mode 100644
index 000000000000..515a10263ca1
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_stall.tc
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test stall monitor
+# requires: available_reactors stall:monitor printk:reactor stress-ng:program
+
+THRESHOLD=/sys/module/stall/parameters/threshold_jiffies
+ORIG_THRESHOLD=$(cat $THRESHOLD)
+trap 'echo $ORIG_THRESHOLD > $THRESHOLD' EXIT
+
+load() { # returns true if there was a reaction
+	local lines_before cpu
+	cpu=$(($(nproc) - 1))
+	lines_before=$(dmesg | wc -l)
+	stress-ng --cpu 1 --taskset "$cpu" --sched rr --sched-prio 1 -t 3 &
+	stress-ng --cpu 5 --taskset "$cpu" -t 3 &
+	wait
+	dmesg | tail -n +$((lines_before + 1)) | grep -q "rv: monitor stall does not allow event"
+}
+
+echo 5000 > $THRESHOLD
+echo 1 > monitors/stall/enable
+echo printk > monitors/stall/reactors
+
+! load || false
+
+echo 0 > monitors/stall/enable
+echo 70 > $THRESHOLD
+echo 1 > monitors/stall/enable
+
+load
+
+echo nop > monitors/stall/reactors
+echo 0 > monitors/stall/enable
-- 
2.55.0

