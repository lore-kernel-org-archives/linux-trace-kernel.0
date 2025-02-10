Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D22528F5;
	Mon, 10 Feb 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208421; cv=none; b=JJg4aiQJLtB/GTKmPdNogXC6EN1WRF1Fzr86bJW3AWZnAV42rG/gH/Q6h02P8rIuFcphSmZXiuCVJkslh9bmr9J5fSCkAwYLhtMOCJ0Mjw0LVvXZVDpfbADQY/OqYtz/lRbvrONnOolykD2lLBQZ+CplohJ7moQBy5laqBIf/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208421; c=relaxed/simple;
	bh=Fjs6+0Zf5mgVOYTBzxjcDWilgXuouqf7lljec52hdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOjALRWVcgj158NOLAqKxI1yAPjiGOIh6dz1gf5iwfaUyja6xU74MrK3VRmZWbYfQLzWwm56i9CoPMZtSjJ+m7yTwwr6xyer/GVB0b/RVCsdZfwhHrciCFQ7JO6Q9QFA6KQT+bHpdsuwds1SBWu+7+cVTdw7VpgCaVuk8x9lVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB8C4CEE6;
	Mon, 10 Feb 2025 17:26:57 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:27:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, Suleiman
 Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250210122700.3b963ff0@gandalf.local.home>
In-Reply-To: <20250210172059.07cda916@pumpkin>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250210172059.07cda916@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 17:20:59 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> Hmmm... you lose big-time anyway.
> 
> All you need is a lot of network traffic 'pinch' the process context until
> the hardware interrupt, NAPI softint code and rcu softint code completes.
> That can easily take several milliseconds.

Not on PREEMPT_RT. All that runs as threads.

And this is a feature that we would like on RT for non RT tasks.

-- Steve
