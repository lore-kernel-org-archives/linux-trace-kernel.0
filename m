Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFB7FBCF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 May 2024 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284665; cv=none; b=Nq3iTBRjEU/MpPghLiz9D9l5KXhqKk8yMvKTQtekjt1tD0UiZeVeUehJ1GqIfYJtpzPrf72xRxgZdg4zK8barckhOZYQVxZbNBOJvOI57kGFgUaTicg39l9Fk95WjjO/+29mNKH7vML28ho6Bs/3zvXCi15VaHcSi7p3+tQiWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284665; c=relaxed/simple;
	bh=25PFL8O7LUiyWR/XgauuhKM/SlCV7k8rJDcEP1QNg88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuUKFeehEyy0i15QKoUKT1mRFrYLQzlzUCdg6f3U22xyhOVzdrDfmzrRIsVZ4L3ioqF3184sBs4bgNjgRxWOLd1R+FvsUh6ByaulSuOvzTRPA0PHMN9zavgU0XmwvDKVpnK8FkV6EOFcrS/NJ38VzIV8cCSOLRzcg17ekaOtCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkVOTHAK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkVOTHAK"
Date: Thu, 9 May 2024 15:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715284660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUOp3tD7dHB3td/tNecroqkm1TIas/9UKBvrzjN3teU=;
	b=kkVOTHAKbEANBp0vEYqjB99ffbNovfw6vt7NbodmwcBMEoPQDq7deOcFUwhWRVGjfcq2rX
	4sq50B7t7nIGBu9k02RL7vXWrTc2vTlV2olwrlOlsnGrb8JgvFflLSjILeltgMcZa4vn6/
	L0TLm5NS01menxQZOJQ98s5RaiTgmUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG in ptr_stale
Message-ID: <f227oabmqv43kx4ftezqjao3zs6ryq7gacn5j6p4z2q4yolja2@zqiluasr3wzd>
References: <c9f0326b-c90f-4764-ae1a-cefc50726283.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f0326b-c90f-4764-ae1a-cefc50726283.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 09, 2024 at 02:26:24PM +0800, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.

This (and several of your others) are fixed in Linus's tree.

> 
> Stack dump:
> 
> bcachefs (loop1): mounting version 1.7: (unknown version) opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
> ------------[ cut here ]------------
> kernel BUG at fs/bcachefs/buckets.h:114!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 9472 Comm: syz-executor.1 Not tainted 6.7.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:bucket_gen fs/bcachefs/buckets.h:114 [inline]
> RIP: 0010:ptr_stale+0x474/0x4e0 fs/bcachefs/buckets.h:188
> Code: 48 c7 c2 80 8c 1b 8b be 67 00 00 00 48 c7 c7 e0 8c 1b 8b c6 05 ea a6 72 0b 01 e8 57 55 9c fd e9 fb fc ff ff e8 9d 02 bd fd 90 <0f> 0b 48 89 04 24 e8 31 bb 13 fe 48 8b 04 24 e9 35 fc ff ff e8 23
> RSP: 0018:ffffc90007c4ec38 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000080 RCX: ffffc90002679000
> RDX: 0000000000040000 RSI: ffffffff83ccf3b3 RDI: 0000000000000006
> RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000010000028
> R10: 0000000000000080 R11: 0000000000000000 R12: 0000000010000028
> R13: ffff88804dee5100 R14: 0000000000000000 R15: ffff88805b1a4110
> FS:  00007f79ba8ab640(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0bbda3f000 CR3: 000000005f37a000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bch2_bkey_ptrs_to_text+0xb4e/0x1760 fs/bcachefs/extents.c:1012
>  bch2_btree_ptr_v2_to_text+0x288/0x330 fs/bcachefs/extents.c:215
>  bch2_val_to_text fs/bcachefs/bkey_methods.c:287 [inline]
>  bch2_bkey_val_to_text+0x1c8/0x210 fs/bcachefs/bkey_methods.c:297
>  journal_validate_key+0x7ab/0xb50 fs/bcachefs/journal_io.c:322
>  journal_entry_btree_root_validate+0x31c/0x380 fs/bcachefs/journal_io.c:411
>  bch2_journal_entry_validate+0xc7/0x130 fs/bcachefs/journal_io.c:752
>  bch2_sb_clean_validate_late+0x14b/0x1e0 fs/bcachefs/sb-clean.c:32
>  bch2_read_superblock_clean+0xbb/0x250 fs/bcachefs/sb-clean.c:160
>  bch2_fs_recovery+0x113/0x52d0 fs/bcachefs/recovery.c:691
>  bch2_fs_start+0x365/0x5e0 fs/bcachefs/super.c:978
>  bch2_fs_open+0x1ac9/0x3890 fs/bcachefs/super.c:1968
>  bch2_mount+0x538/0x13c0 fs/bcachefs/fs.c:1863
>  legacy_get_tree+0x109/0x220 fs/fs_context.c:662
>  vfs_get_tree+0x93/0x380 fs/super.c:1771
>  do_new_mount fs/namespace.c:3337 [inline]
>  path_mount+0x679/0x1e40 fs/namespace.c:3664
>  do_mount fs/namespace.c:3677 [inline]
>  __do_sys_mount fs/namespace.c:3886 [inline]
>  __se_sys_mount fs/namespace.c:3863 [inline]
>  __x64_sys_mount+0x287/0x310 fs/namespace.c:3863
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f79b9a91b3e
> Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f79ba8aae38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00000000000119f4 RCX: 00007f79b9a91b3e
> RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007f79ba8aae90
> RBP: 00007f79ba8aaed0 R08: 00007f79ba8aaed0 R09: 000000000181c050
> R10: 000000000181c050 R11: 0000000000000202 R12: 0000000020011a00
> R13: 0000000020011a40 R14: 00007f79ba8aae90 R15: 00000000200001c0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> 
> 
> Thank you for taking the time to read this email and we look forward to working with you further.
> 
> 
> 
> 
> 
> 


