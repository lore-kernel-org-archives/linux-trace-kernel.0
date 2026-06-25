Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324EE1A5B90
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395313; cv=none; b=tnrcITUGXKcvKVjB+WVasFTApFblh01a5P17JpEDYjZJx8nUKhbuozXgOL1FdhyH5HHdEyOLMCC1cxq9WFvc/jMitiBRKUwGnkhxclLqaWmhsYiyfBWL+WlccqVcMXKYwu5X98FdohX+iR6yTpYzuwOttKyU84ou9S/YAC3zgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395313; c=relaxed/simple;
	bh=T19PEqTyX9tMQyGDoMXCvQiLrw0aQcKeYXwtmVCtvi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m45kisYm6TofGv+CtpRbmyrmShszcapDEbrmv3sKI04vW0VdmiMbRKVkoh6nTD94Bk5r3q6fd4pJ78XcJ3x+ZPf/u9ABVgsaK+/uwXtUWE9jgDTNVxPzVSku1MkcR4xcUEMgWwWAQLi+R/iHSxKsGdDAQJXYsr9HA4q8JAuQ3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zgv17TGk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zgv17TGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0IpTqu/z4GnFZE6CmkOd3go5T9JW8HRVSpYB0rd17SM=;
	b=Zgv17TGkvciJDXqWyEqdLpRZfyFcYTM7VcPWnDmEGsL3L0qe9G+bB4W9S5l8j3tmS+y0ou
	Y6YxiBmQ9/lPQSmObYKbz8i4hxq7v3mipP6TdaKdUNReFDWRtmb7eJx5B3uvnfElmNt6xY
	+YhuOzYEuYDQJTAIHZNw6GlOw2z6Sc8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-FvjnBgH4MEq-vAndbcS9WA-1; Thu,
 25 Jun 2026 09:48:25 -0400
X-MC-Unique: FvjnBgH4MEq-vAndbcS9WA-1
X-Mimecast-MFC-AGG-ID: FvjnBgH4MEq-vAndbcS9WA_1782395304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D60BC18A0E21;
	Thu, 25 Jun 2026 13:48:23 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5A5941956088;
	Thu, 25 Jun 2026 13:48:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jun 2026 15:48:23 +0200 (CEST)
Date: Thu, 25 Jun 2026 15:48:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <aj0xonQHcEQgIi77@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
 <ajvrZ_mMXnKrWf7h@redhat.com>
 <aj0veiIdtp3YcKyK@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aj0veiIdtp3YcKyK@krava>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 4BgxFMtfJj2HmlR9x04kUOQ7mKp2uEQ-7Mq4c1jYikM_1782395304
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/25, Jiri Olsa wrote:
>
> On Wed, Jun 24, 2026 at 04:36:23PM +0200, Oleg Nesterov wrote:
> >
> > Perhaps we can later optimize this code a bit? I mean something like
> >
> > 	start_reachable = ...;
> > 	end_reachable = ...;
> >
> > 	VMA_ITERATOR(vmi, mm, start_reachable);
> >
> > 	for_each_vma(vmi, vma) {
> > 		if (!vma_is_special_mapping(...))
> > 			continue;
> > 		if (vma->vm_start > end_reachable)
> > 			break;
> > 		return vma;
> > 	}
>
> looks good, will try to use that

See my next email, we can use for_each_vma_range().

But let me repeat, we can add this mimor optimization later, I don't want
to delay this series.

> > >  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > >  				  unsigned long vaddr)
> > >  {
> > > -	struct uprobe_trampoline *tramp;
> > > -	struct vm_area_struct *vma;
> > > -	bool new = false;
> > > -	int err = 0;
> > > +	struct pt_regs *regs = task_pt_regs(current);
> > > +	struct vm_area_struct *vma, *tramp;
> > >
> > > +	if (!user_64bit_mode(regs))
> > > +		return -EINVAL;
> > >  	vma = find_vma(mm, vaddr);
> > >  	if (!vma)
> > >  		return -EINVAL;
> >
> > I guess find_vma() can't fail, the caller arch_uprobe_optimize() has called
> > copy_from_vaddr() under mmap_write_lock()... Nevermind.
>
> hum, how's that.. I'll check, but where's the magic? :)

arch_uprobe_optimize() -> copy_from_vaddr() reads this mm at the same vaddr,
this means that vma at this vaddr must exist. Unless I am totally confused ;)
But even if I am right please ignore. I just tried to understand if find_vma()
can fail or not here.

Oleg.

