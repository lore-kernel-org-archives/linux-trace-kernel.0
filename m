Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031249;
	b=3QoGbUe9lp4WZK3YgTaNpx2H4PkpDlNc3yy4jxJmmVABP5zI92KCS343faCWW6NmzGoI
	 LhRvN1tAN++52brCxMuHErvKo5Ij5zcFnG8pdOoUeiiyIJ9W+bjMjmzSspxICWIgr7yNA
	 6qx0fGmiIOHtziRLbiiKCOUXdTldrcVMASORaL1ytz0CRJSIfSrsqBtE1fs/iEGVvuste
	 HxQQa2YdVNngKAVheomVGVy/s0nKEm1bFQMeU//ROtGPNfxbve9TGaOpMvRoI7I761AyN
	 xG3zPMr1jQl9jb5yORfFU8svFUP/FQKvfLYlXZnGO3Lx4HjwOsFdTMNuRaMkpfXCi/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FF3r/eYxoaCj6zb4qykdHSTAdQtZxx1/brdBN243DLg=;
	b=Atgql0hf3uiixLCoJiynhjXZyuJCzHXERRmKzBFtsZ/D2tlo6nXsrk5a+P+C16Ix3eE8
	 kd5kr39VI0WGciv2Nz4aHw7zK5isqtDY0u46WN8uY1HKv3uwsSi15q37C1SbUHP/J7NMX
	 LOs/i8xrUwwwqj/rwIF3AW7Aw5t9WiiAjGY7CoBsBYcTFaWuakj4FNKl/Qy2E4lE7C6XL
	 KnDoPJrVS+YPxWDCzLtGEOAZlQgN6TxHVfoewr8L0pgbdkS0U3vmBSgYJyqzqr396qH1H
	 UNXi3rkGw6Aic66jrNQWlQBLElHgmzIyJ/bMTh66OoSGTXuLxXjfNtlrEclvo4gn7Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WjNBqs/N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AE606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjNBqs/N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CD81F000C4;
	Wed, 18 Nov 2026 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031249;
	bh=FF3r/eYxoaCj6zb4qykdHSTAdQtZxx1/brdBN243DLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjNBqs/N7BrQkn3tdhgmTtbQzIYk3oRl3refg/UlosmCUHVHmMxc+VesIAsaJXXvo
	 WHCl6BhEGUyzJcrqJUz4sOQWMHxJWqJrRSv1jrS9ujXej8HsP94GXZpz+6QBqtz0UT
	 wdBFV4m3meapJ7kFMxr3uO2bj6Jt1/oJtO1DdBrljrN+OXaz1zt/TQjfWaHAsYXG79
	 YdHrJkON/JhNyfSrTo0PPBhIH/JoIXdeTQ7vQyuL0EC7HUSD9dLp84B0rCdYTwwkVR
	 l4484R+ymIKidJunJHAiIL0tJtRrp4yWPJrBeA7dxHenG60UjwMnYBXfD9oDnQjF1s
	 I/c0kois3U9LA==
Message-ID: <sashiko-outbox-221890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/17] platform/x86/intel/ifs: Track and report scan
 results on a per-CPU basis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261118193259.519568-12-ehab.ababneh@intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com>
 <20261118193259.519568-12-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:47:28 +0000
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
- [Medium] platform/x86/intel/ifs: stale ifsd->scan_details in
  ifs_test_core()
- [Medium] platform/x86/intel/ifs: update_group_status() clobbers
  passing CPUs
--

commit 3bcc71cc2c29c09c3eadc3e6e70f27cf28c60879
Author: Jithu Joseph <jithu.joseph@intel.com>

platform/x86/intel/ifs: Track and report scan results on a per-CPU basis

This commit records In-Field Scan test results in a per-CPU structure for
all CPUs in the tested group, restarting from the lowest chunk reached
across the group and evaluating results across all CPUs sharing the scan
engine.

> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index 783b29f234ba2..b93d8de4ca063 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c

[ ... ]

> @@ -211,12 +205,103 @@ static int doscan(void *data)
>  	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
> =20
>  	/* Pass back the result of the scan */
> -	if (cpu =3D=3D first)
> +	if (cpu =3D=3D ifsd->cpu)
>  		params->status =3D status;
> =20
> +	pcpu_scan->test_details =3D status.data;
> +
>  	return 0;
>  }
> =20
> +#define get_scan_status(stat) ((union ifs_status *)(&((stat)->test_detai=
ls)))
> +
> +static void update_group_status(struct device *dev, int reason)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan =3D per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status =3D get_scan_status(pcpu_scan);
> +		/* Don't hide an error code reported by the hardware */
> +		if (scan_status->error_code =3D=3D IFS_NO_ERROR)
> +			scan_status->error_code =3D reason;
> +	}
> +}

