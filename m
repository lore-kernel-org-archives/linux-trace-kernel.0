Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB7449EB6;
	Mon, 31 Aug 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186125; cv=none; b=EPbUeVhI5DafXaqfpv+6otZYIPixKWO3kDkXoc+8o32l9VcJLAqjPe0XXRwsjjGqukhGlxU7gmAPDdN67sBzFkVCMgRN0Q5U9bfGo473ZL0wYFhAd3abe9vqCs+t9gzMoOdefHvWLRCySnCFAFHY925MNm4q6Dc51PvfGqL0oF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186125; c=relaxed/simple;
	bh=PkytVdfjU03gHxwZJqkU7RoAAMlNIn1ynIlSq91v8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIZ0pATzWEOjkh0yDFlgeTHPNwzYi/CL1WKN2Ew9OUG8AK/6Sa+tM4B22JjzoIRLerXRVSs9dcyF2c/b3R9YIyeY2lmkVK8aIo7797d7U5RIkvmblWp+jZwKxb18hVkHSTzkWZwGipQMG1uxe6OR+mdwhggkM90zpN/UxIqJ6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JohyFmJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JohyFmJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150721F000E9;
	Mon, 31 Aug 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186123;
	bh=wxl5RHJhkRFs2XjKvj8BKvxBHt+aIosokXGdx1OzDRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JohyFmJ5Y93g9MdflkNPjIdlCd9hP+llsfFn4odffFq9POB0WzR5tc470wtlGvVgp
	 qNl0DuI6cCEGHvIv9ndhpqop7+h85Ipfnh+wBfkEfqmD7AmXDjPQs+GjN0zsU+AwOP
	 G+td/T8vD/2NNIHnfpv57COFQFqe6uZBzcp3hXihZVJ7p56+vCZ01EYGIzkjExGAUG
	 lwaexXvWRFnw6suVEuh/FoJiTp0OK2GtMUJRnlSzHFI9Ki6lckoNxCvh0aW0oqImQe
	 lwAUvypXTNqc8FDGmaE4LsCtmieBA5H2AuDOm8VM2qM0xRWDO8mECbKuSh3QsJn0qa
	 I1UqmW3nwWTDw==
Date: Mon, 31 Aug 2026 10:22:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 0/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260831102258.27b65d5b@gandalf.local.home>
In-Reply-To: <apSuTRfEmAkzpuiq@yury>
References: <20260624081806.120105649@kernel.org>
	<apSuTRfEmAkzpuiq@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 18:27:38 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> Hi Steven,
> 
> Any progress on it? I still see linux/trace_printk.h in 7.3-rc1.
> 

The merge window just ended. I'll start working on it during this cycle. I
had other issues come up that needed to be dealt with first.

-- Steve
