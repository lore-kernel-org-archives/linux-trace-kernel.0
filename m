Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83B23ED52
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Feb 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938436; cv=none; b=Xhdy4HU/xRzRN5NJl9Fc9qvcPoiGOA1Jkgueqgk6r/pdoikxF42+enw/CeKyS9NtWf6s3NmEfpRRbwTZ1cn2jwV2SPDz4hMCeGr51vXtg/3l7L91MTtgMErt8Yw+RfiJ9K74q+HSg7PrBVLb4/kM3k7KE110Uc2fHrLzYOJLcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938436; c=relaxed/simple;
	bh=o6BN+jhB83FXgQx0sjPW6xCk7t4A/VHNdAvjUSUvNlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q4SNCi+1mf8498iiCedfsi0NLbv4yYbi+gpyM8NKYvVpYqu2ajTsnY2NHEaEp0Da2nObGrfUiH/VnYpJPlIpHxEV7hgrvL2pqkWKG/8RU7U45CcgRrp8xGbZA/fyKTrv0hMKSBbzzkYUgB83U4pxR9lpxd4D4b1Ia+kHTpZKyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1exgTPc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1exgTPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SH1o+QthuKm+KhFtIEw5lEPiGz/yk5zmirl7sfBR7Ls=;
	b=Z1exgTPczPdROr0y3lsLnp0slHq99geAz9AHsSE4WdfFEFfJBrsevdNYf15f9oOOT1Iq6y
	dq/+73A38f24z8EjUS+bIlJDnQXiM0smHx2jp0aza2mbIiIVhPAsiv3lmPRwIs3BEt1vhB
	yEqwIGoBEEkTQyoQgXZRrkIlltbARwo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-mnXezUCGP9ahVmqogIi1rQ-1; Fri, 07 Feb 2025 09:27:12 -0500
X-MC-Unique: mnXezUCGP9ahVmqogIi1rQ-1
X-Mimecast-MFC-AGG-ID: mnXezUCGP9ahVmqogIi1rQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so16545825e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Feb 2025 06:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938431; x=1739543231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH1o+QthuKm+KhFtIEw5lEPiGz/yk5zmirl7sfBR7Ls=;
        b=Kjg4jKL2dIOjhyAecieIQkgtc9OEC9S4iJ7n1C1uHZQ59Lkyj44tYLq8Oblakkcs59
         QcIFwB9b3g8cejNsjQ6gCflSr/sLcjs63KnYbP+ndgsbIGJ+Cuay25qn6b9ELe8AHsBw
         RRrvuVlPoC+DZaMygzSrNqRi93V/hjPSeDJy/rKYqam/Fs2w7K4v/+n2uJ9hwqvquQK7
         TG6/87gHQT6JJU8BZJ9LtXCw+MegmOaChBZ5X46aC/z3yjWKgZ9X/0KbM4tT0iFGu/hj
         //zFN+ybv47GRxI1pKYopuqqy3RWR/mcQt31gd3dqoDDrNkNUbczP78a1GpJWTGVTiXo
         YAmw==
X-Forwarded-Encrypted: i=1; AJvYcCXAk8U7Od6FXe/nXIt93NV9APKZk++qdz66allVW1Ec8AANSh20+0HZEXGrLt0Ka5Y0f1d0Y+FA2FckORFgQP9IcAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDU6KNVlO5WdToB36BoKHC2y6aVD6n+z+NtKk4V0cuv6Ic43J
	9qePTr3kgsqxFSxUIiWUl4w2qB8I+qm0cAQzbAMj6M6K/60fntR/bHX4w6ctQbvTeZeD9L2ZS/c
	3tq54H8Yx8HCB/ecm4cl6IYk6bNUWfwvzEB3htMgcHgLfwy/lJHCsbBO83m1l5DcpsPDJuw==
