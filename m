Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6E223311;
	Wed,  9 Jul 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081073; cv=none; b=sa38OlhRTLQ1sWZVw73QzGLPgx3vBxiNXEV3xZxjqlIJefIKRvwdPTLy2JO7X6geGtvyXD2qfBk20wWeKtxYC1Fc6cp5u/MGXdxe23bW+pYtDaWjybxi8Ta1/I89gk3OwrdgaAgB+Wc2eDI+Us1grpL69kp7y57pZ5aWVBLDXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081073; c=relaxed/simple;
	bh=rOxw1J6Bw5ePvIxnhvmcqIx1OhNgTapjbALNu/5KvXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9jXb/Eu8FXxuNCWEnHvuyvdUQFK1AHFoeQ0zZ/hnsFEcuJ+sxdkMxMq0qe/3lo29P1hWGmdgiKkepMGSkhmaLlrRcrhuP2haxWy6Rgv2vdR4rzCrmlAJIrXUxfxD7ffjE1fMgeNHxvDnSfr4O78DvBqyCmHgv4Mq/IrJNxSWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 15D3157F1F;
	Wed,  9 Jul 2025 17:11:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 6D1F82000F;
	Wed,  9 Jul 2025 17:11:08 +0000 (UTC)
Date: Wed, 9 Jul 2025 13:11:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250709131107.397a3278@batman.local.home>
In-Reply-To: <175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D1F82000F
X-Rspamd-Server: rspamout02
X-Stat-Signature: ck4kexkfb3ushs7d8a14y3thnw819uhe
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/p1rDc+3KDqYDO0FYp1TL/DM0A1phWDkA=
X-HE-Tag: 1752081068-310608
X-HE-Meta: U2FsdGVkX1+dWYv+E3E9ldTuVqBb3nhtSHRAjRp0OYBUDZ1no4dH0i2BSyEJnjhi3AJMsF+NX80EUeCkWnk7j/qVnW4xVFIcjsqjqI0dlPgPx1mYY1job0uYycQ2ll7X4LHjsZqbDO+woF3Ffz7/Ybxbq6JerVFJeoQqWG8WQ/tn/1lfBL74xQFEUEB6bbO8inBrlKuFIQw6YGqdANF6zvxQk3Gu3AUj5/Bm4zzsPKiGokoo1lvv8oU6FoVW3hoofmGfMnlwlS6xXbBSCZKcRtt7+1Vfv3jvp+yFvRQWvgO6qxUoKw8rJAtPVNftGFkgitwPM+UUfqkVJyZqWGH0GRfvqmlqaT8u

On Tue,  8 Jul 2025 20:54:49 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
> converted to `__attribute__((btf_type_tag("user")))`. In this case,
> some syscall events have it for __user data, like below;
> 
> /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
> name: sys_enter_openat
> ID: 720
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:int __syscall_nr; offset:8;       size:4; signed:1;
>         field:int dfd;  offset:16;      size:8; signed:0;
>         field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;
>         field:int flags;        offset:32;      size:8; signed:0;
>         field:umode_t mode;     offset:40;      size:8; signed:0;
> 
> .
> Then the trace event filter fails to set the string acceptable flag
> (FILTER_PTR_STRING) to the field and rejects setting string filter;
> 
>  # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' \
>     >> events/syscalls/sys_enter_openat/filter  
>  sh: write error: Invalid argument
>  # cat error_log
>  [  723.743637] event filter parse error: error: Expecting numeric field
>    Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"
> 
> Since this __attribute__ makes format parsing complicated and not
> needed, remove the __attribute__(.*) from the type string.

Actually, you can do this in update_event_fields() that already does
this magic for enums as the field length.

And it doesn't free after allocation because it only does the
allocation for events that will never be freed. For modules, it
registers the allocated string so it will be freed on unload.

-- Steve
