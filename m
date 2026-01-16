Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43630DED5;
	Fri, 16 Jan 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537518; cv=fail; b=ozBi4jttPBMp9w3KiYiCYjo/D7I2rphiCgAkJXbsR1xdmpukeHYTMzp7q5kTTuKbvvmU3G1TMOThZlwSWzPLX+3pVexES2q0jFrtwxWmbuHIY3FZEncfSWu4WAAadfkwy0DyeKeyVr8lC13NrM0m5OL3LnszrcPzBoiIne4FlrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537518; c=relaxed/simple;
	bh=AhvF1DHVYuLs/Cgm03DjxXA4YSrd1W4Ndtv3pC4pUNY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tsGkTmtyezogBoeeGe9/E8oBYVx6h1zf/038yORxs8/c+YX0qWjsSvwSiymmh6TE64P8XxRHS2x6WS6D/ysZV52boydvA/X6T7PXHI3mzZ8Q8dN70MEO1LrvPXKKisA85+C65ilEMyJgX9vJiunTogXV6tpTjSUZ2VsDMzHDrcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lt0bgsfF; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lt0bgsfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMnj0nMDKcgLYcFnc5s0EZ3FLXDM0e3T+cRROWOEE6UQkRQpHMEQucvjtqbsYEJ06VkoJ0zsAojoXSjA4ezcpehUF5Tkx2QNcq1n316sj7pVb/ZgdIKYysJ5HFMFV3e+EIbne7NAIjjDzgni2W/76LKyoGPn8spvZJw+EEwbzgkISm6AbsxD8aRilvc+p0/Z9wfbBca23cyPCsvGp/S/oW9jkYOPvX3Cqq8WaazPgZ66F9iPnOUAvacQx+6DztyPwMFZvbU7r1hXcHzHrnWtuqIamj4owh59D1maQOeg3gVBM7S8sqxo2QjkeMG+FBqyg4raCkNDP5Ai8kyg2GD/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDHh+hVLImWYkrAKmpHfL+3rBF17UIV4D3P1RxzrJlE=;
 b=wWyZZX2YlvD5z87Zkm2jqwl/wa0aeOb7Bx30IEq2Nqda8BS6k4HBfUORSUYF6ZQBAtSVCNaKGuFQFH16ZOAtXcAFqTFCSktq8gcFI9T+43peFIiuBosbUIH8YhgQZ/7GWWxizLs/SYZOE2INIcrSOk/S7sCoeJzy1GaYf8oKNSRgfBSgdyTl6j6L3hlxcyT4M0qbf+5luvhLXB7GkKQ5EF++MIZCBXctBXXpOmP7omygjR8xSnMGRy7fJlb4uHgHbDevlWbmrAW18Mau+ElaxiZknhv4Xp91e5cTIkkY0h0xQUGSML1EsqOlw6q8AhRe32Ol3ZGZy5/UFPnq7fiHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDHh+hVLImWYkrAKmpHfL+3rBF17UIV4D3P1RxzrJlE=;
 b=Lt0bgsfFSYitRgTBmUguvlLfS4njM1lFAn5c167cuiwE+rAqIIouuovVvCRgomNVU7tTeUziUy0PlxnHRG16tVMP6QF9fxs7sjXzksNMpJHCoc/9kp6fOhhCgVCrASarj+eyxfkzcLRl7nlagpcxWVCTheeqzo/reu2OIDfAigCGyd2sg0mQbMfyMIbuXxyMYvja82Suhzu2ZHvT9Q2uNZ0Fjy4tW7RhtZDYGS9OAIMIK3/PF36DRvc4vrA1cujen5qu4H3JddInRgfPhvN1Zhzn33BIXZnuV3vG2jx88aQ8Zmj7EJYR7O2K4UgC72cgMezQy7EdPfmvi9555FgAoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 04:25:13 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 04:25:12 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v5 0/6] Unload linux/kernel.h
