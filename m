Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215292820B2;
	Tue, 22 Jul 2025 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212395; cv=none; b=XT7OVKvamKwxRfeTPN1zV3WYfDrHKe4axYOv5JTC72HoBJon7Q80K++16WAUqq7FeeQSgleQK8piibohGQwrmS8XB9nfqN2kG+72SSZVg2rE1X8oEEz/S8WKkoytDlE5uOM6R0rruXGDVfR/ZzL6MUSFE6b5f/bRpbYEOwr4Ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212395; c=relaxed/simple;
	bh=ieYC/Kg/WckhcAxK/XsYXyAurG8mkSMcaSOr+UWMmuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr238PnhuhEdk98EMgU7EWhX6i1a6VB/in1id/xMthmyRUSF/4NQLSxJkeXk6VRvi3Xo7xU1KIatihDG0/uNVz8uNf5aLDlFYvh88ONblJVctD8ggcLP6vivJp6AJQJYcsn6Esn7iBsZkEiNpMtOfPblJngkG8Rh4a6wELJs6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D681424;
	Tue, 22 Jul 2025 12:26:26 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0BE3F6A8;
	Tue, 22 Jul 2025 12:26:28 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:26:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: arm: arm64: Hide trace events ipi_raise,
 ipi_entry and ipi_exit
Message-ID: <aH_l4cCzzGB5Cd1K@arm.com>
References: <20250722103714.64eba013@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722103714.64eba013@gandalf.local.home>

On Tue, Jul 22, 2025 at 10:37:14AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ipi tracepoints are mostly generic, but the tracepoints ipi_raise,
> ipi_entry and ipi_exit are only used by arm and arm64. This means these
> trace events are wasting memory in all the other architectures that do not
> use them.
> 
> Add CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS and have arm and arm64 select it to
> enable these trace events. The config makes it easy if other architectures
> decide to trace these as well.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
