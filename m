Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE8212627;
	Thu,  7 Nov 2024 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986103; cv=fail; b=CVhyi3EGWWeG/3W2TSb9c4Xb97KyGEuwIn9km/dZObCTkZCx02Zo67E3wcJal+THhNAkSblv3lZj68khTwmmGgYDo74Xji9gZYM0PQfiydINGgMPlaDdLvAHWo36jfN7TBw7Nbn9bbhvbsVv3AkJKOAwb6mse/AKcYTNbhcHap8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986103; c=relaxed/simple;
	bh=7vjEaPfUkBjxU6s1qjE6qx13VeNi2G7jhlL23Az5/qs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uLZ/RoJ0k8PWFbpGWekdlWZDLMgKVbnGdnXVxOZEmlPBAbNi2utDvZszRF7M1StMbAwTUUlo8w8odUpxqNmaurPbJrl8XNjSnC27P3w9q5pALER6iXu/HTwz8WDwikwzq2NhAGda8KkmkR92DefAdCoUKpCIfqiAzCXPh+dwev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMK4z3MZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMK4z3MZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730986099; x=1762522099;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=7vjEaPfUkBjxU6s1qjE6qx13VeNi2G7jhlL23Az5/qs=;
  b=GMK4z3MZ3w8C8Y/DdmkeU3wqsmXh/s2gp16iGqoqtzezqBptNkYSbAqv
   NFI3w6NrMn5Gh0gevQKSDSSc95lDMJ1EMmgtJxAqtAJJkYUgjmf2WjAct
   U2lasOL34ZyLzL8tZoQi39AsgMf9Ny9haL1+bzNSetzS7CTrhAyI05h4x
   +LS4MjZLNqgIKE354PXtBHpFwxdU4lasdRma1JQjtk21BP3A8fDJAbH7V
   zpiLJOeRN0C7vIQdUDGJMAztZTblmZrrVTCrCHbyC6O3BJVesqLNDQf3l
   vDvjpLzv4h62aXlFI5w5X7q8YYiwEPkEQCum5De9P8UQc6s7rXiKy3zDi
   g==;
X-CSE-ConnectionGUID: psYN+51gRwGjj+u0RJ+0sA==
X-CSE-MsgGUID: dnpfGHW7QPqy0/Yl8Tldwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53384973"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53384973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:28:17 -0800
X-CSE-ConnectionGUID: uO1KkJQXT/62YtVNUIt4RQ==
X-CSE-MsgGUID: Yso91+o9RIeKp+586kJimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="85875713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 05:28:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 05:28:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 05:28:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 05:28:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waGG9sSsSAstdzltXvuKVT3GRUo6dvhW1uL33lwCiFYda4LMVyCVUT/Hi3LSw8NNus2VJzwga7aeMO1//CVZnZE/f2kggBf851u7qdeisnpcWFFbKSjMq8c+lUbAMq0q5LqLGAyBiRgwGYl3OLxG9XCH2NE6EJ0EGh5R8KSrEvbBw7X75t/Fap+E1xlqMd2BbTGQ53Kb5h9vaCGmjiPlleeefS9rgosUs9H96fbE732npDA65nI7I9dY2I7mjzAmApMcoVDhiNoxti6sud6FTJUfS0g+ylIm7KaoUMxo9sKMjnTbxXwvCA4syfB+RI0XO7NH7a5bxrLmQzFaHiMQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0G22Q9sMNqeLWiG52Lj0ImL3dP4d3K3j/ee5Mv8ZaM=;
 b=ZTlN2BmpLtUooQ90LW8R2skiu8Ea9BDs4XcTFycGzQh8fFweafoEPIuewmbOkpEtAtM4PmhaAC+rWop/ifi0bKcV7URMebqN9m7BElXWCHYrk6KI6A2JTkv/F+h4T5Q6mJdsvuocs4WeJnBUWyQnjav1Ea5XpG6OpOiKHkQtPrnvqQgwu1FUWEo41jQljB0n+f7vJcr3ftcjBlGfBpcKVuWgRUpcBSI9iqtPB3qJmMNOC0Z8kktlnB4ZqNAqEgJRwtkG3PNCEfLjEHpnmejHDLytMVXsH99yeUOZX8H04i11mE2FgkWbOgHikHPqx3VUkPbLxRuRCDKTg0y+ZSnhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 13:27:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 13:27:59 +0000
Date: Thu, 7 Nov 2024 21:27:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Heiko Carstens" <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	"Alexander Gordeev" <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [fprobe]  5dc47be68c:
 netperf.Throughput_tps 16.3% regression
