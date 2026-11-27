Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796194;
	b=fGq+lqLzb7Xq7HquQ3bQRXlT4QyxEYN3qDEDRC9AaQjC1DShPoLycEAjcSxpnI5ixDWn
	 gQ/9GhBAVcIlxZQSdU01wpWVbajQeci80IRNCfDEAQZepj9rXu96mkXz4ZQzr8S7yoQ5E
	 1fux3mfy3e31sQqMSQhkSmth5jZWcL2iMH/L6Q1vDpQrHgiobqlxYlqZ8msrSYpJxrQt6
	 ZQ9jAZBNvyY+p+LBLzPBZYteBQDthnVQGO0GLKHdHE0X09602psMdMwJ4G8tSCwWgm/3g
	 BcbQKz2wPfFgPSDQz7kF8DlkDfvcdoFA4UAsDH7mVMuiKOlgxG6YOT3KGXEqXAI8JIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m+pfCm1AlqbmXI6FznJCnGTT3KUiSAkVYAcrnahsaIs=;
	b=GklpcwM+Fml5D9YIBjm3wRJXZRUlaqYGmZJzhe4r8R40wqcNPqBJZUAZFCVzC2+HBW9p
	 l6F8RX0EjsrZnhcmKPfDDDo6C7Sp1ahe5x37d35El0jsiXuB0BwyNg+o6sWdMAQ2/pj2d
	 PKqvsYqiL9Dzi1sSZRHZTN3JxhppzPmTmMQAE+RGE7hEZQzrHSwXp2Lx88BpWa0oQDy/N
	 /0waNvakQJS8zfDXlB7faLLRBXINz+O7OSZvtfPukvy0OpyT/Xu065m26E7jID8iN9UeO
	 LfvHK61i47KvW8+Qn7Zgt5X3ZHhJa0HiZigtY+QARuE8SNtVHGjhZzo0otFmjXbJfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWSKV8N3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA571606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWSKV8N3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BE71F00898;
	Fri, 27 Nov 2026 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796193;
	bh=m+pfCm1AlqbmXI6FznJCnGTT3KUiSAkVYAcrnahsaIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWSKV8N3VvqjSnq3RuTihSXV3Mi1dbun2ych9zi+TciVwoppY3V+rEMxScSeF9d8W
	 RIx83jtvDR6fUC3bitnlww9koc8iW+LI2DMmqnPFy2re5dJz6bmyP2XvjkyQWhrVYr
	 5sJ015eT4fRjZn+nu+6TEjxhS6jXSLXbY8UYE/LST4pheUO0PIicitN+Qgas66sH6a
	 6Ozmkk2K1RK+tMSBwe0nw2JLpgF5+ui1T/qHOPkKDkkQ5fe88ZsJ55r4c+cTHCMGAL
	 jgLLB2hMSkCABxRReBZZJW1OGQGaNEhFiHBTBNZ+VyqBV/bni5/pfUu1Mhqd5Ox/Rc
	 leIIhPqUcZoZw==
Message-ID: <sashiko-outbox-237856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/10] rtla/tests: Add runtime tests for aa action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomas Glozar" <tglozar@redhat.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261127153206.134322-4-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
 <20261127153206.134322-4-tglozar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:16:33 +0000
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
- [Medium] rtla/tests: --aa-only test fails in BPF mode in
  timerlat_top_bpf_main_loop()
--

commit 3e2a3aa570e971109ae2e849934141658e12c520
Author: Tomas Glozar <tglozar@redhat.com>

rtla/tests: Add runtime tests for aa action

This commit adds runtime test cases covering the auto-analysis action for
timerlat and verifying that osnoise rejects the action.

> diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tes=
ts/timerlat.t
> index 1d317c851a0fa..d4f660d32f882 100644
> --- a/tools/tracing/rtla/tests/timerlat.t
> +++ b/tools/tracing/rtla/tests/timerlat.t
> @@ -122,18 +122,31 @@ check_top_q_hist "trace output through --on-thresho=
ld trace" \
>  	"timerlat TOOL -T 2 --on-threshold trace" 2 "^  Saving trace to timerla=
t_trace.txt$"
>  check_top_q_hist "trace output through --on-threshold trace with custom =
filename" \
>  	"timerlat TOOL -T 2 --on-threshold trace,file=3Dcustom_filename.txt" 2 =
"^  Saving trace to custom_filename.txt$"
> +
>  check_top_q_hist "exec command" \
>  	"timerlat TOOL -T 2 --on-threshold shell,command=3D'echo TestOutput'" 2=
 "^TestOutput$"
> +
> +check_top_hist "aa action" \
> +	"timerlat TOOL -T 2 -d 3s --on-threshold aa" 2 "analyzing it"
> +check_top_hist "aa action at end" \
> +	"timerlat TOOL -T 2 -d 3s --on-end aa" 2 "analyzing it"
> +check_top_hist "aa action with continue" \
> +	"timerlat TOOL -T 2 -d 3s --on-threshold aa --on-threshold continue" 0 =
"analyzing it"
> +check "aa action with --aa-only" \
> +	"timerlat top -d 3s --aa-only 2 --on-threshold aa --on-threshold contin=
ue" 0 "analyzing it" "Timer Latency"

[Severity: Medium]
Does the "aa action with --aa-only" test fail when run in BPF mode
(RTLA_NO_BPF=3D0)?

In BPF/mixed mode, timerlat_top_bpf_main_loop() takes the early return for
params->aa_only as soon as the first threshold event arrives, without
running common_threshold_handler() or checking should_continue_tracing():

tools/tracing/rtla/src/timerlat_top.c:timerlat_top_bpf_main_loop() {
	if (params->aa_only) {
		/* Auto-analysis only, just wait for stop tracing */
		timerlat_bpf_wait(-1);
		return 0;
	}
    ...
}

Because it returns before SIGALRM sets stop_tracing, run_tool() sees
stopped =3D=3D true (setting return_value =3D FAILED, exit status 2) and sk=
ips
the end-of-run ops->analyze() call because aa_action_present(params) is
true:

tools/tracing/rtla/src/common.c:run_tool() {
    ...
	if (stopped) {
		printf("%s hit stop tracing\n", ops->tracer);
		return_value =3D FAILED;
	}

	if (ops->analyze && !aa_action_present(params))
		ops->analyze(tool, stopped);
    ...
}

As a result, neither the threshold actions nor end-of-run auto-analysis
run, "analyzing it" is never printed, and rtla exits with status 2 instead
of 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127153206.1343=
22-1-tglozar@redhat.com?part=3D3
