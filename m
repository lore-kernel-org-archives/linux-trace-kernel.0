Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25196F06B;
	Wed, 24 Jul 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810157; cv=fail; b=Uc45953ML9aCsoSoAht90LMhHdeGK6SsbGojwW7u//qF86XNo3gZGYUiOe9EiNvuyN0ugBXMydKBPdMY0CwZC437mxjgh+dbY5RZp5gD6y2hvx8GkUei34zUZRfbY6T2DS7RU8F4oNkSZ1C81mqFVrmAzcvDaXej0dQePoPHN1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810157; c=relaxed/simple;
	bh=WRgPne/Y89Ju2M2584d1NDdOXmCCpD83kZLsRRrIx9A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=by9nORk2wuFBx2APVIo6v65rWs0RYvpes8YxcZ9POXF0mciJZp8IfVtV1N/ka6BF+ssRqaIw08ttMmfbNHFEPgqMSxWHjYZ8niZQqmWqq7c9vHmE15EBJV/49VIZE1GZwmSc8aVF5mczl9wy2oOiy0DtTLamQ61nXQyteN6Le6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrMyHyaH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrMyHyaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721810155; x=1753346155;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WRgPne/Y89Ju2M2584d1NDdOXmCCpD83kZLsRRrIx9A=;
  b=JrMyHyaH9RlAuXXczHpLhjPA3b0goWjB+JQqsYWVu2m8IIa6jxt5lTTb
   0iSWwNIhHkloAkoPFg17Mgch13fiC1ccDK+9qrULXBmzYbeYeuXYI9Zr3
   57OukRkb4uscjl08T+esmT+q1KQwMSGwZputEF9ri8VmWI3CXqGh14EhX
   1FUNZw08dxNQwu7nVwjCPwTC6YQA7keKLuTM/gHvIXKXK8NO+pCI8WmTS
   GGxBGEa65RyLBedMDHwg7gzAogePdwJnneP1RJ0n9683V3F5f2zMIii90
   WzUGGM566qj+4JBMYihhoT+HZq7kHY6duiBusBjj2gZG+6hrD0zWmtKzD
   Q==;
X-CSE-ConnectionGUID: 7xuq6FyTSXijHhBpxn7ufA==
X-CSE-MsgGUID: eXJPgCsTREC4zvxxDLwG6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="42002145"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="42002145"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:35:55 -0700
X-CSE-ConnectionGUID: EYmSyxF1RGCC18VVh0LXug==
X-CSE-MsgGUID: Y6BbBmazRDK+HbKsTB+feQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57042436"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 01:35:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 01:35:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 01:35:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 01:35:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj/epdE244xJYOWx74mPdhy7w529/0xiaSpuXUwKtkr4i5I9J8/gy6ltXR2xYGZWR4NYPatDLlaFM+9wR3hD0hkH9BXVwW2QVmmMWnluWYgsTif5kGlL7Lbm7985Xad5tq/GLza56fV5SpdtjftcoKLm9Yr1F29tzJJACO3P+gvViupfacg+gP+Qa4a91JThkOREpmK+lL2RaEW8yW7B5KXycRzcJQ9drwEvKop7rZqPri1QlI2pADFd4eOIBAbIMplVJWOdO3ld9HKXich8tfStDfnQ5yYWK+QIrlqmPYzOWuy3MwEvhqxbeg+NvEXNFhxkmMPoKsXR7bhUZDaqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q6+x8nSwO/mh8mBIfmdT7hE32dcSZNrRI8JiThoVHY=;
 b=GpYvY3CPOnK5hlWaxUT1/tw2wk8EhAHauGn+oa+gVYGsA+iQkttZRcmgSGTD3QSHHLh+eLfuAStfDZJ+CS020UO+Y+wNTI2TCaZq+kAbpmCKpuvYpRt6LMrNtbZfq7wqwSGTSlrH1DDIkKo7Mgt+j6zvZ/u70KJQMVkgiWWUpgYie5izW7kap5OG+lVhQwFZ6NdewSxyHdWmiORxjznQ/gRL9WbjqLxK3TBkrz/62vdm/02D4KCudSv15LR5m7sBxhz78bMcjSnZAFiNOr4HDkb1OSnRQNXjbnYSvDwqDqn5gX1XQIt/bNvK6ATfq5GQLnrC8I5dbrei3jla5lC2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 08:35:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 08:35:45 +0000
Date: Wed, 24 Jul 2024 16:35:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jiri Olsa <jolsa@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [uprobe]  ff474a78ce:  stress-ng.mprotect.ops_per_sec
 -12.3% regression
