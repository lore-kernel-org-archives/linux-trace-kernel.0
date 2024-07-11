Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD916D31D;
	Thu, 11 Jul 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713531; cv=none; b=hHqUVhIQmAijaaQux2CpP95rWF3OqoMrCN96MVEct9opre/qz1BJ+uGsPJ/epS4L6zRrvaffAJHcfvheUbhxNUxyW0j571FUeAaJ2rUVFrYe07Fog4HrxrYpZgTTkLLZqbKNxCNqSB8QG7I/MaBAT8DY/ETySZP2XKEg+oYU97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713531; c=relaxed/simple;
	bh=/Zkrnqj3Lqd9X1BOC6DYomk6gVS9TS6an3c/CYRKMMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1TP0BPlZSAiX0BmchIAcIThHDY51nOMdcvNHmNhXhEB+b05g0eA6pdWutZhvew9F6i1d3dYzNcV+tca2OK6OPQ9wZ4p68IJWeOMI53v3UNyC6Tq5JV3EK7hg5HHqx6kmjvyHfGyB8ssiUKn/0TArl1QThREGkVkEosQHr+BvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHClfChx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHClfChx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720713529; x=1752249529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Zkrnqj3Lqd9X1BOC6DYomk6gVS9TS6an3c/CYRKMMs=;
  b=SHClfChxKmQGkeddHQeUygO/MJlDDMndCd2pup+DLdeCfp2mzS1vfA4g
   2g8/PmFjNvnsX0nyjncGYJCUv9O1Ojv8ccmNvrjHt/GmKEX6eEj7GiaFd
   RRvTCDMYa5EmnuOKdalSAEUSA9jppljUZaLm9IFeRGJ0/yMNCP433fvjy
   8LI/YctYNALuNlz86HJDAWhsGjl8tqfNPk3DErK05lHBZtPD8ONclbABK
   wsxdSpgur+c1TUfw8ws/6m0MVvvBe29Nc+iu2Fuk/aBvshWKDfrqXeAxA
   1hPOLPk+7LXQ54PIoBhriR4m7RTgTUSK0EIniEtZJDMprV8jCouFvtMkW
   Q==;
