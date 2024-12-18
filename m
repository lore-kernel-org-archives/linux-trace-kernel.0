Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2E19AD8B;
	Wed, 18 Dec 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522461; cv=none; b=obin1AkxZzhq21Q0rsvi7xbJOQAW5JWVfI2KsD0A5G+g86/gYGyuEcUI14qdqQ5IMfL9m2aHCB4YMucUK1dLwbsBKmhqubeJNmmjWexWZxgpX03m6mxGHuUY5EHk+U6cwTZ0YKygvr1U49MA3qNnKGodbqfJeRGAzZ6Jr7nQcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522461; c=relaxed/simple;
	bh=ml4YsiRZyI8UWK0zF2lB/N5rzrqalTGdTrv3mYwPaQo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nSWdJ6F6hX8kfgdjUB8ZG8+3mYk8Ks/d+d53/WM/+r+OjQAtzMaOlKn70G0uRg00rETtkJJmdcRWdqPr362JYZ8+e+g9PsOzlL2JT1OETxcBW1auLhzKDFAv/G182fuVAf4qSGVstu00Yu123LpdmW0g5QI77ppGe71Z+61VSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=m9ct/pdQ; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="m9ct/pdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734522145; bh=X++PoW5aIkpkyLF675jq0vxhfKMR8m+E1BYr0JeW1sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9ct/pdQZjBh0Xc7sPlRq99vUkfFs3BwXpQpv53hBnSmCxrznMK7pP9LYxlzDOj8Q
	 CmMmpDUvI8vzrPrOQu0Tgu5nN3iqaKfA3rZybtCgIEc7XpS/5o5vK/fWZnIndeWyU4
	 A56Ng484VCRF5NfLue/JjJPYoZ+RViwy7H4ebh90=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id A958CCE0; Wed, 18 Dec 2024 19:42:21 +0800
X-QQ-mid: xmsmtpt1734522141ti0yhq8rf
Message-ID: <tencent_11A0A5D80DEC925EDDA2DDB8990F4FC88D07@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69xn5s4ZjXyBME8PiJI4LcghTq2n4LYExr41o2kWAjjOkyl3q4z1
	 nFNHlIcvX2/g/Ma0haw430aJXS2Cx5bgcOxOjw60b+VHGEod5U94SXu3YLWDML9njp9B18ZL4DhR
	 K/A1OaqRUZTtTE94aMg/xLTfNll5y00HB6+CULiYD7Woay9Tk4dU7XkWTLkPfEU7crVaPI4xleMs
	 PdCOd6iJ4X6MhmNnkMIFCL4rIX0/M/An9Ivh3ByNF0vI6Ap2QNEc3tkzmLkWFGqYQ8WcYdfmxpF7
	 bm61r8DbwhbMza8aKcrGxbWd/hrz/7qDZTHPIuWaC5souzGe8JAw+yM9AG6FfztQoGiFQY1kxXwx
	 /fE3ZFOTjOf1vfQEQVCZKDQz4b24vSt72HddYISOt6PR6crVY9BNR5E4JORUrQkKJZS1hhkt5SQF
	 UmIlWf1duC82JUiCghmqDS2S5mxGsQs5BG0uU74kqfMOP54ZvH2mWdjmLxon75dwK3VRqUgj4oH8
	 4ZKOvpAKSOUv5oxzO/v/sPoX6HxCc7mIsBm69SSfGUVwUirW6Y9aYa8Cn6tB6mXoVh05eBlhBa+H
	 2A7RWHNUSY9mHLqVls3zpiXjHz88+20Ris04BvpobcYU98zwyfbrBm3+INQJ7AeVe+QekuUjnMD3
	 B2a7jn0TILHBOmRxq6KKufhA/AYm5XxRx3rPQNSVTPHi58Vu/9FoFz+xc69MAhj4IXW2hQyUO1Mi
	 aGDWMUR0r6z3vR+4l6zmgBGSulD16r+FtN5MqERqEjYnttp34dFRWvPALsImITgCBeFm+ov/Hj6g
	 S2fEz3QxZwLZpFaS6LC4UkLQNdUTtOQQqcXuegsRQdrh//02kLhrT7/O/bIpmnUb+WVbNAvSarbu
	 PwwrfkNRFX4x9L/oQ0faODQOrP4AHa7bvXA5aFB/Wxa40YC8XURnfspZuPMQWGqQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: vdonnefort@google.com
Cc: aha310510@gmail.com,
	david@redhat.com,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] ring-buffer: fix overflow in __rb_map_vma
Date: Wed, 18 Dec 2024 19:42:22 +0800
X-OQ-MSGID: <20241218114221.3899290-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Z2KSR5QrAWYDEBVh@google.com>
References: <Z2KSR5QrAWYDEBVh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a slab-out-of-bounds in __rb_map_vma. [1]

Overflow occurred when performing the following calculation:
nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;

Add a check before the calculation to avoid this problem.

[1]
BUG: KASAN: slab-out-of-bounds in __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
Read of size 8 at addr ffff8880767dd2b8 by task syz-executor187/5836

CPU: 0 UID: 0 PID: 5836 Comm: syz-executor187 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
 ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: updated according to Vincent Donnefort's suggestion, to avoid repeating the (nr_subbufs + 1) << subbuf_order

 kernel/trace/ring_buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..20f0e01b7a50 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7019,7 +7019,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
-	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
+	nr_pages = ((nr_subbufs + 1) << subbuf_order); /* + meta-page */
+	if (nr_pages < pgoff)
+		return -EINVAL;
+
+	nr_pages -= pgoff;
 
 	nr_vma_pages = vma_pages(vma);
 	if (!nr_vma_pages || nr_vma_pages > nr_pages)
-- 
2.47.0

