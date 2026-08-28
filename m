Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE305665
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924312; cv=none; b=NumShQqjyfnJOY1pc0xWvxLnOQblRJ7BoeGaTiy1nMbVn2nP/k4OHT99pvMfRCtdkDBdYZYo8maLOSTEZP3naXxc3K+uHFlpPyUHlBPNajYCkxOJPKVYX6rzuErZwg5AvLG3Yf7DqPh3eN9bfNpLUMMRwIgl4U0Ny0TjB9UZzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924312; c=relaxed/simple;
	bh=bZIcryuqgKH2QpGH3EyR5/6FKyZ7NERRqqhYQ39IIBc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rWcLS/eGJO3Kk07V8dgNEezdRY7WpIlLmgRx/YZ5VySQo81J6IrOVMJZkXOONNYHeoTrO1q4UwJpoYpJdt/twwIolPQ/PI4rAO593zwjjcPHjuXMrZ3lFo+dlfmtAHA0qZcA/QZuTCsn3qVu+0NoIjPKurRPFrvZsDRjHlEbH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BnKsnFdk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BnKsnFdk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=G2zFElECW2KsXla8WnlGyD9i77bDEEqVeEafyitFMYM=; b=BnKsnFdkNKR12e9tT9MlH033Zm
	JFsrsNc6SV8GJToeVwfr2M7VayPdkeTQFCI3qiMtQb2pKrF7PRElG+HWzL5Sq1JKVG5tgRxZo5TLI
	gdkOreyDxQ38i+H35uGu5FIvnQObO5DfrsTFyWYZYKaV95ClJC6FYUIZAKA00pL94Mb39KEwxijbq
	ZdrilUPMtmFVFuYBtRmp83GCfXZyP19hi4cxnn8/6MLthlAA6qmnIUQcKNnYDFjbyTO2iCVu0c/8N
	xiRa+cQS0H4/DLOmg9YoznyTzDp6crOW27Tt7Dv4+/BOsUsqwy+Ixcm/B+UL5T0PHoRsiTLpknDwz
	SQEUZYoQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzwmj-00GoLU-1L;
	Fri, 28 Aug 2026 13:38:21 +0000
Date: Fri, 28 Aug 2026 06:38:17 -0700
From: Breno Leitao <leitao@debian.org>
To: rostedt@goodmis.org, mark.rutland@arm.com, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: ftrace: UAF in ftrace_regex_open() on a removed tracing instance
Message-ID: <apGORjltZgAiAYHT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: leitao

