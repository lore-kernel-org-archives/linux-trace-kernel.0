Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DA1DDA17;
	Tue, 28 Jan 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081638; cv=none; b=Bw8eOnWSSBbfTsPHfRZ3WQIeP8lVmzpOYCvoKWrP+zyffy7UF5zq/q5ij2NMA+D9N11sHa4e7j5KbIJhjuUlpMUdHcP4QiFOhqdGHSzQoikiXmxirUV1gtX4TL0wbKRUSFueicdzwDAYeOnU3jhk8TyYJK6g+ytQK/+kROTDiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081638; c=relaxed/simple;
	bh=iZXWdD3ItlfBsrbSPNO6rgfTytrsJFXrsrdmFmKjmys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q135m4+Cn+EDaQOU/E6Rhh0Valv6hv4/IS3SS5VN/V0xe6Z6GxnW54T/93x5VKeXWcfR1/5iPJ6SwQ8P7P04DkXbZdGB2jdu8Cvhqr/Ooe+9Vwtv18Aa/Dng/5gI47eTf7K8VrLV5TwyQAsEvwgj/T1blZd+MYADE3MUp3G/W6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA8C4CEE1;
	Tue, 28 Jan 2025 16:27:14 +0000 (UTC)
Date: Tue, 28 Jan 2025 11:27:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-ID: <20250128112733.37d7c771@gandalf.local.home>
In-Reply-To: <a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 10:46:21 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This does not handle the situation where a module is already loaded
> before tracing starts. In LTTng we have a statedump facility for this,
> where we can iterate on all modules at trace start and dump the relevant
> information.
> 
> You may want to consider a similar approach for other tracers.

Last night Masami and I were talking about this. The idea I was thinking of
was to simply have a module load notifier that would add modules to an
array. It would only keep track of loaded modules, and when the trace hit,
if the address was outside of core text, it would search the array for the
module, and use that. When a module is removed, it would also be removed
from the array. We currently do not support tracing module removal (if the
module is traced, the buffers are cleared when the module is removed).

If it is a module address, set the MSB, and for 32 bit machines use the
next 7 bits as an index into the module array, and for 64 bit machines, use
the next 10 bits as an index. This would be exposed in the format file for
the kernel_stack_rel event, so if these numbers change, user space can cope
with it. In fact, it would need to use the format file to distinguish the
32 bit and 64 bit values.

That is, a stack trace will contain addresses that are core kernel simply
subtracted from ".text", and the modules address would have the MSB set,
the next bits would be an index into that array that holds the module
information, and the address would be the address minus the module address
where it was loaded.

This way we do not need to save the information from any events. Also, for
the persistent ring buffer, this array could live in that memory, so that
it will be available on the next boot.

-- Steve

