Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675847D44A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357320; cv=none; b=EZ6Gs2H9s3IIWDW4s+LTrEwiEk9zPo1XZrcnCjTYQTeKKxxN1tizrPPxBij5vlg6pvyB5D//iCJfRkqVU7Vx9Vwro8YTwkiIs2GMFTxsESQUIUU5C//omjR4//hkeOKEbGRciyPWxn7b3kv3gmhFgoQPLKjCfx5Q9eZqzT5d2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357320; c=relaxed/simple;
	bh=jfdE2nG5pNX1G/psaPW085o1MgM1bA59x2+rO9S80W0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9JY/xJc3/HRIHbYRUexIB4Pss/J4G7eaNK0ujjI4BLNNojrybxGe/G5H0ZT4kOwepZTb1j9jBgh5Azyb8+0CIswo+PiGuek6+cLorwCivk9nnuOH4zFYWXcftfmJD3kmx1t4pOCBnSLNU/mVkf9UPj2y+Gui4o81vbkpU+1uIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkHwTP3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkHwTP3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7C51F000E9;
	Wed,  2 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357319;
	bh=TnnID2oKD2qyugiiTtsyeGsrJCfCyrWFr0lU5tGKjEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FkHwTP3Qrr1CwynD4F0TJU/523HR9CckGCTuk9X8BY8K10quLJ/sw8XdTwe7KoGhp
	 xaEyikDfz2lT5sC6KXEBdIKanvjOoVLnBuRGb50FWzS1/oyb28H/R5wNIOtzYxqf8q
	 HOb5GEFvtbDi3beee4gNCFtvJ3jJMFvXLvm4TPreg5ixGAedx98zJnowwCNW6pYR+Z
	 LsMIfmwL0FkQoLCs8vKLqMNunWDaChlsBbdNBWm/YgeaskCiV9c/LD3ziWnk1Qh8Ve
	 pocrYmYQIdTyJA4KqnQuO9Ci4teC7WrCRGlEC7yiEXzgySpg8osnmzpEZMBrDtUGzY
	 cYgtgTgb1TUyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] rtla/osnoise: Trace IPI events when recording a
 trace file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Valentin Schneider" <vschneid@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902123942.695822-9-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
 <20260902123942.695822-9-vschneid@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:55:18 +0000
Message-Id: <20260902135519.1E7C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Out-of-bounds read in osnoise_ipi_cpumask_handler due to using C=
PU_AND on a dynamically sized trace event field.
--

commit 25aed6d1003b38e3162e406562eb91e3fee93066
Author: Valentin Schneider <vschneid@redhat.com>

rtla/osnoise: Trace IPI events when recording a trace file

IPIs can now be monitored and accounted by osnoise top. When that is
the case, also record them when saving a trace file. To match what is
being recorded by the tool for its own analysis, event filters are
applied to the events recorded to the trace output.

> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index afab2f341a1e9..87d28865515b5 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -392,7 +392,7 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, stru=
ct tep_record *record,
>   */
>  struct osnoise_tool *osnoise_init_top(struct common_params *params)
>  {
> -	bool ipi_filters_enabled =3D false;
> +	bool ipi_filters_enabled;
>  	struct osnoise_tool *tool;
>  	int retval;

[Severity: Medium]
Can this lead to an out-of-bounds read when processing the IPI cpumask?

Looking at osnoise_ipi_cpumask_handler() above, it processes the
ipi_send_cpumask trace event:

tools/tracing/rtla/src/osnoise_top.c:osnoise_ipi_cpumask_handler() {
    ...
    cpumask =3D tep_get_field_raw(s, event, "cpumask", record, &len, 1);
    ...
    event_cpus =3D (cpu_set_t *)cpumask;
    ...
    CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);
    ...
}

tep_get_field_raw() returns a pointer to a dynamically sized field and its
actual length in len.

Since the code ignores len and casts the pointer to a cpu_set_t *, and
glibc's CPU_AND() unconditionally iterates and reads sizeof(cpu_set_t)
(128 bytes) from the source pointers, does this read well past the end
of the trace field for the cpumask (which would be 8 bytes for 64 CPUs)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902123942.6958=
22-1-vschneid@redhat.com?part=3D8
