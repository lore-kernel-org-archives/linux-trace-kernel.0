Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19552367D4;
	Fri, 11 Apr 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392220; cv=fail; b=J+C5p12QeLX1sbn870d1C24D/7wxJhiT8i+3h3ipWdUNYIKFuoIfyCswAnrY8qwz98LLNLZY4/Mv4kRAwWpIZY85vrH85pCqB2/c0q/nYVlNh3CI2JarwdAjsapFjjLVvaySlmwzDir6gBJNzio83Pzpzu7wnZ5fvXa0LNQyMZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392220; c=relaxed/simple;
	bh=HiAr7BBecjSzaL/cHbQwMmPEv7ZCzwZZqQKXqVyI5hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DM3Hpoqk21W9ZhOH2YHPM9Z/CMth0n8KArmP5i6B6Q2fQBs7Yx4L/XuBJyuPKaJIOI3Xee+SPVqdNhCVbk1oaYQLFDIft2iSYKqtLno2avM6zSNupttHsljLqiM5wzKGQkZZ9FkNUDCmshaOc0o69YkEgIyK4m14nTlCXxr2ncc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPk7eB3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bad0aYNR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPk7eB3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bad0aYNR"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHHaR3015997;
	Fri, 11 Apr 2025 17:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=m8hLCH4vOPgsmdXGUf
	OkKUm0Cv2Gw3hk19o5lELP/88=; b=XPk7eB3fdKP53n3k+N04EcoGZAahT/DGef
	3Vq8UVIs8FvEBunTcrIt9Qlsk5cQoimXuuUzeIW8EniXyrxYUnNNVft8er4x9yq4
	nqGeZXYnqLILAeHl9jRj2xAF6YV9PnHiOvKQTjpdkbKu31IYsWSwQQ+F+67E9WX5
	TUubU0ioOVRIBbVQjOEHcr0tp2WFpqUdjmB2dxVFBotM9EMVk4yXfkWYpU5Vd1M5
	/+XITa1l0YYxkHsHjdK8OGVLAT7xfk9nMJrUGV5xA/ff78jE7rW1BJZuyo8JZmhG
	kLmornys0tvYAP//HXN5MlGtNv7toAKzI/lezdZVXr4khIhQoN0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7bhg08q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:23:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGv6dn021012;
	Fri, 11 Apr 2025 17:17:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttymbax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOM/KWhHSmvc14PCO9KI5gnnP+YQqi8HSMCrGKJr+4a13uVTBNyIn1VyvTetT/0QMgoRQX6vj6acPCwM3XSRp1Ce3xC4LydAH0vlD1hgTHNGVdg4pxbWKzMG5b8R7/wSkLRhA9kx0epOxsrCxLdoY8hd/9hexVtcaj0LaP7vxtbOnJmQFQVA1b7WFHF3UwSQ5VuBnudqYJOfL5E/J4tg6VZT1cYWqqk84x1O30lpX7qT7v/l7AUb91ksktdmr8BKwztjXI8vPL8H0lJy3yK+ExAI4Klyg74XvA8Q2IA80ehzSDnuZzWpwfQEb0gnyqVhvUJno83mDQrRBaQfrtwWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8hLCH4vOPgsmdXGUfOkKUm0Cv2Gw3hk19o5lELP/88=;
 b=lt+wm2LUdr3WKaJeSjrgHoOnOi1rQnQx4S/bLatxe7uyyAfCCbuKtwxIzr2eLkDq5HWt3QQt2ppWI744CuY+oIXAo3RhGePPiXiEUOjGOezgPQApHz5SILHbFDnjyWbSe2teueG+tLFbX3lV+/E1Maj0EoWBdN15y5UcgerLargyGX0W7raw+Ur3UucEN86QgkPkIpMMpupmIn0lrOVFuaIMzWm1xbZZ6aRa44vWanCEWyc71JneIF2V6h2CvaBgJ7lJFW+wrAwqw6AY6Ko89Z78PCrYcBzAK+tuKVjbm5WfIlFT9ij2LGwn//QVCta75jXhxzBpC4KTsDfYIJoIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8hLCH4vOPgsmdXGUfOkKUm0Cv2Gw3hk19o5lELP/88=;
 b=Bad0aYNRZLfi3xo9BDzbN3TlpvF+N8PtvizZev1x92VP+HXaEK7Q0PLFQbzM5PGRBl7xa/kQx7i3mq5hkaucimkzITM5kFYLyYmqZ1QWQTxTurDhfi7IgMRaxsfaxzT8gJJw2Jojdia/viZkRrwYfNuQtDrTq4KqhHtPDdNkbiY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:17:29 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 17:17:28 +0000
