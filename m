Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AF1E4F0C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031526; cv=none; b=ow+n3GDwqS3NwnwlXHmsQ2Ylc0MtSbB6DtKJgJV643lJLaDtoND3J98FbsQixh3063XtrZuoBwKxeup7EndWfRYDM7jpmwkSKEcvso3tKlP5XaiIaYlahz3bOm5ezvDhu+tDMcWL6njabiNXnDAnHTo0I6i22Yo3UgNQrxj/5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031526; c=relaxed/simple;
	bh=RN75MZ8MYRQ8IJAr1KjOptQwPs3l2LTpoDlX74kelVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9SUegKqcxiXEst3CmWsegxeDaZ4kwi+YoaJWvyWBShbXyVToSG74DzThjGWS7J16bF6iFH8pbKHNX5tu2/AUt6oRvE+llJF9JxzkR5Gj9WxswcXyNhkGok2WEv//6NoF+qE6PbTwBFvz4Ve/CUQuf+nKzJOyGF6KqUHqarHsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=eV4DWZwo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="eV4DWZwo"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2475974a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723031523; x=1723636323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSkJbTtDDX1ptGeLI5JXF7jyRV5eixns5KZnH8J+AgQ=;
        b=eV4DWZwoT9oI04SC62zsQ9LlnwZGmZXi0yi9c0AuHoyfade9R+vKDYTH84WUBk8NDy
         LtjODc4v+JUjJt9QnndUKnW1xu+yQdWA+CK/JXgul1lg9kJ8p/nqgAS0Kxh8qAvrgLr4
         W5DeQM/OpMxOSosPSstMu0HzOaUXwRdtkxg95YpNFQk6dJkCllhln823kuCn34DLXcLt
         cMiCdeN5d5au5YrMaGVXnogj5uX9ypPtmUjxKoosWoEgc1Dxxe0jTzVuifcUJXzZjoZ8
         77ihiugG1Y+baocvaWXPDK8tFagw/s2n93cT8eoK1LPzsJqcXbNfNDXumQ5k4dv9pd7N
         Jw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031523; x=1723636323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSkJbTtDDX1ptGeLI5JXF7jyRV5eixns5KZnH8J+AgQ=;
        b=j4nvDPa1g8znqk7SNVeoGqjaRO5nRCj4V1g069VBojUSnVG+oOnoA/PKl7I6+TlBn4
         azoEa4X6FwtGERhbO8KhmaHSimhke/NOSR0B3yKDSACPvJhs+ElE2J/qqvI849v+Eced
         V2YNvzKy5u/Wr1EZS7VEnHsNrmhP9hpTQihi72PmrCSmzJorVo0nzxuV0w85zh25XOV5
         r6Z/OKj/iCNkKHc/fHb73bNc1NciSJFlZQZJNBczdk8AjF/uj5TwlcFgRiVBXr+S37FG
         mB0e1WpSpr02YZal5M9PqUuX0O84wVFphMkiYjG0YaUfBS1l8jOADzeOjguLkIV1cI0K
         f/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7IqXH+oyaQVKl17EQkI9qLXGQ0GL7iacTBzXZuCg1eR1xuVWIhargKGXqIIKiYWiJNkn/5NPo97Cds9xPO2l/JxdFM4p1GoTGpHUTL5ncLL4
X-Gm-Message-State: AOJu0YzS85o585f0vjZOxAlwkydd81ohgla5ZMl+udon1JaaP5dqEKNq
	kcbDPBQgtQtxNB7IumfP6gke4XKZQxEo6hNhrebnsSHjQZUcFMgeEgi8l2vWK6M=
