Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046899;
	b=ySeC2o0pUH7eVbzWq+VRgDS9TUr6Bou3Kie87AcR7E9rrERKeMTnZ6t11u2kQ6T+W5kp
	 uEEwVDPeYdZJ8jjD441mEIaIgQ87lCGOdTQg5Bpzg+mWewWobX8Dt7NwuV3jUQ5bQRsV4
	 WL9bufoMim83UuEohaNkVHMVourcR+co/rtZKjb/l6Ix8CUfhk/gjiArZBMTkTY2q8iww
	 29BvvjwtTlKz0TdOIbKORAc+3kQBUZ3A9S9tHBx8ynQBcqrmq6uU7eOw0otYAQ0r3L1T4
	 0sQYjm7JVCcPC7n6Ej98KMXkODABFBA3Gllj35Y8KfluXVhLKjZuxOtmlazvOBPYHqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=X4l+Gy2WdA0ddUhGXKOE2P+Ofd0gYPNJBhhqsMmOdoc=;
	b=npZCa7legZJDc6TMbbjQDtXJo0cHLSwnQGzpsEIZgPDI40zL0Y5m89kmbhi+aHfUFoqd
	 PKBzjoGmhhbJL1u/1pHBxbB83rtkHejMBepEqN6ssD1bpLVw8H45+868l3RcLaaIx5sjO
	 BSNFSHwdg5lVDTD3SuAg2Khloz2P+EpC2f/2vWiOrJC/wVuQNMKHlIJfsv8Hr4D18bapp
	 pt6W1jOvdeYp9BytIqDykVeYOcF/xdgLYJLA1FTiiLJtfMaphhhPnnQTTYl68vtEawVEw
	 uLKD0m9SkqcneUCCmY8FfVaagPXzc6fVREH4b3SQ4IRd3tQewvtAP3P7JFKdKQCSFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhwDA1y8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A6606A31B;
	Mon, 26 Oct 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhwDA1y8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006B91F01825;
	Mon, 26 Oct 2026 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793046898;
	bh=X4l+Gy2WdA0ddUhGXKOE2P+Ofd0gYPNJBhhqsMmOdoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhwDA1y8p5GYw/Jz97+tRiTWOB2v/l9UiHdxmXQoxCHZTr5uhmhPJZRofD5cmNMUV
	 mQAZFZOcZo4rB1u8dXEgBWSRMdpy4s9rP4PaHqTuulnUTUd6AQIr/ga54o6AKO98xW
	 EwqzitAOT+yloNDHU/FN15n5SLh91EP6Vc34IRK4=
Date: Mon, 26 Oct 2026 21:34:57 +0100
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
Message-ID: <2026102637-buggy-mothball-2a08@gregkh>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <20261024103512.4601ee4f@shazbot.org>
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
In-Reply-To: <20261024103512.4601ee4f@shazbot.org>

On Sat, Oct 24, 2026 at 10:35:12AM -0600, Alex Williamson wrote:
> On Sat, 24 Oct 2026 06:56:34 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> > > On Wed, 23 Sep 2026 12:29:56 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:  
> > > > > > No, drivers should NOT have to do that in their .probe() function,
> > > > > > that's what we moved away from decades ago!  The match function should
> > > > > > handle all of that for you, otherwise it's contant duplication
> > > > > > everywhere that is unneeded.    
> > > > > 
> > > > > Well then you have to accept that root can provoke a null pointer
> > > > > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > > > > least with today's platform bus match function such a match is ok.    
> > > > 
> > > > Agreed, yes, root can cause a crash and can do tons of horrible things
> > > > much worse than this, that's not the issue.
> > > > 
> > > > That's why this taint is there, to make it obvious that this is not a
> > > > "real" bug at all.
> > > >   
> > > > > > Please, learn from our history, don't make the same mistakes.
> > > > > > 
> > > > > > Now I might be convinced that driver_override is the way to go here, but
> > > > > > it still feels really odd as again, bind/unbind was created as a driver
> > > > > > debugging option only, it should NOT be a normal operation that any user
> > > > > > should rely on.  The driver should "just work" properly instead, without
> > > > > > requiring manual bind work, as that's not a good model at all.    
> > > > > 
> > > > > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > > > > (due to missing documentation and/or engineering effort) and being able
> > > > > to rebind the driver instead of rebooting to get a working device again
> > > > > is very useful.    
> > > > 
> > > > Fine, use it!  Just don't expect that to be "normal".
> > > >   
> > > > > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > > > > differ in practise.    
> > > > 
> > > > Agreed, but again, don't rely on this as a "real" solution fo ranything.  
> > > 
> > > Sorry, late to the party, but this isn't a few user scripts that rely
> > > on this behavior.  Effectively every use case of vfio relies on this
> > > behavior.  We rely on unbinding the default driver from the device
> > > before using driver_override and drivers_probe.  That means every
> > > hypervisor with device assignment and every userspace driver use case
> > > now experiences a tainted kernel. That seems like a significant
> > > regression.  
> > 
> > Or finally, a real bugfix :)
> > 
> > > There is currently no alternative for this process.  It's not a matter
> > > of upgrading to a newer kernel where the drivers claim the device IDs.
> > > We can't claim the device ID, vfio drivers represent a secondary use
> > > case for the device.  
> > 
> > How can vfio know that it can properly talk to any device like this?
> > Surely you have a list of real device ids that you know will work,
> > otherwise all bets are off.
> 
> There's not a list of real device IDs.  PCI, in particular, is a
> self-describing bus.  Devices are discovered via bus walk, their
> resources are probed via standard mechanisms, they support interrupts
> and resets as described by capabilities defined in a specification.

