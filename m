Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040852;
	b=IQDsIeXhgn9ArFlPN4FucA0F9ZPrDpIcVtQk6wxTQaA6lxAGqrHOC4ba+xLu3UcB94IW
	 72XfF9CDE0oJ1sb5mddcGz7D9koedMCcB0zHs1EpzTGCP3aR6YryIHry5sF0n1Rfpm6kn
	 +8NFRtE0E+D0cK1vrYucu0lnl0CBexIfwzJFbJNuanZlOjp1S/9ipJqJJs0VG3LXadLdS
	 HLVS4vbz5JlH3OkmXz2rQT2V6gfK8zKLXAxHNHfpX8tS4krH3+oiMbgPKfX6yOPxaLcA9
	 +AWayg11arj2GrH/jQmLkkyPF6yi1h70JNWfNmXCXaiD9K7R4eKjz9YiM3471bjH9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=izO62U5P1bkUU7GoXRqAY4Hpaamxr1pEwL37zKvuiyo=;
	b=PU6aXiOVkRjkQ5bmEssgkvyXeeTq3vIJ7mkEI1tKfNe2DZY1/YTgoO+UrvL1hGxQDsJ7
	 3lz65RCuMGtUPtF1q8UvfJ7HeShTHGzOIvVxS3jiFBWQmEfLjN6zTRzTu1Q2TkhJIkXy6
	 +LmCSHBoz/Mfi8k/6sXqUOAq7fUZdb8Zfqc1xqnmFtOwptDjDusM35HX6G2svpp8nL9ff
	 YdeeXIrOkINvs0VaeukQXUdTGFzDMZSbfTIfeyojTSTtYi0EwmPMu+ijoq8tXB2IOE483
	 UgnczpgN1ivD/wjPoxq3otSVXUcqEUgO0m0FamVq2PBudXyuAEzvGEYR9SoA1b0FcCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqvpiD0n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC0606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqvpiD0n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D5C1F01825;
	Mon, 26 Oct 2026 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793040852;
	bh=izO62U5P1bkUU7GoXRqAY4Hpaamxr1pEwL37zKvuiyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqvpiD0nlQFUmnEPJRC//WZ4zX/NXhd/4rn6CP1fWYVknNNckph1glVUh+Zdcdx5y
	 P2aUrIC0EQS4cK12Iq5U7zUTyIbLJwWcxM5bDcGKb26hi1bB4pkYTO61Wux203AWzw
	 GDvib973MqMqrJOr6ngMB8w0J7czLlalwmdEcxhnqzBGkTiFOWkcvg0ILmW1l09kFK
	 Aw8WtEV9t2irvEbRnxRdek7ffz5VN6dSaQ08lNx4d0EpDwEXwr1dpR4aqUhWRH6A6s
	 fqoVvGwuQg9MmkuQIRgPOO75fejtponAZYbW7PqvOJRa5vyjO0FVHDHRP+z0E75Sq7
	 wJ+MK0GKi+KXg==
Message-ID: <sashiko-outbox-185646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] platform/x86/intel/ifs: Track and report scan
 results on a per-CPU basis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ehab Ababneh" <ehab.ababneh@intel.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026183820.129459-12-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
 <20261026183820.129459-12-ehab.ababneh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 18:54:11 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] platform/x86/intel/ifs: broken group status handling in ifs_test=
_core()
- [Medium] platform/x86/intel/ifs: stale test_details bits in update_group_=
status()
- [Low] platform/x86/intel/ifs: ifs_scan_n zeroed after misc_register() in =
ifs_init()
--

commit 21af90f07c96c13c521c905b29cd18ddd39f88e1
Author: Jithu Joseph <jithu.joseph@intel.com>

platform/x86/intel/ifs: Track and report scan results on a per-CPU basis

This commit records In-Field Scan (IFS) results in a per-CPU structure
(ifs_scan_n) for all CPUs in a test group when tests are run
simultaneously, and updates error reporting and retry checks to operate on
the CPU group.

> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index c830a02fe7b33..08a3e519749be 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c

[ ... ]

