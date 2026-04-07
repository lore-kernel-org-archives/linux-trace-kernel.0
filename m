Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683239EF36;
	Tue,  7 Apr 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563117; cv=none; b=Y6A+0M+F4R/QwxlOMfhIf0zxxtipKzpfFe2JCbFpLa4/V6HivrMMi3ulJESszBCNDXNjZyDYhlSevXHGXYfX6J90g8+ouj0b6efELVediVTSbFn/PoG3fFStEEQwaY5+EiHZj6+TOx/yPN4Wyp0TT9JCjAF43eHwhEHIKRrykSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563117; c=relaxed/simple;
	bh=q567h0t+c2v96BNi3vyUuDldPj+NrQlAz1YEBRCyuSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bpYNyT5IMNxFvMGiA+OYRMreaPzefRqA3I+0OmDbP0eLG371HcjfSvdXsA6xxh3iMGVf8cCGi2rCn+MjYVPL/6aJBG3HpyqKLuM+M7xD6o3DhbEkgjssczW+hL0pnHkhFORX/rOiQxjr5T/IuPwE4Mxzt6J4VnojY/AXHmUM5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d21jWW68; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d21jWW68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=de
	kqFWh3YIyGSGRRz7hWfx59qGviJN2riXCLUpqKCP0=; b=d21jWW68UFMRQtNZU5
	carUVKuKkd6fweRkB/6mwUToCNubJ96RJmDaP84QZ0TwOLr29618u4wnFn/Gzff7
	fl49wzb9X3vQ/NKjOfkgcy1JkfTkAHK7IeVUq5XG5MovLSEI+kxrPNJJMbfVjTYr
	D5j4Zg/iaIeC1dM3Gc2V2YX9c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBX4WhF8dRp3yePDg--.29110S2;
	Tue, 07 Apr 2026 19:57:59 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Account for fprobe attachment at creation
Date: Tue,  7 Apr 2026 19:57:51 +0800
Message-Id: <20260407115751.96184-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX4WhF8dRp3yePDg--.29110S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur15uFyUurykAr4kKrW7urg_yoW5GrW5p3
	srW3ZYkr1kGayI93sxJrWrtw1IkFWxJrs8XF9rJ3y3Zw4UZrn7XFZ7tF4YgF15GFZYqr48
	Z3W0qF1aqFyUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jooGQUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5wgeV2nU8UiyggAA3S

add_remove_fprobe.tc assumes that enabling an fprobe event is what adds
its target function to enabled_functions.

On the current kernel, the fprobe target already appears in
enabled_functions as soon as the event is created, and enabling the
event does not change that count again. That makes the test fail even
though the event lifecycle itself works.

Record the attachment baseline after creating the probe events and only
check that enabling them keeps the expected functions attached. The
cleanup checks still verify that removing the events returns
enabled_functions to its original state.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 .../test.d/dynevent/add_remove_fprobe.tc      | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 47067a5e3..ff08bd1ac 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -26,23 +26,29 @@ grep -q myevent2 dynamic_events
 grep -q myevent3 dynamic_events
 test -d events/fprobes/myevent1
 test -d events/fprobes/myevent2
-
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
 
@@ -62,11 +68,15 @@ if [ $cnt -ne $ocnt ]; then
 fi
 
 echo "f:myevent4 $PLACE" >> dynamic_events
+grep -q $PLACE enabled_functions
+cnt=`cat enabled_functions | wc -l`
+if [ $cnt -le $ocnt ]; then
+	exit_fail
+fi
 
 echo 1 > events/fprobes/myevent4/enable
-# Should only have one enabled
-cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne $((ocnt + 1)) ]; then
+cnt2=`cat enabled_functions | wc -l`
+if [ $cnt2 -ne $cnt ]; then
 	exit_fail
 fi
 
-- 
2.39.5 (Apple Git-154)

