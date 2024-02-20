Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FB4482D0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708403185; cv=none; b=WNqxFgkPnAfYeatwmutR+1ljZNwoOejaMndpktblJ7LecSAOGnF/wiViuNlo4wXkAAaobXA1dvPw0DzNMr2KFAii6b3Fr7TbodYhIjCtVygsiLm1yN7+XPcZS217E42fIuEIC5Hyx5BV7xDo6XUJS9tEvum0LvxrnDIKKHcWsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708403185; c=relaxed/simple;
	bh=KL6pB/FKvA43y8hgMncRFU+5Do+KO5Xj5Ci32oGfZgo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jvUyun0vlX7W4+afUuAqG5JMA4E3HCQN/z/fPs6a0mMkxORZmHZs5OMMk6VYnLiieIgYQBBZ2zGxXWmMAOwIdhQ9iCaN57C2UW4fB8XNKG3qntelHVuMZOpDeudVXtLb+T8VbdcMRx2hgwjXJodPaPps7VAL+jHnVWM+PTlIpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NFxu1Ei; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NFxu1Ei"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso3095009276.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708403183; x=1709007983; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=smOx0A+zJu8PfHoBnnMyvlup4aoJ6C96lfTmf7s2+Ds=;
        b=1NFxu1EiEGZ6GkooiqrMl6CQUfqxBGNaJE1+DaMpD+BXCS7GgiCtLzEQj5FWtOCr3v
         OA1TSoCmbbvhIVYawiroUs753xApnHuPV5y6f8vtCt0/GASLy7vmYyVbFZLNtVaO9/cI
         C3qvGlB3fg2kdWOnaFAgcZscdspaMLC63L82ognb7VRKNV2X0G+4dIB/P8OrLjFWheX6
         yV+vh4/FK07yq8ZvFh06LBRTBtYVwFcV/e0E1kgV5c39Tmd9LlqdEg3M+j673xQl1FdH
         nY3a6p0PplFXyUwfN5bRigpbpAm6q8feSUYS7ZGKKs2B17QkQflTHgYzwdlXI7g6xSGx
         WwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708403183; x=1709007983;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smOx0A+zJu8PfHoBnnMyvlup4aoJ6C96lfTmf7s2+Ds=;
        b=CtJ8+PSuIGsGsRI1Aq6viUaFYRGULG0XcSsTX00VboLtk8qtFVFdhXYxLC/0i2YkFd
         DvWJYQjyJq2xK4syuJXbmTr10fq0uvX4NtLUPHyVJ7pzwcsoQOvxVLFDqtSpNNTx1MK8
         PQC5P2jtV6Fupq7gj8WlW17VolMjPo21yGV0grK68mcLEhZJ9Yw6hLrG7EINDRcdSlbC
         yW9jUZGGsZMKqmWViEHL/dr/iGu+4Uf5YhvjDJzH2+fVBLIAyjT/HpAeZ97pk9XhihIH
         NF072rrMcjSe2CRfKpHa3NXxnEPymdK7YKuKeSZIl2+ZJSh/FF98KEYqXON+52TcvamO
         0ECA==
X-Forwarded-Encrypted: i=1; AJvYcCVxgyiQakfaPPAd6LUjOLHF5OeeDBaGYe3tbEYnXlAvSUd2WNVAOeLm9c9Pmreo4b8+Xcmu8haWNoT4DqcOVCtQyy/VyzTIZxNq+nKTUI6Oa0V7
X-Gm-Message-State: AOJu0YzK/55HxYH1Ad+KAK2Z6b+lVn4R+Ef9X5BxP0emn5q76enJwx1+
	u3uoIqvvhHr7TolOW0mh8OwrJLw6MgdxBha9n3lF7CxbL16G6JuniXf4H7CERw==
