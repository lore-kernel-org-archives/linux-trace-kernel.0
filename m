Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B7325701;
	Wed, 26 Aug 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759052; cv=none; b=hNp663ZMF2H4FZZ0v7FGm9AfMSJbiddTF+ozqk07hslhwiTEBJlkBSN8iTNgSjsIW4ke+lAhs8IDCZoUcWmx87O1CT5YwGnPyi6NK1qXlh20QHVhz7MKkWlSFZFt2pE5EZ1JUsqN3Op6wYlHNa2PV7HEqPON5r40qZqSXLg3N/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759052; c=relaxed/simple;
	bh=01OA8TapfiqREWY5qdNgocQ63a1Ng3x75mPwRkL44so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf/wNQLcfOr1yRF+SP6rdWE41nOg8lbxsQG3GcAiEPWfDMtT/xikA5U9gqo68uGc6PmCtuisETMqVrOgVoh4ofZiqWcb0MXjcR5Dsa3O3vxE67FCYb/HzW4pk+5Wm+NI7IKHEddL+OOQugOo141BK9RM3q4Q0m2/iwJ+3LO88p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Im/eGPGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Im/eGPGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA31F000E9;
	Wed, 26 Aug 2026 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787759048;
	bh=Vf2B2DdVbRkFpNGj3JOupYLPnXTY63U7LDwuZejwfww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Im/eGPGy7JjkgYQUMVExoxSF3n4YW3PB2MUfI8/9+1cV+vpCCTB8H3OtGFOwTu/hQ
	 6E2tKx6WyOk6VK3iKskPKX9JsJRgNgyBCt7fHO9xpany2fWE8NWK2f3hLgJlzLh47x
	 i0UJwc7r7qChiUfmd+HjnfsSzsgCG8BAXq1TfogY=
Date: Wed, 26 Aug 2026 17:44:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <2026082634-cloak-ambush-3861@gregkh>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826153311.6340efcd.michal.pecio@gmail.com>
 <2026082658-statue-census-dc39@gregkh>
 <20260826173549.18c8a89c.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826173549.18c8a89c.michal.pecio@gmail.com>

On Wed, Aug 26, 2026 at 05:35:49PM +0200, Michal Pecio wrote:
> On Wed, 26 Aug 2026 16:25:42 +0200, Greg Kroah-Hartman wrote:
> > > I think you confused 'bind' / 'unbind' with the likes of 'new_id'
> > > and 'driver_override'. Try binding xhci_hcd to NVMe, you won't get
> > > far.  
> > 
> > It seems to result in a failure report that people keep sending random
> > patches for :(
> 
> It results in write() returning -ENODEV.
> 
> You can't bind random drivers to random devices out of the box,
> you need ID overrides. And then you don't need to bind manually,
> the kernel will happily select the wrong driver by default.
> 
> Authors of the recent xhci and thunderbolt patches admitted that
> 'driver_override' was involved in both cases.

I'll be glad to taint if driver_override is also written to, but it's
bind() that triggers the actual action happening.  Or so the traces
show.

> Meanwhile, Syzbot also found a stupid write to freed memory in USB
> core when HCs are unbound. You may say it doesn't matter, but:
> 
> * USB HCs are hotpluggable thunderbolt "gadgets" these days

We support PCI devices being removed, but that falls under the PCI
hotplug rules/requirements, right?  Anyway, sure, we can fix those bugs
when found, but that's not the majority of what we are seeing at the
moment.  Look at all of the dumb platform drivers that are getting hit
with this on the syzbot reports...

> * there were plans to alter this code so that UAF is triggered by
>   hot removal of the USB device, not its parent HC

I don't understand what you mean by this.

> IMO the actually meaningful change would be to taint driver ID
> overrides, because that's the known risky and crash-prone madness.
> bind/unbind taint is noise that will be ignored.

it's not going to be ignored if panic_on_taint is enabled in syzbot,
which the authors have said they will do :)

thanks,

greg k-h
