Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015A42AA6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896965; cv=none; b=B9hEbQJbYyFJPLHglhiFaXvsjL02LXhF8L4kbeBJ5kuBNsDuIeIGfKW82nxzdhO7cJUfugjtnhlqIC+LBVIRvS6S4RwJa+7v+3ZOBouWXD1/8SamI1G+sWePS00uiDCXcAg01XTX57OpX0NUFU8cL1xuB7q6n+k+zcuNvJ9RplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896965; c=relaxed/simple;
	bh=0K9/9vE5TVjrqCBgVRnYtfzP2C3WxjCluC22pQ6GPYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZIasl7oItWhHfWfFI4QGADjCekM4gyTjvtrZXmc7O5HKF5bxSTte2q52eMIuR/fHP5HzlyEEkjIDpkdUG4FPmgmkdJMPxAg4RGdXw5e8GJtcy44yPBA4LU7c/Yvepygk2F0FuLI/JxLdC1rT0+1teUkNITe1Z6G1IftFS0T7bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBqf4bo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBqf4bo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782896963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p4XpPuj0dMr8Ei+9iXfXHmkRsvyKf5pmSt1GdxLc7cw=;
	b=cBqf4bo7BLvLuDYsZeeOWBPtK75P3efS0Ldi7g7/az7aPQoZJaPLUt9+gfPC/0/vrMiGLA
	gk8rH6oSX3q2JEOCABDd5hbJaTaS6TxdqERK4XyrS50omagVamSSqQZuU6SG5xvP9sCFDy
	naRmUEvlDBf1vzwXTCHdy3e3Rb2ni14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-RLOHQJWtPSuVyZhxxSqkog-1; Wed,
 01 Jul 2026 05:09:20 -0400
X-MC-Unique: RLOHQJWtPSuVyZhxxSqkog-1
X-Mimecast-MFC-AGG-ID: RLOHQJWtPSuVyZhxxSqkog_1782896958
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDFE8184A095;
	Wed,  1 Jul 2026 09:09:17 +0000 (UTC)
Received: from fedora (unknown [10.44.32.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7F0FB3000C23;
	Wed,  1 Jul 2026 09:09:12 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Jul 2026 11:09:17 +0200 (CEST)
Date: Wed, 1 Jul 2026 11:09:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, olsajiri@gmail.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	tglx@kernel.org, x86@kernel.org
Subject: Re: [syzbot] [trace?] general protection fault in mtree_load
Message-ID: <akTZNgy1UPQdNcO_@redhat.com>
References: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
 <6a446e28.854d4ab9.360e1d.0017.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a446e28.854d4ab9.360e1d.0017.GAE@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: z9msg8_Q6M1tMBYRyM1go0FDNS03cDXnYFoL5UhwzuQ_1782896958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/30, syzbot wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c7d61c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bf5d2bfae96234
> dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbb11c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130bf4ea580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dc59e4fe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1bc8aed8d2e8/vmlinux-dc59e4fe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b1fdfc4aa09/bzImage-dc59e4fe.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI

#syz test

From: Jiri Olsa <jolsa@kernel.org>

In the unregister path we use __in_uprobe_trampoline check with
current->mm for the VMA lookup, which is wrong, because we are
in the tracer context, not the traced process.

Add mm_struct pointer argument to __in_uprobe_trampoline and
changing related callers to pass proper mm_struct pointer.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..2be6707e3320 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -761,9 +761,9 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 		destroy_uprobe_trampoline(tramp);
 }
 
-static bool __in_uprobe_trampoline(unsigned long ip)
+static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
 {
-	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
+	struct vm_area_struct *vma = vma_lookup(mm, ip);
 
 	return vma && vma_is_special_mapping(vma, &tramp_mapping);
 }
@@ -776,14 +776,14 @@ static bool in_uprobe_trampoline(unsigned long ip)
 
 	rcu_read_lock();
 	if (mmap_lock_speculate_try_begin(mm, &seq)) {
-		found = __in_uprobe_trampoline(ip);
+		found = __in_uprobe_trampoline(mm, ip);
 		retry = mmap_lock_speculate_retry(mm, seq);
 	}
 	rcu_read_unlock();
 
 	if (retry) {
 		mmap_read_lock(mm);
-		found = __in_uprobe_trampoline(ip);
+		found = __in_uprobe_trampoline(mm, ip);
 		mmap_read_unlock(mm);
 	}
 	return found;
@@ -1044,7 +1044,7 @@ static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst,
 	return 0;
 }
 
-static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
+static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
 {
 	struct __packed __arch_relative_insn {
 		u8 op;
@@ -1053,7 +1053,7 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
 
 	if (!is_call_insn(insn))
 		return false;
-	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+	return __in_uprobe_trampoline(mm, vaddr + 5 + call->raddr);
 }
 
 static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
@@ -1064,7 +1064,7 @@ static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 	err = copy_from_vaddr(mm, vaddr, &insn, 5);
 	if (err)
 		return err;
-	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return __is_optimized(mm, (uprobe_opcode_t *)&insn, vaddr);
 }
 
 static bool should_optimize(struct arch_uprobe *auprobe)
-- 
2.54.0


