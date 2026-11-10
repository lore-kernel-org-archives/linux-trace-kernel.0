Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286757;
	b=A6Fv7F+lIVspXLBBBJVTpPmIE5zxhQdIAk/casNslRq3BiksdGTFI1oHCxgqRHydQ9nT
	 /DcRD/ocrRjtdWO35kmTDFT7mfioLNmb39XJlaW+aXUqLdfUcC6EHoo6dx1WSLDlt9QDI
	 qhQZ76sFlgNdCWLBYbyGn8qrTf6J1gKoYXLR30EENjCVitxrLfiJDuSLbzjhbCpQINpYp
	 OlO3n16uTND6m8N/du49regSmjTgxHQe1+cz0HXAyiKVE8p4Bt5jIaUKMCWYMfaAcx1gU
	 rd/UxxJP1kj5SX6Na+KvCvT4fNklHz4RdNbTbfxFLAzE5pS6zCBCzp5gAEW74Aqb1dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qJbNoqsip7jFQTTyYO1PvCgo3Jpyt4cYcx4AXHsZFe0=;
	b=QvRGOQ1qrPDwcCivN1U9O/j71K7FPmzBohq4qwC74JGp2jnhQnx8yViSSfnraP8Itw71
	 Tg77veUTz0XCxPBXulprY54Tqnl0uFo6S9WfBqpTuidAY1FMqr3FsUbAOhUELnJ/Aofhc
	 Bv6XAsQ77IBwUPnZll6OPYLN0V9DOS1JyMccEQePq7S2wGdBQLb3PyIth1hK4gg727lVv
	 722GEk5GMhLnkFlxQElSsAxRQP/eZcV4wGabuXSvqEZC7VOiERRsCY/bv5nKszmgY/ntV
	 QSLGl3Q/5shPY2PLP0MprsZIi1ljpE3uidoiccKPhqymgKU7YiJjeGkvF09MBfpsqFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26C606A31C;
	Tue, 10 Nov 2026 04:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE26C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=qJbNoqsip7
	jFQTTyYO1PvCgo3Jpyt4cYcx4AXHsZFe0=; b=5UTbWVVSHAAVpN1cXNyCDsefAG
	MW3aU/vfRnlvwREBYzIo3mlihlg/m1Fn6xBszaIav+lTM16NF8WfclBDt4gpr7iI
	I0OIXLmTR4N0SP2srdD81pB1XOaNFbmaDxLgiy6DwZXQTXeUCqoLZIVyUIjT2nlV
	9SouzluSXSbowgev0=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [2408:8670:ae1:0:3c71:2a19:707f:720e])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmjQOMpPJqb59kAQ--.63138S2;
	Tue, 10 Nov 2026 12:58:53 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>,
	Jinning Zhang <25031212117@stu.xidian.edu.cn>,
	Bin Yu <byu@xidian.edu.cn>
Subject: [PATCH] tracing: ring_buffer: wait for writers before removing pages
Date: Tue, 10 Nov 2026 12:58:50 +0800
Message-Id: <20261110045850.2786-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkBmjQOMpPJqb59kAQ--.63138S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryUGF4xJF18ZF4rGF4Uurg_yoW5JF1fpF
	4rKFWYqayqvF42kw1DCrs3ury2ya1DWay2krW7Xw1xXwn8JF9YqryfXr17uFWYkFy7trZI
	vr45uryrCa15ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU-F4_UUUUU=
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAgUNEWrx5EWAbwAAsO

A writer can still be using the ring buffer page list when a concurrent
resize removes and frees pages. Disabling recording prevents new writers
from entering, but it does not wait for writers that are already in the
reserve/commit path. The reader lock protects reader-side page operations
and does not provide that writer-side synchronization.

Disable recording before waiting for a grace period, then wait for
pre-existing writers to finish before taking the reader lock and changing
the page list. Keep recording disabled until after the page list has been
updated and the reader lock has been released. The removed pages are
unlinked and subsequently freed.

This adds a grace-period wait to the resize path; it does not add
synchronization to the normal ring-buffer write path.

Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=37e1793bdb0061ea3a47
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
---
 kernel/trace/ring_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c..d92e001 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3078,8 +3078,11 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	head_bit = 0;
 
-	raw_spin_lock_irq(&cpu_buffer->reader_lock);
 	atomic_inc(&cpu_buffer->record_disabled);
+	/* Wait for in-flight writers to finish before unlinking pages. */
+	synchronize_rcu();
+
+	raw_spin_lock_irq(&cpu_buffer->reader_lock);
 	/*
 	 * We don't race with the readers since we have acquired the reader
 	 * lock. We also don't race with writers after disabling recording.
@@ -3132,8 +3135,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 						struct buffer_page, list);
 
 	/* pages are removed, resume tracing and then free the pages */
-	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
+	atomic_dec(&cpu_buffer->record_disabled);
 
 	RB_WARN_ON(cpu_buffer, list_empty(cpu_buffer->pages));
 

