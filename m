Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422A3EDAC0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299947; cv=none; b=MX1h7bWX0J3sSN1taT3uS2gU8LawqMCgJeSTWfhEIBjKmpgWr72I+6HA6uRQds82K21mYOTU4HqWMN7jGl0qER8L0Q23E0GeghMTyQ9EcGVkzQ2JvFJ+RmYWj345bxQ7LiYXloH9q4nPDdDpKkD7soIKFRAs5r6OhxrDAkG69yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299947; c=relaxed/simple;
	bh=ivjLMnYh+gDKhE3NyeK+npuA+uD8EDy6F2Zu9UaPPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2nLFkSh9Efl+/GlN5R0UQ2AZ3SANKfkQUxJb+5LGqro7MngBlAIHIoDRjsvUNFo6/UmLu7pI0DGZAfmwD7SUO0l2onVWC48mjtksdA5ApXXXdmQWVZ/I8P274/IldxFZ2adcXAPAzvzKfY032dWkj/EJlNQr7OpkleMH8Jbi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e41WHapi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e41WHapi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c7120353f1so89763985a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299946; x=1770904746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYk5NaEanNq6uThb2wsIHzNJQE6YGo/SE46HgW+lAvg=;
        b=e41WHapiL96hDLsLJ9qC0wStyceeTXamm5sQZwiNxsIovYRZ2solJ71u0JU1OcQyH2
         d7NkKe7R5H3QThR8pRFvWz2p7jYGnRkDosI10+rw0i5trrN/gnrfjkF+PA/lK/jUktXG
         zbCEo60dZu3ek/bLDocaAFhCqxtpKEAoDD/4y6thevVsc44EgCBEZsZYPG6SdviHyDS+
         9LaYdO98klObHxrJS0veo80dCqY1Ov25jGZnQmnIsJxqjDkI1XOuRCBEnxqR8DUu6Y2A
         Z08J/7rU/nIWTstkbqweDRlJ3eB5GO24oF9S8i3E9LQvBr/WwERoK7cTAuVebDshayPP
         KDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299946; x=1770904746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYk5NaEanNq6uThb2wsIHzNJQE6YGo/SE46HgW+lAvg=;
        b=hQ+grk2vvVQfcyaxVRJF5COFKbS4Kl91BVeUABi+PHXbVECnDxGori6XqwS9x3LwB4
         +6GoSoZz5cbmiXZqwUbd80q2UNegnZ65rmQiK+oFBzuCEwLkpE3YvWYgakvbPWu8VzE6
         Npn/7MToPbkKJoh7d4HMhn/pJZ8jqm5VGYZMT9QFS5HnGokuPvO5ZNQSN5tSEhVStfET
         kIDBWqptXXjyzEdlrkitrnVFBYD6c0dNRRNCiijVoLnncpg77j2X1ikNBHR3I+y+Ccz8
         oQ2xbGYzOrs9TbJaGI/UJVgNxz3nqTpBm6nK0F9JbS1AG3ZaRq8mHNidLdzA9iyQmjaK
         k4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHtTkHu52R77Odynq8tRkCvdq57kj20BzP6lcAGseichLxKsiD2IG+D0IXxcZE41RUnzsso92cTJHL7W64cqZOv34=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfeoqSxlqLRfjoqjb+9lbHzDkkzbWByc6JWWTeO6hY+tMMJR8
	4/aurLxGtu8O/YgY9XyBjqUjEcEX7dZk6kk/yXCURdpYEPWlMWRs3Clc
