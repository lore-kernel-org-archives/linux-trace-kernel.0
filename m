Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111006;
	b=y40Hu1ZwnyFFOK6qrvQK01D4eFgX+sxjhF4nOGuyUSUU8Fi91jMsSqt1DyzCV5YfYvDC
	 K4THoZSAvkXuEpFtKynBqqi5IL4ZwLMPZMvShFTZsdUKAKu0cHALljZSJw6noFjO1JiaA
	 NNaGTobX9L1wH/IswpkI7RG9eAUu8+FwOmpkO7njXVv9FTrNrSwe9DVfFBUCZFgwm0WuV
	 DQpsrKIkJMhmW+OWjQKiYgbbd9eaIxnP5ULIoG17WV4S80ldWgjtaafdGHUU1vtpXYSlh
	 rp7ko1SI3V81KjFPLlx3YcaP4ggINZr9Z/vanFOqd0moKigQwcQLN7bGl5OqsJV8F7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kT7N8QJU0niOA9/LlNY0wLj7foTk2MAN/iIrWeQOcXA=;
	b=C+4QY5VVwSK7n1SAy3CuGSm8riqdwFeMZ6fpV8UE5Gg9WqxOPEAkM9UH3pxQco26av+d
	 D9nw4JynzyfPg3h0MyhbL3/m8utK0lCalisKciVamqKsKlApRTVja3Y6X6/Cs1KTId+kH
	 OcQ8t5sY9LVIT1nI+ZFShr4TfG08T6Vc57HyR1CN2I1abnwBGzZRmzSLGTjEVwz/o01Eu
	 mZQ0bOCJig6bTNw2JMWVhuq7Bn00uRSFJ14oyHMOR87m9xer3IN5x7k9uUWOnn2VMV8zf
	 pxLWyzPiDC5gF1qZuDGkakiSOjOweevplLLAU32nzHfMLYRPY9XUT5XCrrrIyA7yPJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nio9iLky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1D606A324
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nio9iLky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DDC1F000C4;
	Thu, 19 Nov 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111006;
	bh=kT7N8QJU0niOA9/LlNY0wLj7foTk2MAN/iIrWeQOcXA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Nio9iLkyezhwazxm5z2pz7XjpvAJkrjG4uaG/jSUcb49OMdXevn1zrs+gewblS2mE
	 RlNQsLfy2KTdFPl/Hg8m6FZQSKNWwRnKmWOl9i1+nOcL0ZmLu/d1bPZ14V6zBfXq50
	 A8G/4edGohNXd2SO+dZqetRJUwdAD+84LbT3IpRz27ply+RmJc/qra8gm9Wm3+TVXA
	 LlSN9wRjX4PvEp8k79/GVk0hMb4oI2CFzfRJ8XJLEagAh/+SQfvZGsog1dFpgs90UC
	 vNbGwrqs87xrbf7guwFZyWg7o8/IDFHPX3khOjeZrexhKuX34HZnaS74ZEszTJnsdt
	 AzhZt/S3BiuIA==
Message-ID: <sashiko-outbox-223736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Add notrace to event functions that hook to
 ftrace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261119124319.3a8bfe50@gandalf.local.home>
References: <20261119124319.3a8bfe50@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:56:45 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] tracing: missing notrace on update_event_probe() causes ftrace
  recursion
--

commit fa7d6fcf36a58e2cb33d20aff7d184dfe9c6060d
Author: Steven Rostedt <rostedt@goodmis.org>

tracing: Add notrace to event functions that hook to ftrace

This commit adds the notrace annotation to event_enable_probe(),
event_enable_count_probe(), and function_test_events_call() so they are
not traced when CONFIG_FUNCTION_SELF_TRACING is enabled.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6afed2091e19c..fa8927068609a 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -4317,7 +4317,7 @@ static void update_event_probe(struct event_probe_d=
ata *data)
>  		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
>  }
> =20
> -static void
> +static void notrace
>  event_enable_probe(unsigned long ip, unsigned long parent_ip,
>  		   struct trace_array *tr, struct ftrace_probe_ops *ops,
>  		   void *data)
> @@ -4334,7 +4334,7 @@ event_enable_probe(unsigned long ip, unsigned long =
parent_ip,
>  	update_event_probe(edata);
>  }
> =20
> -static void
> +static void notrace
>  event_enable_count_probe(unsigned long ip, unsigned long parent_ip,
>  			 struct trace_array *tr, struct ftrace_probe_ops *ops,
>  			 void *data)

[Severity: High]
Should update_event_probe() also be marked notrace (or inline)?

Both event_enable_probe() and event_enable_count_probe() run via
function_trace_probe_call() without FTRACE_OPS_FL_RECURSION and call
update_event_probe().  Because update_event_probe() is neither notrace nor
inline, GCC cannot inline it into its notrace callers and emits it with
an ftrace entry hook under CONFIG_FUNCTION_SELF_TRACING.  If an
enable_event or disable_event function probe matches update_event_probe()
(for example via a wildcard filter in set_ftrace_filter), calling
update_event_probe() re-enters function_trace_probe_call() and recurses
until the stack overflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119124319.3a8b=
fe50@gandalf.local.home?part=3D1
