Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924793;
	b=Ii9J9SXh3Gkny8nxzjp+FDOXl3ZydLG2x7IQph6bg+MdCMmwFF6NOaboRz4tz5bpnxS1
	 U9XaHCEvcpcl+p44f9nOXvub0Pqiur7ctLaYtNc9UNr9G0EZuIkwFOKi126OjXJrm7WDg
	 jHJdcjU9Th63UvPoH5V3vbIrMRYk2ZMI4Ripcp0OhcQeOXVxHOCg7EAj4fStibal11f1k
	 j1IURfLnjDnq5hiBwGsk+cYHgYqiXBVuvbuPGWy6Q3ymtN6vd4NmbV9PhZTWAW5CqLMRz
	 LGIZworDPylTOZpZaUMHYlUq0rODK47vAo0ToP89Ew2SRjzuW2CG8HVQOrpg5v+T6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=D2FnfX/mptaoH3voVPRlpYuy79Bo947c8qiVWXsE2CQ=;
	b=GiF9DygF/RMVKdojky+TUoP97hmDWoY7Jr9M2lJJbaKn1AIQFbGu2mlYOyiswTH0hv7d
	 stXI9lsm6+GncUlnfo1BeX80vxgdQ7c+lQLmQjljjdNxIIas+MyibH7yT40WjCRn37pcL
	 HBO6mXiVqL28ljSpqm+dpMb9OQUgEMB6QPFNA6j75nMtAmmqGwlcurgh8w6arFkXQTZYd
	 NIOSggNFTom3xaeUK0Kou0dXkp3oITjwksSqAeTlC6TGgrCie2alfAkQ2siLVN8YyGABh
	 HghwpsVHOfz2h+XMCtxVWzr1bg2mi9vFXYP9Dna0ofvxNNJSkf9IGzdG2cN9Jg02k0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XagrSZKy;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DA606BD07
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 14:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544DA606BD07
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XagrSZKy
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso48554215e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794924791; x=1795529591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D2FnfX/mptaoH3voVPRlpYuy79Bo947c8qiVWXsE2CQ=;
        b=XagrSZKymMN1w34uSM4sIvxJ3xPfecDaBs/Dj8wUlkY+QTWy/6AxBlc7uK98Ld78N5
         oSLjvzQ0/galpz1EkTpu0Nya7NsxZ3AGxVxN3sVtAFqnKMkUPI7izUbAvM/z5HFqbs6M
         yb781f9Z0R6lc8dHeS/cm/b6Y3amQkSVQIcpdhYucXdwjJfgcHWlQa9qz1zJZ8r2V/F8
         3KfCv+tudzZT4swks7PofMkdnvBvL9Zsb9PD3ZFodYgdINC3WKCdZ51F/sw0EhBgpc9O
         QJ1lHApdFqZpxD0ZJofLm0PzTCkbJi8n2LwZsau8jcxIcbYnrAo54yvDaa8dwwdn5+rY
         4qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924792; x=1795529592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D2FnfX/mptaoH3voVPRlpYuy79Bo947c8qiVWXsE2CQ=;
        b=qVrmcGDLue+92wF6mb8V1RXQIEMnI+XUrH07tcnRz+5YwfklvVYw+DWyRklBkjgqO2
         4SEsmgyzMAceyGZojoO1kopix2Nib4dcMEj2uAOm3mQ99f86XgJ48cw4uMQIl9zcjxjV
         ViIq2VNg+UPrt1A0gU7xYTczw4KBmfclzbnleRvGKOb+VG8mM7GQcJpi1imoKNdNwJjM
         ujC11qkfFWOyVz7XFZdAVWOwmsf2ysp0gKhZavWMQ5s7DlJf+AwbbVCzCZHDaTqnq6m3
         9l2JmeFaW3b3lyPSGbPeAz90gksulcTRrXMk9iUvIUv4igxcKsPi3sxb2wtuRwqEaKHr
         VtCg==
X-Forwarded-Encrypted: i=1; AL+hErFLFHW6t1McMCOngbtKxfpfqvnZTqhGfCMR5V0r/kqIKvye1BBPseDuXPRnWlYPlTdjYfBEizTRY01XI7o0upm//yU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Llv0OqUv28PkcThbLgT0/DaY+wsN6BuI7hLuwe5Rp8MJtMmff
	ProCRUGr9+E1ADpOJClhq7/V9Z/NpJjdfWcGw6tAnP5ldVF4QFPH7IUNb6+lfV+skg==
