Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303E26C3BF;
	Thu, 10 Jul 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155124; cv=none; b=D0ryZ+f7SalxcdkktW/clHRfYxcLAehlc1NmHYqbg9Z4hFdJueTbUgccddIqzEcGvKC/dhAm4nvLSteqBHI6rsy+5txItxj6H42IzmBh8hbYhJcMEY81HDrkAj8A629euip1yZweylEJ7xd+HTa9rA1IpH/Vee5/BdevfyOdApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155124; c=relaxed/simple;
	bh=f2/LXuhJ/TZJeNZpkkOZvoUbrn6HTFMG4TQ91Hwqc6M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GZxwfEGGcIwxD0k8owrHITG50m9vTXszsqVJY7ftPJN5Or9Ca8khPefxsMJqWlh/pAjlpvs2JAAvcnhljE/LVd+ksu6IEU3NhJlS4mqDemLGMIIGfXpTLdWOpR+VeTd5xcBYIw4BDi4djHGKT+ktV/Yz2O8pCgnvMCZJurmgIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+T3Ni8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+T3Ni8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D081DC4CEE3;
	Thu, 10 Jul 2025 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752155124;
	bh=f2/LXuhJ/TZJeNZpkkOZvoUbrn6HTFMG4TQ91Hwqc6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+T3Ni8eAY2fc3ba7ps+5vKbkVNLHuSBb+pa3sUvXwnPy9KiK4F5IQ8+9VR8U8v8A
	 8kJ0hyGcvA4OUpuVTm9DjZJXIYTM+7FhgBF9PLI4nJW/SZyDE7DBcVQQYQc2w+T95X
	 x2R6Zf96iiy2OItQgCRJH8+v6O1/YIiziovGRtsCL1OIVJrM3ipooXI15KIcSONTfx
	 lmeq976dPtLMh9gfot/ZVCsBKmeZwydJPp9XZXU8KR8hi0MxjSuXTq/DL5ZonEaClc
	 3sSOjLQg9MeSZgduKeRhjV+skOEfeL3fRIcgnj+pDiGmPhUFdVkPcmXpdCZN0xu7Nt
	 pCa9uvrzoR2Lw==
Date: Thu, 10 Jul 2025 22:45:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250710224520.4eaf514db761ecaaee9bc1e1@kernel.org>
In-Reply-To: <20250709131107.397a3278@batman.local.home>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 13:11:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  8 Jul 2025 20:54:49 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
> > converted to `__attribute__((btf_type_tag("user")))`. In this case,
> > some syscall events have it for __user data, like below;
> > 
> > /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
> > name: sys_enter_openat
> > ID: 720
> > format:
> >         field:unsigned short common_type;       offset:0;       size:2; signed:0;
> >         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
> >         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
> >         field:int common_pid;   offset:4;       size:4; signed:1;
> > 
> >         field:int __syscall_nr; offset:8;       size:4; signed:1;
> >         field:int dfd;  offset:16;      size:8; signed:0;
> >         field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;
> >         field:int flags;        offset:32;      size:8; signed:0;
> >         field:umode_t mode;     offset:40;      size:8; signed:0;
> > 
> > .
> > Then the trace event filter fails to set the string acceptable flag
> > (FILTER_PTR_STRING) to the field and rejects setting string filter;
> > 
> >  # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' \
> >     >> events/syscalls/sys_enter_openat/filter  
> >  sh: write error: Invalid argument
> >  # cat error_log
> >  [  723.743637] event filter parse error: error: Expecting numeric field
> >    Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"
> > 
> > Since this __attribute__ makes format parsing complicated and not
> > needed, remove the __attribute__(.*) from the type string.
> 
> Actually, you can do this in update_event_fields() that already does
> this magic for enums as the field length.

Got it. It should be done in the same place.

> 
> And it doesn't free after allocation because it only does the
> allocation for events that will never be freed. For modules, it
> registers the allocated string so it will be freed on unload.

What happen if the tracepoint in module has the __attribute__?
(or enum etc?)


Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
