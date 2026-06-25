Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414351A9F87
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413633; cv=none; b=Ea4iWs9Quo3l5jL1UbqfZgHKv9wern+2I+rfIZeovMKjyD9RYH0g8LRlucmNoA1eot/05/+RwwCDht8mdaJnJTMvm+K80Lj8EcvYKlGrz8CGjOcVnuQSkBveluUje+3TcReIwBzUvZ6FBkmxOv+Y0KBTChkwS11Lpj4GrzWf5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413633; c=relaxed/simple;
	bh=zkJ8zk4nTUNkg2NsqT6TTNga18s7VlJoNpdgJlG+rX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QrvfEwpAPLU1qtKCmTlFWtbpgNkDxSlCewG5tm5Kufp13gafaAkuyPFMmLSCBRtXYsh0+11C/nHRzkur0bCFNaJODJMCARQ8wz+3SR87vPSHVEYgxUhVJ1ogvsAoDR5pQzFYAJRsKE8Un8RqfmfFpSQT1me2n/Puswocj4bxk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmDrxDMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmDrxDMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782413630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkJ8zk4nTUNkg2NsqT6TTNga18s7VlJoNpdgJlG+rX8=;
	b=GmDrxDMBfkU0GwNUlC1Hsc015F8ED2J/mv290Zq8Ndtyeg79dZ6pwl6w4Bg72mE2SQo25J
	GFOS860HLKt5QyEy16TUIiUyfwzRFWtuBgFHfxK0Tiedhylo+d5By3Kzd8WeJa1XlJQHNT
	4eBv90kRNYELZdQJ0JcJXlkDNGkHXH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-DjQzddgxMaiD0omi3szsOg-1; Thu,
 25 Jun 2026 14:53:46 -0400
X-MC-Unique: DjQzddgxMaiD0omi3szsOg-1
X-Mimecast-MFC-AGG-ID: DjQzddgxMaiD0omi3szsOg_1782413625
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A0818600DF;
	Thu, 25 Jun 2026 18:53:44 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2C5F5414;
	Thu, 25 Jun 2026 18:53:40 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jun 2026 20:53:44 +0200 (CEST)
Date: Thu, 25 Jun 2026 20:53:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <aj15Mi3ZISFiU3v9@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260526205840.173790-6-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: f_vVWxqZ1oHJ3R--djHwYzlmoyU3yZNkJk0xKfE_lQg_1782413625
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 05/26, Jiri Olsa wrote:
>
> + * Note that unoptimization deliberately keeps the call opcode and displacement
> + * in bytes 5..9. Those bytes become operands of the restored 10-byte NOP.
> + *
> + * Since there is only a single target uprobe-trampoline for the given nop10
> + * instruction address, the CALL instruction will not be changed across
> + * unoptimization/optimization cycles.
> + * Therefore, any task that is preempted at the CALL instruction is guaranteed
> + * to observe that CALL and not anything else.

Understand... and I guess synchronize_rcu_tasks() is too heavy.

But this means that unregister/unapply will never discard the COW'ed anonymous page
with optimized up; __uprobe_write() -> orig_page_is_identical() will never be true...
Plus this means that we can never "gc" the unused tramp vma's, but this is minor.

OK. This is not critical, and other than that I don't see any problems in yout patch.
(but I am sure this is only because I don't understand this code/patch enough ;)

So, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

