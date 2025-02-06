Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037991C6FF4;
	Thu,  6 Feb 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849764; cv=none; b=Sp+6Pynkj4DIs50CHGBklejF43pOVe2dsMDK62Ik7BcFDcY86Ky2461bTCm0n1+dMuYx8cSad/ieYHxR9/lbTispaHmd5F9tZ9z0karuvzyOeWOjrI63acEgFP3ZxPv4vVJll5y65FW9KpWvuUoDET/EZbBKbsAesucjeoZrFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849764; c=relaxed/simple;
	bh=Y3vfxgqWOZEe0Hd/ewi+GadlPXvOgCMGGR4Qn8Wddt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2GPmPQhlYcWi5Gm8apGI4swJcg81Nqi39S7Rm+DuOo+NiVw+TN/zyewwdVo01xep0dvMezvDkyOCR9jD7B5TiwO9ZrvMmEzKKyDpCfMrmqbTDHaXEK3rrmTtokvkxIYzMdeLA0QtHFZWwiyJw1bqzk2/n+6ewtwmGfQoN2MLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XR64Ar5+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XR64Ar5+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y3vfxgqWOZEe0Hd/ewi+GadlPXvOgCMGGR4Qn8Wddt8=; b=XR64Ar5+6ywuSr/mxmKOGYU1hk
	CE42fj6bIFgcGYiv61/sT4VfvuTtu+6cwaWwZqUntvKFp87sKx5a6x0daN3QhCHOp5/MTnQZQmx1L
	2vEWVTTmPajAydU4sYQSzvwh98kkYWpmg1jst42chKqHf6Sn/6pgeGN543PdGPa6KHx1MGHHq/Avd
	8267K7LR7JZn6xmi+uFz8sqWaC3l/3tvGwAQVaBqmUzgUJGqTQzQNzBIjbui7EielG+zTOcyefl7Z
	55PtNg4aBDKMKyNWH4RE/sV2arFMjyH/PHla5UHwBtBZqoeqa/qKAA+192e0USeQ/RvlDGUsO3DD7
	0D/vsLag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2FZ-0000000GxJY-2XaM;
	Thu, 06 Feb 2025 13:49:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F58C300318; Thu,  6 Feb 2025 14:48:59 +0100 (CET)
Date: Thu, 6 Feb 2025 14:48:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206134859.GP7145@noisy.programming.kicks-ass.net>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206134408.lD_POjuG@linutronix.de>

On Thu, Feb 06, 2025 at 02:44:08PM +0100, Sebastian Andrzej Siewior wrote:
> SCHED_OTHER vs SCHED_OTHER after all. But please don't delay a wakeup of
> SCHED_FIFO/ RR/ DL because of this LAZY hint.

Thing will get delayed if interrupts are disabled or kernel has
preemption disabled too. So as long as we ensure hint crap is of equal
order, nothing cares if you do.

If you can't tell the difference between task does hint crap in
userspace and task is in the middle of syscall, you can't tell the
difference.


