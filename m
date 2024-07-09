Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460517B045
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550983; cv=none; b=q+OxxiMUw4/oKGxSn+4G0BoQiyCxyuC8smjkZ93ksRIfQ8wT6khqFHrPlj0MRkhB3c3vnp963nNrFM+AKLNf6IsCj/fa4otTUPbIFOCK/hhnMxO/u5k+4TCiS4OKFkL9s/9i87yZHQXK0Re7bmiG5kodI2n1sZGUt0GIuu1myrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550983; c=relaxed/simple;
	bh=r0kavy+l4byHNKijAteeqnTYHegvuUsrmKYpdJw9DJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzNBfODv4p9wfDVZgM5AOByYcFoVNCTRE/ctuHwZYcq2UbBivMHVeXqPxtlEopwF9uUIwq7zETyFDse5bMQTL6QAwPfv9RwFyby89lAJA8p5RjzLJI586HY5IeEMO8UO35ue2Dsa8JhNTbvkRnAL3El018j/lOeEuYwb5xufFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1LJqh6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1LJqh6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720550980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0kavy+l4byHNKijAteeqnTYHegvuUsrmKYpdJw9DJ0=;
	b=Q1LJqh6Gb5csJazWbWafRhWx7s/bU/8tw/JZzuNJ9Ke8U7sI10yZLZdZX85ilpY9Hb5bzs
	rb8wLWMGILWhWpl0xrCyp8Tvz9+6KQDRgPUhKaM8OnKz/mr4k23qCMr7/vMMQe/bFqiMA+
	C04qbHWUXtXPbjeE582QOdO6pfD6BTo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-O3XluInyOaqczJhocrnWww-1; Tue,
 09 Jul 2024 14:49:37 -0400
X-MC-Unique: O3XluInyOaqczJhocrnWww-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E1E1955BC4;
	Tue,  9 Jul 2024 18:49:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A7B291955F3B;
	Tue,  9 Jul 2024 18:49:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 20:47:59 +0200 (CEST)
Date: Tue, 9 Jul 2024 20:47:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240709184754.GA3892@redhat.com>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240705153705.GA18551@redhat.com>
 <20240707144653.GB11914@redhat.com>
 <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYZCVNFQcVBPue4uom+StiCQA6ObR7Z-sKzcEZyTiSyRA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/08, Andrii Nakryiko wrote:
>
> On Sun, Jul 7, 2024 at 7:48 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > And I forgot to mention...
> >
> > In any case __uprobe_unregister() can't ignore the error code from
> > register_for_each_vma(). If it fails to restore the original insn,
> > we should not remove this uprobe from uprobes_tree.
> >
> > Otherwise the next handle_swbp() will send SIGTRAP to the (no longer)
> > probed application.
>
> Yep, that would be unfortunate (just like SIGILL sent when uretprobe
> detects "improper" stack pointer progression, for example),

In this case we a) assume that user-space tries to fool the kernel and
b) the kernel can't handle this case in any case, thus uprobe_warn().

> but from
> what I gather it's not really expected to fail on unregistration given
> we successfully registered uprobe.

Not really expected, and that is why the "TODO" comment in _unregister()
was never implemented. Although the real reason is that we are lazy ;)

But register_for_each_vma(NULL) can fail. Say, simply because
kmalloc(GFP_KERNEL) in build_map_info() can fail even if it "never" should.
A lot of other reasons.

> I guess it's a decision between
> leaking memory with an uprobe stuck in the tree or killing process due
> to some very rare (or buggy) condition?

Yes. I think in this case it is better to leak uprobe than kill the
no longer probed task.

Oleg.

