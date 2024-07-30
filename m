Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44391A76B2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359869; cv=none; b=lonrKXAjrE6L54LQlqSQa8FEpolrMy5hpglV0yU0sdEYwqUq4H89PpoaP4a7eRiiv85+MEwmXl+Hrxx3KAYCVQM7qC1+K91vtSY3ndhc1mpubDeMbsEJBxpD8EwXvI8TMqnP0bdfaiQvZgeidhsWaLgFI8p28LYD421yRFIZU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359869; c=relaxed/simple;
	bh=7S8qBivfmksIDCRjowz+E3chlu8P6UM7PipkX6yM/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6G8U4iEEGVMZMuW6BD+LA995TAMtC6GQPTzS0OfQ4+FQcBzqfRhuaZiGievuEd2aO/hGh+vdfC+9hPOH2nfY/yQnCn/CX6OBeWYa9R9N1h/PUUDrp8t0qnEWM93vuaxyNYCWEjqhCJLXZ9I31r8bRzx/JU518SeKnER6Bfyrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpJt54++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpJt54++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722359866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s7X5S4hdI3KRREsro0BMCE0/9TvraRM4Id7gYH2wZOw=;
	b=QpJt54++rejzAD9xW02vG7ipgzifxYowpSfaRPvDNdx0qqXKw0xcLyq3iPdo9bvFIAyA5A
	qHC8hQ1nvUpGTjXW492jRHt9IBT/R0NIwZzVZOG5WE42btvdZcyvggs8oyYk8ZWOgYvQFD
	ZSQWaX7xRYgva+7t/0U2/bpOMhZDU4E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-YS0d8ur5OP21uxpvspE9ZA-1; Tue,
 30 Jul 2024 13:17:41 -0400
X-MC-Unique: YS0d8ur5OP21uxpvspE9ZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 246271955D4A;
	Tue, 30 Jul 2024 17:17:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 09EDF1955F3B;
	Tue, 30 Jul 2024 17:17:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 19:17:38 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:17:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240730171733.GA10822@redhat.com>
References: <20240730123421.GA9085@redhat.com>
 <20240730123457.GA9108@redhat.com>
 <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thanks for looking at this!

On 07/30, Andrii Nakryiko wrote:
>
> BTW, do you have anything against me changing refcounting so that
> uprobes_tree itself doesn't hold a refcount, and all the refcounting
> is done based on consumers holding implicit refcount and whatever
> temporary get/put uprobe is necessary for runtime uprobe/uretprobe
> functioning.

No, I have nothing against.

To be honest, I don't really understand the value of this change, but
a) this is probably because I didn't see a separate patch(es) which
does this and b) assuming that it doesn't complicate the code too much
I won't argue in any case ;)

And in fact I had your proposed change in mind when I did these cleanups.
I think that they can even simplify this change, at least I hope they can
not complicate it.

> BTW, do you plan
> any more clean ups like this? It's a bit of a moving target because of
> your refactoring, so I'd appreciate some stability to build upon :)

Well yes... may be this week.

I'd like to (try to) optimize/de-uglify register_for_each_vma() for
the multiple-consumers case. And, more importantly, the case when perf
does uprobe_register() + uprobe_apply().

But. All these changes will only touch the register_for_each_vma() paths,
so this is completely orthogonal to this series and your and/or Peter's
changes.

> Also, can you please push this and your previous patch set into some
> branch somewhere I can pull from, preferably based on the latest
> linux-trace's probes/for-next? Thanks!

Cough ;)

No, sorry, I can't. I lost my kernel.org account years ago (and this is
the second time this has happened!), but since I am a lazy dog I didn't
even bother to try to restore it.

> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

> > @@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> >                 err = register_for_each_vma(uprobe, NULL);
> >
> >         /* TODO : cant unregister? schedule a worker thread */
> > -       if (!err && !uprobe->consumers)
> > -               delete_uprobe(uprobe);
> > +       if (!err) {
> > +               if (!uprobe->consumers)
> > +                       delete_uprobe(uprobe);
> > +               else
> > +                       err = -EBUSY;
>
> This bit is weird because really it's not an error... but this makes
> this change simpler and moves put_uprobe outside of rwsem.

Agreed, uprobe->consumers != NULL is not an error. But we don't return
this error code, just we need to ensure that "err == 0" means that
"delete_uprobe() was actually called".

> With my
> proposed change to refcounting schema this would be unnecessary,

Yes.

Oleg.

