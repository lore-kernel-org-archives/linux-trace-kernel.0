Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848913;
	b=yatINaC6nNFrrFkJbRFv/lAhL/4C09UTyJ7MeTp42qb4J4uIn6GdnC5C2/Z8NMDBQ9Dt
	 DZGx2J7rQDBl0ResYN9ISPoypQEtDigcsjDLkeyCW4RyhJoQKXPYnfxK/lz+z2qLUjza9
	 96jh5JacaAp0aZ9sRFQgkG9UPg/pEEziNzRuXddf4dp0oCaSr5GCwPABJEeOWWPqgfGQ9
	 s5Svj4YkN656cQ8GefXDAISysb68m3PVW0GjMWvRPkAvUZIW4SpfOnpzESoJ/Uh72daca
	 7bVaATdjAtL2Z8VNYxxIgDs/x7jAEl88+04Ktvo7EZKRizIHDjnQHK2Nq6Zn2bjPZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
	b=jLfA7mPlU9ARKJZZOoH7LYbJ35+BIQxyTW+6w0Gnw/zt8ZT3/O6gvdI5RX6zJo1/y5dL
	 dtnqkO1d4B7dZXQzGy8+A0PdDTjVNa4miavnF/ybv38ISrZQizQuMH1F9A0+debNmirCM
	 ZcywAbnEoWwfVXd5fNsceXZxH2MwCAmmIBouq6h1VnJRRSpGP7sEoH3SiAYuOEVqTXKMp
	 ug0dWSpbmtmv8zLgXzZ8oT4SZ/KWtmVomegdPpW1X/w1X70nPo2gCkZOyZqdKOpWnSDlk
	 j5j/e2//OjcoYUDsIeN+Lut6MCxoePm7W6IX382+3scCL9soHisLz7lcu8JgHMSs+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ey7AZ+Zk;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D357606A33E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 17:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D357606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ey7AZ+Zk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so32304875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794848912; x=1795453712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=Ey7AZ+ZkFFq27QRb5ss7YWBng2ZMQ3j1wzKQijz0gEmSQtB5G7cV7W2CSe+1bKAKpb
         2/9rgiYbBd8iuZwF44uPq48BXRiVp1VYYgae7s7u5X5NKz7rwMEOvjx1MJ6JXJs1w4KA
         hzo+SXFB4IG1b+2HSmx0Sfh/xZD+tjg4km32oyf0hDm/3iYQe0LqKPwl90xvHcoZSP0K
         4KYZJPSExtGJGXVZJIHkrb71LTJdMxOsGCUFEgCxnYZOfWVmKIKg21R7klmwcGHh94B+
         AyEQNk+zQx+T9ionWibHQ3ItgEI5ocKZCioaWcY9QtToa8W8ngo0rBAA+fnWiSg8MmuD
         2Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848912; x=1795453712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=OmJ3jX7VKaD83Vkg2iJXX4Xspb4aY0a+3s2E7zW/qrZrVFAAfo1fFD189wLC/nclMf
         5nvUDpLJ8NQhYT8NyrI5evsVyizpU7h5AJaAQRJrvvXVKGh6+LSFFu7O808A5zaZz4zR
         nyZ42M8YWbwgHX1wyKsRpkTZCt9uPNacbwa2N/LEzPbkRoytPuVk3+o6oeqT0fSTRW+s
         SDde+SaNXtl2LkMQBKuNm8bpYnM9cu2PQ3P3TX1NsV6KJ2gWJ9zMFEb9o21FZSXYjaqQ
         kvMtldWuiHWaAmKWwYeFfgsqUV7tTx24Co0qI4u406Hyq6R3ytYiDAyJKpZBnhONWCrx
         2RZQ==
X-Forwarded-Encrypted: i=1; AL+hErFNb0OSmyEOLasXYSgVbNfyBBCekjeJRzn1tXAy94WXi3+hPOtd0NygpACcRoflu9tXhDMrmWkm3JJ2XLDWUBU3XXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vIwyM5ZS7o4hOQO6DwFmOCOK/lNGck0CfzMZfFSY0GdSLesJ+
	TWePb/9pdCjf2i2akmwhTTb0PMDlMSafZUwZecot7savkldHQWcCsCrWnnTuW3zxgBs=
