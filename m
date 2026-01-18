Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23D54652;
	Sun, 18 Jan 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765886; cv=fail; b=jK0xwwkrFFzx1hfTY0VGZGrA6OxF4cGG3Mn0qR7iijYRePIQG3osRc5pMxG16jA869Wt9E0WlWIgZwmV2y2/CB/UcOu2jiVYmT/eKrDoPhfpqzmVvLUVYtKlzWLirftW7fPjZWvwoyEPljAd6vLqDTEOysBNCOiR/wz8BwMJBLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765886; c=relaxed/simple;
	bh=lZ4TlU5BOTeSkTapHUKrLirNrEXcH8eEXWT8udIx/fg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ExIht6e4c/9uIkE6o8twrDmA9W4Y19OEMJYyok/ShYKdxB5hBNkwi2jnyUEHiFjkBjituxPwNCDfadcf3cpewEdWLzXtHQiG60WgdTe4HJZAuB7QksZaRbfYPXvvdhaXUjA9H8W0TnOw/EMO/6W+AmaSHWL4Q5eK58p9I1mUDiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4QXSYc88; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4QXSYc88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfDHspsyoBBeR0QFsp73mbbn9mGRjB5NDdMeNrnIn6pkV8OBi8Wsfty/c3PjQ+5QcgP5yvbXi1vGWppOLSgaduznlKBJX9qaBm3R/1BrIN9yNJd/lZYN7XS5XNMxiXC7rcLeMxpVHYjftkve2cCih3Z+T3CTWsLizAvCMsckWndYqjvHqpzvE1bChWtNXZhtbJ7KAGLubMbugZWA+E3LGWeGVI0yq6++xSOxxYqafnqQjkyPV2uyloD8YFBP31QhUPY60cM7k1CfWixBm3G2mM5T+cEq7j1xhF8UQaSKtej8BkIB328byViNgmn7Vk/pvOqCwXF7wEV3Ph73D38qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=day50hmtxiuHYB1nhaz1KUWkZYN6XLKexA7F8rSPogY=;
 b=A2H1EpiwewbPNKu6X2YwRn/mb8yBOvBylYY/9Me+7vsKUL9I4LWwqFcs1BH5NWNWRFNJVDEj+7OAbTqh0UCt7bPRLosEYcrpYhS0Pxhcf/viqqeABAhRinGU7WWk5KDG3abJ65JJbXvQJ+Uw8/Lgps3UQ+I5JrRViN1NKsP1er4RQ4T4Qy6FJtMycHht5osKkOXgZXzJKxZ2Ic2NVXRYQ/SdZm6jt89Cz0VDdSSEbR0EhU5vBXIDaQ1Do9Zhp5nc798E5sRjGWTQJXJLgnLthuFdDM49hKKQwu4qKE9j9SL1IhCNIIRYqOlVZj82eAm8DT8+TtU1lkxSDG2h1/gf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=day50hmtxiuHYB1nhaz1KUWkZYN6XLKexA7F8rSPogY=;
 b=4QXSYc88BaYyPje2yaOetTpHC+sdbkQPtgiUQUXkHjVLHxB1cqPLCCh5nS3onLb8KE8gWmXyqfz2EcVsEhDOt5zMs8EUkuhbXNBAm7rdEZonzD5Hhywey5tgQ+yiS0H9l8unhY6NTf8mKd99wwAZcRVUFwOo2Iiratj1Cu2ErEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 19:51:20 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 19:51:20 +0000
