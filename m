Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795297;
	b=rR2Tp3l+t6ysyelhvHcIeSnT7+rzRceujZ1dRiTNWNZ12dnvobtDuJ1AHyjlKFGyxoVO
	 WFoEFfzrC4YLi0joI+E6Weqo9rczxA5bAQaNo9NeVr94ZZlQKlmKfrAQ5A67ILMmu3XkM
	 f72mM6nGa1GYPE/+aTlHQ4OA7M+58syBX/jwavruIphx5954PmAiIFfv/8XytL3Jh2mpG
	 43qHmQkG9lV2V81g6O927+BR0UhuL8ONauit4pyxF2zbitpUqAUJnqh7/KqFfJHrIW61K
	 4UtxuOkCF+GI9mHcb07wveArQSVoqiRQd7lC7kaRVTKRM++u5FaR8SAFgoDXDAguEiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OMRFBEniPDMOejf3jQ9XCBxrfLRI53ylOcswjthA7HU=;
	b=gsmXYu4eHNIO3PtM+MqUFkyR93T4PTOuhdlM7C/fHsEibUusky/dQmZYhPBQ+CjHmWMc
	 DsKozLuS7oBwhSohVG6f8mtTbBK8aOLD43qd9G4b+iOCcTbThiZv6M5ScQz0hXmkScCe4
	 eFTcIAMfnYszrsVVCKSEVqdOfQcrqFzIvzkJUNnus14aNlghM3oWHMsV9ULx6dMt2/3Ra
	 0RCFkySdCjam/giGG4rbHY/QNHnWBABVQgYpI4gyFtmPN6P5vKo0MN33iNQEmN0lKZEne
	 WOs6HfgzzRzTZBHDUmZCxx57NUVqdLWvLVX/kwGmhlFXiNwI171BEeLtQ74ecg0g4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbqDk4Ru;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27607606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbqDk4Ru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625691F0089F;
	Fri, 27 Nov 2026 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795296;
	bh=OMRFBEniPDMOejf3jQ9XCBxrfLRI53ylOcswjthA7HU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbqDk4Rusvf1YTpEqQrJHpkeQI14MgL5Au6XwvLDH4mTuuaPZyC8BkPO/1SSejaS4
	 tpjDcSBqhh3FZKiCUkTQ8oTSWojnXGTgbtbJWqdeSmdG21CPLcYyZSEfEIzQxXZ7I8
	 UQu1LnmpVQ07Y6NPyyY1NsgPtRtYVRArYrGkOLLkF3LFOMkajXpMF7IA1xSuDtSfvI
	 pN8KbN/wGscfGe/jTsUE3zVYQBoCatLO5EyaxfrtcnqM+Yh1Axdcx57J2FXzIDtiwK
	 t3k8hiEBsCKIteit8l3DZZEhYpw0qWeQqaIuJacaNFZDfwq6bS+LAbsBs5OF47Uh5d
	 UgK6mYkWQN7+w==
Message-ID: <sashiko-outbox-237811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/10] rtla: Support auto-analysis as an action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomas Glozar" <tglozar@redhat.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261127153206.134322-2-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
 <20261127153206.134322-2-tglozar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:01:36 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] rtla: timerlat_top_bpf_main_loop() skips aa action when
  --aa-only is set
- [Low] rtla: repeated aa action on stopped trace wipes state in
  timerlat_auto_analysis()
--

commit 3b613e42d174f9f624d5fde84c78336d0d724233
Author: Tomas Glozar <tglozar@redhat.com>

rtla: Support auto-analysis as an action

This commit adds an "aa" action for --on-threshold and --on-end so that
timerlat auto-analysis can be ordered with other actions and run multiple
times when tracing continues, while skipping the default end-of-run
auto-analysis when an aa action is configured.

> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/com=
mon.c
> index ac4172bcc4444..e085eb6c8f13f 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
[ ... ]
> @@ -290,17 +296,18 @@ int run_tool(struct tool_ops *ops, int argc, char *=
argv[])
> =20
>  	ops->print_stats(tool);
> =20
> -	actions_perform(&params->end_actions);
> -
>  	return_value =3D PASSED;
> =20
>  	stopped =3D osnoise_trace_is_off(tool, tool->record) && !stop_tracing;
> +
> +	actions_perform(&params->end_actions, stopped);
> +
>  	if (stopped) {
>  		printf("%s hit stop tracing\n", ops->tracer);
>  		return_value =3D FAILED;
>  	}
> =20
> -	if (ops->analyze)
> +	if (ops->analyze && !aa_action_present(params))
>  		ops->analyze(tool, stopped);

[Severity: Medium]
Does skipping ops->analyze(tool, stopped) here break --aa-only when
combined with --on-threshold aa?

In BPF/mixed mode (the default when BPF is available),
timerlat_top_bpf_main_loop() returns immediately after
timerlat_bpf_wait(-1) when params->aa_only is set, without calling
common_threshold_handler():

tools/tracing/rtla/src/timerlat_top.c:timerlat_top_bpf_main_loop() {
	if (params->aa_only) {
		/* Auto-analysis only, just wait for stop tracing */
		timerlat_bpf_wait(-1);
		return 0;
	}
    ...
}

Because threshold_actions never run in that path and run_tool() now skips
ops->analyze() when aa_action_present(params) is true, running rtla
timerlat top --aa-only <us> --on-threshold aa [--on-threshold continue]
performs no auto-analysis at all and ignores continue.

Also, in both BPF and tracefs modes, if --aa-only is used with
--on-threshold aa and the run finishes without hitting the threshold
(stopped is false), skipping ops->analyze(tool, false) here bypasses the
tracing_max_latency fallback in timerlat_analyze().

> diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/sr=
c/timerlat_aa.c
> index a121ff9d2c571..11ddceab208ac 100644
> --- a/tools/tracing/rtla/src/timerlat_aa.c
> +++ b/tools/tracing/rtla/src/timerlat_aa.c
[ ... ]
> @@ -752,6 +816,9 @@ void timerlat_auto_analysis(int irq_thresh, int threa=
d_thresh)
>  	struct tep_handle *tep;
>  	int cpu;
> =20
> +	/* reset any data left over from previous run */
> +	timerlat_aa_reset(taa_ctx);
> +
>  	timerlat_auto_analysis_collect_trace(taa_ctx);

[Severity: Low]
What happens if the aa action runs more than once on the same stopped
trace without an intervening continue (for example, when both
--on-threshold aa and --on-end aa are specified and tracing stops on a
threshold)?

The first call to timerlat_auto_analysis_collect_trace() drains the
per-CPU trace_pipe_raw buffers via tracefs_iterate_raw_events().  A
second timerlat_auto_analysis() call on the same stopped trace wipes
taa_ctx in timerlat_aa_reset() and reads zero events from the already
consumed pipe, producing empty analysis output (and printing empty comms
with PID 0 for every CPU if --dump-tasks is enabled).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127153206.1343=
22-1-tglozar@redhat.com?part=3D1
