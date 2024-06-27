Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439E17E9;
	Thu, 27 Jun 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451099; cv=fail; b=E5si2hnsev364bWomYRYGtxMpTc8HtT298Jo2BoiAH1JzS2bOFKM2aYE424AdGNhenvroBmm/RxoB7RJTAMwu7SyV9YztlXWkHF1I8j0Xv/om/kahlo4koGwlaJ6qlHD2U9bIsBZddvskyZy/LDdv58QbDYUFtqy3jnzSK6Uhkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451099; c=relaxed/simple;
	bh=WAFKoVCmLBjTG5cCZ2H29t3CqUb8H6fZZQ+lB9xk8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C9m6IMyED6oWD5sJtu4HmNh03psedPPZ4/97k3gyireXTzV2exmmV/p0ESBmPzCZO13iGXojWpQIcwhbiSlzWrh0j8VrV43r8UnmhKtLFtbfDqoUtN+zQlOjpr/gPI98iEhswReXtOkjJTBgGGYgxNeudg+bFPw+/LuMzGkhVe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZxiXpLaE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nxTURoKz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZxiXpLaE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nxTURoKz"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMXHF013417;
	Thu, 27 Jun 2024 01:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=goPl3kFIgeaGN+m
	/1XDQxBf5EPEGV1rPWL0+B4PaPxw=; b=ZxiXpLaEzIDvFi6EJnufOy9cSyeUrI5
	0OsvTA91JYY46tgylwYwo4lF0LcEgkjefc5LuyCaGrCUhxXrzL3TRsnJ19yo4yp8
	QPqRcgd8oMT++OUwe8B1u/jr4CWWNLdEmwRr9T09Sumriz7SMBgBfDryfBFUU6ER
	Yz+dCXbcqhtGKO1iUb+93LLdYsjq0M6g5jseP7wm3RlHCXhdXrBhu2iDzy0qqOa2
	bc9fyknGkWztKPsvvkCfUZ1rYF2PQkVDS/yVvcgHULxjD4O+bvTLTXoft+u+a7F7
	rcODQhX6ftk2xCPzoNepLl4JEmeWtbkaL6Tz2i0zjeoV6RkrBoW89QQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9cd5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 01:18:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QN3fqa021476;
	Thu, 27 Jun 2024 01:18:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys6np3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 01:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PULtobVmx4nTnvPJ1OtTpwPI77ZgBSO4eLGAWkOwCUj+vzy22+C+ofZv8Fq53Eh5/SKyAv9vpSSZ9Ciz6gL2zGBuP7HO9xX0TvC4sdpCGhJ+zxqNK4ISPXHrSgJeFYn6frY1TqS2eJ/xxmWvsXIxsxVXTQSZ6HMY9kKtqi8di93W+Gaal+Xiyg1Ll1mjufh29Tei5x0O1ROMmFo7ZOGdWH961NwMfE9ry6zhzT8T+Qqh5n70rYHrOG/qDhRRpyV6x/dmEnXdI0DpS7UOxGqEk1Uo4dr9lg7GF5cMJKigbjg+xSkj9BgYaksbhjxxozkAPgCpP6vyRuGRQ6Q8wz55UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goPl3kFIgeaGN+m/1XDQxBf5EPEGV1rPWL0+B4PaPxw=;
 b=hyqG0GZTjSBIHDBrd6HoPGgbPpgA38oN5+mj0cYu0/XDHF8ZR/v0Cdg29KOiTV69+XqLgJozgN9L8vWC3KowRY/dYqc2FMsFiTWqJeil43rnqS8RS9oI2M6BS4t8OrDf3ToKgapssIOe4m8mxdqZ5RNDob8Ov4rcUUBvVCuGB1O+Skyd/F06XEIyS0yMkko9ZP7SEiDzfN98nk/yCQQ4aNwGMw+wm2RLtm+rZroLyMYmzhaVja7FTOecUa/C4Z+zatdOlwtEwZweZhz9skkBybQwsZ+iSpD4+KQT8XTeUlzl18RbDIw9JDPQxKNYvTyNMUWl+GFqMn4HU7DSl+/ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goPl3kFIgeaGN+m/1XDQxBf5EPEGV1rPWL0+B4PaPxw=;
 b=nxTURoKzAClff//lt0uWM8iEzcwdKdJ65lG0FoI75rAWXW//n5Av3iTWlOqi7rse5OG0Qo9R7w9fY/9ROxu7qmBeKPrJ3iPCrgEPp1JxaFrFyPsTBB/qbk0W+YLAVrZKTVzFNkemluwL9Fu4rMTS1K3Gkr1Yao9QkC8KByXY+dk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4216.namprd10.prod.outlook.com (2603:10b6:610:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:18:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 01:18:03 +0000
