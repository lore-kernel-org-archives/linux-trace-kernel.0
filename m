Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054781;
	b=qh9NFF9dY4A5xkNNSPl8qhs7wZ9F6oQrwmIQBwPRSSI7bjBXv9eiGMdmK9wOAVQVa8zl
	 T0M8Nt7kHX7fYNngJ3xfeZCNicENHS4N+o0SjHjhWdFnq15vNaC0/suKEzawoGYMQTKUL
	 6kpJHIhKKLPq6nrzQ5W23Akp0nQNc54XaYtFrjt0lM/6tK9i3PaXqyhRRgek0tVO+BkJY
	 JUpzapTYfOFOeZLw30W4FU17Ov5hgRhORnutFSU1h4lMJjhtGKIarz3q9X9H/nGpb1T5y
	 IDBHM5zwQbT/O4uMrrQA5A9kmZ2EGMugmgPPSQySKfB/UGtmOpwlR5C66Ql7aN8Jj7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
	b=XdLI0UlupaWAEP2TOQWoKI0ouvxE4Q05exGEwghA756DYsElhlRMs1YmcdiE0CT++7ZB
	 +ZqwnTKpZtOqFUZNIRW8NyYmTwJJCfQdegfC1zCH1nqgJdSbn9bryLDkVYF/xYVq4HLO8
	 XJSiXHoSnbslWWx+p8fb5omBHmiI86SPEMeVvOEqNUnmnAILTjgw4eRXnLAN4+6bEnpCF
	 wQNAS+cLk3YqWawi0X5GU7+/vtmfXn+inslVozRru7uqjjDqxqQZhjfWaNXj/9dSMMdTp
	 1TYRQZnJMAbIb9EXj+RA7V0liU+ls6XC3457ukvz8T04ai75OzdHUaFrBgJBD/GzWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CC606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 22:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E1CC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FkMZwh2x
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e503815adso381120085a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793054775; x=1793659575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=FkMZwh2xzPGwRXd/6L6YakG28E0XxcbpH4yKhlkVxLiFKRDjnkg0rF4SuQFtOzIsX3
         f5EydNInmzCSCkyh6zkwX5LrW6pJx+yykjP8eF8zTTd4GpSQj2j9YnRNaZqf70z8RmUZ
         V0j9HOG4zRyyPYbjGh8fDJ0CD1b0yexVSSPmIWU3JWr5lLooPlsfB7nv06CCSg5v12eV
         SoxqEP3dz0sh5FDLSqHEK/sK60fYdYH1JO0HlXuGIhkW+uO84PFYtLiQpk8JsiURcZjY
         uPsNy3n6D4nHtcEj11lG1ob2im6ANFeMkqY+1XCA/fQxPdUxjOQ6lMGPBUzC0mYbVssK
         Q32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054775; x=1793659575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Idt4XOOJiJpLeVn+jwc4zJtq10BdWV/RKYdo6dVBsA=;
        b=Bcrc6zdQh1yq/FScBy31UmawDZXMR2xq77QUf9loiPn8gwN07Lvw1E5oXsM/KfrA8z
         JiubMIf2yWfTVKGFZZC2NkJKSqRh+X6FqO01kS6VSX29L9Pg5aC/6RvN8TzeM7sJzkkq
         4OEYFSo9ncsmH7iFF1WCGNTO2ec2prFZVed2ZFuwV3R3RVJyAHKQSL7MUb9CRe8Efxrn
         m3oM6UwhdiRkEN+WG5jtn0HHp+ldeHKLLOeCp2y3MHXq3QL/ddXnsQShnIqNhI4Rdjls
         UEV6cq8p1t6Efv13FZAmV3xLIThfZv0hI0DDH9+PJuTawJtIGhfoipaUkA2loWhAF1Uh
         cLnA==
X-Forwarded-Encrypted: i=1; AKwUvBwlvTTOlTkW342naacOr/fjlzDd1tjn79BRGkuDV2kO4GNRTRjFp/gpwdzz9do19YJ1Ajbcso4WxvT/mIdpJU9Lfh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZF2iYHVfPulLb+msGTfzgcmzExHLbpfrHP1cvQiQhBK5x7acW
	5uWf9yMquJXYfjzaA3rKR9vsdCuaJ943KmS7WpSnRIhWU3flCyAzYh0KAjpML+WYGk0=
