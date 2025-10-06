Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120F21FF4C;
	Mon,  6 Oct 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745453; cv=none; b=TYq1rTDVgGeDd6nkIK4jLBezvsVo5d7v7B11spJ2ql6nZ6kN/DJnZvKXUo/1YW3VRNfIfxcWvdnUnj45FFl58O2pepPdRIph1QOGtwUZeuO+quNobTdlV64qQqjuRenadT7GB9tCnPrSRMeMoJizhL+0ZqfrzxndjYpceRZhg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745453; c=relaxed/simple;
	bh=cYgTEj4pgntErqjqga5WxNM7XufefKDW784gXckyoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw13NWFIQXvsS2M8ns3nc9T/6XWu7EIRgenNCJmuOPWvPQI0KnzRP9EKCOYGK1dNjz55J8i452YAaoMQinjTerstdpkm5LMl6U7GyvfznO8dPctv/7dXK/f6+l8A8GO6jGz8fgJ80koGCysj1bAsfoPz4pl/hNLC3LZ+HX8jb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwpMWfyN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxf7pHXR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwpMWfyN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxf7pHXR"
Date: Mon, 6 Oct 2025 12:10:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759745449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ9gw/5hlteQIY5HmNrmtZC5q8R7f1aOpxmrRciOsJY=;
	b=FwpMWfyNRlQzfYOIO02y7hs3FfI7LSWvwyC/v1u/anjdzMEFu55DAtz24yWzBC5skZm1Tk
	S+7vvho0s5fFJgINvLZdA0/uPm2OEfrH36ovMGFEZNw51l0eHk93HNuIBEqZcs4QfSsTlk
	GKcCajZ2aEAso0tSqsj4xmh6J4lXcFZ4nPBT0fSmY4hZAoPu45WrgaMbW+eaJ+je6Muh6f
	pCRDpQ/DQW+hQrNF3pf2EBYM3t7inzPZZlWr26VNTH/gPSOkmjaYIcVAiB1lIQOXdkzI/F
	LK68QAyPHJyYnPiJd6HcpksDO/uNAIsCQjwzS3zErQK1DoVAAGSSQjRBjsOZSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759745449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ9gw/5hlteQIY5HmNrmtZC5q8R7f1aOpxmrRciOsJY=;
	b=oxf7pHXRl3CmOjq+vU+DQyHbbAbdC8leM7xC038jEyca3Znc+Pg2p25+PB7BDlB429JPNZ
	cux6oWqEH/6IUcCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
Message-ID: <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
 <20250922162900.eNwI7CS0@linutronix.de>
 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
 <87ikgxqrna.fsf@yellow.woof>
 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>

Hi Gabriele,

On Fri, Oct 03, 2025 at 08:30:10AM +0200, Gabriele Monaco wrote:
> 2025-10-02T14:56:23Z Nam Cao <namcao@linutronix.de>:
> 
> > Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> >> I am wondering if it would make sense to add a new tracepoint that
> >> fires in addition of the reactors. That would allow multiple
> >> simultaneous consumers and also bespoke handlers in userspace.
> >
> > We do have tracepoints for each monitor in: kernel/trace/rv/rv_trace.h
> >
> > And yeah, I think it is a nice idea for all the consumers to use these
> > tracepoints intead (that includes rtapp testing, and also the existing
> > reactors). It would simplify things, as the monitors do not have to
> > worry about the reactors, they only need to invoke tracepoints.
> >
> > But this also makes me think about the necessity of the existing
> > reactors. What do they offer that tracepoints do not? Myself I almost
> > never use the reactors, so I'm thinking about removing them. But maybe
> > @Gabriele has objections?
> 
> Well, many use cases might be better off with tracepoints, but reactors do
> things tracepoints cannot really do.
> Printk is much faster (and perhaps more reliable) than the trace buffer for
> printing, panic can be used to gather a kernel dump.
> One may just attach to tracepoints via libtracefs/BPF and do most of the things
> you'd want to do with a new reactor, but I see reactors much easier to use from
> scripts, for instance.
>
> LTLs don't benefit as much as they don't print any additional information via
> reactors, but DA/HA give hints on what's wrong.
> 
> I wouldn't get rid of reactors until they become a huge maintenance burden, but
> probably we could think about it twice before extending or making them more
> complex.

The existing reactors could be implemented on top of the tracepoints.
This should make the RV core a bit simpler.

Note: The current interface between the RV core and the reactors is inflexible.
Passing only opaque varargs requires all reactors to format the string from
within the tracepoint handler, as they can not know how long the objects
referenced by the varargs are valid. Passing the actual objects would allow
for example the signal reactor to format its message as part of the task_work
handler instead of the signal handler and avoid the allocation of a fixed size
message buffer.

> For instance, what's the exact use case of the signal reactor? Isn't it simpler
> to do everything in BPF? Is the signal needed at all or something else (e.g.
> perf) would do the job?

The signal reactor is convenient to write automated tests. It can be used to
validate the monitors by triggering known-bad systemcalls from a test
executable and expect it to be killed with the reactor signal, see below for
an example.
On the other hand it can be used to validate that the kernel itself does not
regress with respect to RV-validated properties. For example the test program
can enable the rtapp monitor and run an example RT application using all kinds
of known-good IPC mechanisms without it being killed.


Thomas



Example selftest to make sure rtapp/sleep monitors detect the invalid
clock_nanosleep(CLOCK_REALTIME). I use this to also test my reactor:

#include "kselftest.h"
#include "test_utils.h" /* Provides

#include <sched.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void test_nanosleep(void)
{
	struct timespec sleep_time;
	pid_t pid;
	int ret;

	pid = fork();
	switch (pid) {
	case -1:
		ksft_test_result_fail("%s: failed to fork: %s\n", __func__, strerror(errno));
		return;
	case 0:
		sleep_time.tv_sec = 2;
		sleep_time.tv_nsec = 0;

		ret = clock_nanosleep(CLOCK_REALTIME, 0, &sleep_time, NULL);
		_exit(ret != 0);
	default:
		waitpid(pid, &ret, 0);
		ksft_print_msg("ret 0x%x\n", ret);
	}

	ksft_test_result(ret == 0, "%s\n", __func__);
}

static void become_realtime(void)
{
	struct sched_param p = {
		.sched_priority = 1,
	};
	int ret;

	ret = sched_setscheduler(0, SCHED_FIFO, &p);
	if (ret == -1) {
		ksft_print_header();
		ksft_set_plan(1);
		ksft_test_result_fail("Failed to become realtime: %s\n", strerror(errno));
		ksft_finished();
	}
}

int main(void)
{
	int ret;

	become_realtime();

	ret = rtapp_enable();
	if (ret) {
		ksft_print_header();
		ksft_set_plan(1);
		ksft_test_result_fail("Failed to enable rtapp: %s\n", strerror(errno));
		ksft_finished();
	}

	ksft_print_header();
	ksft_set_plan(1);

	test_nanosleep();

	rtapp_disable();

	ksft_finished();
}