> @@ -175,6 +180,9 @@ static int __init ifs_init(void)
>  		if (ret)
>  			goto err_exit;
>  	}
> +
> +	for_each_possible_cpu(cpu)
> +		memset(per_cpu_ptr(&ifs_scan_n, cpu), 0, sizeof(struct ifs_test_output=
));
>  	return 0;

[Severity: Low]
Can this memset() in drivers/platform/x86/intel/ifs/core.c:ifs_init() race
with an early test run?

Inside the loop above, misc_register(&ifs_devices[i].misc) registers
intel_ifs_0 and exposes its sysfs attributes (plat_ifs_groups) to userspace
before continuing the loop for subsequent test devices.

If userspace loads a batch and writes to run_test as soon as intel_ifs_0
appears, run_test_store() -> do_core_test() -> ifs_test_core() can invoke
doscan() and update_group_result() under ifs_sem while ifs_init() is
zeroing ifs_scan_n without holding ifs_sem.

Since DEFINE_PER_CPU(struct ifs_test_output, ifs_scan_n) is already
statically zero-initialized, is this loop needed at all, or should any
initialization happen before misc_register()?

> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index 09e7a81e92204..6c3d025817e77 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c

[ ... ]

> @@ -211,12 +205,76 @@ static int doscan(void *data)
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
> +		scan_status->error_code =3D reason;
> +	}
> +}

[Severity: Medium]
Does update_group_status() in drivers/platform/x86/intel/ifs/runtest.c
preserve stale bitfields in pcpu_scan->test_details from previous runs and
clobber hardware error codes from the current run?

In run_test_store() -> do_core_test() -> ifs_test_core(), the local status
variable is zero-initialized (union ifs_status status =3D {};), which commit
3114f77e9453 ("platform/x86/intel/ifs: Initialize status in
ifs_test_core()") added so that an early timeout before doscan() would not
report stale status bits. However, the per-CPU pcpu_scan->test_details
entries in ifsd->result_ptr are not cleared at the start of ifs_test_core().

If time_after(jiffies, timeout) triggers before doscan() runs on the first
iteration, update_group_status(dev, IFS_SW_TIMEOUT) only overwrites
scan_status->error_code, leaving signature_error, control_error, and
chunk_num in pcpu_scan->test_details set to values from a previous test on
those CPUs.

When update_group_result() then evaluates the results:

    if (scan_status->signature_error) {
        pcpu_scan->test_result =3D SCAN_TEST_FAIL;
        message_fail(dev, lcpu, *scan_status);
    } else if (scan_status->control_error || scan_status->error_code ||
               reached_chunk <=3D stop_chunk) {
        pcpu_scan->test_result =3D SCAN_NOT_TESTED;
        message_not_tested(dev, lcpu, *scan_status);
    }

signature_error (and control_error inside message_not_tested()) are checked
before error_code, so a stale signature_error or control_error from an
earlier run will cause a software timeout to be misreported as
SCAN_TEST_FAIL ("test signature incorrect") or a scan controller error.

In addition, if a timeout or IFS_SW_PARTIAL_COMPLETION occurs after one or
more loop iterations, update_group_status() unconditionally overwrites
scan_status->error_code across all CPUs in ifsd->grp_cpumask without
checking whether individual CPUs already recorded a hardware error_code or
completed all chunks.

Should pcpu_scan->test_details be cleared for all CPUs in ifsd->grp_cpumask
at the start of ifs_test_core(), and should update_group_status() avoid
overwriting non-zero hardware error codes?

> +
> +static bool can_restart_test_group(struct device *dev)
> +{
> +	struct ifs_data *ifsd =3D ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan =3D per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status =3D get_scan_status(pcpu_scan);
> +		if (!can_restart(*scan_status))
> +			return false;
> +	}
> +	return true;
> +}
> +
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