X-Gm-Gg: AZuq6aIYa0ZUXoHuRiDA536gJLC47vruMFGeWuen61Re6In7EzDTB7iOB0oV80kLCSc
	RF/+dMlaEVIGRKLK5SoH71C6aTgYRi5qZCKaGcCwm+vo8Z5kmRejD0Ny2gb784cJeuwAlAg/xEa
	AQIzNy6L63XKA5cbShIoA0g9YKCv41+msnGgb9g0K+FwWKAvXefDcUple0hAAbCuMoHwULvlx8P
	Di9gYRWCTrCGhpqkunyK18zZpyGU2Eka/tg+NWlMCiQzhVZbBjTWYZLxCusp5u9Te3KZbcwWBGE
	43qqkt3wUxAMYgASAjpHhlWMglWTK7wmYGW8wO9Sn9RwuI8dMDOWCR4OvAFQG09SdlfPIVq4eEX
	p7BY1dJpaiW0mP6u6k0xL8BaSrBqNpQSv9ofczH1dnm2e5BOxOSgHDnloJvtmYbCh/WVIkq8ZZS
	EO5Bu3mX3Br+i6wEE6gNv2h8kZNW2wn/vr+z01M3m5opUybiWKUa7LFaDg4Bqr5YsJEQRJjA8=
X-Received: by 2002:a05:620a:170c:b0:8be:94e6:3e6c with SMTP id af79cd13be357-8ca2f87eaa2mr899365685a.39.1770299946058;
        Thu, 05 Feb 2026 05:59:06 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:87a6:ecbb:44f:b3c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm404975985a.41.2026.02.05.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:59:05 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	corbet@lwn.net,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v6 4/4] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Thu,  5 Feb 2026 08:58:42 -0500
Message-ID: <20260205135842.20517-5-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fprobe_list.tc to test the comma-separated symbol list syntax
with :entry/:exit suffixes.  Three scenarios are covered:

  1. List with default (entry) behavior and ! exclusion
  2. List with explicit :entry suffix
  3. List with :exit suffix for return probes

Each test verifies that the correct functions appear in
enabled_functions and that excluded (!) symbols are absent.

Note: The existing tests add_remove_fprobe.tc, fprobe_syntax_errors.tc,
and add_remove_fprobe_repeat.tc check their "requires" line against the
tracefs README for the old "%return" syntax pattern.  Since the README
now documents ":entry|:exit" instead, these tests report UNSUPPORTED.
Their "requires" lines need updating in a follow-up patch.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 .../ftrace/test.d/dynevent/fprobe_list.tc     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
new file mode 100644
index 000000000000..45e57c6f487d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
@@ -0,0 +1,92 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event list syntax and :entry/:exit suffixes
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
+
+# Setup symbols to test. These are common kernel functions.
+PLACE=vfs_read
+PLACE2=vfs_write
+PLACE3=vfs_open
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# Get baseline count of enabled functions (should be 0 if clean, but be safe)
+if [ -f enabled_functions ]; then
+	ocnt=`cat enabled_functions | wc -l`
+else
+	ocnt=0
+fi
+
+# Test 1: List default (entry) with exclusion
+# Target: Trace vfs_read and vfs_open, but EXCLUDE vfs_write
+echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
+grep -q "test/list_entry" dynamic_events
+test -d events/test/list_entry
+
+echo 1 > events/test/list_entry/enable
+
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+# Check count (Baseline + 2 new functions)
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 1
+echo 0 > events/test/list_entry/enable
+echo "-:test/list_entry" >> dynamic_events
+! grep -q "test/list_entry" dynamic_events
+
+# Count should return to baseline
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $ocnt ]; then
+	exit_fail
+fi
+
+# Test 2: List with explicit :entry suffix
+# (Should behave exactly like Test 1)
+echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
+grep -q "test/list_entry_exp" dynamic_events
+test -d events/test/list_entry_exp
+
+echo 1 > events/test/list_entry_exp/enable
+
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 2
+echo 0 > events/test/list_entry_exp/enable
+echo "-:test/list_entry_exp" >> dynamic_events
+
+# Test 3: List with :exit suffix
+echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
+grep -q "test/list_exit" dynamic_events
+test -d events/test/list_exit
+
+echo 1 > events/test/list_exit/enable
+
+# Even for return probes, enabled_functions lists the attached symbols
+grep -q "$PLACE" enabled_functions
+grep -q "$PLACE3" enabled_functions
+! grep -q "$PLACE2" enabled_functions
+
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -ne $((ocnt + 2)) ]; then
+	exit_fail
+fi
+
+# Cleanup Test 3
+echo 0 > events/test/list_exit/enable
+echo "-:test/list_exit" >> dynamic_events
+
+clear_trace
-- 
2.43.0

