Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982A20DD51;
	Thu, 18 Dec 2025 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037331; cv=fail; b=KaL9MhAO/g0ByHnlNxWCK+gec4LveRFiESD0Qih9zp/TMDNokTKCQMV59avSNdinH4rCphGp4yE/Oi5DRrWV6muwF5Nhagn++67xJ073aktCBMo1zd27XVWT8/ErC71eFljiGx8rN22roNApt+vaHxrYLfFxnknAmvPyKaCea8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037331; c=relaxed/simple;
	bh=RwZj+jywWqoznbJ0PLxy4Ga+lu0SoPMPBGLaCspEtus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ILuTeG5+NBlyGi0/x64/zGxUot0w5jCKesaPfILbrdJoNrHPX8AFRrGIQsLNZDruZsZQFVZvQYcDDYKuVRpbYNdMTyU5T3NBo8dkL4i/xUis9NMw9vKkgFFkBQMri9uODoCX5nbz3r7BMGgtKUkfpIpLKm90vYCi26PB800nrks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BgbpAkrp; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BgbpAkrp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6hjm1xddv6lTYWRqGbUn+Mci8NSVoZFhXpoSQux0nME/uSCfRvGkRdbZzcpNvoOFUqb33ZC/Dy9wCcb0mphwqIbVlm6mpCE+e/403m1t91fOmlkkL3YOLcp2VWH45F6RG1BcB+cbSH8ENJa5yDP1WaAXzvS3WWZa1pkayXiwcefaK+aUZTmlmoeBkyIzma/4k2aCR4AVidNdNby+fPhdNQ1/5xntiKTyPJu4c9Tf2gqqVAXqCTckwhgjppbgrM1mmp0ilNDP6EMkTQJccayn9rMc+vtYr+j4nm2qd32JrqOZeCMQjO+wAoe8vEAOnm2nUBEc87ItCooMCS5K9scKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpthoi3Lr2+b0JuPpAwOn9AAG/xyFZazZl9X2h6hsX0=;
 b=U3RoOYv7VUgvTerGNLcIj4wxCCn9ucj9gU4NZBGw4VbNIN1MyoDu/Aaz0e+6lykAMby5PF3aLmDWh9kXFSdtCR4oErpH6f4+d1nxP24UYWbZ3X6Pan/UCRlUGs0msbPlAL2rMsLoWJbaHl3jh6jc4RhpS3TUwizLuYGXrp7uL40QzSxHWrEMzfRd1neOjJFXu7g8njfbd4vnMjo6KBOMZMyF8l724RzpBmFqtpPVQ3LtYW7VwQ3d3VaJ/LBEpvZrrC5No7uKpsdhXBCf1ojHjhVzr5q06kLOsKgacEmKoMxRfp/sBsgSBVTTVDTk2fK/AWtLihz0wb6ZskRr9i2mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpthoi3Lr2+b0JuPpAwOn9AAG/xyFZazZl9X2h6hsX0=;
 b=BgbpAkrpmUJ1t39Z95UZrifeg6wOgD+GGiO8BzW6yZIz6x/ihtdnyQJd8qwhTPIfX/hNXXqxBeVM5yZEHXCq8yeG1NyZJfnYCawuxlqCqH1aIzFraCwDA3VNs3RV8MiaQL/7cSKkNwX9MqL5Qb9HvaJ7cFpY+gsCqEkyO6w4mHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 05:40:12 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 05:40:12 +0000
