Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B13DB96F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389855; cv=none; b=sY5jq0hGzkmIfMRMBgRDuaDKiwic2cX9idZiuyfZA6LDkcburLyV7h0Ev5F5vahGLcgXvkOdEg+P1hwLaslENPuDQAvJ7RQ+Z7BaRgOBvHbcOyf6bwXIE9K9ZaVHAjUhjkO/mMfhBJXLaU3Gzlje6rFeQHGhRnjbaEvEblW3RPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389855; c=relaxed/simple;
	bh=OIqt4eNxuZeWLvQ5uF6lgHISsxTSpgtkOwdAl/opFXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=i8XQwQGSaC9rIFzA0UNnJEx5T66Hgj1FD81BInMQhw72kN32/J5YZLGxGYbD5F351WcKslsIujr32HE33ErdT8dhp0SRZdI25bnvRRc46jI+z+OK7NItcGDK9r1qBpSx7Td7X1CwjEn8uNFxYjRKx/sXbqk0+QPC1ostbKGiN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffi9NBaa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffi9NBaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCubuEBtiGnb4xzpMnip+En2MyRkJl+KLec/mLKHQUs=;
	b=ffi9NBaaqz8ol53qcJVO/F5a+U/k1nJxjSqzmAlNMZJwq98bm6diVUbuyJk7Y01uIau9vK
	52r0qeK7qDiKQBR3ARrGmNuyGJkkGQxAysDmIOo96DYPF110NH7KRcpK8ZH+78g43pZ+ie
	mI2DVU1U/z9zCv6RqpbSMiPPDiNO5Q8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-VX5xTTMTPDGM8eqzrxjTOw-1; Thu,
 25 Jun 2026 08:16:17 -0400
X-MC-Unique: VX5xTTMTPDGM8eqzrxjTOw-1
X-Mimecast-MFC-AGG-ID: VX5xTTMTPDGM8eqzrxjTOw_1782389775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA8B1195419F;
	Thu, 25 Jun 2026 12:16:15 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E41FA30003B8;
	Thu, 25 Jun 2026 12:16:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 17/17] selftests/verification: Add selftests for deadline and stall monitors
Date: Thu, 25 Jun 2026 14:14:39 +0200
Message-ID: <20260625121440.116317-18-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: OaOrifFcob2nQLPtUH7Exh_sDhB-gWK0n5QO9nceCRk_1782389775
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add selftests to verify deadline monitors don't fail under expected
conditions and the stall monitor report violations only when expected.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../verification/test.d/rv_deadline.tc        | 21 ++++++++++++
 .../selftests/verification/test.d/rv_stall.tc | 33 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_deadline.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_stall.tc

diff --git a/tools/testing/selftests/verification/test.d/rv_deadline.tc b/tools/testing/selftests/verification/test.d/rv_deadline.tc
new file mode 100644
index 0000000000..b583096bed
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
index 0000000000..8e9bcbb441
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_stall.tc
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test stall monitor
+# requires: available_reactors stall:monitor printk:reactor stress-ng:program
+
+THRESHOLD=/sys/module/stall/parameters/threshold_jiffies
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
+
+echo 1000 > $THRESHOLD
-- 
2.54.0