I am seeing some UAF KASAN issue on ftrace in Meta prod, and I think
I got a reproducer that works ok.

 BUG: KASAN: slab-use-after-free in ftrace_regex_open+0x50/0x770
  Read of size 8 at addr ffff00097627f418 by task stress-ng-fanot/1811644

  CPU: 22 UID: 0 PID: 1811644 Comm: stress-ng-fanot Kdump: loaded Tainted: G            E       7.2.0-next-20260827upstream #2
  PREEMPT(full)
  Call trace:
   show_stack+0x20/0x38 (C)
   __dump_stack+0x28/0x38
   dump_stack_lvl+0x74/0xa8
   print_report+0xd8/0x250
   kasan_report+0x98/0xf8
   __asan_report_load8_noabort+0x20/0x30
   ftrace_regex_open+0x50/0x770
   ftrace_filter_open+0x44/0x58
   do_dentry_open+0x308/0xd20
   vfs_open+0x44/0x280
   dentry_open_nonotify+0x68/0xc0
   fanotify_read+0x5c0/0x1d78
   vfs_read+0x198/0x6f0
   ksys_read+0xbc/0x168
   __arm64_sys_read+0x88/0xa8
   invoke_syscall+0x74/0x188
   do_el0_svc+0x108/0x190
   el0_svc+0x64/0x260
   el0t_64_sync_handler+0x68/0xe0
   el0t_64_sync+0x198/0x1a0

  Allocated by task 1808767:
   kasan_save_track+0x30/0x68
   kasan_save_alloc_info+0x40/0x50
   __kasan_kmalloc+0x84/0xa0
   __kmalloc_cache_noprof+0x2b4/0x588
   ftrace_allocate_ftrace_ops+0x84/0x148
   trace_array_create_systems+0x470/0x13e8
   instance_mkdir+0xcc/0x118
   tracefs_syscall_mkdir+0xa0/0xf0
   vfs_mkdir+0x2a0/0x3d8
   filename_mkdirat+0x1c4/0x368
   __arm64_sys_mkdirat+0xa4/0x198
   invoke_syscall+0x74/0x188
   do_el0_svc+0x108/0x190
   el0_svc+0x64/0x260
   el0t_64_sync_handler+0x68/0xe0
   el0t_64_sync+0x198/0x1a0

  Freed by task 1812034:
   kasan_save_track+0x30/0x68
   kasan_save_free_info+0x54/0x70
   __kasan_slab_free+0x58/0x88
   kfree+0x194/0x6b0
   ftrace_destroy_function_files+0x5c/0x90
   __remove_instance+0x424/0xa68
   instance_rmdir+0xb8/0xf8
   tracefs_syscall_rmdir+0x84/0xf8
   vfs_rmdir+0x18c/0x458
   filename_rmdir+0x1a0/0x310
   __arm64_sys_unlinkat+0xb0/0x1c0
   invoke_syscall+0x74/0x188
   do_el0_svc+0x108/0x190
   el0_svc+0x64/0x260
   el0t_64_sync_handler+0x68/0xe0
   el0t_64_sync+0x198/0x1a0

  The buggy address belongs to the object at ffff00097627f400
   which belongs to the cache kmalloc-512 of size 512
  The buggy address is located 24 bytes inside of
   freed 512-byte region [ffff00097627f400, ffff00097627f600)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9f6278
  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  flags: 0x5ffff0000000040(head|node=0|zone=2|lastcpupid=0x1ffff)
  page_type: f5(slab)
  raw: 05ffff0000000040 ffff000080008c80 dead000000000100 dead000000000122
  raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
  head: 05ffff0000000040 ffff000080008c80 dead000000000100 dead000000000122
  head: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
  head: 05ffff0000000003 fffffdffe5d89e01 00000000ffffffff 00000000ffffffff
  head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff00097627f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff00097627f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffff00097627f400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                              ^
   ffff00097627f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff00097627f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ==================================================================


Reproducer
----------

Needs root and CONFIG_KASAN=y, CONFIG_FANOTIFY=y, CONFIG_DYNAMIC_FTRACE=y.
It is deterministic and fires on the first read():

It seems it was introduced by 591dffdade9f ("ftrace: Allow for function
tracing instance to filter functions") in v3.15, so all stable trees are
affected. A fix is attached.

Thanks,
Breno

---
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/fanotify.h>
#include <sys/stat.h>

#define TRACEFS  "/sys/kernel/tracing"
#define INSTANCE TRACEFS "/instances/uaf"
#define TARGET   INSTANCE "/set_ftrace_filter"

int main(void)
{
	char buf[4096];
	int fan, fd;

	fan = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
	if (fan < 0)
		return perror("fanotify_init"), 1;
	if (fanotify_mark(fan, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_OPEN,
			  AT_FDCWD, TRACEFS) < 0)
		return perror("fanotify_mark"), 1;

	rmdir(INSTANCE);
	if (mkdir(INSTANCE, 0755) < 0)
		return perror("mkdir"), 1;

	/* Queues an event; fanotify does path_get() on the file. */
	fd = open(TARGET, O_RDONLY);
	if (fd < 0)
		return perror(TARGET), 1;
	close(fd);

	/* Frees tr->ops while fanotify still pins the path. */
	if (rmdir(INSTANCE) < 0)
		return perror("rmdir"), 1;

	/* create_fd() -> dentry_open_nonotify() -> ftrace_filter_open(). */
	if (read(fan, buf, sizeof(buf)) < 0)
		perror("read");

	return 0;
}

