Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088350;
	b=R+TDp80aukaH5/1VpSPfzzCqIXQKCPaZtz1ew3WsW2lA2V/HEuDKKLGR8iQIIwajNhW9
	 NcLi/DcqfcJEje4jhS3Q1cK58BIJxlc+A9/Lp0Kof4IIWqPEqXdMbSrwv/oqHvGFKKmXu
	 WjTiScPV5V41q7x87OAjzs9dKP1kKT+tDUYsKuzcf1+jPvtuQj14WggCSIPA9Q2rTO7Cs
	 JyZxezm4bpOpvQ7bQnh2P8DifnJu9caMpVDIUu1cav9cTWRv7dcfU0cSwA2U1+2icodbG
	 uB+z/kY/nfALPQTLwDuGKCRxG3XoFeEhIv9dwDmj+WnU5JBHeSI5ipnwSqtY24yhaAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088350;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BPrJ7zSdgkFlPfR666dcGKV7qJo/SNuXml2HNin/vAo=;
	b=X+7ui+paETDSIiv2knxsefGwAyqZpA8PQEXU+xMgCDqcuFknDY1xH0KDwPXBRHHEjrcu
	 fdzmbLu6C0aSFw3Go/C+gm75msBZDn+QPtYv17b+OkjyT3bJXFdHqfl5Fw0Mcp3dBuy5z
	 4bsO2fdPdCZHUSeKGCnmvnbYtRJaucNw7vIaiIZ7U7U5+A7ulUBjkwqsQpqOA0EdJxutR
	 kur14Tsr8snHdEZsJa2NubKydJW2hKFGQg2EAufVaG+ntGjhVzIlSNl25RMn9h6S9Uk41
	 jF9mL5urqOO5beV48WQpJAsvHWC2MCJUuN4Ri6261fC+erC0eRRcahoEJfXt91PY5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E9Rt7+fy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB2606A31B;
	Tue, 27 Oct 2026 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E9Rt7+fy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAF71F01825;
	Tue, 27 Oct 2026 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793088348;
	bh=BPrJ7zSdgkFlPfR666dcGKV7qJo/SNuXml2HNin/vAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9Rt7+fybzwSR2JXSEMbcSS2YSEXxhtSq/QjU3jgLpkUV+fklU2NxK+HrJcEoXOUu
	 dllpoob+VAQlCfum2hsbbvZhGAN5hsXW3v33jsFtpHlGyzisj8rZcalg6TGHAXmfRo
	 UQE7gkIncVP0CkPNUOXzbTknZZOlhrvtULldMSDI=
Date: Tue, 27 Oct 2026 09:05:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <2026102711-spectator-courier-13d5@gregkh>
References: <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <20261024103512.4601ee4f@shazbot.org>
 <2026102637-buggy-mothball-2a08@gregkh>
 <20261027070300.4c45616a.michal.pecio@gmail.com>
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
In-Reply-To: <20261027070300.4c45616a.michal.pecio@gmail.com>

On Tue, Oct 27, 2026 at 07:03:00AM +0100, Michal Pecio wrote:
> > And as said before, that's a horrid hack and one that is breaking
> > things today in all sorts of ways, which is why the taint was added.
> 
> Are you aware of bind/unbind breaking things for PCI specifically?

Yes, we had reports of this happening for many PCI drivers where unbind
would be triggered and a random pci device would then be "bound" to the
driver and the kernel would crash.  See the zillion syzbot reports of a
few months ago, which caused all of this to happen.

> Without also involving 'driver_override' or 'new_id'? Everyone agrees
> that these APIs used for anything other than pci-stub or vfio are foot
> guns. But your patch targets something different.

Yes, driver_override and/or new_id was being used for most of these, BUT
unbind for other busses was also causing problems (specifically many
platform drivers.)

> We can even bind PCI drivers to wrong devices *without* using bind and
> hence, I presume but don't care to test, without tripping this taint.
> 
> > If you wish to override the kernel, then great, a taint flag is added
> > and all is fine.  All this means is that now developers know what you
> > did and can decide to ignore your bug report or not.  No functionality
> > changed at all.
> 
> I believe people pointed out that it's a functional change for users of
> panic_on_taint who also use bind without being idiots.
> 
> Does this taint even solve a "real" problem? Those bug reports weren't
> coming from users, they were coming from "abusers" like syzbot looking
> for trouble. They were quite obvious even without a taint message.

They were not obvious at all, see the patches that many maintainers
"accidentally" took to fix a bug that really wasn't a bug at all.  This
was forcing additional code into all drivers for no good reason, hence
the taint flag.

Let me reconsider this and think about just doing it for the additional
id and allowing busses to trip it when their unbind is hit for busses
that should not be normally handling unbind (i.e. platform devices.)

thanks,

greg k-h
