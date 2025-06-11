Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0623A99D;
	Wed, 11 Jun 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653197; cv=none; b=s0zbR/2p6/YRrYltCrI6jl2HPWtMYeaIgyZJBXqV6BZ78A3p6VQKrcBqkCl0EskmPEuqarJc44zW+RCGqpop9rSJFkrrtg2eU8jh4TBdGmlqxA8aUr8Zb7KUckNhKYXGv+3S6zxPYMYoxBrKz854oYHrXsyby9zwrYTmwf2RFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653197; c=relaxed/simple;
	bh=4/hh4YENcSHGUjgQwEQhru/Zqy1vGFCLZ+lEog3Di/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C88Kb5/T8aZtiQrnKQgW/JKmwvHW061T0nsXCM+pJUO9T9F2tG8RuFrepvexkw8PqjMCw6jcDW8xLTirTFnBe/oosVrtCDF4bzpGqGybOGqcxysqohluxINE0gZYM+G0FFjTHf4BcZFjzyxt83we40ux1yDVJYI12Zz+PBFObR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7kOC6M9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7kOC6M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98F3C4CEEA;
	Wed, 11 Jun 2025 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653195;
	bh=4/hh4YENcSHGUjgQwEQhru/Zqy1vGFCLZ+lEog3Di/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7kOC6M9BQy5wO8h6teMI1mbyDvpKlbgKXL7Wjl4Yn5ldM65KlFHsnK9CBh7fz/T2
	 N5k5Ka7jG5l3i/gilNG0WVE6k17Oi6ef1yYsrDk0BhLS00+SAXaHuHihGlnYlI32rv
	 sMWtrpmmzSYptMWLK9X1jNXSSqc12z/VVCoL8ZjpppSDp8MfnZwNgf+NAt8KW0fmf9
	 P3g7TPZTB9BT4Aaqrro8IEVXsz3MnzZixRQzRGAqy3LxPDqZBBupn4TjJSq5eJG0yK
	 QCiswNVxjHpa7l/A6s7k62RtfsQnm4y4LQHtEQ+RB1mXN+reXcqlhkqbiZqGuABMJO
	 GJoW+M7Q52sFQ==
Date: Wed, 11 Jun 2025 11:46:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>, Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH 0/8] rtla/timerlat: Support actions on threshold and on
 end
Message-ID: <aEmWyPqQw2Ly7Jlu@x1>
References: <20250611135644.219127-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611135644.219127-1-tglozar@redhat.com>

On Wed, Jun 11, 2025 at 03:56:36PM +0200, Tomas Glozar wrote:
> This series adds a feature that allows to user to specify certain
> kinds of "actions" to be executed at one of two places in the rtla
> measurement: when tracing is stopped on latency threshold, and at the
> end of tracing.
 
> Two new options are added: -A/--on-threshold, and -N/--on-end, taking
> the action as an argument. For example:

I wouldn't add -A and -N, leaving just the long options, as it documents
scripts (and we should have autocomplete as well), leaving the one
letter options for things that are used super frequently, which could be
these new options, after a while, time will tell :-)

But I see that "A"ction connection, and since you show it is used
multiple times in a single command line, maybe its warranted the
one-letter option.
 
> $ rtla timerlat hist -T 10 -A shell,command="echo Threshold" \
> -N shell,command="echo Tracing stopped"
 
> will print "Threshold" if a thread latency higher than 10 microseconds
> is reached, and "Tracing stopped" always at the end.
 
> The list of possible actions is extensible and is covered in
> the commit messages. Later, a documentation patch series will be sent
> with clear explanation of every action and its syntax.

I think having the documentation together with the new options is
desirable.
 
> Notably, a special action "continue" resumes tracing. For example:
 
> $ rtla timerlat hist -T 100 -A shell,command="echo Threshold" \
> -A continue -d 10s

so --on-threshold ends up being a list of things to do when the
threshold is hit?
 
> will print "Threshold" as many times as tracing is stopped after
> thread latency reaches 100us.

> The feature was inspired by a case where collecting perf data on rtla
> latency overflow was required, which can be done by sending a signal
> to the perf process.
 
> Example of this with Intel PT aux buffer:
 
> $ perf record --cpu 0 -e intel_pt// -S -- rtla timerlat top -q -T 100 \
> -c 0 -A signal,pid=parent,num=12 -A continue
 
> In general, the feature is aiming to allow integration with external
> tooling. To implement even more flexibility, passing context to the
> shell through environmental variables, or even an entire scripting
> language with access to the rtla internals can be implemented if
> needed.

That is an interesting example of cross-tool integration using existing
mechanisms for detecting special events and asking for hardware tracing
snapshots, good stuff!

At some point we need to have this signalling to not involve userspace,
shortcircuiting the snapshot request closer to the event of interest,
inside the kernel.

- Arnaldo
 
> Tomas Glozar (8):
>   rtla/timerlat: Introduce enum timerlat_tracing_mode
>   rtla/timerlat: Add action on threshold feature
>   rtla/timerlat_bpf: Allow resuming tracing
>   rtla/timerlat: Add continue action
>   rtla/timerlat: Add action on end feature
>   rtla/tests: Check rtla output with grep
>   rtla/tests: Add tests for actions
>   rtla/tests: Limit duration to maximum of 10s
> 
>  tools/tracing/rtla/src/Build           |   1 +
>  tools/tracing/rtla/src/actions.c       | 260 +++++++++++++++++++++++++
>  tools/tracing/rtla/src/actions.h       |  52 +++++
>  tools/tracing/rtla/src/timerlat.bpf.c  |  13 +-
>  tools/tracing/rtla/src/timerlat.c      |  24 ++-
>  tools/tracing/rtla/src/timerlat.h      |  24 ++-
>  tools/tracing/rtla/src/timerlat_bpf.c  |  13 ++
>  tools/tracing/rtla/src/timerlat_bpf.h  |   3 +
>  tools/tracing/rtla/src/timerlat_hist.c | 145 ++++++++++----
>  tools/tracing/rtla/src/timerlat_top.c  | 167 ++++++++++------
>  tools/tracing/rtla/tests/engine.sh     |  21 +-
>  tools/tracing/rtla/tests/hwnoise.t     |   8 +-
>  tools/tracing/rtla/tests/osnoise.t     |   4 +-
>  tools/tracing/rtla/tests/timerlat.t    |  36 +++-
>  14 files changed, 652 insertions(+), 119 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/actions.c
>  create mode 100644 tools/tracing/rtla/src/actions.h
> 
> -- 
> 2.49.0
