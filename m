Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DB21D3EA;
	Fri, 15 Aug 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265743; cv=none; b=YcAPdt8A05B6gSIKfJJRWE48uR9lSQfWuhXTZ9rv+eN1jcArdz5WgufieVtYJTusWcwsKcAtoNngAE3TF/1jcxmBMw6CGXB8HLQkLOOKjJUFhSgT3w7WqdAidiyf2SzObzhHjN/uQ9hTM7o+Smi9rWBwRRkv5VXbFjqYdE7q3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265743; c=relaxed/simple;
	bh=dtyVu0UoOihmYW9ms8y+knDsPv67ZF0PdoiksezD7KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtlDJ243e+VgUp62Tww5qjsHiqRF9VjArd6nAPA3rVAiuoO6p+au3bEpW5FrHH+TGQ9bq+5zTg7O0qXvQHtPZz+qUJU1nHKKOH2F34n22oGdhGdkXxr1e6seS/Mz0CZIu+jq8lM1bR2XUX3sqA3G0JxYZ61paWteZK41YEfkKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O5PBS6bE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O5PBS6bE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dtyVu0UoOihmYW9ms8y+knDsPv67ZF0PdoiksezD7KQ=; b=O5PBS6bEUD3Jn7edqELH1fGzLu
	5PNouS03BLXym9FiVB8K4C82zMF1njlGuPlpq4tECv5O9/YpHZWjw9sOrWwgqD18aQt/yzzzGhVby
	rodqsmWdcpURNrmcyQK8jTE9CEYvrljS74XA8VRgc5A/LdIrhAtzyWhQg+e6WP1vGWRTPh7i/m/Ae
	4f4R2Hqy5GRa78qWJQJFQdzLwrm7vzlRQ3OeejD0B32Z0eRPj1GATiLYPgCnbeI1UF0hMsdCCSCMZ
	DkStvKGsU3AfpOOjVKa1hIC1wzo76XBM4rK2Lc2qrDWIuAKKws3DFdZUbhahHkeSFmrsAXq7bS21+
	dGETkrHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umunc-0000000GjIV-1mw5;
	Fri, 15 Aug 2025 13:48:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0353B3002ED; Fri, 15 Aug 2025 15:48:51 +0200 (CEST)
Date: Fri, 15 Aug 2025 15:48:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
Message-ID: <20250815134851.GC3289052@noisy.programming.kicks-ass.net>
References: <cover.1754466623.git.namcao@linutronix.de>
 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>

On Wed, Aug 06, 2025 at 10:01:21AM +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and extensible
> scheduling policies

The actual monitor seems to know about deadline too. Surely changelog
and document need updating?

While there, you should probably extend to cover at least STOP class,
but possibly also IDLE class, no? Validating: IDLE < EXT < FAIR <
FIFO/RR < DL < STOP.
