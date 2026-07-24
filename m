Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023108.outbound.protection.outlook.com [40.107.44.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC1442FD9;
	Fri, 24 Jul 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909888; cv=fail; b=WEH5sEHZ8o/Gg26RrUibkeajTlFEydGz1XO+rb0zQ4Pb9T6PyeOwVsxjjvbdBE1O3bFQl3NWznAUuFMuh7ERS3QXmkQeW6tInQZMRrVSNophoDOu2E/UyoZPW/1r1310XsIrw7XIGpl8BEtKCAvNzY33HGZXreYO3ThyO9fe0uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909888; c=relaxed/simple;
	bh=2Sbm+dTI5TKEorLsKkYu57h8SLxXVggj3+owWa/7S68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAQdtZ1jczd/7PLndQdK8Dr6kIHzIl8Vp/CLlQzIbIaYe6dfkLAbM2wsLg3wNinFZ6CdTNiuimlTU1RoJgbm2tMq7sVS3+CDo90xL74d/QUosAageJSo3Q+WW7ufbd4NDb+Vt/2KaP2OnM3fAjiiuO6kIb/LeGKR6kgqFGfm02s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=HlpopYWS; arc=fail smtp.client-ip=40.107.44.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="HlpopYWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miwBUGvzDEPLPqM01fm4Q1WtUtVC7QMEd6poSB5zpg+7+CipgIygAX/CIcMLFjUFi8g2Uc1FFPj/72iqo1+zBde9E7EYROKGtCIHx1nzUOrJ58U+DkyUZrM3GgkSGh3SbXjjzxHEeDs8XMXtyDl4l09wnOGFv8C3lysdibFw0yn25u4qeiFilKDMLR54brerzDXD3UZ4vt1C/zT1UkqplguLDsuxjtxQNfMBRoVcDhMb+1t/rl4nm7+Trz9wNo8xIoZSxXDcxoEC2n4EhXU3Od7OMNt/aMHUvE5b//lD3Oz/CnmsJzZH/zU2pYn9Popt7AOAShwxRvjWTZ4uQrIRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXLpL7LLeRsVlL9qaxKew5oc5MMhvftu4Wt0PVsScy4=;
 b=FA2OeozSkvLfdv5E4v7nUEQ8NzIYSDNClatC6RZz+jOSCKSjnTFPtHAwYZnOrTAW5zeWRqyWfTyL4a8z0JSPiCaoClEl6/Skq2rZn0YupeNu8EDsLkGiQL2ZzSfcMLlTsn+kcXrZZg09sIuuR6ne4L18d/T5VKxKQkZcsMfauH+qpIIlzLOboIytPPH1d+0CXBOilMygokE28WMWAGAxzq38t02LaD5ryX0IjsLdk8XZDEAi86xjbtzhjNUfS0MTQ/Kfz1LxDzhDrw+vbaH4jdyDkR/pqBpB3KuxpDqx3XtDnqZYYNTdD55i9j2602O/W1AkhuCShC2DOutMZTT17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXLpL7LLeRsVlL9qaxKew5oc5MMhvftu4Wt0PVsScy4=;
 b=HlpopYWStPyJ2kiIO4aODvdouMxv2H5bsFWQ9ErQyq7/33EHiRB2dB2k1XMT6PY+LVxiuMXj2ffux5P1tOZ4X3Iad7X5+GHS6qRa5K5NGqo1zlAnM2dK4CILmbTugkldfX7gP1JLtNLBdAQUMoV0euNHA+2xOL4SOiWHQ///dXagG4lnnNcUBAfgu9GZCD3215usKymPiWV1GiU4g1xVrqNP4+hh/LBXqJ6wCXGvjdTS7lhcazaqiwdFpTU/EQFC6kKfVnL2nqGjEdXxvhyOT6KL1P8SsqssS9MgDLmSfOx6YmvozrUARfQzE26MJZLXoNYepTvF4Lb3sjLe8OREaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB5794.apcprd02.prod.outlook.com (2603:1096:4:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 16:17:52 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 16:17:52 +0000
Date: Sat, 25 Jul 2026 00:17:45 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, lianux.mm@gmail.com, lianux.wang@processmission.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Documentation/rv: Explain epoll and aborted sleeps
Message-ID: <amOOoorD5IXKKsxk@ChaodeMacBook-Pro.local>
References: <20260722045706.85633-1-chao.liu@processmission.com>
 <f2679e058fa3904db3534a5f75d1339a4065018f.camel@redhat.com>
 <amNlh-GZO-RcbpiL@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amNlh-GZO-RcbpiL@ChaodeMacBook-Pro.local>
X-ClientProxiedBy: MN0P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: ec713570-d017-4de7-6a90-08dee99f1ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34096008|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LwUVzCHtUhJiAqNDw5EkOJ2wVauWb5T+H0THRaecybnxl94HcaHxBvvlRpX9upnDq+0/pWJiazOc48YnGNwdZ1JfKFrEVbYoU/2uLliXAtftUNSm3TK13wyhjISR4Xt3EbtNJTe0v45IyjbALsb6/09A4hvo5vN6324O5S8FHVLB+CkVK9lZFZYXS3/vLgwwcgIF7n6X7GLBoDmBCNNi0A4dP8Clmy7WH5hcA/qKDPewYaUjArwu6sk7P/97E252GCi/5RKpxqQS+g0QcVdWmvI81lfWNAvyZcegrEifqcaxBaXpb63bpF+tVFuG+A/xGsP3toydX5pBy8RKliOtF3kmKVyYU1pZE5xo3wbA1BY046dEi00zthOHAFf4CiIbNpC8PrOaVaaXgrXOlY5FLsFuTSGLDFhD5KwRbhwJHCQDghQcB4OTn1lf0OdbKCvsdCiu8VOJllXu3u2//7IwQC93bcTjByiBU6WFjWCFc3cb7Oxc7M5x9UIhH5B8Ci8Z5e8vKufSigIXWKZHWnMlpF6uqnA+ydWPNXsPdpPCBa1WOvQUVnS4j5Ht457+ykDFJiLYWMphs/uLgeYsZmSB123G/Fb4GLyf15ZfOYVqIaQz3BLoqOvuIXZfgXVJUqWuqEma3QKJ2xEcA1BvHfe1haf0d9BW8CSkFs/fp3VRaBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(34096008)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YaequSSTc0x0BKhjefk03fsX9Cb9aALslW+M3m4X/ORtK43goG152VQoD7Es?=
 =?us-ascii?Q?A7o1hwkn0JvQlsRA0ASw/+nU5GZispLt5g7a27exTBxWArURQ6L8ltct5ab7?=
 =?us-ascii?Q?Wz+CAigApqfH7NzhaeH9ypXMTDxUnm3L7aYG8CRkRmBww9Zxna0pwQB+0m8E?=
 =?us-ascii?Q?NTKwrRiMRVFdtnhe09MT0dptXSqjdlXKCQ0yvScCpLIoFyJ5DWzUU3iA6Q65?=
 =?us-ascii?Q?F/XrU94TUhAexvRVEL4rze5ElCO2yOlStINNpJVUl+QjM5CQTHCsUa4Kgl3Z?=
 =?us-ascii?Q?sfV6UVeyaZ/3e/N2MoKyeyNSeedUNZrlRI086i/kTvolZKgk/ucRArk4Tbhx?=
 =?us-ascii?Q?uvjGAL4d8j6oCZK1sz/WEVa5j6nB2bmGCy69T3UJDWwGa7/kGae0uDvomf+B?=
 =?us-ascii?Q?0iE/PaTnDTqxcmr+AnoJDsd172uyaPTe6FPO4bSrTeOMMh8TAn20fdTuLOBm?=
 =?us-ascii?Q?ZpgrhoUFqE48lrSJtRcnFrvmVUZlrTig/hASpZGz3XEJCACWy9P7lG4iOyvT?=
 =?us-ascii?Q?j+n1apTxzJZ7bTaqVi8ozbWzJzTHzK1lTxsJG/TazOH+h7AR2aYC+Yo+8Sya?=
 =?us-ascii?Q?H5PYSW3vmqJvA0ecHN6cTdRv1ma/8NL18tIFwvhkgWbGIgR5P3GUcUx4p8Rv?=
 =?us-ascii?Q?uSSwOufdsVHrXu+M5nD8Ax/6IiYowYP1aUu96GVfCaTubCTQeXhDz3psDr4S?=
 =?us-ascii?Q?y0V79Iva36u9lk86SMV0mnA1SueYFXrNafNKFpVLMtCZQQOmJIkztEb+/ETy?=
 =?us-ascii?Q?kishr4aWerBR1xsxc8ow6ZklezNwcFbATPAkG77iHC7jPn9ff70bp1oL8FLV?=
 =?us-ascii?Q?LitPCtRDTEWBf7vjFbtTsM51uxwAnqBTvVjNKtRO+mfGz+BnVACYBO1lcw0A?=
 =?us-ascii?Q?xCO1JvKZ1gwX0D1qMGjDY8R1fp2QxqkhUFAWe9DEFaES+K52vxBOFdgOOGTO?=
 =?us-ascii?Q?frbhuI9U1iKMjO6liqZLm8N/kQidGyHUl55OAuIGqSD13c3xWar3YJ1Ie27a?=
 =?us-ascii?Q?P5v4RdTrG7zBfSXRWhHL4oZa2lnFXg+a9fMtuzDxCVQjtfbpdTrqlppfVfYY?=
 =?us-ascii?Q?FYRaGKftgd44GLkUm+Mhqw75TLE+VqelTMSLieOLPBNNd6FTzSNksTqpfVh6?=
 =?us-ascii?Q?ikdynVRddkl+WszHVF8jhMA8c7z83qPnVZBaF08XsQqoHE39OQU8a/hUnvyf?=
 =?us-ascii?Q?HV+E3BbvW5c6eiBegxAOHGf68NNS8HS9MCNEV9S81PaJVRNNvh7tD7J7nkeN?=
 =?us-ascii?Q?xCVeBjhAblGCWJLvh2j96Zfjx+YjYiqP+a1tD7S0qZJNQ+f/ogKu7WQl7hYA?=
 =?us-ascii?Q?nIQK6jwDlJK04loZgNeRfly9KYOOgxjzOsBOYUKQAur1V9tvkUz3+NjaKq5N?=
 =?us-ascii?Q?YtNutaIWENSnR/NtjSHxJIDOLsthXXRfrj+p5f/lDd4WXDNGbIGxN23DJeXU?=
 =?us-ascii?Q?dGG16LJJEcsXJOjdWl/n6ltxmt+khDpk9lr3kF9gTV0fzUJAxPdqRQBvdWOv?=
 =?us-ascii?Q?8yju1EyAXKoNIPzLsHX6Ng7jeirWxhNKmoNmugXUHlZiTxLHkRWCxeUeNlqF?=
 =?us-ascii?Q?lQGNyWcEpD5FxNjY9HEBral6lIREhWzk/7vhFXIru9ko+G17auUYzbYCg+Sj?=
 =?us-ascii?Q?Wwt0Q/rm7lHbzbwnLWVlV+IyX4+yZ2S5M0vX6i0b/lhsOFVAUDH4qfgL73FR?=
 =?us-ascii?Q?g8f5dtqX6BFLSq1l853siNJcHb6q1uf8JD8w7Q1aHKqoT585IMRZbG7iuvmF?=
 =?us-ascii?Q?XLbDfuCY/Nm4iPxdBz5eEUEdeSaJ9Xo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec713570-d017-4de7-6a90-08dee99f1ca4
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:17:52.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9yOEo5xNAawrd0Qvyb9YLMEUHwWfyatRZni6YkkZU6pIZEXn6LYvEYmf+ehaN6QLGtGO4VG8ja2wH0oeOB2CUnAVZeo0SOilonQDz9rr3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5794

On Sat, Jul 25, 2026 at 12:00:06AM +0800, Chao Liu wrote:
> Results
> -------
> 
> The first two rows compare arm64 without and with the experimental
> mapping. The x86_64 row is the unmodified cross-check using its native
> `__NR_epoll_wait`. The arm64 rows enter through `epoll_pwait`.
> 
> Each case was run five times. `M [L-H]` means median
To correct the ambiguity of my last email (sorry for the trouble):
the data in each entry is formatted as M[L-H]. 

For example, in the second column of "Ep abort": 26 [20-28].

> `[minimum-maximum]`; a single value means all five runs had that result.
> 
> +----------------+------------------+------------+---------------+--------+
> | Case           | P1 err           | Ep abort   | PI block      | P2 err |
> +----------------+------------------+------------+---------------+--------+
> | arm64 baseline | 2043 [2031-2047] | 0          | 0             | 1      |
> | arm64 mapping  | 0                | 26 [20-28] | 355 [308-399] | 1      |
> | x86_64 native  | 0                | 31 [25-92] | 201 [147-204] | 1      |
> +----------------+------------------+------------+---------------+--------+
> 

Thanks,
Chao
