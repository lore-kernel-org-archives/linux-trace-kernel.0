Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBD3B8BDB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520307; cv=none; b=MBs8/fA8K0UETRjSPHcZXdEF0zdiYVLNyNAFsBnnuC1YqiPkferP77ALW/pQXVk5svOUXBfl/AcjrqdBWOjLxGVSxYOWNruEQMWLdYflce/nGf5z6kw0xN7VPXGSWtTpcRgrx8LMY8K81+fF251IobrrhMXOPEePMl0QjUVxFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520307; c=relaxed/simple;
	bh=XwHumhvUbjsZZx6dX0d5ZstdJFk3Ok5F202wOZk2XuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I7aaWyiDIKC0cBDqg6oemEn12r03TaFuBMIThaFbaVoVjyqkJIOYcxrQdep6pLIQ+NQX2jPSUH8+hCCYLHi1JVLjqPfnYQf4IaWzZo5Wo7WEqV1+jC2X5GH0nkktY2Pl8BtFLUTE8u2hpMJyWSo9voFbErJSJrrppz+TFm6NpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHvteqVG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHvteqVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778520305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0dxp9iONw+JdupNMyZ/eC2L/6iu9c7qz5ByFon435Y=;
	b=gHvteqVGd46jf1RzsXhcheZ6HqOqLXxhKfHpMaVVWNMeQigXz9TfAIKHwepH6Cmo9mYzgT
	qd6NJ79tgTckciyiR9WFC/uwjq+L3PRK0WeaZuGkIa3Csbwodi3cJXAosNl+tqPVelHBU2
	j1pl7Y+HDyYGgMsY1yPeBUhAX97wLIo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-3c79aWZ6Ms2jZID9URB2aw-1; Mon,
 11 May 2026 13:25:00 -0400
X-MC-Unique: 3c79aWZ6Ms2jZID9URB2aw-1
X-Mimecast-MFC-AGG-ID: 3c79aWZ6Ms2jZID9URB2aw_1778520299
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EDD1195605F;
	Mon, 11 May 2026 17:24:59 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 86F321800465;
	Mon, 11 May 2026 17:24:55 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 May 2026 19:24:58 +0200 (CEST)
Date: Mon, 11 May 2026 19:24:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jolsa@kernel.org,
	peterz@infradead.org, mingo@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agIQ5WC66PwDxsvs@redhat.com>
References: <20260509003146.976844-1-andrii@kernel.org>
 <agHreV1m7MRKUtbh@redhat.com>
 <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 6kUJtHhJkDci-DfqI7e7ay_FrOLX-IQPYODFCu4LRM4_1778520299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 05/11, Andrii Nakryiko wrote:
>
> On Mon, May 11, 2026 at 7:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 05/08, Andrii Nakryiko wrote:
> > >
> > > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe_addr)
> > >  {
> > > -     struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> > > +     struct uprobes_state *state = &current->mm->uprobes_state;
> >
> > it seems that there is a problem, with or without this change...
> >
> > Lets forget about this patch for the moment, I am still trying to understand it.
> >
> > What if register_for_each_vma() calls install_breakpoint(vma) and
> > vma->mm != current->mm ?
> >
> > In this case install_breakpoint() path will call __is_optimized() and then
> > __in_uprobe_trampoline() which does vma_lookup(current->mm). This looks
> > obviously wrong ?
> >
> > And unless I am totally confused, this patch "inherits" the problem...
> >
> > No?
> >
>
> Yes, sashiko called this out as well. I'm going to pass mm explicitly
> into is_optimized and all the way to resolve_uprobe_addr(), easy fix.

Aah... found it: https://sashiko.dev/#/patchset/20260509003146.976844-1-andrii%40kernel.org

And note that sashiko is more clever than me; I didn't realize that _unregister()
has more problems with current->mm :/

> But we should have a stand-alone easily backportable fix for this even
> without my changes, yes. I can add it as pre-patch or send separately.

Agreed. This deserves another/simple fix. If nothing else, for documentation.

Oleg.

