Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800826;
	b=Hy56tNXAKXUZwz7MTpo0K4ShggHTPORDffI3S24PmFjo7vTwvBBx288cmoX6vN5tP5g1
	 cbH1/kdaNoSwKlAny9MnBzvr3HpfCjmpIIXi8NNNl2xZ+FK0ySQFtGX+BQT9kZEz8YFFT
	 6ZLrr8VUI89xPDpqnMkHQMBfD15qhXG6yrXrMDqD6hG58zyFHmQEMl4W3hCPYBGHs5qFe
	 lt+BlgVijEupww3NgARnXKmn5VYbrmIGu3XqDrFqv0M5n9GcaClH28FRTOacUvS0wsBYG
	 PyZsZTJmhny1vUWaRe7lDMiJPMa6fKlKhSSxVE5Ykr/bjqwyccHOFHBq0mqfbAm1bRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800826;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KXFOfYSmcm/nqozKsRvJkrnKm9hqQgkrKRLJdZRJ9Zg=;
	b=aSZ51XwXvyWOaJVo74UU61bXKlGItd7JGEc/oRkwBqF8+wMTSPG8JBjUk917KnmksJ4i
	 agc+PJwzuqIgun88UgNMjlPLgt8xajAuLVU20skwk1frW55vX5ln9Prwbg0FD3SevsEYt
	 2WIhSh3BvtzOiKihg6lVlLf7k/57eO5AoiEn0AVqYizHNFm82TSeVv2z5x0AlVYXIOQLR
	 +GVGvd2sC6ufv8Zl9GtlBcX6zIHoLagjj1jMFpoKrbB/pBWflkE2WpHOJc9hE+jlMYHIa
	 JdTupVQIWc29TCmI1V6VOsGJzWqgSBRh+ZqKYelwTgTieO6F3I1/t0qxM+maV/AWcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=Mw9OlgmY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q6nthQQ7;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011E606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9011E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=Mw9OlgmY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q6nthQQ7
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BABE11400142
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 20:13:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 20:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792800814;
	 x=1792887214; bh=KXFOfYSmcm/nqozKsRvJkrnKm9hqQgkrKRLJdZRJ9Zg=; b=
	Mw9OlgmYn+Eo2VbqLzZGaYnUMEQxiL3T6RCTpyn6qoqp/H9hHKWDAghGtQ4VFdL/
	HKEDPYzJSm06vJHPT5ChkvntkucioTqXNM2cfJewtlq0i1DS2yKHaeEy9i+FMQxb
	Lr2/HRcRZQQAZOVT9KBSCn3kMiIZAlidwyK8eyPUGsSRPfH9BLJW2srQqn+hCw5y
	GrrIrytS5PUZRosWM3L9uARdgwQ3sAl2OUP2DBJ5CXTjsr5plEWz3PZ9JXABu9p3
	HczVFRDgAJiWx9ECBnaD/zRbswtr9cbixNOCnqDjk6s632EOA8/H7WirgoYReyx8
	EVOcnwst2Gz0h2fXg083DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792800814; x=
	1792887214; bh=KXFOfYSmcm/nqozKsRvJkrnKm9hqQgkrKRLJdZRJ9Zg=; b=q
	6nthQQ7hbTMADEAgYYu9SIogjbLOyTJp2EcWuOw2ckwz0EPFmHmWocGFBXv8vozP
	YDohiP64xCuHAZYqbUZY8C0CSW/ay8GYDq+2fJ0fngDqezpqEwEtndR8+JBI97t4
	cnsIiEeVcu7CBLARdnXJCUnweoLapMgPRS9sjNKan5jAkM279gfTadk4Ygze/1RW
	vSchyDuTFnXDsQ0d+IK5hJxQK5hPD9jjM62PnldhlFnV8fphmSojZRLxu7sjyMxv
	53bFqWI7OgZyqwgt+bjbd5zk4ks22EgpsBHskorY6W/2RB3cs63Gt6CHqIfR9qzp
	/l+Q6GtbsDQlzKSmF3KAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792800814; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:vBiqBusPswsY58H1MTgqqgs7q1I8uM0BGvXgvCzFkk6YmoB
	3wQ2O5QUtKYyMC7RD7h3gPYuDd45/W47m878Ds/aEKHYfROA4nFjqHbtuj2YX9bQ
	BWJ81+RulM0IQVxxx7s/AsdbLa0bY0QkYNAM/QeU99msn63tJPlFPNSOVDQRZTRw
	bikOu6oGUzvZ2DlR7MLAT/f0GiSLJFsGDrXWhxoQfalieHe1xGlil0K+47Yrn90C
	WjjAnTDPpYm7wIemEbp6hBj0zrBMLw4fEJfg1wLgA1mhqq9yRk35h2K56rI10Z51
	gByVXH5FDVIyf+eC9/2OU1kWyoaUq7qvYjJ++3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fbDSgu4IuIlRwCSfp14xCHBk/dW9HMB/tpEky1iDgFo=:HtC2x/W+mhOUzEMx88qx+TWfPeeNPz7Gi6Zev7TMGYw=;
X-ME-Sender: <xms:LPjbatttz8QhTK4k9bD6wQHJHHPtsi-iO05PoRZwMZ8Dd6WtQyGvJQ>
    <xme:LPjbanORW5r1bOsNIQ4QjD_7R9Fc0diUysf0qE2ahRcb3SAUgO5oZEy99rqrDsE7t
    btp7pz67sl2tMESRNbOoihnZcCHgBIk_fuRuo5gIs_fON8jpuKUdlU>
