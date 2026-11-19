Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090443;
	b=VuYQWfsj4e9qWmuu3K7N5pc/R5JK8OthQYIpuYfeDYaVIbTvG2Eoen2GFfp5rbowqHbP
	 NQ29i52MgOtZNy7CSUum3D7rSxpdIEvsYn/3vZUn7GcROXCOal63K0bFJPSctAXpxZz7u
	 y6zwbLQNItAMGgTv6emYrLqWAzE4WOuwraKgXfRdf8Th5UFfNNssJVvlKOso1gx1Ocfr3
	 /6wZeTPdOvuBsM8kESa5stxo3Ipv4LLsGNWya0KoHO5jgPCtXV0Epa3cZ8bzI2r1BlIb8
	 FtLxReXYoA/E7hbyXavOlz7RhUbq2kakBJCTOItYBVwrXrL8qO+MN443J9N2vjUP32w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090443;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=XavwD9n2zgTVS1m0GtP//dRTcLcmT2sKzdb4jadYy2A=;
	b=QvI5NawklX9iRfgfOcMPn2jwDHzUrnZGZqheTIhdsLHbLRGRX0bcxm5y8zGJeRFWzOM7
	 HZPhpbnvA89XE5Sm/5do6xBOg6sFr0IiGtr0gFKcFptBsV1RTAPL6YaetT3Hjy71quNby
	 XrBYRJdvb0XS5ejAolOTwBVOdmpBj0BmjLSSy/LIkOK7Sh3VJyz5efVyHYJPBTzhKB+7X
	 c3n4AcTV1WLmXLjhsrBm2fscCy16DiXhOUKMb7MBxw/oDHzbIdUrAiM5Ep4OYUWsuoGMh
	 WptuU9kks2KzK8rdgqUGJ/n7mh4H0DzPxn7m4bn3WIuWMB3Ycx3dmH7DcMNdPiA6tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fv2cuhW+;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532F606A324;
	Thu, 19 Nov 2026 12:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8532F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fv2cuhW+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795090442; x=1826626442;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tCrPcW/202zEUHPs2i6lzgRHOk3dQ8GJ8ZkALlyk5as=;
  b=Fv2cuhW+K4UQ+MH/Nt5WzyJYe5aSGowDBGqk3SuZoO0+BFhyW+cPT7pq
   s7nR88Olxd5nB4RzWLffPrK+cBS7EaNfoxbSvTEbNuXmpoNmZL3t6jWBc
   ZcNwXmUTDAUsBSEfFBFbhTw9d5Qco03BzRK8c8NY+WYeQblA380i4W3x6
   4ZwftWIsrAgld6WYR5uZfipvUjWk32fFiRKECLaRfdKY7DC8hrFLdRJRK
   m32pksKgz1xnYVfPD9EHDBZ+s46t77Nq0hqVo7+KK9un9oNizPwAB/Npv
   L+EdZn9Z8WbaE4ZBbXs2yvpm9mpsPiO41DD1laOaFurqlcuT7x4l99Ch5
   A==;
X-CSE-ConnectionGUID: qNRBQQf6SJus4rfYld4oZw==
X-CSE-MsgGUID: ExzRjrXFSWOvmw5SwDR6wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3944506"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3944506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:14:01 -0800
X-CSE-ConnectionGUID: X3oZe/zuTq6nH8OSTJS/3w==
X-CSE-MsgGUID: RBr/TmhFRMCHHpYDx95DAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10794030"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:13:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 14:13:51 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 17/17] Documentation/ABI: Update IFS ABI doc
In-Reply-To: <20261118193259.519568-18-ehab.ababneh@intel.com>
Message-ID: <fe3fd31c-b164-028f-6ad4-d932ae958c13@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-18-ehab.ababneh@intel.com>
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

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Add documentation for the new sysfs interfaces {status, details,
> additional_details, cpus_ran}_list.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  .../ABI/testing/sysfs-platform-intel-ifs      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> index 22430926ceaa..420de690e9c3 100644
> --- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> @@ -55,3 +55,27 @@ Description:	Write a number to load an IFS test image.
>  		Reading the file will provide the suffix of the currently loaded IFS test image.
>  		This file is present only for device instances where a test image is applicable.
>  Devices:	intel_ifs_0
> +
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/cpus_ran_list
> +Date:		Mar 3 2025
> +Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
> +Description:	The CPU list of the last test. These CPUs share the same SCAN test engine.
> +Devices:	intel_ifs_0
> +
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/status_list
> +Date:		Mar 3 2025
> +Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
> +Description:	The status list of the last test for CPUs sharing the same SCAN test engine.
> +Devices:	intel_ifs_0
> +
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/details_list
> +Date:		Mar 3 2025
> +Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
> +Description:	The detail status list of the last test for CPUs sharing the same SCAN test engine.
> +Devices:	intel_ifs_0
> +
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/addnl_details_list
> +Date:		Mar 3 2025
> +Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
> +Description:	The additional detail status list of the last test for CPUs sharing the same SCAN test engine.

Try to stay within 80 chars (long lines are harder to read as they require 
eye movement).

-- 
 i.

