Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00925F970;
	Mon, 24 Mar 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826560; cv=none; b=dMX9hup8aKAPYBR8kAe0bGTJHPwS3doObB3DxOGvw0H5hMaQL1CcSiV3oUxeXzW7N9s1HWQQNro/7V8CYPXDIDBxt5KwgSb205uFrF6l7VaGf1zBrDAeDDI1Qmfy5pE0VXde1ihY1NWB64lWHrMFcejFH+LqLUTPEkGkZOMWBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826560; c=relaxed/simple;
	bh=jZ5QUKjHm3bpfL6bHQ9yCWM/FDvqIqAUg1jPYhCsX44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIzTH+fFoS8t4DLIEjJsRA22ret999XNq1s1RqRRObNOiBZtXv5maWwRZn8OdmNUgnYLYi7UFA870iViltMnGorq6R6MC5JoY3E/I5/z4v3NYkPP+zKXkHH+yjOkOhkBlX34U32Z/CDVweJLaChX3d4yJzZFYlxctVrp1OkYUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB6C4CEE9;
	Mon, 24 Mar 2025 14:29:19 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:30:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Douglas Raillard <douglas.raillard@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to
 synth_event_trace2()
Message-ID: <20250324103000.479f83dd@gandalf.local.home>
In-Reply-To: <20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
	<20250318180814.226644-3-douglas.raillard@arm.com>
	<20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
	<3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
	<20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 15:29:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yeah, because those are mainly for the tests, and we are expecting that if
> any modules wants to emit its events, it will define new trace-events and
> use it instead of synthetic events. The synthetic events are for
> programming via tracefs, not reporting from the kernel modules.
> It is confusing if any synthetic events are reported without any origin of
> real trace event. (so, it is an intermadiate event type.) IOW, We expect
> that synthetic event is reported by other events via event trigger.
> The current APIs are just for testing.
> 
> Hmm, I should hide those by CONFIG_SYNTH_EVENT_TESTS.

Perhaps we should remove synth_event_trace() from the include/linux header
file, and move it to kernel/trace/trace.h? That way it is only used for
internal purposes, and not exposed to modules. You could wrap the export
with a #ifdef CONFIG_SYNTH_EVENT_TESTS.

-- Steve
