Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055307;
	b=AxdGoBo86pmUUmi195uNPd2RSSE49eYJph130H4qOXVTtWsgCpMJ1YYVND8LtF9iGX6N
	 73knkW/xyvJzCKWq/bj01rOlSRKRJC6m0Q6cl06UQinsXDqPQ0EVdKNgzDDyTd98IqOHE
	 uFBegNNEPnEefFkf89XSfelyBCH7ddmXFflBY/ZyZj9JnrzkaEpYCXgR8of6sSpuX8QnI
	 Pct12EjRZ08W9vNHPdvzJcBONmESp+98KTfkTG3aDdJfSsIg5BKF/cS3c5bfEsYBp9fL0
	 LlAbsZC1GZ2LKmEzMVUkH/Z62KSJ7PkT38A6QFXA3O9scajL/5bFsHL0wKnWiaY2Q1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Qv4yXz9mBS7TK9aKYpPIFfG0d3O9zFyQxnBKda+GG2U=;
	b=typVDuuawHTDgS/DZ3BPI1ijYsj7x9HYKVzanIEHbJgTCnnnILNvSw0gFljJrNaGfDGy
	 yV1mWyamMpaRid8zoAN4sABGSEsfaTdeQkzzn10wqFbp3U5ukvNgfG1Vw7JqGv8LEPz5M
	 NGL5KAb+P8pAEHSgQbVNvG70KR2JPGVvtrGlYk9jicmwzLa0Mo0CwjwkLcVbyot8hsJMW
	 LoAQmSA6gA1R0eoAqVPu+LF8K0vGnIuy1V/0ftujwsrvqQ8kT34hRwg4loIOYyu/112SA
	 Avi+3zDVbbSg75NvxfyEz20S2ABNq44YgzznU2OZSnVHqr4yG4cOcfvYsO7AxhndMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iE1vhkuf;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB45606A31E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB45606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iE1vhkuf
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53bb57f1310so16978861cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793055306; x=1793660106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qv4yXz9mBS7TK9aKYpPIFfG0d3O9zFyQxnBKda+GG2U=;
        b=iE1vhkufDNk47J0y0sfQfrcXvv7YwF5xZFg9Zgo3GIzWAPWbTFVaeyw2U0dtOlPag2
         5dWMf7SyNSgNhsm9D6diSHIdA69bKNuWJ33g6Ws86B/FXC72+OUoK0GlOXNcOXMMUb7j
         vEQdmCqpATKVE6+OWcRHTpwNRrYJBNMNiiH9SbBKxx83oBE7NDzOB6NP/kzPMrB7tS1u
         BJ8R/xA3Vtfw1W0CvF40clDWUJO6jz0fi1k5djJewrxA40gh6oNqWlI/rreVaHKQhFSf
         2D4NvJf4yKKhk9yrS9MArPN93WnWZW895J1xZMvYhJ7gHZqrZyRRpjbacUJzAeaZicS/
         ct0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055306; x=1793660106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qv4yXz9mBS7TK9aKYpPIFfG0d3O9zFyQxnBKda+GG2U=;
        b=nPOmVfirNItZ0PMbIDmRlArcjsmutyFWvEfzemDgSUEPrn2JFEUGwLAgyYVcQ1iKXu
         M5YalHKVx1NzUEsFtLC5VajY6KBGZ0XMyGJxdhASWiGIs/CCLOiPgigUakWkcefgkDWo
         RaA8Dg2VES9ufQnOvUJ+ONxbWqUKQSBlKR36QKZX5JXZHw0ddHzQwbdteHdweBr3grqu
         lmM2amlfysr7YfyyqpLSUPh1coWtRdAD/C6N7AizrnXca0yv+e440BjdDJxL70BHDSao
         blkCjRSQx6FmUXhRFItN0w6gclqGU1qdP/KTu/RE9KGUomwI2fo46yqXu0l/KrVRwKHh
         n2Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwSq8jr0OXvbi2XarFaM6L0+6zwvRJa2yaQ2BaRQWIXrt/WAhMFvBtQLbVuY9Rfuqm/HKpj+7sKVLhyK2F6SK4AgJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUcO44V9TUXq6JImqbUE9DocPN8FN1Cla5nkX17RRqA68ASBDc
	iprGevBqVx3o/FHticiEQB2NpRIwShZPn442Z54NflnLJWDyqAfbY6XCRt8T1hdVEBM=
