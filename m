Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC571ABEB9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637157; cv=none; b=tYyoPhU6wrohyUmDu73fA5Oe7RBua2u1Pv3TKNGhbbQ20ppQ++P6TiCrfygb355NTc72xQahrIJk61xw04M0cwmFZ7H4C7TpGGkCDu6CNiw1JhUTZmM7M/XUEEJEWugJkPkXZYfimKUaQ9aQJ6Kel4t8DRRXeLORcVJY8LZK/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637157; c=relaxed/simple;
	bh=zjDuUj9eWtqN6r8ONlCdjkOqYfYxbs7W4wvu3c5lOPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5H5SKcf9Ypv4vN/H3G6LvQ4vpZexGpTFPP6OjAi95VXqFcYqdkz+ToRyr4bCm/RuAWlMrbzc7T9TRAYIik+6y7Utmo8wbIwcco1sTvua1qIcW79BxamnatMQlQxAK86icfd2s9nUh6VynXRit4UOsIttVyW564iP805FFAQEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmdyV/zr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmdyV/zr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722637155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr8Txo5D6NSIUjs4UMtM8VDYYilFkkV0/HEbDlasuVw=;
	b=EmdyV/zrNMqLK7s87UQcg4t0FPt3kX9vG0ZjAjT7F5nEKbP1Uj5b+PaC3zU3HdB+T3buKu
	/6nSPaGLvuxdmqSySV7ByES4OQwf456xh+tvHPfIWl/yyAi+xJInDgGiG22g+HtFndHVwI
	vKdfdqcJFW9Qh6e1QX2G2N6AaQPjmeU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-ux8m-Y0dMlusQHBdh_VCOQ-1; Fri,
 02 Aug 2024 18:19:11 -0400
X-MC-Unique: ux8m-Y0dMlusQHBdh_VCOQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CF5A1955D42;
	Fri,  2 Aug 2024 22:19:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6B319300018D;
	Fri,  2 Aug 2024 22:19:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  3 Aug 2024 00:19:08 +0200 (CEST)
Date: Sat, 3 Aug 2024 00:19:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240802221902.GB20135@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
 <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
 <20240802085040.GA12343@redhat.com>
 <CAEf4BzY7fBZBJo3PGaDLp6yzpi7S9QTkcirP+Nz03rL2wcU-0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY7fBZBJo3PGaDLp6yzpi7S9QTkcirP+Nz03rL2wcU-0A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/02, Andrii Nakryiko wrote:
>
> On Fri, Aug 2, 2024 at 1:50 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/01, Andrii Nakryiko wrote:
> > >
> > > > +               /* TODO : cant unregister? schedule a worker thread */
> > > > +               WARN(err, "leaking uprobe due to failed unregistration");
> >
> > > Ok, so now that I added this very loud warning if
> > > register_for_each_vma(uprobe, NULL) returns error, it turns out it's
> > > not that unusual for this unregistration to fail.
> >
> > ...
> >
> > > So, is there something smarter we can do in this case besides leaking
> > > an uprobe (and note, my changes don't change this behavior)?
> >
> > Something like schedule_work() which retries register_for_each_vma()...
>
> And if that fails again, what do we do?

try again after some timeout ;)

> Because I don't think we even
> need schedule_work(), we can just keep some list of "pending to be
> retried" items and check them after each
> uprobe_register()/uprobe_unregister() call.

Agreed, we need a list of "pending to be retried", but rightly or not
I think this should be done from work_struct->func.

Lets discuss this later? We seem to agree this is a known problem, and
this has nothing to do with your optimizations.

> I'm just not clear how we
> should handle stubborn cases (but honestly I haven't even tried to
> understand all the details about this just yet).

Same here.

Oleg.