X-Google-Smtp-Source: AGHT+IFl3uj8zLGrwUtTVjvNj87B+o1zM6Igow4vTYalMP+FRBoXpaIChS0/9GSZNDPn5iTgGYrlQw==
X-Received: by 2002:a25:74cc:0:b0:dc7:140:8c0c with SMTP id p195-20020a2574cc000000b00dc701408c0cmr13293994ybc.23.1708403182457;
        Mon, 19 Feb 2024 20:26:22 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b3-20020a5b0083000000b00dcdbe11c243sm1754092ybp.1.2024.02.19.20.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:26:21 -0800 (PST)
Date: Mon, 19 Feb 2024 20:26:20 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Carlos Maiolino <cem@kernel.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, 
    linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
    linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>, 
    Ubisectech Sirius <bugreport@ubisectech.com>
Subject: Re: WARNING in shmem_release_dquot
In-Reply-To: <544b03a4-e317-499f-8c9f-29571be668dc.bugreport@ubisectech.com>
Message-ID: <ae12d2ad-6f7f-09d4-30ba-03411c4dae66@google.com>
References: <544b03a4-e317-499f-8c9f-29571be668dc.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jan 2024, Ubisectech Sirius wrote:

> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8.0-rc1-gecb1b8288dc7. Attached to the email were a POC file of the issue.
> 
> Stack dump:
> [  246.195553][ T4096] ------------[ cut here ]------------
> [  246.196540][ T4096] quota id 16384 from dquot ffff888051bd3000, not in rb tree!
> [ 246.198829][ T4096] WARNING: CPU: 1 PID: 4096 at mm/shmem_quota.c:290 shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [  246.199955][ T4096] Modules linked in:
> [  246.200435][ T4096] CPU: 1 PID: 4096 Comm: kworker/u6:6 Not tainted 6.8.0-rc1-gecb1b8288dc7 #21
> [  246.201566][ T4096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  246.202667][ T4096] Workqueue: events_unbound quota_release_workfn
> [ 246.203516][ T4096] RIP: 0010:shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.204276][ T4096] Code: e8 28 d9 18 00 e9 b3 f8 ff ff e8 6e e1 c2 ff c6 05 bf e8 1b 0d 01 90 48 c7 c7 80 f0 b8 8a 4c 89 ea 44 89 e6 e8 14 6d 89 ff 90 <0f> 0b 90 90 e9 18 fb ff ff e8 f5 d8 18 00 e9 a2 fa ff ff e8 0b d9
> All code
> ========
>    0:   e8 28 d9 18 00          call   0x18d92d
>    5:   e9 b3 f8 ff ff          jmp    0xfffffffffffff8bd
>    a:   e8 6e e1 c2 ff          call   0xffffffffffc2e17d
>    f:   c6 05 bf e8 1b 0d 01    movb   $0x1,0xd1be8bf(%rip)        # 0xd1be8d5
>   16:   90                      nop
>   17:   48 c7 c7 80 f0 b8 8a    mov    $0xffffffff8ab8f080,%rdi
>   1e:   4c 89 ea                mov    %r13,%rdx
>   21:   44 89 e6                mov    %r12d,%esi
>   24:   e8 14 6d 89 ff          call   0xffffffffff896d3d
>   29:   90                      nop
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   90                      nop
>   2d:   90                      nop
>   2e:   e9 18 fb ff ff          jmp    0xfffffffffffffb4b
>   33:   e8 f5 d8 18 00          call   0x18d92d
>   38:   e9 a2 fa ff ff          jmp    0xfffffffffffffadf
>   3d:   e8                      .byte 0xe8
>   3e:   0b d9                   or     %ecx,%ebx
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   90                      nop
>    3:   90                      nop
>    4:   e9 18 fb ff ff          jmp    0xfffffffffffffb21
>    9:   e8 f5 d8 18 00          call   0x18d903
>    e:   e9 a2 fa ff ff          jmp    0xfffffffffffffab5
>   13:   e8                      .byte 0xe8
>   14:   0b d9                   or     %ecx,%ebx
> [  246.206640][ T4096] RSP: 0018:ffffc9000604fbc0 EFLAGS: 00010286
> [  246.207403][ T4096] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814c77da
> [  246.208514][ T4096] RDX: ffff888049a58000 RSI: ffffffff814c77e7 RDI: 0000000000000001
> [  246.209429][ T4096] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  246.210362][ T4096] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000004000
> [  246.211367][ T4096] R13: ffff888051bd3000 R14: dffffc0000000000 R15: ffff888051bd3040
> [  246.212327][ T4096] FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
> [  246.213387][ T4096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  246.214232][ T4096] CR2: 00007ffee748ec80 CR3: 000000000cb78000 CR4: 0000000000750ef0
> [  246.215216][ T4096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  246.216187][ T4096] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  246.217148][ T4096] PKRU: 55555554
> [  246.217615][ T4096] Call Trace:
> [  246.218090][ T4096]  <TASK>
> [ 246.218467][ T4096] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 246.218979][ T4096] ? __warn (kernel/panic.c:677)
> [ 246.219505][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.220197][ T4096] ? report_bug (lib/bug.c:201 lib/bug.c:219)
> [ 246.220775][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.221500][ T4096] ? handle_bug (arch/x86/kernel/traps.c:238)
> [ 246.222081][ T4096] ? exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1))
> [ 246.222687][ T4096] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> [ 246.223296][ T4096] ? __warn_printk (./include/linux/context_tracking.h:155 kernel/panic.c:726)
> [ 246.223878][ T4096] ? __warn_printk (kernel/panic.c:717)
> [ 246.224460][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.225125][ T4096] quota_release_workfn (fs/quota/dquot.c:839)
> [ 246.225792][ T4096] ? dquot_release (fs/quota/dquot.c:810)
> [ 246.226401][ T4096] process_one_work (kernel/workqueue.c:2638)
> [ 246.227001][ T4096] ? lock_sync (kernel/locking/lockdep.c:5722)
> [ 246.227509][ T4096] ? workqueue_congested (kernel/workqueue.c:2542)
> [ 246.228266][ T4096] ? assign_work (kernel/workqueue.c:1102)
> [ 246.228846][ T4096] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787)
> [ 246.229477][ T4096] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 246.230150][ T4096] ? process_one_work (kernel/workqueue.c:2733)
> [ 246.230735][ T4096] kthread (kernel/kthread.c:388)
> [ 246.231247][ T4096] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 246.231950][ T4096] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 246.232465][ T4096] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 246.233153][ T4096] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [  246.233783][ T4096]  </TASK>
> [  246.234175][ T4096] Kernel panic - not syncing: kernel: panic_on_warn set ...
> [  246.235087][ T4096] CPU: 1 PID: 4096 Comm: kworker/u6:6 Not tainted 6.8.0-rc1-gecb1b8288dc7 #21
> [  246.236174][ T4096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  246.237207][ T4096] Workqueue: events_unbound quota_release_workfn
> [  246.237927][ T4096] Call Trace:
> [  246.238294][ T4096]  <TASK>
> [ 246.238619][ T4096] dump_stack_lvl (lib/dump_stack.c:107)
> [ 246.239144][ T4096] panic (kernel/panic.c:344)
> [ 246.239584][ T4096] ? panic_smp_self_stop+0xa0/0xa0
> [ 246.240154][ T4096] ? check_panic_on_warn (kernel/panic.c:236)
> [ 246.240714][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.241303][ T4096] check_panic_on_warn (kernel/panic.c:237)
> [ 246.241915][ T4096] __warn (./arch/x86/include/asm/current.h:42 kernel/panic.c:682)
> [ 246.242428][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.243117][ T4096] report_bug (lib/bug.c:201 lib/bug.c:219)
> [ 246.243688][ T4096] ? shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.244390][ T4096] handle_bug (arch/x86/kernel/traps.c:238)
> [ 246.244957][ T4096] exc_invalid_op (arch/x86/kernel/traps.c:259 (discriminator 1))
> [ 246.245551][ T4096] asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
> [ 246.246189][ T4096] RIP: 0010:shmem_release_dquot (mm/shmem_quota.c:290 (discriminator 3))
> [ 246.246945][ T4096] Code: e8 28 d9 18 00 e9 b3 f8 ff ff e8 6e e1 c2 ff c6 05 bf e8 1b 0d 01 90 48 c7 c7 80 f0 b8 8a 4c 89 ea 44 89 e6 e8 14 6d 89 ff 90 <0f> 0b 90 90 e9 18 fb ff ff e8 f5 d8 18 00 e9 a2 fa ff ff e8 0b d9
> All code
> ========
>    0:   e8 28 d9 18 00          call   0x18d92d
>    5:   e9 b3 f8 ff ff          jmp    0xfffffffffffff8bd
>    a:   e8 6e e1 c2 ff          call   0xffffffffffc2e17d
>    f:   c6 05 bf e8 1b 0d 01    movb   $0x1,0xd1be8bf(%rip)        # 0xd1be8d5
>   16:   90                      nop
>   17:   48 c7 c7 80 f0 b8 8a    mov    $0xffffffff8ab8f080,%rdi
>   1e:   4c 89 ea                mov    %r13,%rdx
>   21:   44 89 e6                mov    %r12d,%esi
>   24:   e8 14 6d 89 ff          call   0xffffffffff896d3d
>   29:   90                      nop
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   90                      nop
>   2d:   90                      nop
>   2e:   e9 18 fb ff ff          jmp    0xfffffffffffffb4b
>   33:   e8 f5 d8 18 00          call   0x18d92d
>   38:   e9 a2 fa ff ff          jmp    0xfffffffffffffadf
>   3d:   e8                      .byte 0xe8
>   3e:   0b d9                   or     %ecx,%ebx
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   90                      nop
>    3:   90                      nop
>    4:   e9 18 fb ff ff          jmp    0xfffffffffffffb21
>    9:   e8 f5 d8 18 00          call   0x18d903
>    e:   e9 a2 fa ff ff          jmp    0xfffffffffffffab5
>   13:   e8                      .byte 0xe8
>   14:   0b d9                   or     %ecx,%ebx
> [  246.249288][ T4096] RSP: 0018:ffffc9000604fbc0 EFLAGS: 00010286
> [  246.250033][ T4096] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814c77da
> [  246.251035][ T4096] RDX: ffff888049a58000 RSI: ffffffff814c77e7 RDI: 0000000000000001
> [  246.252036][ T4096] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  246.253028][ T4096] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000004000
> [  246.254060][ T4096] R13: ffff888051bd3000 R14: dffffc0000000000 R15: ffff888051bd3040
> [ 246.255058][ T4096] ? __warn_printk (./include/linux/context_tracking.h:155 kernel/panic.c:726)
> [ 246.255694][ T4096] ? __warn_printk (kernel/panic.c:717)
> [ 246.256256][ T4096] quota_release_workfn (fs/quota/dquot.c:839)
> [ 246.256877][ T4096] ? dquot_release (fs/quota/dquot.c:810)
> [ 246.257467][ T4096] process_one_work (kernel/workqueue.c:2638)
> [ 246.258126][ T4096] ? lock_sync (kernel/locking/lockdep.c:5722)
> [ 246.258718][ T4096] ? workqueue_congested (kernel/workqueue.c:2542)
> [ 246.259339][ T4096] ? assign_work (kernel/workqueue.c:1102)
> [ 246.259915][ T4096] worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787)
> [ 246.260529][ T4096] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 246.261176][ T4096] ? process_one_work (kernel/workqueue.c:2733)
> [ 246.261855][ T4096] kthread (kernel/kthread.c:388)
> [ 246.262382][ T4096] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 246.263077][ T4096] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 246.263620][ T4096] ? kthread_complete_and_exit (kernel/kthread.c:341)
> [ 246.264331][ T4096] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [  246.264910][ T4096]  </TASK>
> [  246.265598][ T4096] Kernel Offset: disabled
> [  246.266259][ T4096] Rebooting in 86400 seconds..
> 
> Thank you for taking the time to read this email and we look forward to working with you further.

Carlos, this looks like one for you to puzzle over -
thanks,
Hugh
