Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090175;
	b=zKdFSOFVOLq820hs2/eOaUmoYnCzV/c/oQoRVS/DpYEyQR5CficVa8P8WgqSgfLV+/yu
	 2RnSNTOsX3jowfDMiETpzzHfbiXRJl/fQctpSdEb9mUxF+mMUbiiQW/gfiFU8e89rS8JB
	 qo3+Sg/7RGEZ2bGDJmtaqIf8gLkk3nSyFkYLZXtC3+Ze2wX7qw121WbUvIjlh3ceZ20Vy
	 cSmFi25okmLF3fcdR3U8d0LO1DKk88nisqr/GVqIjrJaIIqyJbfnEFRIYvD5bLilWv4ew
	 3Jf+TCKhFseOYWmjlOcwLVFmhElpIm2z+ZI6g6Fyt7bpaJ7IgXgm+DIn1BlrYnFHPUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090175;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=ydIgApLk01MFhi36RdMalHHr502VfgKWUr2OzSHniKE=;
	b=MXB1R0pVPOO0rIwd7TQ86d6WXD2zecqhBDZR8acvvgfgCmculh0TlSZodHwskgIYOVYZ
	 6RmO9ADoXBQhTcQBi/8dJnpuKAfZFcZcgFG1iVACqX2oi4oPtv9T7b0JjknbhOWuQbKj7
	 UD7HHX8nPra9txNjcG4XzJeL0MrNhyHoOlq8uo+bZrhDG04Y0MKFKSSw6Ucetp22xxn9h
	 tFSN+aA7jqpIR4LUHUnetC42O4gm5VEDuq7uvICCZ2gYtrkaB/0Exdv1K45SsqrbK1NM4
	 N8sA7+yHLKBgx9yvjrZJkrdSa6gZs6kY4HS+KeLdAf7pMRj5bj2KuCJnLUACKUmrsaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jFSeDNwB;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85B606A320;
	Thu, 19 Nov 2026 12:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA85B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jFSeDNwB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795090175; x=1826626175;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FxciG8Bxqkjue7vfajbys66vQv/qbs5afV8W6ePOspQ=;
  b=jFSeDNwBpukF3uvaZUXI/rjuWSLt4WxAplnM2+z7Oc9f8cgABKmq6KiX
   E3ZxWdoaobB395QU+woNCfxnnfSHQSxiwDsFd7NKocDcZEl1W0Ehzp/7K
   JvVVx2UVsY0dNzDFkLhCH6Nbb+tgFNFn2QxnIu8AHn9o0/OogIK0hTBCa
   KjPHDDCQ5kBR//Wy3r+bj1Yz6MB0m0zjIxVPvrh0rt7S6mPNdWysnmFkX
   Mbd1/N6dIrNtYZn5mwGdx1lmEKY4SejPzka8T2uciNSqGBCAmmZ74F9YB
   5ig0tfmHeEF/lkTjNVnIf67Vrah0BUemvTJDP4FdQc3aKMAdLcBffSkKn
   w==;
X-CSE-ConnectionGUID: 7TfQ6ulNTjeio7t44x7kPg==
X-CSE-MsgGUID: XUxvCP4RTYOVFv8ESSkB3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3855345"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3855345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:09:35 -0800
X-CSE-ConnectionGUID: mVgchslIRMiIWFAhm+S0kg==
X-CSE-MsgGUID: USi6k1FWQz+wmYhPRIAdBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10646379"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:09:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 14:09:23 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 15/17] platform/x86/intel/ifs: Remove limit on number
 of batch files
In-Reply-To: <20261118193259.519568-16-ehab.ababneh@intel.com>
Message-ID: <d081d12b-7a35-c45d-4fa6-91f07dbbee8d@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-16-ehab.ababneh@intel.com>
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

> From: Tony Luck <tony.luck@intel.com>
> 
> Writing to the current_batch sysfs file rejects batch numbers above
> 0xff. That limit was expected to be enough, but Diamond Rapids needs
> more than 256 IFS test image (batch) files.
> 
> Remove the limit check on the batch number supplied by the user.
> 
> [ Qiuxu: Update IFS ABI documentation to reflect the change. ]

????

Please don't submit garbage notes relating to development of the patch.

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-intel-ifs | 9 ++++++---
>  drivers/platform/x86/intel/ifs/sysfs.c             | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> index 11cd2f412d81..22430926ceaa 100644
> --- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
> @@ -46,9 +46,12 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
>  Date:		Nov 16 2022
>  KernelVersion:	6.2
>  Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
> -Description:	Write a number less than or equal to 0xff to load an IFS test image.
> -		The number written treated as the 2 digit suffix in the following file name:
> -		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
> +Description:	Write a number to load an IFS test image.
> +		The number written is used as the <batch> suffix in the following file name:
> +		/lib/firmware/intel/ifs_<N>/ff-mm-ss-<batch>.scan
> +		where ff, mm and ss are the CPU family, model and stepping, and <batch> is
> +		the number written, in lowercase hex, zero-padded to at least 2 digits
> +		(e.g. 02, ff, 100).
>  		Reading the file will provide the suffix of the currently loaded IFS test image.
>  		This file is present only for device instances where a test image is applicable.
>  Devices:	intel_ifs_0
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index 1a111e6101d8..1a0bfa2a2821 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -91,7 +91,7 @@ static ssize_t current_batch_store(struct device *dev,
>  	int rc;
>  
>  	rc = kstrtouint(buf, 0, &cur_batch);
> -	if (rc < 0 || cur_batch > 0xff)
> +	if (rc < 0)
>  		return -EINVAL;
>  
>  	if (down_interruptible(&ifs_sem))
> 

-- 
 i.

