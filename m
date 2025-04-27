Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB012E5B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Apr 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775353; cv=none; b=cfMKap3RsMuK+eJUglHY7D/G47Z6fKQio74EtmQclhFO96j6hdyc4urlGA1VlcAVU4VTMWg/QIEi+C2WE3y4lJA+HRe0SO5o/NH+rnTMZxGh+M5dSwOwRcrbn+8wgQPf1TSd7U3TTB3GL/Yk9Lp/WenySmrkNFTNmZLMBCHOIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775353; c=relaxed/simple;
	bh=Hr4UNTEHhVCVvZZ5zXuIRfth2rd/d6VKF7EoePZkF4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxutxXKJq3ddpC6LHdZ0Jq5aGMRig5mReNV3IguY3MNYeOcugxxbyn5BObXR9p3lA/gcVrFedi+y7LQMNCSkbBVl0HMSdalgnQJQgJ3/6JdKlp82fur750fKZKp1Yl/T1fQDP78GX3ja/QRcNryiDo+UWSUk1aA9C0uycXHLDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNGbX20N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNGbX20N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745775350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5TEWWf8DnLfanIEH5dtDU1MuQbJuWxGwB5fnm81OcU=;
	b=eNGbX20No6zl6MKQNBeu5gNhgrmc4iyMdm8b2gpnnPqwEppRI4+De5Xm7jQKp4akhmlcUX
	2JATDRgQwGykiQaRiEK4/7QC/dtZxdGbBVBuJ2G1OTASzZcVo5N3V30R6VOeMMJRZWKDNI
	DTeOkty/bmTu9xDKKYKZ9zVgIlhui5k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-_InogbtzN7WQV-c7OXCMDw-1; Sun,
 27 Apr 2025 13:35:46 -0400
X-MC-Unique: _InogbtzN7WQV-c7OXCMDw-1
X-Mimecast-MFC-AGG-ID: _InogbtzN7WQV-c7OXCMDw_1745775344
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 587421800263;
	Sun, 27 Apr 2025 17:35:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D28419560A3;
	Sun, 27 Apr 2025 17:35:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Apr 2025 19:35:04 +0200 (CEST)
Date: Sun, 27 Apr 2025 19:34:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <20250427173456.GB27775@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-9-jolsa@kernel.org>
 <20250427145606.GC9350@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427145606.GC9350@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 04/27, Oleg Nesterov wrote:
>
> On 04/21, Jiri Olsa wrote:
> >
> > +static unsigned long find_nearest_page(unsigned long vaddr)
> > +{
> > +	struct vm_area_struct *vma, *prev = NULL;
> > +	unsigned long prev_vm_end = PAGE_SIZE;
> > +	VMA_ITERATOR(vmi, current->mm, 0);
> > +
> > +	vma = vma_next(&vmi);
> > +	while (vma) {
> > +		if (prev)
> > +			prev_vm_end = prev->vm_end;
> > +		if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
> > +			if (is_reachable_by_call(prev_vm_end, vaddr))
> > +				return prev_vm_end;
> > +			if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
> > +				return vma->vm_start - PAGE_SIZE;
> > +		}
> > +		prev = vma;
> > +		vma = vma_next(&vmi);
> > +	}
> > +
> > +	return 0;
> > +}
>
> This can be simplified afaics... We don't really need prev, and we can
> use for_each_vma(),
>
> 	static unsigned long find_nearest_page(unsigned long vaddr)
> 	{
> 		struct vm_area_struct *vma;
> 		unsigned long prev_vm_end = PAGE_SIZE;
> 		VMA_ITERATOR(vmi, current->mm, 0);
>
> 		for_each_vma(vmi, vma) {
> 			if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
> 				if (is_reachable_by_call(prev_vm_end, vaddr))
> 					return prev_vm_end;
> 				if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
> 					return vma->vm_start - PAGE_SIZE;
> 			}
> 			prev_vm_end = vma->vm_end;
> 		}
>
> 		return 0;
> 	}

Either way it doesn't look nice. If nothing else, we should respect
vm_start/end_gap(vma).

Can't we do something like

	struct vm_unmapped_area_info info = {};

	info.length = PAGE_SIZE;
	info.low_limit  = vaddr - INT_MIN + 5;
	info.high_limit = vaddr + INT_MAX;
	
	info.flags = VM_UNMAPPED_AREA_TOPDOWN; // makes sense?

	return vm_unmapped_area(&info);

instead ?

Oleg.

