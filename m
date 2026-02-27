Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467EB3A4F23;
	Fri, 27 Feb 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225741; cv=none; b=bbPHBXtXET/7ZGwU8nMnuvfj0be1WUhza18zSlPAXmDsJGCZOQahYSPXU3JZCce3+Qzk96XHjkHnsNU4upfqY8ZdvhNWMZBvmfOqCkhiT+NXFElffXnndP1nuaTTBHj4YjlgGX62I/eHxGaVV8ZejVbBBcQMWBfk2rAl1Pq3438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225741; c=relaxed/simple;
	bh=9P1DES3rP07d3FfjyF2gj1R8LWV5Jcz1cc/2c9A5Cww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdxCxKretSWXDulj5TH8viRy1ZZ1+JahUgFSTTbSfqvSsIXZ+XziRwkwp1CglirVTSCg1+yPlnhUEe0jNDtminOBFx4joH9JFMoJtFFX6MKg7SK38+gx+vqVMxmODN94dMy73D0Lbf43VcQXsThWUIJFChIPxwbMbK9/Q/aHuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id AB7E95BAE7;
	Fri, 27 Feb 2026 20:55:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 5D34A20029;
	Fri, 27 Feb 2026 20:55:36 +0000 (UTC)
Date: Fri, 27 Feb 2026 15:56:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Qing Wang <wangqing7171@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <20260227155601.18ebd3ca@gandalf.local.home>
In-Reply-To: <20260227102038.0fef81e9@gandalf.local.home>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
	<aaFrmHzIAkEe7ufy@google.com>
	<aaF0zS3xh5KgM_yy@google.com>
	<aaF-bhAIhCgusG9k@google.com>
	<20260227102038.0fef81e9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qowkdzp7am53kdeb57n39gue6stf8zay
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5D34A20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/A+ALCsFBkYLx8AEDKBhKfkPGlnqTTPEc=
X-HE-Tag: 1772225736-585346
X-HE-Meta: U2FsdGVkX1/p0bJvgdjQs6KYjXcFpyV/MlnSMf70JAYln9Pl7jBwo+VNmi+k6W2glnyq9Y6jfimC97v7pHsSkWNa9p3COcmXjYbQnCcq8v1Pg3dB+ZwLEQkcJTSFI5Kt8AjINSE5Xuh5TGtNcIuITM0fvReHL2HrrdxcCJaVzhgyKTir7B3XIoHWgF+Lzs9oH6Futp+ioSqhN0+BIcSUAVFT0TZ7KYjBYNtRSRlAp0D8BD4Jm2NT95EGfTqLnJFRheCnW3EfPYZc0bMgE+drabNVuvOFVjpsMlVwPlLM9d+lFdLhcMGQnoVN0Qzg3q6LsPAkq1p0TVH4KNkWyaMcFj0MUlHGE1ahqT+8RtRqgC3YdgN+W/h8sanqZlvGC1EJgM/CwkbuWk8Wf3yb/t+fdyyizo91m7hQbjSXxkkNrJ4=

On Fri, 27 Feb 2026 10:20:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 27 Feb 2026 11:22:22 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.    
> > 
> > As we are applying restrictive rules for this mapping, I believe setting VM_IO
> > might be a better fix.  
> 
> Agreed.
> 

Adding MM folks so we do this right.

Dear MM folks,

Here's the issue. When the ftrace ring buffer is memory mapped to user
space, we do not want anything "special" done to it. One of those things we
did not want done was to have it copied on fork. To do that, we added
VM_DONTCOPY, but we didn't know that an madvise() could disable that. It
looks like VM_IO will prevent that from happening.

But looking at the various flags, I see there's a VM_SPECIAL. I'm wondering
if that is what we should use?

The effected code is here:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/ring_buffer.c#n7172

What's your thoughts?

Thanks,

-- Steve
