Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1A1CAA9C;
	Tue, 25 Mar 2025 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932152; cv=none; b=pl86t751Fa7wJYCY+SshqyFrTNrSBNk9XACLg6BYEhJH0Gor9h3okHjyHD4hIOrlN7uwesVMBqcETYWBbID/FAf6cEQtsOKxz6/GTYIbC6BgDV6QQDEvwo2gN0C8NSxBneGyCOkIwJ+J4NkjpTzcgW6ySgslUHVR/9/NPFDXBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932152; c=relaxed/simple;
	bh=upzxSgG6f7CYOVrBvqIfcjjoIdI0ZTBLwP/LjgwfYRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hz5THPyog6GRZvE7Q9ho+0Tc5CAak3F53amJvpNlAo2YIS+u5ImEYQ1ElsKJ0kGY92dz99HHsv0ApPKkgRzscjhsjIJ11f0oZPfdpAj0xhInko9ef3V753wp9O+In/Apb/977KWWGd1A86U7P5ZNpMfFQt4N8PHLIfw/QOV69Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39583C4CEE4;
	Tue, 25 Mar 2025 19:49:11 +0000 (UTC)
Date: Tue, 25 Mar 2025 15:49:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <20250325154955.5ed4fa33@gandalf.local.home>
In-Reply-To: <174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com>
References: <174282688292.356346.8368421078882769536.stgit@mhiramat.tok.corp.google.com>
	<174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 23:34:52 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the previous boot trace buffer can include module text address in
> the stacktrace. As same as the kernel text address, convert the module
> text address using the module address information.
> 
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202503112303.D7g66VSd-lkp@intel.com/

FYI, You don't add "Reported-by" and "Closes" tags for kernel test robot
reports for previous versions of a patch set.

It even says that in the report:

   If you fix the issue in a separate patch/commit (i.e. not just a new version of
   the same patch/commit), kindly add following tags
   | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/

"not just a new version of the same patch/commit"


> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Protect module_delta by RCU.
>   - Make nop make_mod_delta() for CONFIG_MODULES=n.
>   - Rebased on linux-trace/for-next.
>  Changes in v4:
>   - Move module_delta to trace_array again.
>   - Use bsearch for lookup module_delta.
>   - Revert the boolean logic to avoid '!',
>   - Fix !CONFIG_MODULES compile errors.
> ---
>  kernel/trace/trace.c        |  133 +++++++++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.h        |    8 +++
>  kernel/trace/trace_output.c |    4 +
>  3 files changed, 138 insertions(+), 7 deletions(-)
> 
