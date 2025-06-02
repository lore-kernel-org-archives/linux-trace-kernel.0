Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA681B81DC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Jun 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878033; cv=none; b=SSiIrNH7iMVbPXlDT87K3SfzCrV5vCMxvad1lbgwh/mANXPbv5KtikfZsimeJzxdMdCtxtTNtbksJ2PojH6ZKbHV7shTOEPfUCmDDN7S/5jc0Sa+J/EH+cyx1lsFQb6vM+pnkQRLF0QhRZRjGiN3wAqkrJ2gwKsKhWGdAe6C95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878033; c=relaxed/simple;
	bh=tf4TQ88PTGiQMw5dgY+4bSamtrdvDL3i7GQqhfE7bIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1q5c2YUkC2p8BZa8E08I5ImwJH2a3zwUZSD5LiknF1t8UnO6tvNzGgZo5SaVZup36eC+Ul55fDxro1en+wGQjKlaXG7Cq2ATiSjM20QZHMdqd657Bh60wbm85BVVxrNiwrdxZX7+0CfkuHs4XRAqW5qdVIcBzNryF2L38caEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5438AC4CEF2;
	Mon,  2 Jun 2025 15:27:12 +0000 (UTC)
Date: Mon, 2 Jun 2025 11:28:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 yebin10@huawei.com
Subject: Re: [PATCH v3 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
Message-ID: <20250602112823.4a83daa1@gandalf.local.home>
In-Reply-To: <20250529111955.2349189-2-yebin@huaweicloud.com>
References: <20250529111955.2349189-1-yebin@huaweicloud.com>
	<20250529111955.2349189-2-yebin@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 19:19:54 +0800
Ye Bin <yebin@huaweicloud.com> wrote:

> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> BUG: unable to handle page fault for address: ffffffffc05d0218
> PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
> Oops: Oops: 0000 [#1] SMP KASAN PTI
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> RIP: 0010:sized_strscpy+0x81/0x2f0
> RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
> RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
> RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
> R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
> R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
> FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ftrace_mod_get_kallsym+0x1ac/0x590
>  update_iter_mod+0x239/0x5b0
>  s_next+0x5b/0xa0
>  seq_read_iter+0x8c9/0x1070
>  seq_read+0x249/0x3b0
>  proc_reg_read+0x1b0/0x280
>  vfs_read+0x17f/0x920
>  ksys_read+0xf3/0x1c0
>  do_syscall_64+0x5f/0x2e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Above issue may happens as follow:
> (1) Add kprobe trace point;
> (2) insmod test.ko;
> (3) Trigger ftrace disabled;
> (4) rmmod test.ko;
> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
> ftrace_mod_get_kallsym()
> ...
> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> ...
> 
> As ftrace_release_mod() judge 'ftrace_disabled' is true will return,
> and 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no
> chance to release. Therefore, this also causes residual resources to
> accumulate. To solve above issue, unconditionally clean up'mod_map'.
> Of course, the root cause of this problem is the presence of
> ftrace_disabled. The fixes tags patch introduces the possibility of
> residual resources in the case of ftrace_disabled. The root cause of
> the problem is ftrace_disabled. This patch only adds protection when
> ftrace_disabled occurs.
> 

I've updated the above change log to state the below. It adds a bit more
details about what exactly went wrong:

-- Steve


The following issue happens with a buggy module:

BUG: unable to handle page fault for address: ffffffffc05d0218
PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
RIP: 0010:sized_strscpy+0x81/0x2f0
RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ftrace_mod_get_kallsym+0x1ac/0x590
 update_iter_mod+0x239/0x5b0
 s_next+0x5b/0xa0
 seq_read_iter+0x8c9/0x1070
 seq_read+0x249/0x3b0
 proc_reg_read+0x1b0/0x280
 vfs_read+0x17f/0x920
 ksys_read+0xf3/0x1c0
 do_syscall_64+0x5f/0x2e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The above issue may happen as follows:
(1) Add kprobe tracepoint;
(2) insmod test.ko;
(3)  Module triggers ftrace disabled;
(4) rmmod test.ko;
(5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
ftrace_mod_get_kallsym()
...
strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
...

The problem is when a module triggers an issue with ftrace and
sets ftrace_disable. The ftrace_disable is set when an anomaly is
discovered and to prevent any more damage, ftrace stops all text
modification. The issue that happened was that the ftrace_disable stops
more than just the text modification.

When a module is loaded, its init functions can also be traced. Because
kallsyms deletes the init functions after a module has loaded, ftrace
saves them when the module is loaded and function tracing is enabled. This
allows the output of the function trace to show the init function names
instead of just their raw memory addresses.

When a module is removed, ftrace_release_mod() is called, and if
ftrace_disable is set, it just returns without doing anything more. The
problem here is that it leaves the mod_list still around and if kallsyms
is called, it will call into this code and access the module memory that
has already been freed as it will return:

  strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);

Where the "mod" no longer exists and triggers a UAF bug.

