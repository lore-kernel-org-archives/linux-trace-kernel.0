Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DE1396
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446269; cv=none; b=Vc7DX/f5J/+X3KBYolQqieXWeeVrP+9DRoTfJKOiBFsio9NFlRoeWW1vRx7j4oqqE4VZI+5aSeENL0n2NIVK3kDRyB311GArxGjmBFw1xo7eGWsSuCRklGzyueiY/j+87a51LQip4UHAJmj7HUT5w9dpePe2vavtMBp2VYHi7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446269; c=relaxed/simple;
	bh=WUx/M4+1jhIUgwiAVPxAGlK3xL8kzwraYQRiOxtSloY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBwtAEp2r/t7dImHSvpFPoUncWOjxx35h9swqvZBpyEzbLRs60IDWdt75qV0BB+0x+pR8x/e7GS5Et5Oc5rTyB9vFNfxDM9c/Q1OVOwHI2jIhTF0cPGCH737xjoAosKodWC8W82ktHoShrDqVYRZkXMn12AKx/XniAi1TulkFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edAuapGt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edAuapGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722446267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUx/M4+1jhIUgwiAVPxAGlK3xL8kzwraYQRiOxtSloY=;
	b=edAuapGtIDc0NEcSEhHOc2iIgDSKSAC3VDINWPEKsWo+vvYpAS5CPghllPqlsjQe1BwRUW
	sYYeXJDH3LyP7+h3El6bMkjTuew5KDDYfxBKPO4WfI7qLPigvpzEnKtQsappUers0wMdyB
	TU8QkP8ph3FqW7Nf993j5pThrB1br34=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-BL5xakLTPhyQoHBsW22cFA-1; Wed,
 31 Jul 2024 13:17:40 -0400
X-MC-Unique: BL5xakLTPhyQoHBsW22cFA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B47941955D47;
	Wed, 31 Jul 2024 17:17:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2535F19560AA;
	Wed, 31 Jul 2024 17:17:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 19:17:37 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:17:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, jolsa@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731171732.GA2752@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net>
 <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
 <20240731170551.GK33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731170551.GK33588@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/31, Peter Zijlstra wrote:
>
> On Wed, Jul 31, 2024 at 10:01:47AM -0700, Andrii Nakryiko wrote:
> > > Do I stuff this on top of Oleg's patch or do you want me to fold it in
> > > one of them?
> >
> > Please fold so we have better (potential) bisectability of BPF
> > selftests, thanks!
>
> Fold where, patch 5?

Yes...

Or I can resend these 2 series as v3 1-8 with 5/5 updated (thanks Andrii !!!),
whatever is more convenient for you.

Oleg.