Message-ID: <90a163ab-cef5-4246-a187-1614a7eb182f@amd.com>
Date: Mon, 19 Jan 2026 01:21:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] mm/khugepaged: retry with sync writeback for
 MADV_COLLAPSE
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251215084615.5283-3-shivankg@amd.com>
 <20251215084615.5283-7-shivankg@amd.com>
 <3cc27720-8f53-4b6f-9202-42b3b73928b8@kernel.org>
 <dbbfc5f1-d9e5-4d39-a2df-e35d6ba73063@amd.com>
 <d6287c39-59a7-4592-8afe-bdbdbcd70b04@kernel.org>
 <7a42515f-ae57-4f4d-831c-87689930a797@amd.com>
 <976561d0-0edb-4f09-8ed1-ab8f85c9aa87@kernel.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <976561d0-0edb-4f09-8ed1-ab8f85c9aa87@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bae7d61-3213-4e97-b354-08de56caf345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG1jRmM1Y2Q2RzZsYW1aZjUvdW8vMEVUWHZ5QmlHaXR2ZkV1T3BSMWVGekxE?=
 =?utf-8?B?ZGo3Z0RLNjdEd1B1RTNIbVQvR0t3dk9IcUVlOWdIbXIrTmJZVUxDOXpNd09U?=
 =?utf-8?B?aWNoYVhUOTZJeTZHRElkWURsRFZNbXZ3aEhoY2RYMFRHeTN3UW5TOUswS1Vz?=
 =?utf-8?B?NWJlcXp2Mk16eEg5UksyamVRR2d1cGllMUluUURrYTBnRnZwcDFRcndjUWpV?=
 =?utf-8?B?T1M5Kzd3QndCZGFkYWFIYkNFQVVTUmluYmxaVERsdG1WNTZ0Ym9CSE1SQVRy?=
 =?utf-8?B?dFV6Mk1HcXcyelVZa0xaZmFwc0RPNjJKQTdQTkJXYU9aTmJmZG5GdytqY2VB?=
 =?utf-8?B?NGZuNm44WWNVT2t2SmdEZ1dVcVlMRnBuRHovdTcwRDZRS3l4VkxXYStwVEx4?=
 =?utf-8?B?VDlHK0srdHVsWVBIT1lQcnhFcENubUVqQUVwL3hVd0FOR2ZvT3BxTFcvK1Fm?=
 =?utf-8?B?K2h5bU9Sd2ZJRnB5TDhJRGJ6eDBxQzNPcWdhdmtnbFhSdklvZzVRaTNwY2p4?=
 =?utf-8?B?SjcrSERVeUwya2M1a2UyaEZMaU1TQ3hiUXhQa2huQlJHMDFkZ2oxdlQ2d2x5?=
 =?utf-8?B?Vkw1VkZ0SlJVNktvMWVQbVM3bk1JaUYvemRrclFOV3ArQkxUM0N2VFRLeDY4?=
 =?utf-8?B?NHJYVGNScGpaU1k0RTcvYzQ5cEVCb1U0b2Z6ZGh3aXhLcXpLSTRaVlNUMi91?=
 =?utf-8?B?WTNGRytGSEVsVkJwYkdXeTduQUJZVHNiU1p3a2ZTVkJUTzBiRjF3M29XRUxQ?=
 =?utf-8?B?N0JxMkN5WGJSMHlqaEZ5cUp5YkdWL2YvN2wrbTRSYktVM1Z4QlJGVEZNWGJU?=
 =?utf-8?B?VmtZaThLemJwVHZ0b05McUJJQ3RQb2Jsdk9PMS9WODVzaXNvbWpnNTVTSU5X?=
 =?utf-8?B?QWc4U3FIb3pCSEtwZ0VkZmRNQjBkSFdTMlJWYW95SlIxOVUyM1NEMnNuL0k4?=
 =?utf-8?B?QktHOCtYeWdSSG1CM2tQVHFmWVczRVBaeHVVcEtJS2N4TmN1RmxtanAvcmpV?=
 =?utf-8?B?aHpCeEtBUEtkVlBYejlTU2hQUk9pbmthRnRvV1pYaUhqQUV0ZlBqbUVvTThE?=
 =?utf-8?B?bmJOdWkxenlHZ21HYlh6K3VBMXZZRXdjVXRpQU0yLzltQ2ZXU05zT0dLR2pB?=
 =?utf-8?B?dmVjWFU1dDF6QkJGVnFSWkEwWWl5YUFOV1BGSWNDaTJNYlI2K2VFUWNQdHBM?=
 =?utf-8?B?U1RaMnZpM3VISVVHZ21rMktibUpwaXNBNlNzdytLSjVNL3RKTmhRK2hNejBm?=
 =?utf-8?B?MHFON1lZODh0cXJmckoyTWNpV003bU9xeFhiTDg3eWZuYitrelNuUkI5eGlS?=
 =?utf-8?B?TWswM3ZUTFNYMGwrNDB4bnhxZ0E0SmNPT1AxaDRaZ05zSjFCNUxXSWNRK3pl?=
 =?utf-8?B?eEtJVDQycDM2akU1d1JJbThEWk1mYkd1Uk13SXFvSG1xdEJUazFUQTBDK29s?=
 =?utf-8?B?TlVIVVZ4UDEzenIvTUJmaU5ibkVQanZLbHB1cDUwZ2lNRytUY0N6SVJWMzI1?=
 =?utf-8?B?V3gwdkdBczg4Z0c5d1VkWVRDYVlTSG1kOUhPVVRkSVAyOURxTGZBbGV6Uzcz?=
 =?utf-8?B?LzlSWDUydnhQaGNLQTE3ZkttNjdweU9SUVd0d053eGZPVjhPbFppRUpKOHFn?=
 =?utf-8?B?U0FEZVdlMUsrc2FrVG1hUElZNWsyWkxnSnQxOFltd3JSRG9wa1Z4a3k3N2dm?=
 =?utf-8?B?bEFRMHBpNDl6Z00xMzQwdVdsRnZxbUNiL2t3MGtURk1rbHpwSkk5QlQ4L1NR?=
 =?utf-8?B?dm9lT0NUYVVMdUVJL3NYR3FsMlFZTUZyeXNpZ21WelN3WUxGaUY4R0NzYVZk?=
 =?utf-8?B?S3BZbGRHRC9PdWc5Wm1zNHdNd0tFd0svb010Q0ZmS1YzbWlETzV1VFFVc0gv?=
 =?utf-8?B?SXIzVGF2L0lSaUl6N3V5d2FIK0RYOWk1dWgwL2NXTWZOQ2oyY0JyZEJIeVd5?=
 =?utf-8?B?elNYdWh0MjdwRDJ1bHZTZkZXd2szdHNDNndwbmc2ZjJIR01XbFduaXVYUXNj?=
 =?utf-8?B?b0RWbDFWVjVVZ0lvd24wTlRTU3ZJblpuL2pUT21XcTBhb2UyRi8vU0tSeGFw?=
 =?utf-8?B?WTlnVllDek9CeTZyNG44NmRpS1NXWitWcnVuQzZueXE3WUNrNDdERXkwYThY?=
 =?utf-8?Q?CcU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1UTUg5UnBob3RBNmZKeXZod3NWM0xUVGFsZGJad1NNQWFYSHJjY3Q4MWhG?=
 =?utf-8?B?c0tiS2FNNmxaU29MOVhkM2dURUNCQXBRbU4zaG1xeHdzL1FLV2pLNExIM0d2?=
 =?utf-8?B?TGxNRUYrNzhJZm5hSEJJQk5vMStLbkpKeVltR00zSFpXODFESlZrcUJsUWVN?=
 =?utf-8?B?OEpsNGN4S1Fma1g3eFVVZzBYTHJPOHd2dmFYOXBTRTJiUDRBMUFvdzU4bDNo?=
 =?utf-8?B?S3FLbjlZNDkraStMdFE4QXJkSm1mMDF1YU1LdEFGVzVvdW5LRHNqempuVGsy?=
 =?utf-8?B?cE1mYnBZTTZYU1NvTlNubUdUeUtvR3BqRm1XUWViZmNpZjM2STkrbkFGbVQ4?=
 =?utf-8?B?MDZCUVI0OERzM3QzWVhnOEtJYUpNZG1JLzZjOVpFK1gwc2ZpZVV2ZGxMRXJS?=
 =?utf-8?B?ekphQ3RlZUVjd2xudnFwUUI0MThxQVYrQThJR2owd2xJWE1DMFlHaitlcEpk?=
 =?utf-8?B?Z0J1RW9mQno3MzJYMFJqS1NmV0tmQmU1anM5d3JGQ1FnWEI2QkVQUHJwL3NJ?=
 =?utf-8?B?RCtINUVrV0ZoYy83djg2cFlqc0ZmWG0wdFlFNktmOVFLQ05KT0hIOXliMS9o?=
 =?utf-8?B?Z1pib0wxa0ZXTldqMG9pRDFQdDJhYUxRY0tsWTF4REZXN0hUTmdqcnZsYmFK?=
 =?utf-8?B?RmNreUU3UjNyYlVaWlh6THlmMExUbkdOMTNodkR5VGpCUVgyNUxnSGJUM2Rh?=
 =?utf-8?B?WXFjVUw4Rk12R3MwQjc3QitaUVl0ZGxqUDVFN3BpMi9FbENDVzRXdzhubGU2?=
 =?utf-8?B?eU5IY3VVVVZLYXAzNU9QbWpVZDZ2T0V5QTVKRlhMRWV5a2poRitLYTZCR1RK?=
 =?utf-8?B?MkdYMnFIQU1NbktrVWdEMFFjenc5TVhvQUVua2RaalpvSmtqZEc4eS9FbGUx?=
 =?utf-8?B?RDJNekI0NnMwZUdMT21Mek8zZHQwU2pRNHdocnlKUUhWK2kwL3U0QTQxcVpH?=
 =?utf-8?B?UVpUeUtHeWc2S1NQdFl0QkE0cTloUlhyRnllRXk4QkNLaG8zRUQxajVmRkFr?=
 =?utf-8?B?RjFDQ3pLbmV4aWduTGh3elNFTHplVlVkRGxOK3NDOU1xSVZNbnAvQUF1RW5y?=
 =?utf-8?B?dUI5S0t1Z2NXc1l3MkphUTBlcERXUzYzTU9PTU5BeUpiaWVvOUREYTBJNkxn?=
 =?utf-8?B?Zm53RHJ5N05Ta2VxbVV6dlZGcHdSYS9nM3JISjRYQkJ5OGxraGJ3d1VjaG1v?=
 =?utf-8?B?SndkYVQrQ2lrTjFjQTdBQXZCZHBaNWs3c29vdG1yVTJPSWpKVDl4cUdQRVQw?=
 =?utf-8?B?OUkxSkRiUFN1RUEvYVNEcHptcklRVm0xODBKVmlzUUc2MVBhRkxOYVpYUHdF?=
 =?utf-8?B?NlNTUDg2UTNld3BWQm5XMjR3cm1BUjBTcEdUd09uNE83YURRYUttS1BMTHdr?=
 =?utf-8?B?YkNBZEF1SEc4U3lIU21IYjZBYk1DQnBHVUM0S1FBL3AvYTgvNzFWc1BIZmNF?=
 =?utf-8?B?K1luWDR1MzRLamdNY1hPZnYyenpDTzc1WnhESWVBekl3S0JIYTNEd2FuVk9h?=
 =?utf-8?B?UnVMNkJ3dGxHNXV1elNrMDExc0xZSnNkZnZTR2lxakpUUzBPTXFkYmt2YVoz?=
 =?utf-8?B?a3dFWjl3N2ttVnA2VDFPVlYxTE1pc3ZVR3hqV1BNY05YTXl6Rkhacnc5TWRU?=
 =?utf-8?B?bk1INzdTVC9EYnY4WUd1RncvNWUvNGx1eHVGdXE4d2g3dnFrbHlqaEpsZDcw?=
 =?utf-8?B?eVc1cmtXNmhIR3ZWMmlOQkQ1b29SYlBHRGlqdmREL0R5ZFpkaWRJUEtxamUr?=
 =?utf-8?B?Z3hNUDJPdUZKYU5MZDR4cU45ajdSOG1qZ1AxZm1PeTJVTitKbng1bUduMWRO?=
 =?utf-8?B?VDZuN25aL3c4TVcxZE0zdTRtdFdndjloWFV0VVFpWmE2OTVRZGExZy9RK2hp?=
 =?utf-8?B?SzNWUUN2U3k4ZjFDWmRmRmVGRzh6SUdIYVVEeksyMDROYTkzeE5sNXFZU2NI?=
 =?utf-8?B?aFZFZHN1d1hMckVrQkIvbWQxVktPMEI4aHgwbWV6U0R2ZW1EaWhIdEhTcDNL?=
 =?utf-8?B?SGthd2poczJvN1hvSm1SdkZiazd0ejB3RFY2NHVuTkhLNiswY2J5WFh4eERy?=
 =?utf-8?B?dkxHZ3J0ZWVWOXYwWC9VcGo1TUpzcjJtbCtveDZ6eDJTSkwzMDl4bHdQTWlt?=
 =?utf-8?B?MFU4UU5OdUMvQ3JVQXI1ZWZreFVkV2ljVWdkM1kzWFpjb1Q4OVBkaU9Na2Nw?=
 =?utf-8?B?ejNHclY0VTF2VzFhSWtkc3VWeFBkSC9sYzZ3S1Q5UjZxWW9tOXEzcC9iWWxJ?=
 =?utf-8?B?eCtNZlZRNW9mK1h0TlBHTFp0S29aOTRCdk91SFZnOWJWOWwzalVMSEQzSmRt?=
 =?utf-8?B?bHlVNC9zZHJEeEVRbGFITlJ5a0Zadm1GMlUwYmJUWlF0djNpL2NtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bae7d61-3213-4e97-b354-08de56caf345
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 19:51:20.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNKLq8W/WBeGfRk02676QT1N82+F6Rw4DskXs1vlugo5ZHBxXWzijrqFyusz+euOcCS12WWUobf4JuJgBNZp2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130



