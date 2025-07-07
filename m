Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB288191F98;
	Mon,  7 Jul 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887594; cv=none; b=lME+3uIcX4o/lnxs5iTsM3+RPimg8aYSnERxIuhAPpTFaBz5X9kCyRgHLiYSEgojOxPfAX6LtS+Vv8mOohjLb/r4noemuakHeQrSjQNMFOjmZOOdud732vuHc2oydsksjwBURYArh+cNiQ7V60mnoG8E8dvv+NW0YCRz/fmlWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887594; c=relaxed/simple;
	bh=Hcilk+1gc7opmTuORKXudv4wdN1mbGDUSQFfRBQvgBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC/w96rayKoBdnPmzzH32xIjBn6HkcEXAZn8dqA+YsyJGOQxT+vRstKYQ1LY9WNWvZ/JHV8LmJCm4gzWG8O44ojsWfwEqN75YGUSQ0EF5Ne+vDdBJAMmvTGseFXuMASnNt2KS4QidA6qcaNXCMDMzo4SwnGr/qKx/Ax5QT9kXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NVSXNiGZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NVSXNiGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pzsgu0KWdlrvYJUBaVS/BahIave3CRDWqYqZMw/y10s=; b=NVSXNiGZGUsEnLgLoQXSaxxKzS
	5E5i3NfZ/JTpEpylCPKb9s/ePSMiCGUAFSENBPgfM2N8W9inRHFIqNmHOKqn+65bRnKzJDDuPhWyz
	qN8/161xQ3akgW/mhKV5QECrEll9D1aOVUM+WlEeEfqXyRTMTUpCx7f1YB0Mt95RqLWdrN//J0ZAz
	mMHJ3RuZPw50BsrPNkC/ZjUtDrJdnZGnqpJYvgI2zbFBaTd29qQXfpFnesNw0MKIb+F6cmo/tAVi4
	3v/o/FNA0vBdqqxsDGOssaMCDvBkYgFQyAmrPupx3vQ6oLNklTDtbfl4odj7K2zcRz2o4BLJNBf0o
	dS+ibZxw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYjzL-00000008Tg7-1xeD;
	Mon, 07 Jul 2025 11:26:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 036FE300399; Mon, 07 Jul 2025 13:26:23 +0200 (CEST)
Date: Mon, 7 Jul 2025 13:26:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704170748.97632-3-wander@redhat.com>

On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
> +#define preempt_count_dec_and_test() \
> +	({ preempt_count_sub(1); should_resched(0); })
> +#endif

Also this is terrible. Surely you can do better.
