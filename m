Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF27369206;
	Thu, 21 May 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351242; cv=none; b=VaV0AvX20b4/M5ZqJqKOPGyU3WK3gH6ZkQ/D2fPBZUPIGpzu/50VzmFCPLWEf0vb3cN9ULJ3ToArLD34GtHY8WGx9NKDeoykHaGj15SdgSQlyuFeNs+YM0qAEeTO9WDnnJwnR7zRgEckTh7ptSgxTxsrjQK5qptwJ1plk/weyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351242; c=relaxed/simple;
	bh=pDQV9vVdMJjf0gbgd69nxKCHhFAfEcunajr2zhWn+xI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I6nghZaAIjmzCee7peXdn4agxjVc1TOKbT8EbFryVX07D128jc7+iTWRcN2Km5c5s10zupBOUMBiAQTg1tiEQM2/P195wHUpfCm/kQouu7pBx5FTtDMK5kpkgMCcJvMQVcZC7kaLYSW2QvPGH9/Q6ARO01k0k5SAiPYok7LnCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7cocK7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7cocK7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED601F000E9;
	Thu, 21 May 2026 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779351239;
	bh=Y/Bs6ZlfMO0CZf8eiGBZJ+muRswHEWGOV5DQOo812Qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q7cocK7nrtZJuevPXS2BH97rAwACvIxdNLHz45ULayOJolykKcesyNHphyp1NewcK
	 8KIN+HpIyFIy81RbFG8sYOjxoahNH2gZKe6Z3lG5Dz4L9v1vcptXDR3rudigsKEkdD
	 FL7Odwl1ARbd4AY2comN0wjPpL657W+W6RjiFLgjTjorbnhQhmpPKPSrUF2RZAzA73
	 c34T53QSo1/DFKpT/PEkfMWf+DzYsGzWC54WLfEDF+iVrbasULZW/k1OVufPcO6xAH
	 +QEjB5ePAtXh7RYZtM4J72yf6mIsaMTkfK+xYoMg4IupmHexOBTWVKgvKXzqSB4OmW
	 1wZimEllm7Ouw==
Date: Thu, 21 May 2026 17:13:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 00/10] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260521171353.74e66d117b0809418c8822d4@kernel.org>
In-Reply-To: <20260520184938.749337513@kernel.org>
References: <20260520184938.749337513@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:49:38 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> 
> Here is the 20th version of improvement patches for making persistent
> ring buffers robust to failures.
> The previous version is here:
> 
>  https://lore.kernel.org/all/177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com/
> 
> None of the patches from the 19th version was changed. Only patches were
> added to it in this version. All of Masami's patches were in version 19,
> and all my patches are new to version 20. The reason I'm including
> Masami's patches with mine is so that Sashiko can handle all of them
> in one go.

Thanks for updating.

BTW, it seems Sashiko is stopping review this series. 
https://sashiko.dev/#/patchset/20260520184938.749337513%40kernel.org

Not sure why.

> 
> I moved patch 1 from v19 to my urgent branch as it was marked as
> fix for stable.
> 
> The patches I added:
> 
> - Fix an invalid sub-buffer in the iterator (added TBD fixes tag)
>   I didn't want to fold the patch into the patch that was fixed
>   as it was written by Masami.
> 
> - Have the dropped buffers be persistent across boots. Masami's patches
>   cleared the detection of lost subbuffers on boot up and the next
>   boot would not show them. If the persistent ring buffer isn't cleared
>   it should report the same info on subsequent boots.
> 
> - Show [LOST EVENTS] in persistent trace file where a subbuffer was
>   reset due to being invalid.
> 
> - Show [LOST EVENTS] in the persistent trace_pipe file as well.
> 
> Masami Hiramatsu (Google) (6):
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
>       ring-buffer: Add persistent ring buffer invalid-page inject test
>       ring-buffer: Show commit numbers in buffer_meta file
>       ring-buffer: Cleanup persistent ring buffer validation
>       ring-buffer: Cleanup buffer_data_page related code
> 
> Steven Rostedt (4):
>       ring-buffer: Skip invalid sub-buffers for iterator
>       ring-buffer: Have dropped subbuffers be persistent across reboots
>       ring-buffer: Show persistent buffer dropped events in trace file
>       ring-buffer: Show persistent buffer dropped events in trace_pipe file
> 
> ----
>  include/linux/ring_buffer.h |   1 +
>  kernel/trace/Kconfig        |  34 +++
>  kernel/trace/ring_buffer.c  | 538 +++++++++++++++++++++++++++++---------------
>  kernel/trace/trace.c        |   4 +
>  4 files changed, 397 insertions(+), 180 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
