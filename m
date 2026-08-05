Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D641B8D9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942870; cv=none; b=FAoHQSUF7qoOvzZVNxNHsnnIN/mR3CT1Nx74R2uKzNWXPBBILDCf3Em9YuRTNjk4d6bW5z2+MVlVQYGJAhWnn1KRoxd+8r9yD/YhS9dkmdOBjdyedef4ZbsDTxIrRrCCZsfiOVafE345j7miz3WekqT/E4jGGFgO23zqbAXJt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942870; c=relaxed/simple;
	bh=Hs5V3juOMVZH5ra/jogh0AuQcuuOORr/9WsnqQU1PDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mijjETm469MIOqJHg0ZMYAXKRbZ0zwrBnpMXPcGbFJyAhvWUQLMSgpFQVmdM7Of9amne3SCWPIrt5IybMyBNLT84Ofo+xgskYGWRInnRyudS0WPGBhn6rmg9fSe8hUDlGKY3cPJxLDRDcWwtuw8HbvNLSBtkNb/acxCw+R0QBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7drgEjf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7drgEjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785942865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rCq9tsK99vV/IKDIQH4AsvKIO8wZbuF/vm3wB8OIMI=;
	b=U7drgEjfUcf2oGWaKhwc3B/wDmVKNbT9Z77tmCiAquJ3KFvkR1Eo9pzCMqRXd9kUjT8769
	zN/u3JrvQdzCHyr19+CfkEBqlapOuGDSo1Vau1Lg8ZDudy9Cko6Yh5LrDL7aeT0aLrLZOj
	PbM6EYkIrIw/ZedULYRsUR0Fdg2i/JQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-EbKoPf_FPNCZjbBdEtddHg-1; Wed,
 05 Aug 2026 11:14:20 -0400
X-MC-Unique: EbKoPf_FPNCZjbBdEtddHg-1
X-Mimecast-MFC-AGG-ID: EbKoPf_FPNCZjbBdEtddHg_1785942858
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A62A119560B5;
	Wed,  5 Aug 2026 15:14:18 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2B303195DF93;
	Wed,  5 Aug 2026 15:14:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Aug 2026 17:14:18 +0200 (CEST)
Date: Wed, 5 Aug 2026 17:14:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anNTRb2aGsvY8_Rf@redhat.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: y_VsvkTWstrUwhxPXTwNmjl-McdUij1wJ_vT9cvMjsE_1785942858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 08/05, Sumanth Korikkar wrote:
>
> bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe {
> printf("%s\n", str(arg1) ); exit(); }'

I am hoping that Andrii and Jiri (cc'ed) can take a look, I know nothing
about usdt... And TBH, I don't even know what RELRO is ;)

Let me ask a couple of questions for now.

> expects a semaphore increment of 1, but semaphore gets double incremented
>
> Test program:
> https://github.com/bpftrace/bpftrace/blob/master/tests/testprogs/usdt_semaphore_test.c

Perhaps you can provide the test-case which I could compile on my
machine without libbpf-usdt/usdt.h?

And can you explain what the bpftrace cmd above actually does? I mean,
where does it put the uprobe? I guess the ref_ctr_offset argument of
uprobe_register() refers to USDT_DEFINE_SEMA() in that test-case...

> Reason: .text mapping and RELRO mapping resolve to the same page aligned
> file offset 0
> 01000000-01001000 r-xp 00000000 5e:01 usdt_semaphore_test (.text)
> 01001000-01002000 r--p 00000000 5e:01 usdt_semaphore_test (RELRO)
> 01002000-01003000 rw-p 00001000 5e:01 usdt_semaphore_test (semaphore)
>
> valid_vma() currently accepts both mappings (which contains executable
> text and RELRO mapping) during uprobe registration, since both have
> VM_MAYEXEC set. This causes register_for_each_vma() to call
> install_breakpoint() twice for the same underlying uprobe offset in the
> process.  This means, update_ref_ctr() is called twice for the same
> process, so a usdt semaphore is incremented from 0 to 2.

So, 2 vmas map the same binary, install_breakpoint() is called twice.
But, the 2nd install_breakpoint() -> ... -> uprobe_write() should see
that the original insn was already replaced by int3, in this case
verify_opcode() returns 0 and uprobe_write() should do nothing.

And, if this uprobe was optimized before the 2nd install_breakpoint(),
uprobe_write() won't be called.

Hmm.

> Installing a breakpoint for mapping without VM_EXEC and
> updating usdt reference counter in that case is not useful.
>
> Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
> double increment as shown in the above usecase.
>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  kernel/events/uprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6300b216012c..9e0bbc3cf401 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
>  	bool first_uprobe;
>  	int ret;
>
> +	if (!(vma->vm_flags & VM_EXEC))
> +		return 0;
> +

Well, but then it makes more sense to change valid_vma() to nack the
non VM_EXEC mappings ?

Oleg.

