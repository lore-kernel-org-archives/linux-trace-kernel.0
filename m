Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BE19D8A9;
	Thu,  6 Jun 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639876; cv=none; b=B6LvHnAyPZdm7HTvdTMv3ywXbDBWZjUXNpgNQ9d1GxpSWyROSb8hnJMiZZa4+Mvb5DfSJg6T7wD1+MzNs3LUPn5LocAedSx9Qfv8Bkjgzf+XI0sHTnwaLQrLx8LoMLMFeOITGA861MUr6lb2jbTnPRLqTA9C6ysIy5p32wMYbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639876; c=relaxed/simple;
	bh=SwDOWZjXkGasfrj5gOSvdtiuegyDLuPA+BB35Wt5NKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWV1tXaIAGGN7v5erFG+Mjz0XZdEcZGkQzrPCXj//BKd1B2s4HKCb99/EK2UF1w4AQf1LLQHtc/OGoQ+Js02pWdW6V/sWXLVSvImwipkCOYyGB9DCTd8gu9REV72iNgzxdGCGlj/kf4deIFQAqoSMGG/rKnTguJ/QmRJ5BcrThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wU+zKI4A; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wU+zKI4A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717639870; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J2HjalGyu16JiUmBtdpjzCgzLQfZA9s0Yu8WWDb1HCE=;
	b=wU+zKI4Ar13ms1Conm+ZBGjaOcu2njdSrgQCO+3gBJjirrWmPpTYsqvbg+wEYXkf4mhZo6vSHgpR2WnM3CL01zVCLP3eyXT/TjwMKoYKB6pBip2dG45M01ajC9LylLKeSS8PD6d5GcZ8p9JsZ4u5LOR7eZyrTLAZvyO+0PKDbV4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7wUGVG_1717639855;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W7wUGVG_1717639855)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 10:11:10 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] fgraph: Remove some unused functions
Date: Thu,  6 Jun 2024 10:10:53 +0800
Message-Id: <20240606021053.27783-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are defined in the fgraph.c file, but not
called elsewhere, so delete these unused functions.

kernel/trace/fgraph.c:273:1: warning: unused function 'set_bitmap_bits'.
kernel/trace/fgraph.c:259:19: warning: unused function 'get_fgraph_type'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9289
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/fgraph.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4bf91eebbb08..c00fbf1d0dd9 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -255,12 +255,6 @@ static inline int get_frame_offset(struct task_struct *t, int offset)
 	return __get_offset(t->ret_stack[offset]);
 }
 
-/* Get FGRAPH_TYPE from the word from the @offset at ret_stack */
-static inline int get_fgraph_type(struct task_struct *t, int offset)
-{
-	return __get_type(t->ret_stack[offset]);
-}
-
 /* For BITMAP type: get the bitmask from the @offset at ret_stack */
 static inline unsigned long
 get_bitmap_bits(struct task_struct *t, int offset)
@@ -268,13 +262,6 @@ get_bitmap_bits(struct task_struct *t, int offset)
 	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
 }
 
-/* For BITMAP type: set the bits in the bitmap bitmask at @offset on ret_stack */
-static inline void
-set_bitmap_bits(struct task_struct *t, int offset, unsigned long bitmap)
-{
-	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
-}
-
 /* Write the bitmap to the ret_stack at @offset (does index, offset and bitmask) */
 static inline void
 set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
-- 
2.20.1.7.g153144c

