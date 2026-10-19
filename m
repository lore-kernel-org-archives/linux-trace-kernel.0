Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427465;
	b=jM045pZCMgKnJ0SWi2TyeFIkkotQsjXbXCs5E/ueyq9/tIoflbyaA5VbgVVhFlTK/lAy
	 d6L0dcLrfC+NCvwlpdwT5koEwRP0c2VRCJV+UbBQYTniATLa61YOH/WgUXbWqFif6Wxzv
	 Zn6FrQ2FPjW81356VgXkIqb3w4HuYdyK3CUrpoksZi6TfNt30Chu2APAA7BQuP28VhbH1
	 uzIyDUnWlkAfizsOfkgnr7pg0B9pLeSE7jb11OJoiN25o1YaKURT8uL+oRJOfK7rNKgMX
	 g8TCccOhfN5+wTRUz97fTJv4F2urlTAJdZcP98zbsYB5yIwd6Z/IMUGasdY/V+IkkIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427465;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=7vGFlsnjZ5TUMr/EjNcJOClHWlRBtcNRQf4NXslTfyM=;
	b=DcaiwapyH9q2ZUEVN04kjXrdhK4Ydwo3Oqli1nDrnQv+v9L08KVyCsVmBc0UZVTZQnzO
	 t8mnejZeMyDTOlJiwk6yMFNxBGf6BsHp9xwN3rzB95Yrx8OKT4rCq0uCxCtaA7Odo+3kU
	 PKSvicigQjcCx/D9JwfhQESP3P7xO+CQZUTJdgAvEKkdNuIDmeyvZqmvXnfcM+0g0znPR
	 Z++CVkiNXBCj4+0z9QMFtu/XKuElSK6KHnUPT78G7vt6g569aYcZeY4xOHWl61jwSFOjA
	 Yk1MEnKqjPUlTxR/6hSkk3MeipaXr8aRzsY8bzU5PRahkGQkGGLWngdn7JN4DJR2iWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gmdbnzX7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBB606A319
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 16:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02DBB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gmdbnzX7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792427464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vGFlsnjZ5TUMr/EjNcJOClHWlRBtcNRQf4NXslTfyM=;
	b=gmdbnzX7F5ODU+AlpEshK5MbE9GucbbHMZuxxXWoJDqDdtq5gQ4WzF4uFZzwXcV1XB5Equ
	ZcixMuxSiyRCKMgsCfRFlVXfJx37eJbdwKidWyDc/WciuL88AJjHcvbLRwYcvGZNj0HYAU
	i3tVCYVNxUbZOg3deeoU5gPflBreOzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-Rx91e-ptPqaFVRcYxJHLXA-1; Mon,
 19 Oct 2026 16:31:02 +0000
X-MC-Unique: Rx91e-ptPqaFVRcYxJHLXA-1
X-Mimecast-MFC-AGG-ID: Rx91e-ptPqaFVRcYxJHLXA_1792427460
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9488C1800EF5;
	Mon, 19 Oct 2026 16:30:59 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9F5241803A40;
	Mon, 19 Oct 2026 16:30:54 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 19 Oct 2026 18:30:59 +0200 (CEST)
Date: Mon, 19 Oct 2026 18:30:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	andrii@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
Message-ID: <atZFvTrDIyBtzWbo@redhat.com>
References: <20261019080709.477548-1-18983559317@163.com>
 <atX2FsqHIkOvhrLy@redhat.com>
 <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Y-E3UAZKS3HvTFoRV4gkWyco_xDErac538ZBEB3mzos_1792427460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 10/19, Andrii Nakryiko wrote:
>
> On Mon, Oct 19, 2026 at 3:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 10/19, Binbin Deng wrote:
> > >
> > > consumer_add() publishes a consumer on uprobe->consumers
> > > before assigning its session ID.  handler_chain() traverses the consumer
> > > list under the trace RCU read-side critical section and can therefore
> > > observe the new consumer while uc->id still contains its initial value.
> > >
> > > The race is reachable when an uprobe at the same inode:offset is already
> > > active and a task hits its entry breakpoint while another CPU registers a
> > > second session consumer.  handler_chain() may store the stale ID in the
> > > return_instance consumer array.  By the time the function returns,
> > > uc->id has been assigned a nonzero value, so return_consumer_find() fails
> > > to match the saved ID and the session ret_handler is incorrectly skipped.
> >
> > I guess we don't really care, this doesn't differ from the case when
> > consumer_add() is called right after list_for_each_entry_rcu() in
> > handler_chain().
>
> that uc->id is important for "uprobe session" semantics,

Yes, but

> which seems a
> bit different situation compared to barely missing consumer_add() in
> handler_chain(),

I must have missed something... If handler_chain() misses consumer_add()
then push_consumer(uc->id) won't be called.  This means that then later
handle_uretprobe_chain() -> return_consumer_find(uc->id) will equally fail?

> but regardless, the fix looks good, we should apply it
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Agreed, I have acked it too.

Oleg.

