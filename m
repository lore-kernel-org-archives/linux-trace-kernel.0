Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859214;
	b=pAX0nmzfxKkbwMd2jkL8aR3ub8xsPbPghbf+IjyEHqOkpip4CQWw18TqLi6O97CC7sxU
	 HsqaHkliT5OB1u9c/MUrGwpqlU3lEhGOKnqGSA9qsjXw3HcHZZzGbpEpmmWVzeQvHMdZm
	 5oPgOH4UO9xgA7PlZWyHKxBjBC40Dv6meAXUGiaIP3YhvxJmz4zKZ81WnSqoen5UO+Phf
	 FpKwzduPAUAYkqv7yBbK+vVsXXL5hjEl7gLyP9Cn9uoRQxYTDl6n2U9/o861DSxl/FHgi
	 y63seV45vALuczM2EiohIIqVT03PL0AOj8+nwmo/8B5NftfVFUF15gzbYs3lh3lwvKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
	b=idLXsegP6oj2oZ0ae8ihibylcwxwoGq3BLYd0HMLh81rTVRZ7/lzX7uSxQtgBK8v/2MC
	 PLUr7A0DbDeqVtwT5XsOOdWbFbPmCrSK7bMgqFz9k8XavILai3sWmB8HjYKeDLkIZYDaO
	 SGjHAllQ9AoN6edyB7doEdhtGi4LfTcKWw/ssCKI+Dvk46aBTU7XD1xrXelrZbukpicpO
	 WiF9G1qyIACi2yIE0kyY4GH+6WopJm9/2zuXBKDTSOaatqNcQ/RNwzza4TxbnoN4BWYb9
	 Kw2UI/4s67wkdl2pyqYTrkefltVt4n7kENmZ/G2QDPTk0W87ITKFFbzmJIM3iUofgbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GLEa6lZ3;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5F606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 20:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED5F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=GLEa6lZ3
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so23687635e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794859212; x=1795464012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=GLEa6lZ3l5jEVkJ1iIrvEfG2TgdUgonBjU8VFEoOyLYYiH1PA567+I3hxHvZ3rwGI6
         YoPb5PqhoCNdavSKQ0uzSLFFzC4RfKdXlPB/WLvj1Psbm9tzRaTFJTClEjMpF00RFfAv
         PsWx0Zp8QNjsZWOAtd6F14NGe5Jqo/vbHxOCPUz0JoM/ATPV0XusWXmAPvors+BRbiAS
         3mRGIovOSqoRnNWf5fNbHJhARZ1WsW/d817SY85s3px8OnE1RgIFazCXWFdjZLMPdlbD
         uABeRypIKFPVrlOCvAx1amb/SiZ3Ex5pNTmKzFoY/q3Mv3bmR3FYwSSJug77owftYMO4
         71Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859212; x=1795464012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=JpFeZAr7WkVije6qjlMtf4gyJcHY5zFBPhsJ7hQD+JdsGpVw7WZOOsbxe0OTI3f3A2
         j7DrREnNdK9hblA5OvlETziMkFvLpuqD9DOizJeU5dzlQQAWXmZ2ehSbLEVvgc3eCD+G
         9cGaauG6l96QjfwtQf5prmEcdyAr8aVxnF94X0aSxF3UfRtXzxk8w+pm8vbyrGocGyDb
         4Q4eWZD0r1D2y5NF5rbeGfQ5ackpc1ec/M7rbxp0ShcYCVUp97vSVJRnZQ4l5KQlobfN
         IkZAoXcN1x1GZhvA13izkTzAwshFBYGxVAMT95SKHMJQzWzbH5HI+PnvfHyfSxmVTT1A
         jvzQ==
X-Forwarded-Encrypted: i=1; AL+hErGQqxJOhu9yXLTYwBvysE5QLeR3nHztoGmBpHY7rc6S9l1vB5nGb+/L66Uf+3QKyo+LbK/LRnWexT0W0W9qhQ+GN4E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KOWiZRlYIxcrXnrB5NrJYaizYGLpqJEvCLwRokLI0agcthg7M
	aiwnz7j7DPXwbWijRO5qrrfOPNBBHNDlN7oYaY9cttBhECeQYJlxnpA1EnFz9M3cldU=
