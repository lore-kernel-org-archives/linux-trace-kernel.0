Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488478;
	b=tiAvvS0O+joxYZOXBhbeclo/NuuzDZ156c4hIoDJ00OMNQt79NBePxfgL0qfT2yFYBsH
	 gsOKovGKGAqGodYiks3p/wI0CL83+mtY/GTK17FAtt2+yFMfB0HH6WPhZzCeJDX1m9UJX
	 KsHSGYCyuNqvXu0Ebucqn5HRtqO/t4/0Gch78B1c1KMMvsnGtTsOrJFJKfJSR01HS/bWG
	 n1hs0SDNVjxCXzTlNNTbXdIMG6jZ7J+HsG4JDo2I2rEIe2zMNFo2AP17Hp5cCq1OSy+uH
	 sOgX1Ak8BXwnlsGl0HMGoxjDh/AaW7rMReVJrO1235//iH1vGeQl4z5HlN6xaATp6lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=ilyoWL3u+u9MAiM1YKTDYfoFOBlZSFdY+PBZMMv3M0E=;
	b=0KjWRkRxmK+drUBo9WY+D3uiU09x1c5MISzKPnZkDX1urUDvZ11cSDhjNLP9KPUk5P+h
	 xm+/Az+0qQi1UM/ozb4nES1T5nJKUxmW3EdjPIkKhDJkaUSKZUmvI6TiMTA8IMRut7qcY
	 QkVCPiY4UkB+uukHVkp2YpjswBYkefKpiywiN71DZQ65gyP7lGzWM5drVppf/hJrMdqLI
	 10FEwhfneTN+5LHt9+VWm9MDBd6Ls22B0Ma9T0hHJN+B7pqLsBHFAxlpAb1DkFU9z57ew
	 jBiUiNqnFXDFk7TOPy/fMzTaa3QXVF5LsEJXepqWLKjS4v34E0jep6TUKVjj61OVvGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=daq84WDC;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89B606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 13:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F89B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=daq84WDC
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b467581b98so39481475e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794488476; x=1795093276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilyoWL3u+u9MAiM1YKTDYfoFOBlZSFdY+PBZMMv3M0E=;
        b=daq84WDCg06sOBALJnO7ZFLb7zzHXtyWlWQhU8FsGdFuC/UopQB9t7vG/Kx4sRpZjn
         qbinHBta3+1Zn+TlIKktch9v+VwzT6aMmgYzWveNgRSlxbGZNYDaf11OL9s/42I4qAoR
         V5tjvkNg8ldQ1rPgjFYtdOS4pPpgt6tdBQx4wtb73iUD3YTzuSy9nEc/XEnRVub8EhLv
         7Q5aDmjSwjAhQlgbwsxd7bzbomOGKBVplpe+SaXp7XQXuTS2QvVz0dXjp/qM19Deo27F
         47ywLbODVQTIBAT3uRuTRnVpR3fv4Yw2O3nJnsLNby6wsD/tLoLHDjWKIAx7w+Fm9+G5
         1FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488476; x=1795093276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ilyoWL3u+u9MAiM1YKTDYfoFOBlZSFdY+PBZMMv3M0E=;
        b=qV504KoYEto40YUBVTGQevx+FGv0IAVEeZ9Wdsg5IBG9BCfb/ZL1TN9xSIvr0f6rlA
         kRCUJvALp+8FFMvAMB8+tIqn7OqNn36Fb03q7DXnMhYuIFRW3479J1f/SEX2ais3A9zd
         oveATt8QdjIZMRXa7h7pAESQuGCg1gYgtg9Tmist/fIUEatCRt60RuwSCrN1/ix6mkFQ
         OiRVRws4UMMEnBoNrbsVPpPyc8Bl4QKfdngMGMehcV4uMP+u7tH/36s3y0BrUHv20g/x
         yrblO/w/tJbI4O75ra+eb6v6h574tgmNUC6ow4ChzODmbgSU/YcHGY4DdFv9+oJyU159
         VWnw==
X-Gm-Message-State: APuU4Z/GLYQkPk4V0ScgoSuYqRFqN8pCOcHrDzMvwDwjpe7aQKeaxGBB
	WwS+cpUjaVOxysI2dEoehvk4/+h0OEOLMXy7GqC9ZC7421Cr/8AkS9e1xwdLFJBd7vHM3VqMo7f
	LtPTBdw==
X-Gm-Gg: AYBFou0f0YD9CmjHeXtqmCQN+g2tQVYv70vwbhGit9cq2PAj1OUMDdftIsCrSTDAQ2W
	yeoRX312hXJ7zV8ZWfyHEG/fxl4OzUCHdZcC7OWn+8UtuSEZgEi04FMj+0QRvSFKkVOsMh4j5hm
	VX33bN6edKJ1ACRf3laZqAMDd6GYMOsXp7xiDbrqagvETsu53IIX9XxaxJVWYXo3AXKaMG7qbeI
	QBHbbZx864LeoJe55rl09J75d1WGcFVAryVvMKB0lkqOEAa34md1NBNlqYJ1vk0cLvln8M+GETm
	tdYSr5VEj1nljFEaVTZ16Ud1gI6GZtqn/gutlICwoFxBRAZxL/bGRiwx3YYJ+ONCqgfvBamKlJc
	GepsKOd+sm+B4c5PmlJcHM2rr/cIs+MpXB2LeBc5SrVgNIrNbkcxvxB9wpIY6X4+GUVDvBvBm3M
	UJf/UNUQbwGIlAOSEC/WcXnF172DZDuFDM6iS+IghuTXBmN3kTmANt4AJB32lvozImGT3jbCOj7
	ZTZAKc9rzaUABVEpTvWxlp05oMzrTZeTZ75IsYw72CKE7fgxaNo/6BtsleBFgrUPIIRmfHRikdq
	b3UbZDX5MQlelKxyhwFazWZ/1A/45jwfFrIfPVMUB1EOAa8IayRMBg+S97iavOmrdqY=
