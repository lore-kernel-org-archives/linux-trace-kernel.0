Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8F2A1BF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015553; cv=none; b=m683Odz5+18QEJY2cnV+XgPYDNjCZqaAWjrhUtvl79Vw0l4aZe/ApQtjVkhsqcJYhxGvq53kd0ErjWD8qShhywrI9++WJiLqf4uf00aFuwrSsl2AgV3VpdxWM0IoppkuFXpDNCpg4X5rpun/L1KoNxxez3IYnwAiIAnjND2L5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015553; c=relaxed/simple;
	bh=I1QBPl5Ey4ifEIkMCxl3N8eliVz2YzHxUOV12z15xsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDD2CvyNl3ym9gD+6dlw0iVH6Yn5WAyEVwJpyGC0mdhpc2RbTinFlljzoBHxm9AjvWf3fLYVdCAUuDkI6IxOdMmHzk7eu+2SfDYXmhqHIYA5RnokdiMz2ekjIvM5x/1+P8yVOyN1U0ZGG8IC6m8N2qklf1ydtdYPAv+NOYQUqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aaWCmJZb; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaWCmJZb"
Date: Mon, 1 Apr 2024 16:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712015548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1QBPl5Ey4ifEIkMCxl3N8eliVz2YzHxUOV12z15xsk=;
	b=aaWCmJZbN6WUia8WK2ZqGCYGcNR5t9Erobt0UtI7/peiidTZrpG2Qjqzx9d5jj/b68+T3L
	SeC/Yfw5Lz3vQJICvtLPw2lPUGwruRUcbWCwu2AJzZEeuiX36xZQlQ4Ktz6BGXj6Ht2q2n
	Gmot9nNsLQaABuOt8Du1c2yz9TvCtn0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	hannes <hannes@cmpxchg.org>, mhocko <mhocko@kernel.org>,
	"shakeel.butt" <shakeel.butt@linux.dev>
Subject: Re: general protection fault in refill_obj_stock
Message-ID: <ZgtIuBlUVE1Lj_Tc@P9FQF9L96D>
References: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 01, 2024 at 03:04:46PM +0800, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.

Thank you for the report!

I tried to compile and run your test program for about half an hour
on a virtual machine running 6.7 with enabled KASAN, but wasn't able
to reproduce the problem.

Can you, please, share a bit more information? How long does it take
to reproduce? Do you mind sharing your kernel config? Is there anything special
about your setup? What are exact steps to reproduce the problem?
Is this problem reproducible on 6.6?

It's interesting that the problem looks like use-after-free for the objcg pointer
but happens in the context of udev-systemd, which I believe should be fairly stable
and it's cgroup is not going anywhere.

Thanks!
