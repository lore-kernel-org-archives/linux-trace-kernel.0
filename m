Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915841DE4CE
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768699114; cv=none; b=RBdosshpWaHzDtH18rlQqcF394Kp9uknOCjbc3XBye4BPEShGY6le5FgsVKCVFW1AmBqIwMhrph97lleT34gIyMrzGntdsQYYnpuiuKnqx3H9Udlnln2h6xrU+kdrZY/zBf/0XtpqafyKLRSCk/VaZ0ZQDMyDDrjJAEloXDi2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768699114; c=relaxed/simple;
	bh=ZDrrQk7+ZbCO+fyU001b1FgFHm9Go+TFY1C20mho8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSB+2L5AtpE2HbcrcdbOQRPAN8tnaAgjXZXLXvYOGwOh02+0zkiEQKOgPe6iaBULDQ98VKRIZy8KJBnKwKhIj4zj4IkztKHz9an3WwIL9TpGiMhseBDkxHE8vgM6H1fYNeB0sRQrExA/b+kmYp2f2c1w0A29YuVOfdQ0F6vPVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5jsxLwi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5jsxLwi"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c655e0ee70so348021885a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Jan 2026 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768699109; x=1769303909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tho2VqUNeLqQMboUEaDyPNZ6VVJ6gB0GGd5RNkCMkk=;
        b=N5jsxLwiT0SL5Wdimo9JYVPftYjVKiGF3mRlvZvV98W+RJYJXT81Jrr4xusGkvsEe0
         QmxS83+jvp5HAR2+VItnIK4E0rDDPPYNndfGcseZyevAiuPzSnsp32TywbQOAz5xXSJt
         ANv2TE+DjMBvKpdXJ87a4Pr3l8WL+pAzxZEDLMXBwzNXrW8dGZ2linDwqEHmjcAYBpTJ
         83kYXOTX0RRGJ20j00kB3rwNQZqAlqGc2f8jFJxglTjVwPnVwkzvtFQhiBXEBT9NpCLw
         YDU7J3R5EwPvWZtDoEEvERjJ75LxZQl3QXtcFZoHiW6dS0HjlCDIpl5nSCCV6hdXR5NA
         EUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768699109; x=1769303909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Tho2VqUNeLqQMboUEaDyPNZ6VVJ6gB0GGd5RNkCMkk=;
        b=AlOnUu+JadA8GR8hF9QMgmPbX2rvZMvG0Kdf//blo1gFhC21nQVTg25iOUr54FZxUF
         +5+KtvVUHK5mTvlYfBI2UaJATvQ0y1qBWqEKR0WkJhVZSTLm6Zu9+2C6dSXBptjTHL07
         hBsKdhot+d5uKjPqX5I83mLRciz/AUTtgN9fQHQ+0fU1NiBDLo5Ujh6cMpsrc8jC7s8j
         9QWpBhpV+AMFQRazV+0sAtNFKnW8Xg08VyEvd8+7YlCrR2UZ73C9fC4WdSosItTAi+qc
         sxnuRfCPxbqrrUzQwS2eBRXxUSEGgpv3hHiWqN6KDpaedvHJ8RcbnuzUzruG7bK3PSD2
         K2YA==
X-Forwarded-Encrypted: i=1; AJvYcCUiN332IKxll2x4PhEha9soNTfGTBh2B2exGrgQP+wLrmxdpRCL0+7QAEDZhkWDWm/n2n6EjPdE6epq8/vmYAMZVbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lNtDe0IGM8P5fyogJVNvyAE2W0Jpzxmakz/qxtRTj8IhTj96
	wnx+HjkD8C30PoOOM5lIIKg00/kD2XE89e6cm9fb8Wj3Y8CgBURIEhpz
X-Gm-Gg: AY/fxX5UdwG1zOXwjAnFZdsoL+slXW4d9l9BC4Omjsu5gb0Uxu3Jz0q7On0YJL0ThgM
	pRUXws0kDu5vRaTZYtZ3j9fDqia57O312/es9fywTmtAHAGHoX/VU7k0KtOYZTKMlNdgQgvuD1w
	v8/Pf7t47KyV12eF6H9OH9+qGEFFpW6a6FK3JZvhrMlHfiOJ78hmlyrnkQxLnIcdgqXj8bGRuI0
	gJZzqd84cGl3DPtyM8ye60kgZsXEPagLsnrx7lNYJduk1n68a3XKZJCgd0JjWK9Qw3Z/awgHwWA
	o/X0EJ+AQbknx0jA/s7Du7FdkYHrPTGzWXvNQOmu8Va9IkPOCGJ54G0ZK54OXd8yjv/cFJ1s57p
	tRKpxzC6QyfjJHJ+AMjQ8sbpkKISjZZ6SxrKib6ZWD+8sVhzobGzZiTSFXyMuYtICelck3RkQTd
	Mmcrpf3db3/KKQeKKpbJszuyjDjb4Er8JL80NkE4ExK1rAwxd2987OS2bUK7HCft1Q5EH+crw=
X-Received: by 2002:a05:620a:191e:b0:8b2:ec00:7840 with SMTP id af79cd13be357-8c6a6704482mr1057363685a.27.1768699109428;
        Sat, 17 Jan 2026 17:18:29 -0800 (PST)
Received: from pc.tail882856.ts.net ([2600:4041:4491:2000:8a64:ec6b:4:f1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72642fdsm512290285a.46.2026.01.17.17.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:18:28 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 v5 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Sat, 17 Jan 2026 20:18:15 -0500
Message-ID: <20260118011815.56516-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for comma-separated symbol lists, exclusion (!), and explicit
:entry/:exit suffixes. Verify that excluded symbols are not attached and
that enabled_functions shows the correct probes.

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