X-Gm-Gg: AYBFou1GV4nk30P54NmK1YkoaNZAwJCBkVsqsYPm7k+3SFdW5sTFLnLYyXa3j7eiYOf
	M+7L6BMBeEsIWRftwiX5d1y2ZBbCNeWlWap8X2BvsKw3dtl7m03NjI43LoaTl+0GsdHv0xCRGmm
	gC1ve4G79gTDmBF3Uaw4kHaExDTdybeJ2jWW537LnCLQ751VvjSpddqtWkcCqzVMgHsXrZfTEDu
	Gt+SLSqZ/ihlwKdJM+oTLlddpZNvkhKiwGPzDlWqfANW8DqfWdCtia3xwJSIWRnwDYG4ANKFoUx
	NXLX30PegEOUN9zs0SC6WF/ocadNyhmwMSSsGezwC67Z++No2hR4vrVYl3inqd0JJ3ChwkvinrM
	XwRXJSiW/7m/3DYkKmdkSeku/V6dvtzmSUSreUWt+JwMQoLZx1YkE0nWbsaA9VytfpNnJy2Mh7k
	UYgdO4Zp1+lVbQhfIFFlojTDVqcOL2Pl+jfbxOzwKMerhpPXxZRFICP86AAYjeeohh2tStqFdqw
	7lrFta0n6CRx02Hg0C0Me4PMpGyQdCmnlQ1iY28eAgYIODMx1S45jjoAsfiNstUUU/evTXFhO+z
	1UvrLTrXYMg8HtX8dSfXGSMO1ykqWZyeRof9XcylBJm8PESQ5ZGygNVl5Fts1spoAPg=
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr317973745e9.20.1794924790897;
        Tue, 17 Nov 2026 06:13:10 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm192782795e9.4.2026.11.17.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:13:09 -0800 (PST)
Date: Tue, 17 Nov 2026 14:13:04 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	=?utf-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?= =?utf-8?Q?l=5DRe?=
 =?utf-8?Q?=3A?= [PATCH v5 1/4] ring-buffer: add ring_buffer_memory_size()
Message-ID: <avxg8M4dcs7Gphc0@google.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
 <20261105140221.44614-2-gaoxiang17@xiaomi.com>
 <avhteUQSrWPFuQ3a@google.com>
 <aac878d9f74e49d7b3bccd0f352b700c@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aac878d9f74e49d7b3bccd0f352b700c@xiaomi.com>

On Tue, Nov 17, 2026 at 10:58:05AM +0000, 高翔 wrote:

Hi Xiang,

Please post your answer inline next time. This is easier to keep track of the
different items.


> Thanks, Vincent.
> 
> 
> Agreed on the naming — I will rename it to
> ring_buffer_page_memory_size() to make clear it accounts for page
> memory only, not the slab allocations.

Actually I am more and more convinced a more generic helper is better. This
could be ring_buffer_nr_subbufs() which only reads cpu_buffer->nr_pages.

Regarding the "meta" pages, we can have a separate accessor. e.g.
ring_buffer_nr_meta_pages(). The caller could easily "guess" this value, but as
they are ring buffer internals, I suppose an accessor is alright.

And actually writing the paragraph above made me realise it would be worth
splitting the commit between ring buffer data allocations and meta-page
allocations (and perhaps showing the difference in trace_stat). The sync for
data and meta-page is slightly different.

> 
> 
> On free_page: the read is racy by nature, but it is a best-effort
> accounting that is off by at most one page, which is acceptable for
> memory reporting. I will mark the reads with data_race() so KCSAN does
> not complain, rather than drop the accounting entirely. The same applies
> to the mmap metadata page.

If being off by at most one page is acceptable... (well, one subbuf per
trace_pipe_raw reader) then why accounting for it at all? :-)

> 
> 
> I would still keep a helper rather than compose the existing APIs in the
> caller, for two reasons: the caller would otherwise need to know
> BUF_PAGE_HDR_SIZE, and the helper reads subbuf_order once with READ_ONCE,
> avoiding the subbuf_size_set() race your formula would hit.

