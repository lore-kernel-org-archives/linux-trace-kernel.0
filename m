Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4021381EA7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789179040; cv=none; b=BYmrc9TTbbnI02LIFe5ofEjebj8++ruiz9Ts1/kvZCJiAQs8hkxADQNabcCeFAHe+5SbHCkd/uG2fK7eOUpTxhSCD98wf/cmfegZSErIl0RmSEFwes7Q5Tlgvsj2//Jptb6w36pvrKmpfmV5hrZnl7N17C5M113ZDu2gUpHXFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789179040; c=relaxed/simple;
	bh=8A3oLo8LuuTSCijHhNkQBPtxwm3NAZCSJkKadgMSfTw=;
	h=From:Message-ID:Date:Subject:To:Cc:MIME-Version:Content-Type; b=XaiUGxsTVVNG5Z2VlxQAR8CqrFg0Hb/Css81Qu+7js3gjQSHBTFZ0kJ+iqBsyipkE5K3ePGHjAC3jZd5aIbpjqPAlJgvWit9tNgtsvQKfAN3TXUDSDLkDjZcozKiUDxR2VZ7erfRe8pjBCm5VpX7sI0JJOYty+b3MAkFCo0G4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=UOwQAL8M; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=g+IcSL6t; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="UOwQAL8M";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="g+IcSL6t"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1789179037; x=1789783837; bh=HCVJT/QjQELAeWV+pY
	JmoNACy+thGG2HLHwQvJ9TMgw=; b=UOwQAL8MIkWP4LNPV7M22MTthPhVuIGyqwCBEirTQMRCA
	++Bw2Pb1mqr7Jco25jIsBSYWRzVHL9La/1C30WFefsFLWaxQFupWuuCPuYNdyD2wGHmAnvRrHWJ
	Oo9/mEXBUc21MLy3tM3EG3QWkYnaTgZjFyo4fDPxlMmfJ7ngLfwZfTyvXJxPVkr1uYrrexEvAma
	MG5Ra8YqqLxHArtvwn1KbNMSRNv0cQp7IrZ9EyF6Sm2adP4Rnj54RUL59Sw8mOvNRegrS4U+EmM
	CONKl0hilxADTmgknYFHjS7UZZ4S+3QO5zg8IBKRD1jXTWWPrYfxixigzCGAex2QPEciH1UQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1789179037; x=1789783837; bh=HCVJT/QjQELAeWV+pY
	JmoNACy+thGG2HLHwQvJ9TMgw=; b=g+IcSL6t3c1XiHX+ApVQQumDBKGq3dIdhb9kOc0c/ZXh5
	foF8n41xLID13G3DpluqG7nnA3d7JUqjN1dmZi9mew28dARgkE30Do3ASEEt4FBTNtFfCtw9+3e
	Z6uamHx4gz6KbLEGQx+hgoLCuVkAbK7fETIuwvzHLvJkzQ2lROfRcCIOzjNAXV9ctL8ofCGjfr8
	4RL2xORG3TsSC9icdFQ6X1b7l9YSX107I13JwFu1pDLQdS4bgXi/4cw6evMCBLp/cA4GH4Hjf6U
	IuheJo+FkAF7JjfTXzS62c8TEd2QgwT6YI1QYl51uI/oAMQ9tGgDIXwtrDLD8P5FQbSy674Q==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+832991690fed76cd@bugs.sh>
Message-ID: <hCFYOQWUB1gK6CIQOmWL42dTo2SQRG5Iw3ko@bugs.sh>
Date: Sat, 12 Sep 2026 02:10:31 +0000
Subject: [BUG] kernel/trace: use-after-free in trace_event_probe_cleanup()
To: linux-trace-kernel@vger.kernel.org, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Beau Belgrave" <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org, co <co+832991690fed76cd@bugs.sh>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a bug report, not a patch submission.

We found a bug reachable in:

    path    trace/trace_events_user.c`, `kernel/trace
    crash   use-after-free in trace_event_probe_cleanup()
    commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/trace/linux-trace")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you fix this bug, this tag credits the report and lets us
    close it on our side:

Reported-by: co+832991690fed76cd@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an unreviewed LLM-generated analysis and candidate
    patch. The same reproducer panics the unpatched kernel and runs
    clean with that patch applied. Use it as a starting point, or ignore
    it and write your own:

        patch.diff  https://bugs.sh/b/832991690fed76cd/patch.diff
        report.md   https://bugs.sh/b/832991690fed76cd/report.md

    A guide to taking it from here to a sendable patch, including the
    trailers to add: https://bugs.sh/patch.html

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/trace/linux-trace")
    VM setup       https://bugs.sh/b/832991690fed76cd/run.sh
    config         https://bugs.sh/b/832991690fed76cd/config.gz
    poc            https://bugs.sh/b/832991690fed76cd/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in trace_event_probe_cleanup.part.0 (./incl=
ude/linux/trace_events.h:430 kernel/trace/trace_eprobe.c:59)
Read of size 4 at addr ffff8880137e64a8 by task exploit/144
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
trace_event_probe_cleanup.part.0 (./include/linux/trace_events.h:430 kernel=
/trace/trace_eprobe.c:59)
eprobe_dyn_event_release (kernel/trace/trace_eprobe.c:53 kernel/trace/trace=
_eprobe.c:120)
dyn_event_release (kernel/trace/trace_dynevent.c:110)
trace_parse_run_command (kernel/trace/trace.c:9565)
vfs_write (fs/read_write.c:685)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 147:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kmalloc_cache_noprof (./include/linux/kasan.h:263 mm/slub.c:5489)
user_event_parse_cmd (./include/linux/slab.h:988 ./include/linux/slab.h:130=
9 kernel/trace/trace_events_user.c:2133 kernel/trace/trace_events_user.c:10=
35)
user_events_ioctl (kernel/trace/trace_events_user.c:2508 kernel/trace/trace=
_events_user.c:2703)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Freed by task 74:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:=
6692)
destroy_user_event.part.0 (kernel/trace/trace_events_user.c:1525)
delayed_destroy_user_event (kernel/trace/trace_events_user.c:262 kernel/tra=
ce/trace_events_user.c:251)
process_one_work (kernel/workqueue.c:3322)
worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
Last potentially related work creation:
kasan_save_stack (mm/kasan/common.c:57)
kasan_record_aux_stack (mm/kasan/generic.c:556)
insert_work (kernel/workqueue.c:2226)
__queue_work (kernel/workqueue.c:2401)
queue_work_on (kernel/workqueue.c:2452)
user_event_put (./include/linux/workqueue.h:699 ./include/linux/workqueue.h=
:760 kernel/trace/trace_events_user.c:327 kernel/trace/trace_events_user.c:=
265)
delayed_user_event_enabler_put (kernel/trace/trace_events_user.c:408)
process_one_work (kernel/workqueue.c:3322)
worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
The buggy address belongs to the object at ffff8880137e6400
which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 168 bytes inside of
freed 512-byte region [ffff8880137e6400, ffff8880137e6600)


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


