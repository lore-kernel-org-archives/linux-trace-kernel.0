Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927147124B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116342; cv=none; b=VdtjdwXbRjJKD2lcjhgShZj/YPTrSHH+G8CaAO8hL/BqJKt4Wg2pZubK4MaxZz7mWi0YERHrRDbE9p3uNEaDvrFBDsIM3zDvrNrFAnNcwHcnT77rLqoi0CBtJjfF0sUA61/VMu6YyES5D0KGj46LLW5hXu88vGbMgbtlJqFnXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116342; c=relaxed/simple;
	bh=VGgFv9Zh9lovUAXcAsP5Bqs+2QXJhvYHT0MlkPWTuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNNYdiNwPUuWGFG8HEGtbpX1qZ92++xk9obe+wbWRm7P6KRHtgQD1JqCrG23oIUm7rXfV+o+cQ5ifQ/Xh95n2lgpMOSjKDBojqMawYQrPUkldjS+jrzU9ZosK4kEK6G2t8xGdfOrAHpdsJnNS32vTR8XqWzBB3VrxmVpeJgPVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McRl8ykO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McRl8ykO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so19837665e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786116339; x=1786721139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPWrrpeQH6wKPsLOWBBbeQDw72Bkoh4jFNhrNH+ZpUM=;
        b=McRl8ykOql5JUzwrb5r6/E6+jlMyuG942UftacuCdHe4bG8XdnCnV4elyX0l+LpwE1
         tVc7CTviPJibPAI/bRWdMBOsNybGDAVB6+lWmUSfRFRWw4aVvzzTz4CAaNpeJjAre3CT
         du+IAKHMOWgoCJ8PVGi8bloAUnjfkaZT58AXuuCykIDBaELT/AVCAzoaFtWMaCIMOJEq
         IAGEP5ys48/0ORVvKpN2te3M8CThR4U5uh3hyoIs1+iPXVXxqoLUDS3+uJyL/Z2IMuFN
         rQtaAuX985K6Ml6elPaSqe6T3Zg4rCS4cR85NED4jUZsgbSG3a9CxHX++eEUSm98tDsn
         it1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116339; x=1786721139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPWrrpeQH6wKPsLOWBBbeQDw72Bkoh4jFNhrNH+ZpUM=;
        b=aPBj7entj/aQ4GdUmOJcbcmIP/loVf3GiXh4EdJtUU8U7iPyW2ZsAu96xBJBrj3LD3
         HT2wGRRrsy3dnlhPP5TeVV04FqhEu4WAjPxMAU00lJj64DNPIM4AxSZa/ijlZ9+jj2WY
         0iqEkJV5K6DZqDzTde42TvYVBeyzCaEkQXELSTY4iigOnTh32T4wnx7ECWT+3WWAM2Gr
         qp6VW1xv0yaBcrj3quQdDPolseQnKMOUTe1n9jqM9mC9e4mjlXKyi01aSn5o1lr2OHMi
         1mq4isblesj4tSw63q5KLr3UCRL5s3E787vQ/dzo1Bd2p9u9pPXUSGO25Keg71g/Kxws
         z0zQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDSzZdJTP7Y2euNYJN9Zi8N61Khw39XCEwlRE36UX+R4//1gtKBAXH1ZPUnIeaLL2EX6BF6n9CicsuoCBb3BT4Oko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoxKHcGaxhxzZTIRzq9hXHpnRnD3L9bEA5DcJoetreiDARdsv
	OydLI6MaYCBwcClkPFgI9ZGgX0EN0VsWlkpKjfNFucvvhhqap0uaMG/F6saXJXmdSA==
X-Gm-Gg: AR+sD11OQVB/EJInm2VRHHjtR3IqJpb7InXS7DV0ZEOXcIyoqxQs0XWwtUiW1nV9jaq
	2zFNdtTvxp/1nRyV9mNOdMBMXTCbR160UEWwxo/hJaGC0Qnd+4CtyIvNO8SwbgGA58J6VKVZnPX
	QBumZ3xp7FjBRw6jW96Rkmyd4vSRZ12suuH1GRjrOL1Lv3OOQFSDA+eEHXSQ+32LJEDGRkqCpGo
	f62dIuiiqEWWLQB6ZaRRTpngu67aRYkgjPbnKiHNYV9qKSScH2QRWcqkQn9azTzPHVA2ENxbiC2
	m9UbaHyT2Pk1vCvnA2QPwsfwcrQrmup5YcMbwspuTtors8WQL0BRj1FvtyTqxf6LcTr0QFczzuq
	GOTBqsfGo+oADLUfRTh3gyN/0+1d8lWd7ymMRO28J2m3weOIlbx3af7JSxWVnMZP0ono6zyK3xb
	r32xJ0My1ggINDD6m59+5cqFJKMxDNl91JEQNr0RKJKDjGTAJ9GyLXSQ/AMCwg5Tp5wJTDkdf2O
	fAZE2wq2RwzTTfSP4TKLdTUnpUSbaS5
X-Received: by 2002:a05:600c:c0cc:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-499619531aemr7250405e9.1.1786116338541;
        Fri, 07 Aug 2026 08:25:38 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7a3d1dsm51078255e9.3.2026.08.07.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:25:37 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:25:33 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anX47awNHC9caDN_@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
 <anWT4heM5Z--A1Mo@google.com>
 <anWosNi-U8lVqBZP@google.com>
 <20260807104526.38430aa2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807104526.38430aa2@gandalf.local.home>

On Fri, Aug 07, 2026 at 10:45:26AM -0400, Steven Rostedt wrote:
> On Fri, 7 Aug 2026 10:43:12 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > On Fri, Aug 07, 2026 at 09:14:26AM +0100, Vincent Donnefort wrote:
> > > On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:  
> > > > On Thu,  6 Aug 2026 22:13:01 +0100
> > > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > >   
> > > > > Dynamically resizing a persistent ring buffer is not possible. Disable
> > > > > the feature.  
> > > > 
> > > > Is it true? Of course there is meaningless to resize the persistent
> > > > ring buffer (because it makes the buffer none-persistent), we are currently
> > > > allows user to resize it (like for resizing unused persistent ring buffer)  
> > > 
> > > __rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
> > > rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
> > > one already in the persistent buffer.  
> > 
> > I have just tried and if reducing the size works, increasing fails in both
> > rb_set_head_page() and rb_insert_pages() with a warning, which I believe is
> > expected.
> > 
> > We could improve that, but it feels like it is a lot of work for a meaningless
> > feature which we should just disable?
> 
> Resizing a persistent ring buffer to a smaller size may be allowed, but I
> see no point in increasing the size. Making it smaller should allow us to
> give back a portion of the persistent ring buffer for general usage.
> 
> -- Steve

While I see the appeal to reclaim that memory, I don't think we have any good
interface for that. There is no nice way to get the list of pages that have been
freed and we have no control over what part of the ring-buffer is removed.

Also, as this memory is from a reserved-range, is there really a way to re-inject
it into the buddy allocator?

Perhaps what would make sense for resizing would be to support a CMA pool as a
persistent buffer?

-- 
Vincent
