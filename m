Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9C6F066;
	Tue, 28 May 2024 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880282; cv=fail; b=XpuL7A1keGimWAcIAD22gq3Quq+ylPHKjBG64iMq4UCG8T0VAdt2HOWcDnV0RnhRXQpygWkiL7/QnCq7197B8M3uh0L1PQp2SVyBBHDTsqs9qu7GfuS6kR75PsCMfp13GVmSG/vdiLYtW/yBV0N7XUa9lgUrqz5O71PAzAOtvos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880282; c=relaxed/simple;
	bh=7O1kCks6yj9izOo6JjJYJ6LgTpaNuPG2EBf2JfLCqLM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=exxbrF5WEiaK2ClG/0jG8siOpyGdB+yJ2498FojnHWVteUZkGF3T5eCQyVpXZgEsYUQwmHvQBko+q0lcGFRr/YCBa14J2uxy3rDLnmxS6mKdf6WxIiQ7Qlf9+SkFu7MAEcHgA00ukvddtr7JU4jTVa56uFHy/ltqk8jFMlSlr5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwrEiQRU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwrEiQRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716880280; x=1748416280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7O1kCks6yj9izOo6JjJYJ6LgTpaNuPG2EBf2JfLCqLM=;
  b=ZwrEiQRUH5c3eBqK0RLmUQfGoJE+vTwX4XuJ5LwTEMilrpWsBFejWdAS
   8syroNkStlmYcVDg27oUi0c8vqxHayw/BZz307+eLamA21k4OQpXIvIwl
   zuvUQMf5a1NaZhkXPvjwlSjZ3tqUt7h2kq5yMMtkOHAdXDa6buMau760h
   7DJak9mUsPbalirTBAX/pyU0sYQ0G+b9OGlyOxXlBXIq0H4kuoJQqhwu8
   CH1WKrQYgy7SSmI7rFvGEE5zT2BZ/bu2FEMs5X0tH1ay2uMdcNXRFhzEJ
   3wP3E4231Xn8o3EG8cbO2cX9upzKwMlBMVz1w0nUHfh9y6slKcOZfDqwE
   Q==;
X-CSE-ConnectionGUID: wGB0RZzmQVC8oBfa8+/GXg==
X-CSE-MsgGUID: qUpy67kvRvKNcNBWdwR/cA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17039868"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="17039868"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 00:11:19 -0700
X-CSE-ConnectionGUID: BYv8XJerSZKoXMy4IDhoIg==
X-CSE-MsgGUID: nqRKJhKITJy2clMMBWfT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39510012"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 00:11:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:11:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:11:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 00:11:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 00:11:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6mJ5lV5NJ5BiUVkzYUGClHM/kISK5r3HHogrjwq3CyQyGgihizNVh2vhVx3vIkWjudUKMQJX1f6ZPyaH/oFHBPy06gNprVJU37HJRVOfp2UMS6p3uFy05dQEwGl0jm1/O41g+uRQKoypFcy0hsu/NAsXhSAu9nY/J8HeGT2RVCQskLKtQldhGvalv7KCJJOJSoOkeAsIA368gYESGrgup3+o4knS1PYdBEzZ45W3rMN73NGsW8Y+6qG3U2bDzNPcYbdRn2s12EGsM2NqGBWOFP2TkAVmFc39MjsP29sjtlWb1irkvDB1t+8XqQ/cFOynVZMioznb1r6iUUIojZ0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96QuQBvmPPi93c6T+UE308/VWMLwVDEr3d+ikSZrxuY=;
 b=G/J+m/9ed+g8wmA0ZKQdnYzFkApIRfTmTEr/+GwW5Y4qWF+5EHh6+aEUVcb11bYgrdNryf9AL+i+HR+9CQf3qE/wT1AQPwDyaT6g2sHD5hkiCwlhqIQqVTH9UPvKgrLFsyH64uIE8tjmEHA5ETbziCuPBKautBBlhV4SsU8cb0AMxRkfxJLz7e9LZ2mMrk84vdjWOsZfAPLJMyt7wUAWGno0a/X5V3xG86/1XPdzUCOPswCjsvoWVX5ZUdUhmGWvIdafaB6hgU/IjJdbCjYiO+HsQmLo/2k+TpzGmYcYGhQp8UfGc6fi9CuQcRFjaZoEadIPtH/7J19e4mowkxWOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:11:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:11:16 +0000
