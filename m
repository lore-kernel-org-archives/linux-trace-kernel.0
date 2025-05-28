Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA61A9B3D;
	Wed, 28 May 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447320; cv=fail; b=lW5QiW9M9qwwxjrKPurGXSBiT+oNABLthXdY7ULEhOUICJomEjUnlnQ2bCmbr8q7rN38ZdIFlv8ZOmSs03whWPv7gKKS19VIfo0jr3wDdx6XQB8MsXoUeTgzQBI2ozjzFhpxRQmeSgyWuhcaznARNO7Iozi7AsT9QiyQj3IVZ9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447320; c=relaxed/simple;
	bh=gQu/MrtEsL/EzDtmHnwUA3GzDauoEvln4Yb7Bs8eWng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bDMLesbEr60dTBNwLSrlNx/eulJBp3dxQiinGfwSe96Ib0W/4J8qbX9oXYr4xTEDg4kdIC71LRKwAk4zTMZ2aiTgmzenDpUB/KihbUh/aP0qdBSFBSLLdg0CRFFctF9GCT89vKP/jh6WfjMVwYV1EJaaft6Q646wGbWzS4XFmxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WrEOE201; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WtyYr0gw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WrEOE201";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WtyYr0gw"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqZ5W024175;
	Wed, 28 May 2025 15:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gQu/MrtEsL/EzDtmHn
	wUA3GzDauoEvln4Yb7Bs8eWng=; b=WrEOE201Kwwe9rgdqCiHb3x+t10vIvINYv
	dBmmqCvUh+bewpxp8vZciOq4dmLUConnJmhWw2BTAIA2E9xedgXEWPJcYnNZNNGk
	jpzR3kYMZn2p95gJGbAeEE06utMjTDVECwnN79HiUYkdivhXM6l0/zmyzzYJoRAR
	8mIEkntT+ev/RKvtrJ21+vzRCOco2mt45c1Q1niRii77wk1ozP35Js7RSaGNEFgI
	Wt74OCPvvYrjofQ1CuwfkwHBHHOy3S2Uy1sDFDyx3TosTypfI3H2ppZPR2IZWWXF
	gCOtaaoiFyifnkb71Pk221BHF3faEFjNKnRjSptgQKQX7Yizruig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33mx9nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:48:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFG6tT027834;
	Wed, 28 May 2025 15:48:20 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jakt4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh9F50tm4vLkUep+tC95clAJCZNoguNc8TzrUAbCVQbg55AHSCUSj9e3ksLaypUeTU/++t1VTvQZbDmPh/FsQj0u4ChclFVgrRnqLtsBEOl7cSCgnO5Yz1nDjQDuxMKdWalXDVqaWfsuZJ3u0tDZ+hivahj03XgLg8iWH+w506r89FebonDlARV8/xv/FmV88zqHPYXWNeFDtGnyHC0iH7oU6CcT5xMRs0HZqKsXPhUsjD4R49CI4e7+QrvpikBSPgnx5jbJpAhGwvNQuVBnDjquAVakeC0NN2mdcliL3FutYaP1Fs8HWDUr01/7kVPeBI7Ycmyl0kCaSRJpd9QPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQu/MrtEsL/EzDtmHnwUA3GzDauoEvln4Yb7Bs8eWng=;
 b=f5XGhbjacMpocr7TB2C3R3JCsGt/jsInoDgLAPxgRImn3u5jUBW/u/z9QS1B0Q6ia9FOt9ES7ZU5BrM0YWvyXEdFS6NKWo4qxZuQHMZwXESLOtq3WkPjfqZUPZ15vh+P4/rUrQxmYrbYFW3yw1tefUa9VuuurMPENhD1LpaBDLA8f4Cck8foCBLeFITFdPnNQ916gj56lUYllU9Fe4ERDYo50E7kSnWx/0o/zt273VYQ8ejlh/M23xlFba9jmi90ojuziJLMIRJ1FlcT34F+bskxWIAdXA1Yv/+0k/3S1J0xQiGpaVotKK+Rs2yjqi3jBCCgxa2gze72F3m5aOKTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQu/MrtEsL/EzDtmHnwUA3GzDauoEvln4Yb7Bs8eWng=;
 b=WtyYr0gwaLU+lo4wePukctRkHQfFYCSpOpWmpVbY5WEjXshhV6/YjoTUj02G1XsEkjvBFGJNSs+p4dlnLQHFoq4FQ/vILdMIXiSItv9VQwCtnGrBiRq3bPdy0HGhI4QjmmI+LExyQGKX0jzdcsQiln3zVS8Yo7xfBKpubpS4PZw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4322.namprd10.prod.outlook.com (2603:10b6:a03:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 28 May
 2025 15:48:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 15:48:12 +0000
Date: Wed, 28 May 2025 16:48:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Mueller <emueller@purestorage.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <b694c72b-0873-4123-869c-134709341e19@lucifer.local>
References: <20250411161746.1043239-1-csander@purestorage.com>
 <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
 <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
 <20250528114549.4d8a5e03@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528114549.4d8a5e03@gandalf.local.home>
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: ef072726-a1db-4e58-ba73-08dd9dff0d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opJfK85v7BVMlGk6jJACGLkbtPj2ZZO8fj+Ew+ID6ZHHTFajyT2IhIx5aiQJ?=
 =?us-ascii?Q?wjlKbGdU1FWQJOstoXsQfEI32PJHqrJWB93dMNQrqVAt1+Czs+Y1l5t6lbZf?=
 =?us-ascii?Q?OQFvzwXACchHomMm2hr7OUvMNQ6IsgJ2Z8bI+SVJO6LdvU6OyQgkPgdImoEX?=
 =?us-ascii?Q?6UlTT9vQh7g0+8PJNOrPrd+PMYLwsWxL3puauWLF6TBGasgsWvc0Idebp3HV?=
 =?us-ascii?Q?rTDWCvAfZahrPifrxu/IuJuJnQ9jWMqDO4CJoEqBZaJwcjD19a0ZTA9B6k/o?=
 =?us-ascii?Q?PsSUuk7tY0v9W5nZz2IXCiEbzh5k9cuBdkWrUcmlM+acSQN+8LXuvAiQx+c3?=
 =?us-ascii?Q?Pk+abu0ATkDphMa+41cIAJWY8udRPg/aJavwb9h4vyKj0pMUCR9GFDmuTexQ?=
 =?us-ascii?Q?TUXAN2QhjoXQIEtRvZPe1LztfD22I+1nYLeSw8aAirR92eIqs+i6zEcIuTla?=
 =?us-ascii?Q?ZbYy/FoiviQtSbaLoE9wj8rYi0pjvfKDzS6yDosaEPjlknnZtgfn5RH218et?=
 =?us-ascii?Q?79l3ssbCyJcDXlKPhrDCLtEB/lAxoCKC2rHaefYvyaxGFBvLD/XHui8qh9h2?=
 =?us-ascii?Q?fhCHUHCYcZDs2BwtGOWoFZnDehMpyeQ3cCTUHefdn1JWFDwD1CslPU85OFcP?=
 =?us-ascii?Q?73y8pId3+SEr20dGLQLloryxAAkA3pajE4pug/HP3EDV2vC52eXkRGqOccfA?=
 =?us-ascii?Q?lMMQCyluucQQQal8p6r1/LfH0Hmpeleg7lxzaSTOqFXZqu1QW4bFm/JIntw6?=
 =?us-ascii?Q?ZkHDErzZ+s7p/HN730MJZxkSamGOlNNPp0/asjYB/Kdq/MaV0o1qqhwqG18A?=
 =?us-ascii?Q?7PZhEe5HHVLdLcI78JXM0oBwwncgrPJocVnemO8xGdGd/EdahP3qjpWV3J+2?=
 =?us-ascii?Q?n2TYjt+/e0kbKZW3uETWbxbH5xjcDrYes90NwJZjbhVtE61ccYbjpSI8vegv?=
 =?us-ascii?Q?lduaBFOMVtXMo4viQh8TIpRFTCcX15qMhBs2rJxBZZaBPzZG9pvobyGwLQUq?=
 =?us-ascii?Q?09/8ZboTfR8z3Kwj/5yT2Pi7Uowdsfg/z0nRY2qaNKW+rdnbCdl23j05soQf?=
 =?us-ascii?Q?vwWaAkiY6ITSWKhFrUL2CSbUxcEgqzmg4IfCgO8pLY6dk+nyxIED3ZEABQMd?=
 =?us-ascii?Q?UQoFASLXIM+MfsuQKkPXqCxmrHPG67VyW2xAywgsqiq+3tjdNP7GrgWepARP?=
 =?us-ascii?Q?rVbEMI/vhOqDNLY2mUyK8vzqzAFRGoiS+m/OEUG+E6hyu2NgrsF2bmIpJJb9?=
 =?us-ascii?Q?qYPWN4obig8gv+5l3jJXODMG9EM1sn9w5XgV5jJ0M/gx6EiCGc+ChovN9DVV?=
 =?us-ascii?Q?g2Wzgg1Hub7O7yy3R4giNTxoHL9g8QnoqN8gy4X8Bq8o5OAiwd2t33eIsRxW?=
 =?us-ascii?Q?8URVfRiJu3Yw5ayDUnXJamBce4Tww2gh4HyAl1YDQbtXk53K6PbYeUHoUlQr?=
 =?us-ascii?Q?PcIPBatLFV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZhwgoW9WABH8581vziz3s9ezGljsYw4xAQTKruA5JIlTkNIWyqP1Ims+tX3?=
 =?us-ascii?Q?VmOk9n8iLNEWH81kfQuvkzI4t4KZsuy7uyfdE6RDYCJSzmjQJV4m2qsTxHan?=
 =?us-ascii?Q?qCDfzFpvXjwJ+N2CKXqJ6ChAKIKVwoe9oar/e1/s7jMT9lSV5g40D4Shu923?=
 =?us-ascii?Q?3pSNrX6SliDoi2eRB/7TDyaZEQrxHzmVohy8/1ONACtNNFrNUaSJjMuLgp9t?=
 =?us-ascii?Q?wzy+9GUNOTNUvszJ/yTSxEGImTubxHI6BPhBjp/7CZVw5vR5wZMx9AgER2tm?=
 =?us-ascii?Q?4mL5PaKjsN5J44uOI+wT/dt1tj8bnvJ8s888KRoh163l8Sc3BJlfSOOILcc/?=
 =?us-ascii?Q?PBtTwKzticBpDzUEkDZMW7189aoIEh2aZbt8Ewi9a6V4+HwlV7mwkZrRn/nh?=
 =?us-ascii?Q?bSmTXGdUCylzz8fhgl+5JOhyVgMAqiV0+GOBnmOyp6qZmfX6N0A5GoyV0YdH?=
 =?us-ascii?Q?3N0r2xW3/RhR/aTaF56lPTV9odtnWEaKQw/vwabh19BY//HVTABzXQeZfp5Z?=
 =?us-ascii?Q?VDLGXlWrUv6iEzEQiGoiNxy3SRTjgO8j10J7H7bds8mEGus0oRa31a9f/yZX?=
 =?us-ascii?Q?i/JHRqkC8htiA/Q/s7rf/Dmrhks6F5xI+3cguK0Lpe1M8148pKnw+Pp1/DSy?=
 =?us-ascii?Q?sJFyU3y3pbHycH/bIPJj8QiszlC1nPEG2S/GLbE9tb/MKhlVOYlv7QZu94J6?=
 =?us-ascii?Q?pZXpHtHsFsCU/WDLkQaoudx0lnkDIvu/p99LAF9j+Fd7IAx3MTfWA3csXmsV?=
 =?us-ascii?Q?BHMSfEYFZAyC5pu291YaYqfgJY6lC5V2MF2Xd2VVZkH7dJvsW3TEKq+aGrR+?=
 =?us-ascii?Q?Ml87S0dSxVpOHlhJmMkAYJabYQ+oY+n1EkTP39UU+A8w9xo4yxN5dlMKbJNS?=
 =?us-ascii?Q?y/wA/Nkjbcr2C1G9WLiefPw/dEQIQSZYDLWA3SLA7bErvAqyQ6bWj0E/Cd7u?=
 =?us-ascii?Q?bF7raXfP1ruKAwPDdCV1V6FgICgu5b5tebSd47II6OChpD0HgSkfL7tptKwp?=
 =?us-ascii?Q?gaew8mVoRLOAIs1cpOENBfTsf1ilLbBBubB67lu2GuV8XTUTfFljEU/JPNGu?=
 =?us-ascii?Q?MAtf1DgmN3ReZzh6Cm3kDQ2X1LguOaDVrUL5C2JfUkqCRQM9oywiho5P4yUO?=
 =?us-ascii?Q?f0Cms8nd4vcS3L3OeBhQTqYtgUlzYSKU9+OZpq//nl9plkd7sYhOXxPuixuo?=
 =?us-ascii?Q?xMj3ftW17EhUG7fqvTa2tNTXvguNNHfyFyo0cxdN3IOe0HjNNtuOF/9aBQ/Q?=
 =?us-ascii?Q?z9I9CfNtya16MuhGk74PgKk5kI/YCZZqgT+f+rx7ypMsob0TikwIiVbbUqw0?=
 =?us-ascii?Q?DTy9DJjvDS8/pygM67G3u0tJWR1IRQLoqIuCMwlLct7pZ+p0IoxgY9VGJ0XE?=
 =?us-ascii?Q?4nVZkR4Co7PofCIblDeJshq3FK5nlMaWHXN7Dw0n/tCV49a3zvQbIEtb3ZSn?=
 =?us-ascii?Q?JgtFN4i1by3Da5iB4gvGFSr7MsHWJS789w8OKMZdp5OMPDTVrYmr0//K4kfm?=
 =?us-ascii?Q?JaCLajZwHPJZhOTjXBm9AZnL6C4nnh9NMqZR69iwmhPkvXclpu1xtG9DHMQo?=
 =?us-ascii?Q?ws7v9yFPJleU1mCUCn3Ty930+3Hsdn31HamPLvkbNh8tf1CQuv4PsBdH227X?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hZ7UbIOVKzuROiJ6dkNlevP+ZlThgtYPY9266yX+iBiB7qweW292nf6X7oqTkBEXz8KbPKQAfgIryNjnhfGrdu9Qk0E8nadl6zu/QJw8FrhzzqFdhJPiYea0RgTx+Uwy0y6vrO4BJBKgw7D/zL58fFCgJa6Eb2vs3aNp2OM7HFceFTU5ERS/foe6KV39TKcdLL+o+GPppFAT9yHLz1MTrDO7jy8ElqO0HAf0i/L/lLUmCTMP9KBcDrLPGX506U+n9ZXGuAuWL++vWBKzdw76jA4H9rD0Vz0Deo8GWh7L9V62y3MZvyC88UrQWEVc2UgOTobvCB9M0c0pQIpXqGi66St2mGZ3/UpvfPDPdFIg3S97c8wHIuj24USIJaz3wvm4u5bfZIeMs2RuQJ4hHyoNVe9DfXzHQKfiQoEFYQBbFEJma2vIfHNoqTaTylgzLgJ9DTJudsZK2AGuSalBqjv6OPH/7f6MPorSiuY/TT3/oX5FPyN8iTnTQXM24CZwJ5ZZDme7Y0UVqEwCEpb7X21TZXYy3ReU6ofOUhQNvwIH64Q4s+Rzu4mrMjbhmHBJPCEch6Z3xAQkIEZVckdMaC+qK+2qOgc98JqLnZWqPILRn4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef072726-a1db-4e58-ba73-08dd9dff0d98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:48:12.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLPCE2D0x0JOM+UBmMsORvRXUf06QDFVizdSwcukL0P707dNzgWHZAmUuDYJ7Um6iDRFb5gr6ljvSbM2ZrV2BYsf6n69dTxYwKz/tWqmRjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=572
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzNiBTYWx0ZWRfX27eHZVHP7I85 6foQdsviCHOLnMUpXk31J22d7IDZCdP3u0/cf0zYM5MDF4tT/GBkKt2czuwQKz+s0eWnhIXNAW9 ZMEm1TWUEGUgT0mrziOmHtJPf7k1h3uFZwcj9DJtam16oCDRVGmSmr2uq7YYg+U66GzLGiNv1ye
 LkcVs6/ci6VOBhhK9EsE4VGNN5GaOoNpDrKdqrgy1S/oFz+QW2CO19M/lV7x6ybp0FMif1s6LGu 8NoyJauO+1TW69Vjfhv/cMVaK4eYcNI5Vf+7iRENrV9JmL5QQDZSvVbY4hUwBQhtfhJdYmd3OEE KU3eACRAZpsS3RoSAGhi4ZyXNPQgVGz40MQ0+8er/FrjEuVnua0vkYBqWhEDnfka8l2AZ/wjo5G
 0fYlAPOB0+Yx5rqSGk6uKItoh69245HMQHXFhDJBfvcLJsAf+Ck9YvINUo+dyYkKcZEgzIeR
X-Proofpoint-GUID: 0NJnkOIfGW2vjYYOSzknw-JTssuD-mbm
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=68373045 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=WTJdmG3rAAAA:8 a=hGFkS9ix08AOe-KzrfcA:9 a=CjuIK1q_8ugA:10 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-ORIG-GUID: 0NJnkOIfGW2vjYYOSzknw-JTssuD-mbm

On Wed, May 28, 2025 at 11:45:49AM -0400, Steven Rostedt wrote:
> On Wed, 28 May 2025 08:16:24 -0700
> Caleb Sander Mateos <csander@purestorage.com> wrote:
>
> > Would you mind picking up this patch to remove some old tracepoints?
> > Liam has already given it a review.
>
> Someday I need to add code that lists the events that are never called. I
> can imagine that there's several tracepoints that are created and never
> used, and they still do waste memory :-(
>
> -- Steve

Who traces the tracepoints? A question as old as time...

Maybe reasonably straightforward with a clangd/ctags/etc. backend or
something to track usage?

In fact could do a quick-an'-dirty script to grep invocations and have a
person run down the results to double-check or sth?
