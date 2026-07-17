Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD1314D35
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303324; cv=none; b=rYkV3Bfy1BHmRBZhryMLD09zRBqmmhy2OE3a2R5vuK34pUlvourhHNow4pa9dYQb3UjmQa+oY1a9ybJuJzwcnOV0e/XIvTWtyaD8zCM4im8YgDO1VT4ShznMcJ3RyQhGzYKdZQYylkO6RFUQn+ofC94VH7LJ/zofR4GnkGAPDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303324; c=relaxed/simple;
	bh=5rKxQ1zpC6RNHSnEZCSocKyHSrRa62pnNI/y7I042Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D8dfBnRUBLecZgkatbPHiv0RZS16yl/UMZrGKlBCjqZhWnMA3/2GboZw6Zptav2uc1D/7CHRXiZTQKnFpHIx43817NjmtRRFsY8Kx/voWKpujFsf49O2fP8kHlP0sTgPfCfRDIuJRsykezhTZEJpz0cD7OvpokcLAGQh19lwkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T69TKw/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T69TKw/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgnjwSI/hPUOWvDV3KsGpmfEM2qzvu1QMDBHUn9SIJ0=;
	b=T69TKw/Jz6h8fbNcgSZtZiajrU8QRFMR8i26Sxo1I5/kttrZqYqZHncHGLMlnReAOHoirE
	shdiyS9HrtUuS4I/5Js4LKYjBYoX++PRHSDntq0EnlqH+FfW+rFQGtVrKYxo0H+mkE3wCh
	3cKIwayTqzcdEJU8oTWW1ZXhpH9BsNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-50J7uDgQNqmo3CPdKv6Jug-1; Fri,
 17 Jul 2026 11:48:39 -0400
X-MC-Unique: 50J7uDgQNqmo3CPdKv6Jug-1
X-Mimecast-MFC-AGG-ID: 50J7uDgQNqmo3CPdKv6Jug_1784303317
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BBE9195D026;
	Fri, 17 Jul 2026 15:48:37 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 001EA30040BF;
	Fri, 17 Jul 2026 15:48:32 +0000 (UTC)
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
Subject: [PATCH v4 17/17] selftests/verification: Add selftests for deadline and stall monitors
Date: Fri, 17 Jul 2026 17:46:38 +0200
Message-ID: <20260717154638.220789-18-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Rph8zbpzx1LnHm5h2MXFAPLsM8Ab3j48AnpbSVcNAiA_1784303317
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftests to verify deadline monitors don't fail under expected
conditions and the stall monitor report violations only when expected.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Notes:
    V4:
    * Restore original stall threshold after selftest

 .../verification/test.d/rv_deadline.tc        | 21 ++++++++++++
 .../selftests/verification/test.d/rv_stall.tc | 33 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc

diff --git a/tools/testing/selftests/verification/test.d/rv_deadline.tc b/tools/testing/selftests/verification/test.d/rv_deadline.tc
new file mode 100644
index 000000000000..b583096beda6
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_deadline.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test deadline monitors trigger no reaction
+# requires: available_reactors deadline:monitor printk:reactor stress-ng:program
+
+load() { # returns true if there was a reaction
+	local lines_before
+	lines_before=$(dmesg | wc -l)
+	stress-ng --cpu 2 --sched deadline --sched-period 100000000 --sched-deadline 100000000 --sched-runtime 20000000 -t 5 &
+	stress-ng --cpu 2 --sched rr --sched-prio 50 --cyclic 1 --cyclic-policy rr --cyclic-prio 50 -t 5 &
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