X-Google-Smtp-Source: AGHT+IHTfqPEzAi9hBC5PaDyeAOfWrWFeXv707l+ExkVlqNLjcxCSgKzXsZZDClqLRNjUJicAvsoow==
X-Received: by 2002:a05:6402:148c:b0:5b9:3846:8bb9 with SMTP id 4fb4d7f45d1cf-5b9384693abmr9358623a12.10.1723031522603;
        Wed, 07 Aug 2024 04:52:02 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af119b00710ea47398d5cfcf.dip0.t-ipconnect.de. [2003:f6:af11:9b00:710e:a473:98d5:cfcf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba3acc257asm5207141a12.51.2024.08.07.04.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:52:02 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilkka=20Naulap=C3=A4=C3=A4?= <digirigawa@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Brad Spengler <spender@grsecurity.net>
Subject: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
Date: Wed,  7 Aug 2024 13:51:39 +0200
Message-ID: <20240807115143.45927-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807115143.45927-1-minipli@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With structure layout randomization enabled for 'struct inode' we need
to avoid overlapping any of the RCU-used / initialized-only-once
members, e.g. i_lru or i_sb_list to not corrupt related list traversals
when making use of the rcu_head.

For an unlucky structure layout of 'struct inode' we may end up with the
following splat when running the ftrace selftests:

[<...>] list_del corruption, ffff888103ee2cb0->next (tracefs_inode_cache+0x0/0x4e0 [slab object]) is NULL (prev is tracefs_inode_cache+0x78/0x4e0 [slab object])
[<...>] ------------[ cut here ]------------
[<...>] kernel BUG at lib/list_debug.c:54!
[<...>] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[<...>] CPU: 3 PID: 2550 Comm: mount Tainted: G                 N  6.8.12-grsec+ #122 ed2f536ca62f28b087b90e3cc906a8d25b3ddc65
[<...>] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[<...>] RIP: 0010:[<ffffffff84656018>] __list_del_entry_valid_or_report+0x138/0x3e0
[<...>] Code: 48 b8 99 fb 65 f2 ff ff ff ff e9 03 5c d9 fc cc 48 b8 99 fb 65 f2 ff ff ff ff e9 33 5a d9 fc cc 48 b8 99 fb 65 f2 ff ff ff ff <0f> 0b 4c 89 e9 48 89 ea 48 89 ee 48 c7 c7 60 8f dd 89 31 c0 e8 2f
[<...>] RSP: 0018:fffffe80416afaf0 EFLAGS: 00010283
[<...>] RAX: 0000000000000098 RBX: ffff888103ee2cb0 RCX: 0000000000000000
[<...>] RDX: ffffffff84655fe8 RSI: ffffffff89dd8b60 RDI: 0000000000000001
[<...>] RBP: ffff888103ee2cb0 R08: 0000000000000001 R09: fffffbd0082d5f25
[<...>] R10: fffffe80416af92f R11: 0000000000000001 R12: fdf99c16731d9b6d
[<...>] R13: 0000000000000000 R14: ffff88819ad4b8b8 R15: 0000000000000000
[<...>] RBX: tracefs_inode_cache+0x0/0x4e0 [slab object]
[<...>] RDX: __list_del_entry_valid_or_report+0x108/0x3e0
[<...>] RSI: __func__.47+0x4340/0x4400
[<...>] RBP: tracefs_inode_cache+0x0/0x4e0 [slab object]
[<...>] RSP: process kstack fffffe80416afaf0+0x7af0/0x8000 [mount 2550 2550]
[<...>] R09: kasan shadow of process kstack fffffe80416af928+0x7928/0x8000 [mount 2550 2550]
[<...>] R10: process kstack fffffe80416af92f+0x792f/0x8000 [mount 2550 2550]
[<...>] R14: tracefs_inode_cache+0x78/0x4e0 [slab object]
[<...>] FS:  00006dcb380c1840(0000) GS:ffff8881e0600000(0000) knlGS:0000000000000000
[<...>] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[<...>] CR2: 000076ab72b30e84 CR3: 000000000b088004 CR4: 0000000000360ef0 shadow CR4: 0000000000360ef0
[<...>] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[<...>] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[<...>] ASID: 0003
[<...>] Stack:
[<...>]  ffffffff818a2315 00000000f5c856ee ffffffff896f1840 ffff888103ee2cb0
[<...>]  ffff88812b6b9750 0000000079d714b6 fffffbfff1e9280b ffffffff8f49405f
[<...>]  0000000000000001 0000000000000000 ffff888104457280 ffffffff8248b392
[<...>] Call Trace:
[<...>]  <TASK>
[<...>]  [<ffffffff818a2315>] ? lock_release+0x175/0x380 fffffe80416afaf0
[<...>]  [<ffffffff8248b392>] list_lru_del+0x152/0x740 fffffe80416afb48
[<...>]  [<ffffffff8248ba93>] list_lru_del_obj+0x113/0x280 fffffe80416afb88
[<...>]  [<ffffffff8940fd19>] ? _atomic_dec_and_lock+0x119/0x200 fffffe80416afb90
[<...>]  [<ffffffff8295b244>] iput_final+0x1c4/0x9a0 fffffe80416afbb8
[<...>]  [<ffffffff8293a52b>] dentry_unlink_inode+0x44b/0xaa0 fffffe80416afbf8
[<...>]  [<ffffffff8293fefc>] __dentry_kill+0x23c/0xf00 fffffe80416afc40
[<...>]  [<ffffffff8953a85f>] ? __this_cpu_preempt_check+0x1f/0xa0 fffffe80416afc48
[<...>]  [<ffffffff82949ce5>] ? shrink_dentry_list+0x1c5/0x760 fffffe80416afc70
[<...>]  [<ffffffff82949b71>] ? shrink_dentry_list+0x51/0x760 fffffe80416afc78
[<...>]  [<ffffffff82949da8>] shrink_dentry_list+0x288/0x760 fffffe80416afc80
[<...>]  [<ffffffff8294ae75>] shrink_dcache_sb+0x155/0x420 fffffe80416afcc8
[<...>]  [<ffffffff8953a7c3>] ? debug_smp_processor_id+0x23/0xa0 fffffe80416afce0
[<...>]  [<ffffffff8294ad20>] ? do_one_tree+0x140/0x140 fffffe80416afcf8
[<...>]  [<ffffffff82997349>] ? do_remount+0x329/0xa00 fffffe80416afd18
[<...>]  [<ffffffff83ebf7a1>] ? security_sb_remount+0x81/0x1c0 fffffe80416afd38
[<...>]  [<ffffffff82892096>] reconfigure_super+0x856/0x14e0 fffffe80416afd70
[<...>]  [<ffffffff815d1327>] ? ns_capable_common+0xe7/0x2a0 fffffe80416afd90
[<...>]  [<ffffffff82997436>] do_remount+0x416/0xa00 fffffe80416afdd0
[<...>]  [<ffffffff829b2ba4>] path_mount+0x5c4/0x900 fffffe80416afe28
[<...>]  [<ffffffff829b25e0>] ? finish_automount+0x13a0/0x13a0 fffffe80416afe60
[<...>]  [<ffffffff82903812>] ? user_path_at_empty+0xb2/0x140 fffffe80416afe88
[<...>]  [<ffffffff829b2ff5>] do_mount+0x115/0x1c0 fffffe80416afeb8
[<...>]  [<ffffffff829b2ee0>] ? path_mount+0x900/0x900 fffffe80416afed8
[<...>]  [<ffffffff8272461c>] ? __kasan_check_write+0x1c/0xa0 fffffe80416afee0
[<...>]  [<ffffffff829b31cf>] __do_sys_mount+0x12f/0x280 fffffe80416aff30
[<...>]  [<ffffffff829b36cd>] __x64_sys_mount+0xcd/0x2e0 fffffe80416aff70
[<...>]  [<ffffffff819f8818>] ? syscall_trace_enter+0x218/0x380 fffffe80416aff88
[<...>]  [<ffffffff8111655e>] x64_sys_call+0x5d5e/0x6720 fffffe80416affa8
[<...>]  [<ffffffff8952756d>] do_syscall_64+0xcd/0x3c0 fffffe80416affb8
[<...>]  [<ffffffff8100119b>] entry_SYSCALL_64_safe_stack+0x4c/0x87 fffffe80416affe8
[<...>]  </TASK>
[<...>]  <PTREGS>
[<...>] RIP: 0033:[<00006dcb382ff66a>] vm_area_struct[mount 2550 2550 file 6dcb38225000-6dcb3837e000 22 55(read|exec|mayread|mayexec)]+0x0/0xb8 [userland map]
[<...>] Code: 48 8b 0d 29 18 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f6 17 0d 00 f7 d8 64 89 01 48
[<...>] RSP: 002b:0000763d68192558 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[<...>] RAX: ffffffffffffffda RBX: 00006dcb38433264 RCX: 00006dcb382ff66a
[<...>] RDX: 000017c3e0d11210 RSI: 000017c3e0d1a5a0 RDI: 000017c3e0d1ae70
[<...>] RBP: 000017c3e0d10fb0 R08: 000017c3e0d11260 R09: 00006dcb383d1be0
[<...>] R10: 000000000020002e R11: 0000000000000246 R12: 0000000000000000
[<...>] R13: 000017c3e0d1ae70 R14: 000017c3e0d11210 R15: 000017c3e0d10fb0
[<...>] RBX: vm_area_struct[mount 2550 2550 file 6dcb38433000-6dcb38434000 5b 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] RCX: vm_area_struct[mount 2550 2550 file 6dcb38225000-6dcb3837e000 22 55(read|exec|mayread|mayexec)]+0x0/0xb8 [userland map]
[<...>] RDX: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] RSI: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] RDI: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] RBP: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] RSP: vm_area_struct[mount 2550 2550 anon 763d68173000-763d68195000 7ffffffdd 100133(read|write|mayread|maywrite|growsdown|account)]+0x0/0xb8 [userland map]
[<...>] R08: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] R09: vm_area_struct[mount 2550 2550 file 6dcb383d1000-6dcb383d3000 1cd 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] R13: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] R14: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>] R15: vm_area_struct[mount 2550 2550 anon 17c3e0d0f000-17c3e0d31000 17c3e0d0f 100033(read|write|mayread|maywrite|account)]+0x0/0xb8 [userland map]
[<...>]  </PTREGS>
[<...>] Modules linked in:
[<...>] ---[ end trace 0000000000000000 ]---

