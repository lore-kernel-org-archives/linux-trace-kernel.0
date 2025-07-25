Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE9246779
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450726; cv=none; b=Vkz50r86ExJ1r+wB3oXFkG+Wuebu1+2dQDPk7RgsMUAHCMuJeNYAz1G2ZclZi0c2Zmvs3iEVGnHJoH3VN2VlvjvI70p21Sz9OADTiAv/zkTpdlwj0H4MTc8f90mBlLDGUhBB+4TEyn36qr0xMxlgQav6vHA8hYCwBSIyvI1jIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450726; c=relaxed/simple;
	bh=o/h5xdUlELYwu+ivu3UhGxbnjsxwTaAr0jIo6FCyuLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgKH0iHMdRsd+7nDjPnv3u31eDl7A4MzKS8fsqu6asK4S6nVBwM3nINVQI+D0nO9cXuu4jVtHZNeQlx7WpvTu5KyjBBnm8WJKiK2NSGQhfTWUSKwU3ASTkkif4PrFqYS858JmYmuN/OKCTZXoWM7kqVQNgiyVQXqZXZx3C9eKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9BrdHXo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9BrdHXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753450723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ah1neRedaqT5NMnqo2wenopaUT/ePL4TlLD55zdFBXA=;
	b=W9BrdHXoWDA7Qh17E4DUYVlgZI5Yjot9mTv2m06R3LGhI5ONC/jKJP4c4CF9Gel3XQdxMb
	vLCYERu7yllAyNr+pRFeCpwHqRdUniH8QuXbadClbDciy5qgsG0hXfOxjM09ExM79iL5P2
	NfqsqEN5PGurAAqwYzA2Gh5RVOAg1Is=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-rtSNbs1KMzmw0SqciNIjhg-1; Fri,
 25 Jul 2025 09:38:39 -0400
X-MC-Unique: rtSNbs1KMzmw0SqciNIjhg-1
X-Mimecast-MFC-AGG-ID: rtSNbs1KMzmw0SqciNIjhg_1753450718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96FE81955EE8;
	Fri, 25 Jul 2025 13:38:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 154991966673;
	Fri, 25 Jul 2025 13:38:35 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rtla/tests: Test timerlat -P option using actions
Date: Fri, 25 Jul 2025 15:38:17 +0200
Message-ID: <20250725133817.59237-3-tglozar@redhat.com>
In-Reply-To: <20250725133817.59237-1-tglozar@redhat.com>
References: <20250725133817.59237-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The -P option is used to set priority of osnoise and timerlat threads.

Extend the test for -P with --on-threshold calling a script that looks
for running timerlat threads and checks if their priority is set
correctly.

As --on-threshold is only supported by timerlat at the moment, this is
only implemented there so far.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh                 | 2 +-
 tools/tracing/rtla/tests/scripts/check-priority.sh | 8 ++++++++
 tools/tracing/rtla/tests/timerlat.t                | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-priority.sh

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 64c5be4313de..a97d644ead99 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -69,7 +69,7 @@ check() {
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-			[ -n "$expected_output" ] && \
+			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
 				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
diff --git a/tools/tracing/rtla/tests/scripts/check-priority.sh b/tools/tracing/rtla/tests/scripts/check-priority.sh
new file mode 100755
index 000000000000..79b702a34a96
--- /dev/null
+++ b/tools/tracing/rtla/tests/scripts/check-priority.sh
@@ -0,0 +1,8 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+pids="$(pgrep ^$1)" || exit 1
+for pid in $pids
+do
+  chrt -p $pid | cut -d ':' -f 2 | head -n1 | grep "^ $2\$" >/dev/null
+  chrt -p $pid | cut -d ':' -f 2 | tail -n1 | grep "^ $3\$" >/dev/null
+done && echo "Priorities are set correctly"
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index db263dc90a2d..c71aed5534bf 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -25,7 +25,8 @@ check "verify help page" \
 check "verify -s/--stack" \
 	"timerlat top -s 3 -T 10 -t" 2 "Blocking thread stack trace"
 check "verify -P/--priority" \
-	"timerlat top -P F:1 -c 0 -d 10s -q"
+	"timerlat top -P F:1 -c 0 -d 10s -q -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh timerlatu/ SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check "test in nanoseconds" \
 	"timerlat top -i 2 -c 0 -n -d 10s" 2 "ns"
 check "set the automatic trace mode" \
-- 
2.49.0

