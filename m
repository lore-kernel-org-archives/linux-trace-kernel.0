Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6E33F36B;
	Wed,  8 Apr 2026 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622370; cv=none; b=MeYooO+vkjlJGjYfljLYvfAtSXJgHrYz1BdSePw2pawf9P90ejdeV9zjIcYCECpa4UtZ0xJwbl1XAAtuCOziTf+YjdbUYJreSU1Ra023wzaVXIuA6zdZJTpJXNESwv1qfowlvw5rF6+uk6lJigwCWKitSgfh60xMPNOz2njBouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622370; c=relaxed/simple;
	bh=l4r64N5D+I1XHeVrOoaYWl25atsmHBXYJXxj2m+gyXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oe8NODz+yZ5uYOMwx4V72Sk5OHn3l0UVJLSRHIu1Tb2EkkaxGKsgr/psm0Me1mLt5NeZjokg1GSIDUoJvKwTDavCWfMzzcC7tw3dToRR6z5S8+M/ntTp9NBlwuzcUMkCNTRQ2eRDp8QLHy7rhLRuZX3tx7coQ74l86yq4m45abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HW6eqgww; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HW6eqgww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SE
	AFFlxTxORcT/Rrq6uKhFb/2kqO8DF1rSnsERgmDXw=; b=HW6eqgwwBgeU0Jl1ej
	5FG7Hclzn4e29DTfa4ey1EBeG2RV2Ed4abGMAMX/2kHBKgbr7QpNFuREQQbxmZOt
	kBsta/RvcgVA3XhEKXA+AMWU0EtDd+z+aKifTILYPzJJoH0m9rUqfpJ6sXRE7ro2
	MTtkqIqo4hkicpz8Vvodv7z1Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAHbg7B2NVpAwvfDw--.4309S2;
	Wed, 08 Apr 2026 12:25:39 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: Account for fprobe attachment before enable
Date: Wed,  8 Apr 2026 12:25:32 +0800
Message-Id: <20260408042532.6741-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260407115751.96184-1-create0818@163.com>
References: <20260407115751.96184-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHbg7B2NVpAwvfDw--.4309S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxZr43Kr47tF47WF13XFb_yoW8tF1Dp3
	97G3Z0kr1kGayI9343Jr4rtr1xKFW8Jrs8JrnrJ343Zw4UZFn2qFZ7KFWY9F13GrZ5tr1f
	Z3WIqF13XFyUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrdb8UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AQ3cGnV2MS5wQAA3z

add_remove_fprobe.tc assumes that enabling an fprobe event is what
adds its target function to enabled_functions.

After resetting tracing state with initialize_system(), the current
kernel still attaches the target functions as soon as the probe events
are created. Enabling the three events does not increase the
enabled_functions count further, and the original testcase fails on the
check after enabling myevent3.

Record the baseline after creating the fprobe events and verify that
subsequent enables keep that attachment set unchanged.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
v2:
- rerun in a reset tracing environment after initialize_system()
- keep the fix focused on the failing myevent3 assumption and drop the
  unnecessary myevent4 changes

 .../ftrace/test.d/dynevent/add_remove_fprobe.tc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 47067a5e3..a55179f5d 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -27,22 +27,29 @@ grep -q myevent3 dynamic_events
 test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
 
-echo 1 > events/fprobes/myevent1/enable
-# Make sure the event is attached.
 grep -q $PLACE enabled_functions
+grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -eq $ocnt ]; then
+if [ $cnt -le $ocnt ]; then
+	exit_fail
+fi
+
+echo 1 > events/fprobes/myevent1/enable
+cnt1=`cat enabled_functions | wc -l`
+if [ $cnt1 -ne $cnt ]; then
 	exit_fail
 fi
 
 echo 1 > events/fprobes/myevent2/enable
 cnt2=`cat enabled_functions | wc -l`
+if [ $cnt2 -ne $cnt1 ]; then
+	exit_fail
+fi
 
 echo 1 > events/fprobes/myevent3/enable
-# If the function is different, the attached function should be increased
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -eq $cnt2 ]; then
+if [ $cnt -ne $cnt2 ]; then
 	exit_fail
 fi
 
-- 
2.39.5 (Apple Git-154)

