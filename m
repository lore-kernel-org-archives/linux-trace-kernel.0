Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949816;
	b=Uan/FRVgkeJf+arLkOFkDgLX3sTJX731gQyBIeexR/kN3vC1/9OUrHIKCWUdcYWDGYnT
	 jdqVkNJcTYGFIty2gGr3mitKnVod7v1oU+BT3HoZ+G1rR9txbQvX8a/Z+vhcu8d4NKIMs
	 vZ2yCL35asuFNjnG8DZise6f8cAdm5f6DBkJuXdfiS4oJPKZOJnuvlihqOOKKkqmqxLCs
	 S2W3Xs/yKD6kRoNsTPgXclzVf0HLhePVkp24yg28B7ELo9h3/AL6qmtyIf+Ho9gRNYT3T
	 pH5sthEcUntu1Zm0eVkXxj1hhxyCgn2dSZvVqR3/+DkGjR6FQxD0zlWah2ySyzdqJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949816;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yygiKj7vVgatT//tf7JMSEBn8dLeTNzmQDoK9rtjNLg=;
	b=O5LfwrSp+BZeFQ4k6uroCU2cR1MmtQSBg59s96xvqqfg9BsoR4iyW7j0EYbCXT9Py1ws
	 an/DHcQosLxRFxTTj6jyvMoSI5QFkuLy2DHFJNAChxf7Q9ThofFGMyeXtQ2xCqZcLe97n
	 fH0ipkidBs/WGtYVFiPcJGG1jwWiVlzb8xVip3WzRtHVWkVejAyTfZqccimKvO9R2J3xi
	 vnyQVAQTVb38ozmMpZUxe9/ExDJLcGI0p6w+uvyt603QcToJjt9hD/kE7cp15+45xn0OM
	 Pv0d4OWUEDn4wUXsSI0NjH8Kif9t7OATre0mAOZDpDOii/hYKBFNE9WsYhRy2CRWcUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3cPhH5Gi;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 21:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE93E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3cPhH5Gi
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 37C1E1A05AD;
	Tue, 17 Nov 2026 21:10:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 8995E20016;
	Tue, 17 Nov 2026 21:10:12 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:10:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <20261117161011.59101930@gandalf.local.home>
In-Reply-To: <avy6nTb0ccqNNnOo@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
	<sashiko-outbox-217828@kernel.org>
	<20261117085552.0e4ef272@gandalf.local.home>
	<avybp3O2zxcLozKB@google.com>
	<20261117142203.72235895@gandalf.local.home>
	<20261117142310.4f440b3f@gandalf.local.home>
	<avy6nTb0ccqNNnOo@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w9rcywh5x35r86a8s3uucscodr1thg3e
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8995E20016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+zu1NoF6UDuTb8xtq8RXUAdHs08ksH+Ds=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yygiKj7vVgatT//tf7JMSEBn8dLeTNzmQDoK9rtjNLg=; b=3cPhH5GigAnBISBLed7Ogxrel7ZHb1muwWcTJrO8dezwyRMqu6Saywtkpw5bB0VOpL2/J5f56t2S/mBWUasXiH1EbU/Haqm7NQV7dHiLpaqnx3AXoCfySwvjcpPoXiHN7+jKud4Vl7AZ92G+vzRO7rcnWU9fpT2ovjMQPZD4uGQ=
X-HE-Tag: 1794949812-754246
X-HE-Meta: U2FsdGVkX1/hNX3S9xYEVUTkZAWUeOBkIRmn3onr9PNmwXiSN58n2KWcGC8hvCbVKSA9gc15jwDvUIqEQ1ht72W4h8MWR/4tDplwQH8DfbbnlnWgCooQL06lhQIT8dhC4UGHU3STyklub4jzj6lYdAnIpWyb37mUF3A2JoMSUDV20TBIm4kP1dodlUq5r8KnjGvLPVRoZl+1VjHo3rpbjhl4WJhbYgvLpsVsseWjAOVrlqi2Q1uWolMbBRzS73IkZxuW74tUTafKrWK+WDE05+cXZh3g9zEL88tPWq49V2sDraA3KIsn9SHH6KMyz0f4trtLWZdfAsWjmsa3rUxbBxX3B1gX/MjyQ9x950PFqwCaEfiQqx2rhjj/vRe5DZfbXFXfBY4wmnRqNOakHeV50w==

On Tue, 17 Nov 2026 12:35:41 -0800
Brian Norris <briannorris@chromium.org> wrote:

> On Tue, Nov 17, 2026 at 02:23:10PM -0500, Steven Rostedt wrote:
> > On Tue, 17 Nov 2026 14:22:03 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > As it doesn't need to be visible let's still have:  
> 
> What's wrong with visible? Hiding it is part of the confusion, because
> it disappears when you select something else, even though it's still
> effectively enabled.

Well, one thing, it's precedence. But another is that you can only deselect
it if everything else is not selected.

> 
> Personally, I think it would be nicer if we could eliminate the separate
> ENABLE_DEFAULT_TRACERS (or ENABLE_EVENTS or whatever you want to call
> it) and make CONFIG_EVENT_TRACING:

I think that may have been the reason for the craziness to begin with. I do
remember struggling with circular dependencies.

> 
> 1) user-configurable and
> 2) 'select'ed (or otherwise forced to =y) when something else truly
>    requires it
> 
> That would make it clearer what's happening, IMO.
> 
> But I'm not sure off the top of my head what the best way to do that in
> Kconfig is, without introducing odd circular dependencies or other
> issues, and I also don't know how much more time I want to spend on it.
> 
> I'm open to ideas, or I'll let it sit/marinate until I have more time.

I'm in no rush ;-)

-- Steve
