Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D63FE650
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007016; cv=none; b=nbGGUFu/ZvHelmBtJieD9LAubV37RC66+H50Yhm+LBdc2vcXiTXWS2f7hgUkwS/XJafS12+mJRq3kS1jioKEphirZoSELEXZyZGt67zsgHQcKW9DXZTpQ1LsXmp7UbJ0GX7+m6spKcY9BcGPgrgI9gqSCxtW07qUbAVxi8qSDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007016; c=relaxed/simple;
	bh=h4aj1IilD23SRWn3mGaYFVykc4NVqydsOPXkEWM57y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TMlY2zkL+PP7T0/U6Y1GFPiTIPFIUTBHS/S/d1ysTx+9J4+/c59ZU2OcZIWHOsW4S0OLLrUd17NwPwKCcw/lPS7YcgTJvMY+1bD+fIIAVwF3ILLjvbth1sFj+84bgJipPc2YBDwb8M93PT919IGLizFtos2spY7a6uFqMTdjkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMcDOfVc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMcDOfVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781007014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2vIGKqT4NvdBhXm3fnB9ZjVqhF3ohtRz7d+loqyqUDY=;
	b=PMcDOfVcDQFBbZgLlezKY/u9mHPy2cSA/hg2GLNFUUg+kXNhKTgTgvzTLnz520g3Pe+10s
	+tpKnYVxgR5F+OYC93NOpxF6skb2siEJ4jCUK3crRXKwlisotlVKnToa1EM1FVJ/aPAGVh
	uxGa8QVrcU55CbPQpp51spWVyYuXIUM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-VUb_FKhnOhiQTHwe49wU7g-1; Tue,
 09 Jun 2026 08:10:12 -0400
X-MC-Unique: VUb_FKhnOhiQTHwe49wU7g-1
X-Mimecast-MFC-AGG-ID: VUb_FKhnOhiQTHwe49wU7g_1781007010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74380195C26B;
	Tue,  9 Jun 2026 12:10:10 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.64.147])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 15CAC195419E;
	Tue,  9 Jun 2026 12:10:05 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:10:04 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] rtla: Migrate to libsubcmd for command line
 option parsing
Message-ID: <aigCf7GmPAomxxMN@wcosta-defaultstring.rmtbr.csb>
References: <20260521141833.2353025-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260521141833.2353025-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 2ldA-SvqQM5JyO23IX9EJSSMlDfP9GtU1VVodsvJOFA_1781007010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2026 at 04:18:27PM +0200, Tomas Glozar wrote:
> [ CC to linux-perf-users for the libsubcmd code changes ]
> 
> rtla currently uses its own implementation that uses getopt_long() to
> parse command-line arguments.
> 
> Migrate rtla to use libsubcmd for command line argument parsing,
> similarly to what is already done by other tools like perf, bpftool,
> and objtool. Among other benefits, this allows help messages to be
> generated automatically rather than having to be typed out manually
> for each tool.
> 
> libsubcmd is extended with a flag to parse optarg from separate
> argument if a new flag is turned on. Without the flag, the old behavior
> is preserved. That keeps the parsing working for tools that use
> positional arguments, and allows RTLA to keep its flexible syntax for -C
> and -t options and their long variants, --cgroup and --trace-output.
> Another flag is added to disable automatic definition of --no-xy for
> every option --xy and vice versa, which overlaps for RTLA's --irq and
> --thread options.
> 
> The new implementation is moved into a separate file, cli.c, together
> with a tiny header counterpart, cli.h. This helps separate the parsing
> logic, which has little in common with the rest of RTLA, in a separate
> module. Another new file, cli_p.h, is used as a private header to contain
> macros and static function declarations that are also used by unit tests
> next to cli.c, but should not be imported from elsewhere.
> 
> Macros to generate struct option array fields for libsubcmd's
> parse_args() are used to preserve the consolidation of argument parsing
> code across different RTLA tools. Kernel and user threads are, as
> an exception, treated as common, although they are currently implemented
> for timerlat only, in line with earlier consolidation changes.
> 
> The test suite is expanded to include two levels of unit tests, one testing
> the already existing tool_parse_args() functions, one tests option callbacks,
> which are a new level of the CLI parser added in this patchset. This helps
> to verify that no regressions are caused by this refactoring.
> 
> I expect more improvements to the code being possible in the future,
> like creating macros for option groups to further deduplicate the code,
> reducing the amount of extra code in the _parse_args() functions, or
> implementing support for unsetting options (which is currently only
> supported for those that do not use a custom callback).
> 
> v2 changes:
> - Two unit test suites are added to cover regressions, after several
> options were broken by the v1. The test suites cover all parsing
> issues reported in the v1 as well as those found during additional
> testing.
> - Return value of all paths that print help, including those that
> are handled in RTLA, are set to libsubcmd's help exit code of 129.
> Previously, only the tool help returned 129. While some other tools
> (e.g. bpftool) do that, RTLA unifies those for consistency. The return
> value is also added to the corresponding section in documentation.
> - Incorrect parsing of --no-irq and --no-thread is fixed using a newly
> added libsubcmd option flag.
> - Incorrect parsing of -n and -u timerlat options (which erroneously
> required an argument in v1) is fixed.
> - A now stale declaration of removed function common_parse_options()
> is removed from common.h.
> - Segmentation fault on abbreviated --help (e.g. --he) is fixed.
> - Incorrect formatting of OPT_END macro (spurious tab) is fixed.
> - All opt_* callbacks now reject unimplemented unset (--no-) correctly.
> - opt_trigger_cb() and opt_filter_cb() now take only the required events
> field, not the whole params structure.
> - Spurious opt_osnoise_threshold_cb() which is actually just a wrapper for
> opt_llong_callback() is removed.
> - Old off-by-one typo is fixed in --dma-latency and -E/--entries error
> messages, to make it consistent with the newly added unit tests.
> - Fix a bug in Makefile that defined LIBSUBCMD_INCLUDES as -I... and then
> used it as a target name: define it as the path only, and then add -I$(...)
> to CFLAGS, as this is the only include path that is generated during the build
> itself.
> 
> v1: https://lore.kernel.org/linux-trace-kernel/20260320150651.51057-1-tglozar@redhat.com/T
> 
> Tomas Glozar (6):
>   rtla: Add libsubcmd dependency
>   tools subcmd: support optarg as separate argument
>   tools subcmd: allow parsing distinct --opt and --no-opt
>   rtla: Parse cmdline using libsubcmd
>   rtla/tests: Add unit tests for _parse_args() functions
>   rtla/tests: Add unit tests for CLI option callbacks

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

