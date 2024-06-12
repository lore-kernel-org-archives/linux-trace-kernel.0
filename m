Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD617FAA4;
	Wed, 12 Jun 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208301; cv=none; b=uQJFnR6iK67YS/kSHW0kEXXxc5JAd3DAtSL+CznFRlW64oUZtfqdTWF4BTrvTXRHYJmMapa44ZLr8h+Dh6I2tKzg6lvcNTcpeJO0WAm3pGfypumouxxS611uLNWdWm2tmrs7Xy5jHqJRA04ifWXj4/PEALwd1dMlch3mlx77TBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208301; c=relaxed/simple;
	bh=RWJAxgMTq0703GeW99QCv1Ot2/tX/YqzAh2KeOG06tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C847Tz/x1t737Rb81A/ZdS60SLpZA6XrwIv1SkdRwv0qB1A+geym9m9BsOYwh6nAbFTiB+qJQVdnfJF/AjFa/GUBuTCF4jGFRf/PSqiFir0SeeTTrjXFdkZzgdEMGeXXLM0jp1IzATH+T0O+PGCbjFE3DN0Nn6/IFrHcLiAg8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E39BC32786;
	Wed, 12 Jun 2024 16:04:59 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:04:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Greg KH <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>, Thorsten Leemhuis
 <linux@leemhuis.info>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240612120457.5329934c@rorschach.local.home>
In-Reply-To: <ZmmsJFDmnbjngRNV@zx2c4.com>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
	<20240610112223.151faf65@rorschach.local.home>
	<b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
	<20240610163606.069d552a@gandalf.local.home>
	<70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
	<2024061143-transfer-jalapeno-afa0@gregkh>
	<05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
	<20240611101458.7fa78da8@gandalf.local.home>
	<ZmmsJFDmnbjngRNV@zx2c4.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:09:40 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > 
> > I think "Depends-on" is the way to go, as it is *not* a stable thing, and
> > what is in stable rules is only about stable patches.  
> 
> How does "Depends-on" not spiral out of control? There's a *lot* of
> "Depends-on" relations one could express in commit series and such. Of
> course a lot of git itself is designed to show some subset of these
> relationships.

If a change occurs because a recent change happened that allows the
current change to work, then I think a Depends-on is appropriate.

Like in this example. I thought this change was broken, and it would
have been except for a recent change. Having the dependency listed is
useful, especially if the dependency is subtle (doesn't break the build
and may not show the bug immediately).

> 
> It seems like in most cases, the "Cc: stable@v.g.o # x.y.z+" notation
> expresses the backporting safety correctly. What is the purpose of
> saying, "if you need this patch for any reason, you also need patch X"?
> Who is the intended audience, and are you sure they need this?

The intended audience is someone backporting features and not fixes.

> 
> I ask these questions because I wind up doing a lot of work backporting
> patches to stable and marking things properly for that or submitting
> manually backported stable patches and so forth, and in general, patch
> applicability for stable things is something I wind up devoting a lot of
> time to. If I have to *additionally* start caring about the theoretical
> possibility that somebody in the future, outside of the stable flow,
> might not understand the context of a given patch and blindly apply it
> to some random tree here or there, that sounds like a lot of extra brain
> cycles to consider.
> 
> So, is this actually necessary, and how does it not spiral out of
> control?

How would you see it going out of control? And "Depends-on" would only
be used for non stable relationships. If stable backports, we can keep
with the current method.

-- Steve
