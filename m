Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287833E0C58
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751221; cv=none; b=Fw82ucQSolvWXw434xG1/n7ZbozG4LeqhtojH+oV6MKVeDqgAXwfF5a99AhxpIFuk6bWMj4i6J63CimlR484cR8MIoaeCpRi3qIj6xyZ3D5OpBJfFBbvND5nvVGh6LHDCC+nrDvkZvuyE5IEhqhiH+wpAstcTLgMBL0/cH+eaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751221; c=relaxed/simple;
	bh=T1fLXCn3FavD3bJ3PxuobqPBjZ+A8RlVrG4IjG7DiNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i9b8Lr12+97R6RelWYgGvZa9qQFdEzftiNwU7zZ73VqFmm6Y7dZBnztWw8kSahLPpLYl1dnnHIgx2duvP8tKmzFsJx/AnfaS6UOfA7VEVSALp0dB3sYoUetQJD8sJRsmSAO8aHErvIufpChyIhsA9oWakgzKmmnzY0/tyCYeGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsS/ztBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsS/ztBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782751216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CviOjkV9/YgKW2WypG09pJ964/zY+DekGBGC6jJ7pxM=;
	b=HsS/ztBIPxFQKLA5edt0czis+NYBns0cNakT88mMTi2xZKyy4iqxmjJN5hRCmQQcRaPK8G
	qhf53DQVWVOt9xubo5xojMGdOuX5cJcFbmfY3zlrnfBGB+nOC99UKtAyZJlS44eJFwlTqM
	LDafEdycn5zXigs1s/rak5EulDHgXUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-rpdYnSZOPrigYNwYjzgDog-1; Mon,
 29 Jun 2026 12:40:13 -0400
X-MC-Unique: rpdYnSZOPrigYNwYjzgDog-1
X-Mimecast-MFC-AGG-ID: rpdYnSZOPrigYNwYjzgDog_1782751212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7874B1955F44;
	Mon, 29 Jun 2026 16:40:12 +0000 (UTC)
Received: from fedora (unknown [10.44.32.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6085F3000B76;
	Mon, 29 Jun 2026 16:40:09 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jun 2026 18:40:12 +0200 (CEST)
Date: Mon, 29 Jun 2026 18:40:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <akKf511eknMCE0AB@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
 <aj5JuH6AtjDtWIVU@redhat.com>
 <akJNZN9gvZ30zKUf@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <akJNZN9gvZ30zKUf@krava>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: _PVK-dmVKgpNAB0w1G6tVFiEGT66tx-RDns3AgHy7L4_1782751212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/29, Jiri Olsa wrote:
>
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -265,6 +265,10 @@ static bool is_prefix_bad(struct insn *insn)
>
>  		attr = inat_get_opcode_attribute(p);
>  		switch (attr) {
> +		case INAT_MAKE_PREFIX(INAT_PFX_CS):
> +			if (insn->x86_64)
> +				break;
> +			fallthrough;
>  		case INAT_MAKE_PREFIX(INAT_PFX_ES):
>  		case INAT_MAKE_PREFIX(INAT_PFX_DS):
>  		case INAT_MAKE_PREFIX(INAT_PFX_SS):
>
> or we could just skip it for nop10.. maybe that's better

Well, if you ask me I'd agree with the "maybe that's better" plan ;)
I mean... I don't think that INAT_PFX_CS should be "special" in is_prefix_bad.

But, whatever you do - I agree, feel free to keep my r-b.

Oleg.

