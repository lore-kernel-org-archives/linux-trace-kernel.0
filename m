Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3519E97B;
	Mon, 24 Aug 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615362; cv=none; b=leBYjhQ0VNC+KyaKYeerahWOLq4hP/zgR66jt8oAAQ7QFcBmFYMNj00wz1x9E0cqzozr9jtmP4RteSkoUbkuTTr4wcRlI9pGVl/4gbUvFGITtzlxJP39+32KLH1XtWTGOOoMfT99lD2j6/y0DErajOcE0K5e/7KhU0dAdbzZZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615362; c=relaxed/simple;
	bh=Iicg69Pa24xutF3Ij7CR1UluvHEmMCayMPR3Pjan1K8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=N3Qx/DoSKAdHsF25J7peHaZ0IRCN5CpL9NLasiHKOT7Zfhur9OhnWJF/303kpPDqp04PtlcxSBeIWfJSYYydBzYj3l5agVDFrmReoaJav2jTz0Rq0qtb/k8E0ZH6N/Ao6EACGC/ussLi6lLdaFX/p7fh8w31oGJcxriS/J6PALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=dcFRVRvT; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="dcFRVRvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787615350;
	bh=rxS0vaUj21lOVXJXLyomEgd+cXA8gXGJXeX+NP6ISR8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dcFRVRvTbMN8vCFPGGg4dPSPDIevNx4g4ncOziENOjyKk+guOmlADNk3I61g/67Fi
	 +j7zewFHid62LY6c4Gt0glmrGf+36bowIXzP4XLyPIxnUsNOYrhQ61j/QLQwt9Y/j9
	 zBMzz/LZgfL1HzRikopJgEQDAvfuidN5NR5ebzEE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hTSLG2NsRz10vp;
	Mon, 24 Aug 2026 23:49:10 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hTSLF6CPcz10vc;
	Mon, 24 Aug 2026 23:49:09 +0000 (UTC)
Date: Tue, 25 Aug 2026 00:49:08 +0100
From: Bradley Morgan <include@grrlz.net>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 rostedt@goodmis.org, mhiramat@kernel.org
CC: mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_tracing/user=5Fevents=3A_Clear_co?=
 =?US-ASCII?Q?pied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <7DE87118-1B8B-4B6D-9E7C-6AFC46F6E980@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 August 2026 22:10:37 BST, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>User events keep per-mm tracing state in task_struct::user_event_mm. It
>tracks the registrations and enablers created through the tracefs
>user_events_data interface.
>
>dup_task_struct() starts a fork by copying this pointer from the parent.
>user_events_fork() must then either share it for CLONE_VM, or create new
>state for a child with a separate address space.
>
>The second case can fail. If user_event_mm_dup() cannot allocate the new
>state or copy one of its enablers, it returns without replacing the
>pointer copied by dup_task_struct(). The child now points at the parent's
>tracing state, but did not take a task reference to it.
>
>When the child exits, user_event_mm_remove() can drop the parent's task
>count to zero and queue its tracing state for release. The next
>user-events registration in the parent calls current_user_event_mm() and
>writes to the freed object.
>
>KASAN reports:
>
>    BUG: KASAN: slab-use-after-free in current_user_event_mm+0x51/0x1d0
>    Write of size 4 at addr ffff888005010d30 by task init/44
>
>    Call Trace:
>     <TASK>
>     kasan_report+0xce/0x100
>     kasan_check_range+0x10f/0x1e0
>     current_user_event_mm+0x51/0x1d0
>     user_events_ioctl+0x82e/0x15c0
>     __x64_sys_ioctl+0x139/0x1c0
>     do_syscall_64+0xce/0x450
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>    Allocated by task 44:
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_cache_noprof+0x180/0x3a0
>     user_event_mm_alloc+0x3c/0x1f0
>     current_user_event_mm+0x88/0x1d0
>
>    Freed by task 42:
>     __kasan_slab_free+0x43/0x70
>     kfree+0x13a/0x390
>     process_one_work+0x696/0xf90
>     worker_thread+0x420/0xba0
>
>Clear the child's copied user_event_mm before starting the fallible
>duplication. If duplication fails, the child has no user-events tracing
>state to release. The CLONE_VM case remains unchanged because
>user_events_fork() explicitly installs the shared pointer and increments
>its task count.
>
>Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
>Assisted-by: Codex:gpt-daybreak-blue
>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
> include/linux/user_events.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/linux/user_events.h b/include/linux/user_events.h
>index 57d1ff0..2c9ac7b 100644
>--- a/include/linux/user_events.h
>+++ b/include/linux/user_events.h
>@@ -48,6 +48,7 @@ static inline void user_events_fork(struct task_struct *t,
> 		return;
> 	}
> 
>+	t->user_event_mm = NULL;


I had a think about this, I really feel this is okay.

Knowing me, I made a mistake. Hmmm. Should I do tag?

well.. this can't be wrong, it's a one liner, and a acceptable fix for a
bug.

okay, guess this works.

Reviewed-by: Bradley Morgan <include@grrlz.net>

Comment?, wait, no not really needed. Its small, and easy 

(Sorry, I think Out loud sometimes)


> 	user_event_mm_dup(t, old_mm);
> }
> 
>

Thanks!
