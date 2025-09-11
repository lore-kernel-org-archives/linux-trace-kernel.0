Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF512DC762;
	Thu, 11 Sep 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615832; cv=none; b=H/JCSY/2eJ5Sp7amdkzNmnSTXIbnQN1HBnx9jdU28PyAH3TMHuh6GmsRaFxHEBrJ7yKAutaHhUSzN4xFvVIK0kx9Lghd5HssuSRf4nk6HJuGZNiCchC73FvF1je8QlDlOuTlH7y3zVkMDr0kICRRraWLOE8sg2B+4cQI10N14gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615832; c=relaxed/simple;
	bh=78PSPYBp7Vw4VXblfAAIJKtndDigwrJipsUQNflRbFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5PUWLg6bNHl3OK0Zp6lGS7dSPEl8zQserhae+4IfMCVcPLWAueN7oPInoVhN5hCgGFOckyfhjo9fs7E0CMYhCdQSu9n78BDQ+1FZB2qO3zYiuEpaHO9P+VwKTPTBZV2nwf6f+f/4mr/9pUsfSmRXMF7S9lg7cy970imiD/eW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A2EBFB9CE0;
	Thu, 11 Sep 2025 18:37:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D590F20029;
	Thu, 11 Sep 2025 18:37:05 +0000 (UTC)
Date: Thu, 11 Sep 2025 14:37:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: 20250911104138.2830f60b@gandalf.local.home,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <20250911143758.06ef1230@gandalf.local.home>
In-Reply-To: <aMMSCQAINWfiDA4L@vova-pc>
References: <aMLPm__QGrQCwz1t@vova-pc>
	<20250911104138.2830f60b@gandalf.local.home>
	<aMMSCQAINWfiDA4L@vova-pc>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D590F20029
X-Stat-Signature: aumk7ryxc6e36gnf6qha7t834wxwtrxk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//mr01h/8HlkzE4HpKeuqeKk3kRoWaMiM=
X-HE-Tag: 1757615825-527974
X-HE-Meta: U2FsdGVkX19fp3y95D3lHfuz0cy8HtozpYuuHScxzdrsP9gCxnjN+9IpjFA7Qnb/UJeNAZpSgbzUPL0GuxW/vbNHDJUEby4UKP5q2p5g+3DUem99bBi0PC/NL+BLRu5jCiDSPJuN4U7JYjsJhlCIm/a9YG5ynWQTLmsZ8rJEhZ5J6uHtW2Hw3fESCPF6zOxCTTYnmbYurjnys+xBGdncosaGpFH370F59ezlSH5GLVfq1E85gzqsDPZTnv8DOgVbYS+blYyf5jPGY4Lwv6TD7umswWmHfjK5LQ1i9gKsHQl4kSawDMDFd0DxTTAHzAmas552Bjfh3hKeOFspyu2+d5LDrk5Gv1IP

On Thu, 11 Sep 2025 20:16:41 +0200
Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:

> On Thu, Sep 11, 2025 at 10:41:38AM -0400, Steven Rostedt wrote:
> > On Thu, 11 Sep 2025 15:33:15 +0200
> > Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:
> >   
> > > A soft lockup was observed when loading amdgpu module,  
> > 
> > I'd like to see more about that soft lockup.  
> Sure, here is a call trace:

Thanks, because this helps out a lot in understanding this!


> [  397.861521] [      C1]  <TASK>
> [  397.861562] [      C1]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [  397.861663] [      C1]  ? find_kallsyms_symbol+0x1c5/0x350
> [  397.861739] [      C1]  ? __asan_load4+0x35/0xd0
> [  397.861806] [      C1]  find_kallsyms_symbol+0x1c5/0x350
> [  397.861879] [      C1]  ? mod_hdcp_hdcp2_dp_transition+0x1140/0x1140 [amdgpu]
> [  397.864007] [      C1]  ? __pfx_CalculatePrefetchSchedule.isra.0+0x10/0x10 [amdgpu]
> [  397.868240] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
> [  397.872439] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
> [  397.876605] [      C1]  module_address_lookup+0x7f/0xd0
> [  397.878686] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
> [  397.882809] [      C1]  kallsyms_lookup_buildid+0xf8/0x190
> [  397.884811] [      C1]  kallsyms_lookup+0x14/0x30
> [  397.886734] [      C1]  test_for_valid_rec+0xcf/0x160

As you pointed out below, the test_for_valid_rec() looks to be the culprit.
Most likely because of the kallsyms lookup it's doing. Which requires a
search. It's binary, but still quite expensive when executed over 10
thousand times.


> > How big is the amdgpu driver? How many functions does it have?
> > 
> >  # grep amdgpu /sys/kernel/tracing/available_filter_functions | wc -l  
> 14334 functions, hefty one.

And why this is a problem.

> > 
> > And I'm guessing that this is only an issue when ftrace is enabled:
> > 
> > 		if (ftrace_start_up && cnt) {
> > 			int failed = __ftrace_replace_code(rec, 1);
> > 			if (failed) {
> > 				ftrace_bug(failed, rec);
> > 				goto out_loop;
> > 			}
> > 		}
> > 
> > As that could slow things down.  
> Call trace shows that kernel got stuck in test_for_valid_rec. It calls
> kallsyms_lookup, which then calls module_address_lookup,
> bpf_address_lookup and ftrace_mod_address_lookup. All of these guys hold
> RCU read lock or disable preemption and may consume some time (mostly
> because of debug kernel checks, but still there shouldn't be a panic).

Agreed. The kallsyms lookup is the problem
> 
> Probably it may worth moving cond_resched under within_module check, but
> before test_for_valid_rec call.

Hmm, do modules even have weak functions? If they don't then that test is
useless.

-- Steve

