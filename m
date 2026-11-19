Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089670;
	b=QZPmPWuwqPsM9lACa0en28xMle2RZze4WZPKp+q9GX/GDfKX6mtZezEMTxhwC24gnccA
	 gygnZHMs5jbCyp2iaMuR/vd5e2X+Nxz1i8aGR1xy0w+0Is7nQSnxv2ZOGRttJmH/sN3lG
	 5XasJN/EBLxYAqtcepNT0h3nfWN2+SnBmY5ewzWGC2oLp51Ep3+PhOERRriqM7cDc4qT1
	 AaC0VB2ZisyKyrEweUjOsZb5SuIknhv1O4Id7nhaj6240PzRJxZYqQwa45tY7F++MuM9C
	 cwH2etMjFKkCFy+9uN4YViwRE0kS8fm7hbs7bpEacAgiKnU390Tx1XYUaV+i7QXOrRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089670;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=jdNDYFtRcyHuOKz6Yipuh1UMPWXV9n0NpxhJP59HoDI=;
	b=Crs9qjV1BfWbIvBI2OR8s3YQvHtUZTyfeJsyCRJW3HKhZ0Qx39F4LZG44pGJIljv1ULw
	 MUzq/WZO35dX5SeO2vZA0GkH8knkvkeTwSkoUESKobc5WnU3f3vsuhCVpEzivrBAJGjgF
	 Xr4byAFlM2C/c49sZw+yMP2j/Aepzr+nGtH+nzEROVtfuoXlBbFdHc9G/xE8OcG2qZM6p
	 dR1fzD7ACFOF6QfFv8Jc/8vPyqKvSyJP/81C0gvKIWYNyoGcOCwpnWxxR8F1TbFwfFx/I
	 mwjF8TyyhTZ6dNeXpJHH1q1sNOJjXpkziHlBVOYc0DEAJRgU+5ZlAO913CRh2wI7BGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yh0Xsw8p;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473C606A320;
	Thu, 19 Nov 2026 12:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8473C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yh0Xsw8p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795089669; x=1826625669;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QKU/VHT/GxibGrvFLOA4et0BvWEn2qTvzV37jE3MpbQ=;
  b=Yh0Xsw8pzig2i991T0PKvwa8roJounaeibzG5zy72xJjurFRT7mnzKgU
   rVQWzXNsfPPoLxD0F/zsx/s0vOTDGKlLpUkzK/m+OGs0zIcSw3rjbfAqI
   ET9Dmq7jz1+bsy/+pGnWM6fNSRjBweMgbHBUMFY1WAdO+dVdsHggYE0Iq
   E0ykjPPmvBA3lhgk1JMhJnIj+1aNPA0LiVifWy/RJ0EDTmBOxFL8OQojI
   0SKMnDRNuStWBRHb3KZNoZ5FytsG3ZZH68/RQP6BD2AtjP/knYbXr9hTI
   ROnGC/YobWIAdQ9uoKgNJ/xrpAsZZCddtD47A21uPfzLXJa3v9yCMaavf
   A==;
X-CSE-ConnectionGUID: D7PvNMqUT4a34LKn70Yh9g==
X-CSE-MsgGUID: mJRL7QkqRzmcDvzznlGtDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3927291"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3927291"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:01:03 -0800
X-CSE-ConnectionGUID: LxqG7x7fRwaTzEZnQcEEHw==
X-CSE-MsgGUID: vvtd9sm7QimC6aq73DvTVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10688088"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:00:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 14:00:52 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 11/17] platform/x86/intel/ifs: Track and report scan
 results on a per-CPU basis
