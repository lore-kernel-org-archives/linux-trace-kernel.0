Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6962C3768;
	Thu,  6 Aug 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021114; cv=none; b=UJf1rjXCvGE/1fPuKNGfPWGrCRW+HHeHK/sOUQGTTnbtW5po/TVoIvVK35po88VIyjrP7Zm9XP+u+2R2iN/rSehldZYanKhW6lpmaw6N17kFSxXBaT4h6VGpXzaB1dGbZyD/Sqr/PQEWm5kqFDdaPP8p8eNpUmSmjh+ANLBujN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021114; c=relaxed/simple;
	bh=t+hXEegpOqgVm5F8/JKQzgC1+MS4e8Jwyl2OCPfXrGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkr7dj+xR8k/xgc0z/8t5Abz3hXAl1YKwvai4msbVXX3gi03Kl7cwcFIx8MVqoFgYhfaZbT5ZN4eOfRTRXBr1EXaw7pioxz47TRjNzXYYNGJ6Py1DJrBHphFFISmlfiJyL/OYSQfT7by8pDEuc3CVuSBTP2eSGigBuOCCoJT7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 95AB6C05EA;
	Thu,  6 Aug 2026 12:58:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id AA91420028;
	Thu,  6 Aug 2026 12:58:28 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:58:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: slab-use-after-free Read in
 ring_buffer_iter_advance
Message-ID: <20260806085828.3652b5f0@gandalf.local.home>
In-Reply-To: <6a7137d1.40259c87.584f4.04ab.GAE@google.com>
References: <6a7137d1.40259c87.584f4.04ab.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nrw5ej4s1e4aufpe63j6dmhyw7bioe3e
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: AA91420028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX185dbVDICUNT8e67SfQU2be7FkLnYzIdU0=
X-HE-Tag: 1786021108-847306
X-HE-Meta: U2FsdGVkX1/zAUR1eXW9mcPhNZruUdZm0T55krUju0Ztn0Illqa23DHQlUu8LiVzhEf0iAk6P8HBEXq3vVVVTtv5pqFDMXZHBl4uXiwGQN78++MFaUTwStSt5wvxN9IfhXPyTnOaXJs4rr1DSucHN76bb/gZXxcUZqMAoL852KE3lSsuaS3fu8SSr7hEL6ZdYwImF6km+MmiaSErXPN9vcyXqrWP2xO9CvR0K3BpTNHWpWdr7YDV/dSixFQAJV7qMLIWUa5pXi1ZxmTD4R2+db71shpObi6veX7TNIwMHDNUfE1IinLP4YZNGVvUiY2DV2725x5k7R0xvjpPAaFhbqgigKO2j3EyKQrtq2o6AtJXXEkYaXQblm15v0vzUFYv

On Mon, 03 Aug 2026 17:52:33 -0700
syzbot <syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com> wrote:

> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com

This is a legitimate bug.

> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in rb_page_size kernel/trace/ring_buffer.c:391 [inline]
> BUG: KASAN: slab-use-after-free in rb_advance_iter+0x40e/0x460 kernel/trace/ring_buffer.c:6024
> Read of size 8 at addr ffff88802d79b8b8 by task syz.4.389/6869
> 
> CPU: 0 UID: 0 PID: 6869 Comm: syz.4.389 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> Call Trace:
>  <TASK>

>  rb_page_size kernel/trace/ring_buffer.c:391 [inline]
>  rb_advance_iter+0x40e/0x460 kernel/trace/ring_buffer.c:6024
>  ring_buffer_iter_advance+0x69/0x90 kernel/trace/ring_buffer.c:6445

The iterator is updated under the raw cpu_buffer reader lock.

> 
> Freed by task 6871:
>  kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:78
>  kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2677 [inline]
>  slab_free mm/slub.c:6377 [inline]
>  kfree+0x22b/0x6c0 mm/slub.c:6692
>  free_buffer_page kernel/trace/ring_buffer.c:399 [inline]
>  ring_buffer_subbuf_order_set+0x116b/0x18a0 kernel/trace/ring_buffer.c:7439

The pages are removed from the visible reader list onto a temporary link
list under the raw cpu_buffer reader lock.

After the reader lock is released, the list is then freed. No reader should
have access to any of these items as they were only visible under the
reader_lock.

The bug is that the ring buffer iterator keeps state! It can still have a
pointer to a sub-buffer that has been freed. When another read happens, it
may have a stale pointer.

The fix is to add some state to the cpu_buffer for when it frees pages so
that the next read from the iterator will reset its state.

I'll have to address this when I get some time.

Thanks,

-- Steve
