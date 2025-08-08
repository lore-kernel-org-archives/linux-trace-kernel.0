Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C81A3167;
	Fri,  8 Aug 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634826; cv=fail; b=oK4mf+yg+bL091QyDh/g26QR9Yw7j3cmiCv11Tx6ruAsIGLNKNOWWoUdXS2U/xkwfDS/tWtjYbF2OglM63OiaEE4zZqK5aSG1L4YkYy/Z6lt62hjbMhM2+Xo0uh+yZGYN6L1yablLabyO/PKO0QNS9BEVcKAk4x10LV4DzphoKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634826; c=relaxed/simple;
	bh=wDavsBWMYYetICPdnpH5QyjXKRqbDS9YFbtZPWE6izc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FWntbwcf5PvqnHhZo6hBa96NH6dyIoXaBrdN9O2+ZjmzkoeqIx859Gq8fIsr9WdRY7VTTyL7EKJZ4Mb1uHiSB0HYucHIOfpSZ1W7Ou2vQONXo1okPFQ1sssBZYgTOaBpvMIJIcc8Ghz6RhAr/zR2994BD35N3gZ4N6LNmnmamio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3vzsmoz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3vzsmoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754634822; x=1786170822;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=wDavsBWMYYetICPdnpH5QyjXKRqbDS9YFbtZPWE6izc=;
  b=F3vzsmozcpkfi7owKRfYhox1rjkinass+d4PM10xm+Gio4d4yDFkpNl2
   4IZ4Y0AVivVvZc/+Q0r5N7Dp/wo48RlbaPM0cqMernog8BUOKW+GCpsqh
   ET0wLHRW8h1VlOk/efcmanxg+TRsxbN84pFiATTPw2S19mrfyo2P1m8p6
   alj2DUx74LIvCr8mIbYliOdj3v+q68Q1iPU1lljyBKA80B0tIr1mm98Gv
   q9FmMs/jDVtxjnPmK269o0S9IToja57G+MBnc4IcGThg8YFRJB2wj3tlQ
   GXa2uCXm+NzYylcX4bIOwUMfhecFIvQRu1GkWkyP+JT3pmgcwK6g9IKga
   Q==;
X-CSE-ConnectionGUID: 5wFVGcBYQUGMwO/Q/MxCeg==
X-CSE-MsgGUID: k5t6nuD9SUWh8WUJ1bP47g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68349206"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68349206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:33:41 -0700
X-CSE-ConnectionGUID: KU3eHmqnSxOVzPojAdZhQQ==
X-CSE-MsgGUID: mlava0O6Sjic8NinivjgMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196240993"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:33:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:33:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:33:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd9n+QWbhiejH51w6i/oZ8yINrVXQtKoncF/osF4hscQ0F1TfZYpbGlbjyTi1Bkhp+bm+Gfy5kw+PT7pW8UWZWh/cw2kkd9KQJWMNJSI/2r7hrJK9GYdZ/ItMilaOjqGbAVh5sQi2BMMiHh+4ApVDoRpjFTve+Y+voUo3oIO8aV0p3nd7L3xAlsCx2cEcl+YGzUfI83rH+3frmbtFORvSNtUG/EDpvHLvu2JrpE1LAorEBhySe0daSTMEYqNi2+B/gNFLlNPuRivAK2WlSeiXQlb18cE8NybjppwwjPlOHJz0gOSUO1jCI1amePwHsAIxSdp+IGfoPh/Rvra+Re3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6S+5ueohNI9TnMBsJLXtGCl1n+QHq02Mzfm2j3TTfI=;
 b=ggewjlP6iAwZpuTSWDRdjib7i/ZYiZZb8/GZAyt7zspyJxPFWVmG3PjNRizJmMU6CDspgTg485Wj1FuRyThEvPmIiBEYF/4nZztaeZ9I18BOjHIJVt8Uo5b+qY65Z5irhF7hR7h13MeJgLU/0FctU5a5vFhZf2OwmpFK0Ek+sgN7ESfCeXwN8VPF7GU0qNACx1PlZfPY6fejMkAwsiTt1jRP2xbeueZxXIS0RoCgderJBPIzGsd7XmWwWceJ0yqOshpVopZjgmpKmKMY5YLgSCVcKwP9XEiXeAEU4a81f9WR7p5tuHfPn3Kojhe/MYtrHnmCHUnpzvF5FIWbxnB4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL4PR11MB8872.namprd11.prod.outlook.com (2603:10b6:208:5a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:33:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:33:14 +0000
Date: Fri, 8 Aug 2025 14:33:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Howells
	<dhowells@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ring]  119a5d5736:  stress-ng.mmapfiles.ops_per_sec
 42.7% improvement