Date: Thu, 15 Jan 2026 23:25:03 -0500
Message-ID: <20260116042510.241009-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:408:111::9) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6525f6ac-2a89-4a50-cef2-08de54b73dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lK64WGyF8kjIOBIzmpMQta1kBoXFe1ofU/uZe3wsr9vgXJXiHhK0+c6MH8WT?=
 =?us-ascii?Q?KOmP8jsRVClvPEIiVVpzt2gu3FwMJK6q21wv/nkOzgGnTAfMD9R7NYjCbXYp?=
 =?us-ascii?Q?dIduzXj/JOQCOgti8Z8/eidifDOfQTrsZvzCgvWHOR8gkMehr00mgAODu/On?=
 =?us-ascii?Q?3REW+O9LgWDWZdcq9ExkcdqAhL1mzC1ZLcLQd2WBCLUu66tnBWlsGZQIKyd2?=
 =?us-ascii?Q?pdVHK/6k2IQrPNTji+cyjqLahIJ84Iq8y56XjSv5NKAL8LI6RQaiNwOsTv8a?=
 =?us-ascii?Q?CL7L8swuMc1Hk8G/CxwbbjsgOqPBDIbo2K+AruICgDwpXnlBbi7JFRIF4w8k?=
 =?us-ascii?Q?RYBgIP7Sjh+7Un2wk/+6Vgy99S8jM+7AWONOa/WY7cgOsf4fBDfHP3jfUdnF?=
 =?us-ascii?Q?uAtVsWlro/LsrpVklgH1C6tfIbygl4MclOIt3+zN968iZxOX4VHJAIzQky7O?=
 =?us-ascii?Q?URxXofGKAYNau6m/agxyttrRKRKegOx29ocxnc+Dkg8HZ8d1YhZNTDzAFLUp?=
 =?us-ascii?Q?v2FV7kMIzDtxhIbR+75iaOrTSjfL4HLfDjgfviP1ruz6ed4//j2rrkitu3Uf?=
 =?us-ascii?Q?uN4Z/sRMNuSSlOvwDVCkiWCa8E0YW/zDcL4efToNlxkTp++8qHjBKFP/CMs2?=
 =?us-ascii?Q?lyJ5ccSlsqWyEaspAMsSNddDcAN4JRT5GqZl+jmBK0bVn1OG3T+ZlhkJ8Nqk?=
 =?us-ascii?Q?fvN1uFC8/JR7GuxRq7PM+dAKol8uxLrKk1qJj3je5ReqEBPWUm4OPa/gLPzp?=
 =?us-ascii?Q?LBJcmVugmrNXW9DD0vDtwnNJ1G1YTQFdagopF0Cl0kveJg/H62ep2y/0YcJV?=
 =?us-ascii?Q?FGWZlr7g9jL4mYsI/i+u81qfPiC8J5jcsdIRsC2OoCgNkCo3k+55+GjN6X87?=
 =?us-ascii?Q?SKRxM4bJpn4XMsCu+pvmBdw0lIgjMhrA7zfoxqBkfsS9jwjMYZ2Mdm6WWw+L?=
 =?us-ascii?Q?yn6EemnYs5lY3jYaTlYIt51+RHR4+cfPYYVK/xhHAbkW+T6mQJfoKxSiG2cA?=
 =?us-ascii?Q?zj4yWB6T5hJ4KWSkI1m23UHRSpZQmYHiXt1fV65vvCVaI1n3YImrlRot0cb1?=
 =?us-ascii?Q?vnRQ1kiFLMWNrhuUigstMGEJh2qPi8Iso3PEYpSns/ethduufBK8x02eu17y?=
 =?us-ascii?Q?Kt7j9LrGiTxroCkhGYEA8fZkOhXKPY1+fXR4+p5jTanAlE0H8VC8xXx/h4dI?=
 =?us-ascii?Q?aBVU6BF7Cr6W6bxMG3YbXkb9NJWEjA9ZVP78M7lJUgUMpgVXsNzGmRuvVEJH?=
 =?us-ascii?Q?hzxCnQ1FvFZe4G1br+PDix6XmLjM5O8Vak3fSrrvkgy/9k2IgNt/iVehulrm?=
 =?us-ascii?Q?yqG2aCbLnVPTafOiFB3QUQ9KwZgeMFAsn8JgPgPcbXzE1yhM6QEfzXiTr60D?=
 =?us-ascii?Q?B26ye0Jx1udXwudnV2sh7fHd4cgz26GsZhTjaKr4NtYnpes1vMUWAczal8F/?=
 =?us-ascii?Q?tO3+u9wrph7XfHOBxV1xD+oLHebso3d15/qjLRLmXsZc2TXhp+B5IPNDQ1o9?=
 =?us-ascii?Q?6NZRzIm82Lq/jp5cXBVqineNapQ9uR7F+Jrg2G1KTTxfXYTmm3yiELz5r7VF?=
 =?us-ascii?Q?YxC/abmGIXDqx/iNPf5Zf0jN8sVdEkiK/bgWnsXGseaoxNZ7A1rCf3VZW6vH?=
 =?us-ascii?Q?Iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GNBnQNWqTxTLxtZenyAO/UyKgD4ptSI0g1JzxnRJmzey8Knn2O8QdTDTBDym?=
 =?us-ascii?Q?cfImUSP8LJH6qiZSz1mbRgK4oTxoO4plAc4GMfzkDcihG8eryid1QqFnoxnL?=
 =?us-ascii?Q?TPYZFVnWbciAbpeLlRE8FolD9bkcUxfbyzS3wTofUfPpf5xxoLP/LyVxjB1c?=
 =?us-ascii?Q?0ZAr4+yGf5jzej+4NWv2ZxeU51WcLg4nh9v8hefwGaTVZUSBV0l3Mp6aiwo0?=
 =?us-ascii?Q?gm1BlvymFSoVdZMtN+QcmP52YVpgpBDQ1iQvOrzhCtwmAtNoLuDRQkfrXsEV?=
 =?us-ascii?Q?Yk00LMDS3ofUaIAq6AS0WjD1Fi1bzWcgJBII9Z6zFNH1+xhtlXkrAyqC9A8B?=
 =?us-ascii?Q?LaNcXYmLICCxXFRtn4Ry6ZYiDto93Lw2f7kCLhkeHwQY/1HcX33X8ghQZmya?=
 =?us-ascii?Q?UuaS4Ee7u1D+u4Wb9sg8DoKfpQ1p4zu+FlyUWMSLJpBYZkkXP51SPaOQq/5R?=
 =?us-ascii?Q?mwcPqUYLAc6FYaej30Oh9R80taG063qs2WZiLMHd3A58MTGscRVISfELsO51?=
 =?us-ascii?Q?I2gjD1TTHWpzKmljDnpsbHtfYZiGm/MAAfv/T0DuCWT4Ply/Ulb4ZTVfkbJ5?=
 =?us-ascii?Q?HDMBpBQ72Qe1FVWRxtnYLNatXQYymCUYmcV5+GPG1A+2JorkDNpGdu6X1MPh?=
 =?us-ascii?Q?dPTGlOYoB4pc7Du5UJ5cvvidUdvuW1wHtirQH8gQGjf1LhOq6wuknEOcS/9H?=
 =?us-ascii?Q?nIV7wuGAqa+xuOs7qXuedfqMj8mRoO85X3B69XqIawsVNOpVxkVYy015Faca?=
 =?us-ascii?Q?A/irlwxEHEXaE554YDnM7U8bi8odB0Ib+keScoK+twZwqtZq/g0FsY6om2q9?=
 =?us-ascii?Q?MznbTQQzhUOa/v/2i4EjtlRey2JWYXNxStvU2IVymriVV04mS6pI1R7YjRku?=
 =?us-ascii?Q?CPXNYhskaFEDtAv5zWIAFxLaWGGeCrhZnmGzpv7LM1fIw4U5CJAN17AORaDj?=
 =?us-ascii?Q?ImWi44JYMNI7BG3b+xz3rt9RuhGKdx5mHONQvOnWM4w+IsTYddLVx4FqrYFC?=
 =?us-ascii?Q?ZE/87WEZpDJFkyC3a0bZy9HO/BALJsjzCpJzvanKeWRd2XEs+6VD7BKAcUml?=
 =?us-ascii?Q?bh1c34xvSfOwdwyvsa0IRSf6Z9hnoTj3aAP1AOflFNPVg+p28B34kIGTWu8d?=
 =?us-ascii?Q?dthTsV3rSAan94NDtdXY4ytF4s6VKl3C9oj00Tk84S2X2AE7bNH4U9MQ0TSa?=
 =?us-ascii?Q?gAFA7o++rCiwgDQYBNbr1CZ7m2OYUivgr4AZVheFV8deK7hEJkZ/0fRqQtjG?=
 =?us-ascii?Q?mJYMGrSoNAzwQ7armll3ZSu6JKQw9rrgO+u8YWXluL7XDEtQonWzqkm/vZZ4?=
 =?us-ascii?Q?+nCuhkdv8KbFMDt7/1gUKHmdO5+akR/3p7QtMilZpg7ZSQSXCr4RW9jOhITn?=
 =?us-ascii?Q?SUOmFiOyt/tTNEHDA1olVo4QbLceZSVt+Lqd3kmmtP0baKT7LImXGxUGse+v?=
 =?us-ascii?Q?ZPZVcZmZ5hJFVDLnN4LulN218/V1NwYjfdFHc3uzLIynwQoSHjMw5QYAnAMR?=
 =?us-ascii?Q?6IZPbNS4u8zx9qWtEb3oonPdLgSpSBnjwrr8YSysMZNvUZZwocQzzbXBgAQ7?=
 =?us-ascii?Q?RDdnJJS/IVQ8UkoL76at1dohGcPrpvbo3uItX8z0WrnCrpIpODlLhDDkroLK?=
 =?us-ascii?Q?eb80dR98ZZ96weE3aHzkE1lMeiql5x3pT+jDWvGMS8Evjwzl8UmGWPSwCFLD?=
 =?us-ascii?Q?A03A0xo4Jh3N++yf99uiQ/o2Z+Yw+fnRNJETJuUcJpF1CzFKJoiC44ERqgsI?=
 =?us-ascii?Q?0kWni36ObrgIXXIcw9h4MDy7zLBzyD+t7uCI+SCfMZYZxIhEpCCE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6525f6ac-2a89-4a50-cef2-08de54b73dd9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:25:12.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulVdnCdVTsv2nnp6N+O+3vHvNsojMtohP3Xa907rlqhKOXrXBeoF2OOlmb3Nhvo1rGe/qpE2RBl2Cxm4B+sBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

