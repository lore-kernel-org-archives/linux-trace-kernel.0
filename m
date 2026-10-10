Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D685FDA7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791676018; cv=none; b=uz++GpOrX7vQJBRyeT9N5NihAUD8btn7zItO6bbW/aKDiXVyHpZK5HYAWxVTxAaMH9sYEJ30pkjuvaX6IW0MVLGK+E3xB0X+EKjRv8jfRCN0gZn2aOgbk2qB9RzkBxPaa6mETik6qN6BfA4grebKB05hlubmkU1foaiHQfUzAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791676018; c=relaxed/simple;
	bh=2hvFsAf8JAV1vNTH5rf2/2G92H15dI0BJwMTejjyruw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Upp7iPvl2/ZO4kJIBtNpwaztwb4Dy1OwGZGIXp5I6Xowl9aYjTNpB+Yla6zOMSTLAcnz2EqiDValS6W+kk764jdlqUc245qzb9sQWH94w/rSCAHGz11dYmPTEdD2yvkNn/p2vIZO0JORAtTj2PfXSQOqhx1N4bd6bxGo32SVuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=IzTA7/Vf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="IzTA7/Vf"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A85523F167
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 23:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791676007;
	bh=pQvssHYBZZeCPq+XUhxAF5bUl+NBotKc8Bo70aaWCyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=IzTA7/Vf1/0N+9t2h+6/OwgKSN2rskBtFqQQi2wZjjnLYH4nACZsOrNpP/4fNih2y
	 /fw26622i6x6z0rpUKCpYT4/gkE5bx4Jdei5vTBu76uMjZ/9gpEfYlY9LyVdCJGI0r
	 zhA89dC5riH8yHcij7hQwrqIVeqMyuOQNPvPGofrJd7mh8950/C2Nz/9t5r2xRX65J
	 E9pBszcyeSwLZDnSXQJsQfT6jz8HwNuCRFnzR+M2oGb41aSY9Fy5hiQ25kcWz2oHVK
	 JKLa7RhodFvFDPB74B93BnS0TIhsE/1kIfD0s1Vyd5b0Be8v68wgOzkU599/hxFbC/
	 j2dYbc66cMkcvUsBQ1KjIl2vjo+y5Xc/yqf73XzUjP0r0NitDau2+vj3HU8ZbeLTk1
	 CHOJDtoMATOiLlZR4hjFL73Nxb17JYypxVn9xebec0oKB3GSUEd0/Zq3Yduhzj49zZ
	 8bTux80FK44MJvhJDZX0Sx7Pbn2Rx3kIdQM91EcvNZExTqcyWPmxSizd21vQ+A4Oy7
	 kkujupwwzcA5lU/i89Lns+bNoviKQJTL2OE+IpD6qKrTeoSR+KfCAZdzqTQJU5My6Y
	 y1pAu0Hqrhw1Tgm6jpnNQUbTLMb0kUkCSxO+IFV9awYBKWzUu7W7cMhWzQmtKJhog7
	 Ff/XIWNfGMi6Dq6R+m7YX4Cw=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01b112fa2so12713485e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 16:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791676007; x=1792280807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQvssHYBZZeCPq+XUhxAF5bUl+NBotKc8Bo70aaWCyo=;
        b=F1Jvy/0fLxbi682nwmF9B4Q+gQf63UnU2/CnY6lXdOi8SvhzZyX/hD8AjXuog0HkOT
         6liNz3AggQfgtAP5b/364IT7VD3XYqeJZpix7cKu82N7ShePwu0HRojYKRTvHHfeWFLz
         W40QDchkL4WqHsMXLcQLnfvs9VugyKt+p8j4WMVJQFQ7xt0QrjznB0dEQe/jsCEC3EZA
         Ge+t+4mU72YawOi/CxH24OHQCpeTTaYFCNtk55xBK+TBoev9jR073RWCOMu7DV8sGDEy
         aEv9ifN3oSp0mmKKK7ezkXInnlmMQiRSe45WnOIVRStyhOmz6D2GSWcy4vERWD+v+zz2
         fb8A==
X-Forwarded-Encrypted: i=1; AKwUvBx7Ztvsu450DXqylCOMChD3eYkyHyumLviN1qW79X97d+aeyfVyLt7s6jEpZGKXVZ4T9J/wMlGIplkvhNruD9U4aeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKP7HiSthG27mDAToXScsDJoAL2CX9VAikvgkYghPBVEiEVz8Pz
	k6DxDly01Em+iQdKkz0+YsVh0vLT1rbv7NarEPCDeE3umButMC15bo3f4Mkp45Yo7UGeHx9cH1u
	5r1qO6HpGZBhL0TlG8ePP3hBhuIuxB63CQvianDBYGJ8C8WOLae7AWbiRND8e4PrYMHED/Ycspp
	8TRdQQ78hTO4utJw==
