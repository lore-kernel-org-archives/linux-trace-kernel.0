Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859722;
	b=hwE4aOgjts3vVVC7iO3Ws9qE2RvakdE2jKTuDs/5XIABMn5a9rn8l0o+5MMdV5wP1sZH
	 PuFuWal5p4dEnlqom8VIsvI98Ny9LNCyd37Uo+Clrut5OOSiZac3RRVdG5suJT1EQWEu4
	 uum+SrtdP58o09iAYU1QUMVv7FntdFPAx4Li9ohxn5u+E7nTlUFtj2n6wDr3MakPPdBSJ
	 n1womns76Zc6y5E7bg/NEILN2tejnJPbK2wXCjbssipKLN7uqxGrmXG8cIRerGLHqeHfG
	 924RbBJEMXBQf1aVWuyjV/znpIaxxL7Cu4TMUF6hJrVyW6gby6cMJOKxuUT7mF5PYMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859722;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q3hza6gfFdynstbaNLuNyAqlUowt1fWQwFZR5teeLxg=;
	b=QNLyrt2AQxPexsB1nnCLyU/ksWzrbS4AaypQUNhIungrrul9aTobbQihWPBRG+ItM3OD
	 Lqm2yW8j7PhMMdHliWB97fYhocJUTWE0mor/HGMwoEjTaxPWCNtwtAZTJaCoNkm9QV5l3
	 nL40689XD3SqfxoYEjVXkkz+BE0kgfwuerr9TvPh8Uxr172/t0Ihscrn+L08coPkmcssi
	 odt/FYRQt0x83xXU24YnCG0k6X+HTIpasfJYRN2sTupgYESWl6LiGtmVe6LObau1gy3tY
	 KVjUu+SI0JLlO0GwqiRuJy8y2rfjgzYDncnyDTgSba2Yi1Nv12DfXN35atb2EjRuxwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=E9TTTyuV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HSLmwBuR;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF9606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 16:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BCF9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=E9TTTyuV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HSLmwBuR
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A96021D00170
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 12:35:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 24 Oct 2026 12:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792859717;
	 x=1792946117; bh=Q3hza6gfFdynstbaNLuNyAqlUowt1fWQwFZR5teeLxg=; b=
	E9TTTyuVq5dqLfibvKAUPgIg5tosgfal3gshY7YFVMEvMYBiRtsE/hVOZz+s9E/s
	Vp2Mw+33W+xC5axSUv6LiW6jYatqKOB5v9I05nc0ybaBcpLWshDYhkElOb63LJQa
	5mpWbHmgXLqi/jfi5yzFs5tqgdAcKZZ33LufqE1y0ccmAd5Q2UO75ZaoYMrWplpS
	bz4023BNvDLPHdfxR8em3XXyTd/MJhW0w0KkQGIlAQRC5iVlx9GKHe0E7Fq0NizZ
	iZMYZ9oVMwNQai85YBxlmJidCy+s/9t0+LGErr2goPyIoRxsbsUbppJam9TWjcLF
	oebVumhwCwCnko/ixXCeTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792859717; x=
	1792946117; bh=Q3hza6gfFdynstbaNLuNyAqlUowt1fWQwFZR5teeLxg=; b=H
	SLmwBuRRP2v647BWrpPT4ump0Bi3DOHEEVDkCvC1Z+khtGlflWopAywI1565MjwV
	dfRCBs0WVYow5r3uTm+/ImdcNdW0LshiNslhvGKamfXyDXu2wGqF6VjWmSfEnfi/
	JNfA4N0+/x9qTqCtpiA1OhE2k2y6SKDSKtg477VkRWWVZKjJbH2m6GKQheurdynM
	dySzra7q/jN+o9xrvg4bexh4ur6/psywQSDB+6zccVPfMb6ihmrBh9sHM1+0I3xn
	SCm5yidr3P9G14p9kd5/ZLvLiVM8wpyanAwrKXZW2/Gk/QIHnShXe8LT1It9minP
	abx4p5iwwEwtRMGlPRkNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792859717; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:xHkkSIqsYynzgN9Wjo+uy8xQamwigapA8k5AqJAK/BvQiKb
	jBXir0OfZL4ER/knV6Strfw4SpeY6mOv6Ol+32GO0hObPOzrYFwV2vnrct/omTI2
	z63f3jLT1SudLSVUshxdAxHRJCmmTcnolLnf4bOa+ktAuPogAygGVYeXi/oPSn1C
	q+kH9kYgkHBBay1kwL7apHBCzor4KxV4mxWlKnUIeLKrDUhW2vmqWswon6DTa8Wj
	7LmMJtjZD1SMrizdi2zCGU8M65Evse8iYCcarLA9AP4gnfOpg2UCSYOSf/zNx5iE
	Wlc/BxFlDDFp0ItfDRiw32m/EiCBRkuWxiVJshQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JnbRzMatNOWh6VYk3BtMyVistKV9n98HRh1lJrMuiyI=:s7RKaOxqLU8WzgWaRyrCiYLjCHz0idVdL2rlY3c6L5w=;
