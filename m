Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AF487AE;
	Mon, 10 Jun 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055641; cv=none; b=namJQv0L/RudZRv7ViCHe3n3+NdkWHoCPphcCAzvNLhlXlT0tEXSJ/72OWbs+KeT8l9Z+WZQTlyEj9MwvP1MbpTXVynZvh53HRsOp/7kujw5tyrrdg9frI5juIEETV/s9Wnj+EYE+GI7U/4CYgbuGN0zTsdvJxW+12N/sctrYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055641; c=relaxed/simple;
	bh=Ja29hFfaYkWWjl4eW9FNlAtmGWaZrLAI8SoRzcjlWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh5kDhEfH6QyTS7hKQFaZZRb58trRy3fz00eE9nyqkAgmInRwQfXRIiZkJdVW8kRNWwDFKpoiv7IKQGunFige4BejADZZ6HlxTjkOOD09P/RGvmlj7KNUUoG3uIRbotv0VAJ+yOU+sHDhuAsZClYOH42ZhqqU8U+XxB+7gpJdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4148C2BBFC;
	Mon, 10 Jun 2024 21:40:40 +0000 (UTC)
Date: Mon, 10 Jun 2024 17:40:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in
 selftests
Message-ID: <20240610174052.0fd280f2@gandalf.local.home>
In-Reply-To: <171805480405.52471.13982671291270977479.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805480405.52471.13982671291270977479.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 06:26:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the kprobe-events selftest shows OK or NG with the reason, the
> WARN_ON_ONCE()s for each place are redundant. Let's remove it.

Note, the ktests we run to validate commits, fail when it detects a WARN()
triggered.

If this fails in any configuration, ktest will not detect it failed.

-- Steve


> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
