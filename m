Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663297;
	b=RLvnosyrFyv0QTOH/5hqp9RhWypmZwiZjqq9yrSdfjifLArVz++KN9+oGstNgFGNaBZJ
	 e1eNBAc0BrGwMCnQa1kF9fciyQCB0m0ukiIWnGr/+fx8ABMsVI83ZfJnreSw0FgZAufmK
	 PTFZBOPmPOpwWIiQdIGqJpYy5BufMrxBzeXdVX8pJZAUbMv3EhayocbwC0tTZLGcw32FK
	 Q/uJOwroHrI6WaMcLv2hgG36DmTEJvrWNtvOMdCjXsqxxOcxko7DPjr0U/9pP9V/eyUwT
	 BFLYGfimlWVgyJDJFIHR2sl2lQKjcvI8Dk02kl2urXu+3HcJk96+NJAx83uyomks9hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=iITVNj1hA8VysTM3SegZsQpdbGDdaeAWi8dvud7vL4Q=;
	b=0O2hDrJlshFMTGCd0iRNMgx7PfhyBzemQl1mbvEgC37zI6rpu+doYQ7Dcoxsua9Sbgbf
	 wAuY0Yn9J2pam+d0qx2lonzCyqBOUhOpmnn55ue7QPZLvckGhJRDAb5ZpyO3CKT0AdDik
	 WOSi4psBrO626afWExjh2oBhEdF/ysJ9vyrLw7/5IHDvNpWDxZCKrMW/zq1RmnG7pwWf0
	 c5iX5AsVMHbBRphqmlVvIZBsJn6zqFH/14HIh4DDo0qnNyI3cRhHuS/OQCtsTx4QyYhPi
	 kg1g991TxqdCIYIWnkI674I2OLZ/jrkuIt8RVo3sApyma3AP8sx/KrJVZKDduQHZCfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hugtNYNL;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F804606A327
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F804606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hugtNYNL
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso4738715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794663295; x=1795268095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iITVNj1hA8VysTM3SegZsQpdbGDdaeAWi8dvud7vL4Q=;
        b=hugtNYNLAMlBFGDbNiKjsl6/gjLlQ9FOn/PXyiCRua3kHES8n4nKD7kGcra2ssguCT
         9pP4XOK1XQC1+H7kRly3Gjr5xGHoCE6S7vWkntXq5GNgq306NfW+exOUbmTnC/fw4mzr
         3uVw6A+OWvgaqjrjX72Ycgigpmz+oTIpVA3pS/SuXAViIlD/PNoai8X4vHEJlCghZlPv
         7ba7uA3a/FTMlHa5ziX093EAnMLLt4BrHoboZT6uSeOdz1vwZzfL3eRQgbGXkWUGgF8E
         TymS74/xaqb+3C1WHxVWc8T1m/lCGAPVTguLpIaVAm5ER6i/vEut/fjXeKEnV7qpcms2
         vntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663295; x=1795268095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iITVNj1hA8VysTM3SegZsQpdbGDdaeAWi8dvud7vL4Q=;
        b=VT1C3hY7ysB8VwRFYkh4TId4G+PAvzRLiFfHG7y/sklxoBypVAIxDbgKFwKtuVxGPJ
         4UshfZ3Y6UjpkDpaX0YhkpBXRXGHFULWlbocSgQ859A1k/UP6BGIXV/e/82eT8nhgmzj
         /Q8+w2njMIGYz3MHVgM4nFzxzCLm0g4WWLrN5C+UkYc5SLUEOuFiu8BnwZABGJ3XqPh0
         fj6umK6rJF/umw7CCRH4SG9eiAYRA5zPE0yA+OYEiXJHPLiro60EpcpDUo6inOeoVOjK
         mkgU/fnlsyvQH8xChdDB2l/OvmUQR6pzfgbrel2nSNkJKIltTbIs2H+UK/0n++/vEiQs
         5Skg==
X-Gm-Message-State: APuU4Z+caAg/dh+84Zpe5oZsXcvR1imN3StQ9yyTrobN8IN/IRoeTKNG
	4HnSzPaiYSlXjOI+JeOe1OG/oEuXXznshyot9l9a65iORTQerT/RsRu66O/pdTI0AgYwzZVSkGm
	7CcURtw==
