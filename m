Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC67377ED7;
	Wed, 29 Apr 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480365; cv=none; b=i7Sn5uZHSN+SOzXBTYtkzYfe1OhPLkJJ9WL+E/QSo3KnodPnK7XGXnQqIMPDwWvvs569//zcHCTHcMQuz8iLioCSWVpGPbm+3nyEZS74ESlXaKM9F1ITPfouN/9zyO/fUhB/31qxNwbKdHPtTK+ALMDwIbNTi7Y1yMo62lcGN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480365; c=relaxed/simple;
	bh=c0WxikUppz2uMPqndHhtnnyFjZtw/M53lIEgzbcNhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgTTSIIlPjzBdazKTgnuXL0hhfCX2nttnutNKd+XjrtxcPeamMpRdQRGqYe1YDvX1vIo7315ZQ7fsvhdst3+JNCW//LFgY3PwJ7P19EK7BhNfS+vMXO4qEdqQWNUgF7yO366wntw/G8P1KY64iWpxKwqizIv+qDqFZA5oi1MyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3103614034F;
	Wed, 29 Apr 2026 16:32:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 02EE32000E;
	Wed, 29 Apr 2026 16:32:38 +0000 (UTC)
Date: Wed, 29 Apr 2026 12:32:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 3/8] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260429123256.5172d581@gandalf.local.home>
In-Reply-To: <20260430001559.a2d0489d956c06059e13e58d@kernel.org>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701354681.2223789.14633430761021638378.stgit@mhiramat.tok.corp.google.com>
	<20260428155508.4f47279e@gandalf.local.home>
	<20260430001559.a2d0489d956c06059e13e58d@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02EE32000E
X-Rspamd-Server: rspamout06
X-Stat-Signature: 595h9ut9b6nuepdf88sn1susbafq418f
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+38fsHwXaVeeKb/tR0TBTEd3NZpLiw37E=
X-HE-Tag: 1777480358-669733
X-HE-Meta: U2FsdGVkX180m1p5vGF6wqvR/Xb5tM1EK6BvWIBUmlDbVxNeLWhRk0nFBuWNyo0u14cD4tmCZze/urXDylalHowEEGoHEvHGoXcWledyIo09DvsOAIpSdFWtkfptbW1+NnUljSPIdlX9ftWRxK12z2C9ALg8EHEVNVlj/wj/NcH4gupNrebgSjHWQbX/C8Rx8K4i7AUpe6plGIxXOgRE7A8fCESjJmQ2pNOKfp1RiOVwaJFwQZUGH1RNLlm5BtBp9mfyhWJPL+j9Ix3Xich7iFJDDeWu2/Hmol5N7e8j2uunAJjv9fqUXMUrJ1/PbDwgh1Q7ChqSDGf1tPar4XeglFWC2hX/3A5a

On Thu, 30 Apr 2026 00:15:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> It should not be a never ending loop (there are other exit conditions),
> but I agreed. What about limiting with nr_subbufs?
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5326924615a4..aa89ec96e964 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5630,7 +5630,8 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	 * a case where we will loop three times. There should be no
>  	 * reason to loop four times (that I know of).
>  	 */
> -	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
> +	if (RB_WARN_ON(cpu_buffer,
> +		++nr_loops > (cpu_buffer->ring_meta ? cpu_buffer->nr_subbufs : 3))) {
>  		reader = NULL;
>  		goto out;
>  	}

Yeah, this looks more reasonable.

Thanks,

-- Steve
