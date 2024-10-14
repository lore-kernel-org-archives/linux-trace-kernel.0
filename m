Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE311B4F2A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917917; cv=none; b=QMcLp+igUa9H7/AaJazHxAeUHtRePXE4SNsJ9lpCuDO4f2Lo8bHnR0IpAZMNk16jqSt4Ir9wlzhcrsqV6wHVA5r3JOdClWNLQrt1OxOykcjxECHclV1/HyYbQquSYVatvfLe3WEMECKo91yEAqirIpCn/Vl9DYV86maYPYbLlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917917; c=relaxed/simple;
	bh=oq23hsnNXV6uNDx0wbAksXTfs4tn5G8g2CM0J5DwfGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6fECUnMLKfk//WACLoJ91+MLRAdBbELuqbQNJ5pSxXmDx9exhR9vOeeyVMLZ9Gmd3yso5PAnChp2NUr0QJKS4yU4lzhECW+xvCPhpWewKadE0PBfvQllOBdhvWfW5xhxaAWuDQh4d2iAjzFYELg1TSdZrrMxbIZzoogZ7OsbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUOVQAIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUOVQAIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728917914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSxjdS/4JF5Z+b19MlGDir/0cFtAacDCsFFGIi6NkwM=;
	b=XUOVQAIEISm43UpC7yXjSQm/mxIVdTYoYaejW1hynThzE+e37Pp9zxCAvcB7O3Uup/JJZ4
	Bh9+3f7WXM+X44Q+oSNsJORg4p7x0Uok6jUwHc2gAAprep9HfYR08yTOqkL9nJM80dcx8s
	hcd2KWZDI3xesMM96MROY4wtsLj5Aiw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-0iESe3l2NHW05FAZ2BkOVA-1; Mon,
 14 Oct 2024 10:58:31 -0400
X-MC-Unique: 0iESe3l2NHW05FAZ2BkOVA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF042195608C;
	Mon, 14 Oct 2024 14:58:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5760919560A7;
	Mon, 14 Oct 2024 14:58:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Oct 2024 16:58:14 +0200 (CEST)
Date: Mon, 14 Oct 2024 16:58:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ma Qiao <mqaio@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	namhyung.kim@lge.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] uprobe: avoid out-of-bounds memory access of fetching
 args
Message-ID: <20241014145808.GA8567@redhat.com>
References: <20241014061405.3139467-1-mqaio@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014061405.3139467-1-mqaio@linux.alibaba.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Sorry, currently I don't have time to even try to read this patch, just
one note below...

On 10/14, Ma Qiao wrote:
>
> @@ -979,6 +980,11 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
>  	ucb = uprobe_buffer_get();
>  	ucb->dsize = tu->tp.size + dsize;
>  
> +	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
> +		ucb->dsize = MAX_UCB_BUFFER_SIZE;
> +		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
> +	}
> +

Then you can probably kill the

	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))

check in __uprobe_trace_func(), no?

Oleg.

