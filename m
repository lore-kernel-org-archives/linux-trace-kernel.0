Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEA381C2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Aug 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298435; cv=none; b=CSh9zBBKEqBFdluIUAimQAiHTyUPP4FUA1LbjL41m2KwPyZEzOrxyRCDiZ3z1P2+NDuM8H9aZQVjYevj9Bm7/Ozy5weD4YtEA3bhsYGNe2HE3k9IiBbiAVWwiSJVa0rOqgoT3yQA533OhlbVnRBcNCvvj2akP6WUeNRVgUc2IM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298435; c=relaxed/simple;
	bh=Cj1Yx0PJFEYVxLn4UyvZAIGlvRL72QXzxSOUQM3nhDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYLUXAH1uQ8gz61tQCJk4CuyYfV86B/uumQi3ulbJqnjG64WuabNZGZs4U7kwqa89clxetl/PfmfBsQLP8tjuxHboQABSD+DgALkXaEUHNcshbzu+ksVuj81VNf7wYsiCQaTAlvDe+Zc17dogBarv0M3So8ELAUNQvOpFMsXjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODhV6+rR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODhV6+rR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723298432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=624V9XyG5KuMz5zJt7ndl3ScBb1+yoRWVwukoiM9UV8=;
	b=ODhV6+rRYn2vHIONZfRufwFc4cVhofyQLb5dAyUnWuqYvyGhGCw5JywrgiAky7NevC5Zf8
	UJhbOc6N4RxEntUVW9fGVYJ3RXVEl69eXnFK8qVUmz0hRZPwSvU8jYnM8k2TgYgN52O2Oa
	5NL7kboFqPs1G86gIP7v7YvDJHSEz/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-q4Qa9PKFOGqoKeri_5PBrQ-1; Sat,
 10 Aug 2024 10:00:25 -0400
X-MC-Unique: q4Qa9PKFOGqoKeri_5PBrQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 734B01956080;
	Sat, 10 Aug 2024 14:00:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.43])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 133F419373D7;
	Sat, 10 Aug 2024 14:00:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Aug 2024 16:00:21 +0200 (CEST)
Date: Sat, 10 Aug 2024 16:00:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240810140015.GA21800@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
 <20240808134007.GE8020@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808134007.GE8020@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/08, Oleg Nesterov wrote:
>
> On 07/31, Andrii Nakryiko wrote:
> >
> >  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
> > +static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
>
> Just noticed... Why seqcount_rwlock_t?
>
> find_uprobe_rcu() doesn't use read_seqbegin_or_lock(),
> seqcount_t should work just fine.

Please ignore... I forgot that seqcount_t is not CONFIG_PREEMPT_RT-friendly.

Hmm. __seqprop_preemptible() returns 0, this doesn't look right... Nevermend.

Oleg.

