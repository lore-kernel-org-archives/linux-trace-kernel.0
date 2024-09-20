Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97001143898
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830209; cv=none; b=t/UtCYyMNRzPfsokYX9vaH0mwlBY5PbVYB3KLLirNr/76zVbt+xwZMCOyoWW5tMETEGRo5s+ujnboU9KiVPtoOpuxzIL3vSxPYtFElw+yhAgoSaOvC9XVceFVXnx8YkiRVhLAfRdX68Z6wpW3Eob6rH+oDDIfqvmt/7d7xz43mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830209; c=relaxed/simple;
	bh=t6PyiaU+q5uLSGJpe7i/vY50/CfRtYLyGpxj/y9mOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8rHEzrK0Jy9F8/Ocx5VMRyz6nP5iMMUyxhUmGpvREGetcWaFwdMW4RTQYQYY65zVIlRJoNvaWQe9Y1dF3XqsitqhBXY/d4aEYikbFwO5eJ57Ifriq/nmVsE+HaROYsG3q1rziQW/owx76Oau2jUDyInyxBBAVvKu30Ud4ISgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abQNlWMv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abQNlWMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726830206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pdqIvSPYWLb/TIk+26OrGjim3sMahhGwrllbas8MQY=;
	b=abQNlWMvvetqqqst7LCM01RFcVikoSmwxyYBSgfdCaLSFYiyHjJlmEdtFfTWXu9flcsUQj
	ZYWQHenTXjUr2QKw5c/HhK7uZXn/deACUUI3OhRI2WeNswBpHvEMyTVrDGycaE4DI8lL5c
	FytLIQfRH1jsuH3m9c8Fhs18I1DlJvk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-4iI78YvhOFmvGhS3JrhF-A-1; Fri,
 20 Sep 2024 07:03:20 -0400
X-MC-Unique: 4iI78YvhOFmvGhS3JrhF-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64F1E192DE09;
	Fri, 20 Sep 2024 11:03:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8B7C819560AA;
	Fri, 20 Sep 2024 11:03:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 20 Sep 2024 13:03:07 +0200 (CEST)
Date: Fri, 20 Sep 2024 13:03:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240920110301.GB15795@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/20, Liao, Chang wrote:
>
> 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > On 09/19, Liao Chang wrote:
> >>
> >> --- a/arch/arm64/kernel/probes/uprobes.c
> >> +++ b/arch/arm64/kernel/probes/uprobes.c
> >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >>  	void *xol_page_kaddr = kmap_atomic(page);
> >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> >>
> >> +	if (!memcmp(dst, src, len))
> >> +		goto done;
> >
> > can't really comment, I know nothing about arm64...
> >
> > but don't we need to change __create_xol_area()
> >
> > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> >
> > to avoid the false positives?
>
> Indeed, it would be safer.
>
> Could we tolerate these false positives? Even if the page are not reset
> to zero bits, if the existing bits are the same as the instruction being
> copied, it still can execute the correct instruction.

OK, agreed, the task should the same data after page fault.

Oleg.