X-ME-Sender: <xms:Q97carmA3_xGeqSlgVk8faN9acf8fxLirifsX3U9VTRqL8U5BKfszw>
    <xme:Q97cavkNz9L4po1mV2XOeF5DcVEndKPwyd413O8HaE-Au3TPJY6jd4bkNa7yut72N
    97rywkUVO3ReW-HI3kJIXje6Q7zWYfLxtcwtvQvJfY9JA3gINcE>
X-ME-Received: <xmr:Q97caqjYB8YGnVQGqpVwONajta7tJM0SiEkEfbanOZY2GQp6SYfr3KgNGIfRFQ>
X-ME-Proxy-Cause: dmFkZTF9g0HInb6yy90yfs+ss2zLTr6q9s2zMqnyVsBip2hj18csqpDRvrtfuwSbKKJdKA
    psdh8APLESm8UW8KW01iTqR/S/iRc1Cr4qo4b5Xvo1no8IwYaEMVHtNNjO+pv3ub7J5k4n
    szfnLzyxBxdMpJ70bAXPu417N3F0afseT87ZW2VZCtJeqMVXl3L9yeaBEZmUVots99yNm7
    fErISCP5VUjfv2eP10lfqk0j76TstgnE+aocUeQ5nhqqoe7/7PSyPHEZtYRK9uIa37tQGz
    daj0FHGFjc2S8vyptHVdBTYLfKS0jbo0wjNsNJchNiZajaKm6mcEi63hGrqETG70q6Q7iY
    2aDtOSpItAChdWXVXgRsecuefI3YGiNy/5tzR+n94CkkrgWuYrfga0EBN2TZhjMAla6DB7
    08mXSwJMEpvrbzfNCbuIDYpjIUrJSpfs4YYhH2Zk6LM4fgA0VlbnrxlpUIInldNvCwCwwi
    nyDGoI5RTkojCyZKpoAKEA5LEZjHAv4esvgzLWW9LUsXv2W1pal6pcX0grJnNh+ICAdr3X
    1sMnr+bWuARbAQ0lzpoLGz8HL+VysK7EfCg+SQyz8j4CTYwPdLl0USuckBMLT1ONgPXxgI
    sblheuKLPQHtfON71CR2+i3cC7syWwmzs8IqhBPh/STaXERhx43fa5rVoGGA
X-ME-Proxy: <xmx:Q97carfFfA4SXJtQiRgFajU4VapE3uPl5gkpqu0fLCYli2F0957kqA>
    <xmx:RN7cao_bSBYz6_AU4G_ivQhzgNK86Q5bEAi8UShmqhP2zTqObGxUCg>
    <xmx:RN7caphlL7Mlc8KWfZbl2GPnu19Sl2Vw9qG1uReehdpmDTVj-d9zvg>
    <xmx:RN7cak-MaVrw-X_KHEiKfZbm9VsstGzvp_XMLnPmZEjeLXaiQ2p0gQ>
    <xmx:Rd7canhIppUmJGzskxC_Ni_y7PxhQy9T-N5ARTumtHQB2GalI6fGR1z4>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:35:13 -0400 (EDT)
