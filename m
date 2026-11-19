Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090023;
	b=alG11WF447TMSetNApOldEb5CiyoTQiVCsOdTRG0USR0HDp/0AfqQXyMmYfp+tgcNiPH
	 8iUzoSrOeE0SUyb4xZ16FaX22RTP5gZt4/5AowxNAlS3wVOV1II5wDglhwvPH+NWfE6Re
	 sAyuLOgBGOudZudJd1dv4S8tPtklmCiMlyaAgW4QojH0Z7vMm+SbHhmOThwPC/DM5nt9w
	 7Wa7V2j7ulULjIYv/b79DWLtQMhPszY7jeFSQUUFQ+8iEnL0BlJOycE+bWhaWYBeNtWKx
	 afMM2v62X+YrNqhUc8lyh0WGUdwYi4xYnQg3D5oSaATT1hHzsZ8zYjwDcjoXWfBh3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090023;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=kbnABEqj47FPQ4dABzs+jDJQ6NL1Axc8aBPEjacCJCU=;
	b=o3rrB0gjaVbUXNVxoASc1R9/Tjd6cZECVPXVAR7cFHLr3yBVQD7g3APHxr4PxR9be70i
	 Ii5NXp36KXjG5w0RNPVVc9EkPRn4MR+CLgf8Ti3LVgpUaMKPkVKTxaP+lxhbbdf5Hrf61
	 WJFCSecH5OPxGpOpoaHqaw+s42WXNuu2zUF/6icrDpuT1suEZfbUZcmUmAYfQALpacY/z
	 cZVrAYXsFeuwYaqDdT9XDH00J5JNXqdZzUOd7SxZQ1niKupNAVVjoSzwX2mZEV5vvWQ3q
	 619AlsK2tU/LGmMjffkQ+Ttic8zyGemyV8/yrppLej6c9PWZD0/I+6FkE6U4f2bTrpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DBBI85WQ;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B137606A320;
	Thu, 19 Nov 2026 12:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B137606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DBBI85WQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795090024; x=1826626024;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BTWUer8OEDqo97tY5wtj0OJ8SoMKQqyxH8oQM/MJ1Es=;
  b=DBBI85WQy22HtpUVEUFsmiuYZGx7md3r/xMx7A7BRiELFlSoFETXLQdg
   Fud7u5CL+VBmaTYuWCnKBZHyXa5dN2ILknawXY1o8qZJXDWwd4Vht7EXx
   47GqTiYsr5IbvWXMLxrhzY9EKCYvkX/8o27Yd3v3IthKJYskjWmkE+T4e
   e63lrki827GdSQylnPl1TYn5CVsaSl1I5Qr1zy04VkVv++BI8/T6aay//
   LKKuSJxydRmvylYy3Y4pKYAsoLXjm6pdBw2d+CtcBWNwv5lULEY4S1eqM
   2F4dSnOVafADx+k8srWVeFXYY10CYsD1qz7zviNDy0AFHCln7wVGi3OPW
   g==;
X-CSE-ConnectionGUID: B5/IG/t5Sjy+atiEtucRjg==
X-CSE-MsgGUID: LcaNDb8NTN2+AFUCL0qCtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3826265"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3826265"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:07:03 -0800
X-CSE-ConnectionGUID: NdDRmPNMSeCtUp3gq+nUbQ==
X-CSE-MsgGUID: lGkhzaaQSd+UkqQ0nyKkjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10328310"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:06:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 14:06:51 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 12/17] platform/x86/intel/ifs: Add new sysfs interfaces
 {status, details, cpus_ran}_list