Message-ID: <202407241609.9b33c747-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:820:f::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f865a60-ee9b-4819-bf5e-08dcabbb9c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i/mid2kBqkzqgYWVrTACSUryoquFYnasjfxKykdAmipVZVomeQQ0T1V7Cz?=
 =?iso-8859-1?Q?fDd9ZsLctfX9quy4+AoSN2l7Hiaz2J+2AyGlok9OYF+ekxkhk+8HoVOG43?=
 =?iso-8859-1?Q?Yo3frgTK3VMJ7nOr3ICKiOnKjOpIKZlDSb51JkwlNpwt+GOnRbv7kLRdef?=
 =?iso-8859-1?Q?sf5033BTSctWwLETOLq948ZV4YTpZPjh0hFOXyPvasQ6rg1RbBFYaUMnSZ?=
 =?iso-8859-1?Q?MjCChgVcbGrzya9w/bvnEKnyVuiBRMqcCRP61srRC5HmLg5991f33tLNhp?=
 =?iso-8859-1?Q?AIJ7QRuAdKcnkmyUWbU+cmmMzXaHUgwotZ+H8+O3JuJtwwt1+8jCJZcQ9J?=
 =?iso-8859-1?Q?XhZsfoRNzZeHtbDhAJzdyHrWCSuNW8asLb6N7PbL5rdCtIBxWVjz1IeGwG?=
 =?iso-8859-1?Q?CbNdrkIREgSpNDrt0X2okn0TrELrnTkjkkH4YQUhD0IbLbXeCsfkf6qZIN?=
 =?iso-8859-1?Q?qb/Ne64OsDNAD5E5Nmpnj1SVHcxkRpXo8b/QJ5mdlUTaEV6gUIUu7XrzYS?=
 =?iso-8859-1?Q?EvVAWNpYKSQT81DJd/MOjrInOT84i1oCAOMrEjsKeg3dkw8VMRAY/wt2JR?=
 =?iso-8859-1?Q?bIp2PkbvxYEykPkORqfS+hhNKEYjscXervBjW6fwUILCvFYO7AtYlNSkKy?=
 =?iso-8859-1?Q?F+wsJosMOdV8aJmAcYOz6er7C+q/ABT/3C2mWmJVAsFPM6ntDYKgehdEif?=
 =?iso-8859-1?Q?qMV+Fb+RVweu/Y+nUYVD0X3eqMWUSqz7V1HKYTb2C3rUoh54gkTK2FPN3X?=
 =?iso-8859-1?Q?BVMQBhUelyqd2ZjbLL2pMt8YuBu51ewGVODp9xXHXGI6Qmh8fGXh4FQ1R8?=
 =?iso-8859-1?Q?HjEgiPnanuSxmZCeBUwqMng+dhcTsXpbd4fIT6MBE79U7H7qPVxabpWf57?=
 =?iso-8859-1?Q?5zhhsldfXSxsdxPqcnRG6d3np44WLC7p7F5bYWbqd9UpdZV8foqzSs+4i3?=
 =?iso-8859-1?Q?24jIZLM15cE8+Y1yzKVBEAQ65XjsLGuhv2VmAGmmCfadVuaVLtvhzgiG46?=
 =?iso-8859-1?Q?ExfYOXoOD9YhGpDghcwajC9iKrGc3DuSs7WL5jUe+zg4vSnJ9l4N7Jq+xU?=
 =?iso-8859-1?Q?ww8QBln7tkYEllPqknI8zI5mdaIGuH7M77ePsmGl+b2Ak0XFkFWdQUmLqb?=
 =?iso-8859-1?Q?h95MHs8y1qmsg/jHKqkTm5KTFvIqJ8v0bBNmWQVKU1fGxW7J0AGOfIskSN?=
 =?iso-8859-1?Q?9cpWIKNzcY4nouJdpYEcKroRDF0j9t0LOu0FpOZTxVCzAkYlatcwZFJaei?=
 =?iso-8859-1?Q?nG012gj5BwiAZb0WwBHVL6XjIjppTQk2dSRJEbwKvEnHZ+qhBjMDT9cZmV?=
 =?iso-8859-1?Q?nZPCNf6dCrqahBmtY5wm92uJnT4TlgVNFImpksb3g/wqrLHHKVkXKIjDo+?=
 =?iso-8859-1?Q?C/evOcXLz/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pbkeYbS420YyXZEfbYGtYWVefg9plTpyj3JevaUZpdTIgFA8t+IOBzfd1k?=
 =?iso-8859-1?Q?gLqNA2eq9sZRp95/ykzpYcznXwZJU8gOJvJaUaEf0l4A/nK7DLwrBYSGGR?=
 =?iso-8859-1?Q?RTI1CrWBDIr/dxmXYNJ/p/pB/qlI/+8xELpYMf/K9twQfcJEeDf6HCu1bq?=
 =?iso-8859-1?Q?IgK9QWWNhMSobpUdxGiY6p5B0Ft15f7zej2qFWo3QjBrtkVDFh9Jrl5ZuG?=
 =?iso-8859-1?Q?426MPDpjjHfMuju80pZaO4/t8h82/74WfTnsvZ2GXF8Eff9ca3iPY5nEjN?=
 =?iso-8859-1?Q?O72dVL8eMHECr0KdwAUOW9nwdjen3kFlwNXBb6WzCct7IOTZpad85H8EFZ?=
 =?iso-8859-1?Q?EIZlDvNZyFPcS3V5QklZ6a7+I18OsYi8kMWJb1uM3wbn3zeeKabMfIj7kx?=
 =?iso-8859-1?Q?uoNLWvA/m38IOFFKXa5jxiu9K9TqQhyx7kaADcFKF554Zyt3DQNYkE1rfn?=
 =?iso-8859-1?Q?fPghDxW3y03CcjpXBjNCS3hDOBJ6ZhKpZV4GZHQVk8EWkGrlF7xBS400Tt?=
 =?iso-8859-1?Q?GKq43RMubTOJ58Kh9+2HG5xyFO8gEbTVJpGSKzx505zhsrBcdZ7839vSm3?=
 =?iso-8859-1?Q?0X8H6hGEvIXpNtPeHhGwflRNzfpZhtoEBrYpKySfo7/J75Xj1iI6rSCITA?=
 =?iso-8859-1?Q?ZGAJAk2hr1SjKWMdzpm3WqsnzbJO06PJ+Hit1KJ89eBoeGNx12do2kQGiH?=
 =?iso-8859-1?Q?+7ozwfPn9bKeyXXh3GFeQzf9O4UByYpfDKVkWAc8nBDKmJgXnph8OpUPNx?=
 =?iso-8859-1?Q?s4pYIPwnbWiqGmac8eyNieMjpf+vSbbXU8eX4Bx4Rb6qTjLpryxWiFp04m?=
 =?iso-8859-1?Q?2YUYm0swQvYIcRRWMvBym55ne1L3JXIxBXVMAhyU0O2p9PzkyoBDpDuJMC?=
 =?iso-8859-1?Q?lZ/Lz1FXr3IMEWkgjtz1b4JpdKxvhdmpB2IEF6lMfk90aWKaPQNhwBeuoZ?=
 =?iso-8859-1?Q?nlBRQS8jQ0XXcKIr88xFQJhhx4LWCp9rjNTnHMAWPodi/L6P0FB5FRcf+b?=
 =?iso-8859-1?Q?IrTxyawKVKCEzWn2a7t6u2WKa0o8oDT8cJKuY9/4qbzjjEC69EXanJx5pj?=
 =?iso-8859-1?Q?lYoDiPq/AY+BkKjOhfv68vgPDEsa0OGu4VeEglKAEZsI3Ux9gNawS6E1BI?=
 =?iso-8859-1?Q?tnvZydHmLIaJFk3PhI/NRajC873UmyKbwoBjLDstUS4xdmGvtFipOie7l0?=
 =?iso-8859-1?Q?NA4g4lSU46Es7copJgbPLaWz9qiaOTj54qMlnRhbeuvcVGLClYu6QwTanG?=
 =?iso-8859-1?Q?cdLnREji76UJ+VWKYEvRUJ1JSEx4vU1u++ankwug6jg8S3fOZ9mgv67zdA?=
 =?iso-8859-1?Q?ZAa7qIgDFlP3+BmxjTAXnJHpYZ61zvsDkCw957GtaOKYaLrYKxXk1TMqqI?=
 =?iso-8859-1?Q?HZrjdEIYXnFoCSOFkvZ5D7w4DbiSWPfI48f5g6dV7MjAk+ycbvI95/PPG+?=
 =?iso-8859-1?Q?lpvwnWyrz1Gs6jdLfneORKfKl+tpyi2d+83vnQ8vYHiXf7u+aKMKnv93U4?=
 =?iso-8859-1?Q?u8CS55cpHlyCkD/xJDdpTXiPnoHrIlPs6w/w4kpVLBHmJuG55aCFWYgcrL?=
 =?iso-8859-1?Q?j6wNpJmHue6No5Xd5QtxE9oAN81hkNUYQ61gWypuEv1UUYBsudf6OLMffs?=
 =?iso-8859-1?Q?EsiaKXooA0hXryfeONamSmfCBC1DdUeYbWqom7jyBgRegydPNh6xcKVQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f865a60-ee9b-4819-bf5e-08dcabbb9c46
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:35:45.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V2oTIce/UaH5Wor22tOZvQfqKVtcrDdnGuewXCjQR9IcRkNs8h7baBGg0waw8z43Io2NvB5Spzf7O9HfpzYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com