X-Received: by 2002:a05:600c:4ecb:b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4ba093811d3mr99267285e9.11.1794488475930;
        Thu, 12 Nov 2026 05:01:15 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251491sm71863355e9.2.2026.11.12.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:01:15 -0800 (PST)
Date: Thu, 12 Nov 2026 13:01:11 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Let the reader spin on head page update
Message-ID: <avW4l8AldZK62nJE@google.com>
References: <20261111160624.1294946-1-vdonnefort@google.com>
 <sashiko-outbox-209343@kernel.org>
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
In-Reply-To: <sashiko-outbox-209343@kernel.org>

On Wed, Nov 11, 2026 at 04:55:54PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] ring-buffer: stale list.prev dereference in
>   rb_handle_head_page() writer loop
> --
> 
> commit 42f758b28dc946f5aa06647c36c046a615ee80cf
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Let the reader spin on head page update
> 
> This commit introduces the RB_PAGE_HEAD_UPDATE flag to mark newly moved head
> page links while a writer update is in progress, converting the final link
> to RB_PAGE_HEAD only when the outer writer finishes rb_handle_head_page().
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 1fd28a72e6ee1..73f31e6719f98 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> 
> [ ... ]
> 
> > @@ -3833,6 +3849,24 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
> >  			return -1;
> >  	}
> >  
> > +	if (type == RB_PAGE_HEAD) {
> > +		struct buffer_page *prev_page;
> > +
> > +		do {
> > +			/* Interrupts might have moved the head further  */
> > +			while (!rb_is_head_page(new_head, new_head->list.prev))
> > +				rb_inc_page(&new_head);
> > +
> > +			prev_page = new_head;
> > +			rb_dec_page(&prev_page);
> > +
> > +			/* Try to release the reader */
> > +			ret = rb_head_page_set_head(cpu_buffer, new_head, prev_page,
> > +						    RB_PAGE_HEAD_UPDATE);
> > +
> > +		} while (ret != (RB_PAGE_HEAD_UPDATE));
> > +	}
> > +
> >  	return 0;
> >  }
> 
> [Severity: Medium]
> Can reading new_head->list.prev and rb_dec_page(&prev_page) here inspect a
> stale predecessor page and spin in rb_handle_head_page()?
> 
> Lockless writers cannot rely on the head page's list.prev pointer because
> __rb_get_reader_page() and rb_insert_pages() update the forward list.next
> pointer via cmpxchg before updating the following page's list.prev pointer:
> 
> kernel/trace/ring_buffer.c:__rb_get_reader_page() {
> 	...
> 	ret = rb_head_page_replace(reader, cpu_buffer->reader_page);
> 	if (!ret)
> 		goto spin;
> 	...
> 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
> 	...
> }
> 
> If a writer enters rb_handle_head_page() in the window after a reader swaps
> the head page (or after rb_insert_pages() splices in new pages) but before
> list.prev is updated, new_head->list.prev still points to the old predecessor:
> 
> CPU0 (reader)                     CPU1 (writer)
> __rb_get_reader_page()
>   rb_head_page_replace(reader,
>     cpu_buffer->reader_page)
>                                   rb_handle_head_page()
>                                     /* tail_page is reader_page->prev,
>                                      * next_page is reader_page,
>                                      * new_head is reader->next
>                                      */
>                                     rb_head_page_set_head_update(...,
>                                       new_head, next_page, ...)
>                                     rb_head_page_set_normal(...,
>                                       next_page, tail_page, ...)
>                                     rb_is_head_page(new_head,
>                                       new_head->list.prev)
>                                       /* inspects reader->list.next
>                                        * (RB_PAGE_NORMAL) instead of
>                                        * reader_page->list.next
>                                        * (RB_PAGE_HEAD_UPDATE)
>                                        */
>                                     rb_inc_page(&new_head)  <-- misses head
>   rb_list_head(reader->list.next)->prev =
>     &cpu_buffer->reader_page->list;
> 
> Because every other link in the ring has RB_PAGE_NORMAL, the inner while loop
> wraps around the ring buffer until CPU0 updates list.prev, or deadlocks if the
> writer is an NMI that interrupted __rb_get_reader_page() or rb_insert_pages()
> on the same CPU.
> 
> Since new_head starts as the page right after next_page, tracking prev_page
> forward from next_page as new_head advances via rb_inc_page() would avoid
> touching list.prev on the writer path.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261111160624.1294946-1-vdonnefort@google.com?part=1

Right, using new_head backpointer might be too risky. The prev_page suggestion
looks just better and doesn't invalidate this approach.

-- 
Vincent
