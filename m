Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBC1DDA18
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348470; cv=none; b=fSZf6yWgyZygr6476GrZAI92woIMYbayPSB2/wZmZ178fMGmuDyN9VXTEa8oV6aw5v/CmjVO9O/ljs5s4Fc6CXufbLXKto9i6rmv9RKk2yHOXi60C1p+TaK7PzC4zHj6xEIz+OQB91ymBO33DVVyH9kK2nhPllaJZ+9pXEURpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348470; c=relaxed/simple;
	bh=DZsPznnZGPug8WHwwtFR2mwQWEs4hPM0mWllMfq+YyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdbOZ1RpeVPtSCf6Xf8mg96f4GsxKtjZzmzDcFGCKQyY9Maicm/g7b4p437daYxn8auILZdsN5QnOe8zXCAs26EDZlNSbYG1QKDON3DgkqBwZ5vrcO4WkHghF/nVDnPGpj0AfBJnXmim/DdoeTZ2aORW7obEhFxSA7VuheNL24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xl0+xBal; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xl0+xBal"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47db714766aso2324071f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786348467; x=1786953267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Uv3nXN9Kn89/2ULXr9a73JHriK4BiyXMcLCwXwd/fM=;
        b=Xl0+xBal1FU5ayaOwX/bXcxPYb8Limt/SzuhhYdVpftK6K//FNzM9Ndp8S50mHICEQ
         ZE/JQEQw/sgOCkzOK+tPnrW86EajKMtbM/6DvsZxBc3C9dcPCPrDs5RUWJAAFxWEF+jh
         /+grk7ku5RJQu/FgZeN+oJnl/9Wa+FVJrPLX+2joqNefgohIp6XrVlx1fQ1M7Kw6G7W/
         pPfx4uoOyTWMK623W3zVoDvM+EAanrpYGBMGWs8j8pahfihqNghJorp1IaRp0vt26Kmk
         cEZ9+h+CriBQFVr6sNRsuKdS5Uy9bNaUOqGXJPUevwFQEadPr2JNH6YiJCWH7NWkm/+H
         rYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348467; x=1786953267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Uv3nXN9Kn89/2ULXr9a73JHriK4BiyXMcLCwXwd/fM=;
        b=bQ8/4UwS4Xr8ZipihasDrmwM5zUP6rx5FwIbNU/nBo/+9xNQRPFVg7sIBJ5PaHLrZb
         J8+K/gPxn/9UVuCnsnA/HpUeo3CqyU7PBb0qauwr2QK/blLe5te5DHTep3JSdfIOytZ8
         QYu7GRLbeOqfj7nZ8x1sx19AE1J3Q0J+v9qosNPnoXfMX96xGYrRYCtQ4N4tEv5cfphc
         8YLnxT2GFC2KlNQoi//LlMhX8D86dJRYora/xMhcZjrapKTXQZs9GUhT7JkemUz67L5a
         u6KRqLHiven7fE9y41T9l66herm4FTJ3T56IoYBAMSkVbBms113GeMh846Hl3EOKmBns
         GEXA==
X-Forwarded-Encrypted: i=1; AHgh+RrnQ1GHsjiDC8+CgPxRz48G3/NC+9U66udebdxu6rC2uL0RwFwMvuz1UlZz/tMz0UQ1z5z/qXbk017mQJdd1g4bnOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRU0XCIq5BQQvfdKJq8Y8IIRcujVdIBkULMZ3xBs1aGuMbQo8
	FEwsC3tNoRFphaC7NYvObxwJKrH3GH5yarXBAe1y0WEl4j93NMb47ET4c+OHemXEfQ==
