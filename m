Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23C1E3DED;
	Wed, 18 Mar 2026 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792167; cv=none; b=e9pzBx+bqfFNoBqqe1CDcoYtwHIWcS4yDxxvMdzcfrj2/5/mpZ29ooNiouUZzn6HeSIKus1mkI5BQRseFsnDOGQcqq5IqT2QBiHcpxR/A/0hUB0+TxWnYALRxsPRJNmJ4pnb7viEzD8YL28rVpwhVTFKRO3uySJZPmC6UWdA0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792167; c=relaxed/simple;
	bh=or4+/ROvIUPRlGXGcAw3OQPc/C0vtyA4B1QhKaj7k8A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VDpBB9NaJEX4qXdMHnMwurq0wKRYuG5v8h8A3GEAfhJ59eVc8fSTyJh+QWsjmuu594WknX5gvXZTy227yV2nml6I8Lt8LCf6oz6CVY9yootQ6SDSNFubnwZtNUmCdcoYo25ktqU2OVApXGB/gg+JBur5b9RAeGC4hXoy/xE2EeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rayOT5dI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rayOT5dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08946C4CEF7;
	Wed, 18 Mar 2026 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792167;
	bh=or4+/ROvIUPRlGXGcAw3OQPc/C0vtyA4B1QhKaj7k8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rayOT5dImgqq+0F3lyB4JvuUkKFZCYZZrW88UdL1jmwUmGw0Opz9/J/W/qt3ZDclc
	 6Q5Q28MUZJO7HUP3PXJuo0hmGWyPPMTUWz7n5Ug/MW+UFbCyyj0nabZVv8F2FnGvS4
	 XXCFmfEJry1/cyS/BPYEQebE/5e7RKKfzde5KsVpuG76qN/dydBXvwlk8hiZQewCT8
	 GWGUigs7h14jVjIO4aSqNazwRTTIF0EjBW64EC0EJlEyxhN3rJJv98Q1HGLQW0Anix
	 HCXzOgtISFVDSQUoH5M1GJ1Boxyv+X6uvDrsq+OnXgz2WlOLo4D4KpHycLlPGpG+iR
	 imGHRcr9e2KtQ==
Date: Wed, 18 Mar 2026 09:02:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-Id: <20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
In-Reply-To: <20260317191626.5b6172a9@robin>
References: <20260317204403.72375-1-objecting@objecting.org>
	<20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
	<20260317191626.5b6172a9@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 19:16:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Mar 2026 08:03:51 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 17 Mar 2026 20:44:03 +0000
> > Josh Law <objecting@objecting.org> wrote:
> > 
> > > xbc_node_compose_key_after() passes a size_t buffer length to
> > > snprintf(), but snprintf() returns int. Guard against size values above
> > > INT_MAX before the loop so the existing truncation check can continue to
> > > compare ret against (int)size safely.
> > > 
> > > Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
> > > so the same source continues to build there.  
> > 
> > NACK.
> > 
> > Don't do such over engineering effort.
> 
> Hi Masami,
> 
> This was somewhat my idea. Why do you think it's over engineering?
> 
> This is your code, so you have final say. I'm not going to push it. I'm
> just curious to your thoughts.

I sent a mail why I thought this is over engineering. I think this
comes from vsnprintf() interface design. If all user of that needs
to do this, that is not fair. It should be checked in vsnprintf()
and caller should just check the returned error.

> 
> It is interesting that snprintf() takes a size_t size, and the iterator
> inside is also size_t, but then it returns the value as an int.

Yes, that is checked in vsnprintf(), not its caller.
I think linux kernel should ensure the the return value is smaller
than INT_MAX, and return -EOVERFLOW if not.

Thank you,

> 
> That itself just looks wrong (and has nothing to do with your code).
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
