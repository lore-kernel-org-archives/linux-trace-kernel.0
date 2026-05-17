Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FE395254;
	Sun, 17 May 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023741; cv=none; b=ZP2qdTDAhOghPqlqX7mjnKUnccIq2mJDOXhDlNnIXLYwUKFn+ITiPJBkufoRHzUKryFmChpafcHAsag5Li0X+w8ph30WUWjs3YfOfw+psGspUiA+clkm54mhlYrkjNeZxX/eP3dY25s4JOLwgGUll6yCuFrNmguv9OupmvGYYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023741; c=relaxed/simple;
	bh=CH3UVjKTflNWbQmjvca43WCS7IZ3DbW81iR7z0IwAQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD9ZBUCf3o/NmoMLlQ/NRRlIJdC8z7S27ZDtyODFEfUMVbK1RFReoRqjOkgDVhgCIwV2KR5DsMXjyRxnCPLS2tUpiUKb7QDE3fxNactCV4k+tjkDUV0maBoNHzK9K3EWJKaPKKg/ltJYdSbHhNlPZQngbWyZZ/FneoDvxf453rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CCF821C1869;
	Sun, 17 May 2026 13:15:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2C3462000F;
	Sun, 17 May 2026 13:15:15 +0000 (UTC)
Date: Sun, 17 May 2026 09:15:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Afi0 <capyenglishlite@gmail.com>
Cc: security@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: Race condition in __modify_ftrace_direct() between tmp_ops
 registration and direct_functions hash update
Message-ID: <20260517091510.7ea4cd28@fedora>
In-Reply-To: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>
References: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2C3462000F
X-Stat-Signature: cz4nmr7ycqchb76aonxaio1m3dpijots
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/8Dp5lKj3+zvasumBbm2BwO9CCV6wxJSE=
X-HE-Tag: 1779023715-638126
X-HE-Meta: U2FsdGVkX1+xA3R/0br3bBypSdE46CsNvROsRncOIyLMklREU1nTnEfzws7spuF/ACSjfBTg3WB7AB/LdFHctHp2lNTYSSwuRJR3AQDcsp2BWTC2RzABVCwOvbhmAGGBOHFTw9paSnuaAvpM65GC/b5JbfgrEHGs7q9jUf6caXV9RJOdpjnadwF2kv9JQ9c7305XKJT+iRpQKHJKvz764AafTAEWZAfYIg2w/MZAGFzvOO3Xc6J03UD2NmAq7AanjCbESOBw4XxMX1jpARmlt7ESYHQUW7XbBR2+m/ssxzRe7hdo+t+HkGfmnbjTu/vZooTB90mK1iTUR8kIFxu2einxvFqNls70kVk05/b+C/FuwBgOiGUC+Q==


Added Jiri as he works on this code.

On Sun, 17 May 2026 06:24:11 +0000
Afi0 <capyenglishlite@gmail.com> wrote:

> Hi list,
> 
> Apologies for initially sending only to Greg. Resending to the full list as
> requested.
> ------------------------------
> 
> Component: kernel/trace/ftrace.c Function: __modify_ftrace_direct()
> Affected versions: Linux kernel 5.15+ Type: TOCTOU / Race condition CVSS
> 3.1: AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H - 7.8 (High)
> 
> SUMMARY
> 
> A race condition exists in __modify_ftrace_direct() between the
> registration of tmp_ops into ftrace_ops_list and the subsequent update of
> direct_functions hash entries. During this window, concurrent CPUs
> executing traced functions will read the stale direct call address via
> ftrace_find_rec_direct() and jump to it, while the caller may have already
> invalidated or freed the old trampoline memory.

What the above doesn't describe is how the direct was stale to begin
with. Before the assignment, it should be NULL and not a problem, and
if was being modified, the current trampoline that direct points to
should *NOT* be freed before calling this. Otherwise, that itself is a
bug.

-- Steve


> 
> VULNERABLE CODE
> 
> err = register_ftrace_function_nolock(&tmp_ops);[race window:
> ftrace_ops_list_func now active, direct_functions not yet
> updated]mutex_lock(&ftrace_lock);entry->direct = addr;   /* update
> happens here, too late */mutex_unlock(&ftrace_lock);
> 
> IMPACT
> 
> CPU executing traced function reads stale direct_functions entry during the
> race window. arch_ftrace_set_direct_caller() redirects execution to
> potentially freed or invalidated trampoline memory. Use-after-free in
> executable code context on SMP systems.
> 
> TRIGGER
> 
> Requires CAP_PERFMON or CAP_SYS_ADMIN directly. Also reachable via BPF
> trampolines (kernel/bpf/trampoline.c calls __modify_ftrace_direct()
> internally) with CAP_BPF + CAP_PERFMON, default in many CI/CD container
> runtimes. Live patching via klp_patch_func() also goes through this path.
> 
> SUGGESTED FIX
> 
> Update entry->direct under ftrace_lock BEFORE registering tmp_ops. Add
> smp_wmb() between the store and registration to ensure ordering on
> weakly-ordered architectures.
> 
> Patch attached as 0001-ftrace-fix-race-in-__modify_ftrace_direct.patch
> 
> Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")
> 
> Thanks,
> 
>  Afi0