Message-ID: <202411071649.56f67eca-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f35953-fef9-450b-a4f3-08dcff2fff08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?GWIGy3Ub0dxeefpa4j1QTB7OfKM6joN5b57F7iq3iVSx6wjmEcSkBQD59/?=
 =?iso-8859-1?Q?Q0RxtVhxw6OFy67Wb1Bm/LG6xbNH+YnkeXUmJ3J4JCXL5uizN9QW2HErdX?=
 =?iso-8859-1?Q?4Svv/hHrWbsHX18RDdDrUjlicIaUAb+gl3ZcBu6oi8Z7+74RZs/lAYDw9R?=
 =?iso-8859-1?Q?CCZ8HCkvPIrUn4SQ182rS2NfjPo9E3A4HvITQGW3nWcjyOxCnXHDujDzMd?=
 =?iso-8859-1?Q?s0ridcKOlbNx0x9+cZF0vzJp989Z/37K1ufst7bLJzX6E9e98oqfjzJZok?=
 =?iso-8859-1?Q?ns2/zm6/1I58mbTHtVuFKqDyq6TQgJX5lSobGYzH9il+sstya5tGh8RhYt?=
 =?iso-8859-1?Q?x0BMny6D/pxTNm6XO/rbSAgwFgOniTAK7lZzSDLSNR0Q1epnAQj1p7pzdE?=
 =?iso-8859-1?Q?ZSRJ36lOYldZ1AG2W3cY5b45CFMYFV9agpTfqXoDjek81ggl8c6eyqDDv7?=
 =?iso-8859-1?Q?nkDBsD+EsWfEoOjBjoWyzVBUf8h1Ghuqrbn3SNUB+z4kUwpvWMDYJXLnJt?=
 =?iso-8859-1?Q?ZWB3QWUmvjGjIg4rB+DtA7RrhYNbzE1mYJ4mQY0auK8M4sQ319o2WgL53e?=
 =?iso-8859-1?Q?4SSnfgj3JLWvQzl8S5fJBUGjfVKirmTOGCriN9R0UOfrIklWqU4zZqumdM?=
 =?iso-8859-1?Q?TksVYrQxm2bNNk2iIFZcbgP8piMPzMYfkyUpjdGqe1YsOO63vV/XOovvKm?=
 =?iso-8859-1?Q?u/UTs1M4j4RuJRJW4ozIVnv/adsRQpp22uCiKj9/soOJUCPaAACTNgbytQ?=
 =?iso-8859-1?Q?1t+jSlszHWmcDFDfEtZMe21Ya8t69G7fOwh+5hN+gQ6KbDz4vtcpnRYBKt?=
 =?iso-8859-1?Q?4t5fMMcIOp5g0Bu/K6aEmT1z76BGbRGkAhDB352Jn3f1cGVaezGrUn3dO9?=
 =?iso-8859-1?Q?uvJN/plNWvr5t3ZGc2xoCp693Mb3inwlDhSpv0M8/9EUHLRVbJUfR+Rty0?=
 =?iso-8859-1?Q?FoitOVW3/hggAY7Mp3KCN7lJ5AGgpYC51uaFrFkL2Za0lI6b5tHseLRWR3?=
 =?iso-8859-1?Q?1Y87070W/9z7LYWCiREseeky5EHwxXXpJCDCJXMjILAePmkVj7v0Rdz0KA?=
 =?iso-8859-1?Q?uhqmqAsoBhB639rAiX1ca+IQKClskJhfF+iSOZI0Ty1LhpG5ZI8eID5DME?=
 =?iso-8859-1?Q?YH1Gf+gBFK2QN3GVvC6iU7udPXSeo55zx6qRpn+a6zJUJunZDBGm/lvVT0?=
 =?iso-8859-1?Q?OeKUzj6uU2T1+mjVSH1UI9bod53HtR5OlUJHR6h0BaQdzDUd1Qp+wpuiHQ?=
 =?iso-8859-1?Q?q5p3lGUTN2dlT9LX+kHGrXMABoXPARp468TDsEzXBL6s93SzudCJTDz/vS?=
 =?iso-8859-1?Q?qOFP7IokxQAYweV3Cbo/C15Shw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gqO2npLUPza1IdMO8ES/KDVD+4h9Ec+hQdAXI08YOz9BqO0RPfQbpCrCTx?=
 =?iso-8859-1?Q?BEIxO6zItyEiXMgNVMFmt5/tVRB4W+X+ZZ88M1Hc0COayCfU4me+OgvKZ5?=
 =?iso-8859-1?Q?mtZiiwh3/uVp0xpAc37U/+sl9p9Dk2/SOebM4Blwn+JuyxigvgoDF/PXBo?=
 =?iso-8859-1?Q?8M33/wo6XcoCdQDYA5q+jAZ9ohNbWQTDHvnysocHXYm1RltxQMqHiWD3Mu?=
 =?iso-8859-1?Q?znmZchGZPziNBSsFRYlmRoUqfv4yJpieKXaB8i6Pz5+ItZOBzJD8z8b3EZ?=
 =?iso-8859-1?Q?tmcW7C3iomncQP7j7piUkV/sBYCuwdILins+OXCwmAbqcnugYc5WdBHeBG?=
 =?iso-8859-1?Q?5hOL/2M5G6ls0bXEF2bUdPazrOMx9xEpI9jxahJdiuhcMlIxc1cykWkj/W?=
 =?iso-8859-1?Q?6Fv9LnR5JiFGClZycdi1HcS7GQYZPsaT4D6yGK2cx4pGIofgU+ThH1oNlK?=
 =?iso-8859-1?Q?0wzR0RrvG+jTFC/p4XDtDf6weh5FQOXZgHCJRZREdrtDJZjljfJk+Ib7ex?=
 =?iso-8859-1?Q?s3JfVDWDIX97jxlplk3JM7KxUCj/QYsZIJ9kQwgX3JbZjYmav7Ybs2+ol1?=
 =?iso-8859-1?Q?8QLCJNbJA0/UXmTyiaZRiCuI77sIT9dSj8ayNdFI/YbOUh8XZNBYUOxxZ1?=
 =?iso-8859-1?Q?JaLKqdfKxzG3wYY5CJxa455mJe5y3i3sb21M+p1dK1Ribh76qbwni0+cQo?=
 =?iso-8859-1?Q?Ri0HKePXO3+D0BgTidp6PCBrzpN9II59wgPCYC3W04/QY5CUF2XoaKbXXg?=
 =?iso-8859-1?Q?MMrd6a/XPMJBlfHFSwNGVN0sm2wJgq3OpAtom25F/GCtiHUBwkMhguF6rc?=
 =?iso-8859-1?Q?ITzkmXOMoxDq2fhAq8OOziKYeR34h/HdFzmWKXJ3+aNvqHboRdCSq0WODK?=
 =?iso-8859-1?Q?SHAK8rc691G3XkqgLAeH1gBaH3kPSOVEtUt8c5kAQhBVDSNEPMvV/QPsjW?=
 =?iso-8859-1?Q?qImsl+Bne2ruj4wVrg88YvhZYhJEmIjwq+TMvF1a130kt6GZdO5S3xFls1?=
 =?iso-8859-1?Q?eF1YzAcCMshANglk1frkZ9WzEMeGoi2w285/lYqnicU4GgiznlAuELhI7x?=
 =?iso-8859-1?Q?zLszxN0M4rIMrgwYbTpVXGBJUzDCGc9GZH+43OY8lHnyx0rb6ngonxRruk?=
 =?iso-8859-1?Q?TbqS1EnbhAMMSAPn5VORI366NZI8iUlIEOIBdaEwniCXpVOE+0nAJj2iiW?=
 =?iso-8859-1?Q?IdOTPnk1Qx1ckiRII0y5N9Bs3KkcBRHKzaTyF+PH/T+DE5u4KfgJ/ROG32?=
 =?iso-8859-1?Q?50FS6y5zbTyUSIXmPGA94t8AGO7fP8H9E+t4mawMMhVW/BqRM24tFFq52y?=
 =?iso-8859-1?Q?wFIP7JI5oacU6L9Wv1NCDKrx0iSk5P182zEKgvgm6tZZsdpneLqfeC+VTn?=
 =?iso-8859-1?Q?XV3Iz4K06Mxx2xyMmbZpvdqaIU8ONvKtsjupIofX6cvn6D39tEJOVaBWFp?=
 =?iso-8859-1?Q?vPq46GsyelNQ7rzgKcAaRSNfZgvv2mzbNzac3VkMAIYtMK27fCleFtpV3r?=
 =?iso-8859-1?Q?VrNnrOt7UHVy64lQ4BSF6e6HB7XDYVaQk4RKdQ3T3wblyXj9ZFx+s1pBLk?=
 =?iso-8859-1?Q?lqjJCJG6nA6yV9L3hBH2Ve4uAS3RFdtV04ZurrJYZ9k9w3dOV4aXtAmTf/?=
 =?iso-8859-1?Q?TUL/fzUwPpZXNCKi74jXnYcIlH10ccPoe8DGr/SHdVWnQ29+8vb6JZsA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f35953-fef9-450b-a4f3-08dcff2fff08
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 13:27:59.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYtAZ76Kdt1/B6lLK87BXyV4V1li9QZQd1qtRFI4andGBgTaAfnOkg5DGH1taBZY0Lc+KhWF4COZ4vEgiUXTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com



Hello,

by this commit, we notice below config diff.

--- /pkg/linux/x86_64-rhel-8.3/gcc-12/2a6687e811bef512c4338923329ba866c1ae531c/.config  2024-11-05 23:14:55.426091615 +0800
+++ /pkg/linux/x86_64-rhel-8.3/gcc-12/5dc47be68cd01722d4eb768312945a0545fdc3a4/.config  2024-11-05 09:49:16.462681140 +0800
@@ -7605,7 +7605,7 @@ CONFIG_DYNAMIC_FTRACE=y
 CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
 CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
-# CONFIG_FPROBE is not set
+CONFIG_FPROBE=y
 CONFIG_FUNCTION_PROFILER=y
 CONFIG_STACK_TRACER=y
 # CONFIG_IRQSOFF_TRACER is not set
@@ -7620,6 +7620,7 @@ CONFIG_TRACER_SNAPSHOT=y
 CONFIG_BRANCH_PROFILE_NONE=y
 # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_FPROBE_EVENTS=y
 CONFIG_KPROBE_EVENTS=y
 # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
 CONFIG_UPROBE_EVENTS=y


not sure if it's expected for below netperf performance regression from this
config diff. just FYI what we observed in our tests.


kernel test robot noticed a 16.3% regression of netperf.Throughput_tps on:


commit: 5dc47be68cd01722d4eb768312945a0545fdc3a4 ("fprobe: Rewrite fprobe on function-graph tracer")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

testcase: netperf
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411071649.56f67eca-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241107/202411071649.56f67eca-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_CRR/netperf

commit: 
  2a6687e811 ("ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC")
  5dc47be68c ("fprobe: Rewrite fprobe on function-graph tracer")

