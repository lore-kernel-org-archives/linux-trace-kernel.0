Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D78158853;
	Wed, 18 Dec 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529721; cv=none; b=R3kSGgeU41ICxmcJuWweBeSnaXfKTT7wcBfmCmGDUYKbg97m3zjPkr6eOSmdKPK8gOV0wNcAe1P4F2aLXWl5POyt98pvyQyD6gy9EReLb52U9ZC+JoCkJaXjFdf+sM57vrMiCgwHU7lkvgn8pRseiFsHv7xWdszngh3pr2ISbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529721; c=relaxed/simple;
	bh=lZsa+9GNVO3XNV47LxcjF4WFZ6CE9M58qYSZZ5MI8CQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=N0tEL+Y/rKtzBrl2ernl5uNeGRIF9qTOeGpEBVnRR8Qk76eJew7bvghZjukhOEGkpx5XNX+QNUItT6CjvCxsp3cAQ3j7RTRvxi4MzTDDU2gr+1MjS08DlaULNXwplZvZfS4EeI+ytsV19gGXAOQtxmBM3WEdXVPesfBfMnL3nVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LZpCTfpH; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LZpCTfpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734529404; bh=HqhRBQLkd4Zst9F6bxsYyOJApsFfBzpwqkAN/8E069Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZpCTfpHFsHpZJ7T08px3KaJfmzhDdmhVhL12sgRZfpzyGzEx/0pF4wE8yND70Cm8
	 uj2vT+LZjaWbinyKAh1W+5+Y0wYEMcOnFuKF/vqwxUvCuP74FjVFSxYne7phAgn5Fu
	 ouBFn7cnb2bXPe1t77Z/3fWW/+sX/FNMfibPJ+wA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 936A9433; Wed, 18 Dec 2024 21:36:54 +0800
X-QQ-mid: xmsmtpt1734529014t71c8hezj
Message-ID: <tencent_06924B6674ED771167C23CC336C097223609@qq.com>
X-QQ-XMAILINFO: OB07sFyS3L6pDfQi6qXZC0lcJcyQErbm9KXI/+T2whMv7sxCrZ738ot5FettPy
	 wEQiwF9xEjAT9/e0/rSxYh/xuM3UDcqHSq8wXpF33ti5y/q2prTgyS94wUwqYR9oldsPUiHjMaj+
	 I5Nrk6bZIoYUckQOLZcR9HmzQtrDWPRBhobgx9SSFF8MkCbwpx/1RlFwVbMacWAL8rluDYtt98qL
	 DzWics5xqJsy8Z9/2ZU8fMXnNS34o8jATk3BVV+2GJh1ufxjRVk6q0vuC6LtX5R3dIal92ujeUGc
	 JK2iKuFSjhdidUfi++oR/DOoMD/K0P8KhRc/Jd8RQmyX+Qu1o4cARXeidiJ9QR2OKZFNlj52r/vc
	 KXxYsu9QjbIfuMqD5woAF4ukzKhuBwcqMnst6mFqoteIT8GqeK8xqsXkFsK8PqtzXqF+Q9Pb7JKW
	 g1IlMk749aZZVRQk7Zoe2Z1WvtfjI4OCezykAsRmHyBpfrFrPsM7+Xo6D28P8mLkhlUT/1llhem/
	 Nf/l4G04tvpRRu8I4eQK//71pLUdPuoWZBs+6+lLraxUZLaQZSRPyhcX1CE5Jjw1VLf5ihIpgPri
	 jABNJyzn8nGnNcdWBf1AgL5VLi1stjREwGDYpKII+8+YJVVoER9EopWjWerfo+AhAXttKXvkSz+n
	 f/3Z7CDpeoElkA1WzTx9DkQrH64gUgBLC9qd1yUqFT/811g6S7/1y2gQb58yXu8SqCqF5UoCP4gx
	 vzUsrTL/0LcDT5mSZcPOdmhSgriO0BlzACap5J82x/Db1f17/uNJcgUtQ0JtqlAdk3VYKpuqRiRZ
	 t2UkEODfiRx9cUddNvhqLVdyDRhd8qp3pVFXi+epnGALudgLCLJZvCrzxu8U9P4uzcThTenw1c6v
	 PArxwRtCRWDPZnow47SPqSmVJ21H8izGxGzvv1WVWXMGXxwXFBcQqaFyJJt7mGpA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: rostedt@goodmis.org
Cc: aha310510@gmail.com,
	david@redhat.com,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vdonnefort@google.com
Subject: [PATCH V3] ring-buffer: fix overflow in __rb_map_vma
Date: Wed, 18 Dec 2024 21:36:55 +0800
X-OQ-MSGID: <20241218133654.4010342-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241218081800.05d81fe4@gandalf.local.home>
References: <20241218081800.05d81fe4@gandalf.local.home>
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
V2 -> V3: Add equal condition judgment

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
+	if (nr_pages <= pgoff)
+		return -EINVAL;
+
+	nr_pages -= pgoff;
 
 	nr_vma_pages = vma_pages(vma);
 	if (!nr_vma_pages || nr_vma_pages > nr_pages)
-- 
2.47.0