X-Gm-Gg: AYBFou3dHyZc0PW3jUdxoBQ1I5wIV+Z5B6KF0V+WtKSV+emkzwIFDf3XqFPLCq9Q9gi
	yPjXbEZg+jTGLWPuIztXpZlbBsU8zkq3Ig4tflmR2ChusIn5XVJdji+Y7K1DJakQywp6/TtNoue
	BxGvSjfZMwJmPNg59xxSnjh63M9q4uy4YsYa6VSH1ynhmlmRgHQpIxD+SZTs4Ds4mdZDkKlEIm8
	8E5ShxKWB7zK3tfo89rdq4iQBzBsXWKrcqWgam9GHXQ9K4P1vZmaJua4M3RRMDFFUoNjDy8/T2p
	/XIWw21bG6wpvogwLmFtxQwT/ykY1kz/3/4c1tHXObtoAVXLc2Mv9XpInRNgh00P5HOD3aOgRyy
	J0/zGhZxXPBjYiFC3fs70Yt2xwLwOsjE23u5eaVpqZjZN8NH2uClwtIxK35+pDth/P31uWm8kSz
	y3WyjWsd0/ldv1mdOsXIr7Ol+eqk7hp1Ckp4dfosnqDEb+OjblflzL3GK99ubIhI3/PCQcvStVr
	gwXQnJ985Ci5NbZMhoT6SY8MPIKptKTN50zH/qXAuQspMiJX286peYI4HyHWxRn6qaol2+i9oQl
	AuY3S4f7IAWYz2ivlD/kEhH5zzSvhB56yeQe0w==
X-Received: by 2002:a05:620a:4728:b0:93f:2eaf:64cc with SMTP id af79cd13be357-940ef942794mr1259449285a.44.1793054775098;
        Mon, 26 Oct 2026 15:46:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f05b20e0sm810207185a.3.2026.10.26.15.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:46:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTSF-000000087nJ-1Z9f;
	Mon, 26 Oct 2026 19:46:11 -0300
Date: Mon, 26 Oct 2026 19:46:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
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
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026224611.GB1685504@ziepe.ca>
References: <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <20261026184312.GA1685504@ziepe.ca>
 <2026102604-tint-catcall-433e@gregkh>
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
In-Reply-To: <2026102604-tint-catcall-433e@gregkh>

On Mon, Oct 26, 2026 at 09:05:06PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 03:43:12PM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> > 
> > > This is needed for two reasons: to save hardware and software resources
> > > when creating a large number of VFs, and to allow the PCI config space to
> > > be configured *before* the driver starts using it.
> > > 
> > > There is no in-kernel alternative.
> > 
> > Having userspace involved in driver binding has also always been the
> > plan for confidential computing needs. We cannot have a device driver
> > bound across some of the HW transitions like TDISP shared/private, so
> > there has always been an expectation of bind/unbind.
> 
> What, why?  What forces that decision?  What's wrong with the proper
> driver for the hardware being bound automatically to the device?

It would be a proper driver, with a real match. I would expect this to
be done with sysfs driver_probe, which is like bind, except it doesn't
override the matches, AFAIK.

There are two sort of related isues. Userspace is in charge of
sequencing the new PCI features like link encryption and TDISP. They
have complex authentication policies tied to them so the kernel can't
reasonably do it. These features change how the CPU does address
translation, effectively it adds/removes the iommu - and that can't be
changed while the DMA API is active or it breaks every translation in
effect.

So.. We need a gap a system boot when the driver is not bound so the
PCI stuff can be done prior to driver_probe, and a gap if there is a
PCIe error of some kind to do error recovery and go back to the start
to reauthenticate and reload.

> > For this case the existing sysf drivers_probe is good enough for bind,
> > but we must have taint-free unbind for PCI devices too.
>
> Why?

See above. That should be the easiest thing to ask for! PCI is hot
plug, disabling unbind makes zero sense from any way you look at it.

> > I think this patch should be reverted ASAP, it is a pretty major
> > regression for a lot of users.
> 
> But this use case hasn't even happened yet, so what would regress?

I'm reflecting the other commentators, I care about VFIO too. I think
tainting every hypervisor is unacceptable.

But for CC I find myself one of the maintainers for that now and many
people have been diligently working on this bind/unbind direction for
a long time now. If it goes away I have no idea what could replace it.

Jason
