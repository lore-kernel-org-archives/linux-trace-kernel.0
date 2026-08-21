Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1F390C94;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355016; cv=none; b=fDHrvzpHx4nUCKId2nUewO7Vr1nEL9WDS9FFl4YiFdWYG9kBJNYEKvqXz/+IEiw7iTLJqCxPpY5rW9fvTbX8iZMOxAMFqtPOmctqVroQhBHDN7rf5k1mbTImL6swwfEr5wQLm3aclPrte2T00sd3Y6/LoH+mTYnR4AqkI2fU3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355016; c=relaxed/simple;
	bh=tic/eCG29DwfwVGbWxAuRBOrKemDF71lhWCK6+t3UbA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kgHyUpBNy6IPk67DOFBtrMK+zlJMJKEXgAkuzIoxyARWrP4ALeTReoodg5TgmJ4ov58P7BsC7GOZpdq39KzXEMn4SicUT+Cr55/4O+oEyNiBlHRhv63YDSo031EH/ayGHb6Vk8W8JORgEn2s0Ixi0r3IbcQ7lUhbblH1lfR93Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i575Ts/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i575Ts/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4941F00A3A;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355015;
	bh=aTLLnedvrxWkk6BZVlEE6rO7y4yaYjbcD+kaduCb7WM=;
	h=Date:From:To:Cc:Subject;
	b=i575Ts/+g05oA0P7BLSpkwkxMIS/C9cI9fApuW6hDZ7I2gQ81fdDMQzHIOQgGBwE1
	 RfpAK+JU2Nqz12EuaMzsRHt09fjwEPDnEkyvs5LCiqjMXnPKQC2ax2MJDQxcfOslfB
	 d2SyL1yh9jGK9cD494aIgUK0kSIpqzeblGPrAsl+tHvo6DSl4hvTaHBSo1to5yQ7SU
	 Kab1bmg8qJWhZYR1Hy2y8rLniQkbDOqSEN5uglxMaVs0J++0PWXEsxQ4SIy2AqHVpG
	 2s2OWUo+nmcjUlXacJVhvxf+3iVZxFLVCfhgKDN8GDmmuKO7dGO13nVxURg3Keu463
	 Ub9y4G2iuB/SQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wxYhG-00000005riq-1Iz9;
	Fri, 21 Aug 2026 19:30:50 -0400
Message-ID: <20260821232820.717143516@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 21 Aug 2026 19:28:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Jun <chenjun102@huawei.com>
Subject: [PATCH v2 0/2] tracing: Add 'within' filter logic
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Add a "within" filter predicate that tests whether a given function
appears in the current call stack at event time. The function name
is resolved to its address range via kallsyms during filter setup;
at runtime, stack_trace_save() captures the call stack and compares
each return address against the stored range.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260608145556.94931-1-chenjun102@huawei.com

- Added patch to show error message

Chen Jun (1):
      tracing: Add "within" filter for call-stack-based event filtering

Steven Rostedt (1):
      tracnig: Add proper error message for glob use with "within" filter

----
 Documentation/trace/events.rst     | 12 +++++++++++
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace.h               |  3 ++-
 kernel/trace/trace_events.c        |  3 +++
 kernel/trace/trace_events_filter.c | 44 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 60 insertions(+), 3 deletions(-)
