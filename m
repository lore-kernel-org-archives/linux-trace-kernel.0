Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F023211A24;
	Tue,  4 Feb 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683074; cv=none; b=uImMnqZ3pOUxd5BwpmmToAlbX9Kcdcv8c4r88BSyczITEH9eM0slWnodph2Z5tjb92QBcVGQYDlC38KhhpbLSQDpGebXVQGedaBw8ZqC7h+e8n4qWfc9S6iUdM7ih5432AWLazx1soHss/xuXlP4jsWnWi4AtgeAdILufU00qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683074; c=relaxed/simple;
	bh=csDB38bmsHlooZZ5ojmW7JJ2wKzH5xmMN0NCWnMLt2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbCflC7EHgHP1KFLUk0r5X0rWJeKWSfTHrLOCe/zdpWnamTNISWk/3DZUYveGFqPjZOkYAEYYE1V6bRbN5jwvgD48bohqQyXpAmbQ/kAMnG5GCdk13VNiJeXLTJ0i4VOwo+6vZV2lCH+DhVuiD0SVzPeeHAwHmFJ2dMie3aIb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pW/rqMmx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pW/rqMmx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yUBMLdid6p8J2t+8TyqgXCNeWZFR2eWp9+2MIB84uUM=; b=pW/rqMmxFYkdQlFK2u4+ErsxWP
	1mFDlujBrVq2RFV3eAodLz7/q5UBbw8EliGapJlOs+PTtFwEoRVsMaXnZ0qfI40krCQnFTU6g+lDs
	0S44+5RESQX8KFWglq+LBWlv8HAFxmDvSqk0a+3tdFxnQZkBJd2YpYLUJxYbsrz+QoyhJ933xKrnc
	3vIFA2CENAeqlz3vN0Xb5dISF/WqhGpaD91kt9PZtEhW5qUhCY9z/lDyqkKzQGqy5Wfohu7y5OQlD
	ypwQQub3R9I/F4NvWGx0GlY8SqdAqLZsJMxgiHx20aWYZW9lL1HjelJ7rRh5m1DmPSKpY5rLWSRX1
	e+WijXiQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfKt3-0000000GLGl-2NoB;
	Tue, 04 Feb 2025 15:30:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 280653002CE; Tue,  4 Feb 2025 16:30:53 +0100 (CET)
Date: Tue, 4 Feb 2025 16:30:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
	daniel.wagner@suse.com, joseph.salisbury@oracle.com,
	broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250204153053.GX7145@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net>
 <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
 <20250201181129.GA34937@noisy.programming.kicks-ass.net>
 <20250201180617.491ce087@batman.local.home>
 <20250203084306.GC505@noisy.programming.kicks-ass.net>
 <20250203114537.6a30c7c0@gandalf.local.home>
 <20250204091613.GQ7145@noisy.programming.kicks-ass.net>
 <20250204075100.3fcbfda8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204075100.3fcbfda8@gandalf.local.home>

On Tue, Feb 04, 2025 at 07:51:00AM -0500, Steven Rostedt wrote:
> On Tue, 4 Feb 2025 10:16:13 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > And yes, you can still use the whole 'delay preemption' hint for RT
> > tasks just fine. Spinlocks isn't the only thing. It can be used to make
> > any RSEQ section more likely to succeed.
> > 
> > 
> > > Patch 2 changes that to do what you wrote the last time. It has a max wait
> > > time of 50us.  
> > 
> > I'm so confused, WTF do you then need the lazy crap?
> > 
> > You're making things needlessly complicated again.
> 
> Do we really want to delay an RT task by 50us?

If you go back and reread that initial thread, you'll find the 50us is
below the scheduling latency that random test box already had.

I'm sure more modern systems will have a lower number, and slower
systems will have a larger number, but we got to pick a number :/

I'm fine with making it 20us. Or whatever. Its just a stupid number.

But yes. If we're going to be doing this, there is absolutely no reason
not to allow DEADLINE/FIFO threads the same. Misbehaving FIFO is already
a problem, and we can make DL-CBS enforcement punch through it if we
have to.

And less retries on the RSEQ for FIFO can equally improve performance.

There is no difference between a 'malicious/broken' userspace consuming
the entire window in userspace (50us, 20us whatever it will be) and
doing a system call which we know will cause similar delays because it
does in-kernel locking.