Date: Fri, 11 Apr 2025 13:17:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Mueller <emueller@purestorage.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
References: <20250411161746.1043239-1-csander@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411161746.1043239-1-csander@purestorage.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7a1a82-ce22-4058-be78-08dd791cbc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBKzaVOUSrJmJyZ+HHm8rsbMiobWK9oOyt7Jf/STxiFC3YI6gGznfizLu/gQ?=
 =?us-ascii?Q?jvnKfoE0Zau82/xSRJh1LUJnB7EDoxhoLoEKFtcUsST+r1Npz/ivoIaio2yk?=
 =?us-ascii?Q?ZSiy9N5uS4PpShynwrUJ6ncjweFuHctLF1QgXfzo0faNR27pu4mIFMpkB1LI?=
 =?us-ascii?Q?LBLnDWyvuv4/vzLADEJXhAG24h2bdW+cKsFp3aEHhGD5NrFZhb1IG08/T4K+?=
 =?us-ascii?Q?SDhK444HeIYSt38qKOBckPYMp+GZPNUDyJzn+w4eH/3jdTmunAsjiTQDEo2q?=
 =?us-ascii?Q?Eoz2Nh+H0dvHJw9JyaV5h4rYHYenQ5nSwjpIxlBGBstkHfCVkdSMexCD18FJ?=
 =?us-ascii?Q?h84RqTCP3HkV6Gfd4kTBbpCvOwJQTK9FUEZlH5Fp+1czGMp0bstyFqDxz1KU?=
 =?us-ascii?Q?jdQhG+dSTs9OGq1kHyePudBTHql1Dly4h1NRyFSsXnv6QBD1ZAi0yx5Q4ozy?=
 =?us-ascii?Q?8Nv2TYVpk4Pe8jpJAWeGtS6NhF1i2QSK5aS1kKYNda0sU1IgbmJ5gi4Yv/9x?=
 =?us-ascii?Q?kUH6ktpYmtvwWIvFbFjkKWfq7+EYrN5rnTLSaYQuNmVJlbWsaFOOzuLwMGDB?=
 =?us-ascii?Q?Q60kaQfFnY7CLi7ErLKartd1b6LaSsI/k0rgyZTuuY3b/n2KJ9bMtKHqNOe4?=
 =?us-ascii?Q?LyTMwue4JKgXrVJ7n75NB0t8qohWIztgBpRWjBMgDrZJbskh392QV7J/JEHH?=
 =?us-ascii?Q?iAtlPdM+okTmod6+A+tvHLbQO6bLSJZP6BAjjsg5QCR2DbgBk9QzD30Y58e/?=
 =?us-ascii?Q?/yECsjXj4i1kO9FMzS/M9Z2T+7zBTcVxKzD1WD6gjusNlTu1QPta6DM8b9Ap?=
 =?us-ascii?Q?ZvnGExIX2nE72l9l1fif0UvNisYA4dmDivEwWKi+RA1CYRLwLPuZNhm51r8m?=
 =?us-ascii?Q?sRGLpvY24T/oXvrbe4ws7y1oEEF2AxjDev3vezJlO9rejvl2vdknRRVpbubc?=
 =?us-ascii?Q?vMlRWZhg8m0ts1IblzPbfbHBFVtZUtWEe7pDw5N+G4Zp+CAnkDz0qLISgaSs?=
 =?us-ascii?Q?afj0Uh5Oy9nR+BHoDqgE34tnv3VJkRcYJHqpBFI5rXOSRNvXDTrHX24DtnCo?=
 =?us-ascii?Q?xGcYElwUcfA57F6tt3ZYTc8w5/GimuKejiITsdW7FFaWT0zpGUgzVrn9Ph6H?=
 =?us-ascii?Q?t9B1cCcY9MqzPdS8TKHfrXa+MqxCqMXTNVqS2wEQL4aoEscm69TZLgqVYnha?=
 =?us-ascii?Q?A4Fux4Wc5jk8gF9F4MR1hS/QqjQ3eOB954U0I001SbNWCEQ9i/+8ADC1w3W3?=
 =?us-ascii?Q?pvhwTpyq03Wp2DAk179gV3NyL3XqJ+Vx69v2V+BfrMvs9Lv8juPjupFyfONm?=
 =?us-ascii?Q?zH1RRg7PAsfrzE1tjxXFirCa33CUPP2i3MmzmVrzrlDU+1LnMEbG1TD4A8bB?=
 =?us-ascii?Q?c9cfBM4G6ZnuCem781+w8fqwjKnH4isZVAFh7B7MKzsk5KVhHAg3XDU8Yoce?=
 =?us-ascii?Q?vKBGxZS3lyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REYY0Zw1FUi1sJuT7RbWP/0YNOqKBFFETRVAv+xDmgzRIID6WB3wu9uRX0Rl?=
 =?us-ascii?Q?NbVRk/jszAOI6C/Sl8CZNKUobLZBw1ATB7beReZNl8gZtfTcU2k0qNosfjnN?=
 =?us-ascii?Q?qAD8zMQ5fQGQ8TEdabQPx5RSSYE2tBBRfsKFyckWyXVfj0Kq7NB+0J0hIfPR?=
 =?us-ascii?Q?bL59Neicy4cn5K4NvFrYcV1vDGPMIFDlDyJX+rxhv4wxth5cPhVc0JI6yuvC?=
 =?us-ascii?Q?7P0FvrUNqOXNJYe1q3LxLviJyXi9G8vuZqeBW6pkpqJDrSiwzXaZWi2lHWWu?=
 =?us-ascii?Q?vIKvMr35ZqXzTunoQZcH0lJysceaO2cf9D9b0jawNdDOkrz2wIzE3Y0Y9I5R?=
 =?us-ascii?Q?1EySqRxjmCrb1vIEL6FIwLtcT8+6yXoGUImAYUVbZHoqnWYI9KDtyV1l88mz?=
 =?us-ascii?Q?MlisN5S37BlF6x+OKXtqb+C3CS4ShKLOv2Gfc1nSV7jzf6pSoQjGzkWTz72q?=
 =?us-ascii?Q?blNiuf4U3pSw+IREkRzMYgN7fGOitp77YnCwA6mA8KnDSGJ3/FVvyyV9QYO9?=
 =?us-ascii?Q?qIgm0ohKY259Kmo2++pIfn0BPm5WijRKXEEyZzAlAbc6CRA/j2S3j2k0bbg8?=
 =?us-ascii?Q?U59bIfJlM1x2lcHkqPhAWaE6Q134Zq8xHdFSoJEWWknEglAos7SSnS24xm+6?=
 =?us-ascii?Q?tUdAmWYJWdmS/gC2SaVFtqwT4NwzAJmIj9PIu1zkzmm+CRi2jWH9rnqw0eMz?=
 =?us-ascii?Q?U6dMVMu186sxWBDOJ/FtUXaMnJ/irPZA5iq/nWsKC2TIQ4WIWIek3PxCIMNV?=
 =?us-ascii?Q?+AFLIK8wV1/wLgtkIjbq8p1DdUfCx3sSlqxUEv5qwE5n5TsHe+mr3DasCPdw?=
 =?us-ascii?Q?ZFi4MZHP5LnO/oB9k0V1G5hV1qjc2Em2iOu/bEZV+HI0GwuDYo/EfS6eOzT8?=
 =?us-ascii?Q?WqWPsd41SswmJIgX8KqWmxY8JbCpYulwurraeQE6IKRJc2B1mn1utgxYIifO?=
 =?us-ascii?Q?7fqilPazG90sUiuZFpFAkgW8DpkqbKwjUgfiK/W9zZVCPkKpmcP0RyFLOj+l?=
 =?us-ascii?Q?1bU2ZUpRnp0TFt7X2DCXE1wb6syJSM4vTli5S6V06QizJfDybyJ73jayV6+5?=
 =?us-ascii?Q?qadvrOXx8P16eIx6bp282EobdWx+MC7mqQWe5vmYgWuSZpeFZEmq+8awK4BT?=
 =?us-ascii?Q?tSmUDeEjusUCrYl+Dbitj3Xg2L/KkCH40VgrIY85UqvwkM3r6TFJzV6rfF2e?=
 =?us-ascii?Q?54qMH3Pa/fiDlKUpG+vVHJBXCs2JUZklmzU32Jj0yS9FNeqnkhfjfLIN1epB?=
 =?us-ascii?Q?25JQJgn+pbIIw7e88WkjqTFgjxU5UvycbYJ2X1IhG1aq8BgrGAQAeS7nsk3j?=
 =?us-ascii?Q?HfZHZQXfCGvm+4GZcYC4I6XPh7Vun6xXSY3hFYStHB/MNFn+RMm9U2mPi6R4?=
 =?us-ascii?Q?1GymtazbK+sugi7Kpek1ZURG23JmBaw9GSL+JOxoEfpBgeih9makbovOkLWR?=
 =?us-ascii?Q?rMRHEJjbQPoUbCr0KxwPzmpKjdRZr/LrUd10lYpFPxySKDlFfG0oEj9AtNVT?=
 =?us-ascii?Q?gCLHntl3a56CczcTk0lUXR2p5hwFH4c4te9hXvNRVlPM1ogytgccDee6sei6?=
 =?us-ascii?Q?jwLV3JS3HCI9F0fTcX5eoBdx9tnDKxwKaAaKFfCZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6b1jg73yJBuaNMrF+uYlw2GL7lpETRsyl3lnYytUfFIONOmDpnoKwwsWfHdkqTiVq1kzc4s6KT8bUbgxcvg0vSnVxrNgnXutZQ1APlzdSdpkPL4H+D91MoaMsIJtrwly3aVatwoxM8DlUu1W+JYTx56XFFBYotAK37BeUqhvJ4xiSK0zQnzHcJHvi4W5P3nWSczzs4AGIPUlYeY0YaW9UPSOXigfJ4dO6gKaU4DLLZM0zsWelgajXwjLPDc0T3Kh1lGc3u/4UyJNHHWias3KWyswtYpXNhk7zhHYaYSCraeCXHcUBjLyPiDlP88MpXW+RN4lXpT3e5swofEkDrpfan66z6uF4rpnXJ7k8yrD0CV0s/EYciBy76ZvMvzKdEgVBdS5jgOB9QWfGNB6hvemkP1WHFh2Ha6JCIdBXfjsZ/FP2+aEhIZNzx3WyesEKSdC4gvADyNV0oDwpcn6PCiJbFOTqGxtqnhav+lmjzkgpxyXYAymw+wSqMNfe4lIu3kiKyqr6xyJIbuQRzaVa9bquI/6457VgragZzxR3ntnenx9PjH+jBvfPRP7PH3kiaWPBWtQ0yKxqWTyvAmJBNQk3tK26WGtoCfsXYm8WbIdEZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7a1a82-ce22-4058-be78-08dd791cbc9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:17:28.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqqQJ98sYR56MOiVL2y6xKcNOVyPI0N/Sr9Vcor7QxAEFFWfFJYuqiSQdC6bTMdUVGTnvEoAoU1xQ5GYH8t3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110108