X-Gm-Gg: AYBFou30c5CrKXR5rxJtiCw7kI6+e4XblfrBMPpBJ5GLqDawX0Mj47sXVclLt4uZt7V
	P99ihwdQ5C3x5eihyDrW5tg8oqFLPf1uQ+TA/Id9QT/yXOZwSfl3FaZiCySbvGfOaK2i5mlpR6/
	YPxJ+lpbkYCeG0wpfcCoqM8pgjOCTzslOgf2MalQLYmJhMmy+jPHJUi/KvDnJTL12SbxIlcd+k3
	KZWZAcZAtrPfYlYPNDEsDEhuoWlfbXDelygW/vRUFuDFm6nGzoI4BjqGqSjeyKO+O5Y4uQ8Tw41
	sX3ghiC27VmRizazAkD4mYwIvakbPeX6o+JTDOU0UPUcr6dAl/7k3NBo+CMw+bTOM1lQAlklkSs
	r4tYce5Dl+wEJro2b9PbjbbJPZNfat4KTHTTZias/t1Y3bPxTdtJUV5sjr3ZIOlGPAQhPMqLL1j
	i4BDcWr2+HTctaOdRrxDFjg8YAVg0GZjtnjHt6+fLjeS71wIfBzCykhuTrkcBRtTPIYsDli2zxo
	Q/47HKs/ZM8oR3JFvd+hQZMqEA/r5gAFoHGtahEZM1Vg/4KqQcO5tH4m2ECrMcl7ca7suOFJWBZ
	RYfX0PWf3oMzlPC/sc/16qLb+dN+cZ0=
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr97325545e9.6.1794848911805;
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c77393700sm22964108f8f.18.2026.11.16.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Date: Mon, 16 Nov 2026 18:08:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: john.ogness@linutronix.de, rostedt@goodmis.org,
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <avs4igB_mEc9U-Yw@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>

On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> When collecting high-volume diagnostic output into the printk ring
> buffer during a kernel crash prior to kexec, synchronous console
> emission can stall the panicking CPU for tens of seconds on slow serial
> or IPMI Serial-over-LAN links, risking external hardware watchdog
> resets. At the same time, uninhibited ring buffer rotation can wrap and
> overwrite the initial Oops, faulting registers, and primary call trace.
> 
> Introduce two scoped mechanisms for in-memory crash telemetry
> collection:
> 
>     1.  Console flush suppression

Nit: We already use the word "suppress" for filtering less important
     messages on the console, see suppress_message_printing().

     I would prefer to use another name to avoid confusion.
     We basically want to "block" or "pause" consoles here.

> 
>         Provide printk_suppress_console_flush(bool) to clear the console
>         flush mask in printk_get_console_flush_type(), guard legacy
>         record emission and kthread wakeups, and suppress
>         wake_up_klogd() in vprintk_emit(). Records written via
>         vprintk_store() are stored in the in-memory ring buffer while
>         bypassing synchronous hardware console emission and kthread
>         wakeups.

We already have similar infrastructure for suspend, see
console_suspend_all().

We should not use a completely different aproach to achieve
the same. It would just complicate the code and design.

I suggest to add CON_PAUSED flag and handle it similar
way as CON_SUSPENDED flag. It should be enough to:

   + update console_is_usable().
   + add console_pause_all_in_panic()

, where the console_pause_all_in_panic() would do similar
things as console_suspend_all() with the following differences:

  + no flush
  + take console_srcu_read_lock() instead of console_list_lock()
  + no synchronize_srcu()

And I think that it will be only a one-way operation. We do not
need a resume part.


>     2.  Ring buffer tail pinning
> 
>         Provide printk_mark_panic_start(), printk_clear_panic_start(),
>         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
>         the next reserved sequence number at the start of a crash (or
>         clamping to prb_first_valid_seq(prb) if the crash output itself
>         already wrapped the buffer) allows data_make_reusable() and
>         desc_push_tail() to continue recycling older pre-crash records
>         while refusing to advance the tail past the pinned crash
>         sequence number. Once the watermark is reached, prb_reserve(),
>         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
>         record and stop reserving descriptors or consuming trace entries
>         so the primary crash context and remaining trace buffer remain
>         intact.
> 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
>  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
>  }
>  
> +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> +static bool printk_tail_frozen;
> +static bool printk_tail_full;
> +
> +/**
> + * printk_mark_panic_start - record the ring buffer sequence at crash start
> + *
> + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> + * fatal warning, or panic so subsequent tail freezing can recycle older
> + * pre-crash records without overwriting the primary crash output.
>
> + * Context: Any context.
> + * Return: true if this call newly pinned the crash start sequence from
> + *         U64_MAX, false if a crash start sequence was already active.
> + */
> +bool printk_mark_panic_start(void)
> +{
> +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> +	u64 first_seq, next_seq;
> +	bool pinned;
> +
> +	do {
> +		first_seq = prb_first_valid_seq(prb);
> +		if ((u64)panic_seq == U64_MAX) {
> +			next_seq = prb_next_reserve_seq(prb);
> +			pinned = true;
> +		} else if ((u64)panic_seq < first_seq) {
> +			next_seq = first_seq;
> +			pinned = false;

What scenario does this handle, please?
Why do we need to move the "pin" when there are concurrent callers?
What happens when the original caller clears the pin and
the other racy caller continues with panic()?

> +		} else {
> +			return false;
> +		}




> +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));

Are the atomic64 operations safe in NMI? I would expect that they use
some locking.

I am afraid that we might need another approach.

IMHO, it would be much easier when the caller knows whether it will
panic() or not. And the panicing caller would just freeze buffer so
that the next_seq will always stay there.

Finally, please split the console pausing and ring buffer freezing
into separate patches.

Best Regards,
Petr