2a6687e811bef512 5dc47be68cd01722d4eb7683129 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3144158 ± 20%     -30.8%    2176824 ± 11%  numa-numastat.node0.numa_hit
   3143978 ± 20%     -30.8%    2176546 ± 11%  numa-vmstat.node0.numa_hit
   4413012 ±  2%     -16.0%    3705063 ±  5%  vmstat.system.cs
      0.38 ±  6%      -0.1        0.32 ±  7%  mpstat.cpu.all.irq%
      2.33            -0.2        2.08 ±  2%  mpstat.cpu.all.usr%
   5300022 ±  2%     -15.1%    4499922 ±  4%  sched_debug.cpu.nr_switches.avg
   7173383 ±  6%     -17.2%    5938731 ±  6%  sched_debug.cpu.nr_switches.max
    926.60 ±  4%     +51.9%       1407 ±  2%  perf-c2c.DRAM.local
     27791 ±  2%     +19.6%      33243 ±  2%  perf-c2c.HITM.local
      8285 ±  5%     -11.4%       7340 ±  4%  perf-c2c.HITM.remote
     36076 ±  2%     +12.5%      40584 ±  2%  perf-c2c.HITM.total
     41595            -4.8%      39602 ±  2%  proc-vmstat.nr_slab_reclaimable
   7577382 ±  5%     -23.2%    5821185 ± 10%  proc-vmstat.numa_hit
   7433432 ±  5%     -23.5%    5688642 ± 11%  proc-vmstat.numa_local
  34316646 ± 13%     -29.0%   24362518 ± 11%  proc-vmstat.pgalloc_normal
  32812824 ± 15%     -29.7%   23082358 ± 11%  proc-vmstat.pgfree
   1665462           -16.3%    1394314 ±  4%  netperf.ThroughputBoth_total_tps
      6505           -16.3%       5446 ±  4%  netperf.ThroughputBoth_tps
   1665462           -16.3%    1394314 ±  4%  netperf.Throughput_total_tps
      6505           -16.3%       5446 ±  4%  netperf.Throughput_tps
 3.461e+08 ± 10%     -16.7%  2.883e+08 ±  8%  netperf.time.involuntary_context_switches
      6034            +5.9%       6392        netperf.time.percent_of_cpu_this_job_got
     17935            +6.3%      19069        netperf.time.system_time
    506.80            -8.4%     464.27        netperf.time.user_time
 3.337e+08 ±  6%     -15.6%  2.816e+08        netperf.time.voluntary_context_switches
 4.996e+08           -16.3%  4.183e+08 ±  4%  netperf.workload
      0.05 ±  5%     +35.1%       0.07 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      1.80 ±115%     -95.3%       0.08 ± 22%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.01 ± 55%    +326.6%       0.04 ± 72%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.18 ± 12%    +277.2%       0.67 ±146%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
    634.42 ±109%     -99.2%       5.22 ±106%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.01 ± 66%    +441.7%       0.06 ± 62%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    433.76 ± 31%     +64.4%     713.04 ± 24%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ± 14%     +22.0%       0.13 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.__inet_bind.inet_bind_sk.__sys_bind
      0.10 ±  9%     +27.9%       0.13 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
    432.00 ± 30%     +62.0%     699.69 ± 22%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     13.08 ±191%     -96.9%       0.40 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_sk_alloc.sk_prot_alloc
      0.32 ± 14%  +34733.0%     109.86 ±222%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_connect.__sys_connect_file.__sys_connect
      0.48 ±  3%     +82.7%       0.88 ±  3%  perf-stat.i.MPKI
  3.83e+10           -15.9%  3.223e+10 ±  4%  perf-stat.i.branch-instructions
  3.41e+08           -15.6%   2.88e+08 ±  4%  perf-stat.i.branch-misses
     22.65            +0.7       23.35        perf-stat.i.cache-miss-rate%
  91818015 ±  3%     +58.7%  1.458e+08 ±  5%  perf-stat.i.cache-misses
 4.023e+08 ±  4%     +54.1%  6.198e+08 ±  6%  perf-stat.i.cache-references
   4452703 ±  2%     -16.1%    3736792 ±  5%  perf-stat.i.context-switches
      1.61           +19.5%       1.92 ±  4%  perf-stat.i.cpi
      3514 ±  3%     -36.7%       2224 ±  5%  perf-stat.i.cycles-between-cache-misses
 2.016e+11           -15.9%  1.695e+11 ±  4%  perf-stat.i.instructions
      0.63           -15.8%       0.53 ±  3%  perf-stat.i.ipc
     34.79 ±  2%     -16.1%      29.20 ±  5%  perf-stat.i.metric.K/sec
      0.46 ±  4%     +88.6%       0.86 ±  2%  perf-stat.overall.MPKI
     22.83            +0.7       23.53        perf-stat.overall.cache-miss-rate%
      1.61           +19.6%       1.92 ±  4%  perf-stat.overall.cpi
      3531 ±  3%     -36.6%       2236 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.62           -16.2%       0.52 ±  3%  perf-stat.overall.ipc
 3.819e+10           -15.9%  3.212e+10 ±  4%  perf-stat.ps.branch-instructions
 3.399e+08           -15.6%   2.87e+08 ±  4%  perf-stat.ps.branch-misses
  91573862 ±  3%     +58.7%  1.453e+08 ±  5%  perf-stat.ps.cache-misses
 4.011e+08 ±  4%     +54.0%  6.178e+08 ±  6%  perf-stat.ps.cache-references
   4438237 ±  2%     -16.1%    3724243 ±  5%  perf-stat.ps.context-switches
  2.01e+11           -15.9%   1.69e+11 ±  4%  perf-stat.ps.instructions
 6.183e+13           -16.0%  5.196e+13 ±  3%  perf-stat.total.instructions
     26.19            -7.5       18.73 ± 22%  perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     26.19            -7.5       18.73 ± 22%  perf-profile.calltrace.cycles-pp.accept_connections.main
     26.19            -7.5       18.73 ± 22%  perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     26.19            -7.5       18.73 ± 22%  perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     24.02            -3.5       20.47 ±  3%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     17.62            -2.4       15.18 ±  3%  perf-profile.calltrace.cycles-pp.__close.send_omni_inner.send_tcp_conn_rr.main
     17.38            -2.4       14.97 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr.main
     17.37            -2.4       14.96 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr
     17.28            -2.4       14.88 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner
     18.25            -2.2       16.01 ± 12%  perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     29.53            -2.1       27.43 ±  3%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     29.42            -2.1       27.34 ±  3%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     28.97            -2.0       26.98 ±  3%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     29.30            -2.0       27.34 ±  3%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     27.96            -2.0       26.01 ±  3%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     29.19            -1.9       27.26 ±  3%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     18.89            -1.9       16.96 ±  3%  perf-profile.calltrace.cycles-pp.__sock_release.sock_close.__fput.__x64_sys_close.do_syscall_64
     18.93            -1.9       17.00 ±  3%  perf-profile.calltrace.cycles-pp.sock_close.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.66            -1.9       26.76 ±  3%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     18.67            -1.9       16.81 ±  3%  perf-profile.calltrace.cycles-pp.inet_release.__sock_release.sock_close.__fput.__x64_sys_close
     26.65            -1.9       24.79 ±  4%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     26.76            -1.9       24.91 ±  3%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     26.15            -1.8       24.33 ±  4%  perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     17.13            -1.7       15.43 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     16.97            -1.7       15.31 ±  2%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      2.70 ±  8%      -1.6        1.14 ± 38%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.69 ±  8%      -1.6        1.13 ± 38%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      7.74            -1.3        6.40        perf-profile.calltrace.cycles-pp.__close.recv_omni.process_requests.spawn_child.accept_connection
      7.48 ±  2%      -1.3        6.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests
      7.49 ±  2%      -1.3        6.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests.spawn_child
      4.39            -1.3        3.12 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      7.37 ±  2%      -1.3        6.11        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni
      4.49            -1.2        3.29 ±  7%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     16.62 ±  2%      -1.2       15.43 ±  3%  perf-profile.calltrace.cycles-pp.tcp_close.inet_release.__sock_release.sock_close.__fput
      2.69            -1.1        1.54 ± 24%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      3.92            -1.1        2.79 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      7.87            -1.1        6.75 ± 12%  perf-profile.calltrace.cycles-pp.accept.process_requests.spawn_child.accept_connection.accept_connections
     16.30 ±  2%      -1.1       15.20 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_close.tcp_close.inet_release.__sock_release.sock_close
     18.19            -1.1       17.14 ±  3%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.99 ±  5%      -1.0        0.98 ± 23%  perf-profile.calltrace.cycles-pp.__sk_destruct.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      2.20            -0.9        1.26 ± 19%  perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     10.62            -0.9        9.69 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close.tcp_close
      1.86            -0.9        0.95 ± 38%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.11 ±  2%      -0.9        9.22 ±  3%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close
      3.26            -0.8        2.41        perf-profile.calltrace.cycles-pp.inet_accept.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64
      1.60            -0.8        0.82 ± 38%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
      2.45 ±  3%      -0.8        1.68 ±  6%  perf-profile.calltrace.cycles-pp.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.94            -0.8        2.17 ±  2%  perf-profile.calltrace.cycles-pp.inet_csk_accept.inet_accept.do_accept.__sys_accept4.__x64_sys_accept
      1.76            -0.8        1.00 ± 20%  perf-profile.calltrace.cycles-pp.schedule_timeout.inet_csk_accept.inet_accept.do_accept.__sys_accept4
      2.21 ±  4%      -0.8        1.46 ±  7%  perf-profile.calltrace.cycles-pp.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv
      2.15 ±  4%      -0.7        1.40 ±  7%  perf-profile.calltrace.cycles-pp.sk_clone_lock.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req
     12.55            -0.7       11.81 ±  2%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      1.69            -0.7        0.96 ± 20%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      1.65            -0.7        0.93 ± 20%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.inet_csk_accept.inet_accept
      1.63 ±  3%      -0.7        0.92 ± 32%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.89 ±  5%      -0.7        1.19 ±  8%  perf-profile.calltrace.cycles-pp.__sk_destruct.inet_release.__sock_release.sock_close.__fput
      8.06            -0.7        7.38 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      8.64            -0.7        7.99 ±  5%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process
      8.56            -0.6        7.92 ±  5%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process
      0.89 ± 12%      -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.apparmor_sk_free_security.security_sk_free.__sk_destruct.tcp_v4_rcv.ip_protocol_deliver_rcu
     12.18 ±  2%      -0.6       11.57 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.__tcp_close.tcp_close.inet_release.__sock_release
     12.11 ±  2%      -0.6       11.51 ±  3%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close.tcp_close.inet_release
      1.66 ± 14%      -0.6        1.08 ± 18%  perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.92 ± 11%      -0.6        0.37 ± 71%  perf-profile.calltrace.cycles-pp.security_sk_free.__sk_destruct.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      7.62            -0.6        7.07        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      1.35 ±  9%      -0.6        0.80 ± 12%  perf-profile.calltrace.cycles-pp.apparmor_sk_clone_security.security_sk_clone.sk_clone_lock.inet_csk_clone_lock.tcp_create_openreq_child
      1.35 ±  8%      -0.5        0.81 ± 12%  perf-profile.calltrace.cycles-pp.security_sk_clone.sk_clone_lock.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock
     10.53            -0.5        9.99 ±  4%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect
      1.26 ±  9%      -0.5        0.73 ± 13%  perf-profile.calltrace.cycles-pp.security_sk_free.__sk_destruct.inet_release.__sock_release.sock_close
      4.04 ±  2%      -0.5        3.50 ±  5%  perf-profile.calltrace.cycles-pp.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      1.23 ± 10%      -0.5        0.70 ± 13%  perf-profile.calltrace.cycles-pp.apparmor_sk_free_security.security_sk_free.__sk_destruct.inet_release.__sock_release
      1.47 ± 15%      -0.5        0.95 ±  7%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      3.57 ±  2%      -0.5        3.05 ±  6%  perf-profile.calltrace.cycles-pp.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.41 ± 15%      -0.5        0.91 ±  7%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      9.15            -0.5        8.65 ±  5%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      8.88            -0.5        8.41 ±  5%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
     10.76            -0.4       10.31 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      2.14            -0.4        1.70 ± 16%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
     10.70            -0.4       10.26 ±  2%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
      0.79 ±  8%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.tcp_done.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv
      1.28 ± 14%      -0.4        0.89 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      0.55            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      0.59 ±  3%      -0.2        0.35 ± 70%  perf-profile.calltrace.cycles-pp.inet_bind_conflict.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk
      1.74 ±  5%      -0.2        1.49 ±  6%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.28            -0.2        1.05 ±  4%  perf-profile.calltrace.cycles-pp.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind
      0.95 ±  2%      -0.2        0.73 ±  5%  perf-profile.calltrace.cycles-pp.sk_alloc.inet_create.__sock_create.__sys_socket.__x64_sys_socket
      1.66 ±  5%      -0.2        1.44 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.58            -0.2        1.39 ±  5%  perf-profile.calltrace.cycles-pp.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56            -0.2        1.37 ±  5%  perf-profile.calltrace.cycles-pp.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64
      0.73 ±  2%      -0.1        0.59 ±  5%  perf-profile.calltrace.cycles-pp.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind
      0.90 ±  3%      -0.1        0.77 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.49            -0.1        1.36 ±  6%  perf-profile.calltrace.cycles-pp.inet_create.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      0.74 ±  3%      -0.1        0.65 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.71 ±  3%      -0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.05            +0.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.tcp_v4_send_synack.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      0.55 ±  6%      +0.1        0.62 ±  4%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv
      0.86            +0.1        0.94 ±  4%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      0.58            +0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.50 ±  2%      +0.2        2.74 ±  7%  perf-profile.calltrace.cycles-pp.recv.recv_omni.process_requests.spawn_child.accept_connection
      2.29 ±  2%      +0.3        2.58 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests
      2.30 ±  2%      +0.3        2.59 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests.spawn_child
      2.86            +0.3        3.16 ±  4%  perf-profile.calltrace.cycles-pp.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.11 ±  2%      +0.3        2.44 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.recv_omni
     19.10            +0.4       19.48        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      2.15            +0.6        2.72 ±  5%  perf-profile.calltrace.cycles-pp.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      2.02            +0.6        2.60 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      2.01            +0.6        2.59 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner
      1.96            +0.6        2.55 ±  6%  perf-profile.calltrace.cycles-pp.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      1.97            +0.6        2.56 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket
      0.82 ±  2%      +0.7        1.50 ± 14%  perf-profile.calltrace.cycles-pp.setsockopt.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      0.65 ±  3%      +0.7        1.34 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.setsockopt.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      0.64 ±  3%      +0.7        1.33 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsockopt.omni_create_data_socket.send_omni_inner
      0.60 ±  4%      +0.7        1.30 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_setsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsockopt.omni_create_data_socket
      0.59 ±  4%      +0.7        1.30 ± 16%  perf-profile.calltrace.cycles-pp.__sys_setsockopt.__x64_sys_setsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.setsockopt
      0.54 ±  4%      +0.7        1.26 ± 17%  perf-profile.calltrace.cycles-pp.do_sock_setsockopt.__sys_setsockopt.__x64_sys_setsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.76 ± 40%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_accept.do_accept.__sys_accept4.__x64_sys_accept
      0.00            +0.8        0.77 ± 40%  perf-profile.calltrace.cycles-pp.security_socket_accept.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64
      4.41 ±  3%      +0.8        5.23 ±  8%  perf-profile.calltrace.cycles-pp.recv.send_omni_inner.send_tcp_conn_rr.main
      4.02 ±  3%      +0.9        4.87 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr.main
      4.00 ±  3%      +0.9        4.85 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr
      3.66 ±  3%      +0.9        4.56 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner
      0.00            +1.0        0.98 ± 22%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_connect.__sys_connect_file.__sys_connect.__x64_sys_connect
      0.00            +1.0        1.00 ± 22%  perf-profile.calltrace.cycles-pp.security_socket_connect.__sys_connect_file.__sys_connect.__x64_sys_connect.do_syscall_64
      0.00            +1.0        1.00 ± 22%  perf-profile.calltrace.cycles-pp.__sys_connect_file.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.01 ± 21%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_bind.__sys_bind.__x64_sys_bind.do_syscall_64
      0.00            +1.0        1.01 ± 21%  perf-profile.calltrace.cycles-pp.security_socket_bind.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.03 ± 21%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_setsockopt.do_sock_setsockopt.__sys_setsockopt.__x64_sys_setsockopt
      0.00            +1.0        1.04 ± 26%  perf-profile.calltrace.cycles-pp.apparmor_socket_create.security_socket_create.__sock_create.__sys_socket.__x64_sys_socket
      0.00            +1.0        1.04 ± 21%  perf-profile.calltrace.cycles-pp.security_socket_setsockopt.do_sock_setsockopt.__sys_setsockopt.__x64_sys_setsockopt.do_syscall_64
      0.00            +1.1        1.05 ± 26%  perf-profile.calltrace.cycles-pp.security_socket_create.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      5.72            +1.2        6.93 ±  9%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      5.34            +1.3        6.60 ±  9%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.60 ±  3%      +1.5        3.10 ± 15%  perf-profile.calltrace.cycles-pp.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      1.48 ±  3%      +1.5        2.99 ± 16%  perf-profile.calltrace.cycles-pp.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      1.40 ±  3%      +1.5        2.91 ± 16%  perf-profile.calltrace.cycles-pp.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner
      1.10 ±  5%      +1.5        2.64 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket
      1.08 ±  4%      +1.6        2.63 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket
      1.02 ±  5%      +1.6        2.58 ± 19%  perf-profile.calltrace.cycles-pp.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer
      0.99 ±  5%      +1.6        2.57 ± 19%  perf-profile.calltrace.cycles-pp.__sys_getsockopt.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt
      0.90 ±  5%      +1.6        2.49 ± 19%  perf-profile.calltrace.cycles-pp.do_sock_getsockopt.__sys_getsockopt.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.8        1.78 ± 29%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.00            +1.8        1.79 ± 29%  perf-profile.calltrace.cycles-pp.security_socket_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ±200%      +2.0        2.08 ± 24%  perf-profile.calltrace.cycles-pp.security_socket_getsockopt.do_sock_getsockopt.__sys_getsockopt.__x64_sys_getsockopt.do_syscall_64
      0.00            +2.1        2.06 ± 24%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_getsockopt.do_sock_getsockopt.__sys_getsockopt.__x64_sys_getsockopt
     70.86            +2.1       72.99        perf-profile.calltrace.cycles-pp.send_tcp_conn_rr.main
     70.78            +2.1       72.91        perf-profile.calltrace.cycles-pp.send_omni_inner.send_tcp_conn_rr.main
      0.21 ±122%      +2.6        2.77 ± 26%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.22 ±122%      +2.6        2.81 ± 26%  perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     12.41 ±  2%      +2.8       15.16 ±  8%  perf-profile.calltrace.cycles-pp.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
     25.58            -3.8       21.79 ±  3%  perf-profile.children.cycles-pp.__close
     24.82            -3.7       21.14 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
     24.19            -3.6       20.63 ±  3%  perf-profile.children.cycles-pp.__fput
     26.19            -3.4       22.82 ± 12%  perf-profile.children.cycles-pp.accept_connections
     32.84            -2.6       30.29 ±  3%  perf-profile.children.cycles-pp.ip_finish_output2
     32.35            -2.4       29.90 ±  3%  perf-profile.children.cycles-pp.__dev_queue_xmit
     32.13            -2.2       29.95 ±  3%  perf-profile.children.cycles-pp.__local_bh_enable_ip
     32.19            -2.2       30.02 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
     31.69            -2.1       29.59 ±  3%  perf-profile.children.cycles-pp.do_softirq
     26.19            -2.0       24.18 ±  2%  perf-profile.children.cycles-pp.accept_connection
     26.19            -2.0       24.18 ±  2%  perf-profile.children.cycles-pp.process_requests
     26.19            -2.0       24.18 ±  2%  perf-profile.children.cycles-pp.spawn_child
     19.04            -1.9       17.10 ±  3%  perf-profile.children.cycles-pp.__sock_release
     19.07            -1.9       17.14 ±  3%  perf-profile.children.cycles-pp.sock_close
     18.81            -1.9       16.94 ±  3%  perf-profile.children.cycles-pp.inet_release
     30.32            -1.9       28.45 ±  4%  perf-profile.children.cycles-pp.net_rx_action
     29.76            -1.8       27.98 ±  4%  perf-profile.children.cycles-pp.__napi_poll
     29.65            -1.8       27.89 ±  4%  perf-profile.children.cycles-pp.process_backlog
     36.90            -1.7       35.20 ±  3%  perf-profile.children.cycles-pp.__tcp_transmit_skb
     28.90            -1.6       27.29 ±  4%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     26.88            -1.6       25.28 ±  4%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     26.97            -1.6       25.37 ±  4%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     26.43            -1.6       24.84 ±  4%  perf-profile.children.cycles-pp.tcp_v4_rcv
      3.93 ±  4%      -1.4        2.54 ±  7%  perf-profile.children.cycles-pp.__sk_destruct
     18.26            -1.3       16.96 ±  2%  perf-profile.children.cycles-pp.recv_omni
     16.74 ±  2%      -1.2       15.55 ±  3%  perf-profile.children.cycles-pp.tcp_close
      2.72 ±  7%      -1.2        1.55 ± 12%  perf-profile.children.cycles-pp.security_file_free
      2.71 ±  7%      -1.2        1.54 ± 12%  perf-profile.children.cycles-pp.apparmor_file_free_security
     16.43 ±  2%      -1.1       15.33 ±  3%  perf-profile.children.cycles-pp.__tcp_close
      2.62 ±  9%      -1.1        1.53 ± 12%  perf-profile.children.cycles-pp.security_sk_free
      2.54 ±  9%      -1.1        1.46 ± 12%  perf-profile.children.cycles-pp.apparmor_sk_free_security
     23.08            -1.0       22.03 ±  3%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
     18.38            -1.0       17.35 ±  3%  perf-profile.children.cycles-pp.tcp_sendmsg
     22.98            -1.0       21.94 ±  3%  perf-profile.children.cycles-pp.tcp_write_xmit
      4.78            -1.0        3.76 ±  3%  perf-profile.children.cycles-pp.inet_recvmsg
      4.70            -1.0        3.68 ±  3%  perf-profile.children.cycles-pp.tcp_recvmsg
      4.70            -1.0        3.70 ±  4%  perf-profile.children.cycles-pp.__schedule
      4.07            -0.9        3.12 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      3.95            -0.9        3.04 ±  4%  perf-profile.children.cycles-pp.schedule
      4.23            -0.9        3.32 ±  3%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
      3.53            -0.9        2.62        perf-profile.children.cycles-pp.inet_accept
      3.23            -0.8        2.40 ±  2%  perf-profile.children.cycles-pp.inet_csk_accept
      2.48 ±  2%      -0.8        1.70 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      2.47 ±  3%      -0.8        1.69 ±  6%  perf-profile.children.cycles-pp.tcp_create_openreq_child
      8.38            -0.8        7.60 ±  4%  perf-profile.children.cycles-pp.accept
      2.23 ±  4%      -0.8        1.48 ±  7%  perf-profile.children.cycles-pp.inet_csk_clone_lock
      2.17 ±  4%      -0.7        1.43 ±  7%  perf-profile.children.cycles-pp.sk_clone_lock
      5.42 ±  3%      -0.7        4.68 ±  4%  perf-profile.children.cycles-pp.tcp_data_queue
     12.62            -0.7       11.90 ±  2%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      2.28            -0.7        1.60 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      4.90            -0.6        4.31        perf-profile.children.cycles-pp.tcp_rcv_established
      1.37 ±  8%      -0.6        0.81 ± 11%  perf-profile.children.cycles-pp.security_sk_clone
      1.37 ±  8%      -0.6        0.81 ± 12%  perf-profile.children.cycles-pp.apparmor_sk_clone_security
      2.50            -0.5        1.95 ±  4%  perf-profile.children.cycles-pp.sk_wait_data
      2.29            -0.5        1.74 ±  2%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      4.08            -0.5        3.54 ±  6%  perf-profile.children.cycles-pp.tcp_check_req
      2.11            -0.5        1.58 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      3.00 ±  4%      -0.5        2.48 ±  6%  perf-profile.children.cycles-pp.sock_def_readable
      3.61 ±  2%      -0.5        3.10 ±  6%  perf-profile.children.cycles-pp.tcp_v4_syn_recv_sock
      2.88 ±  5%      -0.5        2.38 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      1.90 ±  6%      -0.5        1.42 ± 10%  perf-profile.children.cycles-pp.tcp_done
      1.54 ±  2%      -0.5        1.06 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.22            -0.5        1.74 ±  4%  perf-profile.children.cycles-pp.wait_woken
      2.82 ±  5%      -0.5        2.36 ±  6%  perf-profile.children.cycles-pp.__wake_up_sync_key
      2.82            -0.4        2.40 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      1.88            -0.4        1.46        perf-profile.children.cycles-pp.dput
      2.65 ±  5%      -0.4        2.26 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      1.59 ±  7%      -0.4        1.22 ± 10%  perf-profile.children.cycles-pp.tcp_set_state
      1.35 ±  9%      -0.3        1.00 ± 13%  perf-profile.children.cycles-pp.tcp_get_metrics
      1.62            -0.3        1.27 ±  2%  perf-profile.children.cycles-pp.__dentry_kill
      1.25 ±  9%      -0.3        0.91 ± 15%  perf-profile.children.cycles-pp.__tcp_get_metrics
      1.59            -0.3        1.26 ±  2%  perf-profile.children.cycles-pp.__alloc_skb
      1.11            -0.3        0.83 ±  5%  perf-profile.children.cycles-pp.dequeue_entities
      1.06 ± 11%      -0.3        0.79 ± 15%  perf-profile.children.cycles-pp.inet_unhash
      2.16            -0.3        1.89 ±  3%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      1.15            -0.3        0.88 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.46            -0.3        1.20        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.32 ±  2%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.30            -0.2        1.07 ±  5%  perf-profile.children.cycles-pp.inet_csk_get_port
      0.88            -0.2        0.65 ±  2%  perf-profile.children.cycles-pp.__netif_rx
      0.96 ±  2%      -0.2        0.74 ±  5%  perf-profile.children.cycles-pp.sk_alloc
      1.20            -0.2        0.98 ±  2%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.78 ±  2%      -0.2        0.56 ±  2%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.84            -0.2        0.62        perf-profile.children.cycles-pp.netif_rx_internal
      1.34            -0.2        1.12 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.00            -0.2        0.79 ±  3%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.99            -0.2        0.78 ±  2%  perf-profile.children.cycles-pp.sk_reset_timer
      1.30 ±  4%      -0.2        1.10 ±  7%  perf-profile.children.cycles-pp.sock_alloc
      0.90 ±  4%      -0.2        0.70 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.92            -0.2        0.72 ±  3%  perf-profile.children.cycles-pp.skb_release_data
      1.43 ±  6%      -0.2        1.24 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      1.60            -0.2        1.40 ±  5%  perf-profile.children.cycles-pp.inet_bind_sk
      1.58            -0.2        1.39 ±  5%  perf-profile.children.cycles-pp.__inet_bind
      0.78 ±  2%      -0.2        0.59 ±  2%  perf-profile.children.cycles-pp.lock_sock_nested
      1.23 ±  4%      -0.2        1.04 ±  8%  perf-profile.children.cycles-pp.alloc_inode
      0.87            -0.2        0.68 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.74 ±  2%      -0.2        0.56 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.20            -0.2        1.02 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.71            -0.2        0.54 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.99            -0.2        0.82        perf-profile.children.cycles-pp.__mod_timer
      1.24 ±  3%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.51 ±  2%      -0.2        0.35 ±  5%  perf-profile.children.cycles-pp.dst_release
      1.00 ±  2%      -0.2        0.84 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      1.45            -0.2        1.30 ±  2%  perf-profile.children.cycles-pp.inet_csk_destroy_sock
      0.50 ±  4%      -0.1        0.35 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.82            -0.1        0.67 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.75            -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.__kfree_skb
      0.65 ±  2%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.lock_timer_base
      0.89 ±  4%      -0.1        0.75 ±  8%  perf-profile.children.cycles-pp.rcu_core
      0.74 ±  3%      -0.1        0.60 ±  5%  perf-profile.children.cycles-pp.inet_csk_bind_conflict
      1.18 ±  2%      -0.1        1.04 ±  2%  perf-profile.children.cycles-pp.enqueue_task
      0.85 ±  4%      -0.1        0.72 ±  9%  perf-profile.children.cycles-pp.rcu_do_batch
      0.37 ±  2%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.sock_def_wakeup
      0.47 ±  3%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.sk_stop_timer
      1.53            -0.1        1.41 ±  6%  perf-profile.children.cycles-pp.inet_create
      0.74            -0.1        0.62        perf-profile.children.cycles-pp.tcp_send_fin
      0.86 ±  2%      -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.66            -0.1        0.54 ±  6%  perf-profile.children.cycles-pp.inet_put_port
      0.42            -0.1        0.31 ±  5%  perf-profile.children.cycles-pp.wakeup_preempt
      0.66 ±  4%      -0.1        0.54 ±  8%  perf-profile.children.cycles-pp.sock_alloc_inode
      0.32 ±  3%      -0.1        0.21 ±  7%  perf-profile.children.cycles-pp.tcp_check_space
      0.30 ±  2%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.kfree_skbmem
      0.48            -0.1        0.37        perf-profile.children.cycles-pp.evict
      0.30 ±  2%      -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__wake_up
      0.99 ±  3%      -0.1        0.88 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.11            -0.1        1.00 ±  2%  perf-profile.children.cycles-pp.tcp_v4_destroy_sock
      0.29            -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.d_instantiate
      0.40 ±  3%      -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.inet_csk_clear_xmit_timers
      0.36 ±  2%      -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      1.07            -0.1        0.97        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.52            -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.57            -0.1        0.46        perf-profile.children.cycles-pp.__tcp_send_ack
      0.72            -0.1        0.62 ±  2%  perf-profile.children.cycles-pp.sk_prot_alloc
      0.38            -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.destroy_inode
      0.37            -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.__destroy_inode
      0.60 ±  4%      -0.1        0.51 ±  5%  perf-profile.children.cycles-pp.inet_bind_conflict
      0.45 ±  2%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.84            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.52            -0.1        0.42        perf-profile.children.cycles-pp.sched_clock_cpu
      0.59            -0.1        0.50        perf-profile.children.cycles-pp.irqtime_account_irq
      0.46            -0.1        0.37 ±  2%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.26 ±  3%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.sk_free
      0.52            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.34            -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.34 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__skb_clone
      0.25 ±  3%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.sock_put
      0.50            -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.45            -0.1        0.37        perf-profile.children.cycles-pp.sched_clock
      0.61            -0.1        0.53        perf-profile.children.cycles-pp.validate_xmit_skb
      0.35            -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.skb_release_head_state
      0.35 ±  5%      -0.1        0.26 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.54            -0.1        0.46        perf-profile.children.cycles-pp.inet_csk_reqsk_queue_hash_add
      0.52            -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.d_alloc_pseudo
      0.14 ±  5%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.woken_wake_function
      0.18            -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.__d_instantiate
      0.39            -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.43 ±  2%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.39            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.51            -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.39            -0.1        0.32 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.27            -0.1        0.19 ±  7%  perf-profile.children.cycles-pp.tcp_wfree
      0.63 ±  2%      -0.1        0.56        perf-profile.children.cycles-pp.mod_objcg_state
      0.39            -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.pick_task_fair
      0.32            -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.timer_delete
      0.57            -0.1        0.50 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.70 ±  2%      -0.1        0.63        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.26 ±  2%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.sk_setsockopt
      0.35 ±  2%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.netif_skb_features
      0.28            -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.50            -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.__d_alloc
      0.40 ±  2%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.fdget
      0.33            -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.62 ±  4%      -0.1        0.55 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.43            -0.1        0.36        perf-profile.children.cycles-pp.inet_ehash_insert
      0.47 ±  2%      -0.1        0.40        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.40            -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.44 ±  2%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.__inet_bhash2_update_saddr
      0.57            -0.1        0.50 ±  3%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.29            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.39            -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.56 ±  3%      -0.1        0.50 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53            -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.ip_rcv_core
      0.17 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.19 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.24            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__call_rcu_common
      0.11 ±  3%      -0.1        0.05        perf-profile.children.cycles-pp.update_curr_dl_se
      0.38 ±  3%      -0.1        0.33        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16 ±  4%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.sock_i_uid
      0.26 ±  2%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.tcp_current_mss
      0.26 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.__switch_to
      0.59 ±  3%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.26            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_options_write
      0.55            -0.1        0.50        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.15 ±  2%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.30            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.41            -0.0        0.37 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.23 ±  3%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.35            -0.0        0.30 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.13 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.consume_skb
      0.21 ±  4%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.30            -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.tcp_send_mss
      0.14 ±  2%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.26            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.pick_eevdf
      0.24            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.19 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.sk_setup_caps
      0.34 ±  2%      -0.0        0.29 ±  5%  perf-profile.children.cycles-pp.__inet_check_established
      0.30 ±  2%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.memset_orig
      0.13            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.enqueue_timer
      0.29 ±  2%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.25 ±  2%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.29 ±  2%      -0.0        0.25 ±  7%  perf-profile.children.cycles-pp.security_inode_alloc
      0.25            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.kmem_cache_charge
      0.14 ±  2%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__inet_accept
      0.17 ±  4%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.move_addr_to_user
      0.32 ±  2%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__ip_finish_output
      0.28            -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      0.18 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.secure_tcp_seq
      0.13 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.ip_finish_output
      0.22            -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.17            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.iput
      0.21            -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.alloc_fd
      0.23            -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.inet_csk_complete_hashdance
      0.25 ±  3%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.13 ±  3%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.sock_rfree
      0.28            -0.0        0.24 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.40            -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.ip_local_out
      0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rb_first
      0.29 ±  3%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.__inet_inherit_port
      0.11 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.down_write
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_write_lock_bh
      0.11 ±  4%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.remove_wait_queue
      0.09 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp._raw_read_lock_bh
      0.13 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__sock_wfree
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.skb_network_protocol
      0.24 ±  2%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__dequeue_entity
      0.16 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.__virt_addr_valid
      0.16 ±  2%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.14 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.file_close_fd
      0.21            -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.security_sk_alloc
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.18            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.12            -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.vruntime_eligible
      0.39 ±  2%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__ip_local_out
      0.24            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.13 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.add_wait_queue
      0.24            -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.sk_stream_kill_queues
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.security_sock_graft
      0.37 ±  2%      -0.0        0.34 ±  5%  perf-profile.children.cycles-pp.__inet_hash_connect
      0.16            -0.0        0.13        perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.21 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp._copy_to_user
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.20            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.17            -0.0        0.14 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.17            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.lsm_blob_alloc
      0.17 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.inet_ehash_nolisten
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tcp_urg
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.33 ±  3%      -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.sk_getsockopt
      0.09 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.inet_sk_rx_dst_set
      0.08            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.tcp_rate_gen
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.skb_clone
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__enqueue_entity
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.14 ±  6%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.kfree
      0.22            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.tcp_init_xmit_timers
      0.17            -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.13            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.inet_bind_bucket_create
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.18            -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.get_random_u32
      0.41            -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.tcp_make_synack
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.23 ±  2%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.tcp_inbound_hash
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tcp_established_options
      0.35            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__sk_mem_schedule
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.sock_copy
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.inet_csk_update_fastreuse
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.up_write
      0.11            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.inet_getname
      0.11            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.08            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.13 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.12            -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xa_load
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.inet_reqsk_alloc
      0.12 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.inet_bind2_bucket_create
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__memcpy
      0.14 ±  2%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.11 ±  3%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.lockref_put_return
      0.11            -0.0        0.09        perf-profile.children.cycles-pp.update_curr_se
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.truncate_inode_pages_final
      0.09            -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.33            -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__timer_delete_sync
      0.12 ±  4%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__get_user_8
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.recv_data
      0.13 ±  5%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.17 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.11 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.eth_type_trans
      0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.tcp_newly_delivered
      0.14            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.nf_hook_slow
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.calc_wheel_index
      0.11 ±  3%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__ip_dev_find
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.get_random_u16
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__try_to_del_timer_sync
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.skb_push
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_rate_skb_delivered
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_chrono_stop
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.fd_install
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.tcp_try_coalesce
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.bpf_skops_hdr_opt_len
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp._get_random_bytes
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__calc_delta
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.minmax_running_min
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.siphash_1u64
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.siphash_3u32
      0.14            -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__inet_csk_reqsk_queue_drop
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.check_stack_object
      0.11            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.raw_v4_input
      0.08            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rb_erase
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.chacha_block_generic
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.chacha_permute
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.crng_fast_key_erasure
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.skb_rbtree_purge
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.raw_local_deliver
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.select_idle_cpu
      0.09 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__sk_free
      0.09            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.tcp_rate_skb_sent
      0.06 ±  7%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.security_file_release
      0.12 ± 10%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.perf_mmap__push
      0.14 ± 11%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.cmd_record
      0.14 ±  9%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.handle_internal_command
      0.14 ±  9%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.run_builtin
      0.09 ± 11%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.record__pushfn
      0.09 ± 14%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.writen
      0.13 ± 12%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.14            +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__inet_lookup_listener
      0.08            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.inet_lhash2_lookup
      0.14 ±  4%      +0.0        0.19 ± 12%  perf-profile.children.cycles-pp.ipv4_default_advmss
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_rbtree_insert
      0.12 ±  3%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.secure_tcp_ts_off
      0.07 ±  5%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.tcp_ca_openreq_child
      0.13            +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.tcp_openreq_init_rwin
      0.29            +0.1        0.40 ±  8%  perf-profile.children.cycles-pp.tcp_connect_init
      0.13 ±  5%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.tcp_skb_entail
      0.10 ±  4%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.tcp_mtup_init
      0.17 ±  4%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.__tcp_select_window
      0.11 ±  3%      +0.1        0.23 ± 12%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.23            +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.tcp_parse_options
      0.36            +0.1        0.50 ±  8%  perf-profile.children.cycles-pp.inet_csk_route_req
      0.32 ±  3%      +0.1        0.47 ±  9%  perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.28            +0.2        0.44 ±  9%  perf-profile.children.cycles-pp.tcp_v4_init_sock
      0.27            +0.2        0.43 ± 10%  perf-profile.children.cycles-pp.tcp_init_sock
      0.09 ±  5%      +0.2        0.26 ± 13%  perf-profile.children.cycles-pp.tcp_select_initial_window
      0.32 ±  2%      +0.2        0.49 ±  8%  perf-profile.children.cycles-pp.inet_csk_route_child_sock
      0.11            +0.2        0.33 ± 14%  perf-profile.children.cycles-pp.tcp_assign_congestion_control
      0.11 ±  6%      +0.3        0.37 ± 11%  perf-profile.children.cycles-pp.tcp_rack_update_reo_wnd
      2.90            +0.3        3.20 ±  4%  perf-profile.children.cycles-pp.tcp_conn_request
      3.73            +0.3        4.05 ±  4%  perf-profile.children.cycles-pp.tcp_ack
      0.47            +0.3        0.81 ±  7%  perf-profile.children.cycles-pp.ip_output
     19.29            +0.4       19.68        perf-profile.children.cycles-pp.__sys_sendto
      0.16 ±  2%      +0.5        0.64 ± 14%  perf-profile.children.cycles-pp.inet_sk_rebuild_header
      0.14 ±  2%      +0.5        0.64 ± 15%  perf-profile.children.cycles-pp.tcp_tso_segs
      0.87            +0.5        1.38 ±  9%  perf-profile.children.cycles-pp.ip_route_output_flow
      2.23            +0.6        2.81 ±  4%  perf-profile.children.cycles-pp.bind
      0.16 ±  2%      +0.6        0.74 ± 14%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      1.98            +0.6        2.58 ±  5%  perf-profile.children.cycles-pp.__sys_bind
      1.98            +0.6        2.58 ±  5%  perf-profile.children.cycles-pp.__x64_sys_bind
      0.41            +0.6        1.03 ± 14%  perf-profile.children.cycles-pp.__mkroute_output
      0.86 ±  2%      +0.7        1.54 ± 13%  perf-profile.children.cycles-pp.setsockopt
      0.61 ±  3%      +0.7        1.32 ± 16%  perf-profile.children.cycles-pp.__x64_sys_setsockopt
      0.60 ±  3%      +0.7        1.31 ± 16%  perf-profile.children.cycles-pp.__sys_setsockopt
      0.55 ±  4%      +0.7        1.28 ± 16%  perf-profile.children.cycles-pp.do_sock_setsockopt
     94.46            +0.7       95.20        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24 ± 13%      +0.7        0.99 ± 28%  perf-profile.children.cycles-pp.security_socket_accept
      0.24 ± 12%      +0.8        1.01 ± 22%  perf-profile.children.cycles-pp.__sys_connect_file
      0.23 ± 12%      +0.8        1.00 ± 22%  perf-profile.children.cycles-pp.security_socket_connect
      0.28 ±  8%      +0.8        1.06 ± 25%  perf-profile.children.cycles-pp.security_socket_create
      0.26 ±  9%      +0.8        1.05 ± 26%  perf-profile.children.cycles-pp.apparmor_socket_create
     94.05            +0.8       94.84        perf-profile.children.cycles-pp.do_syscall_64
      0.25 ± 11%      +0.8        1.05 ± 21%  perf-profile.children.cycles-pp.security_socket_setsockopt
      0.21 ± 14%      +0.8        1.02 ± 21%  perf-profile.children.cycles-pp.security_socket_bind
      7.60            +1.0        8.59 ±  7%  perf-profile.children.cycles-pp.recv
      6.03            +1.2        7.21 ±  8%  perf-profile.children.cycles-pp.__sys_recvfrom
      6.07            +1.2        7.28 ±  8%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      5.64            +1.2        6.88 ±  9%  perf-profile.children.cycles-pp.sock_recvmsg
      1.64 ±  3%      +1.5        3.14 ± 14%  perf-profile.children.cycles-pp.create_data_socket
      0.52 ± 11%      +1.5        2.03 ± 24%  perf-profile.children.cycles-pp.security_socket_sendmsg
      1.50 ±  3%      +1.5        3.02 ± 15%  perf-profile.children.cycles-pp.set_sock_buffer
      1.46 ±  3%      +1.5        2.99 ± 15%  perf-profile.children.cycles-pp.getsockopt
      1.04 ±  5%      +1.6        2.61 ± 18%  perf-profile.children.cycles-pp.__x64_sys_getsockopt
      1.01 ±  5%      +1.6        2.60 ± 18%  perf-profile.children.cycles-pp.__sys_getsockopt
      0.91 ±  5%      +1.6        2.52 ± 19%  perf-profile.children.cycles-pp.do_sock_getsockopt
      0.46 ± 11%      +1.7        2.11 ± 23%  perf-profile.children.cycles-pp.security_socket_getsockopt
      0.55 ±  3%      +1.8        2.36 ± 14%  perf-profile.children.cycles-pp.__sk_dst_check
     71.37            +2.0       73.40        perf-profile.children.cycles-pp.send_tcp_conn_rr
      0.50 ±  4%      +2.2        2.69 ± 14%  perf-profile.children.cycles-pp.ipv4_dst_check
     71.43            +2.2       73.66        perf-profile.children.cycles-pp.send_omni_inner
      0.79 ± 11%      +2.3        3.05 ± 24%  perf-profile.children.cycles-pp.security_socket_recvmsg
     12.53            +2.8       15.31 ±  7%  perf-profile.children.cycles-pp.omni_create_data_socket
      2.55 ± 12%      +8.6       11.13 ± 24%  perf-profile.children.cycles-pp.aa_sk_perm
      2.69 ±  7%      -1.2        1.53 ± 12%  perf-profile.self.cycles-pp.apparmor_file_free_security
      2.52 ±  9%      -1.1        1.45 ± 12%  perf-profile.self.cycles-pp.apparmor_sk_free_security
      2.42 ±  3%      -0.8        1.64 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      1.89 ±  2%      -0.6        1.30 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      1.36 ±  8%      -0.6        0.81 ± 12%  perf-profile.self.cycles-pp.apparmor_sk_clone_security
      1.48 ±  3%      -0.5        1.02 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.24 ± 10%      -0.3        0.90 ± 15%  perf-profile.self.cycles-pp.__tcp_get_metrics
      1.48            -0.3        1.20        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.80 ±  6%      -0.3        0.54 ±  8%  perf-profile.self.cycles-pp.__sk_destruct
      1.31            -0.2        1.08 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      1.19            -0.2        0.97 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.73 ±  3%      -0.2        0.55 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.51 ±  4%      -0.2        0.34 ±  6%  perf-profile.self.cycles-pp.__tcp_close
      0.78            -0.2        0.62 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.48 ±  2%      -0.2        0.32 ±  5%  perf-profile.self.cycles-pp.dst_release
      0.43 ±  5%      -0.1        0.29 ±  8%  perf-profile.self.cycles-pp.sk_alloc
      0.48 ±  4%      -0.1        0.34 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.52            -0.1        0.39 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.60 ±  2%      -0.1        0.46 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.41 ±  5%      -0.1        0.28 ±  8%  perf-profile.self.cycles-pp.sk_clone_lock
      0.63            -0.1        0.51 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.78            -0.1        0.67 ±  4%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.41            -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.skb_release_data
      0.31 ±  3%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.tcp_check_space
      0.29 ±  3%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp.kfree_skbmem
      0.47 ±  4%      -0.1        0.37 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.60 ±  3%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp.inet_bind_conflict
      0.25 ±  5%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.sk_free
      0.37            -0.1        0.29        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.52 ±  2%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp.net_rx_action
      0.24 ±  3%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.sock_put
      0.46            -0.1        0.37 ±  3%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.14 ±  5%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.woken_wake_function
      0.32            -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.34 ±  5%      -0.1        0.26 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.37            -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.handle_softirqs
      0.49            -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.39            -0.1        0.31        perf-profile.self.cycles-pp.fdget
      0.91            -0.1        0.84 ±  2%  perf-profile.self.cycles-pp.tcp_ack
      0.26            -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.tcp_wfree
      0.22 ±  2%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.__skb_clone
      0.42            -0.1        0.36        perf-profile.self.cycles-pp.loopback_xmit
      0.15 ±  3%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.dequeue_entities
      0.26 ±  3%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.prepare_task_switch
      0.51            -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.48            -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.48            -0.1        0.42 ±  2%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.32 ±  5%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.38            -0.1        0.32        perf-profile.self.cycles-pp.native_sched_clock
      0.36 ±  2%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.18 ±  2%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.wait_woken
      0.51            -0.1        0.46 ±  3%  perf-profile.self.cycles-pp.ip_rcv_core
      0.17 ±  2%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.15 ±  6%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.sk_stop_timer
      0.35            -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.32            -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.sk_reset_timer
      0.41 ±  2%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.25 ±  4%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.37 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.26 ±  4%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.inet_create
      0.41 ±  2%      -0.0        0.36 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.13 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.29            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.18 ±  2%      -0.0        0.13        perf-profile.self.cycles-pp.inet_csk_accept
      0.25            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.11 ±  4%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.25 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__fput
      0.39 ±  3%      -0.0        0.34 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.08 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.sk_setsockopt
      0.17 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_options_write
      0.25            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.tcp_validate_incoming
      0.14 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sock_def_readable
      0.29 ±  2%      -0.0        0.25 ±  5%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.20 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.26            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__raise_softirq_irqoff
      0.29 ±  2%      -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.memset_orig
      0.11 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_current_mss
      0.18 ±  2%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.sk_setup_caps
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_send_fin
      0.20            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      0.21            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.34            -0.0        0.30 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.19 ±  2%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  6%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.inet_csk_reqsk_queue_hash_add
      0.26 ±  2%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.12            -0.0        0.08        perf-profile.self.cycles-pp.enqueue_timer
      0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.20 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.recv_omni
      0.12 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__sock_wfree
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_add_backlog
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.ip_finish_output
      0.12 ±  3%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.sock_rfree
      0.19 ±  2%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.netif_skb_features
      0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.switch_fpu_return
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.get_random_u16
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.security_inode_alloc
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_write_lock_bh
      0.09 ±  9%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp._raw_read_lock_bh
      0.09 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.down_write
      0.13 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.23 ±  2%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.25 ±  2%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.17            -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.30 ±  2%      -0.0        0.27 ±  3%  perf-profile.self.cycles-pp.__mod_timer
      0.23 ±  3%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.20 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.23 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.23 ±  2%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.release_sock
      0.15 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.skb_network_protocol
      0.08 ±  4%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.init_file
      0.13 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.lock_sock_nested
      0.17            -0.0        0.14 ±  4%  perf-profile.self.cycles-pp._copy_to_iter
      0.11            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.vruntime_eligible
      0.09            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rb_first
      0.12            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.schedule_timeout
      0.23            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.09 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.inet_sk_rx_dst_set
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__call_rcu_common
      0.19 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.ip_rcv
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_queue_rcv
      0.20 ±  3%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp._copy_to_user
      0.15            -0.0        0.12        perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.31 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.14 ±  3%      -0.0        0.11 ±  8%  perf-profile.self.cycles-pp.skb_release_head_state
      0.24 ±  4%      -0.0        0.21 ±  6%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.23            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ±  5%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__ip_finish_output
      0.08 ±  5%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.09 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.18 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__dequeue_entity
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru_noprof
      0.23            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.08            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.08            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_close
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.13 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.dequeue_entity
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.evict
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_established_options
      0.13 ±  7%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.kfree
      0.07            -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.skb_push
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.tcp_rate_gen
      0.13 ±  3%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__enqueue_entity
      0.16 ±  4%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.lock_timer_base
      0.19 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
      0.11            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__memcpy
      0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.cpuacct_charge
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__get_user_8
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.11 ±  3%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.pick_task_fair
      0.25            -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.send_omni_inner
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.12 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
      0.17 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
      0.13            -0.0        0.11        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.get_random_u32
      0.12            -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.tcp_urg
      0.10            -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.truncate_inode_pages_final
      0.09            -0.0        0.07        perf-profile.self.cycles-pp.update_curr_se
      0.14 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__hrtimer_init
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_accept
      0.11 ±  7%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.eth_type_trans
      0.28            -0.0        0.26        perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sock_def_wakeup
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__ip_append_data
      0.07            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.siphash_1u64
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__calc_delta
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.inet_accept
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.rb_erase
      0.20 ±  2%      -0.0        0.18        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.09 ±  8%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.tcp_newly_delivered
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.alloc_fd
      0.30            -0.0        0.28        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.11            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.12 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.recv_data
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.sk_wait_data
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.tcp_chrono_stop
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.minmax_running_min
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__sk_dst_check
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.sched_clock_cpu
      0.09 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.tcp_check_req
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.13            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.avg_vruntime
      0.07            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.siphash_3u32
      0.07            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.tcp_v4_send_check
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__napi_poll
      0.29            -0.0        0.27        perf-profile.self.cycles-pp.tcp_rcv_state_process
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__copy_skb_header
      0.10 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.inet_csk_destroy_sock
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.tcp_sendmsg
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.nf_hook_slow
      0.07 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__wake_up_common
      0.11 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.sk_forced_mem_schedule
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_bh
      0.14            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.recv
      0.11            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_create_openreq_child
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.tcp_v4_connect
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.timer_delete
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_sk_alloc
      0.10 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.__close
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.fd_install
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_rate_skb_delivered
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.__put_user_8
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.chacha_permute
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__x64_sys_sendto
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xa_destroy
      0.09            +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__inet_bhash2_update_saddr
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.raw_local_deliver
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__inet_inherit_port
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.tcp_rate_skb_sent
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.inet_unhash
      0.11 ±  4%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.11 ±  3%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.tcp_connect_init
      0.06 ±  6%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.tcp_fin
      0.07            +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.tcp_syn_options
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.inet_lhash2_lookup
      0.13 ±  3%      +0.0        0.18 ± 11%  perf-profile.self.cycles-pp.ipv4_default_advmss
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__sk_free
      0.07            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.tcp_init_sock
      0.13            +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.tcp_init_transfer
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.85            +0.1        0.91        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.13 ±  3%      +0.1        0.20 ±  9%  perf-profile.self.cycles-pp.__inet_bind
      0.14 ±  2%      +0.1        0.23 ±  7%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.05 ±  7%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.secure_tcp_ts_off
      0.07 ±  5%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.tcp_v4_send_synack
      0.08            +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.tcp_v4_syn_recv_sock
      0.22 ±  2%      +0.1        0.34 ±  9%  perf-profile.self.cycles-pp.tcp_conn_request
      0.16 ±  3%      +0.1        0.28 ±  7%  perf-profile.self.cycles-pp.__tcp_select_window
      0.10 ±  6%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.tcp_skb_entail
      0.11 ±  4%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.09            +0.1        0.22 ± 10%  perf-profile.self.cycles-pp.tcp_mtup_init
      0.23 ±  2%      +0.1        0.35 ±  9%  perf-profile.self.cycles-pp.tcp_parse_options
      0.44            +0.2        0.60 ±  6%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.09            +0.2        0.26 ± 12%  perf-profile.self.cycles-pp.tcp_select_initial_window
      0.10 ±  3%      +0.2        0.32 ± 15%  perf-profile.self.cycles-pp.tcp_assign_congestion_control
      0.11 ±  3%      +0.3        0.36 ± 12%  perf-profile.self.cycles-pp.tcp_rack_update_reo_wnd
      0.34            +0.4        0.69 ±  8%  perf-profile.self.cycles-pp.ip_output
      0.14 ±  3%      +0.5        0.63 ± 14%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.16 ±  2%      +0.6        0.72 ± 14%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.37 ±  3%      +0.6        1.00 ± 14%  perf-profile.self.cycles-pp.__mkroute_output
      0.25 ± 10%      +0.8        1.03 ± 26%  perf-profile.self.cycles-pp.apparmor_socket_create
      0.49 ±  4%      +2.2        2.67 ± 14%  perf-profile.self.cycles-pp.ipv4_dst_check
      2.46 ± 12%      +8.5       11.00 ± 24%  perf-profile.self.cycles-pp.aa_sk_perm




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

