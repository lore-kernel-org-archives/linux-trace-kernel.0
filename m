Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C5149C57;
	Thu, 13 Jun 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298736; cv=none; b=j/A8YIRSxTqHbnmlDUMItpap3Qp843FluXf4yyqZRJ/mfYXDxsTQ1aX25U+IffeCoxQ56+Q8rmkqyW5AfDO2vDpP79DEMBWesLfKTn+8EoXamR21oXOI/r6AHB0xuXR8L0+9niQggIN7+KdSc4pZVnAF8ga82OLZNNkxytHXWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298736; c=relaxed/simple;
	bh=KGtnCWDjLtvwaHEWBWIoE/+mE2S0vSVzAVfnzRK/d/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9GMxy7Zf/gbeNNcHnifvFQgoS0WsD4t8zSfjd/OL4EvbkbWmnaGAapmx/Kqa09I/xYBgcQdqwgUDl7zJnFLXf/sNeGGXbrW9pv4Ci01bX5yGHFTwLb8xvDMTSHgiZV6TQz2kYvpciqAhqJ7J7qyTocRVGNCibD87EEyl36gDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E4EC3277B;
	Thu, 13 Jun 2024 17:12:13 +0000 (UTC)
Date: Thu, 13 Jun 2024 13:12:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, <suleiman@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Baoquan He" <bhe@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David Howells
 <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240613131212.7d1a7ffa@rorschach.local.home>
In-Reply-To: <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
References: <20240613155506.811013916@goodmis.org>
	<b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 18:54:12 +0200
Alexander Graf <graf@amazon.com> wrote:

> 
> Do you have a "real" pstore on these systems that you could store 
> non-volatile variables in, such as persistent UEFI variables? If so, you 
> could create an actually persistent mapping for your trace pstore even 
> across kernel version updates as a general mechanism to create reserved 
> memblocks at fixed offsets.

After implementing all this, I don't think I can use pstore for my
purpose. pstore is a generic interface for persistent storage, and
requires an interface to access it. From what I understand, it's not
the place to just ask for an area of RAM.

For this, I have a single patch that allows the tracing instance to use
an area reserved by reserve_mem.

  reserve_mem=12M:4096:trace trace_instance=boot_mapped@trace

I've already tested this on qemu and a couple of chromebooks. It works
well.

> 
> 
> > Requirement:
> >
> > Need a way to reserve memory that will be at a consistent location for
> > every boot, if the kernel and system are the same. Does not need to work
> > if rebooting to a different kernel, or if the system can change the
> > memory layout between boots.
> >
> > The reserved memory can not be an hard coded address, as the same kernel /
> > command line needs to run on several different machines. The picked memory
> > reservation just needs to be the same for a given machine, but may be  
> 
> 
> With KASLR is enabled, doesn't this approach break too often to be 
> reliable enough for the data you want to extract?
> 
> Picking up the idea above, with a persistent variable we could even make 
> KASLR avoid that reserved pstore region in its search for a viable KASLR 
> offset.

I think I was hit by it once in all my testing. For our use case, the
few times it fails to map is not going to affect what we need this for
at all.

-- Steve
