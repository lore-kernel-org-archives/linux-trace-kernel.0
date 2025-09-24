Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA385176ADB;
	Wed, 24 Sep 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717957; cv=none; b=W3MFVyYblbmiY/+nqlT3nmLch6QKL7HzCmHjYXE4jX+EZtYQpPpp/mB8+y4ZPXx3HIRH5s4qPqxKNsm87xK9sc9WHryonxAkc7HM7KPqKdGUSqe7l+hKWc2qCJPDLUhhD8qkYZFkndcnrb7sZWWpUaZN1vMT0TBL4p0vYlvX+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717957; c=relaxed/simple;
	bh=t4C69rZFSIWp9UwTTD2KbKg5I44Z6UKMf2ovqBoCMOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot/kLQ6X4m5kSF06E2edGGg11sf4v1ov5dmPiBzl2Ukmxk7XYI9Qf1snix0Wakj2Mhk518jMi840gaB4sNhKxfTRjtxGkGRg12ACaktu0P2u2CoDD5aejviXmTTweVHqPFEXCVBJ8wB3CBm21eM4LOPItGj+04CQHWn0A4AiA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VqZIEq8L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqZIEq8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t4C69rZFSIWp9UwTTD2KbKg5I44Z6UKMf2ovqBoCMOk=; b=VqZIEq8Lvv5usQqKtcbWay+CQK
	7496LcGIjxgUaARlxXudEbKVFcmv1CeiPV9CzCUjpWb9/9AgO5TdRzUWsDb5uKJddxRw0agCEe+wc
	MiAHdkeJ+iaBpejS05lrMYToAoeWFjYCltHHXyqGs1lEdv/Vb5FCMdk2jx0FncSvolmV1zC0tQFIz
	IW+UhnOPO4hH/PMlzzohk1p89q7bpJMBzmWeQz1AmoC0FjvA1ifzRPVgmC5ebdImggmTv/7VSo6j+
	12FRb/wepb0oRxiXNrO+8d94/8zDguD4seyC4Koe4A6LOOw/2nwpzjJfLngcXybWQ73pS86hvVFOs
	iQOmPjOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1OsW-0000000FWqg-3rzS;
	Wed, 24 Sep 2025 12:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE98830043D; Wed, 24 Sep 2025 14:45:47 +0200 (CEST)
Date: Wed, 24 Sep 2025 14:45:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, mhiramat@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	mathieu.desnoyers@efficios.com, andrii@kernel.org, mingo@kernel.org,
	oleg@redhat.com, akpm@linux-foundation.org, gmonaco@redhat.com,
	ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v2 1/1] tracing/sched: add 'next_policy' to
 trace_sched_switch
Message-ID: <20250924124547.GJ1386988@noisy.programming.kicks-ass.net>
References: <cover.1756212396.git.gaoxiang17@xiaomi.com>
 <c2894f9b0c5116eeffdc19947529aef5c5d1db4c.1756212396.git.gaoxiang17@xiaomi.com>
 <20250912103050.5bf82967@gandalf.local.home>
 <20250924124107.GJ3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924124107.GJ3419281@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 02:41:07PM +0200, Peter Zijlstra wrote:

> That said, you can mostly guess the policy from the prio, I mean the
> distinction between fair/batch and rr/fifo gets lots, but you can
> readily tell the difference between the fair and rt and deadline tasks.

FWIW mixing RR and FIFO tasks is asking for pain, adding tracing
information isn't going to help you restore your sanity.
