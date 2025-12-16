Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AB366DA1;
	Tue, 16 Dec 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899590; cv=fail; b=PXNpveXwnHYSmIxTUU4oBNCG7nLUoTKsTVNoQ74cScY/tWnSyGJt3ZK/JEGXrYLebsJy9pDiYAlJPeleJpxlqFdMjJhd1w5BNn5fVwBwZzIOnEjnVU728qhKhD4/Rckd+x+cYdUPqcZAE71nKIklbVmPIEGCF2SZv7GI8mS4FTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899590; c=relaxed/simple;
	bh=za/EO/XPdlY/hsKSH8/3oDk/65XAM9rMnYc/ulxacDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChujYOFNukpW1R1eZaSxbdVQVeC4tMp+0H/KlnkQra6ttzvVQjemVQ0ph2Tc9Sbk/dRHzyduFM0/2dHqKJKUfs6c/JZMVi92uJKhBH31+OnAXUox6KYoiYUoGwbcABsuvhymqNtF+5BQL/MJxrDiSxdV7CDNpnV66tltidRmATQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c70npAad; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c70npAad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV+FfGkNY5fwz07D0QdYLaZF1670eJNvj1LqNCeCT+8ekoWRb44bFERX1TF9e9CHfBe9+agxmhf6vfHX89smXtk6sJ/wJgGRdydjFOxL4o6jmuxVgNoKIpBOsoHEQATu2fnj8iK0zj3M8CQabURrf6SVsoBINGrbTjQXijB2x7RWDho2RpGJui3nKKbriOwZN47BAjHDGa/hc4iOF6xoYZp7h78kP41w4vLQIjKCaj4RVSMop1WCP2Y3OLAtMXgH+/rXxe7N43VEBTRRN/KwJ1Tp+jsMHmibe3nCA8pA7n5ehuI9JBbyDUvyGsSvb/hZvcm0mAawSATTL0eeUqqRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD9e+C7o3s/Hw5bg6oa0OEVf2RqoRgTTSiCgUL0A2Dc=;
 b=NHzRiyaG8q1hrY9DxJrbvbaB1TUdYeVJgo/hbVfWcgaFf4n8wHnFK98uBkqk/egb33HhH5kjAFOxqQ8gY7ZM4oEHfr2mMpX1Hp810QQCeC9rJLj44vu+BT1owWOBCrMowKV7X3VGJeldL9QdTwnPjMXAXIGwqERkzA75KpflgiMcGesoNsQoU4pUG97dJ/VPaVb98/oUmjT/jCv6pglkvPHVvzCscklwoIZbFy3dlm8Ep5TdAQ7+LcL/pZQMMFHJp3jAI8L7aV5dzwax5nEHbFX/X73ji0f9rRFuTBZ1wd/Ipa+CcJypoMOc9alGbddtdt2fUlm8x9SQMxSK/fHhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD9e+C7o3s/Hw5bg6oa0OEVf2RqoRgTTSiCgUL0A2Dc=;
 b=c70npAadAktjcSfdb2Ww+7z6UvabtYVJhzSX7eYz/iySJvJ1Br9laalvSOWxWfcDZRWa0/AQASb59hFkzB0Z9H/76JrHosDTgNVcn0YakKpYjStHydjMSmnVYCHbdAViK+z42h6FPLE6ZQYvwmmSTE1mRnFcJdjMNkZCNPyccj/8gkMm9u9y8h1m+uPC8T0rlYzMiVfm6WvsNTXAbS+n+BE6cqIvY+lqUM+tQeR1XMoHgOnZGUoOorMCd5Q3GyV2PRSX/333CDMy69prPpa3I3GgnkpaVWa0T+8/VNGKy1M7okUCzxn6h3l/7Q9kAF5dzKp/Gtymlu07Jy/dPsqSlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 15:39:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:39:43 +0000
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
Subject: Re: [PATCH 3/3] mm/khugepaged: make khugepaged_collapse_control
 static