X-Proofpoint-ORIG-GUID: A1jqNfskZWrYrOLMtjfpsv2W-HrcYqdq
X-Proofpoint-GUID: A1jqNfskZWrYrOLMtjfpsv2W-HrcYqdq

* Caleb Sander Mateos <csander@purestorage.com> [250411 12:18]:
> The vma_mas_szero and vma_store tracepoints are unused since commit
> fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
> Remove them so they are no longer listed as available tracepoints.
> 

Thanks for doing this.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Reported-by: Eric Mueller <emueller@purestorage.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  include/trace/events/mmap.h | 52 -------------------------------------
>  1 file changed, 52 deletions(-)
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index f8d61485de16..ee2843a5daef 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -41,62 +41,10 @@ TRACE_EVENT(vm_unmapped_area,
>  		__entry->total_vm, __entry->flags, __entry->length,
>  		__entry->low_limit, __entry->high_limit, __entry->align_mask,
>  		__entry->align_offset)
>  );
>  
> -TRACE_EVENT(vma_mas_szero,
> -	TP_PROTO(struct maple_tree *mt, unsigned long start,
> -		 unsigned long end),
> -
> -	TP_ARGS(mt, start, end),
> -
> -	TP_STRUCT__entry(
> -			__field(struct maple_tree *, mt)
> -			__field(unsigned long, start)
> -			__field(unsigned long, end)
> -	),
> -
> -	TP_fast_assign(
> -			__entry->mt		= mt;
> -			__entry->start		= start;
> -			__entry->end		= end;
> -	),
> -
> -	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
> -		  __entry->mt,
> -		  (unsigned long) __entry->start,
> -		  (unsigned long) __entry->end
> -	)
> -);
> -
> -TRACE_EVENT(vma_store,
> -	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
> -
> -	TP_ARGS(mt, vma),
> -
> -	TP_STRUCT__entry(
> -			__field(struct maple_tree *, mt)
> -			__field(struct vm_area_struct *, vma)
> -			__field(unsigned long, vm_start)
> -			__field(unsigned long, vm_end)
> -	),
> -
> -	TP_fast_assign(
> -			__entry->mt		= mt;
> -			__entry->vma		= vma;
> -			__entry->vm_start	= vma->vm_start;
> -			__entry->vm_end		= vma->vm_end - 1;
> -	),
> -
> -	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
> -		  __entry->mt, __entry->vma,
> -		  (unsigned long) __entry->vm_start,
> -		  (unsigned long) __entry->vm_end
> -	)
> -);
> -
> -
>  TRACE_EVENT(exit_mmap,
>  	TP_PROTO(struct mm_struct *mm),
>  
>  	TP_ARGS(mm),
>  
> -- 
> 2.45.2
> 
