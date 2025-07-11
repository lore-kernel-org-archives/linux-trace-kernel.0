Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC4625;
	Fri, 11 Jul 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212226; cv=none; b=IhnGsw6soCK7G8bcVCEl0QY5pXfe0ZjdE9j8xLMrYhDfPobyKl9KFA0oymTlBt4Z8U+2WcuvHAjVZX43ELeUc4svepdg1Og2kli6VhmipcKdJ5H7mhtoQSw4tUcNS01rx3pIulcBiY9PTbBQp3dKx0vPHZ2j94FupSDGNTnOG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212226; c=relaxed/simple;
	bh=rrPMseUm+lcefTjIo2vJ1vwq6HJlDpn6g0FP76bzlmo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fp667YTCGcyXNRNM4ZJLt1iBUwT7qE7Poi4XQDdalsHWb7N1v/U6Lx8bvBweMxaHSLN5oR787yRP5GNJOyamFrdJAfchVdjtHe3L2KCPPFWmPvpt2KM0ClZOCBVBnr4AoUn4CF+rzipHyBH14Hin+1wLJh8JvZUqD8ZuCiCTh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uESNkhD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uESNkhD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA4C4CEED;
	Fri, 11 Jul 2025 05:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752212226;
	bh=rrPMseUm+lcefTjIo2vJ1vwq6HJlDpn6g0FP76bzlmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uESNkhD4F+Ez280CSnVLwqZIWsvm3LOw10iAG1MCb6TrUsLpxANf+KYDnSm/te6Kz
	 YUC5lOHgR0OMc3wrjo71NLoJbcg5klETwRlxjz6TNI+VzyjUwBKmwFVlLdyZW6dhtl
	 8ULKhxjo+4FqMFbia8ucGgTn+IHqP2NdxHkIOcPZ64/LxHM1+4I+Mh3ex60XDJwuMO
	 MNnrElKi00GbiMYibIhOrojAYYdswv1WY6tBI8vEXf/Cu3GHLdTaaXl80U6um7OLzT
	 XktQbds/6jFOd1ZoQKyslmH8vsQRmNJ6RhL+cZpZ04g5UtUQwbpD732d4L/kqZjnqK
	 McRUce02Ih/pw==
Date: Fri, 11 Jul 2025 14:37:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
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

I investigated this but it is not possible to use update_event_fields()
because that function is only used if the 
CONFIG_TRACE_EVAL_MAP_FILE=y.

But since update_event_fields() can replace the allocated
field->type, we need a special care for that case too.
E.g. if update_event_fields() finds field->alloc_type set,
it will reuse field->type instead of allocate new string.

Let me fix that. At lease we need to fold these 2 patches
into one.

Thank you,

> 
> And it doesn't free after allocation because it only does the
> allocation for events that will never be freed. For modules, it
> registers the allocated string so it will be freed on unload.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
