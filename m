Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9E1E5B73;
	Thu,  5 Feb 2026 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252106; cv=none; b=M/iJUqeQLnsyimtwR3eSzwrlwx/QrME1DV4qgS2AD07UV1R3MOVdOysnQNPBMv4T1zJKzir38inLq4ac0M0u+FcKAxBz5iHeYwA7uFRl2xjJLEA+FroWIl0dnTpnuLCLvoQ3AdU9ng3/oefAaLSsb8laBR00ifcszKVi7WHSUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252106; c=relaxed/simple;
	bh=DMCvHTI0uyxPtxa7wxhSQbpFIJEwc7TcZ7IjVTFXies=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eZsCRMY0Xxu3id5+jNXgczatwagPmbV+Zmrm/PRLy1RRY13Ty9RojFXBcX82fhJvomTyJJY6mriK+I86yt/8ETi1Hmdq7NrB2/fj0Cz3oPPTCOeb8fNq8yjPlLXEiLKwIffmBtFGTKvgV4qQu1a4je4EgL5ZVkpYh2ilrfjtsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwcayHPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwcayHPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AABBC16AAE;
	Thu,  5 Feb 2026 00:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770252106;
	bh=DMCvHTI0uyxPtxa7wxhSQbpFIJEwc7TcZ7IjVTFXies=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jwcayHPqxiYyaJ9zohReptyj5GvHVz7JFfhwWCFqWkymFAbBzUrgC0B02WjWaiR31
	 0yG3u/G4Hpj6ydhtZm0Cyl4FOkFTCAap4SBtDWYl++GS7UFEW2EfnIO4XwflrnOCLL
	 MqsEwM+pTb/S6S2OcrlJdg5vHE8D0pJ8/qjvIDcwOsdCpU0amjpSXAwh7sMXKwysNu
	 +CeyADMGx9nmE2jut2KWaWScEK4M3bxInXYz3/lN/JkWn5+RODjaAoM1x4UePE3RqF
	 cATf5khpY4hyhFvLee8TWO9+UOK+evtXkJsq5evc+me2tBOz4x1WrcmdjZ/6JCd4KD
	 cPQIbnb60MYAg==
Date: Thu, 5 Feb 2026 09:41:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] tracing: Remove backup instance after read all
Message-Id: <20260205094142.03d87e2d482649cb51355017@kernel.org>
In-Reply-To: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

Can you review this series?

On Sun,  1 Feb 2026 12:28:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the v6 of the series to improve backup instances of
> the persistent ring buffer. The previous version is here:
> 
> https://lore.kernel.org/all/176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com/
> 
> This version cleanup code and fix typo, according to Steve's
> comments. Also fix to init autoremove_wq only when the readonly
> instance has been made. A major UI change is that the tracing_on
> file is also removed from readonly instance.
> 
> Since backup instances are a kind of snapshot of the persistent
> ring buffer, it should be readonly. And if it is readonly
> there is no reason to keep it after reading all data via trace_pipe
> because the data has been consumed. But user should be able to remove
> the readonly instance by rmdir or truncating `trace` file.
> 
> Thus, [2/4] makes backup instances readonly (not able to write any
> events, cleanup trace, change buffer size). Also, [3/4] removes the
> backup instance after consuming all data via trace_pipe.
> With this improvements, even if we makes a backup instance (using
> the same amount of memory of the persistent ring buffer), it will
> be removed after reading the data automatically.
> 
> ---
> 
> Masami Hiramatsu (Google) (4):
>       tracing: Reset last_boot_info if ring buffer is reset
>       tracing: Make the backup instance non-reusable
>       tracing: Remove the backup instance automatically after read
>       tracing/Documentation: Add a section about backup instance
> 
> 
>  Documentation/trace/debugging.rst |   19 ++++
>  kernel/trace/trace.c              |  162 ++++++++++++++++++++++++++++++-------
>  kernel/trace/trace.h              |   13 +++
>  kernel/trace/trace_boot.c         |    5 +
>  kernel/trace/trace_events.c       |   76 ++++++++++-------
>  5 files changed, 209 insertions(+), 66 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
