Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8621ADA7;
	Wed,  6 Aug 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483989; cv=none; b=DIDTOYnZtw8njPLSMm44pjQjYLpiuE78vzG3ZLSrD4eAuy4QJPjQKdPu1fnethtoci0hRUyBbz9522d4Q+SKWgDln0qMbG5dn1Y489Q0y4G1jWzxx1af8T+vNzI1Sn0zZgWD/QZbjWYLfh98qd78R/+0dnshxmEonpx15gpjIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483989; c=relaxed/simple;
	bh=ANPNYrCFCIkqQyWJwWkD+sCkwU7t+1WOva2vvWabb/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjMmkY/L/ZUV2DRYH5Pe9mi3RGGXPkxFOohfxWotFF+xXtE1b5r+kgQywkoaBtiHIN89FTT1OAQ3UmCfY+KxHPpija+sZ3yUwo763AKJiR+oggw3lprNGzDtiNmDAqw4u9Br6BYqNr/K3ZS+3m/EKLwXMjVXw33DH2IG0oYY4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMIOhgvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMIOhgvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D48C4CEE7;
	Wed,  6 Aug 2025 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483988;
	bh=ANPNYrCFCIkqQyWJwWkD+sCkwU7t+1WOva2vvWabb/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMIOhgvtVjOSSyocjhADIjxPlL5K81zqWEJdF+hAP/eGfg10wN+b5a5Qbm4yx038c
	 IPHB1LJyqBJB6uDA3XsHXjUAbx+dNE82MDhggonOpjywiGJ6oeGhT9yd+NQ6YB9A1U
	 nO0axAQQkdxDJzPiEj/JHQr4FOK4J8D1sf6POktX4S+L2My8agzecwEek5Di8mudCK
	 0A/3uTMJlwtbAvpt54K5Csms7evcf7As9O/3hga4FwA0lC3NqTQO8sg93jG7bj13pT
	 6jde46HfoGYiR0Ku0VWZgSD3qNuTAWtNbE4IwKH4djaLfsxpP0es66Dd9XjyXynBrA
	 yA2FkTnpngyhg==
Date: Wed, 6 Aug 2025 08:39:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH 2/7] tracing: Have syscall trace events show "0x" for
 values greater than 10
Message-ID: <20250806083944.036de894@batman.local.home>
In-Reply-To: <c4f1b8d4-774f-42c1-a828-42c79756503d@arm.com>
References: <20250805192646.328291790@kernel.org>
	<20250805193234.915257520@kernel.org>
	<c4f1b8d4-774f-42c1-a828-42c79756503d@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 11:24:33 +0100
Douglas Raillard <douglas.raillard@arm.com> wrote:

> On 05-08-2025 20:26, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Currently the syscall trace events show each value as hexadecimal, but
> > without adding "0x" it can be confusing:
> > 
> >     sys_write(fd: 4, buf: 0x55c4a1fa9270, count: 44)
> > 
> > Looks like the above write wrote 44 bytes, when in reality it wrote 68
> > bytes.
> > 
> > Add a "0x" for all values greater or equal to 10 to remove the ambiguity.
> > For values less than 10, leave off the "0x" as that just adds noise to the
> > output.  
> 
> I'm on the fence for the value-dependent format. This looks like
> it could easily make life harder for quick&dirty scripts, but then both
> awk's strtonum() and Python's int(x, base=16) seem to handle
> the presence/absence of the 0x prefix so maybe it's a non-issue.

Yes, but the trace file is more for humans than scripts, and the 0x1 is
just noise.

> 
> OTH, a hand-crafted regex designed after a small set of input may start
> to randomly fail if one field unexpectedly goes beyond 10 ...

If you are doing hand crafted scripts, I'd suggest to use tracing
filters or other tooling that can handle this easily ;-)

> 
> Just using explicit hex may be the best here, as the actual proper fix
> (type-level display hints) is harder. It could probably be implemented
> using btf_decl_tag() and __builtin_btf_type_id() to retrieve the BTF info.

That would add a dependency on BTF, which I would like to avoid.

Thanks!

-- Steve

