Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1D1D4146;
	Mon, 14 Oct 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942851; cv=none; b=gYHE8ZZ1vjuDZ3FWZtRkSDC/fsxyM3kQSHXN2T/Vq9Sg7qtlgwI0bMfVgawI8DtT2bN9vPsc3mJwsIJ9XfBm4BdGE1mdDs9ZlKbzeUM4u0EsC3Zy9G5iuaLZ+rEqOfUJNXeeUTBPecS9EO5NqkLl1wbiLrr1zgVG4V1kYP85V78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942851; c=relaxed/simple;
	bh=ZqH16Rgj4Hh52BSJPWE9L9nQI9vM/8AD4xag8e1XBjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkC+R2isu4Tw3bb9ArgT0iFAnuHKKNz0a1ryxPj/f8Ld6jM5Bd+CrbZdAJnCo/YqNHzjv+G6Ms4dwbLo6FPZsnEcwq6Ewnvxq2fT4S1e15TBRg+MX1VxPIzl5QyWtmyANkrov0OlRWgLAn1UGBmwGtIt5jor0LTkdq/iOatMDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92664C4CECF;
	Mon, 14 Oct 2024 21:54:10 +0000 (UTC)
Date: Mon, 14 Oct 2024 17:54:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tracing: replace multiple deprecated strncpy with
 memcpy
Message-ID: <20241014175427.4bcf9020@gandalf.local.home>
In-Reply-To: <202410141423.2C30F35EE0@keescook>
References: <20241014-strncpy-kernel-trace-trace_events_filter-c-v2-1-d821e81e371e@google.com>
	<202410141423.2C30F35EE0@keescook>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 14:31:29 -0700
Kees Cook <kees@kernel.org> wrote:
> 
> We know the destination must have a NUL-terminated string. Is the src
> NUL terminated? Looking at parse_pred(), it seems like no? And we can't
> use memtostr_pad() here because the source buffer size isn't known at
> compile time. Okay then. And there are no NUL bytes in the "str + s"
> span, so yeah, it looks like memcpy() is best.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

The code is simply breaking up parts of one string and copying the bits
into other strings. Like the example that broke:

$ echo 'common_pid != 0 && common_pid != 120 && common_pid != 1253 &&
  common_pid != 17 && common_pid != 394 && common_pid != 81 &&
  common_pid != 87' > /sys/kernel/tracing/events/sched/sched_switch/filter

It would need to move each of the above tokens "common_pid", "!=", "0", "&&", etc
into their own strings for later processing. The parser finds the start and
end of the location needed to copy, so memcpy() followed by a nul byte is fine.

-- Steve
