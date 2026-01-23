Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBBE2C08AB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177061; cv=none; b=Rs0o0rUxatJDZ8Wgeu7RhRpOpZ0Kq2WEt/BznIaI5qNjEYBDEkSZ+RT57AIDQEGnRW8jS7felzrOhfyWYlS8YL7afu63FmnPe0RBsm6kskQcvXTf/NGurXGr1Vn7hG5QVse+oDgzdiMPsBcCdOvGRWlxBVE7uaRSY5RyjPCSYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177061; c=relaxed/simple;
	bh=xR74FnEgZomSJH7UHm/sUF1MVRRHcFzsPeIdesdbPZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPcFs1GQTyOZz78SewHigkNsPrwLgQREZsKivAK87ZmeiduagId1aVA7KojQt1wMW9L3RfnhvN/khUYnDrh4gwRwBXT0QNokl8uCeYOEMU6ekGM6xa0hPj0x1jOcWf2RhhhOhI1FSCaOE26CAckomOv6y28iPalzRlvMMEYuf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Okodc7LS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Okodc7LS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769177059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XG6FgC2QdmCpMOTmVLHTs/vtKB+zUpc4hshBBe7nDPY=;
	b=Okodc7LSUu9Ci/dZ1JqgsiTDhMX8hIvdyYifRcnQiU12bdJYvcN2Q/0oAyFodh34d2nTow
	vnHoolermoCd5DzFCmsXzppa4MJVl/shdK/pYE2jLHvJB88fqWfhHZYcYdiBMGeOtmmLxc
	FyO4Q7DNS1lK7+RKkEJ2x6Sr+9CqtQ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-FsX6tFO9OtKZWHTVSKuMxA-1; Fri,
 23 Jan 2026 09:04:14 -0500
X-MC-Unique: FsX6tFO9OtKZWHTVSKuMxA-1
X-Mimecast-MFC-AGG-ID: FsX6tFO9OtKZWHTVSKuMxA_1769177053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EBD119373E9;
	Fri, 23 Jan 2026 14:04:13 +0000 (UTC)
Received: from fedora (unknown [10.22.64.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B265F18001D5;
	Fri, 23 Jan 2026 14:04:10 +0000 (UTC)
Date: Fri, 23 Jan 2026 11:04:08 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
Message-ID: <aXN_OVcksbGuvhgO@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-19-wander@redhat.com>
 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
 <aXESFlL56FA0PyTZ@fedora>
 <aXIhSGAQvflGAEsN@fedora>
 <ed5ffb1045a5d0734947019ad31b9bf46bdca3ab.camel@redhat.com>
 <aXNkusXPp9MyRX9y@fedora>
 <c866db81d6213862baf4a4d3d9f2f013b7ef058b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c866db81d6213862baf4a4d3d9f2f013b7ef058b.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jan 23, 2026 at 01:26:45PM +0100, Gabriele Monaco wrote:
> On Fri, 2026-01-23 at 09:19 -0300, Wander Lairson Costa wrote:
> > On Thu, Jan 22, 2026 at 02:49:59PM +0100, Gabriele Monaco wrote:
> > > Why fill_tracepoint_args_skel() is not required by LTL is an implementation
> > > detail, so that stub could even stay, in case future monitors are going to
> > > need
> > > the entire thing.
> > > Though I still find it cleaner to move that away too until there's a need
> > > for it
> > > shared in Monitor.
> > 
> > I didn't catch what is included in "that"...
> 
> Right, it ended up quite cryptic, I meant fill_tracepoint_args_skel() could stay
> in Monitor although not all Monitors need it, though I honestly prefer to move
> it away and not rely on the stub. 
> 
> > > What do you think?
> > 
> > I agreed. fill_tracepoint_args_skel() makes sense in the Monitor class.
> > If a derived class doesn't need it, it is an implementation detail.
> > 
> 
> But I get your stance and agree with that too, where fill_tracepoint_args_skel()
> goes is just nitpicking at this point.
> 

I will go with your early suggestion and drop all this related work in
v2 and submitting a separate patch series addressing these interface
issues. Python has some good tools [1,2] to handle that. I intend to
make use of them.

[1] https://docs.python.org/3/library/abc.html
[2] https://typing.python.org/en/latest/spec/protocol.html

> Thanks,
> Gabriele
> 