Date: Wed, 26 Jun 2024 21:18:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: akpm@linux-foundation.org, quic_jjohnson@quicinc.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] tools/testing/radix-tree/idr-test: add missing
 MODULE_DESCRIPTION define
Message-ID: <tjri2jorohbyqalocpra6eb6mdwzgsd5jcsoigazdez2ot7sbx@2vx37eqlwfxw>
References: <20240626232100.306130-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626232100.306130-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: d626819a-75d5-4166-f513-08dc9646fdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IcoMzNIjohomKij9aOji61/2dv6JyWAzg6pwArGhXkX40m9iIogwzCNyelz4?=
 =?us-ascii?Q?O+XCco8FKNkywh8FFTxEwxXMi6uHc7rdwoobQvOT31jhpf+NHpF0MrvY30Ji?=
 =?us-ascii?Q?YRTRaSHy5k9j9apwG7YqAqPCoRS89EyzAWFrJJAjQYT4idyspur57GkET7C0?=
 =?us-ascii?Q?6qA5fgqbhiXukpaoeV1H3eWLHZ7YYyd33rx0lqiujJj3l+b3HSdIVvFVVjQt?=
 =?us-ascii?Q?Q1fl4kqeDwo0fccWV9VK8L0RUAAowgGc/cZECcbVeHOxnt4ugH+nt9Jh1hFi?=
 =?us-ascii?Q?VmnRDvZmd9lZhxYRBabgjQoQLns6Snp/+WmSxONStbxUr9+XVoZG4WgcPUCN?=
 =?us-ascii?Q?pLrdMZ0+CSFAAAZNSearXBnYHKahy2eCt/e49WWwEBFvqFq3g3Q5nYBye0CB?=
 =?us-ascii?Q?lBTa7ra1EiFApLwYIS5tMpLArGMnAUv4HxLkp+iMUK7czGeWYaw2u2WFDAzr?=
 =?us-ascii?Q?sh7cG7cunP/Xq7J3MDvaDsg6kSH2rKv912AQycTF79t/YC5/kKPQgJApxuuS?=
 =?us-ascii?Q?DVib0kPmikjkPZsIyjcCJCqd3UpA43KJhgxs+zjcK85owFjvLb/66rJ0IU8X?=
 =?us-ascii?Q?52fbUGX2oEFvCPd/DK88IFM/dp+ICdUVhf5YtMHgkP2q9xafJ1/EGyCWYW8V?=
 =?us-ascii?Q?H9TUO3Oc1vmiD1rQ0R61ay9KWPMTBrCO0lM2Ic35jQHvh3uVFzI5qif9Hhlc?=
 =?us-ascii?Q?IpCYR1daZiUHGHnOC0cyirgOLDk3n9PsWQzn2PysFk1VDUdPHnHXSxKq6wDs?=
 =?us-ascii?Q?ZZQ95A63jWume9khBXea4W5Oca6hICecorJ/9yvqoInpKrFpgKt5ML8CpOGb?=
 =?us-ascii?Q?RXXAYghdUdoDbkfWvSvhujkmv2YTzloDSnhyosDsWv9PiNAXA/kCV3Gky3oK?=
 =?us-ascii?Q?X2ywClh+f6EvsYGLE9Qf/VeDQLYPKxixDQ9hZ+aUgY32YXsebg4ktEPDPeRA?=
 =?us-ascii?Q?LHFCOd/bKw16pUnclf4RDaQC1hLBHhoMDusZNAirDYhfmVHpfeSGJgbkc48U?=
 =?us-ascii?Q?+iton8RU2kussFLU4Eu3fI4dyQIQ2uDD87tPUf/GTIOex9Dku1xamxcI2mY8?=
 =?us-ascii?Q?tkEcBCDI51nMI50LlaYIwOmPANkXD2B7kIXJersxVJOSd4LRfnaHarfeWHxQ?=
 =?us-ascii?Q?Aqhzijva1IQBgVBY+cfQlfuPwbmiC7Aaj0kcSduCoRnkYmWokv9PuNLJC7GT?=
 =?us-ascii?Q?qEQ5yqtc0X6zCwZvTaqli3bLDIxK3tQURNHY5x/rKIhn1H7+fT0N4+NLjCNs?=
 =?us-ascii?Q?oMbeiSIXLwEyWCWM5y5sRz07eWAMC5QQg9Hx7gU1DTalN4kMnC4iuoqVJamN?=
 =?us-ascii?Q?XQVgCeB2Qmh6/YAJTN0hNMJn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ISGAYqqZIYPFRPJmVs5dcJRkdmiw3nyjqk1Fs+5kzYz18FOly5x8IeBtdco4?=
 =?us-ascii?Q?Ua6ciiv7DFrMkj2o8C+1pdgwJTGqoAQVouEz6CMrzdtr0HQhnJwpxH9xPatm?=
 =?us-ascii?Q?APCw+HmAwQWBOJsZN5bCNRRl9bTNgCyBR1DDqYVLSUqtFZE0rXKMANrO/0pP?=
 =?us-ascii?Q?1kNO5UyeYUt9DJcXvwMZt+NEOqcuF2zg8Vw18Oec4SU7HUdiN6nHCHDCv9Tj?=
 =?us-ascii?Q?665LLIAUh7UN46f07+776WEhhlZ4CuDurAIkVORaUmNhiRq0AEAVUKzE2NcQ?=
 =?us-ascii?Q?kGPsClRaxb83mqYJQRBUqQ/FnLKrRKMsloqJeAl+ZyVscIQSc9pP71qyEo6C?=
 =?us-ascii?Q?O0/EbTDMct1gs69OJ+xmyRLJ8QvgCrvCl+5Nl91vztQ+7TbxRItsJewbY2px?=
 =?us-ascii?Q?erMDcyDwVUdzs4WEYBqgHoalfAKzDy6tDp0/U+VttTWH6sdSE0qJWlgIeiLc?=
 =?us-ascii?Q?QkaLw6lcfxZlPWfg0w6ydwk9glegRByjlQovcHZcPGcMBIUwBKtMZaxRDAZT?=
 =?us-ascii?Q?MjHFag0XcP7DtXm4wevoLwbjLhaH31vlfuPDDSX6l/VZQqoVdIDYIFENN6kK?=
 =?us-ascii?Q?dgkvCegREVfuMflGMA4OuPbqPhzgWy2kP7kMiYePLq6xn1ECTppiwF4zYb3l?=
 =?us-ascii?Q?HO7Cor4m9qjMSkPxa5RsJZCOGx+TcuBFKumbIehYh+LA1ZENAprnLkduedeB?=
 =?us-ascii?Q?JbftRQg40ASjapVHOcq43NdGv1N31V3iKKfqbx7LGQzVGb42IwMpA+aSyyFf?=
 =?us-ascii?Q?8r/7kNJt3CvR8iov1OG1zZ8sfVFmzspFQx9gfXJiJEHgMV7JuGOseA877jqm?=
 =?us-ascii?Q?swLoryXYjlVURloOU5yl+RyW4KbvUoiticfWftaEi0HdQjFkbmsAqf+ti+od?=
 =?us-ascii?Q?Fktx2hEOMcRbbs6FR64r3TYwZL89wNmjma8QHzpfWYH8EXilaiX0KxBZa2+M?=
 =?us-ascii?Q?koNjJGbRZ6EJRckcg3Bidk0r6lkGfacxxTyoO4OHi/sG2aBi43Bk3k5ImPiU?=
 =?us-ascii?Q?fyc74Bk76/ncSKDus5FnVfTC2MbfWB6qWVE/fImmw4TMHjy13bWtTOls1QPi?=
 =?us-ascii?Q?y70Ohb4ab1qssuBlMXejmkdeVSKDXk0S3nrL87cinK05iPDpJeRePOU7Tnwp?=
 =?us-ascii?Q?asEuZS9QnJ4Y4vgoEVNJfZfssQys9hNAAafTy6QhTYfbQ5HbVNW6YgBP0WHC?=
 =?us-ascii?Q?ElvvmGKsjLZjwVpTkjWSW3HagHe2TSr67bzG9tS+zm0+VDSKAmloe2FcY5GH?=
 =?us-ascii?Q?3W81WZzeTpR/eM0p0uzg1c3Ero2aAyDzH+OquMfqSHMgoQ3N6B6jAlImQhMf?=
 =?us-ascii?Q?u8A1nd3Aoyp9za259GaCe4A2xmiRiBqlIGUKztKLcg8NkqjXJPuPTI1C0LT6?=
 =?us-ascii?Q?Q728OV1wNSaZEArEbstTZVZnkfoj+goQQghdpRNzmz39HSCERkjliHQBpokM?=
 =?us-ascii?Q?SLX0B+ZOw/L7oRUUZB5IBpHPv/xJTJ/WtmZI8jCPpp8QlF3S8pwlKK3E5ImP?=
 =?us-ascii?Q?9ULG+1OJy/twRU+frDG/Tuisc28/0pXdXoYXkxSvYL422Gsbw8qCeqtY0JRC?=
 =?us-ascii?Q?vufJQxvooQrVVliqFFuN6fMUOuabh7JMtXRlLjRfbBO7rDUqkdYSv1Uzebxw?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WGakSaz5uryWb2UGIRzdIWYLsTGZZ0gcAfDAgR/aTyF8AsOkbJpHXtfRBXWzkyFAbwniTgqO3L/FLEn4knHdLujzxnfdwn8mH8fYYfzr7VvjgwTzxB81sDZ8Z6++AoDP8vywpHrtcgmzW8e/Y5ZRS3IGrxax4bbUxXnDZtzQOTR+BX0p9zTHI4Nba7A/OWdtT6bPZjZlJXPlfTvipmA/opmejVXtQd98ICrZNTx/brGorUKCyf23X+WPZhhVw23mkQ7UhEuRB39rTyHsNcy28aq/v+g0xHht9DTvqiYAVsr6fMJrqIdvzKgZHEA4CXf+VNY0sj864sVe5gysYNhVrpE6igtXek/G/f6Szw/y+9msiBN7PdnXhYoy90fFZsRpNqvIPJc0BkEmYeNUzJ2O3HZaCd8wim/wXIM+JWjTOghS66KwUxd6wPoTa27x3HuVgFNd03V2xLOwIqPSevavfQh8ByOnn6bPA4z+liImOlgnjmfhY6d6gNXHO935m/F1/Ho7zOJGqdUIg+Tiw6Lh+YxTXx6Avy3sUZSAZKR3Bb1CzFsOPRwhNn5KD4pNTS4nK7p7LzVS958ZIjoshaa0Rj++0dd8WrpauDhXyS76XmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d626819a-75d5-4166-f513-08dc9646fdbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 01:18:02.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOF/ZkDGSblsEz4ppLwvSbJiaKp5gW+4gYmbgBT8jqy9oHWvalcHw97i7wj9GjZke46Md13VWbjixfYNLK9lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270008