X-Gm-Gg: AYBFou1xgwcDlf/yRt2AtouCsgp8vbP57dCXkMb8p13Ojv58JYtwecmapjdVPxCK2Yw
	rb25HxJHwzPewY6I/6S17UdQDZuJXSbmf0zMuhkCE+T9SPs1U3AylwpbltUFu0mkiujfTuU2YKc
	9FQn3KmTCJtIgYkTpWfjVfCIktPWi5sFOauGMfeuZSKPc3fT+D6CpcgAlAaerJrlJZnFWjS+x5P
	H5VsWv1pxkVzW8GwDEZSGx8+//mnW/Q0EksuAoJFJ3y2VR+3onjUNZrauA/9mKQufoHZVqzi0tf
	RTfM+xlZnr6OMOw/vVez516Us0ams8ayrd4yVcinHL9hv17um4lCnCZi/vyEkcrn+WEj+ie4wGF
	wR1asEJYV8XETcDZJyZJK5llBGF3tqGaA1SioBBGpHCXOHsd+6zBTgcQ+xU0ViwqIsZ5zkxDS6j
	HwTpgQ/9trw2wp7KPQ8hVTNnD3Sv5vQRZKIHmMZoIPF0SYDFxVjK408JCApKbsm+5CHU1KhMYph
	0qUdpj/30CirV/PGer/rpzoCi8PKzQla+rvOVqLa8hxR5k+y4BbyGiKm/eajknUhCUX+cLc+ofd
	1XZE3522l2QVBcjEuA2LxnWXUhK/k/QiVB8EGseXBePtuf13VroNHIyIdtpxJ/KgaA==
X-Received: by 2002:a05:600c:3b9d:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb5dbfb103mr85932305e9.9.1794663294856;
        Sat, 14 Nov 2026 05:34:54 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm237952865e9.15.2026.11.14.05.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:34:54 -0800 (PST)
Date: Sat, 14 Nov 2026 13:34:50 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ring-buffer: Order remote page commit with data
 and timestamp
Message-ID: <avhjevfc0CuHyvWv@google.com>
References: <20261113152729.837429-1-vdonnefort@google.com>
 <20261113152729.837429-4-vdonnefort@google.com>
 <sashiko-outbox-213099@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-213099@kernel.org>

On Fri, Nov 13, 2026 at 03:34:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Critical] tracing: out-of-bounds write in simple_rb_reserve_next()
>   [1]
> --
> 
> commit b0c88540d75d93c7a85149df8d188a1bfaa9a89e
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Order remote page commit with data and timestamp
> 
> This commit adds memory barriers between page::commit, page::data, and
> page::time_stamp for remote ring-buffers and defers updating read_stamp
> until committed data is present on the reader page.
> 
> > diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
> > index 5f14ba152fba6..2dddaef638dc6 100644
> > --- a/kernel/trace/simple_ring_buffer.c
> > +++ b/kernel/trace/simple_ring_buffer.c
> > @@ -307,6 +307,11 @@ EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
> >   */
> >  void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
> >  {
> > +	/*
> > +	 * Order page::data and page::time_stamp before page::commit. Paired
> > +	 * with __rb_get_reader_page_from_remote().
> > +	 */
> > +	smp_wmb();
> >  	local_set(&cpu_buffer->tail_page->page->commit,
> >  		  cpu_buffer->tail_page->write);
> 
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can
> simple_ring_buffer_reserve() return a pointer whose reservation overflows
> tail->page->data [1]?
> 
> In simple_rb_reserve_next(), when an event exceeds PAGE_SIZE -
> BUF_PAGE_HDR_SIZE, simple_rb_move_tail() rotates to an empty page where
> !tail->entries is true, and event_size is assigned to tail->write without
> checking that it fits on a fresh page:
> 
> kernel/trace/simple_ring_buffer.c:simple_rb_reserve_next() {
> 	...
> 	if (unlikely(write > (PAGE_SIZE - BUF_PAGE_HDR_SIZE)))
> 		tail = simple_rb_move_tail(cpu_buffer);
> 
> 	if (!tail->entries) {
> 		tail->page->time_stamp = timestamp;
> 		time_delta = 0;
> 		ts_ext_size = 0;
> 		write = event_size;
> 		prev_write = 0;
> 	}
> 
> 	tail->write = write;
> 	...
> }
> 
> Writing the caller's payload to the returned event pointer then writes past
> the end of the page buffer and corrupts adjacent memory.
> 
> [1] https://sashiko.dev/#/bug/linux-b2128783-1787-4f13-b863-090db5378e74
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261113152729.837429-1-vdonnefort@google.com?part=3

There's absolutely no existing event that is big enough to a ring buffer page!

-- 
Vincent
