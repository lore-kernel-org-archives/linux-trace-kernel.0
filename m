Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAF2F46;
	Wed,  5 Feb 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724626; cv=none; b=Lu+cV/gp9aAY6tACDDKXAQ1ssN0r2tBhvVZ4yVutmPuRhvjEOC7edF5moUjR4vESJBPxv9BKCQG5KfP0VpfSPoXXF2awFxYNoigLVPViNaIQW8urQE0dtoGgM7S2USEbvFefb2+WxW27BvA5R1UnrE3kQyXTalW4oyVUbNXNSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724626; c=relaxed/simple;
	bh=OsIkZrPR1FCD59Tt4w40qaAu784YJPZNkN+IsFjoABA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjwxjWiirOaqnxa827yAfadGrXnctBVd6bfeTV06fn/JN5cNC7WUEB95ATHtFYVXYlWf6BiMXXVp3IX/HmjtLpBFLZ/ymaZXVrk2kXFjwnHrOFmrRQ3rAXDsmbChA++2tkx4GBf0whXQ1iG/D2wvW9WXLGSuHNCprrP8xvSYyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840AC4CEDF;
	Wed,  5 Feb 2025 03:03:41 +0000 (UTC)
Date: Tue, 4 Feb 2025 22:04:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>,
 jgross@suse.com, Andrew.Cooper3@citrix.com, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, Joseph Salisbury <joseph.salisbury@oracle.com>,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250204220418.35949317@gandalf.local.home>
In-Reply-To: <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 19:56:09 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > Here is the RFC I had sent that Peter is referring  
> 
> FWIW, I second the idea of a new syscall for this than (ab)using rseq
> and also independence from preemption method. I agree that something
> generic is better than relying on preemption method.

So you are for adding another user/kernel memory mapped section?

And you are also OK with allowing any task to make an RT task wait longer?

Putting my RT hat back on, I would definitely disable that on any system
that requires RT.

But for now, I'm looking at implementing this for VMs only.

-- Steve