Message-ID: <202508080734.62d2e2e9-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL4PR11MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2950c362-ea54-417c-e4ec-08ddd6457399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7wiGhkeQnZJ0zoSER8X94Q8fXIVsu5Nqi2l+fYx3fG3u0sQ1DX4xbRYYuc?=
 =?iso-8859-1?Q?d8PkWmMW5sXgyNqJeA+pmxr63me2Op5vAJXpODjpCXtRHtCNj9LU8mfW80?=
 =?iso-8859-1?Q?Eqh40JWUrF4vhspC5DDV58UINt45mXPvT3tP5KNnYNWygkO6HmxBEw5vLc?=
 =?iso-8859-1?Q?wcabGRYcTnGrtO7I9xD4v0FO2GUCRjwbO+eWDQSwIDY1th2CeRX2ghfLSl?=
 =?iso-8859-1?Q?1BNYIZ6Qur8JpoiwG6KbrNCT41tOY+JtN+kjHbZr0oH2ux21mnGDTCyYgP?=
 =?iso-8859-1?Q?/eaOzgUYV9bDUu+QPP2qLEKuV37lXwgLXJEx50RF0uZzQ5xMFJ2peEdP7x?=
 =?iso-8859-1?Q?FftkRt7wV3sIptwcASJx4HKVt5PTplzxatn6U6dChIl1IEr82GRnUbRdes?=
 =?iso-8859-1?Q?SMhK/4IRnOEIT95RP/nYZZB/cLM+sFbLnr64rM5Wge8QKnQ0TA1X3dE3Xy?=
 =?iso-8859-1?Q?M0+7THxAHb9sgi26ul0ZwrWiSEN4d/6Ll7IwBGxu6ror2JS3fuC1P37miG?=
 =?iso-8859-1?Q?53pJ6fn0Ohxmjn+FL+AWAssLA+x83FT6kNNviZUlLHCJ362vrpgAIYNsKq?=
 =?iso-8859-1?Q?bp7CNvewSIdvPX+gGKRdgM6/24ozlht50eXamTkDlcMp4fPb88HwtoyR8k?=
 =?iso-8859-1?Q?WK9GCAm0f7paKodr2x85bNpVzrlRNU961/ODP9gbQSpiKtf5x9BhVdfSj0?=
 =?iso-8859-1?Q?lW1q7/hCT7vCioq9bZoKiczRdBX4Wu/Wiif2YHYs9NcknJQAomDiXqVdYy?=
 =?iso-8859-1?Q?a16bkixofCaZmRRkDYXqtgjcfxy9haVLS2GXLLsrVNVUpz5royN0Xe/0T1?=
 =?iso-8859-1?Q?qx0ErT5+d7SoyDVALxjzzwW0BiTct1bgyM4stpu9SeeGXns7bm9Wwb5bPV?=
 =?iso-8859-1?Q?XZIUpnjaVxPU5xGoSvnO40+EsPQP1B+R/L2QEGPRZlq9Xma5trd9ibJNh+?=
 =?iso-8859-1?Q?PAzeujUgiUUzmb+Rztlu6qKKBxS/P+7ANFic7jQ+PI9Bl12ZYImV6Y0ad1?=
 =?iso-8859-1?Q?361bSTIaIN5u60v31GUWGaf6F1xRQD1XE0GTFlS7g1ddJ+ldfT/clLMiXz?=
 =?iso-8859-1?Q?zYEWBfavVVvvnQGbRs3kvcLlhlACw0V47w00d0PF6AVGbpwe3O8E6Q/9Dx?=
 =?iso-8859-1?Q?6z/YZ+hZuic0jzPC3gBYhtbdrSbKyhVVes9HJcOwAYcvBLB/qHzmdpd/3r?=
 =?iso-8859-1?Q?TD9fgWZy22RuoJRndi9U5QApXjtMjbg0pRaKDzMK3EJvRUEUmveiqfdzJ3?=
 =?iso-8859-1?Q?wlaRjUJe3dS18J1zPrDaxrEsBcevXn4NEK8QvITsZNu3U4R19NtE0ykw4W?=
 =?iso-8859-1?Q?bzUatPboeMKu5Ept3cVun0ItrcqMpECxJ5ugoTAVoYnsgQzvgurUuIV28c?=
 =?iso-8859-1?Q?W2ofyK+T2g6ezc7ZmVi29PZX5Y3yS7US5L2Wz262TOKWdULXCjyZZdQFdG?=
 =?iso-8859-1?Q?7/lL2maDGyl0OqG5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BrKx/bnPJtIIdwVxpKdGuJs1tVmmh4wlQ1Gg9Xqon3X8r3Cjrr6kOS2pxO?=
 =?iso-8859-1?Q?CPHrlU0ZfgwutS4HL54Uwt6h1YSdC80RtsG/Wej0MEBJdOGLFjNTc1fSam?=
 =?iso-8859-1?Q?QHXyYo3hunLpegFBCV2P4jFSwq6Fzf/Iu7xQHY6kfZ6XWC7nfSWPryPCCJ?=
 =?iso-8859-1?Q?R5CZ/L+eEUrFwAGsPOgg0/OBp1X34yLT7MxxjSSVeQHWcL1m8Knhp8Yyx8?=
 =?iso-8859-1?Q?qHm4WuQcgK2a02Qt8vZVfF7zUdP5G7t9lmAhbEcMoMH1ib/92rjUbHeL9i?=
 =?iso-8859-1?Q?hwkRgQVTgMnswJpe4CWXpvpRGpq/TE0ebKgYqkN0ec4bweZIXoN/RlstQf?=
 =?iso-8859-1?Q?fkOrnk2aq1U73AhniKPizHxylNrVPDL/kqpmyNIthP9MGBHcOfLk6y+CYF?=
 =?iso-8859-1?Q?POB1O9FYVre97+tL7pmtnL6+j1aV2YOx/65XfT/xiP8XcfSSkLYN6oatmN?=
 =?iso-8859-1?Q?5IfGSGvSEr1oFi2E67hTv482AocpoQ0NKQW9AYAvuW/TP071ttW4wXe23y?=
 =?iso-8859-1?Q?xteW5l9c4IzZy8uAYC007+TA3VysgdG9xqT0dVBiH/f0RSO+5AejENks/U?=
 =?iso-8859-1?Q?1RSUg7DtmnB3KE9OLq7a0qhLU2j85VwKQgnL6KK4XqckScjhKCTdfI3wDE?=
 =?iso-8859-1?Q?JJW5TfOab/NEDfJ4vO/5jPbo8Naj+dKXe+yEgBR2QxLIorpcdkyIAsCy95?=
 =?iso-8859-1?Q?jSukxEsyULVEhC7hLfu/1h3eWfhCvqsyjpAgYmtdmv+jODGChwItpyIC3W?=
 =?iso-8859-1?Q?nnYhzmSH01lESb+Tpg38HFiAHsIb2shwJ1EHGDwJZFPcKlgvJvsgs8UtsT?=
 =?iso-8859-1?Q?EfzTiXaffClXK3rd7LbfLCv3QIWwRKo44VZathG6xUgKLIktnGuBgTURNL?=
 =?iso-8859-1?Q?dL91hyTjegixcWaY9QhGaLtbwdoEhwZy0Lcl3/v37pA7Ly/aT+WFhpWSKc?=
 =?iso-8859-1?Q?Cp2AWeJ+KGpyJWxYlAzFilb8PnJ6muJWDaHITROMKJiIXBFTkWa8Fenb9d?=
 =?iso-8859-1?Q?xuJIKtbgNKkA0P7MEguk1HPsgo9jBOd+s51ii3uXoTJR6YngdUC0ytwL9o?=
 =?iso-8859-1?Q?fat7Ks6KJLB1lUnrb7LIAoxwIyF1vXb/fq42WbbiZR2ym2ffqITdDqf/3/?=
 =?iso-8859-1?Q?Qwgxd+m5NasF/wVsYr99VfB/3V/C4rpSCcU+/b0q/Rn7TophrNfhJtxdwK?=
 =?iso-8859-1?Q?+SqdocY7kzv60+oCrhyvzeejnGBMWi3lh81DIO3CO2cT+S/SN4LnpT6VMG?=
 =?iso-8859-1?Q?3GATRmQuvJ2nW01E2WZsTCs9UxEqpzk2oxSr308ArgDa2JA4MVoVVlRus6?=
 =?iso-8859-1?Q?aDGFW693I7LxxvcIoCK+4UUujJrOQcUWeXJpGh4DQey460cRXBr3PxjBUk?=
 =?iso-8859-1?Q?aIJbud4qEj+WKPMLttoQyMT61qKIIAXK3tWn4DHUCCEU/u6pzYFaff49em?=
 =?iso-8859-1?Q?QIMKQFvYIGkH60HRWmAbnWTZm6Qe6DFor9dYCGwMwjrbH12ChYIlhd2STO?=
 =?iso-8859-1?Q?FGgjRIbjvpvqRIv9L+YyepmZZ+GDFpspP7vn5ihb8EDJP0n/sY+gijTqYV?=
 =?iso-8859-1?Q?rzZRpusQR9N9h5LiUZpun742cRbgXKbenHTD1adMRuDzWW2vrpVpnby4mo?=
 =?iso-8859-1?Q?c/Ul9dQPPOW/Mw9Qi2lAybkijlJRdCjznxg/hPvTf/D/68kNho5mgEnA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2950c362-ea54-417c-e4ec-08ddd6457399
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:33:14.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdY2EQjLFKtWpPPG3pbVUHck1D9XUxIdLJ4mrq5DPcQdRaWgQQ0Ui+MqEtnAo2knmCuuXFH40wMofbr5Il+r/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8872
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 42.7% improvement of stress-ng.mmapfiles.ops_per_sec on:


