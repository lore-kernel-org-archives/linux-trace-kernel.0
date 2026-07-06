Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666230D403;
	Mon,  6 Jul 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345016; cv=none; b=oF9Z7VzpICK8LJfoBwfAA1QU4/qIXrlvQxXePUlvr5fW7LVr2e+IQ0V4d2iprpM3brWA44ODzAefxIdnk3VDyCLabB35g7hMzaCS1X7a9vuRaoq7PuZWw28WjTtQEV9C1Fc6l0YKSDhkpcj6XKbDIb/FvaKTNiO6Vle+4ebhB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345016; c=relaxed/simple;
	bh=o36NYZa7n1UvMniLFbo2vJugvYLzERRkzk6Fn0LFVyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZZu+a48sRX1s0vy5YBdMi9nGGQ8FRA9cstZcqPh9kseoBQjo3nYN8QASgnqwSPYk7XJBRcNb35XWIQbwvhD+Zuwyhau5Umb0bSYQrpBuA2jcUvC8OFbtu8QtWWLB3M625Br2PQNN0PauY+MLxO7vQ1tA9wQS1EXk1KQYBuhPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 54997C228B;
	Mon,  6 Jul 2026 13:36:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2FEC017;
	Mon,  6 Jul 2026 13:36:43 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:36:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gary
 Guo <gary@garyguo.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/4] tracing: add ref_trace_final_put tracepoint
Message-ID: <20260706093643.57c46df3@gandalf.local.home>
In-Reply-To: <20260705-refcount-final-put-trace-v1-1-cdd0014626a9@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-cdd0014626a9@mavick.dev>
	<20260705-refcount-final-put-trace-v1-1-cdd0014626a9@mavick.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2FEC017
X-Stat-Signature: wrbjydzdk7zyfpqmfcr7wgaazjfey6co
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18iOBSd1pnsrPI+vzqJgOb1sapVaUTJDoE=
X-HE-Tag: 1783345003-529797
X-HE-Meta: U2FsdGVkX18T6Lw+/fcbVOH4rtqF7ZifzRFdTKamy0zQqCc6fLRr5ibfZP9wg1GYcku/1WOe9lssZmFPjldoouZRMbWsmB76zw/otz1z60JUzDxmL2DZU4i08KjirFEzfCZiFNoTDgaL4SxKt9Q1m8X6hOQZx1OU/uPuqQeDONqy9NJ7EwrdjmPdcNdsV9mhJueYUEzb5/KQoyrKvLYbOev/FHwtuHJQrf+DT3pYr1a03b4b6P038OVkf/0sNNpXBjJ1lwemilyysDS91do4cvogWTkTYlhzThKAbr2xvrY7D8/JC+fGKHAqQnAcLsC3

On Sun, 05 Jul 2026 07:19:20 +0800
Eugene Mavick <m@mavick.dev> wrote:

> +#ifdef CONFIG_TRACEPOINTS
> +/* Wrapper function implemented in lib/ref_trace.c */
> +extern void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj);
> +
> +#define trace_ref_final_put(obj)						\
> +	do {									\
> +		if (tracepoint_enabled(ref_trace_final_put))			\
> +			do_ref_trace_final_put(_RET_IP_, __func__, obj);	\
> +	} while (0)
> +


Also, you may want to make the macro called do_trace_ref_final_put(), to
show that it is not a tracepoint (which all start with "trace_").

-- Steve