X-ME-Received: <xmr:LPjbappvc_varJ5xnyfDnFXx27eEt8sVsq83iCaZLU00GQqwgQxdjusk225DLg>
X-ME-Proxy-Cause: dmFkZTEjdLj0dCavdwlLRNFAYY47iT4nSX5hlN05c5GDlCu2LvbuPP3rByLWOcZIFIaP39
    Pdqx1jhL6T3cQCion/F1Ivz4fT5V5TT4ysAcp2WwMi62rg+PLftoWF6LgHwa4oHdQf6dDs
    eQZt8g659CBYxp7boPVLFg/S0aIJ5NyY8Ce1kPfdXAZBUoDWKMExykZbpyqm+/hWAUW0os
    FrAYTPOJcIpSIT8/dS/spkSs8slLEb5PbbNcJZ8Rg38HTsQ6DmAXGQc0nlPerQYxfexhyn
    Pr41HIi5MrIE4rVBGeEhKtL5iA5cfuiAu8OPcQSUTvuOzSIncVUlWfRoNGv/Al5IMl0UX3
    vRML+fnRjDdo6V3cbp3WpfP0YjiCqmQ8uKIMzPfQORibmRlOYc9SjXbwJs0Xl+Ym3wLEED
    se2ajxXHVuexnbjMeTVubVQgXn/OlCefy5RA4J9bx/h3nKKCMtQqt39Y8BclKR+fAAX2Er
    s9glqWq43aq1Sd5uUpORLMCK+sojlL/RszUzZkaYXHBeNcZ7D/0Ifg23r0bTYi56hGGhd3
    dGxKTcWTiwPIxS3dkmAdabrkUdMNz5lDWeSi6g0R1g8KsP7YPM6Sjuil/mhOqvuki4pBUo
    fc6x7VQeW6bZ9GuNGZ1NfkdOcKWL/Mn2xLFGd8kyWx1ZdbmONXknSE2LirAw
X-ME-Proxy: <xmx:LPjbasF2AXoiVFfLElxv0tQuMsxX9MQc9AJZIE8jDKJI_eJ5uGR-HQ>
    <xmx:LPjbatE4D_ZiQl3hq7tKDfIjDPovuLWbdSOUz2ZpjeRK3O-KFB4H-Q>
    <xmx:LPjbarJmRmffxwsvVU6ku03bDVdbljOJ9iccpF6Hb2Ct46ZiQDGP2A>
    <xmx:LPjbamFgKkN9okE52IGBWRLSdZ0czndwFeZcSr-sNkYtx0Zkj3WRFQ>
    <xmx:LvjbaqoS3prqVlVQp05MgXnemZ7CB_V6Tk-ltPFPezRVT7DVcd-g96o2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 20:13:30 -0400 (EDT)
Date: Fri, 23 Oct 2026 18:13:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>, Danilo
 Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh
 <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Richard Weinberger <richard@nod.at>, Thierry Reding
 <thierry.reding@kernel.org>, alex@shazbot.org, Jason Gunthorpe
 <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261023181326.0dc2f7ed@shazbot.org>
In-Reply-To: <2026092348-victory-erased-0e5a@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
	<DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
	<arIvG0nx4LXG9nlW@monoceros>
	<defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
	<9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
	<2026092321-province-yearly-44aa@gregkh>
	<arOfHEsGGglNse7T@monoceros>
	<2026092348-victory-erased-0e5a@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2026 12:29:56 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > No, drivers should NOT have to do that in their .probe() function,
> > > that's what we moved away from decades ago!  The match function should
> > > handle all of that for you, otherwise it's contant duplication
> > > everywhere that is unneeded. =20
> >=20
> > Well then you have to accept that root can provoke a null pointer
> > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > least with today's platform bus match function such a match is ok. =20
>=20
> Agreed, yes, root can cause a crash and can do tons of horrible things
> much worse than this, that's not the issue.
>=20
> That's why this taint is there, to make it obvious that this is not a
> "real" bug at all.
>=20
> > > Please, learn from our history, don't make the same mistakes.
> > >=20
> > > Now I might be convinced that driver_override is the way to go here, =
but
> > > it still feels really odd as again, bind/unbind was created as a driv=
er
> > > debugging option only, it should NOT be a normal operation that any u=
ser
> > > should rely on.  The driver should "just work" properly instead, with=
out
> > > requiring manual bind work, as that's not a good model at all. =20
> >=20
> > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > (due to missing documentation and/or engineering effort) and being able
> > to rebind the driver instead of rebooting to get a working device again
> > is very useful. =20
>=20
> Fine, use it!  Just don't expect that to be "normal".
>=20
> > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > differ in practise. =20
>=20
> Agreed, but again, don't rely on this as a "real" solution fo ranything.

Sorry, late to the party, but this isn't a few user scripts that rely
on this behavior.  Effectively every use case of vfio relies on this
behavior.  We rely on unbinding the default driver from the device
before using driver_override and drivers_probe.  That means every
hypervisor with device assignment and every userspace driver use case
now experiences a tainted kernel. That seems like a significant
regression.

There is currently no alternative for this process.  It's not a matter
of upgrading to a newer kernel where the drivers claim the device IDs.
We can't claim the device ID, vfio drivers represent a secondary use
case for the device.

A production use case of panic_on_taint now results in a hard failure
for a scenario that has been allowed and documented as best practice
for many years.

What's the solution we can pursue for the scenario where devices have
dual use cases between in-kernel drivers and userspace drivers?  Thanks,

Alex
