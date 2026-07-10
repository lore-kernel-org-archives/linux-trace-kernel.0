Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0003B777F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718634; cv=pass; b=rZii7FVIlA+MGulPTYkV5tMBN0AeOIQZU0eE1B+48olg6rqPI+uVA2TCdlPg3h23jsrQdVqe6CI/R0slLIOpFqtjxO7HGPuM6JjwP9Z4Wk68wWgjubxUeZnHbZJ/e2mP/5L+Y06KeTF6CvP2GOA1MvRpf+moLol4EDqaj36gzOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718634; c=relaxed/simple;
	bh=ZffsXEKRzy6BPrYFDZBFjLeefjvojwkwyzHgCSgBeJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByDxLH79LjsL3vZX7sfmQDceWMgt+03FtVceCtYPqMwiozI4pKJM9DRoVyaOt8XFQGYuu3GYfNlXR0DYWwlZ8xOVYFUH1ijWMrCWfnU+UUnno6Dh4dJkf5DBJ7iaK5Q8c6CO0fR4+HPWgyWQIz6wUFht7ma0L1CHqsOR/beeKxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfiEZkVR; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfiEZkVR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so1093527a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 14:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718632; cv=none;
        d=google.com; s=arc-20260327;
        b=ft5+r8Jm7ZjCp9wbJmB9Uoq3TrTL+Bn7wyoHfnB9b6xbzg1jJ3TfwcjupJ87asVpo5
         E1epoky/55shP0BHWhd7B1lHRqGVN+IfuriKDxxBA2hwBqKIVYo6tXCXSGfuBimVSwW4
         AromObHVdyYMNKqvbqk2RfSRwcDLpN/ogkgYNpauEOUrDKFimLMU/qJSbs2JZSe1fwxp
         70fSviyLZBnDKmhyIGEf+7RoTwOVKvOCc42IymktLqe+aY7hez6h9TSR6VKRElSGqwfG
         iNXFUfGAlvf1OBBIar1EWIMD60HEEK91pPkrq2fumaJaOc7ztfovVPls/BpugCdWGsGV
         IRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        fh=7tstnQRU/zRaAtD8+oWb3p+0LLqUE+GFGjUxJ+n7QmE=;
        b=LbQ9zKcJuEkWXt8DSEYhfURCK5m1gfcbgnHQe0gErdwUdT4Gybs6reh7+bBDULwBS3
         pyRDw+qQFkQGAk+s+f3wUx51P9z8ju/TPI3c4YngvgVP1Mzrvk671LJL9lHTcDHkVFqO
         6tzJwaz9cL0PO3sUzJPFIrQzAJ39LnM2tfkIkdLr8+kz9ETW3+6FA63YrdIIt3IUK3Bc
         MHTSGj9PX/SAS9CnSfh5zFe2DmQ0h9FDGevNRVfMqj+5me6PajazNhp7/RrHFLi37wzK
         L2iOVo8gdqI9uWFm5RxyrUCcXBb3iGDGVIMdTqosXAxcHL54W2lh45zWSm3YCvy7+xMa
         lblw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718632; x=1784323432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=gfiEZkVRkxY3zvcQlPbas/3Cycw47n3fcFyJ5mfu46UrrgcTvkI0356jgCEZcaZafW
         X6cbSUJanZS0Mo6YOChyU/8CzukJyrdbK3RXgTB3KdWymKLh2qd67PwMA3WpUcZFIW10
         r6wgLSZ8WUnZACqQ8DlT2qkuqJSTPx1a/HQ0pI4+wbP48h1SofJJoDlHNaEiGr+1iRpp
         oSALXPlMh62CoSf+dubbQCWTGgAZMRWYEEfE+hs9vLnezx0k6tktUQL31TPkHk/465HC
         I7VEdO3fKkg/syWpwHvbBCjr2Ykni/j2Zgp9pmCrXJssapi1k2eceXGm5OYVZMRwLIcE
         ioQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718632; x=1784323432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3OYMFo4gk2Qm3Y1GCk0JrLQvP6s+kDSI3H/HQZhhkE=;
        b=pbyY1Hl6EykyEpynRZbV7+WcqvSPlQei85CzghK9TSBU/S790BU5C8mx31o5zV7kWf
         ceuXzQaV+iobnmXZtASH91B2ThjlYDmDZGC0T3Xb9uhmIMsnVEMzOKwvj/cshENJPM3c
         xEuZrNmq+tCfCJVoLGxNXA68Qi3NojLxOcSFJFMIaU4jEIsU4fz7aWP1DxZLwFmd6RWd
         WGaJbo1oGKxlzZtY085FyPkPZ9j0YXdwSClZVRZJV7YICdqHeMhcB1M0z6WgvJgr4N4f
         A8gOGoNlfyhy/ynVQbVCqJX0DJtBnxndco8AYe/3wZYjWhrQoIksY2L8ISRqmBesZdm1
         nAVg==
