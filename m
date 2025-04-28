Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C826158A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840506; cv=none; b=qnGvnEzfTBbPZpsSKYhxFiVUMOBD9mxH7JFr0xqtCEUL5JKXRaCOwWz0D58mbMEN3nnRKVEVFCe53SKf6jtY9oB19zTb6LBHOvKN7PN6ZqYn+4ifPqR6l6jVvMfwRRNTrzZ4B4F9fBW4xn7VZSZCUFjaLJL0pZpsr2TnSun72b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840506; c=relaxed/simple;
	bh=LII0rjVz6xDpWfX4i2Uq1BgoozfTJSUr+S+3gbMdj/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+6nM9G8aEceHBjJSfcKpwlyJHwlJekH9PAv6NHYosj9CONajpI6ihpL70sDKun4KTfEb/+IakR0L8KJfWQsGlXSEsC7kFh/9YrAOCve3dMGlvPhaUrFYs+JymQkQm44IiSqvdRiFfZog4FR+ErUUuativroCzUjF1F6RIGXg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgaY89l5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgaY89l5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745840503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LII0rjVz6xDpWfX4i2Uq1BgoozfTJSUr+S+3gbMdj/w=;
	b=hgaY89l5BoGbn9Y6hKL546ygyWeLdcvj0TyFmaGvo2L7st+CSAfnAmrGgsR14fyGWNnsrX
	9y+QyRhgkp5cgFhOnZOVlEBqdpDrLwSp5Ggn0XcyQg/hjayg1AndGRnBctrfscwN8X5U8x
	ZafQG6RFvYeRFHZyEWHw6bry0ex2lSE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-uO0EMHMxP_mVulmeWplVgg-1; Mon,
 28 Apr 2025 07:41:41 -0400
X-MC-Unique: uO0EMHMxP_mVulmeWplVgg-1
X-Mimecast-MFC-AGG-ID: uO0EMHMxP_mVulmeWplVgg_1745840499
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0E0C19560AF;
	Mon, 28 Apr 2025 11:41:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DCA7C19560A3;
	Mon, 28 Apr 2025 11:41:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 28 Apr 2025 13:40:59 +0200 (CEST)
Date: Mon, 28 Apr 2025 13:40:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 07/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <20250428114051.GD27775@redhat.com>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-8-jolsa@kernel.org>
 <20250427142400.GB9350@redhat.com>
 <aA9iUIsdiWfrFcRR@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA9iUIsdiWfrFcRR@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 04/28, Jiri Olsa wrote:
>
> On Sun, Apr 27, 2025 at 04:24:01PM +0200, Oleg Nesterov wrote:
> >
> > And perhaps the comment above mmap_write_lock() in register_for_each_vma()
> > should be updated too... or even removed.
>
> hum, not sure now how it's related to this change, but will stare at it bit more

That comment tries to explain why register_for_each_vma() has to take
mm->mmap_lock for writing. Without the described race it could use
mmap_read_lock(). See 84455e6923c79 for the details.

Now that we have another (obvious) reason for mmap_write_lock(mm), this
comment looks confusing.

Oleg.

