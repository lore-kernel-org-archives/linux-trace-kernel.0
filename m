Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964EC8FE;
	Fri,  6 Dec 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466828; cv=fail; b=R/hhM+BL6GWzZkLkN7JnaJYbd+wyASo3iCfOywq/I3KtCOozasVAo7WC+Fu6n0Gc6lsCXT9szxbLFPKBkD/JiZ/lL9NIYNePO28yxCK3DwJcysLnZmafJT7aHcLfrRnL/qwW2sKATGCOgE8+3CryKH5O0HLia81HqA6Rq0XYn74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466828; c=relaxed/simple;
	bh=MZ9KLE3U7kXcKipt5Csq7Bz02bnWclySQ7xgHJUjQVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tD/B3RZppXfK/3DeX6PnY3N2ANMT6nyNbfAHwJZKzEyYlhWZ6MDLQFhDoTEWr4g5xXiXD4GBk5Fqw8vKI+UlbImgeOeKIsreEzYQ2M5tmVkwBxvF/PUfd8GaobO3M0gFNMJmvUe80FyNm82rkF+kCrNCXwJk7LYKXYgKjRPI39k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vqYeM6F/; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqYeM6F/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgRaVMWCnabtUg0w6BL1YroedmSLM5J4OO7sDZqHtJcSPiqw5GnOGo8rhx5tcc3KhqXZ7kpW8BdvrkiidyztNdayyXQjfDkgL5zcChXeVQueUTQmcmOavDzuE4rEK2cegk0j5cNgdf3tl7Vjo04fLhV896vYFt3up2F+YkJyizs6+aI3BYoNGtSumja7W70Pp6Wd1ZpUHYwxu0FBztNC7++ER8VEhVdpv28WYzfpI/hkqUpk+Yc4rjOkgy9INPOpFqeZbTIvqku9+ncjKhiWgOUpMShJBS36rK9ZkjG6ciCjJ8knQr2J15MGYYclfEp4mlCdIF4T50Qm2NLjJ/JpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/XlRJ5XVO6I3D+iFohX2z//GOiSgnWmkXrqIoZMZHc=;
 b=dSu1y3uzJ9H+oF5nleNT342mVx0mt4GTdf/Rj5KExWQFm/CMPub+x4nkHSESBbUapfalqXjB7iLr67njLCd0f3ffXGttx/dJGDUgkVmgm6tz7Cog1Qziv1Z1D9nEc5yBrwnTn/CLaJD5MdtbLGNXi867BckrypQbRktUMj0WDOguaI48VNGKgnkI3247phwY5J0238QpXOzdRNWZOhkZ1VTuhbgxBBbA/zHwxEimkZuofpGChMY+MwnX+c3hRch2qBswqS93tqBiPTqMXZnpsRMPx2WKYKzTo8IRgJr/BOwkWchs63o3AR49z0/ixR3PbYQpQRS2fKz149H4Wha6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/XlRJ5XVO6I3D+iFohX2z//GOiSgnWmkXrqIoZMZHc=;
 b=vqYeM6F/91pMgU/ZiIPwAf0OguKti0DgcZNsHrJDFdCStsdnd1Ji1zgV5BGbJ7ZxSI7z6LQqN3ZTsMdPppvAAKzKX5TI2Q1ui9KnxMLfxmFFfxk9F3AFfHfdbosaAozy1ld+mBde4aAAZG1eQ8jfmKNBoVnNvu3JX9lBfxdzV28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:33:42 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 06:33:42 +0000