X-Gm-Gg: ASbGncsIqaC7kNMqm5oQUMaj2/rVeSPL8GaZBw4MBmT1xeK1eWcB2GA1emB8rVDZDYP
	f9O7BAz+BJ9miGwsuIJ5zpdT2d+LRvrJ1e4drC3ex8KxZt+Latczezr/uhEqL3qEuBSg5eGjVxE
	7AkGoXjQWDiaHw5oP89bows2g9RloZz41vnN44EU/lxNNuGPy68DLymRrXw18x8OihB5aLChGZU
	HfZBXg/mrvenSh9JyW0Sadp6nEQnX+gtKf/PgADOSDmNB7AWzZJCDWO7cu02WLRKIVaqlhvpkD8
	reUyv9hp/lI1I/vdGnkeeDzHw/ZH0EshP/x8
X-Received: by 2002:a05:6000:1865:b0:38d:c779:4d75 with SMTP id ffacd0b85a97d-38dc935bd55mr2516124f8f.45.1738938431340;
        Fri, 07 Feb 2025 06:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFamBmDU9sldtKn3KhsqrmHnnObiks3DUVer0lNyyYTJiTdK6lOwaF2zwuT8fULoQeZ1rmkaA==
X-Received: by 2002:a05:6000:1865:b0:38d:c779:4d75 with SMTP id ffacd0b85a97d-38dc935bd55mr2516105f8f.45.1738938430935;
        Fri, 07 Feb 2025 06:27:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.128.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da965a6sm56685805e9.6.2025.02.07.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:27:10 -0800 (PST)
Date: Fri, 7 Feb 2025 15:27:08 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH 00/11] rv: Add scheduler specification monitors
Message-ID: <Z6YYPAiM0itlIVAH@jlelli-thinkpadt14gen4.remote.csb>
References: <20250206080952.98478-1-gmonaco@redhat.com>
 <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
 <847c962745ef5bce757b9ae257ae279913ac711c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <847c962745ef5bce757b9ae257ae279913ac711c.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Qs8n_t9MGkZM0Bd4JiXpOqlnJi_CqV94dcJPFV387o_1738938431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/02/25 12:36, Gabriele Monaco wrote:
> 
> 
> On Fri, 2025-02-07 at 11:55 +0100, Juri Lelli wrote:
> > Hi Gabriele,
> > 
> > On 06/02/25 09:09, Gabriele Monaco wrote:
> > > This patchset starts including adapted scheduler specifications
> > > from
> > > Daniel's task model [1].
> > 
> > Thanks a lot for working on this. Apart from being cool stuff per-se,
> > it
> > means a lot personally to see Daniel's work continuing to be
> > developed.
> > 
> > > As the model is fairly complicated, it is split in several
> > > generators
> > > and specifications. The tool used to create the model can output a
> > > unified model, but that would be hardly readable (9k states).
> > > 
> > > RV allows monitors to run and react concurrently. Running the
> > > cumulative
> > > model is equivalent to running single components using the same
> > > reactors, with the advantage that it's easier to point out which
> > > specification failed in case of error.
> > > 
> > > We allow this by introducing nested monitors, in short, the sysfs
> > > monitor folder will contain a monitor named sched, which is nothing
> > > but
> > > an empty container for other monitors. Controlling the sched
> > > monitor
> > > (enable, disable, set reactors) controls all nested monitors.
> > > 
> > > The task model proposed by Daniel includes 12 generators and 33
> > > specifications. The generators are good for documentation but are
> > > usually implied in some specifications.
> > > Not all monitors work out of the box, mainly because of those
> > > reasons:
> > > * need to distinguish if preempt disable leads to schedule
> > > * need to distinguish if irq disable comes from an actual irq
> > > * assumptions not always true on SMP
> > > 
> > > The original task model was designed for PREEMPT_RT and this
> > > patchset is
> > > only tested on an upstream kernel with full preemption enabled.
> > 
> > I played with your additions a bit and I was able to enable/disable
> > monitors, switch reactors, etc., w/o noticing any issue.
> > 
> 
> Thanks for trying it out!
> 
> > I wonder if you also had ways to test that the monitors actually
> > react
> > properly in case of erroneous conditions (so that we can see a
> > reactor
> > actually react :).
> > 
> 
> Well, in my understanding, reactors should fire if there is a problem
> either in the kernel or in the model logic.

Right. I guess I wonder if we can find a way to inject kernel problems
somehow, so that model(s) can be further tested explicitly thus making
us confident that they will be able to identify real problems when they
occur.

