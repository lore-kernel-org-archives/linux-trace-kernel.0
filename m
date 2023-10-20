Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0FDDAB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G4ZwyRGD"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F82EA4;
	Fri, 20 Oct 2023 03:43:22 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB9AA20B74C0;
	Fri, 20 Oct 2023 03:43:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB9AA20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697798601;
	bh=jHEMFSWvEcx1czRBXUE2OS96KE3ALvaIroFuMgx4g8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4ZwyRGDZ8VV6xRFRRI5YT2sOs4vbJ9C1Ls7T6m8Ll4k+alQa91Ymp65cGpTEHlvM
	 fivLgH/sEdRBx51wFJ5cBYSAa87N3p4rUHYZl3JyELXjwSm+WgCsYP86XHT7wto0Fe
	 1f9HbJFCI1NfES2mnL2pq6X2moTAjGc68KWZk4qQ=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 2/2] selftests/ftrace: Add new test case which checks non unique symbol
Date: Fri, 20 Oct 2023 13:42:50 +0300
Message-Id: <20231020104250.9537-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020104250.9537-1-flaniel@linux.microsoft.com>
References: <20231020104250.9537-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Cc: stable@vger.kernel.org
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
-- 
2.34.1

