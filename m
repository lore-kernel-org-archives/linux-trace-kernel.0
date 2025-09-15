Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202EE15D1;
	Mon, 15 Sep 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948876; cv=none; b=YK4uSG1eHr+MgGCZmnr/8V8oh4FKRmxaV7AzVtrBfm8SZ4X9mhwOfeeZz7vLYLKUtjIwgBU43kEYHDPn9Pe3FIg5xqDCmGvT1qo1ZlZjcntapHjBETXB3rMNq0NnVYtdQimO0mrlqWJA/TXQOWHOtwqvkD0MU/37gZRwsS8emes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948876; c=relaxed/simple;
	bh=9lwPpC9IguRK7mLYf7stv3Gtgn5OqQMpmfJLewO9UyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HkBXDkfWGY8Y4RdpzXovfj9a/RSMkngNMeSOp43OtMiB9V5vkxNaLeJsKRPXcyMAzvJjRHKqnuBvft7/xU+PNjRN1JWZ1PsLQuOt3gq5Kvz8hUvU5ZE3EPVeEVos8Ca5rwsruklzIo2mah6FQNjgDA2donk/D/q3YgbTg3sOZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy750PT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy750PT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63448C4CEF1;
	Mon, 15 Sep 2025 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948876;
	bh=9lwPpC9IguRK7mLYf7stv3Gtgn5OqQMpmfJLewO9UyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cy750PT6Xvj2Xm9XALiqKX0uPDNkoshZ/SSRYlKMu2lKNMNn8yx1b/fmXaMBmzTuE
	 ojFvrh9O9recxkon2w3X0Cuv2e5uOu7p1UUBcejJbNh1ds5yj+WRCYKI5G+IE41v5c
	 QT7UbuqPq6LItro9ZM63ejWex554beWu8eZgTZfBQDoxEIHTIzSlOGS/B4PnKelEI/
	 Vg1eyQ8CUGVtjdNUJzc9/DKvs65Hx8tVgdtHj2sJhImnvZQAiReu/Rl+wAWZ7aJoF+
	 xi6hZxmug7TTqePgArBvvWp9sG8CQfkXTRdwOk0cVc9nejJ1nZ8BqEcYIqBlupvqV1
	 h4DQM1It+fz7Q==
Message-ID: <4e6c3e28fe014d7350203b333c235188cdbe3dd2.camel@kernel.org>
Subject: Re: [PATCH 1/5] Documentation: trace: histogram: Fix histogram
 trigger subsection number order
From: Tom Zanussi <zanussi@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>,  Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Sep 2025 10:07:54 -0500
In-Reply-To: <20250911042527.22573-2-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	 <20250911042527.22573-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 11:25 +0700, Bagas Sanjaya wrote:
> Section numbering in subsections of "Histogram Trigger Command"
> sections
> is inconsistent in order. In particular, "'hist' trigger examples" is
> erroneously numbered as 6.2, which is a leftover from=C2=A0 b8df4a3634e08=
a
> ("tracing: Move hist trigger Documentation to histogram.txt").
>=20
> Fix the order.

Looks good to me, thanks!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0Documentation/trace/histogram.rst | 34 +++++++++++++++-------------=
-
> --
> =C2=A01 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/trace/histogram.rst
> b/Documentation/trace/histogram.rst
> index af6d2e15568ebd..d158dadaa42447 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -186,8 +186,8 @@ Documentation written by Tom Zanussi
> =C2=A0=C2=A0 The examples below provide a more concrete illustration of t=
he
> =C2=A0=C2=A0 concepts and typical usage patterns discussed above.
> =C2=A0
> -'special' event fields
> -------------------------
> +2.1. 'special' event fields
> +---------------------------
> =C2=A0
> =C2=A0=C2=A0 There are a number of 'special event fields' available for u=
se as
> =C2=A0=C2=A0 keys or values in a hist trigger.=C2=A0 These look like and =
behave as
> if
> @@ -204,16 +204,16 @@ Documentation written by Tom Zanussi
> =C2=A0=C2=A0=C2=A0=C2=A0 common_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0 the cpu on which the event o=
ccurred.
> =C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0
> -Extended error information
> ---------------------------
> +2.2. Extended error information
> +-------------------------------
> =C2=A0
> =C2=A0=C2=A0 For some error conditions encountered when invoking a hist t=
rigger
> =C2=A0=C2=A0 command, extended error information is available via the
> =C2=A0=C2=A0 tracing/error_log file.=C2=A0 See Error Conditions in
> =C2=A0=C2=A0 :file:`Documentation/trace/ftrace.rst` for details.
> =C2=A0
> -6.2 'hist' trigger examples
> ----------------------------
> +2.3. 'hist' trigger examples
> +----------------------------
> =C2=A0
> =C2=A0=C2=A0 The first set of examples creates aggregations using the kma=
lloc
> =C2=A0=C2=A0 event.=C2=A0 The fields that can be used for the hist trigge=
r are
> listed
> @@ -1608,8 +1608,8 @@ Extended error information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Entries: 7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dropped: 0
> =C2=A0
> -2.2 Inter-event hist triggers
> ------------------------------
> +2.4. Inter-event hist triggers
> +------------------------------
> =C2=A0
> =C2=A0Inter-event hist triggers are hist triggers that combine values fro=
m
> =C2=A0one or more other events and create a histogram using that data.=C2=
=A0
> Data
> @@ -1685,8 +1685,8 @@ pseudo-file.
> =C2=A0
> =C2=A0These features are described in more detail in the following
> sections.
> =C2=A0
> -2.2.1 Histogram Variables
> --------------------------
> +2.5. Histogram Variables
> +------------------------
> =C2=A0
> =C2=A0Variables are simply named locations used for saving and retrieving
> =C2=A0values between matching events.=C2=A0 A 'matching' event is defined=
 as an