On 1/15/2026 1:44 AM, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 20:47, Garg, Shivank wrote:
>>
>>
>> On 1/11/2026 4:59 PM, David Hildenbrand (Red Hat) wrote:
>>> On 1/10/26 19:20, Garg, Shivank wrote:
>>>>
>>>>
>>>> On 1/9/2026 8:16 PM, David Hildenbrand (Red Hat) wrote:
>>>>> On 12/15/25 09:46, Shivank Garg wrote:
>>
>>>>>
>>>>> This looks a bit complicated. Can't we move that handing up, where we have most of that
>>>>> information already? Or am I missing something important?
>>>>>
>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>> index 97d1b2824386f..c7271877c5220 100644
>>>>> --- a/mm/khugepaged.c
>>>>> +++ b/mm/khugepaged.c
>>>>> @@ -22,6 +22,7 @@
>>>>>    #include <linux/dax.h>
>>>>>    #include <linux/ksm.h>
>>>>>    #include <linux/pgalloc.h>
>>>>> +#include <linux/backing-dev.h>
>>>>>      #include <asm/tlb.h>
>>>>>    #include "internal.h"
>>>>> @@ -2786,7 +2787,9 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>>>>             for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
>>>>>                   int result = SCAN_FAIL;
>>>>> +               bool triggered_wb = false;
>>>>>    +retry:
>>>>>                   if (!mmap_locked) {
>>>>>                           cond_resched();
>>>>>                           mmap_read_lock(mm);
>>>>> @@ -2809,6 +2812,16 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>>>>                           mmap_locked = false;
>>>>                            *lock_dropped = true;
>>>>>                           result = hpage_collapse_scan_file(mm, addr, file, pgoff,
>>>>>                                                             cc);
>>>>> +
>>>>> +                       if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
>>>>> +                           mapping_can_writeback(file->f_mapping)) {
>>>>> +                               loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
>>>>> +                               loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
>>>>> +
>>>>> +                               filemap_write_and_wait_range(file->f_mapping, lstart, lend);
>>>>> +                               triggered_wb = true;
>>>>
>>>>                    fput(file);
>>>>
>>>>> +                               goto retry;
>>>>> +                       }
>>>>>                           fput(file);
>>>>>                   } else {
>>>>>                           result = hpage_collapse_scan_pmd(mm, vma, addr,
>>>>>
>>>>>
>>>>
>>>> Thank you for the suggestion, this approach looks much simpler.
>>>>
>>>> There are two small nits I observed:
>>>
>>> Yeah, was a quick untested hack to see if this can be simplified :)
>>>
>>>>
>>>> 1. In the retry loop, it is possible that we reacquire the mmap_lock and set
>>>>      mmap_locked to true. This can cause issues later when we do:
>>>>
>>>>          if (!mmap_locked)
>>>>                  *lock_dropped = true;
>>>
>>> That whole logic of having two variables that express whether locks have been taken/dropped is just absolutely confusing. Any way we can clean that up?
>>>
>>>>
>>>>      because the caller would no longer see that the lock was dropped earlier.
>>>>
>>>> 2. We need an fput() to balance the file reference taken at line 2795.
>>>
>>> Ah, yes, makes sense. Having a single fput() would be nicer, but that would require yet another temporary variable.
>>>
>>
>> I agree, that this interaction for lock taken/droped is confusing.
>> However, a proper clean-up would require refactoring the locking logic across multiple functions in the collapse call-flow path.
>> This seems significantly more invasive and risky.
>>
>> I would like to handle this refactoring but in a separate TODO for later.
>> Could we please proceed with these minimal changes for now?
> 
> Sure, fine with me.
> 
>>
>> Since, V4 has been in the linux-next/mm-unstable for a while, should I send a v5 or an incremental clean-up on top for this?
> 
> Just send a v4, unless Andrew tells you otherwise :)

Thanks! I have send V5:
https://lore.kernel.org/linux-mm/20260118192253.9263-14-shivankg@amd.com

Best Regards,
Shivank
