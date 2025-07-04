Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F841DE2DE;
	Fri,  4 Jul 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611148; cv=none; b=qGU4QfMua38blhqPclDE26PjyYksylNn3Bhj3oIb9KNn1hFDurxptljAW9ck80+JquJM6NR2aTuYAZxEkw523DISoUUR0spN8sxiDqhQJYAePDuHdnxcWeQ/x8vnYZzej2cUvUxj9C4FIRkCCeHbMH2uO4VfGJLKOYGqIrUs+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611148; c=relaxed/simple;
	bh=TLSjzGu3DCxjZDJsTUzJXCYMsVs9Umof+YA6uSnbqtA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=sS26tz1f4ws/HKmxdy0T253oxu5eLVYghWR3q4HRLe8hRRRkZN9OqRK7A+NpN3Bv5E1itaU7IbSv0zWSdBf7q2AbqcaMrzm0zm9J7ilNk+Pp65iQxA6k0c4shlJJPgVn/M5PFsTTjk3MYi/qfjoiH23Z33h+GMDeIBFUPfCcgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bYP9R3zlJz51Srp;
	Fri,  4 Jul 2025 14:38:51 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5646cF7g020695;
	Fri, 4 Jul 2025 14:38:15 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 4 Jul 2025 14:38:17 +0800 (CST)
Date: Fri, 4 Jul 2025 14:38:17 +0800 (CST)
X-Zmail-TransId: 2afa686776d9fffffffff2b-e685a
X-Mailer: Zmail v1.0
Message-ID: <20250704143817707TOCcfTRWsO5OAbQ2eYoU9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <naveen@kernel.org>
Cc: <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBrcHJvYmVzOiBBZGQgbWlzc2luZyBrZXJuZWxkb2MgZm9yIF9fZ2V0X2luc25fc2xvdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5646cF7g020695
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686776FB.002/4bYP9R3zlJz51Srp

From: Peng Jiang <jiang.peng9@zte.com.cn>

Add kerneldoc for '__get_insn_slot' function to fix W=1 warnings:

  kernel/kprobes.c:141 function parameter 'c' not described in '__get_insn_slot'

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
---
 kernel/kprobes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ffe0c3d52306..ab8f9fc1f0d1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -135,8 +135,12 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 static int collect_garbage_slots(struct kprobe_insn_cache *c);

 /**
- * __get_insn_slot() - Find a slot on an executable page for an instruction.
- * We allocate an executable page if there's no room on existing ones.
+ * __get_insn_slot - Find a slot on an executable page for an instruction.
+ * @c: Pointer to kprobe instruction cache
+ *
+ * Description: Locates available slot on existing executable pages,
+ *              allocates an executable page if there's no room on existing ones.
+ * Return: Pointer to instruction slot on success, NULL on failure.
  */
 kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 {
-- 
2.25.1