Date: Sat, 24 Oct 2026 10:35:12 -0600
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
 <thierry.reding@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 alex@shazbot.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261024103512.4601ee4f@shazbot.org>
In-Reply-To: <2026102437-vista-unsoiled-b089@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
	<DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
	<arIvG0nx4LXG9nlW@monoceros>
	<defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
	<9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
	<2026092321-province-yearly-44aa@gregkh>
	<arOfHEsGGglNse7T@monoceros>
	<2026092348-victory-erased-0e5a@gregkh>
	<20261023181326.0dc2f7ed@shazbot.org>
	<2026102437-vista-unsoiled-b089@gregkh>
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

On Sat, 24 Oct 2026 06:56:34 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> > On Wed, 23 Sep 2026 12:29:56 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-K=C3=B6nig wrote=
: =20
> > > > > No, drivers should NOT have to do that in their .probe() function,
> > > > > that's what we moved away from decades ago!  The match function s=
hould
> > > > > handle all of that for you, otherwise it's contant duplication
> > > > > everywhere that is unneeded.   =20
> > > >=20
> > > > Well then you have to accept that root can provoke a null pointer
> > > > exception (e.g. by forcing the pwm-tegra driver on a device) becaus=
e at
> > > > least with today's platform bus match function such a match is ok. =
  =20
> > >=20
> > > Agreed, yes, root can cause a crash and can do tons of horrible things
> > > much worse than this, that's not the issue.
> > >=20
> > > That's why this taint is there, to make it obvious that this is not a
> > > "real" bug at all.
> > >  =20
> > > > > Please, learn from our history, don't make the same mistakes.
> > > > >=20
> > > > > Now I might be convinced that driver_override is the way to go he=
re, but
> > > > > it still feels really odd as again, bind/unbind was created as a =
driver
> > > > > debugging option only, it should NOT be a normal operation that a=
ny user
> > > > > should rely on.  The driver should "just work" properly instead, =
without
> > > > > requiring manual bind work, as that's not a good model at all.   =
=20
> > > >=20
> > > > I agree in principle, but (in my case wifi) drivers are buggy somet=
imes
> > > > (due to missing documentation and/or engineering effort) and being =
able
> > > > to rebind the driver instead of rebooting to get a working device a=
gain
> > > > is very useful.   =20
> > >=20
> > > Fine, use it!  Just don't expect that to be "normal".
> > >  =20
> > > > So yes, theoretically bind/unbind isn't needed, but theory and prac=
tise
> > > > differ in practise.   =20
> > >=20
> > > Agreed, but again, don't rely on this as a "real" solution fo ranythi=
ng. =20
> >=20
> > Sorry, late to the party, but this isn't a few user scripts that rely
> > on this behavior.  Effectively every use case of vfio relies on this
> > behavior.  We rely on unbinding the default driver from the device
> > before using driver_override and drivers_probe.  That means every
> > hypervisor with device assignment and every userspace driver use case
> > now experiences a tainted kernel. That seems like a significant
> > regression. =20
>=20
> Or finally, a real bugfix :)
>=20
> > There is currently no alternative for this process.  It's not a matter
> > of upgrading to a newer kernel where the drivers claim the device IDs.
> > We can't claim the device ID, vfio drivers represent a secondary use
> > case for the device. =20
>=20
> How can vfio know that it can properly talk to any device like this?
> Surely you have a list of real device ids that you know will work,
> otherwise all bets are off.

There's not a list of real device IDs.  PCI, in particular, is a
self-describing bus.  Devices are discovered via bus walk, their
resources are probed via standard mechanisms, they support interrupts
and resets as described by capabilities defined in a specification.
The vfio-pci driver just provides a generic way to represent a device
as resources mapped to file offsets with ioctls to discover those
offsets and interact with things like resets and interrupts.  For
example, PCI config space and BAR regions are just defined indexes into
the table of file offsets.  This works with any endpoint device, where
even that distinction is based on the discoverable PCI header type
rather than a table of device IDs.