ring_buffer_memory_size() still hit a race with ring_buffer_set_subbuf_order().
and existing accessors like ring_buffer_capacity() do too. It is down to the
caller to resolve this race, if necessary.

-- 
Vincent

> 
> 
> Thanks,
> Xiang
> 
> 
> 
> ________________________________
> 发件人: Vincent Donnefort <vdonnefort@google.com>
> 发送时间: 2026年11月14日 22:17:29
> 收件人: Xiang Gao
> 抄送: Steven Rostedt; Masami Hiramatsu; Donggeun Yoo; Mathieu Desnoyers; Lorenzo Stoakes; gao xu; 印闯; linux-trace-kernel@vger.kernel.org; linux-kernel@vger.kernel.org; 高翔
> 主题: [External Mail]Re: [PATCH v5 1/4] ring-buffer: add ring_buffer_memory_size()
> 
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> 
> On Thu, Nov 05, 2026 at 10:02:18PM +0800, Xiang Gao wrote:
> > Add a helper to report the page memory consumed by a ring buffer for a
> > given CPU. It accounts for the data sub-buffers, the reader page, the
> > cached read page, and the mmap metadata page. Unlike
> > ring_buffer_capacity(), which reports the usable data capacity, this
> > reports the full pages allocated to the buffer.
> >
> > The function is generic and returns a size for any buffer type, so
> > callers that need the memory footprint of remote or persistent buffers
> > can use it as well.
> >
> > Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> > ---
> >  include/linux/ring_buffer.h |  1 +
> >  kernel/trace/ring_buffer.c  | 37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index 649b2276b557..e83e94623e76 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -174,6 +174,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
> >  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
> >
> >  unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu);
> > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
> >  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
> >
> >  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 1fd28a72e6ee..0396ec671998 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -6566,6 +6566,43 @@ unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(ring_buffer_capacity);
> >
> > +/**
> > + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> > + * @buffer: The ring buffer.
> > + * @cpu: The CPU to get ring buffer memory from.
> > + *
> > + * Returns the page memory consumed by @cpu, including the data sub-buffers,
> > + * the reader page, the cached read page, and the mmap metadata page. Unlike
> > + * ring_buffer_capacity(), which reports the usable data capacity, this
> > + * accounts for the full pages allocated to the buffer.
> > + */
> > +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
> 
> memory_size() may be confusing because we don't account for all the other
> kmalloc() allocations.
> 
> I have also just realised, do we really need yet another accessor? With the
> existing ones:
> 
>   nr_pages = ring_buffer_capacity(buffer, cpu) / (ring_buffer_subbuf_size_get(buffer) - BUF_PAGE_HDR_SIZE);
gg> 
> (Alhough there's a race with ring_buffer_subbuf_size_set() to be resolved!!!)
> 
> And if the caller knows if a cpu_buffer is a remote, or a persistent buffer, it
> can just add nr_pages++.
> 
> This only leaves free_page unaccounted for. But does that really matter if the
> other solution would be to have a very racy free_page accounting?
> 
> --
> Vincent
> 
> > +{
> > +     struct ring_buffer_per_cpu *cpu_buffer;
> > +     unsigned long subbuf_size;
> > +     unsigned long size;
> > +
> > +     if (!cpumask_test_cpu(cpu, buffer->cpumask))
> gg> +             return 0;
> > +
> > +     cpu_buffer = buffer->buffers[cpu];
> > +     subbuf_size = PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
> > +
> > +     /* Data sub-buffers plus the reader page. */
> > +     size = (READ_ONCE(cpu_buffer->nr_pages) + 1) * subbuf_size;
> > +
> > +     /* The cached read page, if present, is a full sub-buffer page. */
> > +     if (READ_ONCE(cpu_buffer->free_page.data))
> > +             size += subbuf_size;
> > +
> > +     /* The mmap metadata page is a single system page. */
> > +     if (READ_ONCE(cpu_buffer->meta_page))
> > +             size += PAGE_SIZE;
> > +
> > +     return size;
> > +}
> > +EXPORT_SYMBOL_GPL(ring_buffer_memory_size);
> > +
> >  /**
> >   * ring_buffer_max_event_size - return the max data size of an event
> >   * @buffer: The ring buffer.
> > --
> > 2.34.1
> >
