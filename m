Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698433D6FD;
	Fri, 19 Dec 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146852; cv=fail; b=WQYL2H5yf2uHd0Mrps75/NKiurP5fzZJq9H6BcOWltHTKXtCFfER5lU8fIGSYQK9EMWhL8LU6y1MsgIYoIgygjT1BCrqmh4r7bHW4fnyjg2+AFzYVd4FfHEj6ZDgIiilTEGZa4T1BAHcGqU2YC0u4sRIURubyePyoesmsFNMC4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146852; c=relaxed/simple;
	bh=CrDlnx5sZP/JL+I3mHbVUfI9T+GEwfkXeHYjdPfo0VI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0BQ2RU8p9jo9sSSiIn79PWjwHi/QYanxOFEz9s7BfXCN9cXastioW0en39AO6iZ5ruysxlVcJEcLUBKGX/7FSjUBYxHGjYjGD6kqVBIN8JF5BC2q1RZAq1gtx2bDA4d5eXiFaefGgtTtCdD4xqs/8uTO2iS48k9dO56vNFMz3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vEao/xh+; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vEao/xh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwC5AMC3KjQ1fhqr+iDSTnNdvHaWO/fpy4N2dlxMmaSU+F5LG7kUO7sWpIAaw47R0mpf0gIs1aMZLhEAE7e9uF0y65DKlZuBPRi538zJhcrnW37+8P/GxN25oI3ygYStt9Yymuws0s72as8m0ORmHNvE9TvqevtD3n8EKRxbWj1QqR5zZKJqyqLJ4IrrxG2l7crOe6woReppqepEcde+kEqA4zEEYuLxR4Y877PCcCpbq/YdkWWJaP1DMoVtRYwi8twiOj75VODdiJPApdL5BF88E106NmV1A0R8I0RHXA84SXmBVPjhTMGqc+fccoqX4iIZ/t4+FUtK2EdSAb+6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KJIuGsBLGLFteJtVGcFk9sKEQoeG1jtq6h3GPq/ygA=;
 b=DOT5jcIMwH5OvgMLvuZwWPylVm06c8Z8DNKl7ZKv+ROgDv70yf1cXYiZtnax9POEd3h2tu2/+uBvQx/Clgdc/uDk8Iwfj/YPDioFrhav8mqpwCgbsH4s8UNdaTgpkG4ZJ7kRpXRht9Vw4PooCKBvlFKCF6wUFicKn5w++lmQcezKyIKaOBdwXWkblDPscTJlORYbHi/65rhQGoOIlrQMELVhDtkGbDx7oAzXflf8Vtjq1mR+St0fc2hdeiB9mCVmt7ZTO4dBItqkMoMbJZJ27TCdmpL1b/LKQRZuSAcn/yXrloTxdqlwhY9qp9dZpU4g3AcWhIw6HUVRk3HGUX000g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KJIuGsBLGLFteJtVGcFk9sKEQoeG1jtq6h3GPq/ygA=;
 b=vEao/xh+p/1F3cdZ+aJXX82gLHDRcLxVFoF0XWIHZ50D5sk6Tg4IEySeisfvfMmin5hdMlG1/65y7x2+qPpSPowvIlGGGBEwBV89uyBhdvKr/0XFv7n2HqUYH7+sO104QITKiJYcWBao7QVFUMRXGl6Z3Kc3f+F6RJdhdVeRM5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 12:20:47 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 12:20:47 +0000
