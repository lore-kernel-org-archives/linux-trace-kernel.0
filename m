Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AD39B96B;
	Tue,  7 Apr 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557609; cv=none; b=qXsCXnvZpMxUSXn+htu+e7M2Q2CYseuCRC1ItMMOuDzIAObBgydIgMCdiZjJW3s7E9/jEkdzPjyJelixKqjEgH0nzJNCFO1QMd1pgZLop5j/yubAXFLj5UQo1sqiEvI1/cYDHdGb0s9PbAakuBmRGMMPFZL+0ND92o4PYRBQSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557609; c=relaxed/simple;
	bh=2VNvHQofugBeoQyiskx2TBSIlOdPqBZ47PjntJ/BBKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=et7suLPe5sFQ687QKi2+KHS5LTB8z2pY8+1DoBBHNWhU7BkHz9lQasRVpAZLuQSmw3b3Ptt35STCjKq0/uHpV6I65MBaS2lFR3OJHRyhRF2lTMkP2GHWAXod6yudl1jvq6HxC282Z2Vdi59vY7izTRBpQPfiQqLO4jLevSIAqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z/iUsTwZ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z/iUsTwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wA
	WQo03VZE8l3LEexf6LRLV+dPfenD8rqR2dXkKrOm0=; b=Z/iUsTwZtnH6pkicO4
	w1KMrPn+V4/8vgo57qAgo2ZnLKe2XJ7kRazurIcbaDZqWCq+GQMTRxsmBwKl5juh
	Os3F0atxkVgHHoFjnbOE6FjplGVH04AmAUTEqocwi5anVe4HX1Wd5zPGm32waC6H
	qduMzu3SSq5xqzMhMpTRSwYnc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3pfXL29RpAgQOUQ--.2576S2;
	Tue, 07 Apr 2026 18:26:21 +0800 (CST)
From: CaoRuichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Cao Ruichuang <create0818@163.com>
Subject: [PATCH] selftests/ftrace: Drop invalid top-level local in test_ownership
Date: Tue,  7 Apr 2026 18:26:13 +0800
Message-Id: <20260407102613.81419-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3pfXL29RpAgQOUQ--.2576S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruFy7Kw1xKr4UuF4rZr4UXFb_yoW8JryDpa
	4xu3WYkay8tF17Ka18C3WrtF4SkwnruayUGF18X3y3Xr4DJrn2q39rKF1DKrs2vrWrX393
	u348tFnxXF1DtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piUGYPUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5w658mnU285LGAAA3Z

From: Cao Ruichuang <create0818@163.com>

test_ownership.tc is sourced by ftracetest under /bin/sh.

The script currently declares mount_point with local at file scope,
which makes /bin/sh abort with "local: not in a function" before the
test can reach the eventfs ownership checks.

Replace the top-level local declaration with a normal shell variable so
kernels that support the gid= tracefs mount option can run the test at
all.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index e71cc3ad0..6d00d3c0f 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -6,7 +6,7 @@
 original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
 
-local mount_point=$(get_mount_point)
+mount_point=$(get_mount_point)
 
 mount_options=$(get_mnt_options "$mount_point")
 
-- 
2.39.5 (Apple Git-154)