hi, Jiri Olsa, and all,

we made some investigation for this regression and confirmed the code change
in ff474a78ce is irrelevant to stress-ng performance regression, instead, it's
a code alignment issue.

if we applied below patch for both this commit and parent, the regression will
disappear.

diff --git a/Kbuild b/Kbuild
index 464b34a08f51e..d33d30b772324 100644
--- a/Kbuild
+++ b/Kbuild
@@ -78,11 +78,11 @@ prepare: $(offsets-file) missing-syscalls $(atomic-checks)

 obj-y                  += init/
 obj-y                  += usr/
+obj-y                  += mm/
 obj-y                  += arch/$(SRCARCH)/
 obj-y                  += $(ARCH_CORE)
 obj-y                  += kernel/
 obj-y                  += certs/
-obj-y                  += mm/
 obj-y                  += fs/
 obj-y                  += ipc/
 obj-y                  += security/

we still make out below formal report FYI. and Feng Tang (Cced) is working on a
patch to mitigate this kind of less meaningful performance changes due to code
alignment.


Hello,

kernel test robot noticed a -12.3% regression of stress-ng.mprotect.ops_per_sec on:


commit: ff474a78cef5cb5f32be52fe25b78441327a2e7c ("uprobe: Add uretprobe syscall to speed up return probe")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mprotect
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240724/202407241609.9b33c747-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/mprotect/stress-ng/60s