In-Reply-To: <20261118193259.519568-13-ehab.ababneh@intel.com>
Message-ID: <7a3f0d3e-291a-6498-f605-8465cc5bf963@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-13-ehab.ababneh@intel.com>
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
> Problem
> =======
> The current legacy interface for Intel In-Field Scan is designed to
> simultaneously test all CPUs in a group [1], but it only reports the
> status of the primary CPU in this group and doesn't indicate that
> secondary CPUs have been tested. This results in the following issues:
> 
>   - All CPUs in a group can hold different statuses, but the user can
>     only see the status of the primary CPU, as any errors observed by
>     secondary CPUs are ignored.
> 
>   - The topology of a group of CPUs may vary across systems. For example,
>     in a Hyper-Threading (HT) system, the group consists of all CPUs in
>     a core, while in a Dual-Core Module (DCM) based system (e.g., Intel
>     Diamond Rapids CPU), two cores in a module form a group. The user may
>     be unaware of the group topology and test each CPU of the system
>     individually, leading to duplicate test runs.
> 
> Solution
> ========
> The user continues to write a single value to run_test, and while the
> legacy sysfs reports results for the tested CPU to ensure backward
> compatibility, new sysfs interfaces {status, details, cpus_run}_list
> provide results for multiple related CPUs tested as part of a group.
> The user can check for the presence of new sysfs interfaces to
> understand that multiple results are available, read them, and identify
> which CPUs have been tested to avoid duplicate tests.
> 
>   intel_ifs_0
>   +---- run_test	<--- Same legacy file
>   +---- current_batch
>   +---- details
>   +---- details_list	<--- Details for all CPUs in the group (new)
>   +---- dev
>   +---- image_version
>   +---- status
>   +---- status_list	<--- Status for all CPUs in the group (new)
>   +---- cpus_ran_list	<--- CPUs in the group tested along with CPU written to run_test (new)
>   \---- uevent
> 
> Example of reading the cpus_ran_list to see the CPUs tested:
> 
>   echo 0 > run_test
>   cat cpus_ran_list
>   0,96
> 
>   cat status_list
>   pass pass
> 
>   cat details_list
>   0x8086 0x8087
> 
> [1] Indicated by bits [20:16] of MSR_INTEGRITY_CAPABILITIES when bit 21 is set.
>     E.g., in Hyper-Threading (HT) systems, a group includes all threads in a core;
>     in Dual-Core Module (DCM) system, a group includes all CPU cores in a module.
> 
> [ Qiuxu: wrote the commit message. ]

Not among Signed-off-by members?

> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/sysfs.c | 60 ++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index 287f96bb033e..e96faf7bf0fa 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -135,6 +135,63 @@ static ssize_t image_version_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(image_version);
>  
> +static ssize_t status_list_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_state;
> +	int lcpu, len = 0;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		len += sysfs_emit_at(buf, len, "%s%s", (len > 0) ? " " : "",
> +				     status_msg[pcpu_state->test_result]);
> +	}
> +
> +	if (!len)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(status_list);
> +
> +static ssize_t details_list_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct ifs_test_output *pcpu_state;
> +	int lcpu, len = 0;
> +
> +	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
> +		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
> +		len += sysfs_emit_at(buf, len, "%s%#llx", (len > 0) ? " " : "",
> +				     pcpu_state->test_details);
> +	}
> +
> +	if (!len)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(details_list);
> +
> +static ssize_t cpus_ran_list_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	int len;
> +
> +	len = sysfs_emit(buf, "%*pbl", cpumask_pr_args(&ifsd->grp_cpumask));

Why doesn't this format string just add \n and return immediately?

> +	if (!len)
> +		return sysfs_emit(buf, "%s\n", "none");
> +
> +	return len + sysfs_emit_at(buf, len, "\n");

> +}
> +
> +static DEVICE_ATTR_RO(cpus_ran_list);
>  /* global scan sysfs attributes */
>  struct attribute *plat_ifs_attrs[] = {
>  	&dev_attr_details.attr,
> @@ -142,6 +199,9 @@ struct attribute *plat_ifs_attrs[] = {
>  	&dev_attr_run_test.attr,
>  	&dev_attr_current_batch.attr,
>  	&dev_attr_image_version.attr,
> +	&dev_attr_status_list.attr,
> +	&dev_attr_details_list.attr,
> +	&dev_attr_cpus_ran_list.attr,
>  	NULL
>  };
>  
> 

-- 
 i.