Message-ID: <86d39d52-fcc0-4215-8b68-ea6e526c0a01@amd.com>
Date: Fri, 6 Dec 2024 12:03:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V0 09/10] trace/kmmscand: Add tracing of scanning and
 migration
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
 nehagholkar@meta.com, abhishekd@meta.com, david@redhat.com,
 ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
 hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com, bharata@amd.com,
 Hasan.Maruf@amd.com, sj@kernel.org, willy@infradead.org,
 kirill.shutemov@linux.intel.com, mgorman@techsingularity.net,
 vbabka@suse.cz, hughd@google.com, rientjes@google.com, shy828301@gmail.com,
 Liam.Howlett@Oracle.com, peterz@infradead.org, mingo@redhat.com,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
 <20241201153818.2633616-10-raghavendra.kt@amd.com>
 <20241205124645.0d56ea57@gandalf.local.home>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20241205124645.0d56ea57@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: a74f5557-48c8-4596-196d-08dd15bfed62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHFJaTZaVlhqSzFUTmZEYmI1Y2NGayszd2kzN2VISUJLSTBJd3ZOY1hodkVE?=
 =?utf-8?B?eC82VmgzN25qcXRKaStQbDdxcjE4NjdQRWhVMVUraDBEVFZyS1NGbVE0MkNr?=
 =?utf-8?B?TDcwZHBFUjY4ZjA3MlN6RkIyQk00KzZadDB6bFdzWmNPU0lLV0NWeVJFMmNs?=
 =?utf-8?B?dW1hSDVnUitKOHp6ZER6WXM3ZWhTYnNyRkFFcU04dDdzOXNGQ0w1akk2ZWtB?=
 =?utf-8?B?R1FNUC9JWlg4NnE2NlhnKzhHZ3dtNFRHNEh6WEJJdXp0OTluUktEZUJoL1k0?=
 =?utf-8?B?R3hCSlVtcVdueVdEZnI4UzRYWDFXcGtIeU4xalJDSHRoUTNJSitwOHhNUUZC?=
 =?utf-8?B?OEhJUXBlOFI4SVdzbUVIZG16eXRpaGpTUDRYWEh6M2dGeVhQVVU1Q0lGaW9Q?=
 =?utf-8?B?NXRCYVkvZ0VjaDdVei9Zb214ZzUwZmpaczEzLzZ5THMvYVAyTnpscnM4ai8v?=
 =?utf-8?B?MVZucnc5RlM2NU91ZEtuenJoZVBLMGhOQ2xxSVhXaE9SUVVwTjUvbEIzVk9V?=
 =?utf-8?B?OTVWNEowdTQ1ZWhmdGpoWVhLclQ1MEdhUEJreXBVYjljeDV1bVBTZE5wT0Ez?=
 =?utf-8?B?VmNtKzJnak1IKzVxQ3lPRDNMRzdDV1hta1R0ZzF6YlJSVUI2S3pzUXJrU1ZL?=
 =?utf-8?B?VlgxY0dJY21Ya0ZXeEhIMDZOdmhDdEdlVyt1Tm83SEQ3ZzA5elpHUW12TG5z?=
 =?utf-8?B?ZWFkS1NVdXVSK0Q4MTNwQWk1cGxhYzIvQ3FQVkdUZmovcXMrWHIxc2xEdmxm?=
 =?utf-8?B?bnpuU0h6d1lKZ2NmVlh2RDRVSG9KamwwUGJpck5IUS83ZzEydGxzZlNFM1pQ?=
 =?utf-8?B?eE9pZDcxVUNKTUsvRmJQcWJCTDE5YzBRZHc5V2dzWmlUdVdWT00wNE9ibFps?=
 =?utf-8?B?SVZ5NUdkK3gzd3V6d3ZwWmh4QnFlRm9iV0ZTTGQ4a0d2MTBtOFF5cjVuSFBy?=
 =?utf-8?B?dFdQVnN5MnRCbUZJQ2lDbThHSWpEYkozay83VVFrd0x0K2lDVnNadVNmNHdp?=
 =?utf-8?B?bWdRb3JPZFAyZ2xqYXdTOGp6cHRmTEJHTUZ6bHhURHJxNmlVSXVidGVTajl5?=
 =?utf-8?B?b3VTaXk5OGtoekxQUlFodFVYTG04VkMwQTRobVVzVExKQWNTb2tpRm9Idll4?=
 =?utf-8?B?MzVVbE5hUUw0NkZiM2toZFFjNzRNSDFTRkRRM0o1b0lkeS90cXMzbUdwMWhp?=
 =?utf-8?B?NGlVZ0U1dTJ5Y2lURnM2UWtvVXlhVWRhN2hUa1R3RUhMenRpVzY3Skh1VXJ2?=
 =?utf-8?B?OHhEMGtzdFJUd3ZXVms1NHQwenR3ZHVYdXhmdzNnRDR2NktoM2FrWG5BQTVX?=
 =?utf-8?B?UUtpNHgzczdScGRaYUtOenJrbDdTVHhoRDdveUFkTVhHaFhKYytCM09POXpW?=
 =?utf-8?B?K0dMNzZDOEZkQXRkbG1FaDZ1bW9lK01IUVpYYzdtRjh3VWNyNU8vQyt0YTd5?=
 =?utf-8?B?aVlUNnJ3a0xxdlduUW5mOXB0dUJaTllQakVncmQyQ2JCd0QyakozR2xYZWgx?=
 =?utf-8?B?M0V4RmU1UGh6bTNRNG0yMlhtRkFkTEhGNWJ6TDhhKy9yMGdSczZhY2ZsTkgz?=
 =?utf-8?B?Y0lxT1lGNHNld0k5emtGdTl6SDU0MGt6MFJIQWduMUFjNzJsVmdocGNJaU5S?=
 =?utf-8?B?RDJ5NU9rcy83a3dIZkdXTzRtQVhjSHBhaUNvOEVGOTR2TEl3NE9mUFNKeTli?=
 =?utf-8?B?N3JvREtPRnBrYVdDbi9RZ2pPNWlGNGdkUFp6bC9DS3V6bUJDT21EUkZlekth?=
 =?utf-8?B?anFaMnh2VHJzWTd2Yk5lWGZnNjRrWm5qNVI1aUMwUVEwTC8xMFl3Wi9sdDh2?=
 =?utf-8?B?UlJlTFkwbXFmWG1Mc2VXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFdrOVoxd05PNGNZUFpBbXZRSFRmU0tRd0JLTnlxa0Y5VWV4WEZBdzllZGhp?=
 =?utf-8?B?S3BPMUZ0TnJ2WXlQQTYxbFBCN25RSU90SytnZ2h2T1JHU0kyRGV3czZYNUdi?=
 =?utf-8?B?OExocDJuOUYzM1hDZVdBdi9DUFZWZk1CSUgxekZBMVB3dUZvVEdqb1dvV2ZZ?=
 =?utf-8?B?UjBteDFrczZURHp1VzlGa2hJR24vcHR5RkxBUm9DeTNoVTQ5TVFZV1ZYdHZ5?=
 =?utf-8?B?RUtFQUJ2UHdLaDd3WExxVVQ4ZmxhNTgxRkxPbTNMUzMranJRM2E2QnhDZzlN?=
 =?utf-8?B?R09DbEwrd2RMRjNjbFMrWmVaTGZHbG16R0FGcWhacmx1QkRCc3VubzQrNitj?=
 =?utf-8?B?bHYreWw5dWxpcjI3T29YVEkwVnBPaXBPT29JVXZvbkY3cjhNTGxhSUNmK2E3?=
 =?utf-8?B?MTNteUQxMGZNZWRMVEVOQ0ViZGlsQ0VBTXVWWmtUZy9ONWhkME1XYUVVZ0Nx?=
 =?utf-8?B?M2pCbFE3eE9vUmVkNldiRW9hS2h5cVB2cDAwWStWcEJ3S21GQVlXNklyM2h0?=
 =?utf-8?B?YjhlcThtR2RXTXRFV0FhMzJ6RERsUUNOTHlINGRCYkowUzBVOGJxQ1oyRkZr?=
 =?utf-8?B?MzFPQk9IL2t4Vk9NMmY1ejBVaHVFQ3pWS3RFYWNwV3hXb1pEQ0orL3RLMGcx?=
 =?utf-8?B?QkNLcWoxTjBPYzgyaXA3UlgvOFZGZlJYenU2UFZoVGNIN2VqcjdkSHkzVTFB?=
 =?utf-8?B?WmJBa05VNFZTNElGNDlyTEI5RjZxams4VllyK1NrWGtBendNTjZyUVdDK09B?=
 =?utf-8?B?OUh3Q2laQjBiZGloQ2lIVjJVUmgvazJaM0diOGg2NnVnbVdYZ1BMRUgrNlBq?=
 =?utf-8?B?cUZvYzUzWWNpSUJXSzlHNkVzQzdQVEI5Y09nSVBmRW5vSHZ6bzBUQStIdUZw?=
 =?utf-8?B?dlhwRHp2ZTQ4cFRvSnM5VisxZWFMMmxmTDJJbXNPOEEvQVZjM0xMNk5FRlp0?=
 =?utf-8?B?SWJwamJ2dzMxa1JSZ29PbUZDZW8vQjQvZWNoU2xZOWx4VnFVVjBjRXVnUlBt?=
 =?utf-8?B?b3pyczArQ21pQlJwcE0xWGlaNHZEQ0YrcjhoOWM2N1NKdzd4dDVVSzk2anh5?=
 =?utf-8?B?WHFCOVFpOWlBcWQ0TnRyTDl6cTdwQkF0QzM2d0NYT2xiakZwSTVQTVhQNi83?=
 =?utf-8?B?d0duU2N2Mkp4enduSEw1czZsVURPZmh0NXFiY2hwMTlMeGJFbHVCdjIzVVFN?=
 =?utf-8?B?bzMzMGt4eXJ0TzR1SUg5cGdsSWdMOFdoSzRvSkdTdFBjOXYvMHNsVjU0a0dE?=
 =?utf-8?B?aysxb2tBT2Jub3hma1VhMnlobTdLZXJHL0o5Wm53TlB0T1lsUG1yTHVKTndH?=
 =?utf-8?B?NXphZnpOa0IwVUl4cmhicE9ndDB4Tm1kaDZzVlVPUFNRRFVqVEpoZmtCdjJv?=
 =?utf-8?B?R0E1VEhSYld3aVphMnMxcFo0Uk5RRGtWR3BhVyt6a1BVMXIxNkhrUDhsbWpI?=
 =?utf-8?B?cDIrYm14TVBGNEdpNkFiUml2eXFkRjYwTlNHRzBIVStvSkFFS2JEMXBxUkNk?=
 =?utf-8?B?QWhkWnpoZEIyTE1iM3pISUtCeFFyeGdoU3RDSFN6cWVvVEQrN2V4Y3Zaakxa?=
 =?utf-8?B?WGk1N1A0MXdYRmM0N3orZTJZbFFjTXIzYkN6WUJlUnBra2hPRDRnYVpRK2tI?=
 =?utf-8?B?c0VZQll2TStlMm40S2lwVkt2RzVQdSt6Nm5IZlNqcG1MbDZKZnBuRWd4L0Zz?=
 =?utf-8?B?dnplSVFibnZpT1g0bkFQSVBVMzlLdXRqVXYyNzhyd3pyTC9DVEk5ZDlUU0Nx?=
 =?utf-8?B?MUE1ZGZlM1M1YUhiWkpmeC9DSnFPd0hlbDNRTTc0Mjk0Y01KUjVuQXJNNWVk?=
 =?utf-8?B?dkM0eEFJSVpmbnJTWmlCVjYxVmJpaWZDTDNMeWFjRHZydjI1TERVS1R6RmNE?=
 =?utf-8?B?akJHMDVjM0RtMWVRTitkYVBIdnZJTU13Qm1ZMkVWaEtyMy9ReWpqVzlUZERq?=
 =?utf-8?B?Q2N3Z3NUb3NuTFpnU0tlVXJXV1ZDRHRvUk9kL3o5cXRDYU9jSjNEK2VLYXVq?=
 =?utf-8?B?M2NLeVZtTHRWdEwwRFl6MXpPNXJJS3p2WjRLWEp1RmRrdStLaGRCRE82VkI2?=
 =?utf-8?B?c1hJaHkxUldvaTNXZzhxSW1rTVZXaXgrNkpZR0x5NGNwTW1DVlJHb3c5SFdC?=
 =?utf-8?Q?bmyFaKETI2nqVprYx8bevMGap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74f5557-48c8-4596-196d-08dd15bfed62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:33:42.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/e9VaO4Glm1+6AXSjRldSIlrF81wejS9ahF3wgiZyGrTdO0cDy3NM3e6vraSDGVpGvvpb732+l3OS8q1tvQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441



