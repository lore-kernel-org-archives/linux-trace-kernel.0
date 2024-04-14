Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01028E8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068403; cv=none; b=Mozu7Vyh4oxS7ECsghAGpq8oS6V4TjN/Wx8JN4tJ12BKiwRdnDvsu5gyFCUYi2J16zz0lyV5s2trp6Yx3lAGOz74v0jRkb5PfnLCRo+X1NKszu1B2FMSlfuK9vRTW8YprjRvOHM9OT6AwK4iZ3cUi3T6hzx1NeI3K01znKqGMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068403; c=relaxed/simple;
	bh=SB6ARZOhTMvrXawsmySuOnOm8Vrvme3M5GU3snPF6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLsMfkdjLye7ZmiMYih/aTH2WuJJECEfOijELB21dgTDJK+HARTXA7sZ3ejXHdtgpMhnJwVaKqkbme6CaSP5cpcKgMk1zYvkYsC9jZuG7l93ytPgCrEQ1ksw/BbbqUqVspzo8CIBKeVvJhlpgb4bu9nGK1RBoCUEpSRrgg0XT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYzihtcP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYzihtcP"
Date: Sat, 13 Apr 2024 21:19:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713068399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eh56ZyGbJGY/OXd/Aimq36lBQCcFbETossv2eMfjYH4=;
	b=EYzihtcPurjyOYM4mJrGzV3H6XjkCbnOgayvGXbdYwLOu6YGT/ZZSArVVcKAx7hu1DWjnO
	GfTkociOsmt/cruykfhG6lSXruJuco0v+DxB6kp5XMrVIPStTje1d199pE8N+eDzpAVvrM
	TYNKOc2VDSLNVWQEXY3C4B+f3XU01GA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	hannes <hannes@cmpxchg.org>, mhocko <mhocko@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJh?= =?utf-8?Q?l?= protection fault
 in refill_obj_stock
Message-ID: <y5pnw2czcfkgb427vjyv5jwjvafvl4zo7elja2rjtdsppuxsy4@oshxnaik44kp>
References: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
 <ZgtIuBlUVE1Lj_Tc@P9FQF9L96D>
 <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 09:50:54AM +0800, Ubisectech Sirius wrote:
> > On Mon, Apr 01, 2024 at 03:04:46PM +0800, Ubisectech Sirius wrote:
> > Hello.
> > We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> 
> > Thank you for the report!
> 
> > I tried to compile and run your test program for about half an hour
> > on a virtual machine running 6.7 with enabled KASAN, but wasn't able
> > to reproduce the problem.
> 
> > Can you, please, share a bit more information? How long does it take
> > to reproduce? Do you mind sharing your kernel config? Is there anything special
> > about your setup? What are exact steps to reproduce the problem?
> > Is this problem reproducible on 6.6?
> 
> Hi. 
>    The .config of linux kernel 6.7 has send to you as attachment. And The problem is reproducible on 6.6.

Can you please share the reproducer of this issue?

> 
> > It's interesting that the problem looks like use-after-free for the objcg pointer
> > but happens in the context of udev-systemd, which I believe should be fairly stable
> > and it's cgroup is not going anywhere.
> 
> > Thanks!
> 


