Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481342;
	b=PF4a3foBQLLP6et2ovFkRooIj0r2wMd4Ig+UIZZ2eoQVB70Xz79bO4XC2AgrZ5ydlI4g
	 srtwktyKgQKDCxgqjYeSsTZTngMLulgBMrKlniEBrXiiEURwy9uqV9QP43etw9Dqf2jhQ
	 N2VdIorplCha79ke2eDBl0D51voCZbnMShjHm6ke3iQbOqaTJA6qQNRDm8VOJ3XqGxeIc
	 IiOENauZdJJXqRMqM5EmKy1CnkrHpc2Kt++TRb6anqCXnLR+SgwcO3aBZ53qzc061WcO1
	 S7wrkVIOpwxRAL1ItdJom+g+J7B9Etm9z+6U734nSB7gI7a+UnTXb1NxaetXu3xDRQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481342;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=MLBNurMu74zK5/JLIz4Q/wOK32rcLNUYysfbDLmGV2g=;
	b=x3joWWpLh0fWnE+qS+S5nFAFgdi6RRmRsoeTjjJlgUN3mNEeq4Hq4/Yt2w+5EMY1McU/
	 n8V2Oz96l1JVh8Fc7tJaEHwkJa96EhiU+kadZQierkagvKVD8HtuWwkmDyHz9+qekAlnV
	 m3cggGy4cCzZ0CZNsw6uAoygn+P4iIVVsHfZh7vnaThaWS2asTFrlwcJi6SqvMqwrZp5I
	 MDKK5q/yiFB+TZVHQWrV8Mafrv4/+wBZCxv1EbPj8NWfu7+4mA17L4T//9vWF3CT2TNPV
	 gLNgX5IH/dTDUWtvSt0cqoIL9Flh0X1NkAvHE0d0kk3jAt5MXclywVWtxjuVArY0ZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bn3plYk3;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6E606A31C;
	Thu, 12 Nov 2026 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bn3plYk3
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 189181A0578;
	Thu, 12 Nov 2026 11:02:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1051817;
	Thu, 12 Nov 2026 11:02:03 +0000 (UTC)
Date: Thu, 12 Nov 2026 06:01:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Haoli Zhang <26031212468@stu.xidian.edu.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com,
 25031212117@stu.xidian.edu.cn, byu@xidian.edu.cn
Subject: Re: [PATCH v3] tracing: ring-buffer: serialize shrink with NMI
 readers
Message-ID: <20261112060150.7fd677dd@fedora>
In-Reply-To: <20261111094301.2213435-1-26031212468@stu.xidian.edu.cn>
References: <20261111094301.2213435-1-26031212468@stu.xidian.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1051817
X-Rspamd-Server: rspamout08
X-Stat-Signature: fhpjrxe8kmbwb3xdu9weo6rn7u1qogrw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19KuSRyjj3kZpinHmEmz+io+tglLFQ+FAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=MLBNurMu74zK5/JLIz4Q/wOK32rcLNUYysfbDLmGV2g=; b=bn3plYk3IC7ItRvnIkgmewWwoX0KtH2W9haKSrVSk7Kuplm6BfLU8UL9pLJuJce0CoFliirNDQDgMNYutpTvgXznjXCjjLqpgekdsLJVGq9OS9HGecz3O4Dc70p4vR+pIfDrwGE7ToHrPUtHUCtxmTGIQVornAZwERoABjKqdKA=
X-HE-Tag: 1794481323-159622
X-HE-Meta: U2FsdGVkX18tIA76OVX8a94CzBM4AXHoOGr+hqgE9+rKzeFBwL7B3whDbiFdoP/6l42mfRkfZFXlblnMtsjH9xLZVlC91Sb3UDVl8ZO4ZQ5Gn3xMwEpHjV9hoFBGvf7Bx+X7uWZ95O4Idg5EieqYFd3e7byoZw/KqjaqIfbwkFiJ5kpG54+6MQZWC+MdUvNS/v6gwK1AKQJRSsLZ4fONeMEW967MjpxYLp1AkLlF1mdqcH0WyfR/tFZ+RoCr7Q5mp6WeYzultPZkNLCv2QxksIklZxKxX7zbpsN9ypEQvmG5Kve0lWpDDBZlO7/Qm0U4MFZWB3wmckI/kCTwkw6s5JqW1WAf8K7EyIjQSa0ZbDQrJlHPv8xtl3ByqrOCvF8m3DxfqfgpK84yObQIo+t8AoQ/7G6qrH1xqcAaiW2PQL+jPKT3bgLJgCrRWGxKXefY

On Wed, 11 Nov 2026 17:43:01 +0800
Haoli Zhang <26031212468@stu.xidian.edu.cn> wrote:

> The syzbot report shows a use-after-free in rb_is_reader_page(), reached
> from rb_move_tail(), with the freed page released by rb_remove_pages().
> Source inspection suggests that a detached reader page can retain a link
> into the range removed during a shrink. This patch addresses that possible
> stale-link path and coordinates NMI readers with page removal.
> 
> When an NMI reader cannot acquire reader_lock, rb_reader_lock() falls back

What NMI readers?

The only time NMI reads the ring buffer is on a crash

> to reading the ring buffer without the lock. Gate lockless NMI readers

Yes, it reads without a lock because the system crashed and the NMI
handler is doing a *BEST EFFORT* to read the ring buffer to see if it
can produce output that tells us why the system crashed.

> while rb_remove_pages() removes pages. Drain readers that entered before
> the gate before changing the page list. New NMI readers that cannot acquire
> reader_lock while the gate is closed skip that CPU. Readers that acquire
> reader_lock remain serialized by it. The drain loop calls cond_resched()
> while waiting for readers to exit.
> 
> During shrink, redirect reader_page->list.prev if it points to a page being
> removed. Also detect a stale reader_page->list.next and redirect it after
> reconnecting the ring to the surviving successor link, including the
> transferred head flag.
> 
> When an NMI reader skips a CPU while resize_in_progress is set, treat that
> CPU buffer as empty in the empty-query helpers. This lets ftrace_dump_one()
> make progress instead of retrying forever when peek/consume also skip the buffer. Entries on a skipped CPU may be omitted from the dump.
> Clear event on every consume retry. Cache whether it is padding
> before unlocking. This avoids reading event fields after unlock.
> Clear timestamps on skipped peek and consume operations.
> 
> The NMI fallback increment of record_disabled is intentionally retained.
> The existing fallback comment says an unlocked NMI read may corrupt the
> buffer and that recording must remain disabled afterward; the existing
> unlock path does not undo that disable. The nmi_readers counter is separate
> and tracks only the temporary lifetime of a lockless NMI read.
> 
> Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atomic")

This is not a fix.

> Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=37e1793bdb0061ea3a47

No the bug report has NOTHING TO DO WITH NMIs!


> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
> 
> ---
> v3:

I'm not adding this complexity to handle the best effort case of an NMI
reading the ring buffer during a crash.

NAK!

-- Steve
