Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793675770;
	b=4b20whPIwi0l+Ao9sb//uge9Q8E/+3FyISOlUX7VbyWgP7Rh6r9CYrIA0Ui2NOzisgwZ
	 dPKdITfsNLUreK6TrtEFVfQm59tpNQKD/ivNdG8KhTHmcjPEWOM9yf4T1YLvM5I310y+M
	 cguOvCiFYLaPy7QHuE9B0vfAvawJMdbU3DzrBpHdyzCvS6AQg+aJbpfxxTF3TnIU2Bp03
	 qBQqcIUbiYCRI2BBNwZNlQihlUzXC5tN95vEk/MRTX+5bKUgKoEdYddl9pD+jbyVf9Sam
	 e34tI4QVCBbJVOLdXqohVO+9VSMNTf/Xg/BjmDw2M5D+K/Rn0eJ7aE55F8QahpRvxTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675770;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:Subject:
	 Cc:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3PBp3KjHqZkMycqlnDembWGhSyeoJrMSFrKcxvRx9yM=;
	b=RZ6DuzjaKJLITS4cI1zbGTVSBwnQ6BDQpNtPrSo/9r0BKAGF/M3kWz0M1+veqtTJe3oU
	 nDIMKtCFhTZ348tofEUsKNZoL4r0IKWQj1Ax/qWYOShFw1ZEIDLKwM88g2oy/n6GUAFjx
	 C5ltHlqm+wUD7w62cnY4B2db9NuRrJ8iD0D4WFBZ0MRMoNuyPynQRbn2Qj7MujU0G5neu
	 RDRTcaCKRHEqSr1L7pmBg2Pvz80ckmOIqMEXjlc2HahkbfFPL29bP6JdLDa+9aEOMKbX/
	 baTRORCpyt7lNfToiigx9caTj/UI9NTn8FZKyMMSsvnqs6UvpEYQB8QieTcSmOvtFgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rMBFrXl3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.29
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6B606A324;
	Tue,  3 Nov 2026 03:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A6B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rMBFrXl3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWGOuuIpnC0zaQtIJODSJoJPAj5ebMyPlaiyiU7H3wRuZ4cGEHQrhAQvzk01L1/8Hg7+7yAYl9DUP+wKYsCLkd3zkCMyRq1oUlWw2uvUK7Gp1veHd8nPAGgSoMGrQ4xzixzwX4TDICTPmxE1mt4DAC2TVAzOtLlFliObo3wExUeoIHohMVXayDZ67jtGg72FGD/cxWT2DprTs/dCRozfs2mlm+3/sv0ABhTniDRHyfByDI+NBveXdXQvWya5D2Oxnbgh6Fykpds8wUczO7kl9BRvVnPw+MSPdkmIsxdxrFRCy/MCn2ypJ3KLWWx05OAM3f7XHukX1qlvgrE1hfQQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PBp3KjHqZkMycqlnDembWGhSyeoJrMSFrKcxvRx9yM=;
 b=cA/0nsmTV5vTcZmzfIk8/fKFSh3yWRQPBeEAEgHFb//JildtpESFkcMqEVYV4mTooKReKGfG6bOpRXZ4m2ZuH090a2N3yDQXhUFstswMZklr/94SxeVirohaPelJjtrE8xx1qCHFP2bhIj9nkeWgqxofFquUnCzU24edgEGP3Z6BWem2zsy5EmT7IJCqgODtF2E6qen+wZMPAASp4nBwGRTtSAUvioRrSxxZkEoIUiP8X0Vek6Z63iE/TCPUR0nxsnIpHlXvrH3Fjn//fhQAcAp+eBiaDxYXUWlm2Q5+Nup7nBQJHa9VMTkREpucTshQ9jNLRaXkhM/EuJB4qSc3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PBp3KjHqZkMycqlnDembWGhSyeoJrMSFrKcxvRx9yM=;
 b=rMBFrXl3YD7HUsFk3qiNdnMo2sf6Cd8gOXC0z8P0WIkJ1FV6caMrEYLWdRaEfp3CRESNd++HVvhidE/LWNWlbnRfSx5mRW2ooCWXTQdEXLyf0Lg0xJZ3zL+Ngx42h88fT4sxNf09nvrROWNRsiLaUt8t8nhUeqq8phd1W2A3Vk/EM3lhx6TZeZTOXbvqTAd4smvI5fWsAdiJqtvf81pBukkY80WpTvzIKhWmpaUU6d4sR+mw9w3MLuLwUf/TzLluPEbWRIRJOt7ySA/Gt0Bs9mxYLNu/ACPqO+4WpFS6jgubUuIlTm6ipI14PTkIN6R6Sld0jCtkVMtwAJBPmJI8hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:16:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:16:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:15:59 -0500