X-CSE-ConnectionGUID: M+5eZRlrTQeHp/braZwq/A==
X-CSE-MsgGUID: /UNS3NYkTwGkmUuhjn4M1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17815330"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17815330"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:58:48 -0700
X-CSE-ConnectionGUID: 63tcTAldTZ67Xy4Qgrr/Ww==
X-CSE-MsgGUID: 6ffhYOVmRmiyQydRcflAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48494761"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.221.134]) ([10.124.221.134])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:58:48 -0700
Message-ID: <7e1e86b9-9578-441f-9f4a-23c274234344@linux.intel.com>
Date: Thu, 11 Jul 2024 08:58:46 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] platform/x86/intel/ifs: Add SBAF test support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/11/24 2:44 AM, Ilpo Järvinen wrote:
> On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:
>
>> From: Jithu Joseph <jithu.joseph@intel.com>
>>
>> In a core, the SBAF test engine is shared between sibling CPUs.
>>
>> An SBAF test image contains multiple bundles. Each bundle is further
>> composed of subunits called programs. When a SBAF test (for a particular
>> core) is triggered by the user, each SBAF bundle from the loaded test
>> image is executed sequentially on all the threads on the core using
>> the stop_core_cpuslocked mechanism. Each bundle execution is initiated by
>> writing to MSR_ACTIVATE_SBAF.
>>
>> SBAF test bundle execution may be aborted when an interrupt occurs or
>> if the CPU does not have enough power budget for the test. In these
>> cases the kernel restarts the test from the aborted bundle. SBAF
>> execution is not retried if the test fails or if the test makes no
>> forward progress after 5 retries.
>>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/ifs.h     |  30 +++
>>  drivers/platform/x86/intel/ifs/runtest.c | 234 +++++++++++++++++++++++
>>  2 files changed, 264 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
>> index 600bb8a1b285..b261be46bce8 100644
>> --- a/drivers/platform/x86/intel/ifs/ifs.h
>> +++ b/drivers/platform/x86/intel/ifs/ifs.h
>> @@ -157,6 +157,8 @@
>>  #define MSR_SBAF_HASHES_STATUS			0x000002b9
>>  #define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK	0x000002ba
>>  #define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS	0x000002bb
>> +#define MSR_ACTIVATE_SBAF			0x000002bc
>> +#define MSR_SBAF_STATUS				0x000002bd
>>  
>>  #define MSR_COPY_SCAN_HASHES			0x000002c2
>>  #define MSR_SCAN_HASHES_STATUS			0x000002c3
>> @@ -283,6 +285,34 @@ union ifs_array {
>>  	};
>>  };
>>  
>> +/* MSR_ACTIVATE_SBAF bit fields */
>> +union ifs_sbaf {
>> +	u64	data;
>> +	struct {
>> +		u32	bundle_idx	:9;
>> +		u32	rsvd1		:5;
>> +		u32	pgm_idx		:2;
>> +		u32	rsvd2		:16;
>> +		u32	delay		:31;
>> +		u32	sigmce		:1;
>> +	};
>> +};
>> +
>> +/* MSR_SBAF_STATUS bit fields */
>> +union ifs_sbaf_status {
>> +	u64	data;
>> +	struct {
>> +		u32	bundle_idx	:9;
>> +		u32	rsvd1		:5;
>> +		u32	pgm_idx		:2;
>> +		u32	rsvd2		:16;
>> +		u32	error_code	:8;
>> +		u32	rsvd3		:21;
>> +		u32	test_fail	:1;
>> +		u32	sbaf_status	:2;
>> +	};
>> +};
>> +
>>  /*
>>   * Driver populated error-codes
>>   * 0xFD: Test timed out before completing all the chunks.
>> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
>> index 282e4bfe30da..a812ec7761b9 100644
>> --- a/drivers/platform/x86/intel/ifs/runtest.c
>> +++ b/drivers/platform/x86/intel/ifs/runtest.c
>> @@ -29,6 +29,13 @@ struct run_params {
>>  	union ifs_status status;
>>  };
>>  
>> +struct sbaf_run_params {
>> +	struct ifs_data *ifsd;
>> +	int *retry_cnt;
>> +	union ifs_sbaf *activate;
>> +	union ifs_sbaf_status status;
>> +};
>> +
>>  /*
>>   * Number of TSC cycles that a logical CPU will wait for the other
>>   * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
>> @@ -146,6 +153,7 @@ static bool can_restart(union ifs_status status)
>>  #define SPINUNIT 100 /* 100 nsec */
>>  static atomic_t array_cpus_in;
>>  static atomic_t scan_cpus_in;
>> +static atomic_t sbaf_cpus_in;
>>  
>>  /*
>>   * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
>> @@ -387,6 +395,226 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
>>  		ifsd->status = SCAN_TEST_PASS;
>>  }
>>  
>> +#define SBAF_STATUS_PASS			0
>> +#define SBAF_STATUS_SIGN_FAIL			1
>> +#define SBAF_STATUS_INTR			2
>> +#define SBAF_STATUS_TEST_FAIL			3
>> +
>> +enum sbaf_status_err_code {
>> +	IFS_SBAF_NO_ERROR				= 0,
>> +	IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN		= 1,
>> +	IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS		= 2,
>> +	IFS_SBAF_UNASSIGNED_ERROR_CODE3			= 3,
>> +	IFS_SBAF_INVALID_BUNDLE_INDEX			= 4,
>> +	IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS		= 5,
>> +	IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY		= 6,
>> +	IFS_SBAF_UNASSIGNED_ERROR_CODE7			= 7,
>> +	IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
>> +	IFS_SBAF_INTERRUPTED_DURING_EXECUTION		= 9,
>> +	IFS_SBAF_INVALID_PROGRAM_INDEX			= 0xA,
>> +	IFS_SBAF_CORRUPTED_CHUNK			= 0xB,
>> +	IFS_SBAF_DID_NOT_START				= 0xC,
>> +};
>> +
>> +static const char * const sbaf_test_status[] = {
>> +	[IFS_SBAF_NO_ERROR] = "SBAF no error",
>> +	[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] = "Other thread could not join.",
>> +	[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] = "Interrupt occurred prior to SBAF coordination.",
>> +	[IFS_SBAF_UNASSIGNED_ERROR_CODE3] = "Unassigned error code 0x3",
>> +	[IFS_SBAF_INVALID_BUNDLE_INDEX] = "Non valid sbaf bundles. Reload test image",
> Non-valid SBAF
>
> ...but given your define is named "INVALID", why not use just Invalid 
> SBAF?

Above string is from the specification document.But I think it is ok to use
"Invalid" or "Non-valid".

Jithu, any concerns?

>> +	[IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS] = "Mismatch in arguments between threads T0/T1.",
>> +	[IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY] = "Core not capable of performing SBAF currently",
>> +	[IFS_SBAF_UNASSIGNED_ERROR_CODE7] = "Unassigned error code 0x7",
>> +	[IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT] = "Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
>> +	[IFS_SBAF_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SBAF start",
>> +	[IFS_SBAF_INVALID_PROGRAM_INDEX] = "SBAF program index not valid",
>> +	[IFS_SBAF_CORRUPTED_CHUNK] = "SBAF operation aborted due to corrupted chunk",
>> +	[IFS_SBAF_DID_NOT_START] = "SBAF operation did not start",
>> +};
>> +
>> +static void sbaf_message_not_tested(struct device *dev, int cpu, u64 status_data)
>> +{
>> +	union ifs_sbaf_status status = (union ifs_sbaf_status)status_data;
>> +
>> +	if (status.error_code < ARRAY_SIZE(sbaf_test_status)) {
>> +		dev_info(dev, "CPU(s) %*pbl: SBAF operation did not start. %s\n",
>> +			 cpumask_pr_args(cpu_smt_mask(cpu)),
>> +			 sbaf_test_status[status.error_code]);
>> +	} else if (status.error_code == IFS_SW_TIMEOUT) {
>> +		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
>> +			 cpumask_pr_args(cpu_smt_mask(cpu)));
>> +	} else if (status.error_code == IFS_SW_PARTIAL_COMPLETION) {
>> +		dev_info(dev, "CPU(s) %*pbl: %s\n",
>> +			 cpumask_pr_args(cpu_smt_mask(cpu)),
>> +			 "Not all SBAF bundles executed. Maximum forward progress retries exceeded");
>> +	} else {
>> +		dev_info(dev, "CPU(s) %*pbl: SBAF unknown status %llx\n",
>> +			 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
>> +	}
>> +}
>> +
>> +static void sbaf_message_fail(struct device *dev, int cpu, union ifs_sbaf_status status)
>> +{
>> +	/* Failed signature check is set when SBAF signature did not match the expected value */
>> +	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL) {
>> +		dev_err(dev, "CPU(s) %*pbl: Failed signature check\n",
>> +			cpumask_pr_args(cpu_smt_mask(cpu)));
>> +	}
>> +
>> +	/* Failed to reach end of test */
>> +	if (status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
>> +		dev_err(dev, "CPU(s) %*pbl: Failed to complete test\n",
>> +			cpumask_pr_args(cpu_smt_mask(cpu)));
>> +	}
>> +}
>> +
>> +static bool sbaf_bundle_completed(union ifs_sbaf_status status)
>> +{
>> +	if (status.sbaf_status || status.error_code)
>> +		return false;
>> +	return true;
> This is same as:
>
> 	return !status.sbaf_status && !status.error_code;

Yes. Your version looks good. Do you want me to send a version with
this change or you can include it when merging it?

>> +}
>> +
>> +static bool sbaf_can_restart(union ifs_sbaf_status status)
>> +{
>> +	enum sbaf_status_err_code err_code = status.error_code;
>> +
>> +	/* Signature for chunk is bad, or scan test failed */
>> +	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
>> +	    status.sbaf_status == SBAF_STATUS_TEST_FAIL)
>> +		return false;
>> +
>> +	switch (err_code) {
>> +	case IFS_SBAF_NO_ERROR:
>> +	case IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN:
>> +	case IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS:
>> +	case IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
>> +	case IFS_SBAF_INTERRUPTED_DURING_EXECUTION:
>> +		return true;
>> +	case IFS_SBAF_UNASSIGNED_ERROR_CODE3:
>> +	case IFS_SBAF_INVALID_BUNDLE_INDEX:
>> +	case IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS:
>> +	case IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY:
>> +	case IFS_SBAF_UNASSIGNED_ERROR_CODE7:
>> +	case IFS_SBAF_INVALID_PROGRAM_INDEX:
>> +	case IFS_SBAF_CORRUPTED_CHUNK:
>> +	case IFS_SBAF_DID_NOT_START:
>> +		break;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * Execute the SBAF test. Called "simultaneously" on all threads of a core
>> + * at high priority using the stop_cpus mechanism.
>> + */
>> +static int dosbaf(void *data)
>> +{
>> +	struct sbaf_run_params *run_params = data;
>> +	int cpu = smp_processor_id();
>> +	union ifs_sbaf_status status;
>> +	struct ifs_data *ifsd;
>> +	int first;
>> +
>> +	ifsd = run_params->ifsd;
>> +
>> +	/* Only the first logical CPU on a core reports result */
>> +	first = cpumask_first(cpu_smt_mask(cpu));
>> +	wait_for_sibling_cpu(&sbaf_cpus_in, NSEC_PER_SEC);
>> +
>> +	/*
>> +	 * This WRMSR will wait for other HT threads to also write
>> +	 * to this MSR (at most for activate.delay cycles). Then it
>> +	 * starts scan of each requested bundle. The core test happens
>> +	 * during the "execution" of the WRMSR.
>> +	 */
>> +	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
>> +	rdmsrl(MSR_SBAF_STATUS, status.data);
>> +
>> +	/* Pass back the result of the test */
>> +	if (cpu == first)
>> +		run_params->status = status;
>> +
>> +	return 0;
>> +}
>> +
>> +static void ifs_sbaf_test_core(int cpu, struct device *dev)
>> +{
>> +	struct sbaf_run_params run_params;
>> +	union ifs_sbaf_status status = {};
>> +	union ifs_sbaf activate;
>> +	unsigned long timeout;
>> +	struct ifs_data *ifsd;
>> +	int stop_bundle;
>> +	int retries;
>> +
>> +	ifsd = ifs_get_data(dev);
>> +
>> +	activate.data = 0;
>> +	activate.delay = IFS_THREAD_WAIT;
>> +
>> +	timeout = jiffies + (2 * HZ);
> Unnecessary parenthesis.
>
> Other than those things mentioned above,
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

