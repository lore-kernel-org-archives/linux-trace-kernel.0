Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36954298CC0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170752; cv=none; b=F5wGUnmD4YUczdcwbc4SQ4eqQtg8lNiTBR9cW4mJot7JDAYsV7y+W1lS3VJdJlmli4SbcS/lqeiAwjvk+9tdz12T9T7ywWCCpxTlFTv3ggHlIw5O3sctyXT7qW0OLjOz0zsGjwuva0+fiHDkcLSaFnQLNAexXBnENih0RV1SwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170752; c=relaxed/simple;
	bh=sRdn6nOBMVVs5bVA4pXLJjyxpuofImGguqY4bKeHIqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC8AYpl10ZVo5z6txs+/JIiP+Nb2IyHWBzs2HWk1Z/hJYRRaEUe5s5d25/Eh3CJRZAwXs6/V6xh7/U3qxT8Xd65enwVzcQ/jiKmaf0RhhrBhmpZyqrBeav5BP7L7IgEW2+ClcxmrcwqxNkKCFHve0UVoP2zAzp5dmJ3wN+1eBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoP8nvBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoP8nvBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769170750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jizvDJXLKMgDxibrJe2BgxqqVnERlyvLsxL3+6u2Cfw=;
	b=YoP8nvBXeGwWTFKX2FpOixUgOO5E3O6IGK5jox/uO1YcMnMiYBwbAF6laDQVd48/4DAPaH
	qqclQSrT6FGriGdvCJe3Gd3m8HguUGlNMBBsSLGS89MXMzgnC6+A9z/TqDLw0iYZ6/jfs6
	dBeKLuYLxIi9M3BJTXGUMt1kZ5ORwOs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-mrQ8wgfEOOSQznpEuxwwzA-1; Fri,
 23 Jan 2026 07:19:08 -0500
X-MC-Unique: mrQ8wgfEOOSQznpEuxwwzA-1
X-Mimecast-MFC-AGG-ID: mrQ8wgfEOOSQznpEuxwwzA_1769170748
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D91811956054;
	Fri, 23 Jan 2026 12:19:07 +0000 (UTC)
Received: from fedora (unknown [10.22.64.104])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 322111956095;
	Fri, 23 Jan 2026 12:19:04 +0000 (UTC)
Date: Fri, 23 Jan 2026 09:19:03 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
Message-ID: <aXNkusXPp9MyRX9y@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-19-wander@redhat.com>
 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
 <aXESFlL56FA0PyTZ@fedora>
 <aXIhSGAQvflGAEsN@fedora>
 <ed5ffb1045a5d0734947019ad31b9bf46bdca3ab.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5ffb1045a5d0734947019ad31b9bf46bdca3ab.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jan 22, 2026 at 02:49:59PM +0100, Gabriele Monaco wrote:
> On Thu, 2026-01-22 at 10:10 -0300, Wander Lairson Costa wrote:
> > On Wed, Jan 21, 2026 at 02:53:03PM -0300, Wander Lairson Costa wrote:
> > > On Wed, Jan 21, 2026 at 02:57:02PM +0100, Gabriele Monaco wrote:
> > > > Mmh, this is a bit fishy though.
> > > > We the patch using the decorator seems fine, but highlights how this
> > > > method
> > > > isn't meant to be in Monitor if not all monitors use it..
> > > > Adding a stub here is just sweeping dust under the carpet.
> > > > 
> > > > Here should probably keep the common part of fill_trace_h() in Monitor
> > > > (e.g.
> > > > replacing MODEL_NAME and other common things) and create specific
> > > > implementations in dot2k and ltl2k for what is not common while calling
> > > > the
> > > > super() counterpart for the rest.
> > > > 
> > > > Does it make sense to you?
> > > 
> > > Yes, that is exactly my idea. Since the patch series were getting too
> > > long and my brain too rot, I thought would be better addressing this in
> > > a following up patch series. But I can work in the next version if you
> > > are not ok with that approach.
> 
> Good point, that can be a separate series so that we don't mix too many things,
> but I'd also separate the initial patch introducing the @not_implemented .
> 
> > I gave more thought on this matter yesterday before bed. Maybe this
> > isn't a issue on the design. Some methods on Monitor might just have a
> > harmless default behavior. I look into it more closely for next the
> > round.
> 
> Well, I believe that if a bunch of methods from the parent class don't need to
> be called and we have to create stubs just to avoid errors, those methods
> probably shouldn't be there in the first place.
> 
> That's particularly valid for the Container class, that won't ever need to fill
> tracepoints and other stuff.
> 
> Why fill_tracepoint_args_skel() is not required by LTL is an implementation
> detail, so that stub could even stay, in case future monitors are going to need
> the entire thing.
> Though I still find it cleaner to move that away too until there's a need for it
> shared in Monitor.
> 

I didn't catch what is included in "that"...

> What do you think?
> 

I agreed. fill_tracepoint_args_skel() makes sense in the Monitor class.
If a derived class doesn't need it, it is an implementation detail.

> Thanks,
> Gabriele
> 