The list debug message as well as RBX's symbolic value point out that
the object in question was allocated from 'tracefs_inode_cache' and that
the list's '->next' member is at offset 0. Dumping the layout of the
relevant parts of 'struct tracefs_inode' gives the following:

  struct tracefs_inode {
    union {
      struct inode {
        struct list_head {
          struct list_head * next;                    /*     0     8 */
          struct list_head * prev;                    /*     8     8 */
        } i_lru;
        [...]
      } vfs_inode;
      struct callback_head {
        void (*func)(struct callback_head *);         /*     0     8 */
        struct callback_head * next;                  /*     8     8 */
      } rcu;
    };
    [...]
  };

Above shows that 'vfs_inode.i_lru' overlaps with 'rcu' which will
destroy the 'i_lru' list as soon as the 'rcu' member gets used, e.g. in
call_rcu() or later when calling the RCU callback. This will disturb
concurrent list traversals as well as object reuse which assumes these
list heads will keep their integrity.

For reproduction, the following diff manually overlays 'i_lru' with
'rcu' as, otherwise, one would require some good portion of luck for
gambling an unlucky RANDSTRUCT seed:

  --- a/include/linux/fs.h
  +++ b/include/linux/fs.h
  @@ -629,6 +629,7 @@ struct inode {
   	umode_t			i_mode;
   	unsigned short		i_opflags;
   	kuid_t			i_uid;
  +	struct list_head	i_lru;		/* inode LRU list */
   	kgid_t			i_gid;
   	unsigned int		i_flags;

  @@ -690,7 +691,6 @@ struct inode {
   	u16			i_wb_frn_avg_time;
   	u16			i_wb_frn_history;
   #endif
  -	struct list_head	i_lru;		/* inode LRU list */
   	struct list_head	i_sb_list;
   	struct list_head	i_wb_list;	/* backing dev writeback list */
   	union {

To avoid the list corruption, just ditch the union as it has no impact
on the memory footprint of 'struct tracefs_inode' at all -- the
premature layout optimization to save space just isn't. There's plenty
of padding space available.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: baa23a8d4360 ("tracefs: Reset permissions on remount if permissions are options")
Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---

Ilkka, this may fix the splat/panic you're observing during reboot. Can
you give it a shot, please?

 fs/tracefs/internal.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f704d8348357..a7769857962a 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -10,10 +10,8 @@ enum {
 };
 
 struct tracefs_inode {
-	union {
-		struct inode            vfs_inode;
-		struct rcu_head		rcu;
-	};
+	struct inode		vfs_inode;
+	struct rcu_head		rcu;
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	struct list_head	list;
 	unsigned long           flags;
-- 
2.43.0

