Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96304332EBB;
	Fri, 25 Sep 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343369; cv=none; b=OstYSOC3rqb14zqYvqdGTcIwG8KYaUpeo3YYBMFgt1QqMaV3o3rmy58JMFdyPG01RCt6rBPn/94fHyTPm9X+/OnMhrbFQGO6Fd7/x0SWCrGoRSdBJ+NBZQ/IJJADftXX2s9Fao0a/ASsU/Md5T3gYGHipMEh3Ipy/liV+BEqlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343369; c=relaxed/simple;
	bh=/Buq5Yxd9oTyoi0yzaGhQAl28zMu9ChgTZ/Ifz/kZqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfOpxZikPC5/Eq2capz0FquuTEBL0uuwDmn+a3q3BMpatbApkwQYcABFOhfrdRDKkl6ea5nVibG+uXdvi/ZL5rez2jxmy73l3k4yBF9UDAX/AXmvTWSq8EgQzdD93q9Q3TeIsf7hd/6qbkqoDtufpcu+APqjWS+9hdM04ZsvoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=aALP+iof; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aALP+iof"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=NUZFZugQcaUOtbGUptFU8+qpfI74flmUKE/bgA+blDc=; b=aALP+iofqqFy
	/qvMa65VtnuZy31h7CcyVj3VnpgNKrG1aBbnAbpGFreE7cwClfokn3Oe86wxdtJEoMZ/9AOusxme2
	rt77bN036G+KINxUs6gE7eiEhwJH/XEWz4nTfQaNVy65q7gBKQRJrEVJfoKr9QRVj7nhF77jzHTVB
	mqbidsWf8n1iC26JUKQfK6qFu9FDyqH4eC7bim/sSz9uyZdYpThTd6S+PCboZQCOBAtZ6xe8zx3Um
	JcvqvVWw8BXFlihdJUm8qtT5syJaPVAl7H7qRT8HtWiQ73X2CDh4NqiynZcriXtfa20Ow4D5ZQA08
	mng77JIJgLyQItd4kmQu/g==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA62s-008UcG-0Z;
	Fri, 25 Sep 2026 15:35:58 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: skip gcov symbols when picking a function to probe
Date: Fri, 25 Sep 2026 16:35:41 +0300
Message-ID: <20260925133558.3636030-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe_eventname.tc takes the last kallsyms entry whose name ends in
vfs_read and puts a probe on it. On a kernel built with
CONFIG_GCOV_PROFILE_ALL=y the counter symbol gcc emits for the function
sorts after it:

  ffffffff819bd1e0 T vfs_read
  ffffffff845013e0 t __gcov_.vfs_read

so the test picks __gcov_.vfs_read, which is not a function entry, and
the write fails:

  kprobe_eventname.tc: line 10: echo: write error: Invalid argument

Leave those symbols out of the choice. The test then picks vfs_read and
passes; without a coverage build nothing changes, as no such symbol
exists there.

This is the same class of problem as commit 23a4b108accc
("tracing/selftests: Fix kprobe event name test for .isra. functions"),
where a compiler-generated symbol was picked instead of a real function.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index ba19b81cef39..0688a5c47d1e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -5,7 +5,7 @@
 
 :;: "Add an event on function without name" ;:
 
-FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
+FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | grep -v __gcov | tail -n 1 | cut -f 3 -d " "`
 [ "x" != "x$FUNC" ] || exit_unresolved
 echo "p $FUNC" > kprobe_events
 PROBE_NAME=`echo $FUNC | tr ".:" "_"`
-- 
2.55.0

