Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5110953;
	Sat,  6 Jul 2024 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720309660; cv=none; b=gV2XJfbx1PUcmyyd+tKikMksXC0b5V2JWheDdwiBx6jDgjZ9PtmwjEx8uoBr/VeV2vH+uPnUJsco9sxtS1yLN1aFNpbNrOg4bEKOTmk+4CHrsfZxM+iVbptBJ9IOlIYv2IOBHfbNB4xkCW8ocuQ8703Ormy3c/fe6Q2Q2gVL2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720309660; c=relaxed/simple;
	bh=VpfDft53YaRE4Z0zvb6eY7RWf1Py+o10DDRZueu12H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0DWzAzNPQjwMdMh+w8hbv9oNV6ftY1+TiwTmdci/XtJz4LWPOZzNRdrwYJ6lTMFQ61LwH8PwJ0uCaqTlumk8k/iS2dwg5cKQwy8+X++r7jZHJju8mwgQ++RnnpJ3KFtAH5VNL7cS3t6bRjiPoCgFUpz5YD7LCVyL4JzgC2aUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvH+k6PH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvH+k6PH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720309659; x=1751845659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VpfDft53YaRE4Z0zvb6eY7RWf1Py+o10DDRZueu12H4=;
  b=fvH+k6PH1UkvXOXPKPgMvbJ5zOTZBH++BWgMLd+rIbz1UWMwJYOECnv1
   pFCxc3ShaWp1DjxdSci3EYfK2PhyDQFtcfeJokLaI6yuVC1kSTdlH6CVN
   ewrzgfNygIQCsy/i5/ovielIbKzzT6mrTjcW/78fc7kEyOWs7HBVrgwXV
   4R2ZhlLVCUWvfgCS/0Wh9P/ZslSbM7mHBPuC/g6SX0ByIRcIY8EVbDvXc
   i8aDbDbPz0VRqBFcOtCkq9hxK15BfMQVoqQCDYrhEsfPAICX9SMk48gh0
   B8Uh6OVk7FKUCtnMf2tyhkOLpPjaR+jLz8svzt0fSVdtM3497Sy9xAW8+
   Q==;
X-CSE-ConnectionGUID: k8zRK/yXT6Gcyw/eclU/cg==
X-CSE-MsgGUID: Uyi0yAeRQquuZgIdvcZC7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17677987"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="17677987"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 16:47:38 -0700
X-CSE-ConnectionGUID: iXgeC2TgRt+Ewf86buihTA==
X-CSE-MsgGUID: Lc4S215FTLubjjEKLAlKmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="47113639"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.220.93]) ([10.124.220.93])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 16:47:37 -0700
Message-ID: <9e33c98d-805a-4426-b7fb-3fba3d0f8fc7@linux.intel.com>
Date: Sat, 6 Jul 2024 16:47:19 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] platform/x86/intel/ifs: Add SBAF test support
To: "Joseph, Jithu" <jithu.joseph@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240627023516.3783454-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <62fd0e6b-7155-1393-ce18-f3a4ec25e63d@linux.intel.com>
 <35482322-8200-42c5-ba4f-8d50f1b1498d@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <35482322-8200-42c5-ba4f-8d50f1b1498d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/6/24 10:20 AM, Joseph, Jithu wrote:
