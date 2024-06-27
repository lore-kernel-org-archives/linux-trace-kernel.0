Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667821957EE;
	Thu, 27 Jun 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497104; cv=none; b=qsj263s+xuiKzASXlWxDV+JZIR16UeUlEAwSdgV4hbfj6u+ikVxgIIXmrd+oCxWlxm5/CofFeoKbPItr6GEK/ZRAacTyk5P2JknfISFUcWuMFXbW7Tj7UK+sK7/q07d7axxgKh7FAIIbIpbi4rRmcuVjiu+Fwp8xjiHokrbu6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497104; c=relaxed/simple;
	bh=7u2c2BReJNLbS/7UbXxhMkOVAnxA47rWXWcFKaHwC8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMaAO/CRLbQoWUzwe7zBtkO27BfP1J0if/9DuYSNbXCoFplBzag6ss/yC/jqlNwR8FkKGMTZXGVG1hbOZk1S+b9a3RqY2x5MU2vYayByEpEGfLdfbz7AtAsC2r1jcFbc8lul7BDHYRRGL8yfGv8X8BoMnE/Noq62O29pn7Cy8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXUYcgX1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXUYcgX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719497102; x=1751033102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7u2c2BReJNLbS/7UbXxhMkOVAnxA47rWXWcFKaHwC8s=;
  b=ZXUYcgX1NY7WNBVPjVUotRggd2b1xnnDCJTAYIrj4UwPaL6QLvfzD94M
   rECbt9Vs/GRpbO0H7PBLodYNNaYLJd8UhMeU+rOfMVdMWyCSO9oW+UfNz
   cPKoxU4kbvflXQAIm0dvBjkmkvhH4r6OZ2x7CB5aUTv/VQBC/DiHVl9ua
   GHm5DOsmj+DyUBWMG8IKx2XXM/7N8nw5xFA0f9VwNHfC+++nekFGSOOHB
   +/aKq1GvEOScxVARThdtiCLp3/5utxqaenM34DUYFqpK/LaSOZ8A6LnQg
   Y6r16cdsPSRQaqJOQy4Y0E+aYoP50iR7zfWRPItymBHjPtjPXj0kxRALt
   A==;
X-CSE-ConnectionGUID: K11XyIVQQ1+O2y2RTtESUg==
X-CSE-MsgGUID: eKSnjlyiQ0q5uJySC7aBDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="42044854"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="42044854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:04:44 -0700
X-CSE-ConnectionGUID: EwTvl4r4QQaOyodLtKlUdQ==
X-CSE-MsgGUID: 5cpBhRVQRPaeFD3WfHcN6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44806519"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO [10.125.110.10]) ([10.125.110.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:04:44 -0700
Message-ID: <152f846d-2972-443b-b1e2-1b59c2eeaebf@linux.intel.com>
Date: Thu, 27 Jun 2024 07:04:43 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] trace: platform/x86/intel/ifs: Add SBAF trace
 support
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-trace-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240627023516.3783454-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240627095604.12eb1bca@rorschach.local.home>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240627095604.12eb1bca@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/27/24 6:56 AM, Steven Rostedt wrote:
> On Thu, 27 Jun 2024 02:35:16 +0000
> Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>> From: Jithu Joseph <jithu.joseph@intel.com>
>>
>> Add tracing support for the SBAF IFS tests, which may be useful for
>> debugging systems that fail these tests. Log details like test content
>> batch number, SBAF bundle ID, program index and the exact errors or
>> warnings encountered by each HT thread during the test.
>>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
>>  drivers/platform/x86/intel/ifs/runtest.c |  1 +
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
>> index 0d88ebf2c980..9c7413de432b 100644
>> --- a/include/trace/events/intel_ifs.h
>> +++ b/include/trace/events/intel_ifs.h
>> @@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
>>  		__entry->status)
>>  );
>>  
>> +TRACE_EVENT(ifs_sbaf,
>> +
>> +	TP_PROTO(int batch, union ifs_sbaf activate, union ifs_sbaf_status status),
>> +
>> +	TP_ARGS(batch, activate, status),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(	int,	batch	)
>> +		__field(	u64,	status	)
> Please put the 64 bit status field before the 32 bit batch field,
> otherwise this will likely create a 4 byte hole between the two fields.
> Space on the ring buffer is expensive real-estate.

Agree. I will fix this in next version.

>
> -- Steve
>
>> +		__field(	u16,	bundle	)
>> +		__field(	u16,	pgm	)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->batch	= batch;
>> +		__entry->bundle	= activate.bundle_idx;
>> +		__entry->pgm	= activate.pgm_idx;
>> +		__entry->status	= status.data;
>> +	),
>> +
>> +	TP_printk("batch: 0x%.2x, bundle_idx: 0x%.4x, pgm_idx: 0x%.4x, status: 0x%.16llx",
>> +		__entry->batch,
>> +		__entry->bundle,
>> +		__entry->pgm,
>> +		__entry->status)
>> +);
>> +
>>  #endif /* _TRACE_IFS_H */
>>  
>>  /* This part must be outside protection */
>> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
>> index bdb31b2f45b4..69ee0eb72025 100644
>> --- a/drivers/platform/x86/intel/ifs/runtest.c
>> +++ b/drivers/platform/x86/intel/ifs/runtest.c
>> @@ -530,6 +530,7 @@ static int dosbaf(void *data)
>>  	 */
>>  	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
>>  	rdmsrl(MSR_SBAF_STATUS, status.data);
>> +	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
>>  
>>  	/* Pass back the result of the test */
>>  	if (cpu == first)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

