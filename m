Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373819F42D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843183; cv=none; b=HmqX2Nu8ftWVqURoSIu/znMHMl8XOsUD/LIYxHrag3G5QZVopzu0EjK3S36Ag5/EGNSPI3Yt4SHWCCtXscI78iHz/x3sUxjAO/W6AXxR9nGTMDBBMMnZOxehtrIncNZs3shaRdm1uEthVrqgULAdCgLaAcqr6Akl7byFju7/Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843183; c=relaxed/simple;
	bh=3tLaR0BuE2jKlIg/iBJo1y5mS6P8W1RXgdqh/DB4jkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGiijIF2q+9W+216O1Hxn/khTf+pOxEXLRdLek3iOHx7/f5+ZEw4zw8uhniLIIrU3kNaZErelf7m1U1ns0giBcIxPdYw/eCBxlN8/V1AWN5FNq/rqupmZcbNWaQ3oyf0RKOdnj9YsWCFofz9pwm71T2peBZAebLqK6Ak4s1qcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62985C4CEDD;
	Mon, 24 Mar 2025 19:06:22 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:07:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sahil Gupta <s.gupta@arista.com>, linux-trace-kernel@vger.kernel.org,
 Kevin Mitchell <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20250324150703.69665622@gandalf.local.home>
In-Reply-To: <2025032424-custard-volley-bbb6@gregkh>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
	<20250324133619.6c3babf7@gandalf.local.home>
	<CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
	<2025032424-custard-volley-bbb6@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:52:33 -0700
Greg KH <gregkh@linuxfoundation.org> wrote:

> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Hi Greg,

This isn't a patch submission. It's more of a question if something should
be backported because it happens to fix a long standing issue.

It appears that the ftrace mcount sorttable code was broken if you built a
64 bit kernel on a 32 bit machine. I'm guessing it was broken since 5.17?
A recent update to this code coincidentally fixes that issue. That update
landed in 6.14. The question is, is it fine to backport the changes that
fix this? It may not be totally trivial to do so, but I could likely just
backport the changes that address this issue.

-- Steve
