Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3E208982;
	Tue,  3 Dec 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258353; cv=none; b=dJH2IQlAk/EzJQfNr+ARD3UJ5var3+BkMuD3mR0ZV7FMtNLs4W7vVBVP3aXHtwBskjcHdICURnBmGRZp5IsE8twjamvxomYJtxH+EAHFwxTjUMJMenkzqYHq9ys8dHjMlNRtsHbxqjbPecd8WGQkUuiQMCmrJGVimN4V49ZbvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258353; c=relaxed/simple;
	bh=/9P92wCF880VisHrXcy2bp+E18d6UEUGJvSQuZ9XXrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxxnPRF2kdyLa96q+b8w/ua7Lyt4w8nl1K3mhoYkc+jy3ITjVbERH4FqfnKPQnGVEpa/Ml8Z43rrcP6rkoFP0Dr26G7luDN59z8NGakI9PLe5vpYjOQgUOT8uJYZApkD6OdwtndeQ45YC8DEqkPXoaVanHAWyi5H2gLJn2v0Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbFiBiFt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFiBiFt"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee345c1bbdso4362039a91.1;
        Tue, 03 Dec 2024 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733258351; x=1733863151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtzZsQrmindvQAs4uttAxLyfBfsBUOVAjG8uY/n8w3w=;
        b=YbFiBiFtB5It2k57o7Eh4wKF3MYauY7oNCEQQ8NIB6BXnCYjymjRsfgf77+l1c+alQ
         UxsXggScqQYxDcPwsYR8sdoLL9GJF2AIaO5BkOYC3PNUKezQ3Xwqzic6cYQf+K+oDgO/
         KFxN+9VLHvWnIC7d5XOAwa4jgWTrHkXjpyXR6eXVK2IWdsvjelnwJHTKXjvfsZVwc7R2
         ZhUu89WGctLlw++PpPxdeg7U+Sohx1Pho0ixFVxQGtfeKwI33NXbE0G3BYaOpofmIsiA
         xrVCL7p3EbjrLHRmrtt6SGRZTSVpS4TLG8zD/s6PUtr074cRuX/g+iYZlnteJySvImQL
         QNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258351; x=1733863151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtzZsQrmindvQAs4uttAxLyfBfsBUOVAjG8uY/n8w3w=;
        b=FXLMW2D/tq+91JLM6zSHx1CTWyjbUuzsvfNhMBM2DHwQm+Y1cio/AGRemxmp2keZrT
         uc7+KS7tlDJcqCzBoGACQaFgTp14PB0IdL6u+x7hZ/asQSQh9WChsYLhNToJ7Hn/3MKD
         qOw5kEqZyPlKWPy/jDCTZRbgTfoSfu0z11aH/8Q69Wm3zCC/HXpOe9SdazgmpaHhbrRf
         glHdEnEnm0XQuYnnWynzsVlU0KMmtlKXcrzayn9g21X9sVl9xuEp8F4mpi3a7TbIbM6H
         ddGC0IRudiWNKt8SU5rFaxqlxCZMbGMGFKy6QW1EvZvVqOQqEVrRCxtw+PiihWvKXxKC
         uAbg==
X-Forwarded-Encrypted: i=1; AJvYcCXYk+mnLuz2lDoOo46UBMDT0gvEEsxzpwtpunzEdGLdFdunZX7YWQNHBa3xotOg8eomeZuoupjTmfusyknNgvimAmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBy6paMUrJ8yqPfoGCMaCwnpxX+iJjsdWkDXQTdUXp7hSdw4P3
	419lJbpJqAV6sgcJkT5SeUWXUvu8TbrFKGnbeIIPLNWvTBQKf9Im
X-Gm-Gg: ASbGncuMVCgw7SubfCKtW6azWT5jyb8HXMck88tu19J86eGqti239a6sqVFYQuC0JSh
	S0VEiui+5ntKDeIqWOg02hBlj1yjYOq5RlxUs69zhVtXSFa+SlDm5cH3kScMk1UP+jpbPCYvlER
	unehnEM0UoTHba0RBAi4H/4gV5E07fOiUSJVXKEpT9H4X2eaCPd2KmqJpHG+pqJA7MMoQN3g6zl
	92LsaPPrjkLgXKTS8k6m5+Zao9FG7Fwm/r4YNSZsFpIVwsYTWyqmGh2327EGkk=
X-Google-Smtp-Source: AGHT+IEXF0Ez3hehsX/VcpAzi8CDGNZ3el062iIpeGfv74SK8qccLCYIwA2O5Ns9OonAoFiYtQvbCw==
X-Received: by 2002:a17:90b:4c8b:b0:2ee:ab29:1a65 with SMTP id 98e67ed59e1d1-2ef011e36a9mr5286703a91.4.1733258350560;
        Tue, 03 Dec 2024 12:39:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee8a80bbb9sm6555977a91.39.2024.12.03.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:39:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Dec 2024 12:39:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] tracing: Remove definition of trace_*_rcuidle()
Message-ID: <bddb02de-957a-4df5-8e77-829f55728ea2@roeck-us.net>
References: <20241003181629.36209057@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003181629.36209057@gandalf.local.home>

