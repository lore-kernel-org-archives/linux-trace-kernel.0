Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3823D093A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954391; cv=none; b=P97x7Sv9o63jMYSxNGpfYXCZ0cLlIK6250tODo0ENBaMYTucWf/mbgjVJvjW3z5WyxkHp0O8kHoJDW/dnEtTCG+b5HroOHQde6kZUVAwYcGCZOrJOFynxCrHea+gGvgTxtcmFgXPD5mkn7+e+rHGaCO//5qLmY1LQpBL0NA6qq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954391; c=relaxed/simple;
	bh=XVXQDhUarsMjJs81gpH8FPauHzfnLC6aL7PQ95Tr79Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d/IRETELROaNG5yXO8KxIuOI/gd8OITE/qU/Nd0JTYK3FSCRWUdS+JNg3lbgmgLk5W/7SH+XHoEshzEkaFYfmIsplZdiLe5FCfc6bh9S6jFRM0yQ0Bqc3GrwY5wdLvtEHJ1wiDUWjbMQN8icOuledlVpCbPKpJIkPxCxTCAZccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ax3X8aKp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax3X8aKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785954387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mKQZgP1vcBk8xj0SnbVcXmnHMQqkzoB401ckZZMnYY=;
	b=Ax3X8aKpbPuRjaZ545axsHigmuAm08uMJYgRaNaK/jxyVMZ3DN0qg7e/tItrFnR5dy0HPS
	ZUR0C8umwTLRpXrMCCQzgjYgEjPmKkS4UtGSyxYaz1QnLOz+6OhmwrJFnaGFqiaW+H1l4y
	dXQ4MQzZqJWrsXGZqNb17UC2bAFRGj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-q0edZyw0OQOqScYVq9WWdw-1; Wed,
 05 Aug 2026 14:26:18 -0400
X-MC-Unique: q0edZyw0OQOqScYVq9WWdw-1
X-Mimecast-MFC-AGG-ID: q0edZyw0OQOqScYVq9WWdw_1785954376
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0A7A19560B4;
	Wed,  5 Aug 2026 18:26:16 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EE533195DF92;
	Wed,  5 Aug 2026 18:26:12 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Aug 2026 20:26:16 +0200 (CEST)
Date: Wed, 5 Aug 2026 20:26:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anOAQ1-WsKUzR2xy@redhat.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: l_webSSbUhqKkyEEuPy_560Qt3OK0pjz28yg3elwxko_1785954376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 08/05, Andrii Nakryiko wrote:
>
> On Wed, Aug 5, 2026 at 8:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/05, Sumanth Korikkar wrote:
> > >
> > > bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe {
> > > printf("%s\n", str(arg1) ); exit(); }'
> >
>
> does bpftrace care if USDT semaphore is set to 1 or 2, it shouldn't.
> As long as detaching decrements it from 2 back to zero we should be
> fine. Is that what's happening? If so, is there really a problem
> needing to be fixed?

Yes, I thought about that too...

> > So, 2 vmas map the same binary, install_breakpoint() is called twice.
> > But, the 2nd install_breakpoint() -> ... -> uprobe_write() should see
> > that the original insn was already replaced by int3, in this case
> > verify_opcode() returns 0 and uprobe_write() should do nothing.
> >
> > And, if this uprobe was optimized before the 2nd install_breakpoint(),
> > uprobe_write() won't be called.
> >
> > Hmm.
>
> Even though it's the same file offset, it is mapped to two different
> virtual addresses, so I think it should be two different memory pages
> that will have two separate int3 instructions. I don't think there is
> any contradiction or surprise, is there?

Ah, indeed I am stupid ;)

Yes, uprobe_write() creates the COW'ed anonymous page, so the 1st
install_breakpoint() won't affect the 2nd mapping to the same binary.

Thanks Andrii!

Oleg.

