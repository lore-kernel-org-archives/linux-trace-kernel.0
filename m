Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5F1643B;
	Fri, 26 Dec 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766766068; cv=none; b=oqB7bQPFFbDqk+dKgNAYHvyJQbk44z51qeJxchPbyYWSXn9xZcBzT/kIuvPE4ZkSIjGzOBbZ9RjrRajMgbyzdYrzXkO1VLn1HoYmz/faEob1fi/FJJI7wF6/UTJ3MAUAli1dNlb2sPKFbkvZp4ORYVfjZWUvy05cRCz4Bpf781g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766766068; c=relaxed/simple;
	bh=ojrA7RhQq9vA2j9DdcxvWP6UnQOQoYXjrN9y5yJuleE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Asx52AcpJdnROkrcnpgpMKEEVAvWS6FTqfuUYTrN6PvqzdaWFKEzvHa8kRjV6QJ4bBj/Fg436F2t4oXTRdDTypEVRgq13lVIvLrxO2OLJRXXj/KwXGw16IoIJScZ6steg7YGb2WJowRdrd9mx0fyNi7hZzhXMkIOXy2DYq2X+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 27A315FBD7;
	Fri, 26 Dec 2025 16:20:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 04A576000C;
	Fri, 26 Dec 2025 16:20:55 +0000 (UTC)
Date: Fri, 26 Dec 2025 11:20:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <20251226112054.44b2e440@gandalf.local.home>
In-Reply-To: <qw6wgsrmuu4vhuam3ay3zdsqxlowbe7xqrh3wolei7bnbkkwyw@jshbmlr67goc>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
	<20251223133452.416fd539@gandalf.local.home>
	<wgkjg2bpsyonl5qkgxgdrpmzzaduuyiti7vtifxbtdnmlrhptl@jchrtoaltfv3>
	<20251224085848.26387f5d@gandalf.local.home>
	<qw6wgsrmuu4vhuam3ay3zdsqxlowbe7xqrh3wolei7bnbkkwyw@jshbmlr67goc>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 04A576000C
X-Stat-Signature: p5ry1jcitpzoi16nhdxxsdwboy3qnzh8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CuRtiDyHgPV9BznWhBHXCQbD/Fhk1q0A=
X-HE-Tag: 1766766055-174451
X-HE-Meta: U2FsdGVkX18tlOylEYGorLobJyW1V6dZrLQx0TDSbmUG1uTjCh3iG9ier0QMOrveblmmgqYXPg5ysm+OtKli4vDvg131WBfQx1LDRsgVXeN1uHvHSKFLrSynfWdknCcZg4vAEySX7Q9UxJ+Tucq2s1Owa1IZpT9x0qjpXg1BQiZ258i3I0LKHZFAzSjl20p5lJqycfta2USwiTCxkdAzppa0s7OIjPoKt2WICGmATS0YO6G94hZIdOuDjF9KkeBsrWYWftSSagV8+tqvn2r6+JADIKYBlRBwA0pjt5HSIj/cQP5Wzeia1Gw9eUavtbxo8bY5F8BM3ShzT+eUvooyVfi4/KKS7TinLn+Y27oYTcUht/bf/mXXcy7spev0+0Zo

On Thu, 25 Dec 2025 02:38:03 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> On Wed, Dec 24, 2025 at 08:58:48AM -0500, Steven Rostedt wrote:
> > Should we just make all cpu bitmask range lists instead?  
> 
> Hi Steve,
> 
> I am somewhat hesitant to adopt that suggestion as I would prefer to avoid
> breaking any existing tooling that relies upon the default hexadecimal
> bitmask format.

I am too. But the "do not break user space" rule is basically, "it's only
broken if user space notices". If people complain about the change, we can
always revert it ;-)

> 
> Whilst range lists are undoubtedly superior for human interpretation, the
> hexadecimal output is a well-established standard throughout the kernel.
> For instance, the hexadecimal format is still strictly adhered to for
> "Cpus_allowed:" within /proc/[pid]/status. Introducing a global change to
> ftrace defaults could disrupt parsers and scripts that expect this
> consistency across the system.

Really, any scripts that parse the ASCII output is broken by design, as
things change there all the time, and it can be really slow to read.
There's a binary interface for such things. Heck, I bet this change would
probably make the scripts simpler, as searching ranges is easier to parse
than a hex number.

> 
> By leveraging the existing bitmask-list trace option via
> trace_print_bitmask_seq(), we offer users the requisite flexibility for
> high-core-count systems whilst preserving backward compatibility for the
> wider ecosystem.

Perhaps it should only be cpumask-list, and only touch bitmasks that are
CPU lists. Although, right now I only see one user of the bitmask code, and
it's using it on a cpumask. Perhaps we should change it to use the cpumask.

There's not many users of the bitmask in tracepoints, and it is mostly with
the new IPI tracepoints (Cc'ing Valentin to get his throughts).

> 
> I shall send a new version of the patch shortly. This version incorporates
> the use of iter->tmp_seq to ensure the implementation is robust,
> instance-aware, and free from buffer contention or duplication issues.

Thanks,

-- Steve

