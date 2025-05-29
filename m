Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB922FE0D;
	Thu, 29 May 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549774; cv=none; b=DG+aE+Oep8O9Ha4Q6yK5e7Plb61Z0zWBvl0ZoFBe0syVlN2vUc/XVyj+ww98L4c5JH5/q92xrPDhiditVUUSOzJAdKIiphWn/1T74NrK0GgTbRoDPBegQ8JaYPBv6dewulwoRd438zoWqUv4Pbh1n5eorwhdZbtl6PfEDX8vLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549774; c=relaxed/simple;
	bh=/qasvl+nVcRZ79yu/U8D2LnlWxObjlfQGc1xvyOkYKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2JyGmKtsIxk1SA64TSGAIg6R1Q9fivwtKDiX+Byw7adYu7KwloLEqP9GSc3bU7iG+fUsce/Vf/g2Vj1J2GNILnEKXmwnwHReGb+ejOzRHd+LaHJLvBd5JvSfaT40chRTD1SaWUf2wiuGZI/KwMSNac29sbQg6ukph2FCd7HS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A9CC4CEE7;
	Thu, 29 May 2025 20:16:12 +0000 (UTC)
Date: Thu, 29 May 2025 16:17:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <20250529161714.1d172189@gandalf.local.home>
In-Reply-To: <20250529144327.1633825e@gandalf.local.home>
References: <20250411161746.1043239-1-csander@purestorage.com>
	<3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
	<CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
	<20250528114549.4d8a5e03@gandalf.local.home>
	<b694c72b-0873-4123-869c-134709341e19@lucifer.local>
	<20250528122411.16a551b1@gandalf.local.home>
	<20250529144327.1633825e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 14:43:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 28 May 2025 12:24:11 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Yeah, I have a patch that shows how many static key instances exist and I
> > test that. But I probably could also add an option to the macro that
> > creates the trace function to also add something to a section when used,
> > and report when it isn't. Shouldn't be too hard.  
> 
> Done:  https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> 

And going through the list, I almost sent a patch that removed the two
events that this patch removes!

Luckily, when I ran "get_maintainers.pl" on the patch, I noticed you were
one of the maintainers and then I thought "Hmm, is this the events that are
removed that started all this?" And sure enough, it was!

This was going to be my change log:

Subject: [PATCH] mmap: Remove unused events vma_mas_szero and vma_store

When the __vma_adjust() was converted to use the vma iterator it removed
the functions vma_mas_store() and vma_mas_remove(). These functions called
the tracepoints trace_vma_mas_store() and trace_vma_mas_szero()
respectively. The calls to these tracepoints were removed but the trace
events that created the tracepoints were not removed. Each trace event can
take up to 5K of memory, and it is allocated regardless of if they are
called or not.

Remove the unused trace events.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Fixes: fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