X-Gm-Gg: AYBFou3FzESwYcwn6OqANuSBnqVYZUXSzqQHhOIFgVOH9uW2k25qI8ZpoNQ9jcGNi3p
	oOaqbk3ax6qM4uUHFDg7PIE/cwAn9ndIntIBPziBAJ0Qk/jLAbxKBmvSl3x49X9JUUJ5OZcd5Eg
	E7glFX8GZjFDlcxyD7OOvew4HJXIJsYA8gLh+Mhd8hj+e1kcG9dsfkI2xJs4LpvDo970BBTP9Fk
	R3KuZVLrclPOtbPQfd7rYUuM1Fx1bWy9fe5DVNYkCMvCNJZKppiiuDb2OQlIu34nSHDO/Bweh4J
	wF1hWQNkdNQVMrUbG3wr0+KRM88Ob03MCko8kTixKJr8DXpQam4iST4FWNd1M5ksinPeo9Nw9ED
	4823T8lbH8CcJ9aux3OOnXDiKMpS6ZC3GPgl9Pa7+UDgQveF5jqmgXZy4Scy/woDIqKqU8i5fgL
	abzQtMKCMIFJCMFW7YGIuQ3caY6wFZjLFIWliXsKxRZ7nltloksGDUOTb2S7b1O2nZT0SpjilW9
	YhQ7N7WJJouCvRWUoXk5YgewDoEa4SVcR5XFX5m7ujyToiWPBEYUj4xB3IS2lAiQESAPXjrctlN
	w4RF/3UciQnc6YZPeJXbwyH8D6f/1tq8dqzXxA==
X-Received: by 2002:a05:622a:4b18:b0:535:80b:9911 with SMTP id d75a77b69052e-5383b4b0e1dmr122069761cf.24.1793055306222;
        Mon, 26 Oct 2026 15:55:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c565esm66284051cf.6.2026.10.26.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 15:55:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLTaq-000000088rN-3CrV;
	Mon, 26 Oct 2026 19:55:04 -0300
Date: Mon, 26 Oct 2026 19:55:04 -0300
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
Message-ID: <20261026225504.GC1685504@ziepe.ca>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <2026102654-enlighten-perkiness-193c@gregkh>
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
In-Reply-To: <2026102654-enlighten-perkiness-193c@gregkh>

On Mon, Oct 26, 2026 at 09:27:25PM +0100, Greg Kroah-Hartman wrote:
> > > Sorry, late to the party, but this isn't a few user scripts that rely
> > > on this behavior.  Effectively every use case of vfio relies on this
> > > behavior.  We rely on unbinding the default driver from the device
> > > before using driver_override and drivers_probe.  That means every
> > > hypervisor with device assignment and every userspace driver use case
> > > now experiences a tainted kernel. That seems like a significant
> > > regression.
> > 
> > Sorry, I was on vacation and missed this change earlier. This change will
> > affect SR-IOV deployments around the world, which *rely* on being able to
> > bind a driver manually *after* virtual functions are created but before
> > they are used.
> 
> Why can't a real driver bind to those virtual functions?  Like is
> happening in the rust apis?

Most people using SRIOV will bind the VFs to the VFIO driver.

The rest, it is the same as the CC case, there needs to be a gap after
creating the PCI VF functions and before binding a real driver, with a
proper match and a correct id.

This is usually managed by clearing drivers_autoprobe

Ie look at commit b8c5cec23d5c ("Driver core: udev triggered
device-<>driver binding") from 2007 explaining this workflow.

The taint on sysfs unbind makes zero sense here because we can trigger
unbind of those VFs just by disabling SRIOV through sysfs. Should we
taint that too?

> > This is needed for two reasons: to save hardware and software resources
> > when creating a large number of VFs, and to allow the PCI config space to
> > be configured *before* the driver starts using it.
> 
> How is hardware and software resources an issue here at all? 

If you create a 1024 VFs, which is what people on big servers seem to
do, then that can use 1024 x megabytes of resources to load all those
drivers which will memory exhaust a hypervisor.

This is a real case actual users run into, I saw the support requests
go by :|

> And you can write to PCI config space from userspace today, 

Not allowed in lockdown, triggered by secure boot, which pretty much
every server uses.

> > There is no in-kernel alternative.
> 
> Then just don't have a in-kernel driver for the device and all is good?

What? How do you use the HW then? Is this a serious reply?

Jason
