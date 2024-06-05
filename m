Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB09481D3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601205; cv=none; b=SqENiVPUxmHa4Dqh+ahdTWnrgDPDwdPEPbVGJMjZ6cKWb8V9HzygMiAtE5Z8oiGp6P820WW00/hCBl3TaBRXX1T1N2cnGdKBv6sVuZR1HFqyokG35CquX5DQ3pjv8aprD2qO0I+1eOj7C+zIdersGx6C4uBCjeGc+/tFcZuIxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601205; c=relaxed/simple;
	bh=bNuWGrfh+H7Fav06wVfQOoCuk0r6nLVCkcxz3VrlPag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWli3XpvNI3z5bILW7yurZG/hCY5eLvUJZhKzI8cuNFmfdVOUkTYi58aFTmWrxlmdrN9ipGzrv9+LnwkfqOJlKEHCakuvsQaKzhPoW4iI0FkS5XBpwwdA0xTZqQx9Y0dUaDp4iDWkulH1xE6kCRCtzPvap1N9KMzryOKlDJni4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHd5bif5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHd5bif5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717601203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JBCoiHutLk0vWvVe2jPtxGY0YZJBt3gZWD7D6OcdQ4I=;
	b=XHd5bif5rlYgI8tMc/2L0L87pjIbrU3r0a14O+1vBYcBIfEtMmPfgNpYbSMbgQEfpYg64U
	9O377B009rOh7utNwgNJrL2dK/lzR98HzI5DG1DSRqeif7Bem6app5s0B0AuA9XPxjx43Y
	NtvCnOIP8oar+OOZiYy54whF0SrtTYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-1Nq6HuAwPg6NLiDZHQWiFg-1; Wed, 05 Jun 2024 11:26:35 -0400
X-MC-Unique: 1Nq6HuAwPg6NLiDZHQWiFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A5878032F8;
	Wed,  5 Jun 2024 15:26:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 32B02C15970;
	Wed,  5 Jun 2024 15:26:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 17:25:01 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:24:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <20240605152457.GD25006@redhat.com>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604200221.377848-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

I'll try to read this code tomorrow, right now I don't really understand
what does it do and why.

However,

On 06/04, Jiri Olsa wrote:
>
>  struct uprobe_consumer {
> +	/*
> +	 * The handler callback return value controls removal of the uprobe.
> +	 *  0 on success, uprobe stays
> +	 *  1 on failure, remove the uprobe
> +	 *    console warning for anything else
> +	 */
>  	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);

This is misleading. It is not about success/failure, it is about filtering.

consumer->handler() returns UPROBE_HANDLER_REMOVE if this consumer is not
interested in this task, so this uprobe can be removed (unless another
consumer returns 0).

> +/*
> + * Make sure all the uprobe consumers have only one type of entry
> + * callback registered (either handler or handler_session) due to
> + * different return value actions.
> + */
> +static int consumer_check(struct uprobe_consumer *curr, struct uprobe_consumer *uc)
> +{
> +	if (!curr)
> +		return 0;
> +	if (curr->handler_session || uc->handler_session)
> +		return -EBUSY;
> +	return 0;
> +}

Hmm, I don't understand this code, it doesn't match the comment...

The comment says "all the uprobe consumers have only one type" but
consumer_check() will always fail if the the 1st or 2nd consumer has
->handler_session != NULL ?

Perhaps you meant

	if (!!curr->handler != !!uc->handler)
		return -EBUSY;

?

Oleg.

