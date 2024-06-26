Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A67F6;
	Wed, 26 Jun 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719444083; cv=fail; b=oEzb33QeTNFHGaWPwooG69b1rk4HXq/LHBfZUeH8s+PbzShGdE2HatOzcwC/gt3ZKuBoabRXyJxHq8uZo0aDvl4e1ekrYQHZ0/UC3JS0yXI2XgnkYD3lC+nsFmCbtDzUNeD4iO/gxOFc0b3HZ6LLP26P8gD86hhU+1YVQqqRJLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719444083; c=relaxed/simple;
	bh=hPItG8IE49uuyzZOmgQtOGYCp67WCuw6WQnIklbhmn8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=czJqDN31z7oCOARQgelbXuFJPuj4GxLOVOQC3QrSHldMABGJOfhvf57ECMXHqHP0Fbz7f17knLIaP/QvWZ/qUdQoNDMNM/Zb9IDARrqNFKuJqIAEQVsm5h7VPj8M5sdbN3RVrP7SWnM2PmMHYwhtt4VGrHqfBsnSlwj+Iay1ERY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JFZd/8PV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mE1ehGZU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFZd/8PV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mE1ehGZU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMTI2007264;
	Wed, 26 Jun 2024 23:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=vnZuxEZ2use61/
	sCNOv6i8+oEumNJqQC/Xq84VGenJE=; b=JFZd/8PViFd5xg1jI5cyCssMQjoIwl
	OOela8Bp+Se3tHpvciXQf/xrbTSSPX9e3fq7sLXbmgMvnbpCwXl4ZuPpjK4RQSgz
	G3FWuYsIbPlgnEjE9bdHlMqf2WffJ6sAGiJZwStK7GNo9kJNEdifqw0oFpYZgrgv
	sV1Xeb+L9cFv8I5Ok7p+geBtODURDyM1599L1xZ90nGppOR0Hq14DEcOETVhI0Nn
	zPI24KCxOnH/qVigCyku7XSgncCvrfKQUu0iPDgiTxaVJ31IffyaYSMxCcMZwtRA
	rVt+3wKI3gloSqaS1/wSRhw0EtdbtRvreaWOMeSoQ1zlUDBDBsSaPnGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7smhke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 23:21:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QM28S2037048;
	Wed, 26 Jun 2024 23:21:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2a6eyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 23:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PElsCpqoXE0bCXCf1IhuXcDisbaGZOlYby/nN/Wuupmu1fhLDlbojY4/F9ndSjhz23TH+RusmnEZ5dUaRWoxBnYRaEUPTvK5vcbULTxqoqbnfbTEAlCjt0ZlORSAahi+TeplmftHQbnMqWrS1lnVkxgNzPngcSLXFVk7HC6JFAfEoB8LKrwbbM+FbrPqm5k8McocSXXERjxvWDvKiXFmCUDomxwUreZ2bBL2aLz72ZttTGkGQBQZHtuWRu7/xBtYqelKuzXigB84mwbmYZh1G9rxvln1Uz3DXGv88zcLKHfzj0oFkPzSR7VX3LA4FGVLTvlwVtI4CaKv7Yc/ZzRIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnZuxEZ2use61/sCNOv6i8+oEumNJqQC/Xq84VGenJE=;
 b=QuAUcJupYDJsfjW3suCSJrmtMf24a6iJF0Ah9mfh0PdqgjrAQY02LWPaHeTO0mzTle1CLl1q/FQ8w8XhqgLnfxwLPFF6Me3CW9j9ml6/ymqVvO6hCkRcRTRlE+Fepu8SMVAShw4R+BdD+UFdvJbNvKhCUG8tWdIE6Lir8cUliJgaHpAH/QpDVBByCUoPImyTe1S82kvAxlzHYItPHh/Hjo7rGXYoboLi+K/T4ClDsru7Oo5ZWu5sZiSdg1oP5Qo9STz9R8T03WxmgakITe4g0hT43NDa9c9psmnPw7vXbLYNxTsOFrDzc5Td6h2LC9lJ5cg4OtIuLIfiL89wJcpvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnZuxEZ2use61/sCNOv6i8+oEumNJqQC/Xq84VGenJE=;
 b=mE1ehGZUyn3ETGKl9y/yg6QZ7TWJkl7cG0eQVQnSx6h5rkWzXURV/+0unTjCWQM+dEDa6XYMhkDvxz96BONQEbWetn2EUQ5b1d3cnZhukMPapSnagoMbZEXHa8RoOJq3KKE3cmp4XOd23AIP935P3EjDj0fzKlbiNBtbmvuj1Uc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB7365.namprd10.prod.outlook.com (2603:10b6:930:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 23:21:05 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 23:21:04 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: akpm@linux-foundation.org, quic_jjohnson@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] tools/testing/radix-tree/idr-test: add missing MODULE_DESCRIPTION define
