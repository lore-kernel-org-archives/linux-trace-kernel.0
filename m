Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0933C1AE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182499; cv=none; b=cOeUhQnFkJiANi8yv4mzLXeag1TTXv7JA83Uhg2bnHfkT0UtrXHoxUs6gGO9ooQfBW6ZyKfU+x8C9OATrUNCQH6K5bb6ZSL5KK2YZRdP7Cl0y8339XoD+36KDFWGbL/9gjLEy/0SrjeENl53ermNmM03KHNEAvwjGQyriAKgHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182499; c=relaxed/simple;
	bh=14sROXxsePSCyFjX+t2CW+D5fioa/3YjrCzjpOBgBnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX8KHC2z5rOKA3KtILAdmRKwwZKTRaL91wBwHj1+WJXMdhAXUxWtYjEJ9U6NbkojhuS2Vw8tVtVYBrrT9pvdwH2RAbG65rHqugwSm80mmFxsMQv0q+FQUNgMhTW1xmWsW3AoltitgDR4E9ywP5WIzMfjbCZcJKQo4CT6WE5i6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZXk5HKy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZXk5HKy"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88054872394so663936d6.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182496; x=1764787296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah32JKLj65Tb10mc2SlvS0l93Wr7sJeVTGZD/RA6bqM=;
        b=OZXk5HKyKgHowc4hetOJTA5sM5PSZmoRdnTdv16sXymvQDPG5orRvvAOgGLkEReDp0
         FL2fGiqSCMM8WYVrwSdIVlVCK+Ala2vYIIpOMHdNdRZycOVmFVp2YFjO+i6LBMdFx0W8
         DrzGiZHhCCCMD3OnKGJHW+mupc4YmrzkSanivcXFJEnR728j7sJfe9ohAmwSS/m1ejcZ
         McUMKlGNij3iOlYRLIkErn2vn/0/msiO3h98C/LTxxbC1bdix2O9v+8tSpyYgZnWBHUH
         4/wbLhYIWtjEOG8jlYWWqTuDssCyx1LUQyiE7MjvvRyW9sZbgKefQH+18uTy3viweVN3
         uRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182496; x=1764787296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah32JKLj65Tb10mc2SlvS0l93Wr7sJeVTGZD/RA6bqM=;
        b=swNEDs5lsSZHOrfrzhL00wNHZG/T43aI62v6ayV0H5Pd3BxmMfdV+/DwrKkqH6TDt3
         nXlRld4Jvz9IIopn/zckNdyxZU+Nq48xwI/oWgWYYWH4jzD/r+vnMuNCy5ZX9N/2kHhS
         UEH1nhgdg4Bjftx15NjujGN3QQPqsmlhWudlbNn3FGsUlRKtYxhqqY+cnocy3ItQEJ53
         u8ArW8PngbkRDSzRHim/Yy8qQS93SIEM18FAYFbQX/K6WXYzdGElhq4Oe5nzZ7xUJ32m
         ByhfTYLwCbd8ThyiHJe6ATd8FHLzpkPiNVLwzAw/dd3t6p2nDfS7vmaj67gxhoKt59ov
         wI9g==
X-Forwarded-Encrypted: i=1; AJvYcCUr2dUmi3ZspMfo/8R/aotsO4+B+M0l5Dth8/KWj2ZJ+pd78orPzD5/73QvCJVhWsG0FgbGlaaBUScEn7zQyGFPc4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeeyZVNAm5V99WdsBkJZiy87R8HLQhKUIbCuZ8iatzCEE2gzR5
	RdIF48YDfR3xXjvzoBSWr1tEgKgtBFfOjFxxBRX27cGaW34FFnJZYPAI
X-Gm-Gg: ASbGncuJgiEijHzcu9eXFe5ryMzFMCU55cQU08D+03/mNpmS4fiveDFY9fbRRktTdw1
	oyMTXllbixR84hLBWPhmelHA7e65gvM0b0zHqpaM2VI3+5yDSb6c5AyXEyhAZk09os3L/R+IPmK
	5U1xQMBD/4S8UpcvC1qs7BTbRsDKNXkIC6C9jASOLqZ71bFuQfja6wHftg/u26PiDJuCItLKQOt
	Kct9xbPwHWzAM6tUm+tFLs2Cv0bhb5uc5yKM8FxWGk1GKzBUNujKX1R2JQl/RhJBwaic/lyJWrl
	z3U5KRqTSmpj4jTzQIH6utt7sTf4/RS3gKkMwjisX3KTiwya+D/uQysOiUpXyscMTCFp1EkCWF6
	SKZjFp5K68Tbvn+TVp0AVMQ9geyx8zuiIQQ2qkDMUiTz+MiZ3s1jihULEQVYY2DMlTfoGkoRQe7
	yC7G8/U1mcJ0QpCkbnU+34f9cEhwLmrOu4r53C6cvZyTBTTLJvDUbmSza8jQwf1vcnSIVTM8OU
X-Google-Smtp-Source: AGHT+IFEsCg1mSN32D+C3r/VHUzlAz2wwpRVuDST+GsfS6aHpdaamrLaRE/OphYPfzmTkQtgG/qgSQ==
X-Received: by 2002:a05:6214:3d05:b0:880:5bff:74d6 with SMTP id 6a1803df08f44-8847c536166mr305963936d6.51.1764182495821;
        Wed, 26 Nov 2025 10:41:35 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:9820:e89a:8e2a:90ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e445b1csm149919506d6.9.2025.11.26.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:41:35 -0800 (PST)
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
Subject: [PATCH v4 3/3] selftests/ftrace: Add accept cases for fprobe list syntax
Date: Wed, 26 Nov 2025 13:41:10 -0500
Message-ID: <20251126184110.72241-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

