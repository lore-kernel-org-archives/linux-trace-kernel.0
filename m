Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0470209F4C;
	Mon,  3 Feb 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596721; cv=none; b=B3vPdjeEFXOYI2poUTFd+T19BnjmETnQXpHHNn6/0ncjfhOMU8FG6GjJ34C6sHAa5qKLPZcggRMg4/B9cOJ0IwyMvmPqgJrTGdjZSqvWoFC55HvSsZMlVt3+zV/Haumt/dcMNOl7uCpcU6mrmyqZxmM/n8eLV39/GmNvVo/ozc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596721; c=relaxed/simple;
	bh=uqxLU6T2XgxeaLirWDCFeYb8axuV+tjR5jp4i+5h17U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvHA7thnsaEO8vHgpI7ouB53Oykc4CRvgHDYCstdqLQsf/fjqrPuDZvAsNTLh4cPtPKscSnw6rRu5OwRktPZLKaoSsipCg7OEUPY2KgTzxDvmQnPRf6EclU3mXwjyuDTfELCJqptMZwVdMhfVxyqPGCNLg4q2D2rVbapjExWBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF4DC4CED2;
	Mon,  3 Feb 2025 15:32:00 +0000 (UTC)
Date: Mon, 3 Feb 2025 10:32:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Message-ID: <20250203103234.79c4a388@gandalf.local.home>
In-Reply-To: <173839458022.2009498.14495253908367838065.stgit@devnote2>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Feb 2025 16:23:00 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 2nd version of adding relative stacktrace for tracing.
> The previous version is here;
> 
> https://lore.kernel.org/all/173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com/
> 
> In this version, I changed the idea to only use the first 32bit of
> the build_id of the modules instead of using live hash/id to identify
> the module. Also, save the offset from the .text section for each
> module instead of using the offset from the _stext for the module
> address. (For the core kernel text address, keep using the offset
> from _stext.)
> 
> This brings the following benefits:
>  - Do not need to save the live module allocation information on
>    somewhere in the reserved memory.
>  - Easy to find the module offline.
>  - We can ensure there are only offsets from the base, no KASLR info.
> 
> Moreover, encode/decode module build_id, we can show the module name
> with the symbols on stacktrace.
> 
> Thus, this relative stacktrace is a better option for the persistent
> ring buffer with security restricted environment (e.g. no kallsyms
> access from user.)
> 
>  # echo 1 > options/relative-stacktrace 
>  # modprobe trace_events_sample
>  # echo stacktrace > events/sample-trace/foo_bar/trigger 
>  # cat trace 
>     event-sample-1622    [004] ...1.   397.542659: <stack trace>
>  => event_triggers_post_call
>  => trace_event_raw_event_foo_bar [trace_events_sample]
>  => do_simple_thread_func [trace_events_sample]
>  => simple_thread [trace_events_sample]
>  => kthread
>  => ret_from_fork
>  => ret_from_fork_asm  
>

I thought we decided that we didn't need the relative stack trace? That all
we need to do is to expose the offset from the last boot, and a list of
modules that were loaded and their addresses, and then we can easily
decipher the stack traces into human readable format?

-- Steve
