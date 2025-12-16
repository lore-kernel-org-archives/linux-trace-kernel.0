Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305535CBA4;
	Tue, 16 Dec 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898849; cv=fail; b=n7vL6GOyphQchS51hYnLfGccsCQiYD9vN9K8x1FRAtJLm/TmFuxYSQgrUrq5y0hIubfdY7U3iRYVBoolkvH5+VGocZynOWeZOyAOpbqNDLsKbKUIJ2nQPhoIWg0+OtOF1LhYJoIWgrzubPL01j3UYTBsxkCkTvNUk0pM1zrxlUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898849; c=relaxed/simple;
	bh=O7Bmpqe2NGSY8apMI1q+8JWV4M/gC5Kgx6dW1FSkJYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aoa4GF71jAA/zrovHHTW844V8KvcQFXP1pik/4ZgsIJKJGmBl6H3WRXVnzDqklm+4l9N3CylcYwUHLjsaUeZBkQbKbwj19NVT7Xq7jn9e9lmVk9YiH2tYNGh8av4cdMpihlcbZ6qN43bDv4y/7NI9Oo3JfdGi6IDKKv/h1Wc/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CA8gGYyJ; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CA8gGYyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7bzyMGFcTIK3DHRqFxpk6Guax8Vrfl/BYP9AaGfvwFbMVs3rZ5l2K46aqK9uJO4dDOAPh/kRHKbKS0zVa4nWK00tCpOG/rY/uMwXJri7j3c1AmCwsK1UVCbx2zRoyveWgffzUXIsh626OeN2ejW4yf/oyaGMjHXBdQkH6gfMcpvs0wQ+Aacn/6rkjXp7nx0pJ4LyOfO57VMkaRh1FCGOcMt9dDTSSxZ//En9VLq15M3EYA99BbmKHbSPsudHBppxlarnz4nzDrnznopDm66IdP6i35WkXM0gtxAp9M0z+lKNpE0C1JvfLu+9uMnXhGkyKfznFMnggKqlipkjKixmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjGErN/TLwM0jQ+eDoBPL+0eX1xVCGP7N5Ry+xA25lw=;
 b=vL8Uv8eGENVr0fcYDL1YyGqMYQ8vd3NcFFQ9Ta9K9A2i3vi+u/4b3LvLuYNz8678+FFAenKYExHoJKYnnVeqqQWzwVFHQjiPvGxOdRs7rPfyaxyPCd558tNpsmY9Q95nE04P42kEsHiInKIivkj4BKXHhRJ9gOp9jxNkfQaDcdKXgdTN6jVV9qWbpo8cpET1Xfy7ZreyY8/qHyWJt7RnWoX8isS/csUKvbR8T+pSWbYJhQ5Jg05GGRjO6o2xXh8BhkHkApY5amxzCzheTvqn/um+gv4ecxcNMBjr4UXPOgQSblCCW1MqGxHuYj1DbSc+yQJwJQ2p2FABwJ765/sL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjGErN/TLwM0jQ+eDoBPL+0eX1xVCGP7N5Ry+xA25lw=;
 b=CA8gGYyJWSj6RWXs6fFLkEWZvUalTPIwSaGvzTVuyl53CE8K+qD91CraYgZFXySXvcQYGlDc9dba9+m8yX/ZjHfnY6we5g/EinInYm6FFpFhNBYfUDpxG5IYTyyFgn7tk5CHOMnphd9xAHRd1/m4QGFfebOkfQJL79gYWaHKMfekoQMc317eRLxZa7m4sFaMbCCtXBeGoq4MiYGp3QAqpDnwJb0Uze16guaFB41cbgZjgpPfHHKYcGy1Eg/DtGn059WXzWaUtNUjzi7/iTp0V6hL2HW50ZR+YAnStA45HPa/jePPBQpMZdsOmMTZgR1ViZr1SgfwqsH2dLUCqhGIJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 15:27:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:27:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
