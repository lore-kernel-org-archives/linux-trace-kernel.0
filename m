Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792818113;
	b=x0ITSq1ydiKZvMrxgt3BGp+QlSrU5oKeQPerUbnHe0uh0zhLP0mj4Hyep3+0m8NHnkak
	 OwI1Koe6lQBZDxlvMunYDyNwMJaVSTgzvD0Weafe9ezeANRNW9K5HO/xgAdqTlRibcREa
	 njDo+mmBHMxj8I4xixVr+YJtJxR61ZY/Y0orhDDu0HqTYubW8kOQV4oIq5yBdf8oms6gg
	 Sg8k3xjG+8mPzmjwNIsnk0BudGMnsWx2M7ilTIR92YEEwYMtQOy8lCofj8uSj93aV61Wx
	 DTANpiYzezwKMGwQ3NX/rzZS1PW5fzPzJWMas2CVJKVGOZ7oqWxzjQx0RPSYFBVZlQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818113;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=YEovTDR9SiuVKkDWnIJaVfx9ijSldXikdYRm1L41uuw=;
	b=3Q5EAETtZs0p5Y45Cwv4Cf2iwAWoXM2T+rajwi+QHuyLlkCYAxJF7onx2APMfzY/BuEP
	 HeirUmczL6JEAOcrDOoutYptvx5T1GzeWbpwAYZiVHqB7a786ebQO7Rwi3TpVGo5Eg/VX
	 +qqe0gBDp3eMPVrR++Y9O0in1tZuyR4Jta9MtyK9CDCAgwnfLgTR0kg+JMUBS7usObiI1
	 iHb+myXU6bNUI07fxmTibeV/pDD2sE5FhhSpwpTJt8k8cAemo2/3w85mEbdWLWpNqHftG
	 PSCZJC6Pu3xreH03DrURLhEttPHtSipYaaQsqRmSgqWuOMoL5gsg0lKM+rYqjgxJ1UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K1Vs2Cxv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA933606A31A;
	Sat, 24 Oct 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K1Vs2Cxv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9902E1F01828;
	Sat, 24 Oct 2026 05:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792818112;
	bh=YEovTDR9SiuVKkDWnIJaVfx9ijSldXikdYRm1L41uuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1Vs2CxvZXtblpQtQXrnnlHWWUZ+yaHbnD/r5lVmW5zyAYTpiY79C877mgDztRmmd
	 SNRXQ/tUBIjSKdyx0a+QHrqwJXgVxq9HMusPK8zLmyr+Lq0unPm73QqXc8ulTy2Fp9
	 PZzIf9yYAwn9Jm0p/1RtRTacGdWGlcfJHTaOeWvU=
Date: Sat, 24 Oct 2026 06:56:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
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
Message-ID: <2026102437-vista-unsoiled-b089@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023181326.0dc2f7ed@shazbot.org>

On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> On Wed, 23 Sep 2026 12:29:56 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:
> > > > No, drivers should NOT have to do that in their .probe() function,
> > > > that's what we moved away from decades ago!  The match function should
> > > > handle all of that for you, otherwise it's contant duplication
> > > > everywhere that is unneeded.  
> > > 
> > > Well then you have to accept that root can provoke a null pointer
> > > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > > least with today's platform bus match function such a match is ok.  
> > 
> > Agreed, yes, root can cause a crash and can do tons of horrible things
> > much worse than this, that's not the issue.
> > 
> > That's why this taint is there, to make it obvious that this is not a
> > "real" bug at all.
> > 
> > > > Please, learn from our history, don't make the same mistakes.
> > > > 
> > > > Now I might be convinced that driver_override is the way to go here, but
> > > > it still feels really odd as again, bind/unbind was created as a driver
> > > > debugging option only, it should NOT be a normal operation that any user
> > > > should rely on.  The driver should "just work" properly instead, without
> > > > requiring manual bind work, as that's not a good model at all.  
> > > 
> > > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > > (due to missing documentation and/or engineering effort) and being able
> > > to rebind the driver instead of rebooting to get a working device again
> > > is very useful.  
> > 
> > Fine, use it!  Just don't expect that to be "normal".
> > 
> > > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > > differ in practise.  
> > 
> > Agreed, but again, don't rely on this as a "real" solution fo ranything.
> 
> Sorry, late to the party, but this isn't a few user scripts that rely
> on this behavior.  Effectively every use case of vfio relies on this
> behavior.  We rely on unbinding the default driver from the device
> before using driver_override and drivers_probe.  That means every
> hypervisor with device assignment and every userspace driver use case
> now experiences a tainted kernel. That seems like a significant
> regression.

Or finally, a real bugfix :)

> There is currently no alternative for this process.  It's not a matter
> of upgrading to a newer kernel where the drivers claim the device IDs.
> We can't claim the device ID, vfio drivers represent a secondary use
> case for the device.

How can vfio know that it can properly talk to any device like this?
Surely you have a list of real device ids that you know will work,
otherwise all bets are off.

> A production use case of panic_on_taint now results in a hard failure
> for a scenario that has been allowed and documented as best practice
> for many years.

It was never "best practice", you took a debugging option and somehow
thought it was a valid use case.  Yes, I'm being harsh but I am sure I
complained about this in the past and obviously never followed up on it,
so that's on me.

> What's the solution we can pursue for the scenario where devices have
> dual use cases between in-kernel drivers and userspace drivers?  Thanks,

So what is the real use case here, taking any type of any device and
thinking you can bind a random kernel driver to it and it will work ok?
You all have specific platform and pci vfio drivers, why not use the
proper device ids there instead, or better yet, bake-in this type of
functionality into the bus-specific logic so that you can have generic
userspace control of a device (like usbfs and uio does today)?

We have real problems with random "bind/unbind" attempts that this taint
is here to help resolve as it was creating hundreds of false-positive
bug reports on developers all across the tree now that the fuzzers
decided to think this was a valid action to take.  Without this taint,
people were being forced to add hacks to all drivers for this which is
not an acceptable solution.

thanks,

greg k-h