Message-ID: <79fb5cb2-8a24-4260-a9e9-bdf2c5ef602f@amd.com>
Date: Thu, 18 Dec 2025 11:10:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/khugepaged: use enum scan_result for result
 variables
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-6-shivankg@amd.com>
 <D9E6B402-528B-46F2-B4B0-9CD9549A449F@nvidia.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <D9E6B402-528B-46F2-B4B0-9CD9549A449F@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::14) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba1562b-91dd-4d87-2520-08de3df7e9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckc4aWZPb25PZW9TM3I0SkszS3FoZTlpVjVuYWlNOGVSTVUzc3c1c081ZzZo?=
 =?utf-8?B?TG5WejlIZC9pMTFyYUc5dFNoL2dTL3dXRmpBSjlKdGk3cUZQTWZNdC9RTTM3?=
 =?utf-8?B?S1hQdGt4aDhId0J5T2NrWENwSit0T1lYdmhyV2ZOQ2h4NGtIQXFreXk3SWdh?=
 =?utf-8?B?VzJPNFRqMTkwb2NLcUM2bk02d3k5VlQ3Wi9VMVpsUTMzcnVGNitSVzlXRndz?=
 =?utf-8?B?YXlydi90R0RYTi9tNWV6ZElCZUdudy95U2k4R0hFc3Z0WTR4bnVtQlB5L21l?=
 =?utf-8?B?eFJlRW1WOU1KUlFXWkhkbXdJVmFrNXdnS2kxWHAvenpYL0ZsQVh1TDYyU0tT?=
 =?utf-8?B?a21TaUJUSzRmcmJhV1Q2R3J1Tm4zSkVHNnVXMFZ2NGVnRURpajd0V3M5elRp?=
 =?utf-8?B?WjEwam1DWDVsZ2hjZHdVK0ZjVGNpZ1o2bSt0NVhNNkEvdWpDSjN6WFpCalZw?=
 =?utf-8?B?L2ozVTAxTWtyTEo5WjhaOWcyR3NhS3l2Q2liaExueXpBRFRvWmF5enRzSHJJ?=
 =?utf-8?B?M29vbGFCTncrQ2pNdWpqc1gvWnhWKzNNbTExNXdKR0J4NWIwdGJGRlVKUGtr?=
 =?utf-8?B?RW5OejViZHJXL0Q3ZjlDT3YwRlp1cExpcktGMWZFRktwWUd0VnhLNERxYVVs?=
 =?utf-8?B?dXp3Umpla3p6Ny9kampRYnprRVhBYjdXTk1qN2src0YvaHNmczV1ZUlxdm1U?=
 =?utf-8?B?My9FMHlzY05ONGpCV2pvVmF5emZFRU5ldjE1ZkFZSmorZGE4NEovWFBYbDA3?=
 =?utf-8?B?MnczNEhKRDlRS1pyc2NQaFdjQ2diZVRhMzREZEk2M3BwWHN3WjllcTNOam9n?=
 =?utf-8?B?b0JWK1dxNWtvU2Frdzc5RnpKMWZ0Wkcva0ZRMTNYOVc3OUZmTzZ3VXVGWFB5?=
 =?utf-8?B?OWFMYWFBVndTQVJHS1NOS1pNdWp1WjJLdUFhR3R5dSt1R2trRFJWejdNOXhO?=
 =?utf-8?B?OWttaTFTWTlJejcyb1pPcnlFdUJjVGFKaUZ2RkI1M3k0TGowQ05KTXdoTnhW?=
 =?utf-8?B?L0hTQy9iWEt3S3E2d3NpTkJoeVpVK0JneEZ4ZnZUWFFkb1ovdTBXeGV6eHhy?=
 =?utf-8?B?SVdKRGFiTWJVN0ZuRzFJMTV6MUxvb2xwVWVNRktVbm1VMHhnYUExeWFpbWVR?=
 =?utf-8?B?OFQ1dGppc1ovTTNJN3FaTk1hV2VkR1d0bkoweEt3U3VuL3kvYmwvNm96T2lk?=
 =?utf-8?B?U3dkd0J6eHZLWGxFbEZ6Zk5McGtJbGUvMnRZWnJaVDdGMDRQVXhSai9nU1Vq?=
 =?utf-8?B?a3Jza01yNVk5NzFMZ2diakhpS2J5Mkh0UXhYb29JeHE2b05HbHhnMlRUTy9M?=
 =?utf-8?B?N3hUV1lQQlZDamVpVkkvcXVMb0Nvem5QS3I3elVkMlROMlpLUG1SMDhwS0FE?=
 =?utf-8?B?T0xHUmZWbVh0YzhjdDlPMmhKanpVYThMV0FMZU9lMU50b2ZuOHFkb2tLMVlz?=
 =?utf-8?B?U0JyUnZqNXZRd3BSRDJabHhQOXU1N2FyQk5lb0FQRHI2TlpCVklKaExlZVRJ?=
 =?utf-8?B?cm5LTWZmMW8vVmJlMVA0V0lFTWpKeHpNN0JrNm82Z3hRUG14L3pGbzZ5VFkv?=
 =?utf-8?B?a2NtOGJrWFFreHZLN3ZQclFNaHVPcEgxS3J0cGN6VkpMR1hGMURSd0xpbXJS?=
 =?utf-8?B?aFY4T2J0aUNxNmZvTlkwalpua2dWVDIyTGsxVzdVNEQ3czZ0Mk4zUlZMS2Fr?=
 =?utf-8?B?TWRQWDZJdVFldkhEdUd1elRjb3daZGlrSWxRbTRzRWFWUkF0aTRqSXB4c0dP?=
 =?utf-8?B?TlBqdFQwSjhiMCtZaFBJVVVodHFpVEpMOU14ckgwbG1mT25pdVBnenQrOUNE?=
 =?utf-8?B?cmVoSENJTER0L3NGUWRiY1lUU2YrUS8zUnJDdmVQaC9PaVIzRW1FWWxXYm9u?=
 =?utf-8?B?QzIvak83RlRzL0VXMGVmSkVIMWwrWHY5SmdlMTVkdllLenlTdHRySG5XQVFC?=
 =?utf-8?Q?RT1UJ/90caAHH8xrZcEHz4HjQV8DoENC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkdZLzVyUXFCTTVwV0lxbXNBTmFXNFRxaEFtZWZkMTZKbWszUzZoRWFNb3ZQ?=
 =?utf-8?B?Nm85Mjc3UzBaMkc3UWd3elVNUXRYZGJLRGdmUDZmK0V2VmIyRFJBVmxqVFJq?=
 =?utf-8?B?alNZa0o5WWtlYXNCN0RvSVF2T1ZYcHNJakFhY3FhZDlqWTZDTGdkOGl4NkEz?=
 =?utf-8?B?SGI3OXBpTGdmTUZ4TVAvMklxYWMxVzVNZnNWcitDY0lyR2tkK09NSjhidi80?=
 =?utf-8?B?UW5NNk5lSUtQTTRHcUZEamxnTFVkWEMvTGRwZG5odW4wRndlTHY0OFhqWW5h?=
 =?utf-8?B?WHYxQ3RiVTljZ3VVcG5qQ1EzM3RqSkhMMEFpZ2dNcjVzR1JMc0l0R1NLZThm?=
 =?utf-8?B?K1N1SEg1Vk1mWDRBeVFnSnRIemoxTDUwTE93Z0JDRjJlOTFXT2hvNGVQZG5p?=
 =?utf-8?B?K0pSZWhxZ3AyODZGOFVBc296aUhhRFNrbDd2TGFJdU1IaktzTmxtZFljQmtH?=
 =?utf-8?B?NVo3bGxjcHBaeDNiYXVFRzNEWWNTODJIZFo4TStidUJQRVdFeGlkTEdrRXd1?=
 =?utf-8?B?QnQ5NTRja2VDWlNMT0M3cG9sSHAvYkVZSmdRc01hTUUrdXNXVy83ZjNzUWw2?=
 =?utf-8?B?dVN4NlN6VTRuN3ZaSkVjV3AxNDZYN1N0UGhnVEpvRTBiNEpadTBXbmMwVkdS?=
 =?utf-8?B?Y1dnWWx1cUE1ZTZDUWlxVW1lbi9OVm1ZeEtiU0hmY2h1SnNGdm9sSmJuYmlP?=
 =?utf-8?B?Qm4vaXFiMXVUVkFkMjVPNkVkMkh0UGllOWY2a3ZNRE4xQ3h1RzdGTjFseXR4?=
 =?utf-8?B?WjNKK3lvK0d3bzVOc1U0U3VtSWFlYTE3eGVRbDFyVkxlbjEvSlNhM2YwNU1N?=
 =?utf-8?B?QjBYNDN4TFNKS0NjaWJRN0JwQkdGaE9mSk5sWnhaQ1M1bWdUR05ZcjJhSzAy?=
 =?utf-8?B?bDlZVFZHaUllRHhOT28zYXdpRHdxTUhXdERDSjJ5MmNQSUtRajBSL1F0amVv?=
 =?utf-8?B?a1FKZG9rUEFLdHVHek42RUFERm43b3BNRzhPMGVodkU4VXhnTG1hM1ppT2p2?=
 =?utf-8?B?WXhPVnNNN0w4NUtPelZCa21rOVJzRnBPNUdSOEQ0U3Y3eEJjb1lKb09OYkE2?=
 =?utf-8?B?S2FUKzBDbVlDOHE0Q2cxbHluMFBTYWhQWWZLNTR0UFo3ZHV5RUZVL0ZKWmhu?=
 =?utf-8?B?bXB5OFJtR25pK2ZmTTlEb2gzbWo2S29uK2dYMmRzNjE1QWo4K0thNU1uc1Bq?=
 =?utf-8?B?T0xqQnBtd05hVDYzNy9iajAvYlJRcXZnZEpEK2hzK3hQcnNmS21wWjJpNHNP?=
 =?utf-8?B?K29IM2JZemJLNHNjelp1c1RQZ3lEbEhNeENITHN2ZEpmTFkxVE5xak4vTVRO?=
 =?utf-8?B?WngyU29zemZleEpMbVFZTWFQcDNndzUrd0IrRzZTdVcwY01tbmJ0S29MVmVC?=
 =?utf-8?B?VnZOUmYrckUwNGx5WFNxN3VneHJzUExCWnRjVDhQZWp6TkMrcUFJZEwzdHp0?=
 =?utf-8?B?NkduZ2MwYVlVdmxUMjlMQnV3MHFwdURSYzJmRFFTTy9wVFlNV2N4Z2pNMlJ5?=
 =?utf-8?B?ZUludXRjMjFDUkc5SXAwTkNpVDJnS1VaZzVXOFJKUlAzUjRZSHZHa3VNWnlL?=
 =?utf-8?B?MHVSSnZYRmFMY1BVbS9JeGdrbGkxWklYNHRBbC9wank5WUN3dVhXSGhGN1Bu?=
 =?utf-8?B?N2trOFhUVXp5L0NOaWJ2UHBSQ3YwaXVacVNVdllSbnVQaXk3OWdXMHY0czR0?=
 =?utf-8?B?NkhrbnBYKzBDUDFncC9PcDBtN003bC9TLzZGdFV0bU45blRtaUFtdVVzdVpN?=
 =?utf-8?B?U3JsS1IwZE1xMDBCMkVEa1NjekdxME11U0RrVlVsZEQrdjNvaGJVY2NZa3p3?=
 =?utf-8?B?eVkrVlZYK1l5ZFVGclVnUFJNYnFPdUlleE5OamIwV29vYVYydVJULzQrVnpR?=
 =?utf-8?B?U0JpWDk1Q29MSU5OR0lqY042RkNXazBheDV2MWowWUVCalBYMEVvOWU4R09w?=
 =?utf-8?B?empuWHBRa1U4MmllL09vdDN2eCtyRk9JNEN4ZXZ3VTFqSERIbFk5QURDK1l2?=
 =?utf-8?B?Q3Q3WE1IUTBIRVRoQzFjKy9HN0NvcUt5ZmNzTStjblo2Q2NZbHhSUnkvbERG?=
 =?utf-8?B?Q3lhWnhLbyt1MVJrdGp3d1EzbTBVZnRteE1VZVlxZTVZblVVY0lhNWx2VVZj?=
 =?utf-8?Q?iMIylVSIzBuuu5nQEDFkSjcN3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba1562b-91dd-4d87-2520-08de3df7e9fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 05:40:12.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BG68sTA8ynVMQbuVBLQpLfMy8P5+VqLmF7Iz9ea4DBDDfPeBg+XuHx6cxB1ou4ckTb4DI6bxhKMoCf7HD+ZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615



On 12/16/2025 9:08 PM, Zi Yan wrote:
> On 16 Dec 2025, at 6:11, Shivank Garg wrote:
> 

> 
>>  int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>  			    bool install_pmd)
>>  {
> 
> And here.
Since this function is declared in khugepaged.h, I need to
move the enum definition to that header. I see two options for handling
the CONFIG_TRANSPARENT_HUGEPAGE check:

1. Define enum OUTSIDE the ifdef: This allows the static inline stub
   to also return enum scan_result, keeping the API consistent.
2. Define enum INSIDE the ifdef: The enum is hidden when THP is disabled,
   forcing the stub to return int 0 instead.

The only external caller (uprobes.c) of collapse_pte_mapped_thp currently
ignores the return value.

What is the more preferred way for enum definition in such scenario?

Thanks,
Shivank


> In addition, the return types of find_pmd_or_thp_or_none(),
> hugepage_vma_revalidate(), alloc_charge_folio(), and check_pmd_state() need to be changed to enum scan_result too.
> 
> Best Regards,
> Yan, Zi

