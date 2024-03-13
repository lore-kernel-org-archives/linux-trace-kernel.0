Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220E43AAF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336058; cv=none; b=ErTk7YgIRAEbnjeYdSwhINKY3R24yXORTvS6tp/vpoWF86YzyWt5K53Ia7V7dVQzzd0VCROiRvauN0TpDHfqnXSjmhsVEejjbQbW9g0ebLbkMnlSoF7AfzwwdLybqsBfUvJVwLRGkQn8N4uYiFYMZRSbaMAn4RJ6AR8Hz9X/1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336058; c=relaxed/simple;
	bh=FaT4XGiP/1deYiwr6gMlT38Yu4UeP83mybH7QKeqj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSOjFwqGfoWYjlkRTD9t+FV11elYzj5z4lGSz6lgJYrOHfAm0AyGM57YDwHUTcOBtYRYvQ8Osir4qO7vp0Zfq0+F/PdbAXGLncAy14J/SL1OIRe7SYv9sUzkvGCh/W1XSI6slpCxrCEPd7taJPKI43G2YfaGAxh/1CivzSKB+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpnByxP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpnByxP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710336054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9AU0bydAYPASchpnpF2gWjzciQAPMb4OtYaMryl0jc=;
	b=ZpnByxP3a1EC3rLcm5WXjBNK/tJfzfH/o/KKkQyUqosfU0/LVDAwv7bza0Hn5ZzhB7D6Vo
	PQVYI6HlcAWjkbY0JP7GBy7H0JJ9WvTO8Xw4lJAuPWzxVJQBrAAiti2XAUEHQUZJeH3qbW
	/VlWV9FlqyxthVhMZfgIn0Gfgv9CmVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-gV73DBrjPaWDGE1FfRfGdw-1; Wed, 13 Mar 2024 09:20:51 -0400
X-MC-Unique: gV73DBrjPaWDGE1FfRfGdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A17101CC63;
	Wed, 13 Mar 2024 13:20:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.233])
	by smtp.corp.redhat.com (Postfix) with SMTP id D189B2166B4F;
	Wed, 13 Mar 2024 13:20:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Mar 2024 14:19:29 +0100 (CET)
Date: Wed, 13 Mar 2024 14:19:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] uprobes: add speculative lockless
 system-wide uprobe filter check
Message-ID: <20240313131926.GA19986@redhat.com>
References: <20240312210233.1941599-1-andrii@kernel.org>
 <20240312210233.1941599-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312210233.1941599-4-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

I forgot everything about this code, plus it has changed a lot since
I looked at it many years ago, but ...

I think this change is fine but the changelog looks a bit confusing
(overcomplicated) to me.

On 03/12, Andrii Nakryiko wrote:
>
> This patch adds a speculative check before grabbing that rwlock. If
> nr_systemwide is non-zero, lock is skipped and event is passed through.
> From examining existing logic it looks correct and safe to do. If
> nr_systemwide is being modified under rwlock in parallel, we have to
> consider basically just one important race condition: the case when
> nr_systemwide is dropped from one to zero (from
> trace_uprobe_filter_remove()) under filter->rwlock, but
> uprobe_perf_filter() raced and saw it as >0.

Unless I am totally confused, there is nothing new. Even without
this change trace_uprobe_filter_remove() can clear nr_systemwide
right after uprobe_perf_filter() drops filter->rwlock.

And of course, trace_uprobe_filter_add() can change nr_systemwide
from 0 to 1. In this case uprobe_perf_func() can "wrongly" return
UPROBE_HANDLER_REMOVE but we can't avoid this and afaics this is
fine even if handler_chain() does unapply_uprobe(), uprobe_perf_open()
will do uprobe_apply() after that, we can rely on ->register_rwsem.

> In case we speculatively read nr_systemwide as zero, while it was
> incremented in parallel, we'll proceed to grabbing filter->rwlock and
> re-doing the check, this time in lock-protected and non-racy way.

See above...


So I think uprobe_perf_filter() needs filter->rwlock only to iterate
the list, it can check nr_systemwide lockless and this means that you
can also remove the same check in __uprobe_perf_filter(), other callers
trace_uprobe_filter_add/remove check it themselves.


> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1351,6 +1351,10 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
>  	tu = container_of(uc, struct trace_uprobe, consumer);
>  	filter = tu->tp.event->filter;
>
> +	/* speculative check */
> +	if (READ_ONCE(filter->nr_systemwide))
> +		return true;
> +
>  	read_lock(&filter->rwlock);
>  	ret = __uprobe_perf_filter(filter, mm);
>  	read_unlock(&filter->rwlock);

ACK,

but see above. I think the changelog should be simplified and the
filter->nr_systemwide check in __uprobe_perf_filter() should be
removed. But I won't insist and perhaps I missed something...

Oleg.

