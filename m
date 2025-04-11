Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C81230BEC;
	Fri, 11 Apr 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392176; cv=fail; b=ahHDcFdsdgCD7CsHQlM0+gX6WTJqImLr7bWpH3KKJRoWwpCqJ+rg2aRlE6O8yln0PIGxS7+wI+wDNcB86QGCp0gaVy8HcSpBbOvkMTDi3ZoEVBvz7aF2VLL+UupZjZw9A/H2BW777UeyC6E6BjU4H03lY8VEATqmI/lweJZZsJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392176; c=relaxed/simple;
	bh=HtQ3VPGJE1fLrKPhjFxEV7z8df5QVoqmoENl+KkhCJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJpM2JtyfY0RyJ7pVxg9ZXamTH3ig4cOJN7GHy5hh25YOpzaEOXuymOpIkSBAKBzGSraQGpTzm6zgxil/g+NaH2LuEH8skkTPE5BDiad8B0xLGQeMUGoBeBJg+B24UgWIX/WzXoxfORhde2KRhPlX+aES+G7qoL8tKUeUxd1QMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=il3XB/0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zN5HPNrn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="il3XB/0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zN5HPNrn"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGvNCW006955;
	Fri, 11 Apr 2025 17:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=I+VadX88KSbqbrCumg
	FQLBknLBeY+pJ6qlMAfe4wl/Q=; b=il3XB/0+11LKqUsvn9bXPa5Utn1dZ+OTgi
	2d3iRrrjNvHzVe+IQL8eVc7tHIsrzADJD3m+/7ApfSEHyqIquivCNWp0K+AD/CyE
	TVdum1R55qv4dC93xl8R+amUAZEaOAoZf1mLtbBz1hJP7sPpA92kPvIVC+z8htLg
	B7r5fPJNYE9XgOSRgoC5oXB2h4MxXAxjTZe2oTBhB1uuY6sI3Q5W/veEyXCIGK7a
	EP532hxYYkIRdqBpjhRGRL7MO/OjI9hyt0icCvjNWawRFCOloeRF571E7QhnAMt1
	lLyRXgeto3OjVUQm2CF5EYsKVyb3FahwgIB4lQbdp9BHMVSO0EkA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y72281pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:22:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFpQd3016123;
	Fri, 11 Apr 2025 17:22:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydxar6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1mHjf5RX+oHDz3TgNEwdExP4lke+t6DAi/kNWBIEw3HF4BwRdKPibarAz/7qupsIaA+s7nKJ2rNQldPYiM8npCMdhjOS2/uuXApJaBtofW3DFgBx10urZem2corRxTAUbojcnHxslQBDNc8mkxz614XNiNJ0hAWAXrWnyGYyP3XNOWjGEwTcFTvHjb7CgTANAZ/99BqJXs6TmkHTYnDuo1UeO5my05TOdnfoMAAJ9XsXSzSwW2jHmCPijDuvVk+2qLk3tOWCm5Y++1eJ+bCrHKiL8tA7MDXUy03KOLQvCg7Nl+lRgYWWsHv8I/D64jagfbBvzTgd9mffOVMzeTzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+VadX88KSbqbrCumgFQLBknLBeY+pJ6qlMAfe4wl/Q=;
 b=W6JlE8uoWOeidIfm8ZDEcr/iru4WgPiM0ueqCnEyb9BFpEthmTyR4P/1N/+dbA6XxZITJQRdniJEm53o6KjNbhwwKZONMqyJZYQhAg3tFlnw86obXamTZlK7WB8WZL1xZVvn7QkTU6JYkaG8Siq9Tpe1EBajn3lVSiPNAaPbmS9GM82SzfYMu0g+wYscd0kx3alB1f6sYTsrZKwPzG3zNb4Yp3IGt8yLphic8w7vRLYHkXs/Z2Hll4cgnS/wzLQ0/S7ega3aerigHIaQRQ7IcQ03A9wZRCOZOsHN1ynFNiOUyDCKW1obpd/nApDun9oXy6N4JWF8hsUZYU/zdyrDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+VadX88KSbqbrCumgFQLBknLBeY+pJ6qlMAfe4wl/Q=;
 b=zN5HPNrneUtcSTcFB3UKeyMvi3t04JhSoI9uNJ+Wl5M2zEmCOipJSZxugM00XbWjhzLUybBWRgmIOv43/s5t+e9971MIM1yi8V2ZYivhGiki+0raJCu04PNvB82rViSCMCNbJbk9qQ8x8Z8r4zWz7eQ+ZE4JkoxJvJEOybd1+U4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BN0PR10MB5093.namprd10.prod.outlook.com (2603:10b6:408:12d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:22:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 17:22:36 +0000
Date: Fri, 11 Apr 2025 13:22:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Mueller <emueller@purestorage.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <qefbtvvqq6xf3dq2bpendhfel36k3vpix6tvl3to5bursepuap@gstlh5aeifrm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Caleb Sander Mateos <csander@purestorage.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Eric Mueller <emueller@purestorage.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
References: <20250411161746.1043239-1-csander@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411161746.1043239-1-csander@purestorage.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBP288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BN0PR10MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfbb2dc-1c46-4fa8-3aaf-08dd791d73b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVBuMJEQsGNa3o88T/qhxSWghHvn0ETUBU/Qfx6zfaNrRQsg73EKhNx1G7hO?=
 =?us-ascii?Q?whrLDyrB9VkjhYmb6fDTkEyL4+NztxDEXcGma4OYWpzhXWgSVeBhXbrCl7ri?=
 =?us-ascii?Q?zzv1UDEQJtARzOcmWTogU48qZuIzlB65ASsBQZ2Yz9xf8oVYA3d0XhUpU1It?=
 =?us-ascii?Q?x4xcluR4TbUf++nl+aNmSbvvcqz7XX7zYzCVbqoPD8FYsBF1VL+uzQjMTSZ4?=
 =?us-ascii?Q?u2VzOlLGJpH0MXu6Lcf7EFE5Y1nC9OHO++m/MxjNyiQx0Lng/oIg1kTF6wvg?=
 =?us-ascii?Q?vELtkWqun8aOFoUVOdP+WuZI2Jsf9qBcamdc6tXsVpdUeKHhlTsGy94Tuz7V?=
 =?us-ascii?Q?mX5N22gY79S203RLxH6mNBpk9D27dW1/U0uGKyFAD3VTm6cqh5fgcP3jNjxD?=
 =?us-ascii?Q?yHRCOdv02EzV/d8aIdf0IRoNtHATWWGNIqarfaEDZmSvD3ZMpKZCW9qCeoZg?=
 =?us-ascii?Q?PEsO1AFIFX4Dz3EZJiALFjixOd2ypAO9zO2JNIu8kOOKOk2BredfC/TCmSwg?=
 =?us-ascii?Q?x9eC7lWJ9Hk+cMUNVtDn/Zf3fVtwkFyQh1zHBepciq1Xf7cC0F7P7oYeB6GQ?=
 =?us-ascii?Q?42V1tuEUzFpw/F7PShIt7AGr6D/cNIUZuEU4xS2JpabqVs2au+x1dzQQ8fbs?=
 =?us-ascii?Q?lcBGF/VfWhIvtN4WnYrcIJKiFYLcKqfh/OjRc2OXT7zghQGzy1d9W/ZGQZtd?=
 =?us-ascii?Q?B5RYfG83i8r6o9IK645sYtuHdn6IYB4bK2F8c93eoXmz0Q54Bg+02SC72zaG?=
 =?us-ascii?Q?mi3tUypfnzA7dc5qD/aR+ZzZlydqBG6iuRsQ7Pc3ICbb1BEG4XQiJFLBqVR9?=
 =?us-ascii?Q?Ew43haWERT2pvTiqWJx2RkfptyJhYHRg3QBIZyL5MI9Iu0uulEYUzDs2Ru8S?=
 =?us-ascii?Q?f7NQa6J35L+UMD6bnhFEgtIesg5OvIumFyDO9VpsB8b3MeSf0kg7c0omEkCJ?=
 =?us-ascii?Q?W24Ui1s9SlDiSmMski7QdBn2lOOIq747wJ8SQFU4KJfGDTwpcMUn3zXdYjMx?=
 =?us-ascii?Q?EAZ8cHwPoccX1eWd9j6fycLto1c/pUf6y8Z59/oVAfiLsgYldh3+9puKA75+?=
 =?us-ascii?Q?YvaiDD2NEgFSZB6yUDmGjH7AgNWnIw5JwZwuSsivsTmoQ48DIFzbwL8BQLSE?=
 =?us-ascii?Q?13Aj4Gns/cPhShRLniUllT+0iqWOPJ6XxtGXXRbOqh6LDWPWzsicO7yxXvZc?=
 =?us-ascii?Q?9Nvo3BfDg43e2dhWfnMdAaGnxQdxM1bgZwES11rrHYi228y0cfQapalOu7Mz?=
 =?us-ascii?Q?Z/GUP9asHiib/5A8YXt8xAXspmAv12NUty9EnB5bqHnPr6YZruS9YF6DRGF1?=
 =?us-ascii?Q?I+Z2U7SNyOwQ+BgVHDjZ3Z583PijeQmubTwrN+kmDyszODQbPnlv1PfmaGfF?=
 =?us-ascii?Q?fJsD9eRo7Or3R0ipbZ8m2hD8knzBjqG5ePCj+xlil7mRJv/567gGSHC5rwnk?=
 =?us-ascii?Q?fONHOgd8f5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdC1rKGnzjIqakFlGnk0p8ef7DS4HE+jjU4xfkz9l3MHpv8VGLtaGj7AbGiD?=
 =?us-ascii?Q?XZ75l5GqOStqBxjwZituY9c2JhRxS6FqKeCCcRjspbGA0dutnUdLhTgZIyUN?=
 =?us-ascii?Q?S9XGRkcysUTrCIll8h5qk2KleQLjynZAVR4qSWlKDzVdeJR2gPAhFPtRGy8j?=
 =?us-ascii?Q?Ycl+z+tuXw5uViWSaJ9Pbd6pBnb15TL6LCseGLr5DZ16DSHRpI+95xtgg7rc?=
 =?us-ascii?Q?hqbviSWe7PkX4+2KKxMdL8bjVbzdbpRfbpprPCsLd1iPbu03CaNTlF7mRJY6?=
 =?us-ascii?Q?Y5XMSySZFM/C9vjpvkQFioP/SvNQgJ4CGz2Ics3m3X++wQj5wUImVk80l5y6?=
 =?us-ascii?Q?ouSO33V9aoDiU+VvTe5MiLRMKMl0FtgriSdPzYlA2kxmroxhbrp8GAoUQ/bs?=
 =?us-ascii?Q?5jCTAyY3K832tgdS28TocFjAI3ktRKYm/Gy2On2Ch6puiIkgjk6hYNj/UP3l?=
 =?us-ascii?Q?Unpf544zhzbTUehcgHauhGNipBn+n3ZVzEPDwQzPFA+9pC3rdEugLurAFtg2?=
 =?us-ascii?Q?W6RHzXfPZiBi/DxFo3Xy8H28o3pqYk4sfKtwGB2ZrO1/tE1ckoTVpEcLfT+h?=
 =?us-ascii?Q?atGGbINy44IfsyVLgyVvmg684jCnLDu0mbfbuA4QCexDa/8SwBuXhXoeFV94?=
 =?us-ascii?Q?hvKfGTH+P5EE4OvSB4zhb8WONFXGTEa1pL5Kj18ude27e+OHYCXdEYuSRzYl?=
 =?us-ascii?Q?LTDIJg8llF0jQWfkDPV4DDpgnu6JM0Wb3G6TE9WTr1F2/gV6eYk7N5+uj3jB?=
 =?us-ascii?Q?0TV2qseGGmeTb5fjvILLJJ36jHlvgWOFBSn7ognz43ry9JbYtnb3EQqwH+ff?=
 =?us-ascii?Q?qVO+IlpUeVdrvURHZSv5qP05KMu4qoxeNFJ1JvWlE6PPRSDgcIaWuea1739u?=
 =?us-ascii?Q?UG//1gGjmYrhvSYnson3ldfe7xswWXwfox0syuaIUoQ04/wSiCP94On230M4?=
 =?us-ascii?Q?Myqw5Gk8XkUoYYQRAZxYYv0Nf1dsVMAcM5zRPBLg4br8GZTl6eBmzZ3BxvDP?=
 =?us-ascii?Q?QPwGdyB/uXGHRLIneyGIa3PTK94t8o2bBUQw94Q05IdGTrCa0rOC443jTjLX?=
 =?us-ascii?Q?ano66Q072FBHuUiVasuWJ+8AyVTY+V56Am2wSDx7ejhaSoqgFZ3w/h4fF2er?=
 =?us-ascii?Q?6lXDs68a9M1jt75nlNuq4tb7NjCS5vFDEnDzu4+9E/MEKi1meQnkRTFd9vIz?=
 =?us-ascii?Q?6JRtIm6bIrscS0NtRFpf3n/E1EqaDpJ8M4L76jDw2E2uKPJFDfhwr+T0KEvQ?=
 =?us-ascii?Q?ttXku+9QmIf3YGeAr7aYfq2h6pWk93yxkcx7BBEs+J7Ibv2Rx3hd1HUv51TL?=
 =?us-ascii?Q?TKo4m8YN5sc9PJBY+z0wPjnGInXCuIkaUxD3IUYqbadzhTfCdukrTz8jiKMm?=
 =?us-ascii?Q?R66JRmi9zNkPn+hZyIxV6sK08lpKkUCPrRzfcNf/AGy76nQd/NlD6Telhcmx?=
 =?us-ascii?Q?AUjRPltb/njtK9hzfyKB2zvMxxExWIelnoYby6Ksw8FpywFUivWrEPp0Cbgk?=
 =?us-ascii?Q?nDhCHZUhZ3gkBfSf1zlKRXOrXhvpL7fIGBlAlNL4bb9aVJ87E29DfsX3EmaC?=
 =?us-ascii?Q?FToEicS73t45Hma8rXmCZOmHXuH6EoT6RpyQ3QoA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CGWtdX49M30mFTmszVRdyVCsJoiFR/EONqb6WNLywMp/P292MtdYTfw/4xAB2RSdKv1sAMSmyMM9r5bUuc2PpPPOUdjZfspI4VPmfEKKXBh3auKtOHHpMqFn4LQ/nGDs96ru6XfkqpTyZYDz/vGJxhbOX0qKgm9wWGANEUnUqAJ6L2IrapzsG5HeEMOGkjrinj0A8GMIiUefxeds4q+UwweP+47li7Qdzk2lQ93AjHX3JkS9IhaLn7VzY7gfsjlCWTN92PL0IhTmU7nP4mXeNVT9q0MJEgqzYX+VuOjJN1/N7X6l3xLFkdIm4AvZoTmEDnfghavM5WPSA2w+ptvhfVV3xtEW4PR75KruKLizqSF5fSLzduaZRX8yU2du+EO6U2cNaiJFfSu+V7bPiio83kb5CdL42iG00+N/QWHk4vMYGlGqPgkuND+jHkoZ4KIGfqe2R4m8y0r34SQypFMfdDO1SPlrvY6EK+d3cy/Py2o3wv4SNL0wBSACP/GpEJS7fesemxLSRqqSwgizacWvyRDJYbdlLRm5JFevqFsItgRMS8i4YMxDdh9zB1vbdWt9AU7CySxTx3qsqY/1TzoTA8aH0yVtq2q0T84FFfbP0hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfbb2dc-1c46-4fa8-3aaf-08dd791d73b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:22:36.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKFFtXvhThZkgv/qEtWZ33eBoifUBjS9GKWL9y3t0CuFjEZw7g2RATcG1NfMG5IIRVKiOwhGrTiYJ6f2DdcUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=929
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110108
X-Proofpoint-GUID: BFvwzvAI3psWOZJCW2kMztCX4zumQdLG
X-Proofpoint-ORIG-GUID: BFvwzvAI3psWOZJCW2kMztCX4zumQdLG

+ linux-mm

* Caleb Sander Mateos <csander@purestorage.com> [250411 12:18]:
> The vma_mas_szero and vma_store tracepoints are unused since commit
> fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
> Remove them so they are no longer listed as available tracepoints.
> 
> Reported-by: Eric Mueller <emueller@purestorage.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  include/trace/events/mmap.h | 52 -------------------------------------


Just a note about this file, it is currently not listed in MEMORY
MAPPING, but it seems other files in the trace/events are handled by
entries in the MAINTAINERS file.

I'll send out a change to MAINTAINERS to do this.

Thanks,
Liam
