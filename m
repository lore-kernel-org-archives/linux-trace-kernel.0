Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD744E66F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014088; cv=none; b=J7C+gh7EAd4NonAz76TFuFnwP5XcuCigMB05ktrDY1B961jknVHXQsf2ThZ12gk5YGe+UVbMR92dujUHFvy3N79oPpmFpIs95OOTLgD5imAEupAy8DShpnt7kcNu0z8TxK1RMAtMDSOU3dtmzVe4yFDTtld0t0Vv8AFXD8b9MgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014088; c=relaxed/simple;
	bh=8OcZ/XEaNhU6TcWkpG9aw0DsinsbjPLsjEM4oICiU2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ro/XmePvX1SWLWROqI8EkdC1ifaeGEMT9MPqbhdNI1z9leCgvGCnEVjArPCvqpLVm4KvareDZKlSs+paadjObz9ma2lRxsDwG1y4+ycvlWLqoP3OoZ1SMM4KS67rT0alZEN7FVPS8/YdyblL7pJ83sIxyxwU9wSJKvDUlEYTajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWrdY8qq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWrdY8qq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786014085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hyS+yJCTIeJkt0nhMDFmRl1vaJBp/NVdNxilVPkN+o=;
	b=PWrdY8qqA3D9xxZKnFtuhqWO7PyH8mOLjxqDdQbqpTpFyelOUys/WupPIfnkoFUGNmtk1G
	g0jVbfSj+XnHkcz9jpU5J3FHbMoYMzyq8Haagc8D22UIVRzFgRn19qnbb4ry6eDnok50yf
	H7WaviVR/3hi6IwKH5ybscK5etJ2pV0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-N_JIwuDUO1CVszhclOpwlQ-1; Thu,
 06 Aug 2026 07:01:19 -0400
X-MC-Unique: N_JIwuDUO1CVszhclOpwlQ-1
X-Mimecast-MFC-AGG-ID: N_JIwuDUO1CVszhclOpwlQ_1786014077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61CDA19560B9;
	Thu,  6 Aug 2026 11:01:17 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DC0FC3000239;
	Thu,  6 Aug 2026 11:01:13 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Aug 2026 13:01:16 +0200 (CEST)
Date: Thu, 6 Aug 2026 13:01:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anRpdyApCza3MYVi@redhat.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 4gQHrsvEw89Uhglwy3XTos9c3KxFF5_ieWYq34kAjEw_1786014077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sumanth, thanks for details!

On 08/05, Sumanth Korikkar wrote:
>
> So semphore incremented to 2 when a tracer was attached and decremented
> back to 0 when tracer was detached. install_breakpoint() was called for
> both vaddr and succeeded, also remove_breakpoint() succeeded for both
> vaddr.

Then I agree with Andrii, we don't really care. IIUC, only the value of
.active != 0 matters correctness-wise.

> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
> > >  	bool first_uprobe;
> > >  	int ret;
> > >
> > > +	if (!(vma->vm_flags & VM_EXEC))
> > > +		return 0;
> > > +
> >
> > Well, but then it makes more sense to change valid_vma() to nack the
> > non VM_EXEC mappings ?
>
> After looking at your 2012 commit 78a320542e6c ("uprobes: Change valid_vma()
> to demand VM_MAYEXEC rather than VM_EXEC"), I thought changing it in
> valid_vma() was not the right approach.
>
> "If a program maps memory as non executable initially, but it has
> VM_MAYEXEC permission, the program can later call mprotect(PROT_EXEC)
> to make it executable." So adding VM_EXEC in valid_vma() can be too
> strict.

Yes,

> Hence, I think install_breakpoint() can be one point where non VM_EXEC
> mapping can be restricted.

But your change in install_breakpoint() essentually reverts that commit?
If uprobe_register() -> register_for_each_vma() finds a VM_MAYEXEC vma
without VM_EXEC valid_vma() will return true, but then install_breakpoint()
will fail anyway.

Oleg.

