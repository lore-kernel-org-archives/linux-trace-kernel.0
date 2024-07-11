Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109C14E2F1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687653; cv=none; b=R/lFAr8jc7ArZSPOAZ4O76WWvVpvZ9hN8NigmDpWyhOX/CkJx4U+hteD7aYHbTEH2FlTmP0MjPJyw0lbn4tRAkqrLzHEYfCAtM5lFC94Mlmb5kCPbJwsmcEad3fsJf0GlQzHSD69yVxly2OqZgog7cvQlLrd3g/uv2PB10JpKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687653; c=relaxed/simple;
	bh=5ZCyuD2DzmlBuVpILbtQgukvyp/ynyXyNQ79xarcr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9itaoM9LeclZ79zI0qCrnGEZm8GzuVfaXYlvMuT/gcXFn+2b6E5MCFrj8O/hKqT+R/y6Mp40LHqnyzdZIRE+P8iOavj0PMhmkxSyJOZdID+s3A56JewFvOX7hiJ2wRrX3M4R3mdtoJpVNkpoyLuFJtbHa9CGR6ZKLbt9pmTQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM6egutF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM6egutF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720687651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZCyuD2DzmlBuVpILbtQgukvyp/ynyXyNQ79xarcr3k=;
	b=VM6egutF8TMnZXmw8YOIxQcbx1DwISRp+a0calni35JMpusrRch9l59KxMLjG6D/musc+B
	zJ8TdMPQkfMahKOgfOrH5QlK/AKrDJ5W1eCinArXW6GDCkBwxtuTePhA6zr8aGNXDdyabR
	upuiCO5Bd6bIsIVkylYPyjVTZmly08o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-Vfj7cJSFPT63hJ_UL7aRrw-1; Thu,
 11 Jul 2024 04:47:26 -0400
X-MC-Unique: Vfj7cJSFPT63hJ_UL7aRrw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8607C1955BCC;
	Thu, 11 Jul 2024 08:47:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B79EB19560AE;
	Thu, 11 Jul 2024 08:47:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 10:45:47 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:45:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: andrii@kernel.org, mhiramat@kernel.org, clm@meta.com, jolsa@kernel.org,
	mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] uprobes: future cleanups for review
Message-ID: <20240711084451.GA16902@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240711082736.GG4587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711082736.GG4587@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/11, Peter Zijlstra wrote:
>
> On Wed, Jul 10, 2024 at 06:30:22PM +0200, Oleg Nesterov wrote:
> >
> > In fact I would like to push 2 more cleanups before the more significant
> > changes, but they certainly conflict with your ongoing work, albeit only
> > textually.
> >
> > Let me send the patches for review anyway, perhaps you can take at least
> > the 1st one.
> >
> > 3/3 is only compile tested so far. Andrii, can you take a look?
>
> I was going to post a new version today, but I can wait and rebase on

No, I do not want to delay your changes, please send the new version,
I'll rebase these cleanups on top of it.

Oleg.