commit: 119a5d573622ae90ba730d18acfae9bb75d77b9a ("ring-buffer: Remove ring_buffer_read_prepare_sync()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mmapfiles
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508080734.62d2e2e9-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp2/mmapfiles/stress-ng/60s

commit: 
  ca296d32ec ("tracing: ring_buffer: Rewind persistent ring buffer on reboot")
  119a5d5736 ("ring-buffer: Remove ring_buffer_read_prepare_sync()")

ca296d32ece38b07 119a5d573622ae90ba730d18acf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.193e+10           -26.3%  8.798e+09 ±  2%  cpuidle..time
    558288 ±  2%    +161.6%    1460278 ± 10%  cpuidle..usage
     22372 ± 46%   +1763.2%     416840 ± 33%  numa-meminfo.node0.PageTables
     47857 ± 53%     +94.6%      93108 ± 40%  numa-meminfo.node1.KReclaimable
     22578 ± 43%   +1566.2%     376209 ± 33%  numa-meminfo.node1.PageTables
     47857 ± 53%     +94.6%      93108 ± 40%  numa-meminfo.node1.SReclaimable
    479508 ± 10%    +458.2%    2676402 ± 11%  numa-numastat.node0.local_node
    594878 ± 10%    +363.8%    2758872 ± 12%  numa-numastat.node0.numa_hit
    531322 ± 10%    +341.7%    2346758 ± 14%  numa-numastat.node1.local_node
    613929 ±  9%    +301.1%    2462353 ± 15%  numa-numastat.node1.numa_hit
     98.51           -24.7%      74.15 ±  2%  vmstat.cpu.id
      2.83 ± 19%   +1588.2%      47.70 ±  5%  vmstat.procs.r
      3473          +154.2%       8830 ±  7%  vmstat.system.cs
     14439          +659.0%     109604 ± 16%  vmstat.system.in
    152185           +67.3%     254663        meminfo.KReclaimable
  10605505           +12.6%   11939258 ±  2%  meminfo.Memused
     44933 ±  2%   +1660.3%     790954 ± 30%  meminfo.PageTables
    152185           +67.3%     254663        meminfo.SReclaimable
    233417           +29.0%     301047 ±  6%  meminfo.Shmem
  11392789           +11.4%   12687942 ±  3%  meminfo.max_used_kB
     98.56           -25.3       73.31 ±  2%  mpstat.cpu.all.idle%
      0.02 ±  2%      +0.1        0.15 ±  6%  mpstat.cpu.all.irq%
      0.04 ±  4%      +0.1        0.11 ± 14%  mpstat.cpu.all.soft%
      1.21 ±  4%     +24.9       26.13 ±  5%  mpstat.cpu.all.sys%
      0.17            +0.1        0.31 ±  4%  mpstat.cpu.all.usr%
      2.00          +341.7%       8.83 ± 36%  mpstat.max_utilization.seconds
     55.48 ±  4%     +80.2%      99.98        mpstat.max_utilization_pct
      5581 ± 46%   +1788.6%     105415 ± 32%  numa-vmstat.node0.nr_page_table_pages
    594897 ± 10%    +362.5%    2751363 ± 12%  numa-vmstat.node0.numa_hit
    479527 ± 10%    +456.6%    2668892 ± 11%  numa-vmstat.node0.numa_local
      5638 ± 43%   +1601.6%      95938 ± 33%  numa-vmstat.node1.nr_page_table_pages
     11964 ± 53%     +94.4%      23254 ± 40%  numa-vmstat.node1.nr_slab_reclaimable
    613317 ±  9%    +300.2%    2454445 ± 15%  numa-vmstat.node1.numa_hit
    530710 ± 10%    +340.7%    2338849 ± 14%  numa-vmstat.node1.numa_local
    948595            +1.8%     965579        proc-vmstat.nr_file_pages
     67777            +3.9%      70433        proc-vmstat.nr_mapped
     11229 ±  2%   +1691.2%     201140 ± 30%  proc-vmstat.nr_page_table_pages
     58340           +29.1%      75323 ±  6%  proc-vmstat.nr_shmem
     38047           +67.2%      63620        proc-vmstat.nr_slab_reclaimable
   1211585          +329.3%    5201870 ± 11%  proc-vmstat.numa_hit
   1013607          +393.7%    5003804 ± 11%  proc-vmstat.numa_local
   1861736          +408.3%    9463058 ±  7%  proc-vmstat.pgalloc_normal
    557415            +4.3%     581427 ±  3%  proc-vmstat.pgfault
   1807764          +374.6%    8580349 ± 12%  proc-vmstat.pgfree
     18197 ±  2%     +38.0%      25119 ±  7%  proc-vmstat.pgreuse
    191421 ±  3%     -21.9%     149532 ±  7%  stress-ng.mmapfiles.file_munmap_per_sec
   3363175 ±  7%    +107.9%    6993704 ± 27%  stress-ng.mmapfiles.file_pages_mmap'd_per_sec
   4884918 ±  3%    +100.3%    9783815 ± 22%  stress-ng.mmapfiles.file_pages_munmap'd_per_sec
   6754176           +41.9%    9586043 ±  4%  stress-ng.mmapfiles.ops
    111144           +42.7%     158592 ±  4%  stress-ng.mmapfiles.ops_per_sec
     25.52          +103.5%      51.93 ± 26%  stress-ng.mmapfiles.pages_per_mapping
      2211 ±  7%   +1357.1%      32217 ±  3%  stress-ng.time.involuntary_context_switches
    200039           +19.4%     238867 ±  2%  stress-ng.time.minor_page_faults
    223.67 ±  4%   +2191.5%       5125 ±  5%  stress-ng.time.percent_of_cpu_this_job_got
    132.88 ±  4%   +2229.6%       3095 ±  5%  stress-ng.time.system_time
      4.76          +285.9%      18.36 ±  6%  stress-ng.time.user_time
     24766          +366.3%     115490 ± 15%  stress-ng.time.voluntary_context_switches
      1.60           -25.3%       1.20        perf-stat.i.MPKI
 9.736e+08 ±  4%    +463.2%  5.483e+09 ±  6%  perf-stat.i.branch-instructions
      2.65            -2.0        0.60 ±  7%  perf-stat.i.branch-miss-rate%
  18028015 ±  2%     +33.3%   24027893 ±  3%  perf-stat.i.branch-misses
     21.61 ±  2%     +15.2       36.78 ±  3%  perf-stat.i.cache-miss-rate%
   5865140 ± 12%    +371.6%   27661345 ±  9%  perf-stat.i.cache-misses
  18232987 ±  7%    +317.0%   76028298 ±  9%  perf-stat.i.cache-references
      3231          +172.2%       8796 ±  8%  perf-stat.i.context-switches
      1.76          +210.2%       5.47 ±  7%  perf-stat.i.cpi
 7.856e+09 ±  7%   +1983.0%  1.636e+11 ±  6%  perf-stat.i.cpu-cycles
    279.01           +11.2%     310.29        perf-stat.i.cpu-migrations
      2586 ±  4%    +137.5%       6141 ±  5%  perf-stat.i.cycles-between-cache-misses
 4.702e+09 ±  4%    +460.6%  2.636e+10 ±  6%  perf-stat.i.instructions
      0.70           -47.1%       0.37 ± 15%  perf-stat.i.ipc
      1.85 ±  2%      -1.4        0.44 ±  3%  perf-stat.overall.branch-miss-rate%
     32.01 ±  5%      +4.4       36.40        perf-stat.overall.cache-miss-rate%
      1.67 ±  3%    +273.3%       6.24        perf-stat.overall.cpi
      1354 ±  8%    +340.9%       5970 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.60 ±  3%     -73.2%       0.16        perf-stat.overall.ipc
 9.638e+08 ±  4%    +460.7%  5.404e+09 ±  6%  perf-stat.ps.branch-instructions
  17771587 ±  2%     +32.3%   23506612 ±  3%  perf-stat.ps.branch-misses
   5801292 ± 12%    +369.2%   27220520 ±  9%  perf-stat.ps.cache-misses
  18054778 ±  7%    +314.5%   74836354 ±  9%  perf-stat.ps.cache-references
      3178          +172.2%       8650 ±  8%  perf-stat.ps.context-switches
 7.791e+09 ±  7%   +1978.9%   1.62e+11 ±  5%  perf-stat.ps.cpu-cycles
    274.51           +11.5%     305.96        perf-stat.ps.cpu-migrations
 4.656e+09 ±  4%    +457.8%  2.597e+10 ±  6%  perf-stat.ps.instructions
 2.909e+11 ±  5%    +453.0%  1.609e+12 ±  6%  perf-stat.total.instructions
      0.03 ±  8%    +143.3%       0.07 ± 49%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.16 ±  3%     +55.6%       0.25 ± 17%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.03 ±  8%    +143.3%       0.07 ± 49%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.16 ±  3%     +55.6%       0.25 ± 17%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      0.03 ±  8%    +150.7%       0.07 ± 45%  sched_debug.cfs_rq:/.nr_queued.avg
      0.16 ±  3%     +63.6%       0.26 ± 12%  sched_debug.cfs_rq:/.nr_queued.stddev
     83.59 ± 39%    +103.0%     169.68 ± 27%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     36.00 ± 37%    +108.2%      74.96 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     35.99 ± 37%    +108.3%      74.96 ± 27%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     73.07 ±  8%     +95.1%     142.52 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
    132.39 ±  5%     +61.7%     214.07 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
     72.93 ±  8%     +95.2%     142.34 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
    131.99 ±  5%     +62.1%     213.94 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
      5.91 ± 21%    +265.0%      21.58 ±105%  sched_debug.cfs_rq:/.util_est.avg
    399.75 ± 21%     +76.2%     704.42 ± 12%  sched_debug.cfs_rq:/.util_est.max
     42.75 ± 17%    +112.0%      90.63 ± 40%  sched_debug.cfs_rq:/.util_est.stddev
     63474 ± 15%     -93.7%       4007 ± 33%  sched_debug.cpu.avg_idle.min
    130531 ±  3%     +54.2%     201275 ± 24%  sched_debug.cpu.avg_idle.stddev
    240190           -10.6%     214836 ±  5%  sched_debug.cpu.clock.avg
    240210           -10.6%     214860 ±  5%  sched_debug.cpu.clock.max
    240161           -10.6%     214813 ±  5%  sched_debug.cpu.clock.min
    240107           -10.6%     214755 ±  5%  sched_debug.cpu.clock_task.avg
    240182           -10.6%     214836 ±  5%  sched_debug.cpu.clock_task.max
    233419           -10.8%     208173 ±  5%  sched_debug.cpu.clock_task.min
     87.53 ±  9%    +187.7%     251.86 ± 80%  sched_debug.cpu.curr->pid.avg
    586.44 ±  3%     +46.2%     857.66 ± 32%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  5%     +31.2%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
      0.02 ± 12%    +166.0%       0.06 ± 56%  sched_debug.cpu.nr_running.avg
      0.14 ±  6%     +67.8%       0.23 ± 20%  sched_debug.cpu.nr_running.stddev
      0.50           -86.2%       0.07 ±203%  sched_debug.cpu.nr_uninterruptible.avg
    240171           -10.6%     214815 ±  5%  sched_debug.cpu_clk
    239913           -10.6%     214554 ±  5%  sched_debug.ktime
    240379           -10.5%     215030 ±  5%  sched_debug.sched_clk
      0.00 ± 73%   +5026.3%       0.16 ± 75%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01 ±  6%     +67.1%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±143%   +9114.3%       0.11 ±111%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±223%   +2650.0%       0.02 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.02 ± 14%     -43.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 14%     -38.7%       0.01 ± 32%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ±130%   +1180.8%       0.06 ±105%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ±100%   +2261.5%       0.10 ±189%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.02 ±  8%     -44.1%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  2%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      0.01 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
     21.61 ±223%    -100.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      0.02 ± 41%     -91.2%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      0.03 ± 12%     -60.6%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 73%  +22042.1%       0.70 ± 81%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.18 ±173%    +591.2%       1.24 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±143%  +50485.7%       0.59 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±223%  +11625.0%       0.08 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.04 ±  7%     -43.2%       0.02 ± 36%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ±  6%     -49.5%       0.02 ± 46%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 38%   +2026.5%       0.41 ± 79%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±130%   +9969.2%       0.44 ±118%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ±123%  +30451.5%       1.68 ±210%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.69 ±214%     -98.4%       0.01 ± 21%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ±  5%     -34.6%       0.03 ± 18%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      0.02 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
    151.19 ±223%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      5.35 ± 99%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
    158.67 ±223%    -100.0%       0.01 ±120%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
      1.73 ± 12%    +633.0%      12.67 ±113%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ± 97%     -90.9%       0.01 ± 44%  perf-sched.total_sch_delay.average.ms
    318.07           -74.2%      81.94 ± 59%  perf-sched.total_wait_and_delay.average.ms
      7377          +365.1%      34316 ± 49%  perf-sched.total_wait_and_delay.count.ms
    317.97           -74.2%      81.93 ± 59%  perf-sched.total_wait_time.average.ms
      3.94          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    490.51 ±  2%     -13.3%     425.48 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    549.71 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
    635.63 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
    619.17 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    646.14 ±  3%     -97.2%      18.27 ±141%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    743.78 ±  7%     -95.7%      31.63 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    233.72 ±  4%     -93.2%      15.82 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
    721.82 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    632.62 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    228.23 ±  7%     -96.8%       7.24 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      3.25           +29.2%       4.20 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    914.98 ±  2%     -86.1%     127.54 ± 31%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    122.83           -66.9%      40.67 ±141%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    420.50 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     75.00 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
     64.00 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
     80.33 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    535.83 ±  4%     -99.2%       4.33 ±213%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
     10.00 ± 37%     -98.3%       0.17 ±223%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    570.67 ±  3%     -99.9%       0.33 ±223%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
     63.33 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
     17.67 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    465.67           -99.7%       1.50 ±223%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      1027           +15.5%       1186 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1553            +9.8%       1704 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    626.67          +792.9%       5595 ± 31%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1665 ± 43%     -70.5%     491.40 ±100%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      1013 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      1013 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
      1023 ±  3%     -94.3%      58.85 ±182%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    990.98 ±  3%     -96.8%      31.63 ±223%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      1009 ±  3%     -96.9%      31.64 ±223%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      1010 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    989.32 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
      1024 ±  3%     -96.9%      31.50 ±223%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.11 ±223%  +23337.7%      24.65 ±214%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    490.50 ±  2%     -13.3%     425.46 ± 10%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    549.70 ± 14%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
    635.61 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
    619.16 ±  6%    -100.0%       0.04 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    645.85 ±  3%     -93.4%      42.51 ± 36%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    722.17 ± 13%     -95.6%      31.63 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    233.70 ±  4%     -93.2%      15.82 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
    718.98 ±  9%     -98.9%       7.61 ±154%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    632.60 ± 19%    -100.0%       0.13 ±223%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    227.88 ±  7%     -85.6%      32.76 ± 24%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.66 ±  6%     +60.5%       1.06 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.24           +29.2%       4.18 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    914.95 ±  2%     -86.1%     127.53 ± 31%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±141%    +643.8%       0.02 ±105%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.11 ±223%  +1.6e+05%     173.47 ±213%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.99           -23.4%       3.82 ± 35%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1002          -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      1013 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      1013 ±  3%    -100.0%       0.04 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
      1023 ±  3%     -88.1%     121.41 ± 68%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    990.96 ±  3%     -96.8%      31.63 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      1009 ±  3%     -96.9%      31.64 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      1010 ±  3%     -98.5%      15.22 ±154%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    989.30 ±  2%    -100.0%       0.13 ±223%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
      1024 ±  3%     -88.4%     118.41 ± 43%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      2.43 ± 12%    +284.4%       9.32 ± 15%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      5.00           +32.2%       6.61 ± 18%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     44.22 ± 10%     -42.1        2.09 ± 92%  perf-profile.calltrace.cycles-pp.__cmd_record
     42.62 ± 12%     -40.5        2.08 ± 92%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     42.62 ± 12%     -40.5        2.08 ± 92%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
     42.50 ± 12%     -40.4        2.08 ± 92%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     37.52 ± 13%     -35.9        1.64 ±104%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     35.11 ± 13%     -33.6        1.56 ±102%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
     34.68 ± 14%     -33.1        1.54 ±101%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
     21.55 ±  7%     -21.1        0.49 ±172%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     21.53 ±  7%     -21.0        0.49 ±171%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
     20.50 ±  7%     -20.0        0.50 ±179%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
     20.50 ±  7%     -20.0        0.50 ±179%  perf-profile.calltrace.cycles-pp.main
     20.50 ±  7%     -20.0        0.50 ±179%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
     20.44 ±  7%     -20.0        0.46 ±172%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
     19.35 ±  8%     -19.0        0.38 ±223%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.handle_internal_command
     19.35 ±  8%     -19.0        0.38 ±223%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.handle_internal_command.main
     19.35 ±  8%     -19.0        0.38 ±223%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.handle_internal_command.main
     16.95 ±  8%     -16.7        0.24 ±223%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record.cmd_record.perf_c2c__record.run_builtin
     16.94 ±  8%     -16.7        0.24 ±223%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record.cmd_record.perf_c2c__record
     16.91 ±  8%     -16.7        0.24 ±223%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record.cmd_record
     15.60 ± 18%     -14.4        1.20 ± 51%  perf-profile.calltrace.cycles-pp.common_startup_64
     12.83 ±  9%     -12.6        0.22 ±223%  perf-profile.calltrace.cycles-pp.machine__process_mmap2_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
     13.16 ± 20%     -12.2        0.94 ± 37%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     13.16 ± 20%     -12.2        0.94 ± 37%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     13.15 ± 20%     -12.2        0.94 ± 37%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     12.24 ± 19%     -11.3        0.89 ± 77%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     10.80 ± 21%      -9.9        0.90 ± 36%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     10.23 ± 19%      -9.4        0.84 ± 77%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.22 ± 19%      -9.4        0.84 ± 77%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     10.22 ± 19%      -9.4        0.84 ± 77%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      9.83 ± 21%      -9.1        0.75 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      8.03 ± 18%      -7.5        0.52 ±123%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      7.64 ± 24%      -7.1        0.52 ± 79%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      6.76 ±  6%      -6.6        0.12 ±223%  perf-profile.calltrace.cycles-pp.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      6.42 ±  6%      -6.3        0.15 ±223%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      6.42 ±  6%      -6.3        0.15 ±223%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      6.42 ±  6%      -6.3        0.15 ±223%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      6.08 ±  7%      -6.0        0.10 ±223%  perf-profile.calltrace.cycles-pp.map__new.machine__process_mmap2_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.00            +0.9        0.90 ± 14%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.00            +1.0        0.96 ± 36%  perf-profile.calltrace.cycles-pp.kernfs_fop_open.do_dentry_open.vfs_open.do_open.path_openat
      0.00            +1.0        0.98 ± 30%  perf-profile.calltrace.cycles-pp.set_nlink.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.00            +1.0        1.02 ± 35%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.00            +1.2        1.20 ± 56%  perf-profile.calltrace.cycles-pp.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      +1.7        1.95 ± 63%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.17 ±141%      +1.7        1.87 ± 63%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.0        1.97 ± 19%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.link_path_walk.path_openat
      0.00            +2.1        2.09 ± 73%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +2.1        2.12 ± 73%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +2.1        2.13 ± 73%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +2.1        2.14 ± 73%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +2.2        2.18 ± 73%  perf-profile.calltrace.cycles-pp.getdents64
      0.00            +2.7        2.71 ± 86%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.7        2.73 ± 85%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +2.9        2.89 ± 85%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      0.00            +2.9        2.94 ± 83%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      0.00            +2.9        2.95 ± 83%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.1        3.10 ± 41%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_permission.inode_permission.may_open.do_open
      0.00            +3.2        3.24 ± 16%  perf-profile.calltrace.cycles-pp.down_read.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      0.00            +3.5        3.48 ± 35%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_getattr.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat
      0.00            +3.8        3.75 ± 16%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +4.2        4.19 ± 39%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.may_open.do_open.path_openat
      0.00            +4.3        4.27 ± 38%  perf-profile.calltrace.cycles-pp.inode_permission.may_open.do_open.path_openat.do_filp_open
      0.00            +4.3        4.34 ± 28%  perf-profile.calltrace.cycles-pp.kernfs_iop_getattr.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat.do_syscall_64
      0.00            +4.6        4.57 ± 33%  perf-profile.calltrace.cycles-pp.may_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +4.6        4.57 ± 22%  perf-profile.calltrace.cycles-pp.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.6        4.61 ± 22%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +4.6        4.62 ±105%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +4.8        4.83 ± 19%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +4.9        4.89 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +4.9        4.92 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +5.1        5.12 ± 16%  perf-profile.calltrace.cycles-pp.fstatat64
      1.28 ± 12%      +5.6        6.84 ± 22%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +5.6        5.59 ± 98%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.7        5.68 ± 98%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +5.7        5.73 ± 98%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +5.8        5.82 ± 98%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +5.8        5.83 ± 98%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +6.0        6.02 ± 97%  perf-profile.calltrace.cycles-pp.__mmap
      0.00            +7.1        7.08 ± 80%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.lookup_fast.walk_component.link_path_walk
      0.00            +7.2        7.21 ± 79%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +7.9        7.88 ± 74%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      0.00            +8.3        8.28 ± 68%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +8.4        8.39 ± 20%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +8.4        8.39 ± 20%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +8.4        8.42 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +8.4        8.42 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +8.5        8.45 ± 20%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.00           +11.6       11.58 ± 48%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +11.6       11.61 ± 48%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +14.9       14.93 ± 39%  perf-profile.calltrace.cycles-pp.up_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.00           +19.5       19.53 ± 38%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.00           +36.7       36.65 ± 37%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00           +40.5       40.51 ± 34%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.30 ±101%     +63.6       63.93 ± 28%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.37 ± 13%     +65.8       68.21 ± 21%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.38 ± 13%     +65.8       68.22 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.40 ± 13%     +66.0       68.42 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.41 ± 13%     +66.0       68.43 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      2.48 ± 13%     +66.2       68.63 ± 21%  perf-profile.calltrace.cycles-pp.open64
      2.30 ± 13%     +73.9       76.20 ± 22%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.30 ± 13%     +73.9       76.23 ± 22%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     63.68 ±  7%     -60.9        2.75 ± 97%  perf-profile.children.cycles-pp.__cmd_record
     59.56 ±  9%     -57.2        2.40 ±100%  perf-profile.children.cycles-pp.record__finish_output
     59.56 ±  9%     -57.2        2.40 ±100%  perf-profile.children.cycles-pp.perf_session__process_events
     59.42 ±  9%     -57.0        2.40 ±100%  perf-profile.children.cycles-pp.reader__read_event
     37.54 ± 13%     -35.8        1.72 ± 96%  perf-profile.children.cycles-pp.process_simple
     35.18 ± 13%     -33.6        1.62 ± 96%  perf-profile.children.cycles-pp.ordered_events__queue
     34.82 ± 14%     -33.2        1.60 ± 96%  perf-profile.children.cycles-pp.queue_event
     21.64 ±  7%     -21.0        0.67 ±111%  perf-profile.children.cycles-pp.__ordered_events__flush
     21.55 ±  7%     -20.9        0.67 ±111%  perf-profile.children.cycles-pp.perf_session__process_user_event
     21.41 ±  7%     -20.7        0.66 ±110%  perf-profile.children.cycles-pp.perf_session__deliver_event
     20.50 ±  7%     -19.8        0.69 ±113%  perf-profile.children.cycles-pp.handle_internal_command
     20.50 ±  7%     -19.8        0.69 ±113%  perf-profile.children.cycles-pp.main
     20.50 ±  7%     -19.8        0.69 ±113%  perf-profile.children.cycles-pp.run_builtin
     19.63 ±  8%     -19.0        0.66 ±113%  perf-profile.children.cycles-pp.cmd_record
     19.35 ±  8%     -18.7        0.62 ±119%  perf-profile.children.cycles-pp.perf_c2c__record
     15.60 ± 18%     -14.4        1.20 ± 51%  perf-profile.children.cycles-pp.common_startup_64
     15.60 ± 18%     -14.4        1.20 ± 51%  perf-profile.children.cycles-pp.cpu_startup_entry
     15.58 ± 18%     -14.4        1.20 ± 51%  perf-profile.children.cycles-pp.do_idle
     12.96 ±  9%     -12.6        0.38 ±116%  perf-profile.children.cycles-pp.machine__process_mmap2_event
     13.16 ± 20%     -12.2        0.94 ± 37%  perf-profile.children.cycles-pp.start_secondary
     13.22 ± 19%     -12.1        1.16 ± 51%  perf-profile.children.cycles-pp.cpuidle_idle_call
     12.24 ± 19%     -11.2        1.09 ± 53%  perf-profile.children.cycles-pp.cpuidle_enter
     12.24 ± 19%     -11.2        1.08 ± 53%  perf-profile.children.cycles-pp.cpuidle_enter_state
     10.23 ± 19%      -9.2        1.03 ± 53%  perf-profile.children.cycles-pp.acpi_idle_enter
     10.23 ± 19%      -9.2        1.02 ± 53%  perf-profile.children.cycles-pp.acpi_idle_do_entry
     10.23 ± 19%      -9.2        1.02 ± 53%  perf-profile.children.cycles-pp.acpi_safe_halt
     10.22 ± 19%      -9.2        1.02 ± 53%  perf-profile.children.cycles-pp.pv_native_safe_halt
      6.81 ±  6%      -6.6        0.22 ±111%  perf-profile.children.cycles-pp.evlist__parse_sample
      6.19 ±  7%      -6.0        0.16 ±123%  perf-profile.children.cycles-pp.map__new
      6.45 ±  6%      -6.0        0.46 ± 48%  perf-profile.children.cycles-pp.ret_from_fork
      6.45 ±  6%      -6.0        0.46 ± 48%  perf-profile.children.cycles-pp.ret_from_fork_asm
      6.42 ±  6%      -6.0        0.45 ± 47%  perf-profile.children.cycles-pp.kthread
      7.06 ± 21%      -5.7        1.36 ± 37%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.32 ±  5%      -5.1        0.18 ±109%  perf-profile.children.cycles-pp.evlist__event2evsel
      5.12 ± 21%      -3.9        1.19 ± 35%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.57 ±  9%      -3.5        0.08 ±151%  perf-profile.children.cycles-pp.__dsos__find_by_longname_id
      3.71 ± 14%      -3.4        0.28 ± 84%  perf-profile.children.cycles-pp._nohz_idle_balance
      4.02 ± 14%      -3.4        0.61 ± 86%  perf-profile.children.cycles-pp.handle_softirqs
      3.94 ± 15%      -3.4        0.58 ± 85%  perf-profile.children.cycles-pp.__irq_exit_rcu
      3.43 ± 11%      -3.3        0.09 ±149%  perf-profile.children.cycles-pp.maps__fixup_overlap_and_insert
      3.60 ±  6%      -3.3        0.33 ± 32%  perf-profile.children.cycles-pp.worker_thread
      3.63 ± 12%      -3.3        0.36 ± 76%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      3.18 ±  7%      -3.0        0.21 ± 35%  perf-profile.children.cycles-pp.process_one_work
      3.27 ± 11%      -2.9        0.34 ± 76%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.89 ± 11%      -2.8        0.13 ±113%  perf-profile.children.cycles-pp.read
      2.84 ±  5%      -2.7        0.19 ± 78%  perf-profile.children.cycles-pp.write
      2.73 ± 11%      -2.6        0.13 ±111%  perf-profile.children.cycles-pp.ksys_read
      2.67 ± 12%      -2.6        0.07 ±143%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.76 ±  5%      -2.6        0.18 ± 78%  perf-profile.children.cycles-pp.ksys_write
      2.78 ± 10%      -2.6        0.20 ± 48%  perf-profile.children.cycles-pp.__schedule
      2.74 ±  5%      -2.6        0.18 ± 80%  perf-profile.children.cycles-pp.vfs_write
      2.63 ± 11%      -2.5        0.12 ±112%  perf-profile.children.cycles-pp.vfs_read
      2.41 ±  7%      -2.3        0.07 ±143%  perf-profile.children.cycles-pp.evsel__parse_sample
      3.13 ± 20%      -2.3        0.85 ± 20%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      3.06 ± 20%      -2.2        0.84 ± 19%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.47 ±  8%      -2.2        0.28 ± 52%  perf-profile.children.cycles-pp.sched_balance_rq
      2.44 ± 11%      -2.2        0.26 ±107%  perf-profile.children.cycles-pp.rest_init
      2.44 ± 11%      -2.2        0.26 ±107%  perf-profile.children.cycles-pp.start_kernel
      2.44 ± 11%      -2.2        0.26 ±107%  perf-profile.children.cycles-pp.x86_64_start_kernel
      2.44 ± 11%      -2.2        0.26 ±107%  perf-profile.children.cycles-pp.x86_64_start_reservations
      2.27 ±  9%      -2.2        0.11 ±116%  perf-profile.children.cycles-pp.seq_read_iter
      2.27 ±  8%      -2.0        0.24 ± 51%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      2.20 ±  9%      -2.0        0.18 ± 43%  perf-profile.children.cycles-pp.schedule
      2.25 ±  8%      -2.0        0.24 ± 51%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.10 ±  8%      -1.9        0.22 ± 48%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.90 ± 10%      -1.8        0.08 ±106%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.96 ±  8%      -1.8        0.16 ± 44%  perf-profile.children.cycles-pp.__pick_next_task
      1.88 ±  6%      -1.7        0.17 ± 87%  perf-profile.children.cycles-pp.writen
      1.82 ±  6%      -1.7        0.16 ± 86%  perf-profile.children.cycles-pp.shmem_file_write_iter
      1.81 ±  6%      -1.7        0.15 ± 86%  perf-profile.children.cycles-pp.generic_perform_write
      1.86 ±  6%      -1.6        0.26 ± 81%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      1.85 ±  7%      -1.6        0.25 ± 83%  perf-profile.children.cycles-pp.perf_mmap__push
      1.78 ±  7%      -1.6        0.18 ± 77%  perf-profile.children.cycles-pp.record__pushfn
      1.72 ±  9%      -1.6        0.15 ± 43%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.16 ± 22%      -1.5        0.62 ± 18%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.58 ±  7%      -1.5        0.08 ±131%  perf-profile.children.cycles-pp.seq_read
      1.93 ± 24%      -1.3        0.60 ± 18%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.27 ± 10%      -1.2        0.11 ± 93%  perf-profile.children.cycles-pp.copy_folio_from_iter_atomic
      1.16 ± 16%      -1.1        0.08 ± 63%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.16 ± 20%      -1.0        0.13 ± 53%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.15 ±  6%      -1.0        0.12 ± 86%  perf-profile.children.cycles-pp.vfs_fstatat
      1.09 ± 20%      -1.0        0.07 ±103%  perf-profile.children.cycles-pp.idle_cpu
      1.14 ± 14%      -1.0        0.15 ± 60%  perf-profile.children.cycles-pp.sched_balance_domains
      1.01 ± 22%      -1.0        0.06 ± 89%  perf-profile.children.cycles-pp.update_rq_clock_task
      1.15 ± 10%      -0.9        0.27 ± 85%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      1.06 ± 14%      -0.8        0.23 ± 84%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.84 ± 11%      -0.8        0.03 ±105%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.87 ± 15%      -0.8        0.07 ± 92%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      1.04 ±  9%      -0.8        0.26 ± 84%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.77 ±  8%      -0.7        0.03 ±102%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.86 ± 11%      -0.7        0.18 ± 84%  perf-profile.children.cycles-pp.clear_page_erms
      1.20 ± 30%      -0.7        0.52 ± 13%  perf-profile.children.cycles-pp.update_process_times
      0.76 ± 15%      -0.6        0.13 ± 37%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.82 ± 19%      -0.6        0.19 ± 30%  perf-profile.children.cycles-pp.ktime_get
      0.80 ± 24%      -0.6        0.22 ±116%  perf-profile.children.cycles-pp.rcu_core
      0.51 ± 12%      -0.5        0.04 ± 75%  perf-profile.children.cycles-pp.update_load_avg
      0.63 ± 14%      -0.5        0.17 ± 29%  perf-profile.children.cycles-pp.clockevents_program_event
      0.46 ± 30%      -0.4        0.04 ± 45%  perf-profile.children.cycles-pp.menu_select
      0.53 ± 30%      -0.3        0.24 ± 12%  perf-profile.children.cycles-pp.sched_tick
      0.30 ± 36%      -0.3        0.02 ± 99%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.30 ± 36%      -0.3        0.05 ± 86%  perf-profile.children.cycles-pp.__poll
      0.30 ± 37%      -0.3        0.05 ± 85%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.30 ± 37%      -0.2        0.05 ± 85%  perf-profile.children.cycles-pp.do_sys_poll
      0.37 ± 19%      -0.2        0.14 ± 62%  perf-profile.children.cycles-pp.tracing_check_open_get_tr
      0.25 ± 18%      -0.2        0.03 ±102%  perf-profile.children.cycles-pp.tracing_buffers_open
      0.32 ± 36%      -0.2        0.12 ± 27%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.25 ± 23%      -0.2        0.05 ± 90%  perf-profile.children.cycles-pp.__tracing_open
      0.21 ± 28%      -0.2        0.03 ±108%  perf-profile.children.cycles-pp.native_sched_clock
      0.19 ± 30%      -0.2        0.04 ±115%  perf-profile.children.cycles-pp.rmqueue
      0.02 ±144%      +0.1        0.10 ± 63%  perf-profile.children.cycles-pp.hash_name
      0.00            +0.1        0.09 ± 67%  perf-profile.children.cycles-pp.mas_data_end
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.kvfree_call_rcu
      0.00            +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.kvfree_rcu_bulk
      0.00            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.01 ±223%      +0.1        0.14 ± 56%  perf-profile.children.cycles-pp.seq_open
      0.00            +0.1        0.14 ± 71%  perf-profile.children.cycles-pp.filldir64
      0.02 ±142%      +0.1        0.16 ± 48%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.00            +0.2        0.15 ± 72%  perf-profile.children.cycles-pp.vm_area_alloc
      0.02 ±223%      +0.2        0.17 ± 75%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.2        0.16 ± 44%  perf-profile.children.cycles-pp.kernfs_unlink_open_file
      0.00            +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.vma_migratable
      0.00            +0.2        0.21 ± 32%  perf-profile.children.cycles-pp.task_numa_work
      0.00            +0.2        0.21 ± 35%  perf-profile.children.cycles-pp.unmap_region
      0.08 ± 59%      +0.2        0.31 ± 79%  perf-profile.children.cycles-pp.rb_next
      0.01 ±223%      +0.2        0.25 ± 91%  perf-profile.children.cycles-pp.__traverse_mounts
      0.01 ±223%      +0.3        0.26 ± 46%  perf-profile.children.cycles-pp.kernfs_fop_release
      0.09 ± 65%      +0.3        0.36 ± 43%  perf-profile.children.cycles-pp.task_work_run
      0.21 ± 39%      +0.3        0.52 ± 35%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.5        0.54 ± 66%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.00            +0.7        0.67 ± 66%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.00            +0.8        0.80 ± 68%  perf-profile.children.cycles-pp.unmapped_area_topdown
      0.00            +0.8        0.80 ± 67%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.8        0.84 ± 67%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.11 ± 13%      +0.9        0.96 ± 36%  perf-profile.children.cycles-pp.kernfs_fop_open
      0.01 ±223%      +0.9        0.87 ± 67%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.00            +1.0        0.96 ± 26%  perf-profile.children.cycles-pp.generic_permission
      0.00            +1.1        1.14 ± 30%  perf-profile.children.cycles-pp.set_nlink
      0.05 ± 73%      +1.2        1.20 ± 56%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      0.50 ± 16%      +1.6        2.13 ± 54%  perf-profile.children.cycles-pp.open_last_lookups
      0.10 ± 56%      +2.0        2.09 ± 73%  perf-profile.children.cycles-pp.iterate_dir
      0.10 ± 56%      +2.0        2.12 ± 73%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.11 ± 55%      +2.1        2.20 ± 73%  perf-profile.children.cycles-pp.getdents64
      0.03 ±101%      +2.9        2.95 ± 76%  perf-profile.children.cycles-pp.terminate_walk
      0.04 ±101%      +3.1        3.18 ± 74%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.08 ± 53%      +3.1        3.23 ± 72%  perf-profile.children.cycles-pp.__legitimize_path
      0.09 ± 50%      +3.2        3.24 ± 72%  perf-profile.children.cycles-pp.try_to_unlazy
      0.08 ± 46%      +3.5        3.60 ± 23%  perf-profile.children.cycles-pp.lockref_put_return
      1.26 ±  5%      +3.6        4.88 ± 18%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.26 ± 24%      +3.8        4.03 ±106%  perf-profile.children.cycles-pp.__mmap_new_vma
      1.30 ±  6%      +3.9        5.20 ± 15%  perf-profile.children.cycles-pp.fstatat64
      0.00            +4.3        4.34 ± 28%  perf-profile.children.cycles-pp.kernfs_iop_getattr
      0.06 ± 80%      +4.5        4.57 ± 22%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.14 ± 49%      +4.5        4.67 ± 30%  perf-profile.children.cycles-pp.may_open
      0.05 ± 76%      +4.6        4.61 ± 22%  perf-profile.children.cycles-pp.vfs_fstat
      0.28 ± 22%      +4.8        5.10 ± 13%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.62 ± 27%      +5.0        5.61 ± 98%  perf-profile.children.cycles-pp.do_mmap
      0.63 ± 26%      +5.1        5.70 ± 98%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.46 ± 23%      +5.3        5.74 ± 98%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.34 ± 11%      +5.6        6.91 ± 20%  perf-profile.children.cycles-pp.do_open
      0.18 ± 27%      +5.9        6.06 ± 97%  perf-profile.children.cycles-pp.__mmap
      0.41 ± 17%      +7.9        8.27 ± 62%  perf-profile.children.cycles-pp.__d_lookup
      0.44 ± 11%      +8.1        8.54 ± 64%  perf-profile.children.cycles-pp.step_into
      0.22 ± 32%      +8.2        8.47 ± 20%  perf-profile.children.cycles-pp.__open64_nocancel
      0.98 ±  7%     +10.7       11.65 ± 47%  perf-profile.children.cycles-pp.walk_component
      0.18 ±  9%     +11.1       11.29 ± 64%  perf-profile.children.cycles-pp.dput
      1.28 ±  9%     +12.3       13.63 ± 36%  perf-profile.children.cycles-pp.lookup_fast
      0.58 ± 20%     +14.9       15.45 ±102%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.65 ± 13%     +16.0       17.66 ± 86%  perf-profile.children.cycles-pp._raw_spin_lock
      0.03 ±142%     +17.2       17.26 ± 35%  perf-profile.children.cycles-pp.up_read
      0.11 ± 32%     +30.7       30.82 ± 34%  perf-profile.children.cycles-pp.down_read
      0.07 ± 80%     +40.9       40.93 ± 37%  perf-profile.children.cycles-pp.kernfs_iop_permission
      0.26 ± 33%     +44.6       44.87 ± 34%  perf-profile.children.cycles-pp.inode_permission
      1.23 ± 12%     +62.8       63.98 ± 28%  perf-profile.children.cycles-pp.link_path_walk
      2.48 ± 13%     +66.2       68.67 ± 21%  perf-profile.children.cycles-pp.open64
      2.63 ± 12%     +73.6       76.25 ± 22%  perf-profile.children.cycles-pp.path_openat
      2.64 ± 12%     +73.6       76.27 ± 22%  perf-profile.children.cycles-pp.do_filp_open
      2.74 ± 12%     +73.9       76.64 ± 21%  perf-profile.children.cycles-pp.do_sys_openat2
      2.75 ± 12%     +73.9       76.65 ± 21%  perf-profile.children.cycles-pp.__x64_sys_openat
     14.74 ±  9%     +79.7       94.47 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
     14.76 ±  9%     +79.8       94.54 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     34.27 ± 14%     -32.7        1.58 ± 96%  perf-profile.self.cycles-pp.queue_event
      5.12 ±  6%      -4.9        0.17 ±113%  perf-profile.self.cycles-pp.evlist__event2evsel
      2.38 ±  7%      -2.3        0.06 ±147%  perf-profile.self.cycles-pp.evsel__parse_sample
      2.19 ± 21%      -2.0        0.17 ± 60%  perf-profile.self.cycles-pp.pv_native_safe_halt
      1.59 ± 13%      -1.5        0.05 ±137%  perf-profile.self.cycles-pp.machine__process_mmap2_event
      1.52 ±  8%      -1.3        0.18 ± 46%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.24 ±  9%      -1.1        0.11 ± 92%  perf-profile.self.cycles-pp.copy_folio_from_iter_atomic
      1.08 ± 20%      -1.0        0.07 ±103%  perf-profile.self.cycles-pp.idle_cpu
      0.90 ± 27%      -0.9        0.04 ±121%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.83 ± 13%      -0.7        0.18 ± 83%  perf-profile.self.cycles-pp.clear_page_erms
      0.70 ± 25%      -0.7        0.04 ±125%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.68 ± 19%      -0.5        0.18 ± 31%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.09 ± 64%  perf-profile.self.cycles-pp.mas_data_end
      0.00            +0.1        0.09 ± 52%  perf-profile.self.cycles-pp.step_into
      0.00            +0.1        0.12 ± 73%  perf-profile.self.cycles-pp.filldir64
      0.00            +0.1        0.12 ± 63%  perf-profile.self.cycles-pp.__mmap_region
      0.00            +0.2        0.19 ± 34%  perf-profile.self.cycles-pp.vma_migratable
      0.08 ± 64%      +0.2        0.31 ± 67%  perf-profile.self.cycles-pp.may_open
      0.08 ± 59%      +0.2        0.31 ± 80%  perf-profile.self.cycles-pp.rb_next
      0.19 ± 36%      +0.3        0.51 ± 35%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.3        0.34 ± 61%  perf-profile.self.cycles-pp.kernfs_fop_readdir
      0.06 ± 72%      +0.4        0.42 ± 69%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.4        0.43 ± 69%  perf-profile.self.cycles-pp.mas_rev_awalk
      0.26 ± 13%      +0.4        0.70 ±106%  perf-profile.self.cycles-pp.__d_lookup
      1.52 ± 13%      +0.8        2.31 ± 32%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.9        0.94 ± 26%  perf-profile.self.cycles-pp.generic_permission
      0.00            +1.1        1.13 ± 31%  perf-profile.self.cycles-pp.set_nlink
      0.04 ±101%      +1.3        1.38 ± 22%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.08 ± 46%      +3.5        3.56 ± 23%  perf-profile.self.cycles-pp.lockref_put_return
      0.15 ± 34%      +3.7        3.85 ± 21%  perf-profile.self.cycles-pp.inode_permission
      0.58 ± 20%     +14.8       15.37 ±102%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.03 ±142%     +17.1       17.15 ± 35%  perf-profile.self.cycles-pp.up_read
      0.10 ± 33%     +30.4       30.52 ± 34%  perf-profile.self.cycles-pp.down_read




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

