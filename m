Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA3248888;
	Thu, 12 Jun 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739285; cv=none; b=lMmWGjXqY7srxbN+VEYgE0E8hGxz9jRztJ8m6D+rhXG9HD0uoa9D3B6WJ9rYifV0vocUc8nsmuIup5W7Yd+2X5uWapEwv3qg296MjJsLpx7vHj4SE4EQWw0/tzCIKVS8QSPjT3nVBnBLXml/6z4x93CKRmzDKZTygrNiwTQtcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739285; c=relaxed/simple;
	bh=LFbsH10WLiGBngvFPh44/deNfnqtaymDaLb4kT/e05U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krdIU2bVQ+Uu7hG94w4zJKdrao37djGpRiCMLe+dMx1K8cW+V1gb4Vfgm0EJ81HC7jXDfOQyygm+ZmSs6vvIo4ZDlnBqcnxzPuaPxGCSiC8U4Ge/XCap4vGEwyxR/X1tQshAoGMUwudsVrhOmtdLVQNEknGpseNp7FQflQjU4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CEB5D1A1783;
	Thu, 12 Jun 2025 14:41:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 74D8122;
	Thu, 12 Jun 2025 14:41:17 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:41:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to
 x86 code
Message-ID: <20250612104115.039a3817@batman.local.home>
In-Reply-To: <2aec964c-ed7d-4e37-9649-cc0d20469142@intel.com>
References: <20250612100313.3b9a8b80@batman.local.home>
	<2aec964c-ed7d-4e37-9649-cc0d20469142@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74D8122
X-Stat-Signature: 14hjkb4s3yoff3wm6gf659x3bwz7783f
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196er8TgFlcvZzFV7v1dZa9COTqpYsEhew=
X-HE-Tag: 1749739277-873154
X-HE-Meta: U2FsdGVkX18wyPL2yuue7VL02ph12FgTwvegfaD4iTi35/VWqfSPLmLSGyNWfO2TO40aBJ4fT8UNWbBF5M5sSxew+Vv9NO8j4KZIoq0bByed8Fk7orVUocN2xfl2i3omDu2fDOwQB954fenIF65SwV5zmPVfre53F+YzfzeYzN4G1ZvNGWEQQtrhDf1uV4cvgNLOUMr5HnOVfzKGHoN2ym+0r53vP2dKCr4I/dCkFtOIg/MlaXGtA2QpYO1iHgF76TZ87v9qt4jfNvVTNtVf/5t7meV7cTL+1mcBe1Q/6rEdETi1BTP1ShfcYZx0yZ3SkCWuLWB+HAuxyv5Aml3PCLJZOgNZ0YYJ

On Thu, 12 Jun 2025 07:06:47 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 6/12/25 07:03, Steven Rostedt wrote:
> > Remove the events/tlb.h from mm/rmap.c and add the define
> > CREATE_TRACE_POINTS back in the x86 code.
> > 
> > Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")  
> 
> Is this a big enough problem that it deserves a cc:stable@?

That's questionable. Without this patch, some memory is simply wasted.
So it matters how much you care about wasted memory? On memory tight
systems it may make a difference. But it's just one trace event, which
would free up around 5K of memory.

I put in the fixes tag here because it was an obvious mistake that the
header file wasn't removed from rmap.c when the call to the tracepoint
was. Hmm, I think I put in the wrong fixes tag. I should probably be
the other commit:

Fixes: e73ad5ff2f76 ("mm, x86/mm: Make the batched unmap TLB flush API more generic")

-- Steve