X-Gm-Gg: AYBFou2I4Ol8XtYnO1Oc8tDPbCBxBCyXft4sa/yPwxKnCWXWuPLy5VRWA2b2zUYco68
	irin5wTbe16YoB98vA4FHGZGNaTDZWB5Y1aeELYADO9N0tECDj8uEoi91/3pXzN4/yBlsiEZAx/
	BV8ydajWuqSE8gjVB4/OUCdmSxBz3aCKUdGwtnvrJ1QY55TUe8d8FriWrJPOfrV8P3R8CCg6Xs3
	ovq339nFYXTMRLTN16/uPHBhLby6AHc5wUOWal78bBPFLYIkFVOpO8krfBPbknpB6qqTIyDbz0h
	Iga7VM6zoIXm95C3zqstyzbKAi+MWtpN8ooPXu+Fk5DQRubeku7i/FrdoT1nIZXyX2Zgnsk36Gq
	BFsUK4jqIQ76ySAi3NeoIbJgz5rkJ2qdVm2RySNr14BvnMqVibcGHSeTMiDxdqHF4eJitHnDZgZ
	t3baAxYvKTO15CoUOQ3iF+elnhikhA38L0A3sifagwIeFdkMcpqY01mxMIECPnqgsiVXBOSmMRC
	EwAIr7f0LBx22smig3RVsompR5JTeBW9dJBLL4Chz2tNerArkH/RfOcSZDr8uFQba/oU/kqLhlj
	KEHkCbAHlz9eM5kki/k66BobmKj+95Q=
X-Received: by 2002:a05:600c:8709:b0:4bb:73ad:c1f0 with SMTP id 5b1f17b1804b1-4bb73ade318mr72004685e9.23.1794859211890;
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78386902sm14032225e9.1.2026.11.16.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Date: Mon, 16 Nov 2026 21:00:07 +0100
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
Message-ID: <avtgx3WkeDvn7zoK@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
 <avs4igB_mEc9U-Yw@pathway.suse.cz>
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
In-Reply-To: <avs4igB_mEc9U-Yw@pathway.suse.cz>

On Mon 2026-11-16 18:08:31, Petr Mladek wrote:
> On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> >     2.  Ring buffer tail pinning
> > 
> >         Provide printk_mark_panic_start(), printk_clear_panic_start(),
> >         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
> >         the next reserved sequence number at the start of a crash (or
> >         clamping to prb_first_valid_seq(prb) if the crash output itself
> >         already wrapped the buffer) allows data_make_reusable() and
> >         desc_push_tail() to continue recycling older pre-crash records
> >         while refusing to advance the tail past the pinned crash
> >         sequence number. Once the watermark is reached, prb_reserve(),
> >         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
> >         record and stop reserving descriptors or consuming trace entries
> >         so the primary crash context and remaining trace buffer remain
> >         intact.
> > 
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
> >  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
> >  }
> >  
> > +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> > +static bool printk_tail_frozen;
> > +static bool printk_tail_full;
> > +
> > +/**
> > + * printk_mark_panic_start - record the ring buffer sequence at crash start
> > + *
> > + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> > + * fatal warning, or panic so subsequent tail freezing can recycle older
> > + * pre-crash records without overwriting the primary crash output.
> >
> > + * Context: Any context.
> > + * Return: true if this call newly pinned the crash start sequence from
> > + *         U64_MAX, false if a crash start sequence was already active.
> > + */
> > +bool printk_mark_panic_start(void)
> > +{
> > +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> > +	u64 first_seq, next_seq;
> > +	bool pinned;
> > +
> > +	do {
> > +		first_seq = prb_first_valid_seq(prb);
> > +		if ((u64)panic_seq == U64_MAX) {
> > +			next_seq = prb_next_reserve_seq(prb);
> > +			pinned = true;
> > +		} else if ((u64)panic_seq < first_seq) {
> > +			next_seq = first_seq;
> > +			pinned = false;
> 
> What scenario does this handle, please?
> Why do we need to move the "pin" when there are concurrent callers?
> What happens when the original caller clears the pin and
> the other racy caller continues with panic()?
> 
> > +		} else {
> > +			return false;
> > +		}
> 
> 
> 
> 
> > +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));
> 
> Are the atomic64 operations safe in NMI? I would expect that they use
> some locking.

To make it clear. I think that it is not safe on 32-bit system.
This is why we used 32-bit lpos values internally in the ring buffer.
Also we use struct latched_seq for "clear_seq" in the printk code.

> I am afraid that we might need another approach.
> 
> IMHO, it would be much easier when the caller knows whether it will
> panic() or not. And the panicing caller would just freeze buffer so
> that the next_seq will always stay there.

I know that your proposed design make the new API easier for use.
You just remember next_seq at the beginning of a potential panic()
message. And you freeze the buffer when you realized that it really
ended in panic(), ...

But the proposed changes in the printk_ringbuffer code look complicated.
They are not easy to review, definitely.

I feel that there must be an easier solution. For example,
desc_push_tail() reads the state of the tail_id descriptor
including the @seq number. It should be enough to compare it
with the pinned sequence number and return failure when
it is greater or equal.

One more variable might be set when the pinned sequence is reached.
And prb_reserve() might then always fail at the very beginning
when we could not make any more space reusable.

I am not sure why you touched so many other locations. I guess that
you wanted to allow saving short strings when they would fit
into the remaining free space. But I think that it is not worth
the complexity. This feature should be used with a big log buffer
so using few more bytes is negligible. And it might even be misleading
when we store some random short string later.

Best Regards,
Petr