Date: Tue, 28 May 2024 15:11:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Luis Chamberlain
	<mcgrof@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Muchun Song
	<muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm]  d99e3140a4:
 BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report
Message-ID: <202405281431.c46a3be9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1c48f3-dc38-4d95-887f-08dc7ee55dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Eu48UDWTgmvv5T6DE3WKjfpbEc5NMyDCOAEL60pXfdtxOHYA/qeYVeNFOvN?=
 =?us-ascii?Q?gI9xCVNwfKyEqDFySLRMudMk9t6jxOPxio4/CZXuMTdfWTGFAn1HjBK6M/rm?=
 =?us-ascii?Q?Sd0MskZ8FhoNPtMa/e2ScyILNFkTSRajiuSP8IUTTZ73soYigGlLFcKg9K4/?=
 =?us-ascii?Q?KjXIpK+zqD2YR60Q8MwqbrnouNIDe4N3IsSh1SckFypZHemLbbUTRB38cxiK?=
 =?us-ascii?Q?bulctsGzYWOepkTXtjQHj7L+KbWbkg161FQAmX39Cydf/QvWHyRkAUaOoFvM?=
 =?us-ascii?Q?2hcl3ctA5EqDYqjjudbP/uycFTeWWOmDytXnprA/9+k0pX8QHaWISFRw8QTe?=
 =?us-ascii?Q?xPn5ciqmaL6xaVJ9FNAk0H625To1s2cxJJ1qJEsbiFDzeYihPa+PHLS6HfCC?=
 =?us-ascii?Q?vVnaviKsHgn0jHTJ1osh8Jf0JkRsRDy6k8AY6c4VzUD8kWuFDtIuJMVXroQ6?=
 =?us-ascii?Q?kwVsN+s9rlgg/ut/8HXH4pAIJaKturWzKxw4jtbpmhd8VrhDyjgF9NohJZjH?=
 =?us-ascii?Q?NUEO+REluP1kI3mtU85hkr5frY5BuWBitAR27gw8BvVmnoQR/zjJMyKFCOB3?=
 =?us-ascii?Q?EbzMxkmSWH4oLxXT73nQsUNCR4NdYsR8KQ/yVtthAHPQ6d28k1FmNlRiniZ6?=
 =?us-ascii?Q?cbxpeaqeY6keotf7CZioyN++lXrNMAjXE+ChzNXBpYC4V2RKSp5OZXNel/Zk?=
 =?us-ascii?Q?K924JyxMrfec62rT3doMLzgb+XAAo0akktRUgxr0IZRIde9UZAXXsy3DYQqg?=
 =?us-ascii?Q?JCUgMENSbw269I9L9Dh32mo3xgf+OMmjGx5vEvKF7zh6j1kF8i5w7WvZ2bnm?=
 =?us-ascii?Q?pWKaE+RXBNB70O+phtCgcd724be58llg0YWAOT7YHh8dUhw6rKbca0e0PqVd?=
 =?us-ascii?Q?mG9kM2peo6SnrANHQuC0DXROwmlv20/2tl1CljiU3E498OCkBHbwFyk9pklr?=
 =?us-ascii?Q?eLJfbzs4qgmGYb+fYpTyAUnFhkPaeWOzLgYKo6/Hb2w+DrxSGtSxCpofqWd2?=
 =?us-ascii?Q?H9qc+VYM+gxy8+UCvG0rGKGiOa2rn9u2Opqd0HGmWKlbzPhnAXf21eeOXxF9?=
 =?us-ascii?Q?vynmVzqX9nc47J1BwQKaTsaiLepI5+eC2kEzRpOd9JeSrebzk+iMrYgAFL1V?=
 =?us-ascii?Q?btWr2FK5vB8HwIdHk264rVjEmFM+CyZe7Q4bz63L2p7n0ppJWb5VFKXdXK2C?=
 =?us-ascii?Q?LTpR7aROVKHNhp4WcE1lmpZaMfZZe78dMsvjX0zn7ilW0LaVtOGoxRmBLnU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUe3Gmi17pmXvzqCyVqrjXoLIh01hDL/QkhzDvMRERMOJLUfGV8r0YWCrWNB?=
 =?us-ascii?Q?/k9mhxBaGCwfAv23WQl+OkpIGsl9lsRBhUMoNNsbiXpD5d0Vg3nB4PEnABJj?=
 =?us-ascii?Q?WGHfuJAxtyAp1YyAQNHcGVQ/i5IhSjU/ghGwrxzN59V7FM5Lz29DYtEC9RKG?=
 =?us-ascii?Q?Su2JRvqxTbvCEsmbGMGP3I9B6aWMoI4m22/iXI2ro0/gOGw3asToTzrO2Vt3?=
 =?us-ascii?Q?J4tWtc/na+FbxYG9bOBhb5FLRPUO1dBqhFXb7/FRkUWcv/Xs2v6Euq7U/oyb?=
 =?us-ascii?Q?5LXQb7ZhxA5TeMoEI7VbhCTUUj5QBM7RuQVw7P8obNT8DEHjyqMSvW6ZJJxx?=
 =?us-ascii?Q?pPOvcP41cjgdAueBLBE0Fy+YZ7wExbA6PxtBfeb173qyqzDMWcjDz39Iom3J?=
 =?us-ascii?Q?jSKySThx0iNdW0lJlhtd4qc8iTRcopCyZ0IBVlrm7qwqLCgw1NwJMVZgUSyq?=
 =?us-ascii?Q?f3P4DnvhLva5VFd9jGM5x4xMeQvMuEYAz74rBbzKpykaApoycNe/c3BaBSjZ?=
 =?us-ascii?Q?i/mSvCc3stoV6XX2VLUz6FO3htd3SJEjvkZ8AmYs1/gR+sL2A4YyMhV2aZmF?=
 =?us-ascii?Q?CjQ9z+B7ddxP/enUlqwCGCNpFksuH5qdPYzSnPr8VIZ/RM/C7xocCRdeioHH?=
 =?us-ascii?Q?XG5uzFt2RJC0Mo6WL/feqFqBDcALm/zcAi8DPwe51mLyxB9vgSSaCN0l41Zz?=
 =?us-ascii?Q?vGXiTTUX2HhHJO71Usf+Lt4u4fA8FPw/LicORnfBa1MkXFVBPWAg6OWm15/G?=
 =?us-ascii?Q?o6vXhCU+Z/D4CLFZ6QOeTdiCDjWxbLDnBzY/r34rgdmFjrPweYUnTNF6v4TS?=
 =?us-ascii?Q?sWhKP8Rb+BvPM0E9ixVQpQEi8GaO+PajrgznyoA4oo2uB7Fc9vU+kbUSBSub?=
 =?us-ascii?Q?Zo1yG7HGn4MHffRs5F6rj+v4PVD2T1/7rbODiawL/iHbVqdI4Rn5tBGzQLul?=
 =?us-ascii?Q?8qMnWkK7RZn2j1Kdtm9hqdWv3kPNCPx4HNcln+TpWlY51cHDa9tGbKiA8urx?=
 =?us-ascii?Q?xB1Wsr5GS3CO/w3CdzKYJX/VOGOCrGWb+7/0Vg29r2V6KUnxseP3Abo0wqHO?=
 =?us-ascii?Q?pWMM2hdUh/UnRZspuQ86+w9L8xXgGTwE0rW0m7cDotrY7BmWE0FXLGH4D4Hr?=
 =?us-ascii?Q?ueGwUqC8yWMVPO9O2j/iUL5x5KtVYYSnsE5IovdjFylJNM6NsudCt5FoVaOd?=
 =?us-ascii?Q?LfTTIEZiBTHfgQt3wUVJ4igPcO1/hyXFMtrmpnNY26VV2PcB0dlDmpP2u+wM?=
 =?us-ascii?Q?Fje7wu8SGQ5WPVTLLofbFMoIlvrUIZWK86pDPqhHn9konCCRfKgtIyd7Kuuh?=
 =?us-ascii?Q?U147/KlXA+uQoQxOua9Ij9lu0TU+qLpX+3dLLwzLqzhzZfgv8BC+eIyCTpE/?=
 =?us-ascii?Q?/KDwogOJrMbH/rLsETiEnzKe39iZYwFAFJJ+ixWGvP99zZmoUWOJaEWXxjcM?=
 =?us-ascii?Q?P3tphSyTgCCAmCy7Ftj0GThdmN61eARqXRUvxw2h2qxg6TgWISpOqkEdrQbK?=
 =?us-ascii?Q?ElmUA0F9Iu4wuoSS9xciHbPNlHzLXjJUDjbltpTFg0UqM8PmwJdVSDeFsWyP?=
 =?us-ascii?Q?t7jIvAqJ92yVMeEO7u5f3C/bVENziWGMrgfjDGJFqRZWvwcJgQCbbRgxoArf?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1c48f3-dc38-4d95-887f-08dc7ee55dac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:11:16.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNEoy0MQyvxlAdi4QROCVm3T91RSOBGsm2bwsy6fV01UXakjtGcViar0n0mo9+s8sfBjvSGNYtbtb49Vp1CzVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report" on:

commit: d99e3140a4d33e26066183ff727d8f02f56bec64 ("mm: turn folio_test_hugetlb into a PageType")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c760b3725e52403dc1b28644fb09c47a83cacea6]
[test failed on linux-next/master 3689b0ef08b70e4e03b82ebd37730a03a672853a]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this issue does not always happen. we also noticed there are
different random KCSAN issues for both this commit and its parent. but below
4 only happen on this commit with not small rate and keep clean on parent.

fd1a745ce03e3794 d99e3140a4d33e26066183ff727
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :106         35%          37:192   dmesg.BUG:KCSAN:data-race_in_folio_add_file_rmap_ptes/print_report
           :106         29%          31:192   dmesg.BUG:KCSAN:data-race_in_folio_dup_file_rmap_ptes/print_report
           :106        103%         109:192   dmesg.BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report
           :106         21%          22:192   dmesg.BUG:KCSAN:data-race_in_folio_try_dup_anon_rmap_ptes/print_report



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405281431.c46a3be9-lkp@intel.com


[   66.557105][  T404] BUG: KCSAN: data-race in folio_remove_rmap_ptes / print_report
[   66.557726][  T404]
[   66.557923][  T404] read-write (marked) to 0xffffea000443ec30 of 4 bytes by task 405 on cpu 0:
[ 66.558647][ T404] folio_remove_rmap_ptes (arch/x86/include/asm/atomic.h:79 (discriminator 1) include/linux/atomic/atomic-arch-fallback.h:2319 (discriminator 1) include/linux/atomic/atomic-instrumented.h:1421 (discriminator 1) mm/rmap.c:1514 (discriminator 1) mm/rmap.c:1590 (discriminator 1)) 
[ 66.559106][ T404] zap_present_ptes (mm/memory.c:1506 mm/memory.c:1563) 
[ 66.559525][ T404] zap_pte_range (mm/memory.c:1608 (discriminator 1)) 
[ 66.559919][ T404] zap_pmd_range+0x11c/0x18a 
[ 66.560359][ T404] unmap_page_range (mm/memory.c:1751 mm/memory.c:1772 mm/memory.c:1793) 
[ 66.560773][ T404] unmap_single_vma (mm/memory.c:1841) 
[ 66.561184][ T404] unmap_vmas (mm/memory.c:1885) 
[ 66.561552][ T404] exit_mmap (mm/mmap.c:3268) 
[ 66.561910][ T404] __mmput (kernel/fork.c:1347) 
[ 66.562235][ T404] mmput (kernel/fork.c:1369) 
[ 66.562555][ T404] exec_mmap (fs/exec.c:1053) 
[ 66.562901][ T404] begin_new_exec (fs/exec.c:1310) 
[ 66.563280][ T404] load_elf_binary (fs/binfmt_elf.c:1006 (discriminator 1)) 
[ 66.563678][ T404] search_binary_handler (fs/exec.c:1780) 
[ 66.564106][ T404] exec_binprm (fs/exec.c:1821) 
[ 66.564461][ T404] bprm_execve (fs/exec.c:1872) 
[ 66.564829][ T404] do_execveat_common+0x286/0x2af 
[ 66.565284][ T404] compat_do_execve (fs/exec.c:2081) 
[ 66.565663][ T404] __ia32_compat_sys_execve (fs/exec.c:2144) 
[ 66.566100][ T404] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-016-20230920/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 66.566529][ T404] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:321) 
[ 66.566946][ T404] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 66.567369][ T404] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 66.567762][ T404] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:122) 
[   66.568307][  T404]
[   66.568510][  T404] read to 0xffffea000443ec30 of 4 bytes by task 404 on cpu 1:
[ 66.569119][ T404] print_report (kernel/kcsan/report.c:396) 
[ 66.569495][ T404] kcsan_report_known_origin (kernel/kcsan/report.c:692) 
[ 66.569959][ T404] kcsan_setup_watchpoint (kernel/kcsan/core.c:678) 
[ 66.570402][ T404] __tsan_read4 (kernel/kcsan/core.c:1024) 
[ 66.570787][ T404] __folio_rmap_sanity_checks (include/linux/page-flags.h:1045 include/linux/rmap.h:201) 
[ 66.571241][ T404] folio_remove_rmap_ptes (include/linux/instrumented.h:97 include/linux/atomic/atomic-instrumented.h:1420 mm/rmap.c:1514 mm/rmap.c:1590) 
[ 66.571679][ T404] zap_present_ptes (mm/memory.c:1506 mm/memory.c:1563) 
[ 66.572076][ T404] zap_pte_range (mm/memory.c:1608 (discriminator 1)) 
[ 66.572456][ T404] zap_pmd_range+0x11c/0x18a 
[ 66.572877][ T404] unmap_page_range (mm/memory.c:1751 mm/memory.c:1772 mm/memory.c:1793) 
[ 66.573274][ T404] unmap_single_vma (mm/memory.c:1841) 
[ 66.573670][ T404] unmap_vmas (mm/memory.c:1885) 
[ 66.574020][ T404] exit_mmap (mm/mmap.c:3268) 
[ 66.574364][ T404] __mmput (kernel/fork.c:1347) 
[ 66.574717][ T404] mmput (kernel/fork.c:1369) 
[ 66.575033][ T404] exec_mmap (fs/exec.c:1053) 
[ 66.575401][ T404] begin_new_exec (fs/exec.c:1310) 
[ 66.575811][ T404] load_elf_binary (fs/binfmt_elf.c:1006 (discriminator 1)) 
[ 66.576234][ T404] search_binary_handler (fs/exec.c:1780) 
[ 66.576683][ T404] exec_binprm (fs/exec.c:1821) 
[ 66.577064][ T404] bprm_execve (fs/exec.c:1872) 
[ 66.577455][ T404] do_execveat_common+0x286/0x2af 
[ 66.577939][ T404] compat_do_execve (fs/exec.c:2081) 
[ 66.578316][ T404] __ia32_compat_sys_execve (fs/exec.c:2144) 
[ 66.582840][ T404] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-016-20230920/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 66.583256][ T404] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:321) 
[ 66.583687][ T404] do_fast_syscall_32 (arch/x86/entry/common.c:346 (discriminator 1)) 
[ 66.584104][ T404] do_SYSENTER_32 (arch/x86/entry/common.c:385) 
[ 66.584491][ T404] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:122) 
[   66.585022][  T404]
[   66.585226][  T404] value changed: 0x00000016 -> 0x00000015
[   66.585694][  T404]
[   66.585891][  T404] Reported by Kernel Concurrency Sanitizer on:
[   66.586387][  T404] CPU: 1 PID: 404 Comm: run Not tainted 6.9.0-rc4-00021-gd99e3140a4d3 #1
[   66.587057][  T404] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   66.587876][  T404] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240528/202405281431.c46a3be9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

