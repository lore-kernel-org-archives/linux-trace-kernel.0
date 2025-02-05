Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06A1FC7FC;
	Wed,  5 Feb 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791148; cv=none; b=RvRZjCpbTopnL6offxIRr3RlGfVakHQHplhIgJAlXRtlEctG0Zvb7SFyvfiBMicdJZIEmu4BdSTdcT9H06+zdbz/RcLqVW4IIvc8DYeidvg0ffkL1cPX29AIbK0wZyRtmv4I+RyosWo/1Xp8Izc8edf4HnnoTyHCoW+A9l2mMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791148; c=relaxed/simple;
	bh=LAF55b2VOhUvWPEgC7SRkW4/zaanQll9Ujc4+1KleSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/fi4OOPqNwppxpnruR5DNiqm8WmFq9jA+kSMWIYCppHB19qYSwbZN/Vde7zh/xQW3Cqe3fpDohoBwSyEkI3RVbIgFgrA4A/9iphYPWBt8zHoM86sExO8HUXlPNwMq/HVm8YczkoXar/E/Nw4FCS+ZQz28XiyMaAL8ZnDuPxlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C5C4CED1;
	Wed,  5 Feb 2025 21:32:24 +0000 (UTC)
Date: Wed, 5 Feb 2025 16:33:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, Peter Zijlstra
 <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "x86@kernel.org" <x86@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "willy@infradead.org" <willy@infradead.org>, "mgorman@suse.de"
 <mgorman@suse.de>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "bharata@amd.com" <bharata@amd.com>, "raghavendra.kt@amd.com"
 <raghavendra.kt@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, "jgross@suse.com" <jgross@suse.com>,
 "Andrew.Cooper3@citrix.com" <Andrew.Cooper3@citrix.com>, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "daniel.wagner@suse.com" <daniel.wagner@suse.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>, "broonie@gmail.com"
 <broonie@gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250205163303.6f45db37@gandalf.local.home>
In-Reply-To: <20250205161945.44daf018@gandalf.local.home>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<1A67C4F1-F07E-477C-9781-071546AE3A8B@oracle.com>
	<20250205161945.44daf018@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 16:19:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Feb 2025 21:08:47 +0000
> Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
> 
> > The new syscall/API proposed was to provide per thread shared mapped 
> > area(shared structure) that are allocated from memory pages that are pinned. 
> > So the kernel could access it without the need for a copyin/copyout. 
> > 
> > The idea is that it would be helpful in places where we cannot take a page 
> > fault in the kernel codepath.  
> 
> What places do we need to decided this in a critical path? If we follow my
> proposal, where we set NEED_RESCHED_LAZY on sched_tick when it interrupts
> user space, then it should all work out.

Actually, it doesn't need to be pinned for kernel critical paths (like an
interrupt handler). That's because when entering the user critical path, it
writes to the location, which will fault that memory in. If the page isn't
there when the kernel accesses it, it most likely means the task isn't in a
critical section and there's no reason to extend the tick.

-- Steve