I know how PCI works, I used to be the PCI maintainer all those years
ago :)

> The vfio-pci driver just provides a generic way to represent a device
> as resources mapped to file offsets with ioctls to discover those
> offsets and interact with things like resets and interrupts.

Great, then just have that driver attach to the specific device you want
by having it contain the device ids for what it wants to control.  Or
have it say it wants to control all devices and be "last" on the list to
bind.

> For
> example, PCI config space and BAR regions are just defined indexes into
> the table of file offsets.  This works with any endpoint device, where
> even that distinction is based on the discoverable PCI header type
> rather than a table of device IDs.

I don't understand what you are trying to say here, sorry.  Yes I know
how PCI config space works, again, I was the maintainer and still have
access to the PCI sig through various means.

> Even if we could come up with a set of device IDs, it's a policy
> decision whether a given device is intended by the admin to be used by
> the default in-kernel driver or a userspace driver.

Great, then have the admin never allow the in-kernel driver to be on the
system, or be loaded (modprobe has deny lists) and all is fine.

> This policy changes over time, within the same host session.

what are you defining as a "session" here?

> That means that at one point we want the default driver bound and at
> another we want a vfio driver bound.  Coordinating this is exactly why
> we have driver_override and, building on that, match IDs that require
> driver_override.  This allows drivers to describe themselves as
> vfio-pci compatible drivers via modules.alias while requiring
> userspace to enable the match via driver_override.

And as said before, that's a horrid hack and one that is breaking things
today in all sorts of ways, which is why the taint was added.

If you wish to override the kernel, then great, a taint flag is added
and all is fine.  All this means is that now developers know what you
did and can decide to ignore your bug report or not.  No functionality
changed at all.

> > > A production use case of panic_on_taint now results in a hard failure
> > > for a scenario that has been allowed and documented as best practice
> > > for many years.  
> > 
> > It was never "best practice", you took a debugging option and somehow
> > thought it was a valid use case.  Yes, I'm being harsh but I am sure I
> > complained about this in the past and obviously never followed up on it,
> > so that's on me.
> 
> I won't doubt that you know more about the history and intent of these
> interfaces than nearly anyone, but I don't find any documentation or
> comments that specifically declare these as debug interfaces.  In fact,
> Documentation/ABI/testing/sysfs-bus-pci has documented the bind and
> unbind ABI for over 20 years.
> 
> You've certainly expressed more than once that users get to keep all
> the broken pieces if they bind devices to drivers that don't support
> the hardware.  This is the first that it's been formalized in a
> taint without warning or an escape hatch for drivers like vfio-pci that
> do in fact intend to work with all hardware.  It affects the industries
> that depend on this usage model.  It's a regression.

No functionality changed, just an informational flag is now in the
system when this happens.  The systems still obviously work just fine,
otherwise all testing so far of linux-next would have caught this,
right?

> Is there some way instead that we can resolve the string written to
> driver_override and only taint for non-vfio drivers?  It's a much more
> confined problem if vfio drivers filter hardware outside their scope of
> support in their .probe function, and I think we largely do that
> already.  Thanks,

Why are you worried about a taint flag?  So many servers run with taint
flags enabled due to out-of-tree or questionable licenses with no
problems, what's one more informational bit here?

thanks,

greg k-h