X-Gm-Gg: AR+sD13MJtzBkQiLbFHswpXSSMejK37G9qv3QLQFXU7DTKu0JlTFbV4+/fOVVHeZs8m
	ME1iAOUFml3FCUGIKPb0BkWdOSgOWotZOb2kF8+My36iFyxpaUhg8CFOyrCnyqafA5ACANipdFG
	8WveEOzWKhV0lwHAXeN5FDxmf+dpmmw9yrbLOGiHWn8npu3SGOHcTn1lVXt/Vycvm8OQRPficuK
	UdXFaQAxqiYq6IVX5OVH7xYmI7iGFaloeSpuqGUJvQJAybufUMgJCb86PgpHUqYq4ViitoOfNat
	RkeCzgmJX6v+CAzqtTYZqAW63nmOU2LMe0Nmp5QB0FIfI46TY7Agv5H4M7bBvPPCz9S9igWisGa
	PJE++h9hV8IAT2hE1Oj0uYtS7YHIDlYDGb/CEOY9THLBtvL0Qv2gBIspBQ6BZQKmE4VlXNVtE9F
	ZYOxTiStYl+09cacBwpTTwDvwbY7vqXkDWKEjbFznIL9L0pSEzI0NOw5CuI0KHShwDLsCKLLjAk
	GVLAzQ4KWlhQ29lYEYvkqM26c05MxUO
X-Received: by 2002:a05:6000:428a:b0:47f:e7f9:5251 with SMTP id ffacd0b85a97d-48131927665mr19978287f8f.3.1786348466256;
        Mon, 10 Aug 2026 00:54:26 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145971sm29999794f8f.8.2026.08.10.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:54:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:54:22 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/6] ring-buffer: Fix subbuf resize concurrency
Message-ID: <anmDrhrSLQI3jAMI@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-5-vdonnefort@google.com>
 <20260808145854.4ff68a39@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808145854.4ff68a39@robin>

