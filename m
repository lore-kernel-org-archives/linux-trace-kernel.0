Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455C18E745
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127371; cv=none; b=fQ67fiYIET3tqe1HivSxUvehWM0s8cLliD5chT+UfLRI0BxLBqlxrXisxAfw5juK6CJyagVcH9hLQMb5P1TUrzcXE/zS8dm39Bdzs3gXrTch2TAziRLAitOTfxn3uST+5IAzuxF13PtCxkGmoYu6rj8596uRaC7lJT7WYB/q0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127371; c=relaxed/simple;
	bh=gDND6qNLPtj9Cvnqepa/26hTXzqHsUw/LUV9SpFzEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSBWF08rmZvaH50vBx1qqRzzx1FgUNvJa5KsgJQUMNbD0w3Nvn87Oyp2mMb0XTit9LA1iiOHubce+yADUaGCwaVFzudzTL+mAY1KNJiwOKOEi2FXB52f7jPe0mInaoNx4OmFAsfz+65L6UjEJh66S+3csNF5G4ktqboSu8PEc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEUC4seg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEUC4seg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723127368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDND6qNLPtj9Cvnqepa/26hTXzqHsUw/LUV9SpFzEO8=;
	b=PEUC4segrJEsUCo0KXlaygV7EgVTU9zaJlueDBPFzJuq6FQBo/0hYNxxKqwtGhkdLFEKmv
	Y5VPtEUnZVIMDquSxFYj0xWm9nq0eYbPYonUowbCG5yXVHomH18WiN41bBwWAq7sEQQ8Gd
	s0xBXPXWzqgK7ssoQXmjpX7y2yqAwgc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-hgslZID_PW2LeFYh0ix_Vw-1; Thu,
 08 Aug 2024 10:29:25 -0400
X-MC-Unique: hgslZID_PW2LeFYh0ix_Vw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608F119560A3;
	Thu,  8 Aug 2024 14:29:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3F7AF19560A3;
	Thu,  8 Aug 2024 14:29:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 16:29:21 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:29:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240808142916.GF8020@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
 <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/07, Andrii Nakryiko wrote:
>
> So, any ideas how we can end up with "corrupted" root on lockless
> lookup with rb_find_rcu()?

I certainly can't help ;) I know ABSOLUTELY NOTHING about rb or any
other tree.

But,

> This seems to be the very first lockless
> RB-tree lookup use case in the tree,

Well, latch_tree_find() is supposed to be rcu-safe afaics, and
__lt_erase() is just rb_erase(). So it is not the 1st use case.

See also the "Notes on lockless lookups" comment in lib/rbtree.c.

So it seems that rb_erase() is supposed to be rcu-safe. However
it uses __rb_change_child(), not __rb_change_child_rcu().

Not that I think this can explain the problem, and on x86
__smp_store_release() is just WRITE_ONCE, but looks confusing...

Oleg.

