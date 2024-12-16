Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C9205E3B;
	Mon, 16 Dec 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358453; cv=none; b=PyCL1Hht5JXIBx6Ea3SK589/+K+uuyaqP4KDwkSmJnUiFGWBAIWUVYun2xFm7DU8XC7trVq11mlMi7ud51FlLEdAHehofyO9A6yx5rRR0L+3r0iOSkvXQDSSA4kGH60NnZ67veT/kY1tJ0B5poEY8XE6tkJHqli+dU6JYszkr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358453; c=relaxed/simple;
	bh=Lab8uBkoiiDISVjxkdymFR9/9sEdfGxnbo81pkp2ecA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qqBl86OizOL7OUqkvbqTUjqL+XxpucqJxGgvmAVmTAObKAALMd2e8/B9+XqVSdKtqwywDCb2PceVqFWNxH28HDFDPJChXHGigF1JrvXySIKjvLMlnBFi+rh7Q7fazgA/PuxHsEpyvfWo4ext1hHs9S5IJj/ENXb8jdAXPSWQhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dFywmTWX; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dFywmTWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734358447; bh=IORjVDWw9PVe8SQPp6GdmklSQwTD9Lex2dxUowqavTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFywmTWXuxBhOKyAEmLFTZus9m4bfrsWlh3bV5SAGEoZrDIOxum0ISqozZLSYuqqb
	 Yn4SLcinuioRIKEP74ofQBRIli/9MPKfEBDTa96Ve4ghRKqBDyDE/mqHxfqF1hHqwo
	 tvcdwzaEEeFflmW9rT4ONDsIkx45YpUr0rFmgPJk=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 1F82E847; Mon, 16 Dec 2024 22:07:56 +0800
X-QQ-mid: xmsmtpt1734358076t4cw6z6sy
Message-ID: <tencent_E036A29600368E4A2075A7774D67023CFD09@qq.com>
X-QQ-XMAILINFO: Mw5V7KuSxHjfshEbLKBaYpHNs9f8PO4duBsWltGCidOguOVaYfh6cm6CMRRR0Q
	 XHC8WXjVLgmWKoWRcNm3xli7h0s0tPapEIYCRH7eWgV1tkkGubkVywRj4bmrP06gk3YY3HtipO4r
	 FWLnUbHSujKBlhB9Nf2OYoC9kOcAUC/CDZpYjg8iRguWuZPSZ5sJBJKXKRFzdduZzGzpw8YRtDe3
	 fd63UoFfbhW3tajNxr/QrAzlPc1KH7tXywfJZXeSNor8k9n1rklMd07VtKQdmwunM9G+j5eDSy4t
	 0+kPJ7tQIEZYbwSj5cYpe5fT3X/Be1Aob4CZC7eYJVAMLhQyaeo+Rk8L5R53ViEpCjavyneFatNg
	 aakW8G/bt1oMSOmeZJ4iL6Flp9vttWMQsC9xTQUC3hf1zm/O4NE9Qg8HnTBhjiPuPUDtNSAda8m3
	 jyI1WP0sRGYPmJJq5muHZnPg0GwGEADV/7zCj37UCbz9n4FVLEkGqAQ3yyoEFL2VkbR3GizK0Wcy
	 q+mnUm1gvyg31Hmw9UpzmuVV0RKjJqzIATp6IXnpYsCm+K3pW6VwTPrB9UegX4Q2nF/k/QK1eyP6
	 dw0q050HtJ9LiuB5PkVv0IW9j+DT0lEl78mwpwc0HuSNYQztqhoJhBWjrOMXIBnO8LRWdfLiprAH
	 rx8zxIAgp8e9MXa/RDyv27vdB38gYaUV2L2gXgDmMHkOJNAVQv2gyLeDXAv+GJjbeM975PjW/db5
	 iOFxGfTK+eKRFW+qWEkX+LQTe8w+sEKDOWCGw+d7SJ+ku6ctTxfOFxC6PvjPVFPyxdpj5vZ97atE
	 Ylqs7eknhHhvWnYjoznJKEtDW9/Tuk3U0lO/zZSra7BqfDwJiJFox3LcKAIcTlqHSc+FQIdkmVVS
	 MFuiTADFX8esAIHG58ysROX0OUK9N8hg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Date: Mon, 16 Dec 2024 22:07:57 +0800
X-OQ-MSGID: <20241216140756.2403238-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675fe376.050a0220.37aaf.011e.GAE@google.com>
References: <675fe376.050a0220.37aaf.011e.GAE@google.com>
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
Tested-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..15c43d7415d5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7019,6 +7019,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
+	if (((nr_subbufs + 1) << subbuf_order) < pgoff)
+		return -EINVAL;
+
 	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
 
 	nr_vma_pages = vma_pages(vma);
-- 
2.47.0

