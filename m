Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2241DDC2B;
	Mon,  7 Oct 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325523; cv=none; b=ImGtOI3kijNpl83bZV/LSn/6lQxcoflacrY8G4kXGUozY1hZXuajXEDjLq8xigEBYKOWwtQCUqgo8AJmGke1nN6s4h8mfZycRAKc/tNqoO6amUj4EfuJOFos/4Fe+eV+2F+sDjfxQz2BjWKZRkLWvc9my45+2kBLF5tmSX/NR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325523; c=relaxed/simple;
	bh=eL+UUseJdKGqGlrV0AxBjqNKuNBQCF6P3bXK2xko/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgfHBS3a795Wr1ZbT6kqZwvxDtzNJS/EI8AdI0c8J2R8a9sBN1M7AGw8DgBtpn9K0LLQ3kA2G525GBqasyfmqWCNJ3suKx/oqpAO9G4UBo/93i4IPtjEmhJh4p/XPvaHEh/vD50tH/sSO3iTcpfs4sjX1jxtMGdF3Xby/04fcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCmaZQGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCmaZQGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F01C4CEC6;
	Mon,  7 Oct 2024 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325523;
	bh=eL+UUseJdKGqGlrV0AxBjqNKuNBQCF6P3bXK2xko/k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCmaZQGoYQNAyZAP+PMMyWWRvSKuk9gy4NbiJHS/a3HkpiCyNdsAfeL/tZEdMkD4+
	 2bPusCmdXGLO+hTZJ1vnThSRcjuWG8/kvchtFn7+DAoSd+zUM5+p/3ZZfMdl7c3iFw
	 xjEpqnfZBpf6XssacHILkl8jTDczXiS+/k1hb+6EX94K2p22LAk8I1H3WwGlvSs8bb
	 ETWb/8aY5306cqQNxLxP8Amh5aO+8eWZXO4idItKtp+NMW4mmoaVVBh2TanVNtAqC6
	 7zxlCwHJXLiB9C4mw4FR0ZSraqNvqZ2cyG7Wg29Z07+TW3f60VUyG8L0tOAU69WCcK
	 RvwZA9RCUPEoQ==
Date: Mon, 7 Oct 2024 11:25:21 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] tracepoints: Use new static branch API
Message-ID: <20241007182521.xtlduygupnt6wnfa@treble>
References: <03da49e81c50eb2a9f47918409e4c590c0f28060.1727817249.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03da49e81c50eb2a9f47918409e4c590c0f28060.1727817249.git.jpoimboe@kernel.org>

On Tue, Oct 01, 2024 at 03:24:01PM -0700, Josh Poimboeuf wrote:
> The old static key API based on 'struct static_key' is deprecated.
> Convert tracepoints to use the new API.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Steven,

The kernel test robot found this patch breaks the build with
CONFIG_HIST_TRIGGERS:

  https://lore.kernel.org/202410040333.vJSL1NXx-lkp@intel.com

Here's the fix, do you want to squash it in or should I post a v2?

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..cc2924ad32a3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -822,7 +822,7 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 {
 	struct tracepoint *tp = event->tp;
 
-	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+	if (unlikely(static_key_enabled(&tp->key))) {
 		struct tracepoint_func *probe_func_ptr;
 		synth_probe_func_t probe_func;
 		void *__data;