[Severity: Medium]
Can update_group_status() overwrite scan_status->error_code on a CPU that
has already completed all chunks?

When one CPU in the group finishes through to_stop (leaving chunk_num >
to_stop and error_code =3D=3D IFS_NO_ERROR) while another CPU stalls on an
earlier chunk until the test times out or exhausts retries,
update_group_status() sets error_code to reason on the completed CPU as
well.  update_group_result() then sees a non-zero error_code and marks that
passing CPU as SCAN_NOT_TESTED.

[ ... ]

> +static void update_group_result(struct device *dev, int stop_chunk)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	u32 reached_chunk;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan =3D per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status =3D get_scan_status(pcpu_scan);
> +		reached_chunk =3D ifsd->generation ? scan_status->gen2.chunk_num :
> +				scan_status->gen0.chunk_num;
> +
> +		if (scan_status->signature_error) {
> +			pcpu_scan->test_result =3D SCAN_TEST_FAIL;
> +			message_fail(dev, lcpu, *scan_status);
> +		} else if (scan_status->control_error || scan_status->error_code ||
> +			   reached_chunk <=3D stop_chunk) {
> +			/* E.g. another CPU in the group stopped the scan */
> +			if (!scan_status->control_error && !scan_status->error_code)
> +				scan_status->error_code =3D IFS_SW_PARTIAL_COMPLETION;
> +			pcpu_scan->test_result =3D SCAN_NOT_TESTED;
> +			message_not_tested(dev, lcpu, *scan_status);
> +		} else {
> +			pcpu_scan->test_result =3D SCAN_TEST_PASS;
> +		}
> +
> +		if (lcpu =3D=3D ifsd->cpu)
> +			ifsd->status =3D pcpu_scan->test_result;
> +	}
> +}

[ ... ]

> @@ -258,6 +348,7 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	while (to_start <=3D to_stop) {
>  		if (time_after(jiffies, timeout)) {
>  			status.error_code =3D IFS_SW_TIMEOUT;
> +			update_group_status(dev, IFS_SW_TIMEOUT);
>  			break;
>  		}
> =20
> @@ -272,15 +363,16 @@ static void ifs_test_core(int cpu, struct device *d=
ev)
>  		status =3D params.status;
> =20
>  		/* Some cases can be retried, give up for others */
> -		if (!can_restart(status))
> +		if (!can_restart_test_group(dev))
>  			break;
> =20
> -		status_chunk =3D ifsd->generation ? status.gen2.chunk_num : status.gen=
0.chunk_num;
> +		status_chunk =3D group_min_chunk(ifsd);
>  		if (status_chunk =3D=3D to_start) {
>  			/* Check for forward progress */
>  			if (--retries =3D=3D 0) {
>  				if (status.error_code =3D=3D IFS_NO_ERROR)
>  					status.error_code =3D IFS_SW_PARTIAL_COMPLETION;
> +				update_group_status(dev, IFS_SW_PARTIAL_COMPLETION);
>  				break;
>  			}
>  		} else {
> @@ -295,16 +387,7 @@ static void ifs_test_core(int cpu, struct device *de=
v)
> =20
>  	/* Update status for this core */
>  	ifsd->scan_details =3D status.data;
> -
> -	if (status.signature_error) {
> -		ifsd->status =3D SCAN_TEST_FAIL;
> -		message_fail(dev, cpu, status);
> -	} else if (status.control_error || status.error_code) {
> -		ifsd->status =3D SCAN_NOT_TESTED;
> -		message_not_tested(dev, cpu, status);
> -	} else {
> -		ifsd->status =3D SCAN_TEST_PASS;
> -	}
> +	update_group_result(dev, to_stop);
>  }

[Severity: Medium]
Can ifsd->scan_details diverge from the target CPU's per-CPU test_details?

ifs_test_core() writes status.data to ifsd->scan_details before
update_group_result() runs.  If another CPU in the group aborts the scan
with a non-restartable error while ifsd->cpu stopped at reached_chunk <=3D
stop_chunk with no error, update_group_result() sets
IFS_SW_PARTIAL_COMPLETION in pcpu_scan->test_details and sets ifsd->status
to SCAN_NOT_TESTED, leaving ifsd->scan_details (exposed via sysfs details)
with error_code =3D=3D 0.  Also, the timeout path unconditionally sets
status.error_code =3D IFS_SW_TIMEOUT, overwriting any retryable hardware
error code from the previous iteration that update_group_status()
preserved in pcpu_scan->test_details.

Assigning ifsd->scan_details =3D pcpu_scan->test_details when lcpu =3D=3D
ifsd->cpu in update_group_result() would keep both in sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193259.5195=
68-1-ehab.ababneh@intel.com?part=3D11