X-Forwarded-Encrypted: i=1; AHgh+RpngFTjsIf3Uw5bJJ481TDP2/WQFOdMAccIAeOdHRGKPhaXMrYu/nEQVjzuMz8rDSGWq4K80w+JzmGTs6Clg8Z4hVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqSBClVdCmV5/m0pWjhltdRr1qsICk+roXYYYxtoAzSGmRi0X
	T8l2bQxpzrYFuuUSwRolrbbWy6Vz8hhmbMZv8m/in+JMTzmo+v2AP5MwOF8tC5vRM6dLhImQQLP
	BjSrXxK9rev8CVXQ0I3QIuv0He2oe2b8=
X-Gm-Gg: AfdE7ckDadg08FjBGn/1YhfTOSThO/ahsAdwq1eYLQQLCSLZ9Ae6OaDOP0eK6CIkMsQ
	b8Bzfns6bMwI5phGGaVNBUF+AyqqU+O36UBl76+QjWt4E35FBwRxhASdZJ+JWexnz2L2mTf9nS4
	aTjurgxyUHjjQKQETENN9jtrpXMl+b3nAh+fDbwullsrPdmXPvygI0H7TqfbTxyDEzRTR0VNaJJ
	X4R0DBhohXP3vQYmrns8hp1wVBS+bzyBGOPsxp65N4E9h0gG2nx9Z8ExSXEtD8eivpAcyV6q1vJ
	gFHFaxbWcEz7wDIpFNdEnAggHAu6q8tWau5m8cG5iIVj45UNrPXxWQ==
X-Received: by 2002:a17:90b:5903:b0:37f:9e21:91d8 with SMTP id
 98e67ed59e1d1-38dc834de8fmr359486a91.15.1783718632544; Fri, 10 Jul 2026
 14:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706172744.3920417-1-puranjay@kernel.org> <20260706172744.3920417-3-puranjay@kernel.org>
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:23:39 -0700
X-Gm-Features: AVVi8CeESE7KrO4SofyyKXRIq0UuNC-RWDudhRYzrwkmSGZKKMPllM8AreG8cCk
Message-ID: <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to SRCU-fast-updown
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> uretprobes_srcu currently uses normal SRCU, which issues
> two smp_mb() per read lock/unlock pair. This overhead is
> paid on every uretprobe hit.
>
> Switch to SRCU-fast-updown, which eliminates the per-reader
> memory barriers by moving the ordering cost to the
> grace-period side (synchronize_rcu() instead of smp_mb()).
> This is acceptable because grace periods (uprobe
> unregistration) are infrequent compared to reader-side
> uretprobe hits.
>
> The updown flavor is required because the SRCU read lock is
> taken in prepare_uretprobe() when a return instance is
> created and is held until that return instance is finalized.
> The traced thread returns to user space in between, so the
> lock is inherently released in a different context from
> where it was acquired: on the normal return path via
> uprobe_handle_trampoline() -> hprobe_finalize(), or from
> ri_timer() (expiry) or dup_utask() (fork) via
> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
> are designed for this acquire-here / release-elsewhere
> pattern and, unlike the same-context srcu_read_lock_fast()
> variant, do not carry the lockdep read-side tracking that
> would warn on it.
>
> The short, same-context SRCU sections in ri_timer() and
> dup_utask() (which guard the uprobe against reuse across the
> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
> for proper lockdep coverage.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++--
>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>

Very straightforward replacement and will improve performance, thanks!
LGTM. Peter or Mingo, I assume you guys will want to route this
through your tip tree, right?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
