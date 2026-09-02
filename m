Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECE49B210
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354062; cv=none; b=KLx0c1teefZx79DrQoVXkQbhkGdfGrhBGtw84iiOUQTo8wU54H8r2ff/rxqt5uRRS6IgP80tETU0u4lHRa7NVLZcy4ICDURGfdEI8ZZrR8Aemn5um7rmvbbKCBWN1vm+PBnZCfzB9+3Ds6LB8YAaGpLvITLF2fQuIpR1A7eV2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354062; c=relaxed/simple;
	bh=+gp7Q6PMTQ28kUW7Tp8lCxH4mgpKGbF2CWdLWc1zss8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFq9+45I3sCHc/mfsPUrGfWMQAoHtC1tHKPg1ouQPlBs5y93f3EiLOP5Vpcvw9CjCH3EzDGQvZ+AxGqSBJ4dDTx4IU6W0siy7VVLK25wt+BK4GglvBCsm/ugHC461+HHbXuX095SxFbfXTdn2PGdGAJYmkS2wfqo2Fh9locNl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd9BoJap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd9BoJap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961641F00ACF;
	Wed,  2 Sep 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354060;
	bh=WeIkHW0zvLxkEjqBB7X0Un21CMRqdUL+aYbxitrj6tA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fd9BoJapoJuRZThN7WQ2VIqPVSQes6GD6+w1+hY8UdY21DI/dwY0iaiAZ4BixCTpW
	 3twTwCuohkBy97DERJLy1pAhbGgM8nX3WGwLbbLshh435EetUYjPYiK+UwDip9Qlol
	 qT7YGh2agUqYTMBaSIvAlYDOhXNaMSZloIfw3mzBLKaR+o2/FwXzB5rkolqzCMnbKY
	 kgPYqy5112reMl8uw8CuxZHDTrdAq7FxhnSiv2mfoTp7KpJp9p+0GNQGoRYrNZHq4G
	 Am3MbXzpNT1hchqrSTXQsdsHzoSdEjUDFvQDAzyshl3UXKJ8oStX9r6UhpU8Y02a6k
	 dvhnlLs5opcxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] rtla/osnoise: Record IPI count in osnoise top
Reply-To: sashiko-reviews@lists.linux.dev
To: "Valentin Schneider" <vschneid@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902123942.695822-3-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
 <20260902123942.695822-3-vschneid@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:01:00 +0000
Message-Id: <20260902130100.961641F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Out-of-bounds read and potential unaligned access when parsing t=
he dynamically sized cpumask trace field with CPU_AND.
- [Medium] Missing return value check for tep_get_field_val() leaves dst_cp=
u uninitialized, leading to out-of-bounds memory accesses.
--

commit ff03318823c0d1c72fb9d5969112afecabf91462
Author: Valentin Schneider <vschneid@redhat.com>

rtla/osnoise: Record IPI count in osnoise top

This commit leverages the ipi_send_cpu and ipi_send_cpumask trace events to
record the count of IPIs sent to monitored CPUs. It adds these statistics to
the osnoise top output, enabled via the new --ipi command line option.

> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index 512a6299cb018..7b5ae5336cf08 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c

[ ... ]

> @@ -275,12 +282,93 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
>  	return -1;
>  }
> =20
> +static void account_ipi(struct osnoise_tool *tool, unsigned long long ds=
t_cpu)
> +{
> +	struct osnoise_top_cpu *cpu_data;
> +	struct osnoise_top_data *data;
> +	unsigned long long inc =3D 1;
> +
> +	data =3D tool->data;
> +	cpu_data =3D &data->cpu_data[dst_cpu];
> +
> +	update_sum(&cpu_data->ipi_count, &inc);
> +}
> +
> +/*
> + * osnoise_ipi_cpu_handler - this is the handler for single CPU IPI even=
ts.
> + */
> +static int
> +osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
> +		     struct tep_event *event, void *context)
> +{
> +	struct osnoise_tool *tool;
> +	struct osnoise_params *params;
> +	unsigned long long dst_cpu;
> +	struct trace_instance *trace =3D context;
> +
> +	tool =3D container_of(trace, struct osnoise_tool, trace);
> +	params =3D to_osnoise_params(tool->params);
> +
> +	tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
> +
> +	if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
> +		account_ipi(tool, dst_cpu);

[Severity: Medium]
If tep_get_field_val() fails to extract the field (for instance, due to a
trace format mismatch), the return value is ignored and dst_cpu is left
uninitialized.

Could this result in an out-of-bounds read inside the CPU_ISSET() macro, or
an out-of-bounds heap write when dst_cpu is passed to account_ipi() and used
as an index for data->cpu_data[dst_cpu]?

> +
> +	return 0;
> +}
> +
> +static cpu_set_t cpumask_tmp_cpus;
> +
> +/*
> + * osnoise_ipi_cpumask_handler - this is the handler for broadcasted IPI=
 events.
> + */
> +static int
> +osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *reco=
rd,
> +			 struct tep_event *event, void *context)
> +{
> +	struct trace_instance *trace =3D context;
> +	struct osnoise_tool *tool;
> +	struct osnoise_params *params;
> +	struct tep_format_field *field;
> +	cpu_set_t *event_cpus;
> +	int len;
> +
> +	tool =3D container_of(trace, struct osnoise_tool, trace);
> +	params =3D to_osnoise_params(tool->params);
> +
> +	field =3D tep_find_field(event, "cpumask");
> +	if (!field)
> +		return 0;
> +
> +	event_cpus =3D tep_get_field_raw(s, event, "cpumask", record, &len, 1);
> +	if (!event_cpus) {
> +		err_msg("Failed to get cpumask field\n");
> +		return 0;
> +	}
> +
> +	CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);

[Severity: Medium]
The event_cpus pointer returned by tep_get_field_raw() points to dynamically
sized raw bytes according to the len parameter. The glibc CPU_AND() macro
assumes both source arguments are full cpu_set_t objects and unconditionally
operates on 128 bytes.

Does this cause an out-of-bounds read and potential unaligned access when
parsing the trace field with CPU_AND()?

> +
> +	/*
> +	 * Computing the mask weight is overkill but there is no leaner option
> +	 * provided by glibc, e.g cpumask_first() or somesuch.
> +	 */
> +	if (CPU_COUNT(&cpumask_tmp_cpus)) {
> +		for (int cpu =3D 0; cpu < nr_cpus; cpu++) {
> +			if (CPU_ISSET(cpu, &cpumask_tmp_cpus))
> +				account_ipi(tool, cpu);
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902123942.6958=
22-1-vschneid@redhat.com?part=3D2
