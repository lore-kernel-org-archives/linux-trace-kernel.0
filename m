Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541000;
	b=cyaH+4vZs0+jAbvsDI5+ALux25H6CM5nEQN7AzgVBeZbMVtKjuwKvIql4KL5inqVXQVe
	 ZtStmXGhRwLlGr3j8GhyTFNPTNF97+9T8MipFEltk+Tv3xBUJgakv4gZcyzTBeUEztRgp
	 fIpRfumF4WWuueR1pmwzP4S2WdYiW1g3AqKixWI8Zy5I1JxVnKYnNoI024fwPbkp5B3o6
	 M7/MbupMLdP65rGuxNgnj1DI/iIsQEfF4S1b5JDIg9/T9+bBi2LI/oh59LAobPljeaMDL
	 HDz1jELAJ5BB7uMiFlA92ZoGKq03E72u4ZvvrJSFZ2ja/iLifFQnLQkxUsii1JCM0nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541000;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=M6MPRBaMl6qsLHsFVJwyZRZbKlf0xi2IF1F8WK4FWo8=;
	b=X0mCOVbPQEfO+KiVSjmhSNXP+r9olJT+iv2tFI7sxnxJBXo2Q+BmuJ4kT8alNdAXcMnN
	 b2PJ7MQldCXTMqAXRAV0327RWJPy1o4KVAkv2qMo4PpbQMqis2k0rvAIRCartTJzKpgBq
	 Mel+jdfh4yr/rhOVibzTGwbilGnOb5v/UtT1hVAehAvRlyuA5m0OKE0oISl0aZfa0vq7h
	 +x1NqE31E/P5vvJk/NERSX2e4MfE8eXA/eeKOhCdPFUDsAK72Z3nCD37qTO3vPIhJVOeF
	 MAvUSGN0tEQ0MKKPYzsdSlUACtUT6JshQQ9iTHNUVE+P5+UVlaS16K7FZuPHtnT9ZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8E606A330;
	Fri, 13 Nov 2026 03:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD8E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=M6MPRBaMl6
	qsLHsFVJwyZRZbKlf0xi2IF1F8WK4FWo8=; b=0Ym5ltMXYVjiufTAji0Zf+dDtn
	h9gC1v0Cf6ClgeTN0hTRKB4Fq8v6yJ2+2CHIfKV4aoBZK8l4KCnNUwKncHZ9QH30
	PuP3AicnQeO3Ss0yTTrsVUgVCcjtr3uaymu/M59mHWMNcu0h317BjSv2TJ2nlbD2
	uzkk2wyNlydwiL2G4=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [2408:8670:ae1:0:f9cb:8590:3db:f71a])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBWnQKxhfZqDhKMAQ--.41291S2;
	Fri, 13 Nov 2026 11:36:18 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH v4] tracing: ring-buffer: fix stale reader-page link
Date: Fri, 13 Nov 2026 11:36:12 +0800
Message-Id: <20261113033612.1349-1-26031212468@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBWnQKxhfZqDhKMAQ--.41291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw13uF18Gr4xXrW8CF47CFg_yoW8urWxpF
	4rKrZ0gFWDtrsFkw48CrsxW3WjyF97Xay7Ca9Fgw1rZFn8AFW29rySqF1Uuay5Cry2vFWU
	tr4DZryrGF4UZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUQEWr11lZwGQAAsz

Hi Steve,

Thanks for reviewing v3. I apologize for adding unnecessary NMI reader
coordination and skip handling. You noted the report is unrelated to NMI
reads. The lockless NMI path is only a best-effort crash-dump path.
I have removed that complexity and dropped the Fixes tag.

The report shows rb_is_reader_page() dereferencing a freed page through
page->list.prev->next. During shrink, reader_page is detached from the
ring list and can retain a previous link to a page being removed. Redirect
that link to the surviving tail page while identifying pages to remove,
before any removed page is freed.

This change does not add work to the normal writer fast path or alter NMI
reader behavior.

Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=37e1793bdb0061ea3a47
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
 v4:
 - Drop NMI reader coordination and skip handling.

 kernel/trace/ring_buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3106,6 +3106,16 @@
 	for (nr_removed = 0; nr_removed < nr_pages; nr_removed++) {
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
+
+		/*
+		 * The reader page is detached from the ring buffer list, so its
+		 * previous pointer can still refer to a page being removed.
+		 * rb_is_reader_page() follows this pointer, so redirect it to the
+		 * surviving tail page before the removed page is freed.
+		 */
+		if (rb_list_head(cpu_buffer->reader_page->list.prev) ==
+		    rb_list_head(to_remove))
+			cpu_buffer->reader_page->list.prev = tail_page;
 	}
 	/* Read iterators need to reset themselves when some pages removed */
 	cpu_buffer->pages_removed += nr_removed;
-- 

