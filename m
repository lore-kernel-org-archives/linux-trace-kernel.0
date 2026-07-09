Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9043935E;
	Thu,  9 Jul 2026 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573116; cv=none; b=s68RTmQf4PrOlSFTEB9aHsjsMg+FYQm1ljl6KcowrF8tawGNR1NV6JgdmtOQDL6tMLFXHFy4VFRub4dnRCGgR6YLtVEZp9rvi2/bjLHHEDBMn6oF2lZ/EOGVMpiODZep0j0A9fN0tcFdhO1ey21sLJzv1ccAj7MEOSzrVyvOL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573116; c=relaxed/simple;
	bh=q8N2HEg9Je9eXNf7TF+79CneoSXOsknAkBNJW/OONtU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UqYXt2pqDOpMi110D4Vumojjjpicv5LpqIdHRnv+Q+ttY0xl6AG5/MjZNlAhqoIetTmVANF7x/5m61eyg18qTgHheps4KxxrgyLwtXOedcSFhsXXwWiV97nyrl3ML7bts/63qInYcukvIdFI/9dSUTeiKJaHrf60pzchiOkGQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq+je7F+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq+je7F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69CE1F000E9;
	Thu,  9 Jul 2026 04:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573114;
	bh=bgbxzt2X00yGRcHUIikp6blheELKqubbVW8qGItt7Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aq+je7F+HveCplWyPvJR6z1Qd0+ZejulZ5T3TZaOKnkZEoUTUYejyOuVcd03iufLw
	 ijp49X7ZPBtu3DWEgVft/+aAmxOuuz311ZT4V636ASpg4aSFPhZECJA6qSiNFUw28k
	 izjYd4g2U+W46EtCzouVHxj42Uo9CzTuIDnGBFAtN71SNZi518/5HboYGzfkG7nqT0
	 qOX39GFG7NPioSsiEih+3BcKJnywmfsidB7jxkCqCSU5KfAOAvJ+84feMnCWMoNxqN
	 yly9XuNp6WhDWhKM+L8fjDpYzgo+HKTh7AV8xgjssi4680u0rb7kQ+pxzmfyu9XpOr
	 0VeNswVMG9rNQ==
Date: Thu, 9 Jul 2026 13:58:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/tracing: Have trigger-hist-poll.tc use
 sched_process_exit
Message-Id: <20260709135832.8aeb6cd3f4e26650a033e8c5@kernel.org>
In-Reply-To: <20260708163731.566a86aa@gandalf.local.home>
References: <20260708163436.058cc3df@gandalf.local.home>
	<20260708163539.1e1d845d@gandalf.local.home>
	<20260708163731.566a86aa@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 16:37:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 8 Jul 2026 16:35:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I forgot to mention that I tested this with and without CONFIG_RCU_LAZY.
> > With that config disabled, the test passes. With it enabled, it always
> > fails.
> 
> And I also traced it with:
> 
>   trace-cmd set -p function_graph -l event_hist_poll -O funcgraph-retval
> 
> and it shows the sched_process_free being called for the sleep process
> *after* the poll finishes.

Thanks for fix and tested!!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
