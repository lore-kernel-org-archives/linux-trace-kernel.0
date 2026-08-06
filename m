Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343743B48C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030555; cv=none; b=uyY2kq8EObWP9R0QcW5JVvpKahiWsEUuMrIuv2TiqxnTysL6ozYx4Jp8ZW7Os6Z8OOafFK7WPNzs8+wxTp3/98uoqyPStR+WxL8Lwhs6XiAXXx7vmdkK/FGVVSvm+8QwwEWWjJPRON8TKVX8c9JbAFCjXuFf5J9bBUfccFhYRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030555; c=relaxed/simple;
	bh=r6HeOM6i2D+rbIGS117BMSevYrXhqKly7idLuF29n0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nRo3D0oEx3OPr5qTuI7bOvz6OEvfvf6HFk3whqoi1WiH9s+K5DOoii2GQmBpI1aJk5HP9SaPPA7CFE7/Y9XKx5WnSoU9IiDGniaaX4FenDidNe31nmEF4OnYnQgsRZEjkGOLK2KJE9AGA2p1MZQfxf9Ikon1yXheXDG9f26neD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFDxsPlR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFDxsPlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786030552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3a+zvsPBODBUkg2zPTRvsk0hWuKJ+5dJXyH550K1dLI=;
	b=ZFDxsPlRsIYvMVEHy4pR1VWw+Drmw1cosGcW7XUfeqlHvzl6s6PTNKkkdr1EtCiY54BdTx
	u0z2ZWughls0wjqrLRZMZnQnLGrq9ZquOUiFJMt6lkJWwuvF0ohWkZP6KfmSe/98lUevex
	DoOBo0VijG+aVqQY6oP2wXpY5oJcMGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-POPOuaPvN8267V3tIFsocA-1; Thu,
 06 Aug 2026 11:35:47 -0400
X-MC-Unique: POPOuaPvN8267V3tIFsocA-1
X-Mimecast-MFC-AGG-ID: POPOuaPvN8267V3tIFsocA_1786030544
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B9371956088;
	Thu,  6 Aug 2026 15:35:44 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0B17B30001A2;
	Thu,  6 Aug 2026 15:35:40 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Aug 2026 17:35:44 +0200 (CEST)
Date: Thu, 6 Aug 2026 17:35:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anSpyzXNCF_e3NFc@redhat.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
 <anRpdyApCza3MYVi@redhat.com>
 <anSNg4EA-tUc3C7W@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <anSNg4EA-tUc3C7W@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: c1F9NrzmLeGaGMUB7sQdar0AKxn2b6YVSQZkmjF4CoI_1786030544
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 08/06, Sumanth Korikkar wrote:
>
> On Thu, Aug 06, 2026 at 01:01:11PM +0200, Oleg Nesterov wrote:
> >
> > But your change in install_breakpoint() essentually reverts that commit?
> > If uprobe_register() -> register_for_each_vma() finds a VM_MAYEXEC vma
> > without VM_EXEC valid_vma() will return true, but then install_breakpoint()
> > will fail anyway.
>
> Initially non exec vma will be ignored via uprobe_register(),
> install_breakpoint() will reject non vma mappings initially.
>
> As far as I understand,  if mprotect(PROT_EXEC) is performed later by a
> process, it adds VM_EXEC flag to vma and calls vma_complete() via
> vma_modify_flags(). uprobe_mmap() will then call install_breakpoint()
> and now it should succeed because VM_EXEC is set.

Heh, I am stupid the 2nd time in the same thread ;)

Sumanth, thanks for correcting me! It seems that I forgot everything about
these code paths.

Then this change makes more sense, but the VM_EXEC check needs the comment
to explain this all.

However, I personally still don't think it's worth "fixing". But I leave the
decision to Andrii and Jiri who (unlike me) understand how USDT's are used.

Oleg.