Date: Tue, 16 Dec 2025 10:39:40 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <7D3819F6-18F3-4F33-AFDC-CAEA4E5810F7@nvidia.com>
In-Reply-To: <20251216111139.95438-8-shivankg@amd.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-8-shivankg@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce13111-2069-49c8-ebe8-08de3cb9551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvwx+kujjUG/bRK/M3xlbt8j232ryh5+gjjuJNT3Fnxo+a4AWAXf+O6aF2Jk?=
 =?us-ascii?Q?2WSczZ2n8UfGDu5QSWe+vbwtTSRIA9qjGHbl7SUAKUD2YIm8Mq5OBeXSlR8j?=
 =?us-ascii?Q?WN2MmS0ljlMjJZ33TWtkByCbTk7PFi2GwMbXylPAymYkvnMad/JLjaoiGAwS?=
 =?us-ascii?Q?XHY3Nlqh1FusZ5xuUtWq35SAMBY03i6SkQqINyqIiYWQnN2XBddWNVtffhlH?=
 =?us-ascii?Q?zUNypuDSNXnwmOu1CXEeCUttEVGWYKPICNiHW+P3Vm1HSnpDEBMTsCpnJ3Cp?=
 =?us-ascii?Q?x2a4iYcNcHNWd0pvyD8i1beA8tFUj+d2g2A5OHOtadMud+0R4ktK/IuK7CGf?=
 =?us-ascii?Q?iXzTezRdX4AsxD+wTO47vy445jHDIlhtjd2lmC/wwvOxDbWzj1bhXoPZ1Vwk?=
 =?us-ascii?Q?vTtxyhAP7Q/dZMh5+lZaTgwUTuTqTy6f0GpPoV0ENossuLTF+UOMYynoLCP9?=
 =?us-ascii?Q?RtgkRk1nJUlGLeFdGj4FVC+DQLGBbdpVuaLX3Hdb5NxL/F3ubPRP7uAhaHMC?=
 =?us-ascii?Q?lRCfWvuYgXm+Flt6nh8lPtiTJw1jRPOxwZ2AiP4PSdbyxn1ZLhNCZ1gIvPag?=
 =?us-ascii?Q?A+QCJkTcjM7dVXl0ls9bMRa8PhowXnLK0vpVaJ2ajHuj24vBD/kdmzT6TGNy?=
 =?us-ascii?Q?bUxpr6mBupZlP78j4v0IONT53WuWmbW/P3NQUmO27Us1h9ueRjIQ340Ia6Ob?=
 =?us-ascii?Q?9ior1oGF3WPhX7vwMthRSqxqqMbPghMIDI4otFQ5GeODnJZAci/lrHDtnmwy?=
 =?us-ascii?Q?LZozXISVRkW4Thgl8umw8CQZhlFrN2EbW2s0SEeV7WlXcGX00UP9fUq/sJIb?=
 =?us-ascii?Q?mpQfIcWlSENqwQ13hl+2FdNCVekghf7uQLY80hi6zBnx124QKdqqCPD1+5z+?=
 =?us-ascii?Q?owpZ1BRi1WlFMERXS/y/Vwa2GM331//Ku2WG/dXP4xHnSBCEGMNdOpK4En3a?=
 =?us-ascii?Q?06sk0kVCjgv9h4in5VHupNZk4E274RY4SmQLwFQ9J9vmba2PGf2MpD2I3S9R?=
 =?us-ascii?Q?Z++iI4O24Wbsvxr5FKLSL0d6kbVXVBhPCyPdFxR3P0VzLfNWyBgizmlbNajk?=
 =?us-ascii?Q?Mfv6fG0lNC78vd6rModcmXzidP32z/COL1JfntdRcSbP/hDm7AZh7aaP1DjL?=
 =?us-ascii?Q?QwmtC+8Ka4jTKnbIQF6Lb3Vu7dRLpIc8wEDKBCvfB7axlKas/TnY3KWoovYS?=
 =?us-ascii?Q?l6nqgqFH8L5Wf3PQ7VPFJ52ZsNdLpI++Y0Zo9RZJKGb8hjIwkYB7G0S8M0Sw?=
 =?us-ascii?Q?8sAN3L5XAGJaFOx5WjqeS30BAiMsvFNiWmG3MRhDWZn5IzFav15J57CbcYpb?=
 =?us-ascii?Q?LS9ZBcXlCauq9bf/E5lfqPm0g9ddnLO9n1RshrAaxbDFEKsoqhUNGwBNhIQ+?=
 =?us-ascii?Q?/Y2zCLEyvcTQjP5z7m1y1psZxJ3EE1ToWCVCJb/lXNNagcH+hNSw7CDwD3dx?=
 =?us-ascii?Q?DaSJAIvMQI0nBeDdh6Tt9S2bOXIfpd4T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AoC49/PMoUNcOe6BxHAtf+zIuJKfmD2x3DfLLGwzf1G3GrxdILTfKFUOa9Na?=
 =?us-ascii?Q?3OY5AR4MyVup/0R6GWS+Q8xI4X5QlF0QM4Tyfb2rMLD789fWds+fWTVU1NYr?=
 =?us-ascii?Q?EAFUqyC1cpNTMvH+Xil7D45E+cTnExQ9FCBGldYsMybysdgYPBCPPULLAGVF?=
 =?us-ascii?Q?PrhPcWusKWmYKZuRSPgepU6gF6vZrvkWR+DmYvopbAZGHJch25ouLD+ot05t?=
 =?us-ascii?Q?ZFcVvd8GRdLEgKahaMYuFoKARlbQn1v7N6zbKCosNuM0N9n9Fxh/F4TECkwb?=
 =?us-ascii?Q?kf27rohC307TaiDBsycA/8cpdK6qrAS03aW6Hv8QLMGfeD9TDec8vmAB61ez?=
 =?us-ascii?Q?aPNBeMPrhU457f1Pt8hTCwi2m6rroiG9NPWeogOCzfIWk7zEL/v502JC0Reg?=
 =?us-ascii?Q?LGgdkT7lrD+da1+rX2FNmrdkZV7abCo9Di0F4PdiEF4prXTJGOq0tLMFzs1w?=
 =?us-ascii?Q?KJqC3or++owRk5bGW+GPS6PseXkh6qECvdW8mROpN6ULtAVndia2V4mhW6m2?=
 =?us-ascii?Q?bFA+PqgZA80VgbFEMEJw+c2HBjkix4gq2q0+A8NOiW9rzogPaV5GQqSXCNI1?=
 =?us-ascii?Q?s8Goxm76d7Bi8Rdbwp560mZeSFXMwNhcM4y3KZFqGl/+tg97DPeYMQXek0Dt?=
 =?us-ascii?Q?BI6DgHk6ZKM/GqbNUo92i+myhXO6cz/CaWZiSidBsApgSiS5pSLO6QXunGTt?=
 =?us-ascii?Q?CsOri4ZJpWa0vjO4he00KoUV6d3TCayiuerH5JlO8nz2If0/mSYcsXEnJVyj?=
 =?us-ascii?Q?RgmrYs021JDYiaPNsZsTgv4+0+7+DOkfjEmdMbCQF/sFZ1JBAcPB/4MV7Ojv?=
 =?us-ascii?Q?A6WbEmsJssEnC6saP3W49AV/jkPHFpqthcI/c/TInmfB+93mlPw4U3Xkear/?=
 =?us-ascii?Q?jfPwy1BsHTJdDqBk2AMOMPzOWIPXZCuOb1X9CAFW6iAOHt9y23xF1jiAqpxS?=
 =?us-ascii?Q?yKhM+1jOQbTUzLhBeCeeDNvP+MkY3O9Dt/3GzFwrdqfrv0Q8DV9rNr7eETfr?=
 =?us-ascii?Q?Q7qV5OstI9SVuu5L0t/ByAMZMXkmSCk3SOHeApWS90QFNcEuEFoVI1PrW+Yc?=
 =?us-ascii?Q?jXS7or2W4GC4A8Rgd/LvvbzQVG5CxwLwdFfogRbFNfCkVYCmWYBMbAZneOzx?=
 =?us-ascii?Q?9gsRIvvMTiPZVvpD/dOnyKXoVBO2JUxLLxy1vbFCqGPaN2RQm1u4V3KnC/Bl?=
 =?us-ascii?Q?1mv5tOhnj8doBbn4m8rVxuwow8/pVTX+Rvx2uZZdzg/2hdUf9EXkWC9vYt9X?=
 =?us-ascii?Q?ZXmG0IQcQFUxBp7zcd9qEFo5hmiRUJ7cInhCI5r80CzzfRGQJvKUHkXBZLQ0?=
 =?us-ascii?Q?6ZW2urDUau7cFfN0TjUTES9Th8+shEjfquSB29XhG4N+iu7HF2mxPnjlqfWz?=
 =?us-ascii?Q?Ymgvb2zoR8qqCEFmvIX7Lmr2KFik1Ghl7qweMg3BX5xz/+JXT5GfKi/hVevN?=
 =?us-ascii?Q?VEi0xPyc+7koRwpoEhE2VR1CmLxcXnkns/+KA6UAzhtSoRCS53TUodtTjNo9?=
 =?us-ascii?Q?rOut24eq8PU4bHcDhvUkELyuYsHVxTal7ZIiDpoIzG6qBZtA3GdPJ3XWinXG?=
 =?us-ascii?Q?DxhCEbLxxD1fwWL5JLIw9hQ3VtwF2myH7u+KQfS2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce13111-2069-49c8-ebe8-08de3cb9551f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:39:42.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcNaZ/xZY1pUfgIRkQx3hBx+8IGyWmVJLVtylwT7OaeKu6g+2D8GP7OQd0GGxHl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720

On 16 Dec 2025, at 6:11, Shivank Garg wrote:

> The global variable 'khugepaged_collapse_control' is not used outside of
> mm/khugepaged.c. Make it static to limit its scope.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