In-Reply-To: <20261118193259.519568-12-ehab.ababneh@intel.com>
Message-ID: <7c9226eb-24d0-6756-1f0a-66cfada6d743@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-12-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Ehab Ababneh wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> IFS requires invoking the scan simultaneously within a group of CPUs, as
> indicated in the MSR_INTEGRITY_CAPABILITIES (bits 20:16). When bit 21 is
> set, it indicates that all threads in the groups need to trigger the test
> at the same time.
> 
> When the tests are run simultaneously, record the test results in a
> per-CPU structure. This reduces the need to redundantly repeat the test
> for all thread in the same group.
> 
> There are several benefits:
> 
>  - Reduced power consumption by avoiding multiple scans.
> 
>  - Decreased time to complete a scan by 50% or more.
> 
>  - These tests could take up to 200ms. Prevents taking these cores out
>    of circulation just to repeat tests that have already been conducted.
> 
> The cores in a group share a scan engine but each reports its own
> result, and they can differ. So when a test is restarted, restart from
> the lowest chunk any CPU in the group reached. When the driver marks a
> test as timed out or partially completed, keep any error code a CPU's
> hardware reported. When warning about an incomplete group, look at the
> results of all CPUs in the group, not only the CPU being tested.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/core.c    |  14 +-
>  drivers/platform/x86/intel/ifs/ifs.h     |  12 ++
>  drivers/platform/x86/intel/ifs/runtest.c | 171 ++++++++++++++++++-----
>  3 files changed, 161 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index b9ac04228141..e019c986ac0d 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -49,6 +49,8 @@ static const struct ifs_test_msrs scan_msrs = {
>  	.test_ctrl = MSR_SAF_CTRL,
>  };
>  
> +DEFINE_PER_CPU(struct ifs_test_output, ifs_scan_n);
> +
>  static struct ifs_device ifs_devices[] = {
>  	[IFS_TYPE_SAF] = {
>  		.test_caps = &scan_test,
> @@ -58,6 +60,9 @@ static struct ifs_device ifs_devices[] = {
>  			.minor = MISC_DYNAMIC_MINOR,
>  			.groups = plat_ifs_groups,
>  		},
> +		.rw_data = {
> +			.result_ptr = &ifs_scan_n,
> +		}

Add trailing command to all non-terminator entiries.

>  	},
>  	[IFS_TYPE_ARRAY_BIST] = {
>  		.test_caps = &array_test,
> @@ -86,7 +91,7 @@ static int __init ifs_init(void)
>  {
>  	const struct x86_cpu_id *m;
>  	u64 msrval;
> -	int i, ret;
> +	int i, ret, cpu;
>  
>  	m = x86_match_cpu(ifs_cpu_ids);
>  	if (!m)
> @@ -105,6 +110,13 @@ static int __init ifs_init(void)
>  	if (!ifs_pkg_auth)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Clear the per-CPU results before misc_register() below makes
> +	 * run_test visible to user space, so no test can be running yet.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		memset(per_cpu_ptr(&ifs_scan_n, cpu), 0, sizeof(struct ifs_test_output));

Put the pointer into a temporary local variable and do sizeof(*that_var).

IMO, best is to declare it right within the loop.

> +
>  	for (i = 0; i < IFS_NUMTESTS; i++) {
>  		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
>  			continue;
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 62db0a6aa940..acf8d8a7b105 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -130,6 +130,7 @@
>   */
>  #include <linux/device.h>
>  #include <linux/miscdevice.h>
> +#include <linux/percpu-defs.h>
>  
>  #define MSR_ARRAY_BIST				0x00000105
>  #define MSR_COPY_SCAN_HASHES			0x000002c2
> @@ -290,6 +291,7 @@ struct ifs_test_msrs {
>   * @loaded: If a valid test binary has been loaded into the memory
>   * @loading_error: Error occurred on another CPU while loading image
>   * @valid_chunks: number of chunks which could be validated.
> + * @cpu: The CPU on which the test was triggered
>   * @status: it holds simple status pass/fail/untested
>   * @scan_details: opaque scan status code from h/w
>   * @cur_batch: number indicating the currently loaded test file
> @@ -298,6 +300,7 @@ struct ifs_test_msrs {
>   * @array_gen: test generation of array test
>   * @all_lp_join: all logical processors join test
>   * @tid_bit_shift: APIC-ID bits of the logical processors sharing a scan engine
> + * @result_ptr: points to percpu result
>   */
>  struct ifs_data {
>  	cpumask_t	grp_cpumask;
> @@ -305,6 +308,7 @@ struct ifs_data {
>  	bool	loaded;
>  	bool	loading_error;
>  	int	valid_chunks;
> +	int	cpu;
>  	int	status;
>  	u64	scan_details;
>  	u32	cur_batch;
> @@ -313,6 +317,7 @@ struct ifs_data {
>  	u32	array_gen;
>  	bool	all_lp_join;
>  	u8	tid_bit_shift;
> +	struct ifs_test_output __percpu *result_ptr;
>  };
>  
>  struct ifs_work {
> @@ -327,6 +332,13 @@ struct ifs_device {
>  	struct miscdevice misc;
>  };
>  
> +struct ifs_test_output {
> +	u64	test_details;
> +	int	test_result;
> +};
> +
> +DECLARE_PER_CPU(struct ifs_test_output, ifs_scan_n);
> +
>  static inline struct ifs_data *ifs_get_data(struct device *dev)
>  {
>  	struct miscdevice *m = dev_get_drvdata(dev);
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 783b29f234ba..b93d8de4ca06 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -83,25 +83,21 @@ static void message_not_tested(struct device *dev, int cpu, union ifs_status sta
>  	 * been corrupted. Reloading the image may fix this issue.
>  	 */
>  	if (status.control_error) {
> -		dev_warn(dev, "CPU(s) %*pbl: Scan controller error. Batch: %02x version: 0x%x\n",
> -			 cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
> +		dev_warn(dev, "CPU %d: Scan controller error. Batch: %02x version: 0x%x\n", cpu,
> +			 ifsd->cur_batch, ifsd->loaded_version);
>  		return;
>  	}
>  
>  	if (status.error_code < ARRAY_SIZE(scan_test_status)) {
> -		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
> -			 cpumask_pr_args(cpu_smt_mask(cpu)),
> +		dev_info(dev, "CPU %d: SCAN operation did not start. %s\n", cpu,
>  			 scan_test_status[status.error_code]);
>  	} else if (status.error_code == IFS_SW_TIMEOUT) {
> -		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
> -			 cpumask_pr_args(cpu_smt_mask(cpu)));
> +		dev_info(dev, "CPU %d: software timeout during scan\n", cpu);
>  	} else if (status.error_code == IFS_SW_PARTIAL_COMPLETION) {
> -		dev_info(dev, "CPU(s) %*pbl: %s\n",
> -			 cpumask_pr_args(cpu_smt_mask(cpu)),
> +		dev_info(dev, "CPU %d: %s\n", cpu,
>  			 "Not all scan chunks were executed. Maximum forward progress retries exceeded");
>  	} else {
> -		dev_info(dev, "CPU(s) %*pbl: SCAN unknown status %llx\n",
> -			 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
> +		dev_info(dev, "CPU %d: SCAN unknown status %llx\n", cpu, status.data);
>  	}
>  }
>  
> @@ -117,8 +113,8 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
>  	 * the core being tested.
>  	 */
>  	if (status.signature_error) {
> -		dev_err(dev, "CPU(s) %*pbl: test signature incorrect. Batch: %02x version: 0x%x\n",
> -			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
> +		dev_err(dev, "CPU %d: test signature incorrect. Batch: %02x version: 0x%x\n",
> +			cpu, ifsd->cur_batch, ifsd->loaded_version);
>  	}
>  }
>  
> @@ -177,12 +173,13 @@ static void wait_for_sibling_cpu(struct ifs_data *ifsd, atomic_t *t, long long t
>  static int doscan(void *data)
>  {
>  	int cpu = smp_processor_id(), start, stop;
> +	struct ifs_test_output *pcpu_scan;
>  	struct run_params *params = data;
>  	union ifs_status status;
>  	struct ifs_data *ifsd;
> -	int first;
>  
>  	ifsd = params->ifsd;
> +	pcpu_scan = this_cpu_ptr(ifsd->result_ptr);
>  
>  	if (ifsd->generation) {
>  		start = params->activate->gen2.start;
> @@ -192,9 +189,6 @@ static int doscan(void *data)
>  		stop = params->activate->gen0.stop;
>  	}
>  
> -	/* Only the first logical CPU on a core reports result */
> -	first = cpumask_first(&ifsd->grp_cpumask);
> -
>  	wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
>  
>  	/*
> @@ -211,12 +205,103 @@ static int doscan(void *data)
>  	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
>  
>  	/* Pass back the result of the scan */
> -	if (cpu == first)
> +	if (cpu == ifsd->cpu)
>  		params->status = status;
>  
> +	pcpu_scan->test_details = status.data;
> +
>  	return 0;
>  }
>  
> +#define get_scan_status(stat) ((union ifs_status *)(&((stat)->test_details)))

Can't this be static function which allows getting rid of most 
of those parenthesis?

> +static void update_group_status(struct device *dev, int reason)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status = get_scan_status(pcpu_scan);
> +		/* Don't hide an error code reported by the hardware */
> +		if (scan_status->error_code == IFS_NO_ERROR)
> +			scan_status->error_code = reason;
> +	}
> +}
> +
> +static bool can_restart_test_group(struct device *dev)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status = get_scan_status(pcpu_scan);
> +		if (!can_restart(*scan_status))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/*
> + * The cores in a group can stop at different chunks. Return the lowest
> + * chunk reached so that no CPU skips chunks when the test is restarted.
> + */
> +static u32 group_min_chunk(struct ifs_data *ifsd)
> +{
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	u32 chunk, min_chunk = U32_MAX;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status = get_scan_status(pcpu_scan);

These three lines seem to repeat, so consider adding some local 
for_each_... macro for these iterations.

> +		chunk = ifsd->generation ? scan_status->gen2.chunk_num :
> +			scan_status->gen0.chunk_num;
> +		min_chunk = min(min_chunk, chunk);
> +	}
> +
> +	return min_chunk;
> +}
> +
> +static void update_group_result(struct device *dev, int stop_chunk)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_scan;
> +	union ifs_status *scan_status;
> +	u32 reached_chunk;
> +	int lcpu;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		scan_status = get_scan_status(pcpu_scan);
> +		reached_chunk = ifsd->generation ? scan_status->gen2.chunk_num :
> +				scan_status->gen0.chunk_num;
> +
> +		if (scan_status->signature_error) {
> +			pcpu_scan->test_result = SCAN_TEST_FAIL;
> +			message_fail(dev, lcpu, *scan_status);
> +		} else if (scan_status->control_error || scan_status->error_code ||
> +			   reached_chunk <= stop_chunk) {
> +			/* E.g. another CPU in the group stopped the scan */
> +			if (!scan_status->control_error && !scan_status->error_code)
> +				scan_status->error_code = IFS_SW_PARTIAL_COMPLETION;
> +			pcpu_scan->test_result = SCAN_NOT_TESTED;
> +			message_not_tested(dev, lcpu, *scan_status);
> +		} else {
> +			pcpu_scan->test_result = SCAN_TEST_PASS;
> +		}
> +
> +		if (lcpu == ifsd->cpu)
> +			ifsd->status = pcpu_scan->test_result;
> +	}
> +}
> +
>  /*
>   * Use stop_core_cpuslocked() to synchronize writing to MSR_ACTIVATE_SCAN
>   * on all threads of the core to be tested. Loop if necessary to complete
> @@ -232,9 +317,14 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	int to_start, to_stop;
>  	int status_chunk;
>  	struct run_params params;
> -	int retries;
> +	int retries, lcpu;
>  
>  	ifsd = ifs_get_data(dev);
> +	ifsd->cpu = cpu;
> +
> +	/* Don't let results from a previous test leak into this one */
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask)
> +		memset(per_cpu_ptr(ifsd->result_ptr, lcpu), 0, sizeof(struct ifs_test_output));

Local var similar to above.

>  
>  	activate.gen0.rsvd = 0;
>  	activate.delay = IFS_THREAD_WAIT;
> @@ -258,6 +348,7 @@ static void ifs_test_core(int cpu, struct device *dev)
>  	while (to_start <= to_stop) {
>  		if (time_after(jiffies, timeout)) {
>  			status.error_code = IFS_SW_TIMEOUT;
> +			update_group_status(dev, IFS_SW_TIMEOUT);
>  			break;
>  		}
>  
> @@ -272,15 +363,16 @@ static void ifs_test_core(int cpu, struct device *dev)
>  		status = params.status;
>  
>  		/* Some cases can be retried, give up for others */
> -		if (!can_restart(status))
> +		if (!can_restart_test_group(dev))
>  			break;
>  
> -		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.gen0.chunk_num;
> +		status_chunk = group_min_chunk(ifsd);
>  		if (status_chunk == to_start) {
>  			/* Check for forward progress */
>  			if (--retries == 0) {
>  				if (status.error_code == IFS_NO_ERROR)
>  					status.error_code = IFS_SW_PARTIAL_COMPLETION;
> +				update_group_status(dev, IFS_SW_PARTIAL_COMPLETION);
>  				break;
>  			}
>  		} else {
> @@ -295,16 +387,7 @@ static void ifs_test_core(int cpu, struct device *dev)
>  
>  	/* Update status for this core */
>  	ifsd->scan_details = status.data;
> -
> -	if (status.signature_error) {
> -		ifsd->status = SCAN_TEST_FAIL;
> -		message_fail(dev, cpu, status);
> -	} else if (status.control_error || status.error_code) {
> -		ifsd->status = SCAN_NOT_TESTED;
> -		message_not_tested(dev, cpu, status);
> -	} else {
> -		ifsd->status = SCAN_TEST_PASS;
> -	}
> +	update_group_result(dev, to_stop);
>  }
>  
>  static int do_array_test(void *data)
> @@ -313,7 +396,6 @@ static int do_array_test(void *data)
>  	int cpu = smp_processor_id();
>  	union ifs_array *command;
>  	struct ifs_data *ifsd;
> -	int first;
>  
>  	ifsd = params->ifsd;
>  
> @@ -323,9 +405,7 @@ static int do_array_test(void *data)
>  	/*
>  	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
>  	 */
> -	first = cpumask_first(&ifsd->grp_cpumask);
> -
> -	if (cpu == first) {
> +	if (cpu == ifsd->cpu) {
>  		wrmsrq(MSR_ARRAY_BIST, command->data);
>  		/* Pass back the result of the test */
>  		rdmsrq(MSR_ARRAY_BIST, command->data);
> @@ -343,6 +423,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
>  	unsigned long timeout;
>  
>  	ifsd = ifs_get_data(dev);
> +	ifsd->cpu = cpu;
>  	params.ifsd = ifsd;
>  
>  	command.array_bitmask = ~0U;
> @@ -451,6 +532,26 @@ static bool ifs_group_incomplete(int cpu, struct ifs_data *ifsd)
>  	return false;
>  }
>  
> +/*
> + * For a scan test, check the result of every CPU in the group, since the
> + * cores in a group can report different results. Array tests only have
> + * the result of the target CPU.
> + */
> +static bool ifs_test_passed(int test_num, struct ifs_data *ifsd)
> +{
> +	int lcpu;
> +
> +	if (test_num != IFS_TYPE_SAF)
> +		return ifsd->status == SCAN_TEST_PASS;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		if (per_cpu_ptr(ifsd->result_ptr, lcpu)->test_result != SCAN_TEST_PASS)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target CPU and
>   * its sibling CPU. Once all sibling threads wake up, the scan test gets executed and
> @@ -491,7 +592,7 @@ int do_core_test(int cpu, struct device *dev)
>  		ret = -EINVAL;
>  	}
>  
> -	if (!ret && ifsd->status != SCAN_TEST_PASS && ifs_group_incomplete(cpu, ifsd))
> +	if (!ret && !ifs_test_passed(test->test_num, ifsd) && ifs_group_incomplete(cpu, ifsd))
>  		dev_warn(dev, "CPU %d: test did not pass; not all CPUs sharing the scan engine were found (group %*pbl)\n",
>  			 cpu, cpumask_pr_args(&ifsd->grp_cpumask));
>  out:
> 

-- 
 i.