Message-ID: <32f3f9dd-f84c-4113-b356-01750b2af80a@amd.com>
Date: Fri, 19 Dec 2025 17:50:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
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
 <20251216111139.95438-4-shivankg@amd.com>
 <848E8F85-CD24-491C-8A3B-474E4FCBF995@nvidia.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <848E8F85-CD24-491C-8A3B-474E4FCBF995@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017D.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::48) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c346b97-a3d6-451e-2600-08de3ef90a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkFIam8xM2c3WTBVa0MvaDQ1OEtkZEQvWXJqT29DUWcyc2ROQ2JXQUlBVnNH?=
 =?utf-8?B?NEdUQUNmUGJWaDJBbVRrbkFmcG9VWnhrQ29TbVZ5NCtzejB2ZlhxVkpTeUo2?=
 =?utf-8?B?ZGtNYnJ1czBFRjBlMGY0QWEvOFRoei85V2NsRlRRTUFUV1VXRnVQNk9DQytK?=
 =?utf-8?B?bUhjTk4rdTlYWkRCbWpGelJ4YTJiUysvUEp4NXlPUGV0S0lRMmNwT3IxY2N5?=
 =?utf-8?B?TFk1WnBLVDY0MVd5a3FKSGxibmh6eVVHcXdKcmQ4WExiSGdtdmhhSEdLVWd5?=
 =?utf-8?B?Y0JkcEFvQUpJTDh0alpuaEptUm15K2JTT29kN2JnSWd2UDlpNWFoRXRMZlov?=
 =?utf-8?B?OE1LWXN4QXgrRkJHOHhFOEwydnJ2K0RiaVBxSnNka0Y5NW43bkREazh0SE5M?=
 =?utf-8?B?RHg1eXlhZGFxVUhjRE42QXZnbVI3Qzc0NWpuMUVWbDZqWTAzQXZUZlFSS1Yy?=
 =?utf-8?B?TlFFSWJTYUd6akdQODdrYm9TaE51UTFqMHhEbVpTczFBdVVWUUJva3ZqRXhm?=
 =?utf-8?B?d2lBclBKMDNjRFpjQUJFaWpxaVR0MXhrUjZBa2dOQ3ZOREhReGpuSmlNbWx0?=
 =?utf-8?B?S1dvSmtQV1lSWEd6cDZmOEVucGIyaDRlVXZFRjkwanBKU2RZb01yRHg4Y2Jx?=
 =?utf-8?B?SVFZa1laRWU3SFFialQ0ZWpEcFB2YkhhYXBqNFdkclJtbCtBWmF1eTZpVjEz?=
 =?utf-8?B?WFlsVlhLeDlaaHhsWkJEaGRXV2UrRTEwdkVXTVptWHVhQXBvV2V2Z2JzQ3dR?=
 =?utf-8?B?ZU9xWlo3QkhxOXBwMGZhT25LS0N1UnRmYklCQ2Yva0FLcmJ3YWJqZE5jdVds?=
 =?utf-8?B?QWoyNnVhQnZqSHI5QmZpN1hmUDNuUFRGQVZteFU4Q3RqUE1uNS9qblV5Smxl?=
 =?utf-8?B?cUJqUUFoU21qR0Q5MjFyU2tCZEFsckk1WUdQcENXdTFIWlM2RnNXL2o2MU90?=
 =?utf-8?B?Ympqek80RFJXbnVZSUFkQXVmSWJCMmh5aFkxQ0pxbG5pbTJaQkZacVNVSmcr?=
 =?utf-8?B?ZW1mZ1MvZ2tyb3lOSnc5aFgzZjZ1NEVLSm5Bem93Wk1YTWE2ZlJFMklPblh2?=
 =?utf-8?B?TkRLUnZuYmcxQ2tjWVRhOXVUMm9scFlVdFZocW44SkZNaUgyZVNkMFNaTFJh?=
 =?utf-8?B?UDdRbzdNbCt5emsrOXB3THl1cVhaL0kxdURueERoSWN0S1M2NStyWHIxZG4w?=
 =?utf-8?B?c2VxMThPSHZqa2hQeUM0N05EY0loTlpJK3lFbUFRS3NrQjZNbS9neHllRVRD?=
 =?utf-8?B?aCtzcVBjOTZ3OTNhTDg1UGhyK2hJVkhVbHE0aDV5OU9KcEdwanVYTWs2OS9C?=
 =?utf-8?B?bWFCMjZPK1BCTXR2bWlzQTlaV29Mc1FlRzFxb1gzemdvNU9SK0V2NytjNnlU?=
 =?utf-8?B?amluYVI3UzR2QmxqbVBZTkU2WUFtSzhlK01wYUFhczlBb09KOUJzYkFmQUcx?=
 =?utf-8?B?T2llY0w1Q1VXOUxoWk5LMFF2VWw5aDhjSy9sT0V1UnE4S0JvTzVkVVlKSlN1?=
 =?utf-8?B?MmNnMjhQeVRuQzEzS3dzQjdkK3k5S2FjUEJPMnk1TkJKb1o3Sm9Va2hIdWdj?=
 =?utf-8?B?M3J0TnpEZjhHdm9wRzdCc1I4SFBDMXhFWURPc0EwZEk5d3pCei9zTmc4cUlm?=
 =?utf-8?B?Zk5TcU5Mb1lrUy9jSVZBeVlGSStvejdraEVWUUwveHp6bWhpeTdnT0UybzZT?=
 =?utf-8?B?aG1aN3g4dTk1a1NweS8rYnAwMW95aHRUVEw2b2MzaFVRb0pYK29VaEltbFdZ?=
 =?utf-8?B?OUZYTUhiM1ZSWFUyN3NYQjRReVVrZGgvYW1nWDFtTmp3SHhiMXNsaDdmV1RV?=
 =?utf-8?B?RDdFYSticjBFQnVPUGZYSk80bHFES1VGOFJnckR4SWp2Z09RYS9zcGVGMjJv?=
 =?utf-8?B?THNZMyt1RVNJYk1WMmZ5T2dYK3FnVlN0L09IajVXVWNmYTcxdFhRN3hoekt2?=
 =?utf-8?Q?olX01a2E9UVcUfNWeHo6J/9ECsp+1hJS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU5MdzhocGNmK28rUE4rN1Fvc2czc0dHWks4VU5MdnpxM3FYaGtXNzkxaGZ2?=
 =?utf-8?B?dXUrUTBoSnlGUnd2U1FmV2kvTVZYVHladTN2b0NCTGNsRnB2VWI3Y3VhVS9G?=
 =?utf-8?B?U3lZQWtlN2JZOTB0SDc1ZnNjTzIyb0JCYThtNk9uVU5yeDRJR0oxWmNkendy?=
 =?utf-8?B?QlRXTGJqRmNsb2J6d0EvNVZRSlk2MU9aQkpvODlNSDFGS0Z3eVNidnRQMkoz?=
 =?utf-8?B?aENTVkpzNXVwZnBrNnpzOWFtVVljYWNMUnJNRnBrd3djaUF2RHRKb2VySjlW?=
 =?utf-8?B?L3lFNXlGMEUzSFFoVDhVZXNxMDhlZ3dyVXZXdGVmelhIVE5UcXdxRDhXTU8v?=
 =?utf-8?B?aGZYYURtSHkvdHdlSkhEMjFsK2RRZ09hQWJMV3A4Ny9nZUc1MnV4bnc4a2NG?=
 =?utf-8?B?cEgzNjVkL2FFN0cxL3ZablBPZE5kZStvQlg4NFdtdHNFWUpBWFFST2JFeTZi?=
 =?utf-8?B?eW5XZDByVWxVRlpvbGRmS2hUV0RDbFA1UGVaOHlacEFBVDZ5RUI3VmdpTzlx?=
 =?utf-8?B?SGZpQ0RzZ0Irckw1YUcweXFhbTRBWko1dWs2UzZjQ1BRZ3pkV3FwMzEvODNI?=
 =?utf-8?B?V2JOaGEweG9DZlNRNTVDLzlxYk1LbkhBanBSMWV5bzZ5VFBiVkJkWjRJR0tU?=
 =?utf-8?B?WVBGWXlBRkV1Q3lTanIvaWsxQWNlbTl0T1NlWUtjc29nRkluSEMxVUdtSWRr?=
 =?utf-8?B?RUNkdHNLcFMwR2xDNjlTaWZaNmhXSlpLbEhiYjI2amhqODQyOExlcTNqcGJa?=
 =?utf-8?B?MnZkWGFwTnp0RFluVFlHWWI5R3orcW12NGhHVERBRU9hNUtXM3g5d1RuUlBW?=
 =?utf-8?B?enNBZVVKWnY4aU96eXNaNUNVTXFsbklWamlZemlJemFFQ2hhd2txUWJBR0Jt?=
 =?utf-8?B?WnNOYm5pOHRsaHpMbHQvZHBuT01QWUtSV0pCY3VrSmdXVDFaWVkzUjJwS3ZE?=
 =?utf-8?B?Y2tZdXQ0dW9kMUhkQ29oRnFjZjlDTzFtL1BDMjFwM29BTmttdTJ4R05RSXNk?=
 =?utf-8?B?bTZwcTJYd0dOUDFQMFIzUDQ1OWw0ZkwxSlFNcE9aRlQ5T25SdWJqL3RSTDNH?=
 =?utf-8?B?UCtHaEVoL1BXU1RDNzN2QXAwVHJDQW1kaURyMmZjY0NZblNLYWZtZTIySE5j?=
 =?utf-8?B?bzUyS1JXbUZ5bmZVTEZSaE9NYllHNFpMUmErTW1qSWhWL2dzUGR6WWh3NFNl?=
 =?utf-8?B?S05KODlaekVLMGpRTE9YNElRVkQyTmZHN1BLTDV1MXNwaUJaRjJUSG1vOFh1?=
 =?utf-8?B?OWVqV1dJdUVRYnlGYnUvTkpMV1FaUXQyY3JKTHhWaHZIa25wMzg4aFpIMGdQ?=
 =?utf-8?B?cFExV2tINmhhZXY5YVFWSllDYWpkQk1BeVpsa042R0tHTXp3THJFU1lyRU1R?=
 =?utf-8?B?aFFYdG56ZFJ3NU12ZUFBSlVGRndRTzNIdUxWekxZMXFyT3pYZHFqL3ZCYnA4?=
 =?utf-8?B?VnpXK0VHTkxhWVNkTE9HaDVKeU1pL240RFNSa3grRXcrZkY2dVd2MDNPLzc2?=
 =?utf-8?B?anZBRlRzR0xFSHBqRHVkVVFvdTNYbCtiTVRMd3ovcmpTRU1IZ25sMjlmSTJw?=
 =?utf-8?B?TXNaTmNQK3NJRjE0NTFaVG53TTNERkZEcUtjZ3lyVXJQOVNTUVhhemNySDVE?=
 =?utf-8?B?SDZMcjkxWVNjUURGays1SlRVcHdXeTlXN2MvNzNaTUo5aWFucDEyTStIcE93?=
 =?utf-8?B?b1k5TkhOUVM1eDdORk5WY1RoRW1ZVFk2VDFBUW10K0F0MWhsK0JpL3hlK1pJ?=
 =?utf-8?B?dVZTejllcTU0MlBmUDljdi9TV2FST0srVnNoaFZRQ1RyanJ0OVN6TkVlU2tq?=
 =?utf-8?B?ek1nM1dzdGtLVUlWd2I5bDdkdTNzQXovL1FMTnd0YktqR1dkcGRRK2tXMjBF?=
 =?utf-8?B?SGM2cVZseUtRMUllcHNFWlRFL202QkJFN0pTaURxZkdRQ3A0L1BONXpYdmRK?=
 =?utf-8?B?M3U5b1FJMDVES0dRek9mNnkrcG9kVlhqb0tiWkpjZTNnZCtmenFpOHE4a2pK?=
 =?utf-8?B?R1NGWjFCVXovemNlcVh5bkdTaUZNZFVQWXl0QVJ2SFoySUJEb2dMUThkcWZq?=
 =?utf-8?B?ejQ1bWRqS3RBZGtxVDJhQUJiaTF5QW0wTkdUeWJJaGgwRVN2MnNpZHM4ckhp?=
 =?utf-8?Q?ywrNMUe8peq9ftMBjCwDzjv7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c346b97-a3d6-451e-2600-08de3ef90a27
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 12:20:47.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqioaxzJ+ArlDXRcqvpnHCp1eHGGJyeqpA1/T2q8dDviTWqgPcE7/QvyWBFx7Oj/61hRF4SdLZ4Pz4tbaKiyHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793



On 12/16/2025 8:57 PM, Zi Yan wrote:
> On 16 Dec 2025, at 6:11, Shivank Garg wrote:
> 
>> Replace 'goto skip' with actual logic for better code readability.
>>
>> No functional change.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  mm/khugepaged.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
> 

Hi Zi,

I noticed that b4 didn't pick up your Reviewed-by tag automatically (possibly because
it was on the same line as "LGTM."). Just thought I'd mention it in case it's helpful,
Since maintainers may be using b4 or similar tools and your tags might occasionally
get missed.

Of course, I'll make sure to add your tag manually when sending v2.

Thanks,
Shivank
