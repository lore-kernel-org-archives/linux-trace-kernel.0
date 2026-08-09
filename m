Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44F286881
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786253368; cv=none; b=rTBr/Lo+Z+zTcRZOBM7otV9pfRFawh+nVHp9R4cDyl+TY7jC3pnUNVKJ8LbxNgEsccK2hAPJ44lmXvV5ad4yNfE08WsYRH4qgfXDtDkcNO5n0uU5e79pxF4K/rizBc693xP8e34uHXh64h36yKFT7b8HwH69jIYoFYuxvkSBmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786253368; c=relaxed/simple;
	bh=X9OQpKpuomPd2DHH4c9UycInQYjg3rZQ1z/4rBiDkto=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nrvFjFTMSnlshMha5hjDrMOm9nZg+CMfD8lraQvjIejCASKF05WonEC/zblwZ2fK362JT/CGZRZYU+nybE5crgVWSRo42oeF1SQuzdWxk2pSqDme80SuP3F93t+tqT91WaDtn+ZpkzLceD7I3n/TLwbVR0lP0CsJilCI92xQsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9e741693bso479197a34.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 08 Aug 2026 22:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786253366; x=1786858166;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJCEcOBoCOvBwJ00UyGRPpiB5DkjriR63z9d68ArgeY=;
        b=P/oYciyG8SeTwjA4tzHKr0do4CxRWEV+Mp6AdvwCdnfZSkGYi716+OCIEWjFle4/bJ
         tTLlxdnlbf4xd8t7P4Lgx3h48rJ/uug4okKLFNvBwQ/hfCdvld+PEyprBsRMpGeqJ/2U
         r3XzXzUlw9mUut0JyyM8sTNCoRFv/cyFszshJRQ0uemGmGob+768nZaniJtD/4K+kOqz
         73/qNOr5H46jbRHpFFejTMP+UWsH5B1GmfBATwFXMp6p4u+nW9D8JP0PCf8iNfx3kaHA
         JOrPYljbYmHYlYvPype6yTkoVsThKBxIYeN0h323dUncCrt4nVRa6p7hG8Wvd+a5RXnT
         Cx6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoKOgGKpOnhjkmsWTFQMEJX0g2VZUMaQFohcVpF7nvJOo6mCCbBhbHemc/68HtQQxZdwI1jHmg3gN24Ha6uDx37hjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGuP3BLkVHvtWamhxVdVBj84m54wwtSILMXtcqA26CDFPX9aT
	0xC5gx371NFPajASJyU5bUAVRD1roduhSWspYw09cxvpdGhHEsljdSEQL+jkXy4m952/FUJrAEH
	DzyhpLauIdwCl6YtC4C5AZZWtihXtSNQg0asOJmN+CnlRxtMNDjrqlRhCRWE=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2015:b0:6ae:42c7:ef88 with SMTP id
 006d021491bc7-6ae96c17639mr18161767eaf.7.1786253366198; Sat, 08 Aug 2026
 22:29:26 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a781036.9c11d2ce.289b96.00c7.GAE@google.com>
Subject: [syzbot] [trace?] KCSAN: data-race in __rb_reserve_next / ring_buffer_iter_peek
From: syzbot <syzbot+b57601b220ccc4fa1551@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ba2132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=b57601b220ccc4fa1551
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82bd4b0b2828/disk-f9a2394a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab3cb0b1997d/vmlinux-f9a2394a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0a8ddb2683a/bzImage-f9a2394a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b57601b220ccc4fa1551@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __rb_reserve_next / ring_buffer_iter_peek

write to 0xffff8881331f4000 of 8 bytes by task 12741 on cpu 0:
 __rb_reserve_next+0x5f1/0x6c0 kernel/trace/ring_buffer.c:4851
 rb_reserve_next_event kernel/trace/ring_buffer.c:4925 [inline]
 ring_buffer_lock_reserve+0x68c/0x830 kernel/trace/ring_buffer.c:4984
 __trace_buffer_lock_reserve kernel/trace/trace.h:1676 [inline]
 trace_event_buffer_lock_reserve+0x148/0x300 kernel/trace/trace.c:1924
 trace_event_buffer_reserve+0x120/0x180 kernel/trace/trace_events.c:688
 do_trace_event_raw_event_kmem_cache_free include/trace/events/kmem.h:117 [inline]
 trace_event_raw_event_kmem_cache_free+0xa4/0x140 include/trace/events/kmem.h:117
 __do_trace_kmem_cache_free include/trace/events/kmem.h:117 [inline]
 trace_kmem_cache_free include/trace/events/kmem.h:117 [inline]
 kmem_cache_free+0x31d/0x380 mm/slub.c:6503
 anon_vma_chain_free mm/rmap.c:147 [inline]
 unlink_anon_vmas+0x1b8/0x360 mm/rmap.c:514
 free_pgtables+0x50e/0x630 mm/memory.c:414
 exit_mmap+0x367/0x5e0 mm/mmap.c:1312
 __mmput+0x28/0x1c0 kernel/fork.c:1187
 mmput+0x40/0x50 kernel/fork.c:1210
 exec_mm_put_old fs/exec.c:916 [inline]
 setup_new_exec+0x20a/0x230 fs/exec.c:1353
 load_elf_binary+0x77a/0x1a30 fs/binfmt_elf.c:1024
 search_binary_handler fs/exec.c:1694 [inline]
 exec_binprm fs/exec.c:1726 [inline]
 bprm_execve+0x45c/0x9b0 fs/exec.c:1778
 do_execveat_common+0x7a4/0x8a0 fs/exec.c:1876
 __do_sys_execve fs/exec.c:1949 [inline]
 __se_sys_execve fs/exec.c:1943 [inline]
 __x64_sys_execve+0x5f/0x80 fs/exec.c:1943
 x64_sys_call+0x2752/0x3020 arch/x86/include/generated/asm/syscalls_64.h:60
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881331f4000 of 8 bytes by task 11658 on cpu 1:
 ring_buffer_iter_empty kernel/trace/ring_buffer.c:5647 [inline]
 rb_iter_peek kernel/trace/ring_buffer.c:6143 [inline]
 ring_buffer_iter_peek+0x265/0xb10 kernel/trace/ring_buffer.c:6305
 peek_next_entry kernel/trace/trace.c:2349 [inline]
 __find_next_entry+0x1a9/0x420 kernel/trace/trace.c:2398
 trace_find_next_entry_inc kernel/trace/trace.c:2672 [inline]
 s_next+0x10e/0x370 kernel/trace/trace.c:2711
 traverse+0x1c1/0x3b0 fs/seq_file.c:121
 seq_read_iter+0x7dc/0x8f0 fs/seq_file.c:196
 do_iter_readv_writev+0x4f6/0x5a0 fs/read_write.c:-1
 vfs_readv+0x1e8/0x6d0 fs/read_write.c:1019
 do_preadv fs/read_write.c:1133 [inline]
 __do_sys_preadv2 fs/read_write.c:1192 [inline]
 __se_sys_preadv2+0xfc/0x1c0 fs/read_write.c:1183
 __x64_sys_preadv2+0x67/0x80 fs/read_write.c:1183
 x64_sys_call+0x2b3b/0x3020 arch/x86/include/generated/asm/syscalls_64.h:328
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x000001502ab37190 -> 0x000001505958442b

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 11658 Comm: syz.6.11885 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
