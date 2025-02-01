Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7F1CAA7C;
	Sat,  1 Feb 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738433521; cv=none; b=pMgV8ZBrBg/ephq0K7oJl6BnnoOiQSa534SbZI/ujNZECkeutb34685pr8MAdHc3CuXYesnFSqVUbDFUTwFgpzlc2o1B9BJn74s1aT2R1X0RwTgPr0OTyoB1PeMbIwaV6y5Ko3XWF6o3zkAXgw/nrevg13jxaR7/+AqiEl2GoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738433521; c=relaxed/simple;
	bh=8WVjS1nKR1GWra/WMp/l4q+WpANRNgI0+C0UyHhV8wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYEpL/Seb6bIuJTbt/C55zBw8lfeKTc4HjrOBFhFVN0xyID2yZpExj9NSC5wqhG+U0W0OQlh5kx/wHAku2sYICulTfri2BxF0qerYvgmyLvEs4Qx5gVC+3w8K4wqHoU4rtEQPT+03ZuPr0u7y6ZSPKjzIF8tS1IBFDxDcXXe4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GkxBa9u1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GkxBa9u1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LlN8fDEAhKUNZRsMj4/4ALQP9qC4Omt7rN7TUcf2ulk=; b=GkxBa9u1m4Eqw2KXdSpvkSQ+JZ
	4XNmsUP5uhEN1ahspih1L6Th1k2fi9/2y3hkTHXyVIjsr2evfoYAnvUdZul+rQkDn8bMGyoN38Uoa
	X6JpfmbO+08gGHS4lzE16N8UL4DNA26FN6XTHFb0O0edNswuz2w42ipCGBozAiXVB76syUK+7oLUP
	flummX4f9D/V2IhuMvMxxnyOyPyqDsEf87FtmvhyS7Or6tfq/mN+llwF+n1YdxoZzcUq251ZbiFPS
	v0ysA7RI1RQsgYPoZWBqMcl7FYToKeOrCSVsr2W/r2wRkpfpwuI0KD8u0dpytC3QZqD+5HHlV7Ch+
	MbjQi+PQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teHxq-0000000FkEP-2zBU;
	Sat, 01 Feb 2025 18:11:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E78330050D; Sat,  1 Feb 2025 19:11:29 +0100 (CET)
Date: Sat, 1 Feb 2025 19:11:29 +0100
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
Message-ID: <20250201181129.GA34937@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net>
 <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>

On Sat, Feb 01, 2025 at 07:47:32AM -0500, Steven Rostedt wrote:
> 
> 
> On February 1, 2025 6:59:06 AM EST, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >I still have full hate for this approach.
> 
> So what approach would you prefer?

The one that does not rely on the preemption method -- I think I posted
something along those line, and someone else recently reposted something
bsaed on it.

Tying things to the preemption method is absurdly bad design -- and I've
told you that before.