On 12/5/2024 11:16 PM, Steven Rostedt wrote:
> On Sun, 1 Dec 2024 15:38:17 +0000
> Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>> Add tracing support to track
>>   - start and end of scanning.
>>   - migration.
>>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Masami Hiramatsu <mhiramat@kernel.org>
>> CC: linux-trace-kernel@vger.kernel.org
>>

[...]

>> +
>> +	TP_STRUCT__entry(
>> +		__array(	char, comm, TASK_COMM_LEN	)
> 
> Is there a reason to record "comm"? There's other ways to retrieve it than
> to always write it to the ring buffer.
> 

Thank you for the review Steve. The motivation was to filter benchmark
in the trace to understand the behavior.
I will explore regarding other ways of retrieving comm.
(or may be even PID is enough..)

[...]

>> +
>> +	TP_printk("kmmscand: scan_mm_start comm =%s mm=%p", __entry->comm, __entry->mm)
> 
> No need to write the event name into the TP_printk(). That's redundant.
> 
> Also, the above two events are pretty much identical. Please use
> DECLARE_EVENT_CLASS().

Sure. will do.


>> +
>> +	TP_STRUCT__entry(
>> +		__array(	char, comm, TASK_COMM_LEN	)
> 
> Again, why comm?
> 

Will do same change here too.

[...]

>> +	if (mm->owner)
>> +		trace_kmem_scan_mm_end(mm->owner, mm, address, total,
>> +					mm_slot_scan_period, mm_slot_scan_size);
> 
> Please do not add conditions that is used just for calling a tracepoint.
> That takes away the "nop" of the function. You can either use
> TRACE_EVENT_CONDITION() or DEFINE_EVENT_CONDITION(), or you can hard code
> it here:
> 
> 	if (trace_kmem_scan_mm_end_enabled()) {
> 		if (mm->owner)
> 			trace_kmem_scan_mm_end(mm->owner, mm, address, total,
> 						mm_slot_scan_period, mm_slot_scan_size);
> 	}
> 
> But since it is a single condition, I would prefer the *_CONDITION() macros
> above.
> 

Very helpful suggestion.

Thanks again.. I will keep these points in mind for next version.

- Raghu


