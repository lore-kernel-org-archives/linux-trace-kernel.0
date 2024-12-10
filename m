Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829C1FCCE6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815207; cv=none; b=RaarAVs3Pzr2h8l0Y1KQBujLMJRp4yAIH9JlG9w+Q9wgFZKrfg083yNONZ0OCKyzXe/6zu5zjMiS6g0TwFpRkelKYYApe6qIs7uqY98YUcpRoMFoPmZLURlfbuif8gKSA65lD92wEco1Ac29WbBmJrMghJ79TP8agUfQybTJjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815207; c=relaxed/simple;
	bh=uwoTQGd50XKRwmHhcyRLGgeWF/OnpXo+mrRXAHkc1/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4czmi1pWK0Szq0cUhxo2NO3f2h+YAJ6V76oCtC8/V5KiQHJEXmHc0TM7qvcGdIAy7YhdZV6z1S1EaBiH0RVhoo4SLlX4Jfz5mbYXO19kvaCzaw9esehHSzwiuIGZkkWqW0M2f3mGZTnXj0UvVlZY5Y5kYA68rChM7ufzNJAWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VUjc3sa3; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VUjc3sa3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1733815197;
	bh=I6OUNlZ7q6hyKu9YRiOTtA/g+UIxdZdA2a3DziIzYZs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VUjc3sa3ejqES2iqegxHVJ0+P1KzWYW25IblXjY9rdAJfQ5g5QSem28gSRwD+KAuf
	 D/y1Wt/elMjfJIw7SyifxRVTjH9g8E9Kf0l782SvbRI5gDe1EEgm1Sp3lviygW/qtA
	 7qIFiyU/TEzgqoLAbXA9Si6TAkUaGK+8W05LDsSA=
X-QQ-mid: bizesmtpsz5t1733815191tzukagc
X-QQ-Originating-IP: BQZx3pqtbXIOlFbutyZ1NwLboTopXuCOx+OBMpN1wwM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Dec 2024 15:19:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8042686719195873629
From: Gou Hao <gouhao@uniontech.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	wenqing.lz@taobao.com,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gouhaojake@163.com,
	wangyuli@uniontech.com
Subject: [PATCH] ext4: make trace_ext4_ext_load_extent print-format correctly
Date: Tue, 10 Dec 2024 15:19:48 +0800
Message-Id: <20241210071948.12636-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MvUCj+jJbjsSHqGpu3lISJxqeONBvmgBohLacv7+gQ2TAvTSP3hhzZjs
	8sne/r4xRVGqL+mXEs6fm8MuG/AHMPHE4Epr4lJTG6YyYbnWk59ggLcgk35CLpMCmd1EiXd
	dlDz/22p9wJ4yI0s/Br2djCaCTYMXadfKU+vpdbdzPYJO5IfGilneY4lvsPHpMejpV1yaRS
	6nrrYBu2y4963gURYvFr6uJ+pLp3LLNCRLR9mgTyuxvHheG3xHurojaJ7RdCVQoHwKwJOIg
	cyc1Qw0AO4axHJYvoKSMqr4RBDl7rx2lZ6XHx+RxGsd2Yh8/goTf9u7oao5ud+xGHmXDtLq
	4zWX2Kg9oEaWfFFOTN3oZ7k1kfxZRS2emqEhQMDMEPR32chnwwPwXK/+EPOCdFVh0FU1oiH
	Qe0JPsZocUU6UAssr4dHTReQAqYJCVuWyw1DOIenpuyPNGcV6glkhtxm4DVQdaIyU/f6tXE
	s1sbuLt4f7OYLc9Z19XsImlH+LnIc8cRCMlw3dx7QF8qYbcBwfJUZxXWfnLkvWKd9jpucqT
	BCiu0vjPtZTA7MeKCA1v/z3LDJcsh3lJF+2dhH1U+cMwHncik58O48uUxXtARb6rX01PRPr
	NFFs4MK2pGVYfCLRGLVF6c2H37npjfOecdTpuTHh16whWe3deiKTW6MqzzEWlXz/enliozn
	pbNz5c7kStWQwl2xgJr1ZHEgnntE4WKnwfKUA1pNJf6ppWYfeWgc7iXZ3fPJ/9cF7XH4GoR
	xyLbKbs3/Dk9GdNApnCkQYfUYfnvjpfbbInd4V49dJ+xJItFnZNMdSIUTjrUPQQDTMXTiQX
	EmSJiCR8mEaKIGYNqX0+fXboRSJ28TnPDzFLp4ipO17QL5v/FkSHIODfQNax11vx5NYPvtW
	M1BG6Hq7k7L42PNqaT0RPvxZ5TJ/35mDuDjprSYaGDua/6ighMgdI3bMq8cqNM/H4EHtHfV
	rWFuCVOcxjYj66n21QZja0nkHc04/M/qZ6gF+NitC1eHgoFSpJ+vX1sSNjvKeG2MyhtiagP
	E7IJxLKMX0tNRm09PEfXhUfQoENc8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

In commit '7d7ea89e756e', pass the 3rd param of trace_ext4_ext_load_extent
to _RET_IP, without modifying the print-format of it.

before this:
147.827896: ext4_ext_load_extent: dev 8,35 ino 272218 lblk 1135807 pblk 18446744072651077338

after this:
35.118227: ext4_ext_load_extent: dev 8,35 ino 272218 pblk 1135807 caller ext4_find_extent+0x17a/0x320 [ext4]

Fixes: 7d7ea89e756e ("ext4: refactor code to read the extent tree block")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 include/trace/events/ext4.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641..55061c36a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1707,28 +1707,28 @@ DEFINE_EVENT(ext4__map_blocks_exit, ext4_ind_map_blocks_exit,
 );
 
 TRACE_EVENT(ext4_ext_load_extent,
-	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk),
+	TP_PROTO(struct inode *inode, ext4_fsblk_t pblk, unsigned long IP),
 
-	TP_ARGS(inode, lblk, pblk),
+	TP_ARGS(inode, pblk, IP),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
 		__field(	ext4_fsblk_t,	pblk		)
-		__field(	ext4_lblk_t,	lblk		)
+		__field(	unsigned long,	ip		)
 	),
 
 	TP_fast_assign(
 		__entry->dev    = inode->i_sb->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->pblk	= pblk;
-		__entry->lblk	= lblk;
+		__entry->ip	= IP;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u pblk %llu",
+	TP_printk("dev %d,%d ino %lu pblk %llu caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
-		  __entry->lblk, __entry->pblk)
+		  __entry->pblk, (void *)__entry->ip)
 );
 
 TRACE_EVENT(ext4_load_inode,
-- 
2.43.0