kernel.h hosts declarations that can be placed better. This series
decouples kernel.h with some explicit and implicit dependencies; also,
moves tracing functionality to a new independent header.

For testing, see v4.

v1: https://lore.kernel.org/all/20251129195304.204082-1-yury.norov@gmail.com/
v2: https://lore.kernel.org/all/20251203162329.280182-1-yury.norov@gmail.com/
v3: https://lore.kernel.org/all/20251205175237.242022-1-yury.norov@gmail.com/
v4: https://lore.kernel.org/all/20251225170930.1151781-1-yury.norov@gmail.com/
v5:
 - drop v4#7, i.e. keep trace_printk.h included in kernel.h

Steven Rostedt (1):
  tracing: Remove size parameter in __trace_puts()

Yury Norov (5):
  kernel.h: drop STACK_MAGIC macro
  moduleparam: include required headers explicitly
  kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
  kernel.h: include linux/instruction_pointer.h explicitly
  tracing: move tracing declarations from kernel.h to a dedicated header

 Documentation/filesystems/sysfs.rst           |   2 +-
 arch/s390/include/asm/processor.h             |   1 +
 .../drm/i915/gt/selftest_ring_submission.c    |   1 +
 drivers/gpu/drm/i915/i915_selftest.h          |   2 +
 include/linux/kernel.h                        | 210 +-----------------
 include/linux/moduleparam.h                   |   7 +-
 include/linux/sysfs.h                         |  13 ++
 include/linux/trace_printk.h                  | 204 +++++++++++++++++
 include/linux/ww_mutex.h                      |   1 +
 kernel/trace/trace.c                          |   7 +-
 kernel/trace/trace.h                          |   2 +-
 11 files changed, 234 insertions(+), 216 deletions(-)
 create mode 100644 include/linux/trace_printk.h

-- 
2.43.0