Date: Tue, 16 Dec 2025 10:27:19 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <848E8F85-CD24-491C-8A3B-474E4FCBF995@nvidia.com>
In-Reply-To: <20251216111139.95438-4-shivankg@amd.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6605049d-a331-47b7-8ce8-08de3cb79b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMohGjz7jxFU+9wIMhUtgGKk7zqw57vVtO0IBwngj1BskOOEZtvXiCDEJ7lr?=
 =?us-ascii?Q?1x1s4pW9/Ti7xFg4dDse2JYVmfDaDUnhmUXfEG4QSYI3ngQBBE6xn+NjI0oB?=
 =?us-ascii?Q?P5zVffvBfQdv+ZeK6WOnlLokGOsezY4mepvh6mXSzc1uR4orrYOytW1PuEc7?=
 =?us-ascii?Q?ALwiak3rSaVAf5exeU5yUVv+m2gahdlSgbSGNvbakzeuShvzjdKumtlUAjS4?=
 =?us-ascii?Q?QLPAIgZFd2FWDZJZtQimIBw9BtBmDsYtBXBHqIzjBTDYZyFt8l9A0iQf18SG?=
 =?us-ascii?Q?Wdzibr7MOuMOb7XfY/mzRDbUJhdoVDe/IcUJMgsEpfZ4ja4aU6lYMThz9A0P?=
 =?us-ascii?Q?UFc8ATwlmdtARjyFWR5o9POe3Yup1AeZS3vqbjFY5J3EmtNYUw/9O1rsMHxZ?=
 =?us-ascii?Q?X2tGvCHr0z8sFkzTqvemOwbgvHiEEt5r2+OcdbOxXHbMksW1/ABYPHFrqfyp?=
 =?us-ascii?Q?H8LwHOafslGVNqR1dFKjccRbz9jIDVk+Ww0uVllP5Njk+F1XkLlYXm/V8jAW?=
 =?us-ascii?Q?UZoz6PHHNZPTzkXUdfjdWDd3/V3WRPIS5ON/1Y1nmlMdWJGEFfnU4k/mFo/K?=
 =?us-ascii?Q?/wz6yFtL/aPNfXfdqaP5UkqiutbNTLsCN8Dc5lcZhtOuuCB2NNSTwFfR/633?=
 =?us-ascii?Q?zzQTCmVTF0+fZj0rI5+BjPwmnpj/8H5uykm5NGhbHzNfIUVU5+ZG0cec7M00?=
 =?us-ascii?Q?Du77jYQNLoVGnTxS7+/Bnvx6WIEx0RYf+FB7U4hOUwK3/btQb3mUPIljTvKY?=
 =?us-ascii?Q?N8d0f/C+2Xspyhit/XSjdducM3jQsL1PnFKfx+lNDwphoPZ14aKQF+5HvONb?=
 =?us-ascii?Q?TfFvBoPoM7/2EDmPp1mLFAT17s2YxuIRcqtU2b6SdqgsU6tDJn3PwIPL6kfv?=
 =?us-ascii?Q?pRVoAlMQif0zR4zFdbUJtyKRRkaqcjhzh/RI3etvXl6xUVHADwMUBEyh826R?=
 =?us-ascii?Q?hpxcyiVPChELCjanIR9354w0PTpPtbVaK0zIDQt4Sr1RRGcpfK90Uf912/dx?=
 =?us-ascii?Q?xYQs+lRUx4eoLrDuvchlkTV5vTjXr8cQGXT71X5NiJHhMjO3nCYdSEi1mUZb?=
 =?us-ascii?Q?toz2qpG1Otn1C0cV/TRF1uQdUD0dp/lqDwUn+s2vv9vAaj9SJDO/KIJhnhkf?=
 =?us-ascii?Q?BpDgi9S73t+AKgZsni41SrkyiZPnAAsG3Ro3XKP/LQEYy1Gll33xSsguvBmC?=
 =?us-ascii?Q?TgMLRQ09ZZfA6qWwCWO8+Lw03htTCud2gFXOQo5g5uXTMWvsgsSJIF2Xf6QU?=
 =?us-ascii?Q?VHThY6nYwIAnSMHdYghmBIMdkgIa9w1qFEoGQaOx+d1IF/vv2bFMQLvdY1Sx?=
 =?us-ascii?Q?C2QMVf7PZQvBtS9nlB7zMs3OPn2sXZV08cc3ffTut8fSlVpb9x46C6iPkmVi?=
 =?us-ascii?Q?QzpM+TWFNfpxGFdPtFR0OCJMcHTkVX0jZIVDyMfwB00wF99qONCw3xcR95vc?=
 =?us-ascii?Q?6zwSh09LhKuGgaXPRZUfJIlQe1O+nmyN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRl55yFuqDqI12gk67GWmLtdwD46JfT4PrzHCaIzscpCigj4ZcIIqicXKwKu?=
 =?us-ascii?Q?4DOV6389uSEdS4g5N7pJREWkuYraVdMkTi0TTLHqtfvtCQNqo4CDVN0dzb1k?=
 =?us-ascii?Q?un5lG48tz8rjJTT69bSsy78fkX5GQuFNdwMlkXJ3ZuGjeQRfDjq74y6UCejK?=
 =?us-ascii?Q?BP52+1KZUrTDXcAPFEYRPJfuDrnAB11pIJQSkCRYGB9aWydZXq/f7MAEuTNB?=
 =?us-ascii?Q?TcW1vN3+rvBDNrcrX24YjwB2o1suInYJmzzStZ2ECPsKljLvEpN2Fx3IhWw8?=
 =?us-ascii?Q?q//POs1VuI1aP9eJjXQZBjcse4voDo90o9N6GhTbCmReWRd+03RCfpyKPMwm?=
 =?us-ascii?Q?UmAE8Y+dYPA8rC4ox4/zFYPGPwQs0K99lyUhowH6swAsTug2ydjXNNwsrk/v?=
 =?us-ascii?Q?NR9BDbbM/f5WgvpehffYyzwcNaiUoOaPPiji6zgFy1eB51Xi8c2A2mmFweWE?=
 =?us-ascii?Q?FvBp70pLaid+MGU6isXUhpM0UFEiOtYXdBlF+mgXTNRezbTq3sEcD704x7YC?=
 =?us-ascii?Q?xDFEkctBiGH8T/KhOSEK8DG6NW2mSyN7XPGgr8kC+Y+6jMY05+Gh/jhKE+hR?=
 =?us-ascii?Q?CDf/IQABXB94drhPVMfGT3pvg5J7/UuDnmiiwRnj5gyS/wOLrOSlgQog/rLU?=
 =?us-ascii?Q?rMMeKRtSNWvm+HWpNXYeSTJt8CxMeDpaECQvIcz8yGj2f+MDQbpugf1sWxej?=
 =?us-ascii?Q?lKXxW7k8qPSe6o88ij2lanH9YQtQc5AGDVi/mY0Kh+jT4Yk49BUpyfwH6s/c?=
 =?us-ascii?Q?lF0Kfjllx5EnCJM3DWFdTsW43XqjiapbajbBXArEEuoEcekmdqZKqs9e83+X?=
 =?us-ascii?Q?a1izbjnvrR/yqgcZD4aQUwi1ftPGFCcgSBtL8cMcJRDhD0whEVsIQmtG0MDN?=
 =?us-ascii?Q?qSq2PNN6cfrDqS4An3k1pYBKRugz8AuM9Vy+khUG9XD130vQuD97kuNX5qhp?=
 =?us-ascii?Q?Alx2cU1VGw0cGuiplBDboHgppiUGjbQoAU+lzF3KMoaMlZrWTkKdOKFtwvfu?=
 =?us-ascii?Q?zTUojRHiLd/3GSO5EWgsjbmoR+7kUQINNFKTeaKLnKELDS6xGp4w6AwUnp7Y?=
 =?us-ascii?Q?1g6+LiN8pbOdpxykfuGwPPvaW8dV05aF7H+eljzQVDmVUrik/JHflnTOtl76?=
 =?us-ascii?Q?deCWTZSygRbN6LlZdS2BqZNj2BNfyfLVmQ7FxJmncuB76fzmYA827Osppb5W?=
 =?us-ascii?Q?hVjxUsgrUy/MU5v7b9Ug2AgtXxzFIwuG2aI8J0bGCy8O4oa30Pq+299IObIu?=
 =?us-ascii?Q?mjh5EkMvghCJiC1VryZ5Ix8kLPZeJbHQ4RVL2iBAVNugYWdh28kuWIgcEXk6?=
 =?us-ascii?Q?NnuQhHJ1cy4Mp8HoyY0SBQyF4e7/NLODYDeIu0eM8dYnOq0lwox0Lrhavg4L?=
 =?us-ascii?Q?/yT+j4H0oBDk5Z4pGK79QNKlH49sx9VMQr8rwMEGUtds/WZ//3nVHwFS2Nq/?=
 =?us-ascii?Q?D9Dpp6Dhm5q+7PfXo9RgEOa2MMm6h55qmGY7qJVNganHzdzt0UCGyJJUNmRp?=
 =?us-ascii?Q?BDtKNjBXrLekPB+BSgvsfw5L3YAH6wTCgOMsO9xZ1eMamRaKwk0dwh79BmyP?=
 =?us-ascii?Q?0NVH9OyU/ukIixgkx//1jiPguHBvurtiqhD7IEVj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605049d-a331-47b7-8ce8-08de3cb79b89
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:27:22.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5wjLwjH1WuRsXb49fOnfHuBAGVe5ijg5Ol62R/97qYB7Sr6pu1Qg2xRCfMe2wdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895

On 16 Dec 2025, at 6:11, Shivank Garg wrote:

> Replace 'goto skip' with actual logic for better code readability.
>
> No functional change.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/khugepaged.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