Even if we could come up with a set of device IDs, it's a policy
decision whether a given device is intended by the admin to be used by
the default in-kernel driver or a userspace driver.  This policy
changes over time, within the same host session.  That means that at
one point we want the default driver bound and at another we want a
vfio driver bound.  Coordinating this is exactly why we have
driver_override and, building on that, match IDs that require
driver_override.  This allows drivers to describe themselves as vfio-pci
compatible drivers via modules.alias while requiring userspace to
enable the match via driver_override.

This is how vfio-pci variant drivers work.  These drivers contain
device specific knowledge, for instance the ability to serialize and
expose device state for migration, but they're still a secondary use
case to the in-kernel drivers.  This is effort and coordination with
subsystems and driver-core over many years and relied on by every
hypervisor, now deemed unsupported through a kernel taint before we can
even bind the driver.
=20
> > A production use case of panic_on_taint now results in a hard failure
> > for a scenario that has been allowed and documented as best practice
> > for many years. =20
>=20
> It was never "best practice", you took a debugging option and somehow
> thought it was a valid use case.  Yes, I'm being harsh but I am sure I
> complained about this in the past and obviously never followed up on it,
> so that's on me.

I won't doubt that you know more about the history and intent of these
interfaces than nearly anyone, but I don't find any documentation or
comments that specifically declare these as debug interfaces.  In fact,
Documentation/ABI/testing/sysfs-bus-pci has documented the bind and
unbind ABI for over 20 years.

You've certainly expressed more than once that users get to keep all
the broken pieces if they bind devices to drivers that don't support
the hardware.  This is the first that it's been formalized in a
taint without warning or an escape hatch for drivers like vfio-pci that
do in fact intend to work with all hardware.  It affects the industries
that depend on this usage model.  It's a regression.

> > What's the solution we can pursue for the scenario where devices have
> > dual use cases between in-kernel drivers and userspace drivers?  Thanks=
, =20
>=20
> So what is the real use case here, taking any type of any device and
> thinking you can bind a random kernel driver to it and it will work ok?
> You all have specific platform and pci vfio drivers, why not use the
> proper device ids there instead, or better yet, bake-in this type of
> functionality into the bus-specific logic so that you can have generic
> userspace control of a device (like usbfs and uio does today)?
>=20
> We have real problems with random "bind/unbind" attempts that this taint
> is here to help resolve as it was creating hundreds of false-positive
> bug reports on developers all across the tree now that the fuzzers
> decided to think this was a valid action to take.  Without this taint,
> people were being forced to add hacks to all drivers for this which is
> not an acceptable solution.

At its core, vfio is describing the fundamental aspects of a device,
regions and interrupts, without purporting to know anything about the
specific programming model of the hardware.  In the case of PCI, the
vfio-pci driver effectively decomposes the PCI representation of the
device into a set of ioctls and a file descriptor.  A userspace driver,
for example QEMU, recomposes that representation back into a virtual
PCI device to the VM with virtualization, emulation, and direct access
wired through to the physical device.

There are no devices deemed only for vfio use by default.  Often we're
unbinding a device from the host, exporting it to a userspace driver
through vfio, exposing it to a VM, only to bind the same driver to it
in the guest that it was previously using in the host.  Binding to a
vfio driver is always a secondary use case governed by the policy of
the system.  We cannot create scenarios where there are competing
drivers for a device.  The vfio driver is always brought into the
picture via driver_override, and except in the rare case where no host
driver exists, unbind must be used to release the device for
drivers_probe.

Is there some way instead that we can resolve the string written to
driver_override and only taint for non-vfio drivers?  It's a much more
confined problem if vfio drivers filter hardware outside their scope of
support in their .probe function, and I think we largely do that
already.  Thanks,

Alex