Hi Steven,

On Thu, Oct 03, 2024 at 06:16:29PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace_*_rcuidle() variant of a tracepoint was to handle places where a
> tracepoint was located but RCU was not "watching". All those locations
> have been removed, and RCU should be watching where all tracepoints are
> located. We can now remove the trace_*_rcuidle() variant.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

This patch triggers backtraces with mips qemu emulations.

WARNING: CPU: 0 PID: 0 at include/trace/events/preemptirq.h:36 handle_int+0x128/0x178
RCU not watching for tracepoint
...
Call Trace:
[<ffffffff8012a89c>] show_stack+0x64/0x158
[<ffffffff8011e998>] dump_stack_lvl+0xb4/0x128
[<ffffffff801550f4>] __warn+0xa4/0x1f8
[<ffffffff80155328>] warn_slowpath_fmt+0xe0/0x1d0
[<ffffffff801233e8>] handle_int+0x128/0x178
[<ffffffff80f25ff8>] r4k_wait+0x30/0x40
[<ffffffff80f26448>] default_idle_call+0xa0/0x330
[<ffffffff801b6ccc>] do_idle+0xe4/0x1b8
[<ffffffff801b71c4>] cpu_startup_entry+0x34/0x48
[<ffffffff80f2689c>] kernel_init+0x0/0x110

WARNING: CPU: 0 PID: 0 at include/trace/events/preemptirq.h:40 trace_hardirqs_on+0x184/0x240
RCU not watching for tracepoint
...
Call Trace:
[<ffffffff8012a89c>] show_stack+0x64/0x158
[<ffffffff8011e998>] dump_stack_lvl+0xb4/0x128
[<ffffffff801550f4>] __warn+0xa4/0x1f8
[<ffffffff80155328>] warn_slowpath_fmt+0xe0/0x1d0
[<ffffffff8028fb74>] trace_hardirqs_on+0x184/0x240
[<ffffffff80123030>] restore_partial+0x6c/0x13c

Bisect log is attached.

Guenter

---
# bad: [f6420e2ee9caa3ecf226d0db22572db0d9451977] Merge branch 'fixes-v6.13' into testing
# good: [adc218676eef25575469234709c2d87185ca223a] Linux 6.12
git bisect start 'f6420e2ee9ca' 'v6.12'
# good: [6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7] Merge tag 'bpf-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good 6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7
# good: [071b34dcf71523a559b6c39f5d21a268a9531b50] Merge tag 'sound-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 071b34dcf71523a559b6c39f5d21a268a9531b50
# good: [8a07b2623e7ff04856f8d4470d002675049b2065] Merge tag 'drm-misc-next-2024-10-31' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
git bisect good 8a07b2623e7ff04856f8d4470d002675049b2065
# bad: [80739fd00c7ea1315d362ce889bef499452913ef] Merge tag 'mfd-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect bad 80739fd00c7ea1315d362ce889bef499452913ef
# good: [e175800137f588688ac6aae30ce491e098f30c45] Merge tag 'exynos-drm-next-for-v6.13-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-next
git bisect good e175800137f588688ac6aae30ce491e098f30c45
# good: [ade5add00da20de40f63d097345bddea24d924f4] Merge tag 'amd-drm-next-6.13-2024-11-15' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good ade5add00da20de40f63d097345bddea24d924f4
# bad: [06afb0f36106ecb839c5e2509905e68c1e2677de] Merge tag 'trace-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect bad 06afb0f36106ecb839c5e2509905e68c1e2677de
# good: [f1db825805d48cee6826b7dc082a04112c1f0c8d] Merge tag 'trace-ring-buffer-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good f1db825805d48cee6826b7dc082a04112c1f0c8d
# bad: [61c6fefa92bb4ed7a34163b94f6ffac628237a29] bpf: decouple BPF link/attach hook and BPF program sleepable semantics
git bisect bad 61c6fefa92bb4ed7a34163b94f6ffac628237a29
# bad: [cdb537ac417938408ee819992f432c410f2d01a2] tracing/perf: Add might_fault check to syscall probes
git bisect bad cdb537ac417938408ee819992f432c410f2d01a2
# bad: [e53244e2c8931f9e80c1841293aea86ef8ad32a3] tracepoint: Remove SRCU protection
git bisect bad e53244e2c8931f9e80c1841293aea86ef8ad32a3
# good: [49e4154f4b16345da5e219b23ed9737a6e735bc1] tracing: Remove TRACE_EVENT_FL_FILTERED logic
git bisect good 49e4154f4b16345da5e219b23ed9737a6e735bc1
# bad: [48bcda6848232667f13b4e97588de488c83c37d4] tracing: Remove definition of trace_*_rcuidle()
git bisect bad 48bcda6848232667f13b4e97588de488c83c37d4
# good: [4a8840af5f53f2902eba91130fae650879f18e7a] tracepoints: Use new static branch API
git bisect good 4a8840af5f53f2902eba91130fae650879f18e7a
# first bad commit: [48bcda6848232667f13b4e97588de488c83c37d4] tracing: Remove definition of trace_*_rcuidle()
