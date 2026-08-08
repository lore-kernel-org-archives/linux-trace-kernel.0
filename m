Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4B2EB0F;
	Sat,  8 Aug 2026 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215542; cv=none; b=eswhreqyDeEmpvmGk++nIRjwCDGSNdRhNLD0aYmUwHX/temsTdBCKJJiiKBN5CBE/tDi8goidvyYFQJ40RmW/E60ju5QPaNV+Pp/J58Zb9fI7vvIaIgsZIr6DzthN2XstHzJLzwS9vDQ12cUgXuREDfPebgyIdsEQ6N67eDVo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215542; c=relaxed/simple;
	bh=X4BvETNwkvl8hykdw2suaqElYpjB4OrLIs7c1JCwi7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sp47UV0I+O6DjA7Vl25b5k+RlEk6VyTdebp2bUQPidfG1XuavJPvdqfnIwX4uZpJgtUFzZ/FgSFAvA0byu1FEe16RgqE8wrsSYFaW18Gl9HRu5VmpzMMcCSVttc1DkPSYhui98BodouypEEEO8IY7mhGP94doEGRJWSAif9KXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1043EC040A;
	Sat,  8 Aug 2026 18:58:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 235E920032;
	Sat,  8 Aug 2026 18:58:56 +0000 (UTC)
Date: Sat, 8 Aug 2026 14:58:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 4/6] ring-buffer: Fix subbuf resize concurrency
Message-ID: <20260808145854.4ff68a39@robin>
In-Reply-To: <20260806211306.3704194-5-vdonnefort@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-5-vdonnefort@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 235E920032
X-Stat-Signature: x1x9h5x9n6qhyqfmyatt6o3j5mfttrxw
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kgKIx9eEIrdoW2z5xOuFSRfb1GMnpIiU=
X-HE-Tag: 1786215536-842995
X-HE-Meta: U2FsdGVkX1+TLTzCp8dXBsRqaotX8jcnobuqTXVn6frV4I9HLJFxKVhqF85LsuY1QGVRZs/b9G+lM93e0LmLQdbtBNmgrZO+kUfcQUFSprpbvmtq1mJLOHqTgSRbMG9I5lmOVUCsUy8JaObV9dykXKeAddzsYi/2KSIr1abYJg2V24K22cII2bJPw34y5jHTfFXTD1JKFaLhfTtZnPTaBZS3im4kmXmre1+/Acut66ToCgUfdXWfN/7tgS/fadf7cmYkwllwOvfIt0tvesJAg2qcClcHGSrSVosA/AY+kT+ymkS0z0nGUAKgYSGe34ZHx+HXli3/DWmrZUpH5vPTBFZPnw55Y0wpmsxDBrYDn7R6H0YYgKco4w==

On Thu,  6 Aug 2026 22:13:04 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> trace_buffer subbuf_size is read lockless in ring_buffer_read_page() and
> ring_buffer_read_start(), while it can simultaneously be resized with
> ring_buffer_subbuf_order_set().
> 
> Instead of trace_buffer::subbuf_size, use bpage::order in
> ring_buffer_read_start() and ring_buffer_read_page().
> 
> In ring_buffer_read_start(), even with resize_disabled, there is still a
> possibility of a race with a buffer modification. Hold the trace_buffer
> mutex to synchronise with any pending ring buffer order modification.
> 
> trace_buffer::subbuf_size is now actually useless, remove it. Also,
> create accessors rb_subbuf_capacity() and rb_page_capacity() which
> return the actual size available for storing events, while
> rb_subbuf_size() returns the actual subbuf page-size.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

In testing a bunch of fixes, This triggered. I haven't proven that this
is the culprit (currently running my tests without this commit) but it
looks to be the only one that touches ring_buffer_discard_commit()
(actually rb_decrement_entry() called by ring_buffer_discard_commit()).