X-Proofpoint-ORIG-GUID: 0c-8QB8c9DCOlig2ExuWEW43idALCUsB
X-Proofpoint-GUID: 0c-8QB8c9DCOlig2ExuWEW43idALCUsB

Thanks.  These (this one and two previous patches for xarray and maple)
are needed for our testing to compile.

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240626 19:21]:
> Userspace builds of the radix-tree testing suite fails because of patch
> KUnit: add missing MODULE_DESCRIPTION() macros for lib/test_*.ko. Add the
> proper defines to  tools/testing/radix-tree/idr-test.c so
> MODULE_DESCRIPTION has a definition. This allows the build to succeed.
> 
> Fixes: 303474913271("KUnit: add missing MODULE_DESCRIPTION() macros for lib/test_*.ko")
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> 
> This patch is based on next-20240626
> 
>  tools/testing/radix-tree/idr-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index ca24f6839d50..84b8c3c92c79 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -424,6 +424,7 @@ void idr_checks(void)
>  #define module_init(x)
>  #define module_exit(x)
>  #define MODULE_AUTHOR(x)
> +#define MODULE_DESCRIPTION(X)
>  #define MODULE_LICENSE(x)
>  #define dump_stack()    assert(0)
>  void ida_dump(struct ida *);
> -- 
> 2.45.2
> 