X-Gm-Gg: AYBFou3lCBKTlSPOpoAvG2bUUIfA+5tO+nl57HrKmMC2a3LOyyekp4JQUSAV77YE5U5
	lyfhm5CJTtYZ5IED/feaOI9/T+M3kEQ15vj8mUGn1Pr+qg3g3J99BJYRMvgvcaEV4MOae7Iz3/i
	t9MGWlbET0R2zn5nh+mfXoDsJCZpOvm5yrAsGaywxB6tlOAm6vwkao9CJ+4RwJjmlkmbRsVR8uS
	xGfF2FDw615mLJ22k5NPHkONsScq42Q/xiMnAvRgexPXEjo1X3ZU0hVDk9hbBKxPJvyLZMM1bgf
	sgb8ZPwAU1jDF5dhozdWxkYAFi6JPnDVFSRdBmEhbITRe9zaE76yu8SV4RMvNFZIixI7Ug==
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a18e49881amr99936325e9.8.1791676007287;
        Sat, 10 Oct 2026 16:46:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a18e49881amr99936095e9.8.1791676006955;
        Sat, 10 Oct 2026 16:46:46 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:cab2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm85743135e9.1.2026.10.10.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 16:46:46 -0700 (PDT)
From: Sarah Emery <sarah.emery@canonical.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Sarah Emery <sarah.emery@canonical.com>,
	Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2] selftests/ftrace: Account for 8-byte aligned trace_marker_raw events
Date: Sun, 11 Oct 2026 01:46:45 +0200
Message-ID: <20261010234645.173550-1-sarah.emery@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_marker_raw.tc expects the length of each raw event to be rounded
up to a multiple of 4 bytes. That is not the case when the ring buffer
forces 8-byte alignment of events (CONFIG_HAVE_64BIT_ALIGNED_ACCESS):
the id plus the data is rounded up to a multiple of 8 bytes instead, so
trace_pipe shows 8 * N + 4 items. This was seen on riscv64.

Make the test accept either rounding.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Reported-by: Hui Wang <hui.wang@canonical.com>
Closes: https://lore.kernel.org/all/20260607072431.125633-3-hui.wang@canonical.com/
Signed-off-by: Sarah Emery <sarah.emery@canonical.com>
---
Original v1 patch from Hui Wang was posted in June and only patch 1/2
was merged (commit c37e0a4b79a6).
This is a v2 for commit 2/2, addressing reviews.

Changes since v1:
 - Drop kconfig_enabled() and the CONFIG_HAVE_64BIT_ALIGNED_ACCESS
   lookup. The review of v1 objected that it depends on the kernel config
   being readable from the test environment. The test now accepts the
   4 and 8 byte roundings based on what trace_pipe prints.
 - The expected length for the 8 byte case is unchanged (8 * N + 4).
 - Rebase on 65f26d15f7db ("selftests/ftrace: Fix trace_marker_raw test
   on 64K page kernels"), which changed how the test writes its events.

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index f985ff391463..dd2b94be0947 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -67,7 +67,8 @@ test_multiple_writes() {
 	# add a little buffer
 	echo stop > trace_marker
 
-	# Check to make sure the number of entries is the id (rounded up by 4)
+	# Check to make sure the number of entries is the id (rounded up by 4,
+	# or by 8 on architectures forcing 8 byte alignment of ring buffer events)
 	awk '/.*: # [0-9a-f]* / {
 			print;
 			cnt = -1;
@@ -77,9 +78,12 @@ test_multiple_writes() {
 					i++;
 					cnt = strtonum("0x" $i);
 					num = NF - (i + 1);
-					# The number of items is always rounded up by 4
+					# The number of items is rounded up by 4
-					cnt2 = int((cnt + 3) / 4) * 4;
+					cnt4 = int((cnt + 3) / 4) * 4;
-					if (cnt2 != num) {
+					# With forced 8 byte alignment, the id (4 bytes) plus the data
+					# is rounded up to a multiple of 8, and the id is not counted
+					cnt8 = int((cnt + 3) / 8) * 8 + 4;
+					if (num != cnt4 && num != cnt8) {
 						exit 1;
 					}
 					break;
-- 
2.43.0