On Sat, Aug 08, 2026 at 02:58:54PM -0400, Steven Rostedt wrote:
> On Thu,  6 Aug 2026 22:13:04 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > trace_buffer subbuf_size is read lockless in ring_buffer_read_page() and
> > ring_buffer_read_start(), while it can simultaneously be resized with
> > ring_buffer_subbuf_order_set().
> > 
> > Instead of trace_buffer::subbuf_size, use bpage::order in
> > ring_buffer_read_start() and ring_buffer_read_page().
> > 
> > In ring_buffer_read_start(), even with resize_disabled, there is still a
> > possibility of a race with a buffer modification. Hold the trace_buffer
> > mutex to synchronise with any pending ring buffer order modification.
> > 
> > trace_buffer::subbuf_size is now actually useless, remove it. Also,
> > create accessors rb_subbuf_capacity() and rb_page_capacity() which
> > return the actual size available for storing events, while
> > rb_subbuf_size() returns the actual subbuf page-size.
> > 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> In testing a bunch of fixes, This triggered. I haven't proven that this
> is the culprit (currently running my tests without this commit) but it
> looks to be the only one that touches ring_buffer_discard_commit()
> (actually rb_decrement_entry() called by ring_buffer_discard_commit()).
> 
> [  441.914171] WARNING: kernel/trace/ring_buffer.c:5049 at ring_buffer_discard_commit+0x3f8/0x440, CPU#3: ftrace-test-eve/4443
> [  441.918601] Modules linked in:
> [  441.920136] CPU: 3 UID: 0 PID: 4443 Comm: ftrace-test-eve Not tainted 7.2.0-rc6-test-00014-g4940cbedc775-dirty #30 PREEMPT(lazy) 
> [  441.924738] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [  441.928532] RIP: 0010:ring_buffer_discard_commit+0x3f8/0x440
> [  441.930958] Code: 75 fd ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 66 fd ff ff 41 83 e1 1f 41 80 f9 1d 74 2b 44 8b 5b 04 e9 ed fd ff ff f0 ff 47 08 <0f> 0b e9 9b fc ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 11 ff ff ff
> [  441.938138] RSP: 0018:ffffcd5681657970 EFLAGS: 00010002
> [  441.940410] RAX: 000000004083b000 RBX: ffff8b734083b010 RCX: ffff8b734082b540
> [  441.943337] RDX: ffff8b73408a8000 RSI: ffff8b734082b540 RDI: ffff8b734005fc00
> [  441.946270] RBP: ffff8b734005fc00 R08: ffff8b734005fc00 R09: 0000000000000000
> [  441.949203] R10: 0000000000000003 R11: 0000000000000044 R12: 0000000000000000
> [  441.952133] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffbd75cf40
> [  441.955056] FS:  00007feb18297780(0000) GS:ffff8b73fe646000(0000) knlGS:0000000000000000
> [  441.958428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  441.960886] CR2: 000055e57b946e20 CR3: 0000000111b30006 CR4: 0000000000172ef0
> [  441.963855] Call Trace:
> [  441.965158]  <TASK>
> [  441.966344]  trace_event_buffer_commit+0x222/0x2b0
> [  441.968132]  trace_event_raw_event_sched_switch+0x129/0x190
> [  441.970070]  __traceiter_sched_switch+0x45/0x60
> [  441.971729]  __schedule+0x8e5/0x14c0
> [  441.973115]  schedule+0x3d/0x100
> [  441.974400]  schedule_timeout+0xca/0x130
> [  441.975889]  wait_for_completion+0xa5/0x160
> [  441.977438]  synchronize_rcu_normal+0x2c9/0x370
> [  441.979083]  ? trace_buffered_event_disable+0x63/0xf0
> [  441.980884]  ? trace_function+0x35/0x140
> [  441.982355]  ? __pfx_synchronize_rcu_normal+0x10/0x10
> [  441.984175]  ? synchronize_rcu_normal+0x5/0x370
> [  441.985824]  trace_buffered_event_disable+0x63/0xf0
> [  441.987576]  __ftrace_event_enable_disable+0x148/0x2c0
> [  441.989395]  try_unregister_trigger.isra.0+0xa9/0x110
> [  441.991188]  event_trigger_parse+0xc1/0x1b0
> [  441.992748]  trigger_process_regex+0xc3/0x110
> [  441.994352]  event_trigger_write+0x7b/0xf0
> [  441.995884]  vfs_write+0xd0/0x5a0
> [  441.997191]  ? 0xffffffffc0400095
> [  441.998507]  ksys_write+0x79/0xf0
> [  441.999828]  do_syscall_64+0x7e/0x7d0
> [  442.001232]  ? trace_hardirqs_off+0xd/0x30
> [  442.002754]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  442.004554] RIP: 0033:0x7feb1832c7d2
> 
> 
> static inline void
> rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
>                    struct ring_buffer_event *event)
> {
>         unsigned long addr = (unsigned long)event;
>         struct buffer_page *bpage = cpu_buffer->commit_page;
>         struct buffer_page *start;
> 
>         addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
> 
>         /* Do the likely case first */
>         if (likely(bpage->page == (void *)addr)) {
>                 local_dec(&bpage->entries);
>                 return;
>         }
>         
>         /*
>          * Because the commit page may be on the reader page we
>          * start with the next page and check the end loop there.
>          */
>         rb_inc_page(&bpage);
>         start = bpage;
>         do {
>                 if (bpage->page == (void *)addr) {
>                         local_dec(&bpage->entries);
>                         return;
>                 }
>                 rb_inc_page(&bpage);
>         } while (bpage != start);
>         
>         /* commit not part of this buffer?? */
>         RB_WARN_ON(cpu_buffer, 1);             <<<--- WARNING from this
> }
> 
> This patch replaced the mask algorithm with the rb_subbuf_size(). If for
> some reason it is incorrect, the addr will not match.
> 
> Note, this is the first time I ever triggered this warning.
> 
> -- Steve
> 

This is probably the issue.

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c2cbdb3ef727..a64cdc925078 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3534,7 +3534,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
 {
        unsigned long addr = (unsigned long)event;
 
-       addr &= rb_subbuf_size(cpu_buffer->buffer) - 1;
+       addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;
 
        return addr - BUF_PAGE_HDR_SIZE;
 }
@@ -4123,7 +4123,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
        new_index = rb_event_index(cpu_buffer, event);
        old_index = new_index + rb_event_ts_length(event);
        addr = (unsigned long)event;
-       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
+       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
 
        bpage = READ_ONCE(cpu_buffer->tail_page);
 
@@ -5033,7 +5033,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
        struct buffer_page *bpage = cpu_buffer->commit_page;
        struct buffer_page *start;
 
-       addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);
+       addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
 
        /* Do the likely case first */
        if (likely(bpage->page == (void *)addr)) {


I will resend a V3 dropping the 3 first patches you have applied already.

-- 
Vincent