commit: 
  190fec72df ("uprobe: Wire up uretprobe system call")
  ff474a78ce ("uprobe: Add uretprobe syscall to speed up return probe")

190fec72df4a5d4d ff474a78cef5cb5f32be52fe25b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.74 ±  3%      -0.7        4.05 ±  9%  mpstat.cpu.all.soft%
   3424654 ±  2%     -25.4%    2555508 ±  3%  numa-numastat.node1.local_node
   3457847 ±  2%     -25.2%    2588010 ±  3%  numa-numastat.node1.numa_hit
   3460293 ±  2%     -25.2%    2589125 ±  3%  numa-vmstat.node1.numa_hit
   3427101 ±  2%     -25.4%    2556623 ±  3%  numa-vmstat.node1.numa_local
 5.214e+08           -12.3%  4.573e+08        stress-ng.mprotect.ops
   8682811           -12.3%    7614767        stress-ng.mprotect.ops_per_sec
      3343            +1.4%       3392        stress-ng.time.system_time
    266.56            -9.7%     240.62        stress-ng.time.user_time
     64550 ±  2%      -4.1%      61895 ±  2%  proc-vmstat.nr_slab_unreclaimable
   6835207 ±  2%     -15.4%    5779808        proc-vmstat.numa_hit
   6768863 ±  2%     -15.6%    5713472        proc-vmstat.numa_local
  13293019 ±  2%     -15.5%   11227409        proc-vmstat.pgalloc_normal
  13067274 ±  2%     -15.8%   11002545        proc-vmstat.pgfree
     2e+10 ±  3%     -12.2%  1.756e+10 ±  6%  perf-stat.i.branch-instructions
   2.1e+08 ±  3%     -11.6%  1.856e+08 ±  5%  perf-stat.i.branch-misses
  35961320 ±  2%     -14.1%   30897555 ±  6%  perf-stat.i.cache-misses
  1.43e+08 ±  2%     -12.1%  1.257e+08 ±  5%  perf-stat.i.cache-references
      2.00           +12.4%       2.25 ±  2%  perf-stat.i.cpi
 9.396e+10 ±  3%     -12.1%  8.262e+10 ±  6%  perf-stat.i.instructions
      0.50           -10.4%       0.45 ±  4%  perf-stat.i.ipc
     65.08 ±  3%     -12.6%      56.86 ±  6%  perf-stat.i.metric.K/sec
   4163362 ±  3%     -12.6%    3638357 ±  6%  perf-stat.i.page-faults
      2.02           +13.2%       2.29        perf-stat.overall.cpi
      5301 ±  4%     +16.1%       6156 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.49           -11.7%       0.44        perf-stat.overall.ipc
 1.972e+10 ±  3%     -12.2%  1.731e+10 ±  5%  perf-stat.ps.branch-instructions
 2.071e+08 ±  3%     -11.6%  1.831e+08 ±  4%  perf-stat.ps.branch-misses
  35342279 ±  2%     -14.1%   30342927 ±  5%  perf-stat.ps.cache-misses
 1.412e+08 ±  2%     -12.0%  1.243e+08 ±  5%  perf-stat.ps.cache-references
 9.262e+10 ±  3%     -12.1%  8.143e+10 ±  5%  perf-stat.ps.instructions
   4109544 ±  3%     -12.6%    3592376 ±  6%  perf-stat.ps.page-faults
 5.823e+12           -11.1%  5.178e+12        perf-stat.total.instructions
     59.24            -3.1       56.14        perf-profile.calltrace.cycles-pp.__mprotect
     51.61            -2.3       49.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mprotect
     51.20            -2.3       48.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     49.61            -2.1       47.49        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     49.36            -2.1       47.27        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mprotect
     34.18            -1.9       32.28        perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.64            -1.3       23.38        perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      7.35            -0.6        6.70 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
     11.07            -0.6       10.44        perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
     13.35            -0.6       12.73        perf-profile.calltrace.cycles-pp.vma_merge.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      6.97            -0.6        6.36 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      1.14 ± 17%      -0.5        0.62 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      3.38            -0.4        3.01        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__mprotect
      3.16            -0.3        2.84        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      2.44            -0.3        2.14        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
      2.60            -0.3        2.30        perf-profile.calltrace.cycles-pp.clear_bhb_loop.__mprotect
      3.00            -0.3        2.73        perf-profile.calltrace.cycles-pp.stress_sig_handler
      1.93            -0.3        1.68        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.vma_modify.mprotect_fixup
      2.79            -0.2        2.55 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.vma_modify.mprotect_fixup.do_mprotect_pkey
      1.79            -0.2        1.56        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      2.10            -0.2        1.88        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.vma_modify.mprotect_fixup.do_mprotect_pkey
      1.73            -0.2        1.51        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.vma_modify
      1.95            -0.2        1.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__mprotect
      1.92            -0.2        1.70        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.vma_modify.mprotect_fixup
      2.20 ±  2%      -0.2        2.01 ±  4%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_merge.vma_modify.mprotect_fixup
      1.35            -0.2        1.15        perf-profile.calltrace.cycles-pp.security_file_mprotect.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50            -0.2        1.31        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
      2.76            -0.2        2.58 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      1.42            -0.2        1.24 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      1.77            -0.2        1.60        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify.mprotect_fixup
      0.60 ±  3%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.__perf_event_header__init_id.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap
      1.28            -0.1        1.14        perf-profile.calltrace.cycles-pp.can_modify_mm.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.43            -0.1        1.28 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.vma_modify
      1.35 ±  2%      -0.1        1.21 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.vma_merge.vma_modify
      0.75            -0.1        0.61        perf-profile.calltrace.cycles-pp.apparmor_file_mprotect.security_file_mprotect.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.79 ±  2%      -0.1        0.66 ±  3%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.vma_complete.vma_merge.vma_modify.mprotect_fixup
      1.97            -0.1        1.84        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      1.22 ±  2%      -0.1        1.09 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.vma_merge
      3.42            -0.1        3.30 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_merge.vma_modify.mprotect_fixup.do_mprotect_pkey
      0.94            -0.1        0.82        perf-profile.calltrace.cycles-pp.stress_mwc16modn
      0.86            -0.1        0.75        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_mprotect_mem
      0.81            -0.1        0.71        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.89            -0.1        0.80        perf-profile.calltrace.cycles-pp.stress_mwc32modn
      0.95 ±  2%      -0.1        0.86 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.vma_modify
      0.92            -0.1        0.84        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
      0.86 ±  2%      -0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      0.70            -0.1        0.62        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.46            -0.1        1.38 ±  4%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.vma_modify.mprotect_fixup
      0.62            -0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.simple_dname.perf_event_mmap_event.perf_event_mmap.mprotect_fixup.do_mprotect_pkey
      2.29            -0.1        2.22        perf-profile.calltrace.cycles-pp.mas_find.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58            -0.1        0.52        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.65            -0.1        0.59        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_sig_handler
      1.80            -0.0        1.75        perf-profile.calltrace.cycles-pp.pthread_sigmask
      0.75 ±  3%      -0.0        0.70 ±  3%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.force_sig_info_to_task
      0.75 ±  3%      -0.0        0.70 ±  3%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.force_sig_info_to_task.force_sig_fault
      0.80 ±  2%      -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore.bad_area_access_error
      0.80 ±  3%      -0.0        0.75 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore
      1.35            -0.0        1.31        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.23            -0.0        1.19        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_sig_handler
      1.22            -0.0        1.18        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_sig_handler
      1.16            -0.0        1.12        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_sig_handler
      0.66            -0.0        0.62        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
      0.64            +0.0        0.66        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.08            +0.0        1.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      0.62 ±  2%      +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_signal.arch_do_signal_or_restart
      0.62            +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_signal
      1.04            +0.0        1.08        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      0.66            +0.0        0.70 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode
      0.67            +0.0        0.71        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.52            +0.0        0.56        perf-profile.calltrace.cycles-pp.__bad_area.bad_area_access_error.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
      0.86            +0.1        0.91        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      0.82            +0.1        0.88        perf-profile.calltrace.cycles-pp.tlb_gather_mmu.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.87 ±  4%      +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.perf_output_begin.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap
      0.59            +0.1        0.67        perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.pthread_sigmask
      0.85            +0.1        0.93        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.43 ± 44%      +0.1        0.53        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.vma_modify.mprotect_fixup
      1.82            +0.1        1.92        perf-profile.calltrace.cycles-pp.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.91            +0.1        1.03        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey
      2.20            +0.3        2.55        perf-profile.calltrace.cycles-pp.up_write.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.up_read.__bad_area.bad_area_access_error.exc_page_fault.asm_exc_page_fault
     14.37            +1.5       15.84        perf-profile.calltrace.cycles-pp.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore.bad_area_access_error.exc_page_fault
     14.50            +1.5       15.98        perf-profile.calltrace.cycles-pp.force_sig_fault.__bad_area_nosemaphore.bad_area_access_error.exc_page_fault.asm_exc_page_fault
     12.56            +1.5       14.04        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal_locked.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore
     14.70            +1.5       16.20        perf-profile.calltrace.cycles-pp.__bad_area_nosemaphore.bad_area_access_error.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
     13.11            +1.5       14.62        perf-profile.calltrace.cycles-pp.__send_signal_locked.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore.bad_area_access_error
     16.61            +1.5       18.12        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
     12.16            +1.5       13.67        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.__sigqueue_alloc.__send_signal_locked.force_sig_info_to_task.force_sig_fault
     15.30            +1.5       16.82        perf-profile.calltrace.cycles-pp.bad_area_access_error.exc_page_fault.asm_exc_page_fault.stress_mprotect_mem
     14.79            +2.4       17.15        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     14.74            +2.4       17.10        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     10.32            +2.7       12.98        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault
     12.16            +2.7       14.84        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.irqentry_exit_to_user_mode.asm_exc_page_fault.stress_mprotect_mem
     34.36            +3.5       37.86        perf-profile.calltrace.cycles-pp.stress_mprotect_mem
     32.29            +3.8       36.05        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mprotect_mem
     59.32            -3.1       56.23        perf-profile.children.cycles-pp.__mprotect
     52.91            -2.3       50.60        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     52.48            -2.3       50.22        perf-profile.children.cycles-pp.do_syscall_64
     49.68            -2.1       47.55        perf-profile.children.cycles-pp.__x64_sys_mprotect
     49.58            -2.1       47.46        perf-profile.children.cycles-pp.do_mprotect_pkey
     34.28            -1.9       32.37        perf-profile.children.cycles-pp.mprotect_fixup
     24.66            -1.3       23.40        perf-profile.children.cycles-pp.vma_modify
      5.34            -0.7        4.66        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      5.37            -0.7        4.71        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      7.37            -0.7        6.71 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      5.05            -0.6        4.41 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      5.04            -0.6        4.39 ±  2%  perf-profile.children.cycles-pp.rcu_core
      4.95            -0.6        4.31        perf-profile.children.cycles-pp.irq_exit_rcu
      5.01            -0.6        4.37 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
     11.11            -0.6       10.48        perf-profile.children.cycles-pp.__split_vma
     13.43            -0.6       12.82        perf-profile.children.cycles-pp.vma_merge
      7.02            -0.6        6.42 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      4.58            -0.6        4.03 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      4.07            -0.5        3.60        perf-profile.children.cycles-pp.mas_store_prealloc
      6.63            -0.5        6.18        perf-profile.children.cycles-pp.vma_complete
      3.71            -0.4        3.26        perf-profile.children.cycles-pp.mas_wr_store_entry
      3.20            -0.4        2.77 ±  3%  perf-profile.children.cycles-pp.__slab_free
      5.57            -0.4        5.16 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      3.10            -0.4        2.74        perf-profile.children.cycles-pp.handle_signal
      2.97            -0.3        2.63        perf-profile.children.cycles-pp.clear_bhb_loop
      2.92            -0.3        2.59 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
      3.00            -0.3        2.73        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      5.08            -0.3        4.82 ±  3%  perf-profile.children.cycles-pp.down_write
      1.81 ±  2%      -0.2        1.57 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      2.31 ±  2%      -0.2        2.08 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.82            -0.2        1.59        perf-profile.children.cycles-pp.x64_setup_rt_frame
      2.09 ±  2%      -0.2        1.89 ±  5%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.38            -0.2        1.18        perf-profile.children.cycles-pp.security_file_mprotect
      1.52            -0.2        1.32        perf-profile.children.cycles-pp.get_sigframe
      2.32            -0.2        2.14        perf-profile.children.cycles-pp.stress_sig_handler
      1.42            -0.2        1.24        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.48            -0.2        1.32        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.23 ±  2%      -0.2        1.06 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.17            -0.2        3.01        perf-profile.children.cycles-pp.mas_find
      1.31            -0.1        1.16        perf-profile.children.cycles-pp.can_modify_mm
      0.77            -0.1        0.63        perf-profile.children.cycles-pp.apparmor_file_mprotect
      1.11            -0.1        0.97        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.98            -0.1        1.84        perf-profile.children.cycles-pp.vm_area_dup
      1.18            -0.1        1.06 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.97            -0.1        0.85        perf-profile.children.cycles-pp.stress_mwc16modn
      2.09            -0.1        1.96        perf-profile.children.cycles-pp.mas_walk
      1.30            -0.1        1.18        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.89            -0.1        0.78        perf-profile.children.cycles-pp.sync_regs
      0.83            -0.1        0.73        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.94            -0.1        0.84        perf-profile.children.cycles-pp.stress_mwc32modn
      0.73            -0.1        0.64        perf-profile.children.cycles-pp.native_irq_return_iret
      0.78            -0.1        0.69        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.45            -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.65 ±  3%      -0.1        0.57 ±  3%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.65            -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.simple_dname
      0.57            -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.72            -0.1        0.65        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.92            -0.1        1.85        perf-profile.children.cycles-pp.pthread_sigmask
      0.62            -0.1        0.55        perf-profile.children.cycles-pp.mod_objcg_state
      0.60            -0.1        0.54        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.65 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.mt_find
      0.82            -0.1        0.76        perf-profile.children.cycles-pp.___slab_alloc
      0.72 ±  4%      -0.1        0.66 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.37            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.43 ±  2%      -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.50            -0.0        0.45 ±  2%  perf-profile.children.cycles-pp.prepend_copy
      0.46            -0.0        0.42        perf-profile.children.cycles-pp.ima_file_mprotect
      0.23 ±  4%      -0.0        0.19 ± 13%  perf-profile.children.cycles-pp.__memcpy
      0.57            -0.0        0.52        perf-profile.children.cycles-pp.fpu__clear_user_states
      0.44            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.mtree_load
      0.39            -0.0        0.35        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.43            -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.copy_from_kernel_nofault
      0.42            -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.37            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.vma_set_page_prot
      0.39            -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.kfree
      0.27 ±  4%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.local_clock
      0.26            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.28            -0.0        0.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.20 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.strlen
      0.23 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.mas_update_gap
      0.50            -0.0        0.47        perf-profile.children.cycles-pp.kmalloc_trace_noprof
      0.18 ±  3%      -0.0        0.15        perf-profile.children.cycles-pp.vm_get_page_prot
      0.37 ±  2%      -0.0        0.34        perf-profile.children.cycles-pp.vma_wants_writenotify
      0.25 ±  4%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.23 ±  3%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      0.22 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.22 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.30 ±  5%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.aa_file_perm
      0.29 ±  2%      -0.0        0.27        perf-profile.children.cycles-pp.mas_pop_node
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.copy_from_kernel_nofault_allowed
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.28            -0.0        0.26        perf-profile.children.cycles-pp.x64_sys_call
      0.14            -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.uprobe_mmap
      0.42            -0.0        0.40        perf-profile.children.cycles-pp.mas_prev_node
      0.12 ±  9%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.find_vma
      0.12 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__put_user_8
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.amd_clear_divider
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mas_put_in_tree
      0.10            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vm_stat_account
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.mas_data_end
      0.10            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.error_entry
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.__arch_override_mprotect_pkey
      0.19            +0.0        0.20        perf-profile.children.cycles-pp.mas_prev
      0.08            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mas_prev_setup
      0.37            +0.0        0.39        perf-profile.children.cycles-pp.mas_ascend
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.send_signal_locked
      0.47            +0.0        0.49        perf-profile.children.cycles-pp.__set_current_blocked
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.prepare_signal
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.perf_output_put_handle
      0.54            +0.0        0.57 ±  2%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.52            +0.0        0.56        perf-profile.children.cycles-pp.__bad_area
      0.48            +0.0        0.52        perf-profile.children.cycles-pp.up_read
      0.88            +0.0        0.92        perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__init_rwsem
      0.28 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.36            +0.1        0.42        perf-profile.children.cycles-pp.mas_next_node
      0.41            +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.fput
      0.89 ±  4%      +0.1        0.96 ±  2%  perf-profile.children.cycles-pp.perf_output_begin
      0.08            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.63            +0.1        0.71        perf-profile.children.cycles-pp.sigprocmask
      0.83            +0.1        0.91        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.85            +0.1        0.94        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.86            +0.1        1.95        perf-profile.children.cycles-pp.down_write_killable
      1.77            +0.1        1.88        perf-profile.children.cycles-pp.mas_preallocate
      0.89            +0.1        1.03        perf-profile.children.cycles-pp.recalc_sigpending
      5.06            +0.4        5.47        perf-profile.children.cycles-pp.up_write
     14.39            +1.5       15.86        perf-profile.children.cycles-pp.force_sig_info_to_task
     14.51            +1.5       15.99        perf-profile.children.cycles-pp.force_sig_fault
     12.57            +1.5       14.05        perf-profile.children.cycles-pp.__sigqueue_alloc
     14.72            +1.5       16.22        perf-profile.children.cycles-pp.__bad_area_nosemaphore
     13.13            +1.5       14.64        perf-profile.children.cycles-pp.__send_signal_locked
     16.64            +1.5       18.16        perf-profile.children.cycles-pp.exc_page_fault
     12.16            +1.5       13.67        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
     15.30            +1.5       16.83        perf-profile.children.cycles-pp.bad_area_access_error
     16.04            +2.3       18.35        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
     15.92            +2.3       18.23        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     10.32            +2.7       12.98        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
     12.20            +2.7       14.87        perf-profile.children.cycles-pp.get_signal
     36.12            +3.3       39.41        perf-profile.children.cycles-pp.stress_mprotect_mem
     35.30            +3.5       38.83        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.60            -0.4        3.18        perf-profile.self.cycles-pp.stress_mprotect_mem
      3.11            -0.4        2.69 ±  3%  perf-profile.self.cycles-pp.__slab_free
      3.55            -0.4        3.19        perf-profile.self.cycles-pp.do_mprotect_pkey
      2.92            -0.3        2.59        perf-profile.self.cycles-pp.clear_bhb_loop
      2.26 ±  3%      -0.3        2.00 ±  8%  perf-profile.self.cycles-pp.perf_event_mmap_output
      1.70 ±  2%      -0.2        1.48 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      1.23 ±  2%      -0.2        1.06 ±  3%  perf-profile.self.cycles-pp.mas_wr_node_store
      1.16 ±  2%      -0.2        1.00 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.07            -0.1        0.94        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.93            -0.1        1.80        perf-profile.self.cycles-pp.mas_walk
      0.63            -0.1        0.52 ±  2%  perf-profile.self.cycles-pp.apparmor_file_mprotect
      0.92            -0.1        0.82        perf-profile.self.cycles-pp.__split_vma
      0.88            -0.1        0.77        perf-profile.self.cycles-pp.stress_mwc16modn
      1.11            -0.1        1.00 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.88            -0.1        0.78        perf-profile.self.cycles-pp.sync_regs
      0.73            -0.1        0.64        perf-profile.self.cycles-pp.native_irq_return_iret
      0.71            -0.1        0.62        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.86            -0.1        0.77        perf-profile.self.cycles-pp.stress_mwc32modn
      0.44            -0.1        0.36 ±  3%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.71            -0.1        0.64 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.62            -0.1        0.56        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.54            -0.1        0.48        perf-profile.self.cycles-pp.mas_find
      0.55            -0.1        0.50        perf-profile.self.cycles-pp.can_modify_mm
      0.43            -0.1        0.38        perf-profile.self.cycles-pp.kmem_cache_free
      0.56            -0.0        0.51        perf-profile.self.cycles-pp.do_syscall_64
      0.44            -0.0        0.39        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.43            -0.0        0.38        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.57 ±  2%      -0.0        0.52 ±  4%  perf-profile.self.cycles-pp.__call_rcu_common
      0.56 ±  2%      -0.0        0.51        perf-profile.self.cycles-pp.mt_find
      0.35            -0.0        0.31        perf-profile.self.cycles-pp.fpu__clear_user_states
      0.37            -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.43            -0.0        0.39        perf-profile.self.cycles-pp.mod_objcg_state
      0.32 ±  3%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap
      0.24            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.32            -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.43            -0.0        0.39        perf-profile.self.cycles-pp.ima_file_mprotect
      0.41            -0.0        0.37        perf-profile.self.cycles-pp.mtree_load
      0.22            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.36            -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.42            -0.0        0.39        perf-profile.self.cycles-pp.mas_next_slot
      1.35            -0.0        1.32        perf-profile.self.cycles-pp.__mprotect
      0.41            -0.0        0.38        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.50 ±  2%      -0.0        0.47 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.18 ±  4%      -0.0        0.15 ± 12%  perf-profile.self.cycles-pp.__memcpy
      0.36 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.kfree
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.strlen
      0.28            -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.24            -0.0        0.21        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  5%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.save_xstate_epilog
      0.12            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.simple_dname
      0.20 ±  2%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.force_sig_info_to_task
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.21 ±  3%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.14 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.20 ±  3%      -0.0        0.18 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.31 ±  2%      -0.0        0.28        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.15 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.36            -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.38            -0.0        0.36        perf-profile.self.cycles-pp.mprotect_fixup
      0.26            -0.0        0.25        perf-profile.self.cycles-pp.mas_pop_node
      0.15 ±  2%      -0.0        0.13        perf-profile.self.cycles-pp.pthread_sigmask
      0.23 ±  2%      -0.0        0.21        perf-profile.self.cycles-pp.vma_wants_writenotify
      0.28            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.copy_from_kernel_nofault
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.mas_prev_node
      0.13            -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.11 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.uprobe_mmap
      0.28            -0.0        0.27        perf-profile.self.cycles-pp.get_signal
      0.23            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.copy_from_kernel_nofault_allowed
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.__put_user_8
      0.18 ±  2%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__x64_sys_mprotect
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.11            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.error_entry
      0.10 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.stress_sig_handler
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.mas_data_end
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.handle_signal
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.rcu_do_batch
      0.34            +0.0        0.35        perf-profile.self.cycles-pp.mas_ascend
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.vma_adjust_trans_huge
      0.54            +0.0        0.56        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  2%      +0.0        0.18        perf-profile.self.cycles-pp.lock_vma_under_rcu
      1.12            +0.0        1.14        perf-profile.self.cycles-pp.vma_merge
      0.09            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.prepare_signal
      0.43            +0.0        0.46        perf-profile.self.cycles-pp.mas_preallocate
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.mas_prev_slot
      0.52            +0.0        0.55 ±  2%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.45            +0.0        0.50        perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.send_signal_locked
      0.17 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.mas_next_node
      0.80 ±  4%      +0.1        0.86 ±  2%  perf-profile.self.cycles-pp.perf_output_begin
      0.13 ±  2%      +0.1        0.19        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.38            +0.1        0.44        perf-profile.self.cycles-pp.fput
      0.05            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__perf_sw_event
      0.77            +0.1        0.85        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.79            +0.1        0.88        perf-profile.self.cycles-pp.tlb_finish_mmu
      1.52            +0.1        1.66        perf-profile.self.cycles-pp.down_write_killable
      0.88            +0.1        1.02        perf-profile.self.cycles-pp.recalc_sigpending
      4.50            +0.5        4.96        perf-profile.self.cycles-pp.up_write
     12.16            +1.5       13.67        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
     10.32            +2.7       12.98        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

