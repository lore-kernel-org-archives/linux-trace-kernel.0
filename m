Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896745;
	b=lCaq5NAizVqyQt1pfKP/0j7nqzquHXn0uuUC8daRxIgLTi0hLCq3XcqvU9Yb9NfI2sXK
	 TEgfHInoDiSoAWtSGJEzwkDUeqXPJxdJwX9r21xjLJPq8wTQ7axaymxO1Yq2052dHXqPH
	 T3IursP8pf8KbOw4yWtQHVYGAcQhktgzzDF9edBpsgo9h9O4HdhbDdcMzKSuVKWg3GYIj
	 /nbkHe1RYSb7zDxFWRIJTAlzz4wMzw3uaYenMPwZbApyg4CkSxCOZGYnhNbxiAQ6Zf3Bh
	 3+7M9i1VRonwDRXfdex4EqFSvku+k5OuXkETbsWqpdPjGVUDWSwyLBPzyR3ASb/XNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896745;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=kq5cypGlHYrtedqahWiyNWkNdooOV+Ht4WFr1V8te0Q=;
	b=eUTiG8bpJLX4ogD33+ei3zlmURsIqyLsUxt1m8ZlFcV5jnpGw/NSfwjlE5xJjnpoj5oB
	 sX6sFDPS+3sbYe514gyP1Z8H3v2lfUdMkgUlEwdN4x/iwonQkwPWEkV5I7BNzdKVjrXJu
	 gtevNCSBE5gYKx7pfasf2UDuzaCZOtcYvB4eKsk3Rk9vaba0ft6k7tH4/m0x75gH/46HK
	 22oxhhgOgTNLRH50imr80cr5YlCdIU5Mv1PZh84qSOXTt19nDazFeti/ZbPMo6sJB03tc
	 xVZPcQsPkWag2WswCLfRlgzQ2aDXRgYRI7xArIDC5U9oEgof76RK3C5i53oc4Oy1OYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="b6Num/TW";
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F7606A32C;
	Thu,  5 Nov 2026 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92F7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=b6Num/TW
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id F0C9A140B24;
	Thu,  5 Nov 2026 16:39:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2F0AE18;
	Thu,  5 Nov 2026 16:38:59 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:38:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ilya Maximets
 <i.maximets@ovn.org>, Matthieu Baerts	 <matttbe@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH v7 0/4] tracing: improve symbolic printing
Message-ID: <20261105113857.4737cffb@gandalf.local.home>
In-Reply-To: <ba474cdb3bb30c3eaf4aafc6534d0e77cfde64d4.camel@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	<20261105091216.7b91db5a@gandalf.local.home>
	<8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
	<20261105112444.7873d9c9@gandalf.local.home>
	<ba474cdb3bb30c3eaf4aafc6534d0e77cfde64d4.camel@sipsolutions.net>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2F0AE18
X-Stat-Signature: h4zn1ddzjz7nn7h6ct6z6hidbaidy6g3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ZYiExF9YG4u8wCaH23+av+MdUttndELo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kq5cypGlHYrtedqahWiyNWkNdooOV+Ht4WFr1V8te0Q=; b=b6Num/TWvcXNyT6YYpp9UlfprOPzdny3/CU2E2mmd4ayuZIxTDHdmMfKwgSMAk1xuN5Qhhzw1G4v/Od8pX8eOYbn+nd/w+r/1m80YazZA3iuV7r3ECnxtzyOil1dqZBiYU9ArQlf5m0CVnsi+ulAkmfeLXQzAdWce26QScVn1w8=
X-HE-Tag: 1793896739-173868
X-HE-Meta: U2FsdGVkX18Ge+M/eMh4AycP6vbERni8fpZULNY2gTG/6/YpT0pw1HRsKIzF535NQRSMArPWMzs2pWF+Y2hmCKI58pTClRTtt+ZdiPB8xQxT2rifSpobdZKhDk6IZlapVhv7Q3kbla14sUlywXTneIpTGQNQdeeSL7EVtTgq1A7hxHsV0GuTo/mpIHVl7eXy6dRVFS0qOW080KykFQKGnpQc1OeRYSPQ4LOefCxlwMpgdXvh4+7yXPXDbs9m/CNH4lQkb1ag50K+yKXskuHsui/8dLzUNdO2LPGuU2bAU7ZsNgA7It3if51Ejm3NX0kHzf3h6BLSPmi+wTSvX8zIWJeq9dUB15cEYYHzmie1W19Dcv7XG+vYVXUG7og5V48b

On Thu, 05 Nov 2026 17:26:58 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2026-11-05 at 11:24 -0500, Steven Rostedt wrote:
> > > Any objection to simply converting the __print_symbolic() sample? It
> > > would look something like this:  
> > 
> > Actually, keeping them both would be very useful. That way one can see how
> > to do it the other way. We can say, the old way is being deprecated so
> > please use the new way.  
> 
> What's the point? But OK, sure.

I thought I mentioned the point? "That way one can see how to do it the
other way". Basically, seeing the equivalent way.

> 
> > > +/*
> > > + * Alternatively, you could define a function for the names:
> > > + *
> > > + * The _lookup() function returns the string for the given value.
> > > + *
> > > + * The _show() function must
> > > + *	seq_printf(m, ", { %u, \"%s\" }", value, name);
> > > + * for each value that userspace should be able to parse.
> > > + */
> > > +const char *sample_names2_lookup(unsigned long long value);
> > > +void sample_names2_show(struct seq_file *m);  
> > 
> > Are the above going to be defined somewhere?  
> 
> Well, it's a sample, and I wasn't even using "sample_names2" in the
> below, so I didn't actually define it. I can flesh that out even more,
> but I'm not sure it's worth it?

It is, otherwise it is confusing. If it is in the sample code, people will
think it's required.

> 
> I reckon most users won't even need the dynamic way, but obviously part
> of the reason I'm doing this is that I _do_ need the dynamic way for the
> drop reasons, which are registered/built at runtime.

Right, but if we want to deprecate the old way, we need to have the
simplest sample of it. That is, have one event that shows the simple way to
do this (one that simply replaces the old way), and then have another
example of how to do it in a more complex and featureful way.

Honestly, this is why I asked for this. Your updates use the complex
method, I wasn't sure from the code how to do it for the simple case. That
is, what wasn't needed for just replacing static __print_symbolic() lists.

-- Steve