[  441.914171] WARNING: kernel/trace/ring_buffer.c:5049 at ring_buffer_discard_commit+0x3f8/0x440, CPU#3: ftrace-test-eve/4443
[  441.918601] Modules linked in:
[  441.920136] CPU: 3 UID: 0 PID: 4443 Comm: ftrace-test-eve Not tainted 7.2.0-rc6-test-00014-g4940cbedc775-dirty #30 PREEMPT(lazy) 
[  441.924738] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  441.928532] RIP: 0010:ring_buffer_discard_commit+0x3f8/0x440
[  441.930958] Code: 75 fd ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 66 fd ff ff 41 83 e1 1f 41 80 f9 1d 74 2b 44 8b 5b 04 e9 ed fd ff ff f0 ff 47 08 <0f> 0b e9 9b fc ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 11 ff ff ff
[  441.938138] RSP: 0018:ffffcd5681657970 EFLAGS: 00010002
[  441.940410] RAX: 000000004083b000 RBX: ffff8b734083b010 RCX: ffff8b734082b540
[  441.943337] RDX: ffff8b73408a8000 RSI: ffff8b734082b540 RDI: ffff8b734005fc00
[  441.946270] RBP: ffff8b734005fc00 R08: ffff8b734005fc00 R09: 0000000000000000
[  441.949203] R10: 0000000000000003 R11: 0000000000000044 R12: 0000000000000000
[  441.952133] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffbd75cf40
[  441.955056] FS:  00007feb18297780(0000) GS:ffff8b73fe646000(0000) knlGS:0000000000000000
[  441.958428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  441.960886] CR2: 000055e57b946e20 CR3: 0000000111b30006 CR4: 0000000000172ef0
[  441.963855] Call Trace:
[  441.965158]  <TASK>
[  441.966344]  trace_event_buffer_commit+0x222/0x2b0
[  441.968132]  trace_event_raw_event_sched_switch+0x129/0x190
[  441.970070]  __traceiter_sched_switch+0x45/0x60
[  441.971729]  __schedule+0x8e5/0x14c0
[  441.973115]  schedule+0x3d/0x100
[  441.974400]  schedule_timeout+0xca/0x130
[  441.975889]  wait_for_completion+0xa5/0x160
[  441.977438]  synchronize_rcu_normal+0x2c9/0x370
[  441.979083]  ? trace_buffered_event_disable+0x63/0xf0
[  441.980884]  ? trace_function+0x35/0x140
[  441.982355]  ? __pfx_synchronize_rcu_normal+0x10/0x10
[  441.984175]  ? synchronize_rcu_normal+0x5/0x370
[  441.985824]  trace_buffered_event_disable+0x63/0xf0
[  441.987576]  __ftrace_event_enable_disable+0x148/0x2c0
[  441.989395]  try_unregister_trigger.isra.0+0xa9/0x110
[  441.991188]  event_trigger_parse+0xc1/0x1b0
[  441.992748]  trigger_process_regex+0xc3/0x110
[  441.994352]  event_trigger_write+0x7b/0xf0
[  441.995884]  vfs_write+0xd0/0x5a0
[  441.997191]  ? 0xffffffffc0400095
[  441.998507]  ksys_write+0x79/0xf0
[  441.999828]  do_syscall_64+0x7e/0x7d0
[  442.001232]  ? trace_hardirqs_off+0xd/0x30
[  442.002754]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  442.004554] RIP: 0033:0x7feb1832c7d2


static inline void
rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
                   struct ring_buffer_event *event)
{
        unsigned long addr = (unsigned long)event;
        struct buffer_page *bpage = cpu_buffer->commit_page;
        struct buffer_page *start;

        addr &= ~(rb_subbuf_size(cpu_buffer->buffer) - 1);

        /* Do the likely case first */
        if (likely(bpage->page == (void *)addr)) {
                local_dec(&bpage->entries);
                return;
        }
        
        /*
         * Because the commit page may be on the reader page we
         * start with the next page and check the end loop there.
         */
        rb_inc_page(&bpage);
        start = bpage;
        do {
                if (bpage->page == (void *)addr) {
                        local_dec(&bpage->entries);
                        return;
                }
                rb_inc_page(&bpage);
        } while (bpage != start);
        
        /* commit not part of this buffer?? */
        RB_WARN_ON(cpu_buffer, 1);             <<<--- WARNING from this
}

This patch replaced the mask algorithm with the rb_subbuf_size(). If for
some reason it is incorrect, the addr will not match.

Note, this is the first time I ever triggered this warning.

-- Steve

