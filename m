Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C84779F;
	Wed,  5 Jun 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603619; cv=none; b=GzkMTYGdW+01TTIzGExlKnPZFe8GGjQObmb9dvNErR6cAtq5gL+UWbSHIPKj2fAiR7pn4HHmEdQRQoavEKSGbHZ0Rjb9t0D65Rk7hq2I/IgFutURlp4scenCm97DtNqidJQP+7BrjwyJJZKji9LfkctbQBcEUbvoueGaiELhiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603619; c=relaxed/simple;
	bh=vtOGMKyFj/QGvV0AXX6doQAz9IlpRaSa50akhCpLhgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Of5R8PQ58j3Gfi//5VK64jb06jRmQRxrnM/4REMnFEPnsMwk9Myu7yG4jkFKdSMXH/Xgq3upjk8QSwirCK0yR5VFuMix8f9TvVfC/GVkAqdmC+t2bXehF6ttDEEDPxwmBPF/puGEqQb7zARy8x3h/K3ubPpdFH5+sfEBA4xK2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C12C3277B;
	Wed,  5 Jun 2024 16:06:57 +0000 (UTC)
Date: Wed, 5 Jun 2024 12:06:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] ftrace: Comment __ftrace_hash_rec_update() and make
 filter_hash bool
Message-ID: <20240605120657.1c8938ee@gandalf.local.home>
In-Reply-To: <20240605101832.09fb4211@gandalf.local.home>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.725383717@goodmis.org>
	<ZmA6ygUWNPkq0PKV@J2N7QTR9R3>
	<20240605101832.09fb4211@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 10:18:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > + *
> > > + * @filter_hash: True if for the filter hash is udpated, false for the
> > > + *               notrace hash    
> > 
> > Typo: s/udpated/updated/
> > 
> > ... though I couldn't parse this regardless; maybe:
> > 
> > 	@filter_hash: true to update the filter hash, false to update
> > 		      the notrace hash  
> 
> Sure.

Actually, they are both wrong. Because I realized your's was not correct, I
started describing it in more detail and realized it does basically the
same thing (but differently) if filter_hash is set or not. I think it can
be removed completely!

I just tried it. I forced "filter_hash" to always be true, and all the
tests worked just fine. This function is only to update the dyn_ftrace
records when an ops is added or removed. It doesn't matter which filter is
being used, as they are both necessary for the update.

This will make that code a bit cleaner and simpler. Let me go and fix that
first, and then add the documentation on top!

This is what happens when you document your code :-p

This code has been rewritten a few times. When it was first written, which
filter was being changed may have been important. But now it is not.

-- Steve
