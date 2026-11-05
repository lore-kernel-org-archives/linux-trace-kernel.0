Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896024;
	b=sJNwfgqIkrLr4cbHtfjFczq+0yxZb3dD0Ttvo9xelAkWRIezFEdHOSrcca2yVF7ZNgVN
	 Hnpu6ssspSTpwjzSgQTJzWFhuF5L9VeXTlHb9zIOMOfoo53xxSmrYvr0nEaKWqWXjxMHP
	 8oDotCSk+zYKWh97TISLa1KXVUtvZPneWw7IZzlho5y0VjjbtBXHJhbQdBknkhz9A2OSD
	 ntOyRmsDl9/m9IvnGaJm24sN433ikSqx+yIBtIHhVNnr6t+UYyABJx/MDDGSQ2DSiUedU
	 r7uvtubj7EMofQVqSddOICFPcT4+dnLZDnTIkUPOqLnZr1BcX4GNB8AgMhIaE2oR40Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896024;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=eYQXe0kVk/iy4RnIgyOEwW7bf0V+nUHM2tfqY76sn3c=;
	b=3Ak0RvhIwXkEzsq78MqcxchD5hW+e29C7rXUhXMOtdzUWG9O0lvgTGm2CPS0h8ntWv3g
	 AZbyUQFqPFqv9rINRl3Pwwi4kKL/5YMwF1qEgDpuKqnDVhkrIQZsaWDYiam4/uzkvkGEX
	 R9cyB7IGc4BZiTB1i9sC6DV4QcoeBjIx9Dj9VlhybrsilHoyy8Dvmm/U6gJDBqXmhwlPD
	 AQ5FDDkdExbdCjC1Dh1cN31IHFE5TsJNlZhM4+Lq4LpsQ+TeoVcODvoWSjAh8m65/ZLEA
	 wVTQABcSH1jWb6bjHO462hp7eEE2JFlSE1b4PzND3XvoM1N0pT6dwi1Gqig7+wfqnOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=GreaKXfU;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A4606A332;
	Thu,  5 Nov 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=GreaKXfU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eYQXe0kVk/iy4RnIgyOEwW7bf0V+nUHM2tfqY76sn3c=;
	t=1793896023; x=1795105623; b=GreaKXfUgBJZ9m8CSPkVSaWKliPzJVSLEqKuvEeMUs6U41F
	kbg/9TEZ2ToIXu0HcFylVscleILe7CZweq7ocpklVtH+gv4nOxv7a2Mmmf74lwX5WQQdBuPzkLpkI
	vfSWll4Iauv6Mh6N9Ga3NML8PqyODxSrfkGB8RX4PYScODrc3Ugje7i777aSsQw0Z6UdsJ3M5eVDz
	tbFJDFo1ZxR8hpEaR9UKrpavHdclOmjHgdgz4A25fEFT+ePBFruo91uGKjJMZOZ4I4yUJ+TquLl7B
	0ZSKUFli0YGYozCLWOctCqAzXjQCVVbXcb+FZcFSVsEgnQVC++JBGFN9Vs4FNhcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xP0Il-000000088Go-18VR;
	Thu, 05 Nov 2026 17:26:59 +0100
Message-ID: <ba474cdb3bb30c3eaf4aafc6534d0e77cfde64d4.camel@sipsolutions.net>
Subject: Re: [PATCH v7 0/4] tracing: improve symbolic printing
From: Johannes Berg <johannes@sipsolutions.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ilya Maximets
 <i.maximets@ovn.org>, Matthieu Baerts	 <matttbe@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>,  Antoine Tenart
 <atenart@kernel.org>
Date: Thu, 05 Nov 2026 17:26:58 +0100
In-Reply-To: <20261105112444.7873d9c9@gandalf.local.home>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
		<20261105091216.7b91db5a@gandalf.local.home>
		<8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
	 <20261105112444.7873d9c9@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2026-11-05 at 11:24 -0500, Steven Rostedt wrote:
> > Any objection to simply converting the __print_symbolic() sample? It
> > would look something like this:
>=20
> Actually, keeping them both would be very useful. That way one can see ho=
w
> to do it the other way. We can say, the old way is being deprecated so
> please use the new way.

What's the point? But OK, sure.

> > +/*
> > + * Alternatively, you could define a function for the names:
> > + *
> > + * The _lookup() function returns the string for the given value.
> > + *
> > + * The _show() function must
> > + *	seq_printf(m, ", { %u, \"%s\" }", value, name);
> > + * for each value that userspace should be able to parse.
> > + */
> > +const char *sample_names2_lookup(unsigned long long value);
> > +void sample_names2_show(struct seq_file *m);
>=20
> Are the above going to be defined somewhere?

Well, it's a sample, and I wasn't even using "sample_names2" in the
below, so I didn't actually define it. I can flesh that out even more,
but I'm not sure it's worth it?

I reckon most users won't even need the dynamic way, but obviously part
of the reason I'm doing this is that I _do_ need the dynamic way for the
drop reasons, which are registered/built at runtime.

johannes
