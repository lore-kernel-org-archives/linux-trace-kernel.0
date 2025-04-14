Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8115575C;
	Mon, 14 Apr 2025 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664167; cv=none; b=CXOmee98R8xBjBMYftJvExX92setmxLv63k2ogUaXtWH4dGJlxzE8Ob1K0qgLy9RYwL5NYE/wPzkhBjgWv5fF0XGE/up0X0cyhrEmkZhCKQdejmnQAJp+0DCx7KI3BdC6blQscWIwRhL2Iu2zSn2oBUXqKKeEWaTn/DvB9IKqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664167; c=relaxed/simple;
	bh=nNlenzc4R+LanzONpkiJeLCQmeC9r4SGdYX7aFxePys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKnv03mOhMj94wkNK8KKQMB5uK2JDPhcs5BpsEEiBofdxo1BDXBdMVV0omwwxK+JMt2D4H1cCGGGCTskkzckxiFqbRcG2UIuArgwmtYicuEopYe/1Pu5d/Ozup0ZY/AEwbhRykZrS1ZsG6uFP8RHqauf1a9XWghOHFh4Hr4h8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03FC4CEE2;
	Mon, 14 Apr 2025 20:56:03 +0000 (UTC)
Date: Mon, 14 Apr 2025 16:57:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250414165736.77415836@gandalf.local.home>
In-Reply-To: <214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
	<214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 13:42:23 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/14/25 13:35, Junxuan Liao wrote:
> > Rename page_fault_{user,kernel} to page_fault_{user,kernel}_enter, and
> > add the exit counterparts. This might be useful for measuring page fault
> > handling latencies.  
> 
> Is there a reason kprobes don't work for this?

Kprobes is not always easy to add, and it does add more overhead.

I use to have measurements by using function graph tracing of all timings
into the kernel, but when the noinstr was added, that broke. I still do
timings but that's by manually adding hacks into the kernel. I haven't done
timings on a vanilla kernel for some time. It would be nice to be able to
do that again.

-- Steve
