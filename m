Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A940F8E6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007145; cv=none; b=WnTRJhHtHd8EZbpKm8goSijl9CaWchiCWk2uTWwBnxjAMkzX9YtBSpr8581dmIzCNU0BHlMYxw6FvZFv0npFcveTGxP1EjhF9bwyK4bE4x933ZPx5rPEk5VCTtwvVAjbzp9fHit/ldYRLNGjZ6hSFNox9dm0F8Nm4Mjj+FtZeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007145; c=relaxed/simple;
	bh=kQNeA9EENj1YAtM4fEP+zi0XeDBvMta3HDRVyq0W5AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ws3FOVWDwq1m6fzp0Q7C8H2JEl1Ch4i3UNIqtsM7E2I19cikA6rqSNvX95SiT5IdwO75gyTi8OKz9jr26krMLaPEsOHdJ+PTITe9Gk5I9Wkm9ZVqsSdWmW8Wi6eLw9itZJPMJpEefTWBnmmJlSZqSZhDR2MCtREER7MItPab1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYWBYASu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYWBYASu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781007142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZamH9fWG/8PnwimSoG6hhrEwCuHOo2qBwn+wgNnhIxU=;
	b=NYWBYASux9f28GHEgHDHKb07Tc71e7askaoGGkNUikdSJzEPtutOmeBjIPnZlFTiR4OnI5
	p/3kZgz2/LFRW1ShOj0zOt07M7LDEcWToMjnn2i8qkXBjXu1tlFQ6HPtXxWFkQE5rclQPM
	lhv1L38Bnl5LfMXAmkU1mjMAbrkrHk0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-qi0xqxhvNq-hwvw_F1Vk7A-1; Tue,
 09 Jun 2026 08:12:19 -0400
X-MC-Unique: qi0xqxhvNq-hwvw_F1Vk7A-1
X-Mimecast-MFC-AGG-ID: qi0xqxhvNq-hwvw_F1Vk7A_1781007138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F6E11801303;
	Tue,  9 Jun 2026 12:12:18 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.64.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA38C19560AB;
	Tue,  9 Jun 2026 12:12:13 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:12:12 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] rtla: Migrate to libsubcmd for command line
 option parsing
Message-ID: <aigC7WP0J2935SV5@wcosta-defaultstring.rmtbr.csb>
References: <20260528103254.2990068-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260528103254.2990068-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: OSc8x8sX93PNIvnMU-EivXvLnb_J42EWTexgK_a8QeA_1781007138
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 12:32:48PM +0200, Tomas Glozar wrote:
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
> Base commit:
> - https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/commit/?h=rtla-for-next&id=f03a59f949176ce4312cb466245d1243aaf40389
> 
> Dependencies:
> - https://lore.kernel.org/linux-trace-kernel/20260423130558.882022-1-tglozar@redhat.com/T/
> - https://lore.kernel.org/linux-trace-kernel/20260424140244.958495-1-tglozar@redhat.com/
> - https://lore.kernel.org/linux-trace-kernel/20260414185223.65353-1-costa.shul@redhat.com/
> (apply in reverse order, alternatively, use base commit above)
> 
> v3 changes (all in cover letter or first commit):
> - Add FORCE to all targets that feature a make subcommand to ensure changes
> in the dependency will trigger rebuild correctly.
> - Convert all dependencies on directory targets LIBSUBCMD_OUTPUT and
> LIB_OUTPUT into order-only prerequisites to prevent modifications of
> the directory content triggering rebuild of targets inside it.
> - Properly mention depedencies of the patchset in the cover letter, as well
> as the base commit.
> 
> v2: https://lore.kernel.org/linux-trace-kernel/20260521141833.2353025-1-tglozar@redhat.com/T/
> 

Oops. I mistakenly added the reviewed-by tag to the v2 patch series.

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

