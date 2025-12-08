Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796B2E5B19
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189770; cv=none; b=fvCCCyI/sSZnOrkZZfzw5wobyiixsVwo91PfW+vDa8MHqKx1qZoPcD6UZE6pG6QZx4ZNfPIJvC2HAxoU7RzahgdIcaXhzVFWhIrrM3Srcha8VN1Q2zlmHRiJhn0QPD25LspAQ05ZBrqDdmpac8JIVJnuxUbilnJQDiHvqO2hQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189770; c=relaxed/simple;
	bh=Lai2720BhSwYhpwgkcvbksu2hyCojtOkg28bQeIJf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL5PlY4IgIDDpqmzHTBEmvQwsMuoPJGWyuA3HIFvLQSfVVVOKIFIAButvRLKVL1olOhSp2VOM8pFZmicQhiguewwAK+0v43725JHnYgOHkznG1yOa7KB99DjqhixCdM+tKyF5/1Kv1NHM+a82A3IHzffACmnFtuUs102Fnp/Bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rl6NRuOC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rl6NRuOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765189767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lai2720BhSwYhpwgkcvbksu2hyCojtOkg28bQeIJf4Q=;
	b=Rl6NRuOCx3epes229VYIwW9/dO/i+4C24SUDgkKDRQuyjWCTOLi5UEuQZBmBB996qTux2h
	v2VNRQEtbsfMnBVfmJp9VUn00Qlsa497+/LJqY+ly5Idib9JB/aen/qU3VgzrxXmennE3F
	uesgu7uTq0KCx1uh0/bzN9aqfqnsUZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-Puq_hxsiMPi3trjBsX9Jew-1; Mon,
 08 Dec 2025 05:29:19 -0500
X-MC-Unique: Puq_hxsiMPi3trjBsX9Jew-1
X-Mimecast-MFC-AGG-ID: Puq_hxsiMPi3trjBsX9Jew_1765189757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 049101956054;
	Mon,  8 Dec 2025 10:29:17 +0000 (UTC)
Received: from fedora (unknown [10.45.224.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E6D9F19560B0;
	Mon,  8 Dec 2025 10:29:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Dec 2025 11:29:16 +0100 (CET)
Date: Mon, 8 Dec 2025 11:29:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 0/8] uprobe/x86: Add support to optimize prologue
Message-ID: <aTaodcF1ACgQneRT@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
 <aSSgGu8X04XoYN8D@redhat.com>
 <20251208153056.3a4e9cd3511ccf00dc12e265@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208153056.3a4e9cd3511ccf00dc12e265@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/08, Masami Hiramatsu wrote:
>
> On Mon, 24 Nov 2025 19:12:42 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 11/17, Jiri Olsa wrote:
> > >
> > > There's an additional issue that single instruction replacement does
> > > not have and it's the possibility of the user space code to jump in the
> > > middle of those 5 bytes. I think it's unlikely to happen at the function
> > > prologue, but uprobe could be placed anywhere. I'm not sure how to
> > > mitigate this other than having some enable/disable switch or config
> > > option, which is unfortunate.
> >
> > plus this breaks single-stepping... Although perhaps we don't really care.
>
> Yeah, and I think we can stop optimization if post_handler is set.

Hmm, why? This doesn't depend on whether ->ret_handler is set or not...

Oleg.

