Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EE200A9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722476; cv=none; b=LE/LMX1Kdbkqji72zEHhQ/ElzAjR6DYeU0ijXPnlRbL9OtUixc/mlOosrcsuaxzkm0LeQQ/dQvFHpkqxVP+s+01EIxXUg+KEutjAd14vtxbl+5q3QsfVcRd34iLfzp6YPTaf2EAS4YW4t0L0E/W2TNRvs2TBXQFGfHI+x7uApl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722476; c=relaxed/simple;
	bh=Lua3LKUXFd4xVRTS2QXlOUR9sZ/HRIG3LaRWVWB1ptk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg51z1nkhIXG69cxPbjT6ZNhhxuFlBTlV1SJLkMTM1GOibmMq8C1zwOZEUPUBgGrhGZpEEpLTlg3n5mL1GSssehO1rEaQQrlYhFCoTs9Zs8TjMe2mdK5G2Hz8dNkgsott1QTHJHVwqTi6knWyGUO7tJJeGL/yA3WNm9/bOzmhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2osiaX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2osiaX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720722474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd4UHj9VAgwr6mSYNAHZvQwEcc9OS5JWplfkFQM4iNI=;
	b=X2osiaX2MOvfZoDEWwaHgeG3NqGfXy2XiBvWl4zX6Y4ksbDLOxz5NAel7nq9AjoIHuQTqL
	d+JhW5iECzFbFI9ourMUriBl/TBrGViQ3eIOCgVOz/SKr2cTn6KHg8gzM33HaInjDkw+NS
	EkyN8ZkcTwX67aQQNsx264wFgcwVw80=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-G-f8Fo2ANhmyXZrfikp55g-1; Thu,
 11 Jul 2024 14:27:50 -0400
X-MC-Unique: G-f8Fo2ANhmyXZrfikp55g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910DB1955F41;
	Thu, 11 Jul 2024 18:27:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8178619560AE;
	Thu, 11 Jul 2024 18:27:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 20:26:11 +0200 (CEST)
Date: Thu, 11 Jul 2024 20:26:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, jolsa@kernel.org, mingo@kernel.org,
	paulmck@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <20240711182606.GA29154@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
 <20240711092619.GA18031@redhat.com>
 <CAEf4Bzb0ErnW0o09fk2TCJnY3LNW7U4aB0YcUJqKjfNH+m-uyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb0ErnW0o09fk2TCJnY3LNW7U4aB0YcUJqKjfNH+m-uyA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/11, Andrii Nakryiko wrote:
>
> On Thu, Jul 11, 2024 at 2:28 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 07/10, Oleg Nesterov wrote:
> > >
> > > -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> > > +void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > >  {
> > > -     struct uprobe *uprobe;
> > > -
> > > -     uprobe = find_uprobe(inode, offset);
> > > -     if (WARN_ON(!uprobe))
> > > -             return;
> > > -
> > >       down_write(&uprobe->register_rwsem);
> > >       __uprobe_unregister(uprobe, uc);
> > >       up_write(&uprobe->register_rwsem);
> > > -     put_uprobe(uprobe);
> >
> > OK, this is obviously wrong, needs get_uprobe/put_uprobe. __uprobe_unregister()
> > can free this uprobe, so up_write(&uprobe->register_rwsem) is not safe.
>
> uprobe_register(), given it returns an uprobe instance to the caller
> should keep refcount on it (it belongs to uprobe_consumer).

Of course. And again, this patch doesn't change the curent behaviour.

> That's
> what I did for my patches, are you going to do that as well?
>
> We basically do the same thing, just interfaces look a bit different.

Not sure. Well I do not really know, I didn't read your series to the
end, sorry ;) The same for V1/V2 from Peter so far.

But let me say this just in case... With or without this change,
currently uprobe_consumer doesn't have an "individual" ref to uprobe.
The fact that uprobe->consumers != NULL adds a reference.

Lets not discuss if this is good or bad right now, this cleanup is
only cleanup.

------------------------------------------------------------------------
Now, let me add another "just in case" note to explain what I am going
to do in V2.

So. this patch should turn uprobe_unregister() into something like

	void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
	{
		// Ugly !!!! please kill me!!!
		get_uprobe(uprobe);
		down_write(&uprobe->register_rwsem);
		__uprobe_unregister(uprobe, uc);
		up_write(&uprobe->register_rwsem);
		put_uprobe(uprobe);
	}

to simplify this change. And the next (simple) patch will kill these
get_uprobe + put_uprobe, we just need to shift the (possibly) final
put_uprobe() from delete_uprobe() to unregister().

But of course, I will recheck before I send V2.

Oleg.