Message-Id: <DML8ZOGLGOY6.2KBZ8XOKBAU15@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v5 12/12] mm/mmzone: remove zonelist_node_idx()
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>, <akpm@linux-foundation.org>, <david@kernel.org>,
 <ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
 <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
 <kasong@tencent.com>, <qi.zheng@linux.dev>, <shakeel.butt@linux.dev>,
 <baohua@kernel.org>, <axelrasmussen@google.com>, <yuanchu@google.com>,
 <weixugc@google.com>, <baoquan.he@linux.dev>,
 <baolin.wang@linux.alibaba.com>, <rientjes@google.com>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <muchun.song@linux.dev>,
 <osalvador@suse.de>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
 <ying.huang@linux.alibaba.com>, <brendan.jackman@linux.dev>,
 <hannes@cmpxchg.org>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>,
 <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
 <justinstitt@google.com>, <Bessel.Wang@huawei.com>, <jiang.liu@huawei.com>,
 <mgorman@techsingularity.net>, <anshuman.khandual@arm.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>
X-Mailer: aerc 0.22.0
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-13-gourry@gourry.net>
In-Reply-To: <20261101021340.2251928-13-gourry@gourry.net>
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 677dfba0-e73a-49c1-2497-08df3958ca34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|261102123227099003|18002099003|56012099006|261022075727099003|261021121427099003|11063799006|5023799004|4143699003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	VCMPRVBtlCPk1L0gJ414k14+9gHXczWLwLAo+Cm0+fUUxAug+kQxAvkHTiE+XwDcDUrBW4oFgLV4gHfqGadxgBJuF9Icaj3lgPkJSktxWUBZXS5lVGjuIHincnMXpu0xExBUCIs5L6MTIc3SCqQ+pX8qq7OnKlWTKbrqIvpD/jlEH3GGm4rF2AqKE4t6WsuGfhOUmJUU0mAt78MR18hHFLkX7lwKCDiS4CTQBG0BTiXQssQyqSDY+2fpWHs2NzNue5g/IqYeYwJ008skPnx86bajJdMg6xg4SkdHi6qQ2tfZ8NdVshqfQb3kVglK2BSraCvgw9RoR6RepB9CVW0w587ASK0zhPh7P7kTr68lAaxVo/zTZP90r7dZ1UES1jf0WKoRVx5I8aCOq4aKGnrgkEaZOtq+wqA6kczsadCgzCBC7c9Pr3IhtkA2SgIImHV11kiILkrSLmTVKFTMyaVKy2jgcTAumu+LQqmVmYhguzadWQEVeHOWC/Fl/z/hP59ayAkxsp7SsKRK9CfMuj80lIbHq2YTcwUKBdNUF/ZVp5r+SOID5hXxrY+TEyOxU2iapKPV28AEvD8TJ4GO2Rw87chMHRXM8//ZJgWwCwNiYUr6i086OuqSbH0xuwuegVyGtGt8UB2WKT2u0Lm/4EE4Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(261102123227099003)(18002099003)(56012099006)(261022075727099003)(261021121427099003)(11063799006)(5023799004)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3dERWpwY3NJK2lVZGxTNnM3TkxVQmhiK0JvRlcvalBuNzQwN2lKdmQzOHZZ?=
 =?utf-8?B?aWxreHRXV3NCaUsyRVdrQWpRc0FFaHFLUE96T2Q4RjNtZ3R5ZVkxNEk2eE5Y?=
 =?utf-8?B?QXVlbGlBbEpDWUJjeFVJN0lMQktTVU1ydW5QTFFsS2hadndjQSs3SDFxbUNl?=
 =?utf-8?B?ZmRDMEgrUGN5d25yWDFtTTdCU0pldGRBRFlQY0ttREtBK3hzOXc1ZXNqZElZ?=
 =?utf-8?B?Z0lyV2JHRktCN09ORm9jTG40RlhTSng0dEVMZlJqV1JMaGdCd05SdisvR1JB?=
 =?utf-8?B?a3dHdDlPcldSTFc0aWl2SHNwUTNpN0N4Zmt2RVkxMFZKRzZ1QnFodUxqdEsz?=
 =?utf-8?B?Q2hONTA2bkpUREtDaVJyOGVLNnJuaEI5WXFOUEp2NUhYMENvNG9hVFlOZFlM?=
 =?utf-8?B?TThneGVHalcrYUJZazFBK0F6VHUyK29maWhaV2hXN1QrdU56V2czeDc4aXhF?=
 =?utf-8?B?ZzgyaEx2VHF1T1RBNVFuVUo0SEc2c3UyMDVXTmpTVFlXbmdFejFyNEJyMFhG?=
 =?utf-8?B?Z1AvajZrZU82TitVNEtCaHhrVng5aGdZNS9Hd2ttRndXSWFUdVozRUpwLzV0?=
 =?utf-8?B?WC8vVEtDZnpBeXVlZUU3OFlIRXk1MStvSysrNFFEZ2lPNitWUGhXUmxOTSt3?=
 =?utf-8?B?UUtleFUzU1ZlZWl1ajJ2cCtlMC95T2haVkRXcWlkeVBhZzJqY3g4ZlU1OEtP?=
 =?utf-8?B?WDBDaWU3b3lDVURteFBUWld1K1JhZ0lRcGZOMDFySjVZeCtYWHcxT2owV2tN?=
 =?utf-8?B?Ti96MEtBdmR0dGFteGVmUEh2UHdwQUdKYUJPS3R0SEpSZjJaWkFYV3dFMEpT?=
 =?utf-8?B?b2I0UncvaWxCQVhYNG9ZZUExNFBRUjNMeko5aURZTWhkYVc3YnZ5NC9jTmda?=
 =?utf-8?B?aU1nZVdPUkNva3JYcVdWTjAxZEpMRGhGTVVhUTZrZGkxaWYrcTJLWWlMMmdr?=
 =?utf-8?B?c3BqUy9XVHBQU3M0VHdGcHByaGZiVjFTVVdUcnoxR25hc1pTQVViUFZ1OEZj?=
 =?utf-8?B?QlQwMTRBdUxrQnkyRG5EaW5yV0Y4Qi9NRVE2SWF6eUJUQmczRXFiTDVncW5Z?=
 =?utf-8?B?c0t1RG5NaGpTekoxVXZWc21lcEUxOWJTbnBBNDl6c2FKK2xoN2dnOXZGVDBF?=
 =?utf-8?B?Z1pnblZwYzFodWkxMkN0cnhwdjdiem1UUFYwdFh0azFJV0VadFBkKzlBT0pK?=
 =?utf-8?B?UUVaYUtoUjhwTU1DekFPMTdXV0pwaFlKVjlQTkd6Mk1MU0E0REpLbEllRWUy?=
 =?utf-8?B?ZDUzUkJLUzhTZ1REV1lCRkVqM2pyN1RqdFdMNnBEWHJTZnV3OUlaWS9FQ2lo?=
 =?utf-8?B?SzBZNzlEY3JGQWNwN3NVbzhybDVUR2dYR0Z6UHlVNitVK0FZdExPbTZ6Ym53?=
 =?utf-8?B?UzNoRXJPaUljYS8vazR4Snl1REhVU096TUpMb2VzRXprUjRaT1I5RVdFZ2Y5?=
 =?utf-8?B?QXVUbVVIWUZEYTNqekJDUVdRc3pTL29TaDUrUmc1VCs3R2pRWmhJU0tvZTkw?=
 =?utf-8?B?U1JyMFFsVk0wRnlqalBZMm1ZNjRTY21wN1drZFFoZk5FeWZEc1VGdmhNekQv?=
 =?utf-8?B?ZWRhMmFJZWFxUW9yeGVzZ3FGbFFlRWNzS2ZoWVNFWGtUNDhIRXFZZms4dW5U?=
 =?utf-8?B?N29zai9aemVhUUlxTGNta0wrUTVCOG9vaENsbWdab21lT1NhTjBUNWdjcVVS?=
 =?utf-8?B?Y1hFL0U3RU5MZmZocGJQazFmWXdtQU9NWDBjOXRtOW44d1lWZ3NNVHJLWHVZ?=
 =?utf-8?B?ZUgzbWJuV2I3WThOSmtPaVlUMUtaMWtIVlFWUHF2dDBJTzRaVDQ4RllldzZZ?=
 =?utf-8?B?enFOS044RndoVDhsT0hBenY4UFNyaWFMZlI5b1EwVVIzOFIvRFp6NXpIOEVo?=
 =?utf-8?B?MGMxaU9pQnZQV1ZQWWFGUkNOaUgyaXJoc2c0ejNIdmhhendqVTlsTlVXV1hT?=
 =?utf-8?B?SE92THMrRGRYMDNMMjc1bUw5MW40bitSMUZVQnpjQmxMV0JOSEZnb2ZOT3Ns?=
 =?utf-8?B?ZDR4eFR6bHdjVEpQdi9NNFFIRXExbkdtajRabkF4bVJ1a1dhVzdya01Xb1hO?=
 =?utf-8?B?SFBTdm9tLzViRkNLQ2p3eG4vZDl0VENpeTBXREV6aXdoOWNnWjhSTUFsQ2FI?=
 =?utf-8?B?K1ZoOUU3bEI2cjN2SkQvQUVNS2hsdXZHK3BiQTNrVGdYQ1NWNUpmeW9GTGFu?=
 =?utf-8?B?Y1htSzNCMDN0WStIK1VvTFJuQXlOc2Mzbmp6R0VBb3RGQndtQURWSXJWTktj?=
 =?utf-8?B?a3R4d2NML1k0RU90MzNCZUpkd3l4RlF2SEkzVUNXMVdHM3lyNWhNZWJFdUZP?=
 =?utf-8?Q?QvV+URilOkZjVTratR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677dfba0-e73a-49c1-2497-08df3958ca34
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:16:02.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaZReS6sb6DncmjD/lICWEhczqRi29nlMTpe7brDIKfzorGO+tGJ6T1vo4OYlTXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
> zonelist_node_idx() looks like it returns a field of the zoneref, as
> zonelist_zone_idx() does, but it loads the zone from the slot again.
>
> Memory hotplug rewrites zonelists in place, so a caller that has already
> checked the slot can get a different zone, or the NULL terminator, from
> that second load.
>
> __next_zones_zonelist() and mempolicy_slab_node() had this bug.
>
> Remove the helper and open-code it in its two remaining callers, neither
> of which can race with a rebuild.  local_memory_node() runs either inside
> __build_all_zonelists() or during CPU bring-up, which holds
> cpu_hotplug_lock for write and so excludes mem_hotplug_begin().
>
> The lookup in mpol_misplaced() is unreachable: it needs a policy with
> MPOL_F_MOF but not MPOL_F_MORON, and nothing sets one without the other.
>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/mmzone.h | 6 ------
>  mm/mempolicy.c         | 2 +-
>  mm/page_alloc.c        | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

