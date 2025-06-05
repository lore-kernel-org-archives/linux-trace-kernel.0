Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09A23741;
	Thu,  5 Jun 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156938; cv=none; b=ZOQy+LKTQnC3GURY8eQYWuI0GS9lWrNfVeLZoUzvhI+lWD5ylBOo3hki4xg71GsA+GGt3VofZqHeRAi7OobKybipWTeXUoKoz8kqvHVm3w2PCgKMr6skbZeDxzKFHY/Prkvg9tnvX/O4N3CyxmZjF0JWxrRmgxZPSQzVrtbZ4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156938; c=relaxed/simple;
	bh=jp7oNZPg44z03qc6V7Ms4lQv5ipBgXpJSOmI1KxzXkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoLnUoaNZ7Xn+d0KgIdn3oNkVdV2Xwc+L9uJLulMZSrLa+ysrT8TGwiMi3yUkjKO0G4uXTaHD3UVz5bQ+YXJsh5HH7x9nJ+tlhpDhyHLgI6yEszAsjhdMS2vv+LQZEIYg7BSuSyiE/4zCR+rkevjW0FTP6M9M+8zg62D3sA0a3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D36195FA98;
	Thu,  5 Jun 2025 20:55:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id AD02320029;
	Thu,  5 Jun 2025 20:55:30 +0000 (UTC)
Date: Thu, 5 Jun 2025 16:56:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>
Subject: Re: [PATCH] mmap: Remove unused events vma_mas_szero and vma_store
Message-ID: <20250605165650.7b0270a1@gandalf.local.home>
In-Reply-To: <20250605134910.fa50aabe5b0c13c11f6c9178@linux-foundation.org>
References: <20250605161959.328ed2a7@gandalf.local.home>
	<20250605134910.fa50aabe5b0c13c11f6c9178@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AD02320029
X-Stat-Signature: ozn6gjhii6uwraqr6g3eymtkwfz7tbwx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ht0IpfE6SRGJvfPppIyveXuohSzBZEM4=
X-HE-Tag: 1749156930-546864
X-HE-Meta: U2FsdGVkX19M3ItOfsB/vCMW63kyqpDODO06ntnG8YiQgqGw/4NphT/YJVyTZzabte8jpXUJ7PcYGMxNeuUWw9dsrXJN9yhM7Dzy9Bju2vx1QiquAIUrk3K8bhuis6ZHjkLNiQ1YYf+VrA2h1hWeEgVtCQH2rsqoerYSEVvFOnNLGtsi7DQGflfXrPzTibev66IOtIqeVqvu+Bi/dflk/iKvCX0CD54u3Smp/HXtOh2/+YhZuP32VrWv6yRgfFz5MhzJTL6IuH2XxoWwBEehhy6se7EAeIVZPy7wegKT6qQmLz6wB7DYSA2bypTIl5oNWeYsjX7bXsAP/xqCO7gC0dIYdh2ZFIUBxAyfuWkut6wjObtqcI03nLn713cbaSjr8xCwbPzzu/LSNu6bgWUfyQCPnDoqPLBX8d6pziDRLsDJu1ywcA8HB8NHk4+EUddWynYrOTNSMlwld6ei7oQRoDdhcS559R3cpi9Ip7K2ghLZhZUFwoUzdCNvtZFbakNnILLw5adMeeY=

On Thu, 5 Jun 2025 13:49:10 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 5 Jun 2025 16:19:59 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > When the __vma_adjust() was converted to use the vma iterator it removed
> > the functions vma_mas_store() and vma_mas_remove(). These functions called
> > the tracepoints trace_vma_mas_store() and trace_vma_mas_szero()
> > respectively. The calls to these tracepoints were removed but the trace
> > events that created the tracepoints were not removed. Each trace event can
> > take up to 5K of memory, and it is allocated regardless of if they are
> > called or not.  
> 
> Thanks.  mm.git has an identical patch from Caleb Mateos
> (https://lkml.kernel.org/r/20250411161746.1043239-1-csander@purestorage.com)

Bah, that's why I didn't send it out. I just noticed it in my queue. I
forgot to delete it.

I even replied that I was going to send this and found out that it's the
patch that started everything.

Feel free to ignore. Sorry for the noise ;-)

-- Steve
