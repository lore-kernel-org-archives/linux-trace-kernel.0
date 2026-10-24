Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792828999;
	b=f6PNGbJdT6tPkJEGpEDGBTsuj7VXaA87jDBBsnTeFFKs7hjJ8DtDs6jzwnIqHpa2UE6G
	 QmaYsX7yq+idawHf88MhHF69mKFJVxfG7r8yxcqk220XnT+um+3PHgqlb7+XSJXDCM8po
	 dtW5kiamyWo17avxmpoqWvshaHyDKvnOKyb0uycKcJPXFCJplSsy5LaeUFAXfOxrMp5k3
	 fatph/YXIS6jPhG/x8YsfAwGmDlpWkMZO4QcV51mQniEN9Fvq8LmY0jtl1h2U/XGSQd34
	 G5LWVliohxbiPulQ6HnWeqN9fo3TTLLzQ/sIEjlYPk21VvcNv2baXi0xsUCfAJPWmCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792828999;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=8I7PHHye8JpA6spuSf6FF+Dzt4KdS5nxOce7osDTdv4=;
	b=YkXi4RPAapSrjUmnPUD/tg3gxqBWyTeXtLE51ZzkTRt2+Bu4DzMfM9bEc6GAkay4e7e2
	 C+4i49mYLonCPYt4UAAZIjjIY3fSfo+bXSVbMuYU98nJTFHHzXGAE/y1U3BLEzyaRvu10
	 uzFYo8r/M0dhnMCwgGVQS2sk0DWERskDvxowaBcv0l482pWiHVt8/m2xrSU8S1f27VUB3
	 3/P/rLXU1EZ/oNBjH41yOBuP7T/Q0y6XLBC+gQTDsCNGmJxYz1zjEpCi5DZ4FrPqhl3Fm
	 TOuzvrC3oCm+7D8Yahx3d10qvaNhkoKXa4GpvBOpmkgX6oifHuA9pvlAlSF8ZuxXUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=as9NhG5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E6606A31A;
	Sat, 24 Oct 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=as9NhG5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5AC1F01825;
	Sat, 24 Oct 2026 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792828999;
	bh=8I7PHHye8JpA6spuSf6FF+Dzt4KdS5nxOce7osDTdv4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=as9NhG5oQHTobK2/mtbYfX081L8TiGN+7Nke+BYiyax0jCpaUVAdlv4rxiI/MsO/J
	 N8SyqbaUfDpXNj01HeWdCCQXVLR8Zv3Kv/lCTVi8nZ9GsHXf9juNHK8qc4GyXDYcq7
	 hTJ0QGdsJ5f7MkBUTBgnp5ohe3tIQPxOPvg8MCJv/1So9b85nP+mWMiSzCmDWeFhJf
	 t1GDmUJ0ktNZatQbgYNWY+flxNFjHzCHL8M/LxpYkBauFIb2ZMJRQ15NKgOrjkrFR9
	 H76M8b0+h/axA2ikfcA1ukWKHarV5+sApPluSWXeva5cRO4fpVtT5xL8Bvphf2gcK4
	 VVYHwX8inR9cQ==
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 10:03:11 +0200
Message-Id: <DMCWU4HYYXQ8.3W3UIPO3K16QA@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alex Williamson"
 <alex@shazbot.org>, "Armin Wolf" <W_Armin@gmx.de>, "David Lechner"
 <dlechner@baylibre.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Aleksandr Nogikh" <nogikh@google.com>,
 <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-trace-kernel@vger.kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Richard Weinberger" <richard@nod.at>, "Thierry
 Reding" <thierry.reding@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org> <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh> <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh> <atxdQ4vfh-b6GD0B@monoceros>
In-Reply-To: <atxdQ4vfh-b6GD0B@monoceros>

On Sat Oct 24, 2026 at 9:32 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Why is it false positive?  IMHO unless it involves a driver_override it i=
s a
> bug to fix.

In an earlier reply I mentioned that we can leave it as a follow-up to limi=
t
this to buses that do not support hotplug (will send a series soon), as we =
have
quite some drivers - for devices on buses where it is not expected that the=
y
ever go away - where those drivers don't implement a proper teardown sequen=
ce;
for buses that support hotplug we should only taint on driver_override.

One can argue that they should be fixed then, and I would certainly love to=
 have
all drivers to properly implement the full driver lifecycle, but it would a=
lso
mean to write a bunch of code that in practice is just dead code.

bind/unbind sysfs attributes (as well as module unload) can break such driv=
ers,
which, under the premise that those drivers don't have to write this "dead =
code"
in the first place, is a false positive.

But again, I'd still always recommend to properly implement the driver life=
cycle
for new drivers for various reasons (portability to other buses, general dr=
iver
design, etc.), and I'd love to see existing drivers be "fixed", but I don't=
 see
how it is reasonable to expect this to happen.

(Luckily, in Rust that's at least partially never going to be an issue, as =
the
core APIs can fully enforce a proper driver lifecycle statically without dr=
ivers
having to write extra code for it. It obviously can't enfoce to leave the d=
evice
in a defined state though.)