Date: Wed, 26 Jun 2024 16:21:00 -0700
Message-ID: <20240626232100.306130-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: aedbe9a9-bef3-4cd3-9721-08dc9636a673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k96+/GGMlRkUYgWQVWfGg3ptP4WNDCc8Qp9oaVjrveogAAkEiTew8Y1wld2I?=
 =?us-ascii?Q?bvraZ6beQvGadoAa4f/SxVsb+jIw5EIe+XaZI5+kbp/o+j8eGJJdnsRPdjQf?=
 =?us-ascii?Q?aT/4EETds/qoGd2TTcBzRvEHwLEOmDo+/JPegLbZc6Tku7ZymfPH3HeQPOC4?=
 =?us-ascii?Q?SZqiXo4uANkVYs9rKEPDwzMEUwkK7QoduXrn/91uvl/TIgDY26v9QasMqtH/?=
 =?us-ascii?Q?PucisS9Icm+zHP/i43lck33wyR05//aNXksVjhB/3l0i/DaPfJdxtLncMJf+?=
 =?us-ascii?Q?CTsew6ZUG0CT/PMeMEqqbUlmIkrb906P31ZXNVX5kLAoeqc07Tl8AL7Dz0nT?=
 =?us-ascii?Q?Z4rcWhLd1Nh7D4+Q3p/nwYzba9nlk/L9n0INEiXxnES5DcXc09sZWVzjQ+5X?=
 =?us-ascii?Q?iMcD8HC9NIuUc0laImRyDL/pA1pzG0FZncevAamf4NGgzeCwJsptRloXH+f/?=
 =?us-ascii?Q?zwck3NxtpObsyi1ny2UrotN2Zo8qkByqyFXQk3ANsOMd7T1Hvaag6iMya/86?=
 =?us-ascii?Q?YN1CMqbhACMvMLu8mT0TG6Qx9pLKaCD6ZPq9B6KepPNBFBuT1V/Om1WlxSBz?=
 =?us-ascii?Q?kWmwel+7V4qO0dkMn1N9nDxNs9LEuPhoR6s2KWt/yWtjx+8lr05r/pOeXGWB?=
 =?us-ascii?Q?GfppLRNYMkPvA3mu7Zd71O3jciA7R0qUymeo0WdH70Jth+90/0Ia41LTy8Pc?=
 =?us-ascii?Q?qOJbvl/HqHoH2MGcYTBAdjPI/PkThn6E5zfSDy07810iu8gA4VDqyzt2UuzV?=
 =?us-ascii?Q?/ScJYTRNqCJGoeHAnXJVavCPTKS06RwQPkXWYBxBokuS+FuERhUARIeDWonj?=
 =?us-ascii?Q?zYj+dclHj1uMUrlYtZBeevgocEIfXmHhiIDThfQc04BXHhmrtOKGfz2H9/ix?=
 =?us-ascii?Q?js0Y6rxORflhB1BZn50st2FzOHAS0yd1dljxMm0PCmsZ3oo5oTNz5TkXq7Ks?=
 =?us-ascii?Q?FEbIMsPtVmziH+GppB6ySY64/+hAaX/AI01zdhvxUEtVBdvbpOMLhZwWemQH?=
 =?us-ascii?Q?kC3U+LcZrMR05ljP8C34DV8xJXxRsAQPwL66JUdOJ2N7WdzcEw8mBxMJxHse?=
 =?us-ascii?Q?C7DbwrYZteIeZ8KYXjH66BPajAwQBVuJfjXBKldyvx6923yUXDQayM+9B6R2?=
 =?us-ascii?Q?skMHoTMF7GyGNG1Gdn6tVoP4utw5EVsTt/bNH0TYRcuEp5G/+NSecZq/o6AP?=
 =?us-ascii?Q?qmy8uF0t9lTUOLJ+rtOgkpKAvon1knk00jHb6lEHkLC2yZtSZkh9WMfBZ2uY?=
 =?us-ascii?Q?kQwUk99FyXYq7MWJ8IwNaF8wmkQEu9g5CthDUbgg1vfn2sc966XDIEqln5Jc?=
 =?us-ascii?Q?zyDBtRkneUgssVuWJC9AecstZ3HweS/WIq/L8PQyLLW3Kg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FDUzItC4A9+mI5QKwsWYzNcPSGU2NIdC6MStWnIe/KYXdzmh01PqSMp8FCRo?=
 =?us-ascii?Q?uhmvotUIDmJ0nIAsaDEDZ/vjojQYkyZGLvHh+Lw7OubHy18bcxGPtE6JBbgE?=
 =?us-ascii?Q?VuyYRYak6zHJnVxbB9fM22BvHm+xA5VhfReI8zKhhwnlj6OdwAShqg79Rlz8?=
 =?us-ascii?Q?/lgh1br9zDi4I5TGpDIFhYP+3cogVNh5Jf92WpweXjhnhhek9498BtsO57Zq?=
 =?us-ascii?Q?qwUxS7ckahYN+Dpy5X8Papu8mcHiaC1D6mdCHcf3TGCCfRyfngUKgtmhg+NF?=
 =?us-ascii?Q?V7YmtE8rOXwjPOPjuRIy1s5eKciYdP8piQuDa8wEgwQ5O/vkyPQ2Yuf1nHWI?=
 =?us-ascii?Q?HvnSOcTQ8yTZQfoI/sCzSrFu0OGGZ1tteNs6St2VM1NpzaaK0V+TpkB5A2fb?=
 =?us-ascii?Q?H5J+5/3iNVwDQYW2eIDrvtMA/EnqEwA98FaEJngv52DRv2la0k3zhhzYBw3v?=
 =?us-ascii?Q?eXZHs+Ip01DHtBqfqJ6uMa67mqEnY2uMWHSPB8NS9jrsQhQGZCr7B5yEYDmg?=
 =?us-ascii?Q?nRH734h71sqDRCQcLYhb3p3QRAj69ey6hOFEQp7n+sOTXiWdYh/od8bR2yDd?=
 =?us-ascii?Q?8KRqX1+U7mM00x7T4yTgbtE3lYktiENs0nsVXghW8c/OJQSghE/VWX0rNopM?=
 =?us-ascii?Q?VtyKMg0CS5vHypuwuikjgFnjv1hv77NLVzPVJ/e5wFFvM1UIQKLO2uuCdZDj?=
 =?us-ascii?Q?PJgmgKJ9zs3UfZ9KyF6JY+SLQUxEgRiM4xbDfvnAuiE1cvJtR+sunV+sOPDz?=
 =?us-ascii?Q?jvMTLqEWfi+ECkwRl7xU+Gs7Vxk2ZrT9kBtfgrf4tqyNQXQU2bUHalP60we4?=
 =?us-ascii?Q?TdIkjVUDugFaN0ZyHDDdlDp7CKZXfQs7/rBZbQm7nr6vtDTrxawDyinSFflW?=
 =?us-ascii?Q?HsHdpcbivS3lpjpOQcXt1+CpFQkITmiTrJmU9ZOJomxYHups38KMZWxAnQJ6?=
 =?us-ascii?Q?Gegl6mwMcYVbWwVNaDXuNyXt6+3vHiF6xKhxrNnEXwBMXJjroj/9jKPa/nuQ?=
 =?us-ascii?Q?R6hzVne0FDv5Col4pnLKkwMYPUoLVAjJsjJTK4rek+M6UZRo+MqIhRqXGDQS?=
 =?us-ascii?Q?2B5462rVrhAu9wwwSOTDBhfWyGz+rtG/qD0UbrZV3TM0fe12iYVGfk0h8QLX?=
 =?us-ascii?Q?cpfEUTIPMrqY8zeHRmNScm2TCpI2GtnqaeQ6KgUyXi+lcUPvufay9ITvZoVR?=
 =?us-ascii?Q?CeVp0IczVEHOfemMBLw4PnksJecXRgk1LbegG+Qkb00VuLlMci59qWltcITh?=
 =?us-ascii?Q?u4ZHc5hhJ8WmklGhbjscF9rLYT7O532IEhnRNFxpVx5oCxPn3hViQco7WMap?=
 =?us-ascii?Q?oSZnwSIHHJn9bY9cmgww9Q2+iKlsZwqiX9B5fHKtpwgGpZQx568q6Ky+VLRJ?=
 =?us-ascii?Q?lllpkEVNT/sC1X03xMSXMV5FAhMfPn7YWixSt6KdTQhCToNEiL34V8bCqmSA?=
 =?us-ascii?Q?5MKBIlFQYNEXOPtHZXwDcmCCxsofTUnAd2WCH/LojEyVxdqFwXskoz7g1eR1?=
 =?us-ascii?Q?gTtS+D+oP82JHCAKubPkCXrDYAmp4PYf7EopImmpkSagC93kdVG8+cQJvLFd?=
 =?us-ascii?Q?Pk6XkOpB4SZ4GaanNc2gqTE7ZF2V7QRMMhRmtqK78wwpKGlwzqEYpuV76GcA?=
 =?us-ascii?Q?cZZ9nXXC1dtj8kM9fA+R94I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wz4OlEYgn7uhutuJePaytQKOwk5ZSWOCNFn9BGG+N8q/WD8DqEPksb8AGhTqy+M4GfM3zMVybo8NNaOPbouuo9gGPukgDp0tKMQ8VjlK7A3ziwkYgnh9IHb+C0+lRr0p1c4yKAaXF5WysuZNytRE0LstDp86RnLGyYfRT8GCGDzZ60TzqRPHfTzvdazRjLoI8RX6rxapk4Eg+9leaDwrhZSVg/8nPBa20mPlAcAMsKT87HKxNQSaQET3wHhIlfAMIYVrfv0se0pmjuiJmtlKPISR6YP0Z9W+8pi9HgBOlvMQds3ragZXtMnGk7WCysA4kEoLc8amn15xEUDxHjJTNGHCSXiiEKEMuqF6TJjIt0WwQbN6/xSg5DUr62BLwGT1+dvgmtqPyus71k/TJkfqa5V9vBE4h77R96/fosTkTACYzinuNSnkf+NQm7Dp6CU1KanNXm+CrBL7lz74fK7be4jOJYeSU1F9gGh2yeQXmZHuw78lK9NP4Lb7QUpRWQCKrdMfLuVPD/p1CWM5QjEK9CCz6f60rEifYXG4kx/P6gqSeyvT/J3YNUP58LfI3G63gQxdJEyD4Cb60RGUegO3+0/B+IgohdReTsF9DNy3mhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedbe9a9-bef3-4cd3-9721-08dc9636a673
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 23:21:04.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/CNsofgVOQUBbQjT9lwjCo8ikSWajYO6BnXdG/QV/saaUF+tdGZXOHMp2/TaFBfvyeQo6RkOfEO5KkZ/qBJxEvLA86DLjBancrFW7zhrXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_15,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260171
X-Proofpoint-GUID: sX4Gu4ykVnb4Mz-VnGCZd5ifTjnXmLHk
X-Proofpoint-ORIG-GUID: sX4Gu4ykVnb4Mz-VnGCZd5ifTjnXmLHk

Userspace builds of the radix-tree testing suite fails because of patch
KUnit: add missing MODULE_DESCRIPTION() macros for lib/test_*.ko. Add the
proper defines to  tools/testing/radix-tree/idr-test.c so
MODULE_DESCRIPTION has a definition. This allows the build to succeed.

Fixes: 303474913271("KUnit: add missing MODULE_DESCRIPTION() macros for lib/test_*.ko")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---

This patch is based on next-20240626

 tools/testing/radix-tree/idr-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index ca24f6839d50..84b8c3c92c79 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -424,6 +424,7 @@ void idr_checks(void)
 #define module_init(x)
 #define module_exit(x)
 #define MODULE_AUTHOR(x)
+#define MODULE_DESCRIPTION(X)
 #define MODULE_LICENSE(x)
 #define dump_stack()    assert(0)
 void ida_dump(struct ida *);
-- 
2.45.2

