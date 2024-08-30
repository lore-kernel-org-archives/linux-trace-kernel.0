Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031E1B2523
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028399; cv=none; b=YDddFTXVQwnqMXrxz518n8MNNdUYqGoRBDVKF+z9tK7c3YCBT5FXU2dvvY9UTj6b12kQ+6CYdqKmrjDuNqs74+gBfdYi/monmdAeY++EM9KmxOyvWQEh04JB5P7zLwFBzpZVXg2crsea9rHGFjxwPAljO+9v8n/XDigVWZdspbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028399; c=relaxed/simple;
	bh=Cdrs9lyTXnUfkn8WkxXokR606qv5rn+vUk9l2phbnIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN+Er6ljsYQ0TGtzJNoUq5Vo/UchEbdBGzoqxW4EIuwxHXYR3dxtzka/Ewk29nNNMLfgrDMn6NY5Ui/gbt7JseTFY4KVGQ4r+7i986Ec0prsCSTO3M/yTbGHJltLqATRlShW4P5IfBpMD7uSU5bTGATZGTUYDFqgp5xl4CxAQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPGplkAE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPGplkAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725028396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdrs9lyTXnUfkn8WkxXokR606qv5rn+vUk9l2phbnIM=;
	b=BPGplkAE1KP6tOlOptBGbXATIyMqCXvcgeGtx2MCTxyrVBSF9G8xMS2UiQvNtaYibllKAI
	WyGPfpPWPDZ8Vf9oABk3fBcg1JrFb1W7yrIvq7U3Bd5WUPt5sidXD/ZbCxEDxVXC4BvIeq
	9D+ycs92EFcPpJC5bV7nUoMXdLTaLzU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-7oYBhr9PPP66Lp4ib6DiPA-1; Fri,
 30 Aug 2024 10:33:10 -0400
X-MC-Unique: 7oYBhr9PPP66Lp4ib6DiPA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EFCA1955D58;
	Fri, 30 Aug 2024 14:33:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6EFD819560AE;
	Fri, 30 Aug 2024 14:33:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 30 Aug 2024 16:32:58 +0200 (CEST)
Date: Fri, 30 Aug 2024 16:31:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20240830143151.GC20163@redhat.com>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHM_C1NmDSKL0pi@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/30, Jiri Olsa wrote:
>
> with this change the probe will not get removed in the attached test,
> it'll get 2 hits, without this change just 1 hit

I don't understand the code in tools/...bpf../ at all, can't comment,

> but I'm not sure it's a big problem, because seems like that's not the
> intended way the removal should be used anyway, as explained by Oleg [1]

It seems that I confused you again ;)

No, I think you found a problem. UPROBE_HANDLER_REMOVE can be lost if
uc->filter == NULL of if it returns true. See another reply I sent a
minute ago.

I think the fix is simple, plus we need to cleanup this logic anyway,
I'll try to send some code on Monday.

Oleg.

