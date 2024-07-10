Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0A1922F2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618381; cv=none; b=i1wqZm+OGbQNNT7fEYCcA4qWsKkkzoRVUIX72qCJJupLXiLE7dwrV8iwxBAToTrDVDk7nbOjiu6UUI2St5sr47mA4BL2KOSg1DSBtTJxBIcQPRgn8VEXNzDbWt6JK+GibVEJQmIRqco3Y1qmEzxG48hWm020/He9lqKeAM4pY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618381; c=relaxed/simple;
	bh=kn8LUbWIe+Gz3RA5JbBKLr6Du3KlZIc1sUeGjfDtUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyJpgsDsEVZp7ZBgbt+x2gLDBW2c4xncVO8jrI0P9zXNCO8CHplra+Y4klJf/b0nDhD5hx+yIWdbUN8QERXNHmnF6jyIKi4zN/95UEoaY3ripz7Fqi3+axoTDwUmMB1dhZWxzNla18XcNeM7XhGXK3CtElvncA1lZ/UEg77OXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAh1bbnT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAh1bbnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720618378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=883k/meUQZ7VdLJT0YsroQR9x4ibt1eMIzZuBlKNXww=;
	b=dAh1bbnTgbbDVZVj9rB5e0gG7NBbsPA3HI7gv7v9BseIkqHjDIasGmuFu6q6wLbfTqKeCo
	6skE/wKMotzZt9JxvKKuy6IKIhmg+3nZ9VvBDLhWWGV/YWw6j5LycmXxddUCHhGL3rGuPR
	B0xEtjkT4nZyFC2rs32/n277fskXaAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-DmqMCUPaMmKvzHdTwEwXfQ-1; Wed,
 10 Jul 2024 09:32:55 -0400
X-MC-Unique: DmqMCUPaMmKvzHdTwEwXfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71F519560B2;
	Wed, 10 Jul 2024 13:32:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 029A91955F3B;
	Wed, 10 Jul 2024 13:32:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 15:31:17 +0200 (CEST)
Date: Wed, 10 Jul 2024 15:31:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	clm@meta.com
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
Message-ID: <20240710133112.GA9228@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-2-andrii@kernel.org>
 <20240703113829.GA28444@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703113829.GA28444@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/03, Oleg Nesterov wrote:
>
> >  	/*
> > -	 * The NULL 'tsk' here ensures that any faults that occur here
> > -	 * will not be accounted to the task.  'mm' *is* current->mm,
> > -	 * but we treat this as a 'remote' access since it is
> > -	 * essentially a kernel access to the memory.
> > +	 * 'mm' *is* current->mm, but we treat this as a 'remote' access since
> > +	 * it is essentially a kernel access to the memory.
> >  	 */
> >  	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
>
> OK, this makes it less confusing, so
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
> ---------------------------------------------------------------------
> but it still looks confusing to me. This code used to pass tsk = NULL
> only to avoid tsk->maj/min_flt++ in faultin_page().
>
> But today mm_account_fault() increments these counters without checking
> FAULT_FLAG_REMOTE, mm == current->mm, so it seems it would be better to
> just use get_user_pages() and remove this comment?

Well, yes, it still looks confusing, imo.

Andrii, I hope you won't mind if I redo/resend this and the next cleanup?

The next one only updates the comment above uprobe_write_opcode(), but
it would be nice to explain mmap_write_lock() in register_for_each_vma().

Oleg.