> @@ -1789,8 +1789,8 @@ or assigned to a variable and referenced in a
> subsequent expression::
> =C2=A0
> =C2=A0Variables can even hold stacktraces, which are useful with syntheti=
c
> events.
> =C2=A0
> -2.2.2 Synthetic Events
> -----------------------
> +2.6. Synthetic Events
> +---------------------
> =C2=A0
> =C2=A0Synthetic events are user-defined events generated from hist trigge=
r
> =C2=A0variables or fields associated with one or more other events.=C2=A0=
 Their
> @@ -1846,7 +1846,7 @@ the command that defined it with a '!'::
> =C2=A0At this point, there isn't yet an actual 'wakeup_latency' event
> =C2=A0instantiated in the event subsystem - for this to happen, a 'hist
> =C2=A0trigger action' needs to be instantiated and bound to actual fields
> -and variables defined on other events (see Section 2.2.3 below on
> +and variables defined on other events (see Section 2.7. below on
> =C2=A0how that is done using hist trigger 'onmatch' action). Once that is
> =C2=A0done, the 'wakeup_latency' synthetic event instance is created.
> =C2=A0
> @@ -2094,8 +2094,8 @@ histogram::
> =C2=A0=C2=A0=C2=A0=C2=A0 Entries: 7
> =C2=A0=C2=A0=C2=A0=C2=A0 Dropped: 0
> =C2=A0
> -2.2.3 Hist trigger 'handlers' and 'actions'
> --------------------------------------------
> +2.7. Hist trigger 'handlers' and 'actions'
> +------------------------------------------
> =C2=A0
> =C2=A0A hist trigger 'action' is a function that's executed (in most case=
s
> =C2=A0conditionally) whenever a histogram entry is added or updated.
> @@ -2526,8 +2526,8 @@ The following commonly-used handler.action
> pairs are available:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kworker/3:2-135=C2=
=A0=C2=A0 [003] d..3=C2=A0=C2=A0=C2=A0 49.823123: sched_switch:
> prev_comm=3Dkworker/3:2 prev_pid=3D135 prev_prio=3D120 prev_state=3DT =3D=
=3D>
> next_comm=3Dswapper/3 next_pid=3D0 next_prio=3D120
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 <idle>-0=C2=A0=C2=A0=C2=A0=C2=A0 [004] ..s7=C2=A0=C2=A0=C2=A0 =
49.823798: tcp_probe:
> src=3D10.0.0.10:54326 dest=3D23.215.104.193:80 mark=3D0x0 length=3D32
> snd_nxt=3D0xe3ae2ff5 snd_una=3D0xe3ae2ecd snd_cwnd=3D10 ssthresh=3D214748=
3647
> snd_wnd=3D28960 srtt=3D19604 rcv_wnd=3D29312
> =C2=A0
> -3. User space creating a trigger
> ---------------------------------
> +2.8. User space creating a trigger
> +----------------------------------
> =C2=A0
> =C2=A0Writing into /sys/kernel/tracing/trace_marker writes into the ftrac=
e
> =C2=A0ring buffer. This can also act like an event, by writing into the
> trigger

