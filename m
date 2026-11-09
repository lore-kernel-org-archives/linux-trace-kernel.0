Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229501;
	b=NAhwnebgCrtCF1m64XCLc24Okw1Nrr6gwMbF+L8gDVcUhuqJQ3BJrRPrACaJz8HAKwet
	 +pHqPmtsOmHsjI0jmc9QT/I4wZKSyJdQzQBXGCAW0jTI2Wz+7Uroy0D4l8A8FHehkRu+z
	 Djyy9ANFuZVLZ5XJaKWujQXS1LtATjaHoZcZ/aDnb93t87PDHuQl9i6JB7RCEDTyS3iR9
	 mEG8LHQRWUO2xyh4DAFll941ha6I8M8H4X+Y1RzXnHdyCzrLISul8yttKmZ3QDgdYYslt
	 8Mn8Ca6O6EfTS5sFtcWLVngJs8q3oFQRwfICAqq5LH1v67ax6+DIPTXLAwHj59nz0Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229501;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=EJpU1TPCJ8D+Q2T//JjeHAShFUrLh+PotIAWBFM5oJ8=;
	b=b5Read69n5B7YdBy0E6SLwMASD+11eFxJqlwopvQerfH7kWI5SYtwPtgf3OyWfUS6EyN
	 /mRj8vl3w8tMXUxuFKzNYyLZMKWXWLcVLfk+AhrTJp54az2khlm2ExVjSvj5lD8ECDefT
	 0fI5b1NK5oiLCB1hyg7vEWJQ4/3irKB5lFL4AgBujkk9F7yiT8ERLKWoGhNW49vrjBnvZ
	 cxRkYRRBTmZPXI55bCPyqpwgc2M9mSM+5Yx56kk/GtXbJYJCNE29L9jcKXspfOR1oOY2B
	 U2OJbu7TJ5MKIs8LAnRC/UfZuFR0Mr9bINQYHPuaHrjsPUl7HpD1CZ8573KgeeesqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=N4Y3F+Pc;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8B606A33A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 13:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C8B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=N4Y3F+Pc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EJpU1TPCJ8D+Q2T//JjeHAShFUrLh+PotIAWBFM5oJ8=; b=N4Y3F+Pcv9PmLGuwiUxla7xQCs
	ZBXltqPd17AqjoNs9OPzjd4MqlQ6NY9sEJ1O0RxSmJlXJWi+nlmsjzVr0SzzStjEfDNKg0Zi8/G1X
	meifZEnglHV6St7fJ2vSZRnIM2WfTtul/QUkhXI2IHNiMIMdjMslFBl+w9odWW6VRG1G8QJUULLSR
	ZjyqH9G3040yu8cq2/30R7nHP/VRFVOQKUpHzMqolMnPwElGwhNAqR19O5y32Sfa3MYhX3ZEEekWU
	QY/kZZtUJ3tt1TIgvdD6j70ii6c/aa9kJgOh7FsASSUST5YZmENcD2o9DS5ojjccj8X1jaZRm5d6a
	oghCMj4A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQP3P-00BdEu-1I;
	Mon, 09 Nov 2026 13:04:55 +0000
Date: Mon, 9 Nov 2026 05:04:50 -0800
From: Breno Leitao <leitao@debian.org>
To: sashiko-bot@kernel.org, rostedt@goodmis.org
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Do not allow reader to see unfinished moved
 head
Message-ID: <avHEs_umssItSLHi@gmail.com>
References: <20261109032241.55e57d26@fedora>
 <sashiko-outbox-204599@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-204599@kernel.org>
X-Debian-User: leitao

Steve,

Thank for the patch,

On Mon, Nov 09, 2026 at 08:39:43AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index e760d2fe386fb..cf9e0dc10c88f 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1494,7 +1494,13 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
> >  		return NULL;
> >  
> > -	page = head = cpu_buffer->head_page;
> > +	/*
> > +	 * Make sure that the start of the search of the head_page does not
> > +	 * start between the writer adding the UPDATE and the new HEAD that it
> > +	 * moves forward.
> > +	 */
> > +	/* Sync with the writer moving the HEAD in rb_handle_head_page() */
> > +	page = head = smp_load_acquire(&cpu_buffer->head_page);
> 
> [Severity: Medium]
> Can the reader's non-atomic update of cpu_buffer->head_page in
> __rb_get_reader_page() race with the writer's new store in
> rb_handle_head_page() and advance cpu_buffer->head_page past the sub-buffer
> marked for update?

I've asked my robot to test this case, and it was still able to
reproduce the race, even with this patch.