> @@ -272,15 +332,17 @@ static void ifs_test_core(int cpu, struct device *d=
ev)
>  		status =3D params.status;
> =20
>  		/* Some cases can be retried, give up for others */
> -		if (!can_restart(status))
> +		if (!can_restart_test_group(dev))
>  			break;
> =20
>  		status_chunk =3D ifsd->generation ? status.gen2.chunk_num : status.gen=
0.chunk_num;
>  		if (status_chunk =3D=3D to_start) {
>  			/* Check for forward progress */
>  			if (--retries =3D=3D 0) {
> -				if (status.error_code =3D=3D IFS_NO_ERROR)
> +				if (status.error_code =3D=3D IFS_NO_ERROR) {
>  					status.error_code =3D IFS_SW_PARTIAL_COMPLETION;
> +					update_group_status(dev, IFS_SW_PARTIAL_COMPLETION);
> +				}
>  				break;
>  			}
>  		} else {
> @@ -295,16 +357,7 @@ static void ifs_test_core(int cpu, struct device *de=
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
What happens in drivers/platform/x86/intel/ifs/runtest.c:ifs_test_core() and
update_group_result() when CPUs in ifsd->grp_cpumask observe different scan
statuses or stop at different chunks?

In doscan(), every CPU in the group writes its MSR_SCAN_STATUS to
pcpu_scan->test_details, but params->status is only written when
cpu =3D=3D ifsd->cpu.

1. In ifs_test_core(), can_restart_test_group(dev) checks can_restart()
across all CPUs in ifsd->grp_cpumask, but status_chunk and to_start are
computed solely from params.status (ifsd->cpu):

    status_chunk =3D ifsd->generation ? status.gen2.chunk_num : status.gen0=
.chunk_num;

If ifsd->cpu advances to status_chunk (or finishes all chunks with
status_chunk =3D=3D to_stop + 1) while a sibling CPU in ifsd->grp_cpumask h=
ad a
restartable abort at an earlier chunk C2 < status_chunk, to_start and
activate.gen0/gen2.start are updated to ifsd->cpu's status_chunk. Doesn't
this either exit the while (to_start <=3D to_stop) loop without retrying the
sibling CPU, or restart the group scan at status_chunk and skip chunks
C2 .. status_chunk - 1 on the sibling CPU (which update_group_result() will
then mark SCAN_TEST_PASS if the final pass reaches stop_chunk + 1)?

2. When retries reaches 0 in ifs_test_core(), it only checks
if (status.error_code =3D=3D IFS_NO_ERROR) on ifsd->cpu before calling
update_group_status(dev, IFS_SW_PARTIAL_COMPLETION), which overwrites
error_code on all CPUs in the group even if a sibling CPU had a specific
hardware error_code, or skips update_group_status() if ifsd->cpu had a
non-zero error_code while a sibling had IFS_NO_ERROR.

3. In update_group_result():

    } else if (scan_status->control_error || scan_status->error_code ||
               reached_chunk <=3D stop_chunk) {
        pcpu_scan->test_result =3D SCAN_NOT_TESTED;
        message_not_tested(dev, lcpu, *scan_status);
    }

The reached_chunk <=3D stop_chunk condition is evaluated when both
scan_status->control_error =3D=3D 0 and scan_status->error_code =3D=3D IFS_=
NO_ERROR
(0) (for example, when another CPU in the group aborted the scan via
!can_restart_test_group(dev)). Calling message_not_tested() with
status.error_code =3D=3D 0 hits:

    if (status.error_code < ARRAY_SIZE(scan_test_status)) {
        dev_info(dev, "CPU %d: SCAN operation did not start. %s\n", cpu,
                 scan_test_status[status.error_code]);

and logs "CPU %d: SCAN operation did not start. SCAN no error".

4. Finally, update_group_result() only updates ifsd->status when
lcpu =3D=3D ifsd->cpu (and ifs_test_core() only sets ifsd->scan_details from
ifsd->cpu). If a sibling CPU in ifsd->grp_cpumask encounters a
signature_error (SCAN_TEST_FAIL) while ifsd->cpu does not, won't
ifsd->status report SCAN_NOT_TESTED or SCAN_TEST_PASS instead of
SCAN_TEST_FAIL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026183820.1294=
59-1-ehab.ababneh@intel.com?part=3D11