> Thanks very much for the review Ilpo,
>
> On 7/6/2024 6:19 PM, Ilpo Järvinen wrote:
>> On Thu, 27 Jun 2024, Kuppuswamy Sathyanarayanan wrote:
>>
>>> From: Jithu Joseph <jithu.joseph@intel.com>
>>>
>>> In a core, the SBAF test engine is shared between sibling CPUs.
>>>
>>> An SBAF test image contains multiple bundles. Each bundle is further
>>> composed of subunits called programs. When a SBAF test (for a particular
>>> core) is triggered by the user, each SBAF bundle from the loaded test
>>> image is executed sequentially on all the threads on the core using
>>> the stop_core_cpuslocked mechanism. Each bundle execution is initiated by
>>> writing to MSR_ACTIVATE_SBAF.
>>>
>>> SBAF test bundle execution may be aborted when an interrupt occurs or
>>> if the CPU does not have enough power budget for the test. In these
>>> cases the kernel restarts the test from the aborted bundle. SBAF
>>> execution is not retried if the test fails or if the test makes no
>>> forward progress after 5 retries.
>>>
>>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>  drivers/platform/x86/intel/ifs/ifs.h     |  30 +++
>>>  drivers/platform/x86/intel/ifs/runtest.c | 234 +++++++++++++++++++++++
>>>  2 files changed, 264 insertions(+)
>>>
> ...
>
>>> +
>>> +static void ifs_sbaf_test_core(int cpu, struct device *dev)
>>> +{
>>> +	struct sbaf_run_params run_params;
>>> +	union ifs_sbaf_status status;
>>> +	union ifs_sbaf activate;
>>> +	unsigned long timeout;
>>> +	struct ifs_data *ifsd;
>>> +	int stop_bundle;
>>> +	int retries;
>>> +
>>> +	ifsd = ifs_get_data(dev);
>>> +
>>> +	activate.data = 0;
>>> +	activate.delay = IFS_THREAD_WAIT;
>>> +
>>> +	timeout = jiffies + (2 * HZ);
>>> +	retries = MAX_IFS_RETRIES;
>>> +	activate.bundle_idx = 0;
>>> +	stop_bundle = ifsd->max_bundle;
>>> +
>>> +	while (activate.bundle_idx <= stop_bundle) {
>>> +		if (time_after(jiffies, timeout)) {
>>> +			status.error_code = IFS_SW_TIMEOUT;
>>> +			break;
>> If we take this branch on the first iteration...
>>
>>> +		}
>>> +
>>> +		atomic_set(&sbaf_cpus_in, 0);
>>> +
>>> +		run_params.ifsd = ifsd;
>>> +		run_params.activate = &activate;
>>> +		run_params.retry_cnt = &retries;
>>> +		stop_core_cpuslocked(cpu, dosbaf, &run_params);
>>> +
>>> +		status = run_params.status;
>>> +
>>> +		if (sbaf_bundle_completed(status)) {
>>> +			activate.bundle_idx = status.bundle_idx + 1;
>>> +			activate.pgm_idx = 0;
>>> +			retries = MAX_IFS_RETRIES;
>>> +			continue;
>>> +		}
>>> +
>>> +		/* Some cases can be retried, give up for others */
>>> +		if (!sbaf_can_restart(status))
>>> +			break;
>>> +
>>> +		if (status.pgm_idx == activate.pgm_idx) {
>>> +			/* If no progress retry */
>>> +			if (--retries == 0) {
>>> +				if (status.error_code == IFS_NO_ERROR)
>>> +					status.error_code = IFS_SW_PARTIAL_COMPLETION;
>>> +				break;
>>> +			}
>>> +		} else {
>>> +			/* if some progress, more pgms remaining in bundle, reset retries */
>>> +			retries = MAX_IFS_RETRIES;
>>> +			activate.bundle_idx = status.bundle_idx;
>>> +			activate.pgm_idx = status.pgm_idx;
>>> +		}
>>> +	}
>>> +
>>> +	/* Update status for this core */
>>> +	ifsd->scan_details = status.data;
>>> +
>>> +	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
>>> +	    status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
>> ...is status.sbar_status uninitialized? (And perhaps other fields too 
>> that are used after the loop?).
> Will initialize status.data to 0 (at function entry, prior to the loop) to ensure that in the unlikely scenario of taking
> the aforementioned branch (on the first iteration),  all the status fields will be zeroed (apart from status.error_code, 
> which would be set to IFS_SW_TIMEOUT at the branch)

Yes, it is better to initialize the status variable to 0. While moving the
timeout check to the end of the loop could also address this issue,
explicitly fixing it at the initialization is a cleaner solution.

--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -542,7 +542,7 @@ static int dosbaf(void *data)
 static void ifs_sbaf_test_core(int cpu, struct device *dev)
 {
        struct sbaf_run_params run_params;
-       union ifs_sbaf_status status;
+       union ifs_sbaf_status status = {};

I think there is a similar usage in ifs_test_core() as well. Will fix that in
a separate patch.

>
>> It could also be that the timeout check shouldn't be before the first real 
>> iteration inside the loop to ensure that kind of shortcut cannot occur?

>>
> Thanks
> Jithu

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

