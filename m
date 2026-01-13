Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E530CDBF;
	Tue, 13 Jan 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327238; cv=fail; b=tmtXCPlHL4JEdv+MQ9Hfr0sb9ykrV1/CO7F0NSKka3d6Yq2qs5ZwLQ7w4qPG/C6PiWpsqw0L0uVK+kGCJEc0ERRKK3+W9zku3TKD6Zj9IshrPC3cqINuI1hd8QZR086PfsFuFMaN5/KltRpwnqVtWkoYqqkIvlr/UjAjH+/AT+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327238; c=relaxed/simple;
	bh=VnL/+qXDE3M6Oe0WwN7sP5vyaVZIzyRzfIMe5dCvd+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xi9XzUiwHFeqgc90Y+ub/W7a9D5zbbs0RdmOjfy8mQedPZfMW1TdZ5flNJTlQ4qWnnIQlPGoo/xc48GpBlFxoL7DanWnih/1HoMnLiekYx/qy1LOmw+RDScRAyCx6DLWoeaLrlNE2s/gu7PVnRaxCASygTi6mA5h69ibgdLYI7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZxoy4Pr; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZxoy4Pr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKirmOnaj7WoD7+/uaK1j4QwO+g7L7zTEr5e81Nhp8KnT8+dzCluYn2h2yjiNrDznjYAQzTVLMbvkowMXDZt7GdgVMo27f8oswxcMs4F3tVja2fKJ0RXY8PHHHsc7sKF8daxd6YSxKNWOJ5r7L1C+itTFH53z4jSV+16+I5VBbVQB9JiLNRE9ru/E93n90IV0vSG7RtdooEssueSJ4o3+qdLI5M8qQXGZru2Z7ZjxwRJTdGix91inpi1G4z555r+eK3e8c2+qCjEv2LH07NoLIjJiHSWe0nLBYf0TmY1i2TY2nyDQrBXSRKS5c+dJkqd9p+P/XHD3aQrUg2k0DH3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DFs5GX6VjFp4iQF2flZWKZNo0OhGSJAlXZedpsD1yg=;
 b=ByYBdMFaazU6z571DC3dVCiysP/jWRZJffg1pJcU8sY3fmt3FbD4deTJKfryGv7/Al7GJ9ZkKqR0DtubhJgcp7AGmpqjEaVXviN+zY4yTP7BbC7NjMOAKowHO0jOguoF+0qHx3CoRDvJb14irzMQh5rvcP/q930COtZs/ZMzbFggBt2AUjE74hhWzZukQdXmGlvg/5Og2ox8rgzbyEXQz01mdenQiAZGRTb4jpqyfsQi9uqptYKDXbXMTM2Xn1Hvu/Mu0LodQsrwWNvnNXlircSDdkN1xqU7yj9eqc2vcs0vA1nMaJY7XivtZItaE0jk3VRfdLCaCsQwEj8DO7GggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DFs5GX6VjFp4iQF2flZWKZNo0OhGSJAlXZedpsD1yg=;
 b=XZxoy4Pr/iFE76hlfBikh8kkqeET+y73OQO7eEsYnJwAZbqEtISd0HgCHduH+m36GNt0t40FyF90cTk7e7XcUgzS1AkzdfI5rODKozvj7d3GFOXbyE+h6tjef+P37+BerB7UZXDigRDHFV+SvunjczPv4xlpQx/DTHhuPevqwnq3OUVdyNQmjGYohxs/AZEPJUK4KCSGwGfR0brf/gJK3RMGx5UUgIwdkMOqfJcTOBy8IU/63Z+zgisGN4R3rfSbp6jAAUoSF4nfdOIWBsYDJbNVtRDG88c93aU93INKdl5otNZsgsmU+JPqUBL2mJUtEJ2OqJiX6Dee9RQFCV+Urw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:00:28 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 18:00:28 +0000
Date: Tue, 13 Jan 2026 13:00:25 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: tglx@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org, aliceryhl@google.com,
	yury.norov@gmail.com, vmalik@redhat.com, kees@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, rostedt@goodmis.org,
	mhiramat@kernel.org, brauner@kernel.org, jack@suse.cz,
	cyphar@cyphar.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Message-ID: <aWaIOT_o-99G-_r-@yury>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
 <20260112073039.1185-2-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112073039.1185-2-fushuai.wang@linux.dev>
X-ClientProxiedBy: BN9PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:408:112::29) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: ed764249-955d-4c84-3bd3-08de52cda27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwpGQFiMPwW4xjtAiPs37xdOwrgCbVHmCNnVmD0DlQ3LRzu9h/gw4Z79Iga4?=
 =?us-ascii?Q?03MW93x5RpW9MUF6Pl1Qc7oz7hDioDaIT6pF2rPZC3WILUBAtIFDoaWO/gXv?=
 =?us-ascii?Q?gSZSuS5Of025MartMK+9qzPiJV/Sddqnyu6OrEt0Vfr1ebUz1ovQVzeuluDw?=
 =?us-ascii?Q?mrKn/2LzUFxn7e8AygRCKBmUczCL8BW81o6BQGTp0RqGr4yZ/Yu1p5MQ9AtU?=
 =?us-ascii?Q?fvuxWz5l+d0zRwQ5/YxcxoIH89Z3g+lS5B9MTkjnd3NIM5gGSEx/G/TWc7Jv?=
 =?us-ascii?Q?hWitZaaI+aDqZt6vo4wbc2+9W3/QrMYp0W/8A+XQANN3Q0//iBA3hCMoFB+8?=
 =?us-ascii?Q?f2vZtbydRPqyABfGc0Hfa1imwjjGMzYzGEtXebL3Z/GpCVbJ0MpR1kLNIeja?=
 =?us-ascii?Q?VrUyCIntQaNVwTq21KH5VmGC0iUaB4g0JuQcLWxnCK+AWknbfluKIEEzxj38?=
 =?us-ascii?Q?F7/r+WyPxwrNE+IIP+4bJUFp6lmPs1l/ptB9/0zpfar4V9SIoCO7ho0ysSFd?=
 =?us-ascii?Q?byjn6vmKA12xYMGlvVE03mVXjA5QEfwIgdjG29kCCNtnJ6uCz42XatBnCJP3?=
 =?us-ascii?Q?eghjl2pPLqMdFcOINZVzfiid/a28uI+w7iKypY1cIRRv5vwen79raZE6FJzJ?=
 =?us-ascii?Q?DpyyZSy5sjWpSqU0HCam6HxdCFajcOEVygHLPrgaHpw6vVgc5VaycBgzKBcA?=
 =?us-ascii?Q?cpfPm40IYJzT3sJ2eNGBFAiR+LhMB3jzGEYkLHcoTQu8nyzEe4ZaBlT5mbIj?=
 =?us-ascii?Q?pDVEdW97XqZlVesNxIB14jkCV9YfsEbQjSjjsMqsCOCoVzUB/lZ22Tq/Qf0/?=
 =?us-ascii?Q?UQaL4pejgIkhWcni8U+ewQLxC61XHGyTykdMPodgLZhjsP1Q7n5MtNfKH/nV?=
 =?us-ascii?Q?SiZ+g5NelDAiUniJbz5ufngqM8CispczFtVhCtM7eKJbrE/bahqeYGJdqcLq?=
 =?us-ascii?Q?Hd9zZsvcuCOKQ5Wd38NsUN6aBMNXhca/gftHXA7EWee85CjviGXAujQB1/E8?=
 =?us-ascii?Q?R9N8VGZCwsuYWu2gJfuqIm2rvxIWHA1Ds29phR5LdxMuYWZk/UWcouaWinXn?=
 =?us-ascii?Q?EQ3HZ57GnlLxA0Tiw4LXE2HU4d2tIvoXWvO0QM9GCt02xvV1K/0dfTAx2eEf?=
 =?us-ascii?Q?MqHZZhXspQJxg10O6SZ25eU+/YbTDcTyWm+/oN5QQFyZ7sUS0XHyUpz46MC6?=
 =?us-ascii?Q?Wk+EiZFj7Hkw62Nz9XahmIEPcK2UOMm76GZ3QM/XA3HmUCNpTmZRRVPbvjdZ?=
 =?us-ascii?Q?8+Pd+jGdqkgQqWrxy9td/4Wxq7YiWbEDwBVY5V5A/crFgOfOuINAzHyaZHAu?=
 =?us-ascii?Q?WT3P2t3yp6R8hEz6vnpZc0DlPqWV4yzs15WV2SQ+9U4GAVriZyW0u/KECJPk?=
 =?us-ascii?Q?ysRxxVV4atTwTLyerLvzFQbvEbcPPJGTp2pY/q3V//ikBL81DbeZXjo3KG66?=
 =?us-ascii?Q?QXP5U9LayAJ+wzIYiCNBLWkxJyHcza1c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3zlzOuao1g8zaVCs4atZBGNieDyKBYE1PzsF36zWWqIJAgX2PMKdSzly7AJ?=
 =?us-ascii?Q?apkcm5WE4DY2rXMJmV/kozbp6Xj93Ur92+kcLXyyAIkqPJhoIJdFvUX4Y61B?=
 =?us-ascii?Q?2a+SZRczY1Bu1fEmeNLecanrPRt2bk6EFfsbRmKMw02z9RaKb4jS4bOs6Uxk?=
 =?us-ascii?Q?r1SOQAfg6yhhSeRDqL5np4azdxjpoyp2nruD9YmQrkFtVQMTg4myFrS4DEow?=
 =?us-ascii?Q?k2VO8q5Y48cDFxNtk4C8Dp4tayNHDSeobwjTw44kk+tExbfv8J/R1AJEnaqO?=
 =?us-ascii?Q?rlVcjwhnsNUy9rNe0VTlFlTLmKKHF4Uol+3PWEi3IwrkCrDwJTTnDJ39e9Fo?=
 =?us-ascii?Q?5NSj+xvmQyogJYrWZ0sscIVm4Hxv36xumjeG/dbN8GmYR6ruaq3aA3v13tlG?=
 =?us-ascii?Q?MmYoaiTLd7xFD3KOYs9Zc1wZb7thZnlHyQBtMYpiz0qzCmJKhMry+x/xvrHX?=
 =?us-ascii?Q?5ek7yr8T/0qVBBg4ZpHruwt8YF9uRPU+9Z2sSC9yuIqJw+XRifnL0/97aEkS?=
 =?us-ascii?Q?jIh+REp+L8rRIalz2qwa5tq1fYuw9M/VNyom4ffHnwBlaKVyunBQapA5y4uS?=
 =?us-ascii?Q?RNqQ6ulaTl4AZVdUASa+kdBTz2KXYz8d0mlFO8VtxzHslGQEfFumLzz2yyU1?=
 =?us-ascii?Q?1Aewe33JNkxlwrbLWvtokGrRmkzUEwbiaRkDdYfuJHBus0hNm/LkltkaOomj?=
 =?us-ascii?Q?C5yjwyfcuEkVpa1nPhvWVNYjP6yqo2eHXVGT8lUMuU2Mw+myMrptVDiS+j0G?=
 =?us-ascii?Q?91FwhgG4roF7xTESRHzfxYa1ueXheue5vRTq25W809lNE3PAaMLuU4pDeBOp?=
 =?us-ascii?Q?oad3GbjsoSGI4s80hFUwQdABWYZAUas3MS0ZQLumDVz7bEKDWjex8n/IqsYP?=
 =?us-ascii?Q?7uQzmr96kTlUnbirtG2q/WE+zT0qgMhCNxKG9mq+q7svSULnjrISzf3Gn+uj?=
 =?us-ascii?Q?beO+lHb2ZZRiCw57X0u/eP/qsvqmI6llQC1pWf1hky0Zi0gV4X1HqTcQOgt1?=
 =?us-ascii?Q?ogZnPtzvFCdulrQ678HkJ5Guw+K+tty4a8T2w5UUdV8IcKSc2lchCtG0vTgK?=
 =?us-ascii?Q?e1uhngSGuFEntIXoK//OO8k3hzsPVxyE6QkU9S6rXpTOIhFhXp+gXMQzw8rv?=
 =?us-ascii?Q?t3FqpCeNhYIj05asJzOjAarkLy6pbOVXTbeHyDooHLk9RJJLXj2pLCCLR8Eo?=
 =?us-ascii?Q?KDEcp76RDYUa5NvixCw8JcVSgm+XnUIHf3bw73IWer2VcR0n5/A7wh9LvWXW?=
 =?us-ascii?Q?T5FfHTxrzgJDuEVsOCdPmzj1BkJBSi/gnGsxG88HCiBRU8taiC1SG6ZUXTvA?=
 =?us-ascii?Q?iXDVXPOjGysjtc7kNzFBAGoUjj62897/rUQpbqTIgDkDnD0AHGOTkOQCWkRZ?=
 =?us-ascii?Q?zJhesazz/SPxeFUU+5CGn81JmJdAr8c5Fi7+UnMkr+HhuQMSxW8VUFdXwwKQ?=
 =?us-ascii?Q?6L+jupwdQlO2Y/+sEBJC1DIAyMrQokts7pBn/x+bDNYt3FreCpjAge3Q177h?=
 =?us-ascii?Q?ci4rgkQfr4KmieoxkUhCkNNsEoCdroYzM/RwEn8vh2dVQaTN8dK3Qs2bKjkq?=
 =?us-ascii?Q?S5i4uwtBuFSJ/2wfnCVEKlocD8uXZH9GhuhayGyyyvCRD++R5Cl0hv0Sh6Yu?=
 =?us-ascii?Q?Q8s8W47p6vE4GGIHP09g9pTUUurP9Buv91TGmyfOcQZ6cEGhxivlrB7Hu2+m?=
 =?us-ascii?Q?uDv8Hsz+cNPj/UZbV3itle9ptwMGzbBrILR7iIE/Jgd+QKHrOpzEFFnuNBXB?=
 =?us-ascii?Q?r/c78af8eB22HugFiOjYtslgFcqQwCwjBmwc/Xs8gFANlbwKdhpl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed764249-955d-4c84-3bd3-08de52cda27f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:00:28.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du3LdMEetGvpLC3seFqSxu9zdDS6nfv8RhUZsvrh3XCZLdCkPuTvLhnA68YW5fyN4dEzqtJtsP5cs4/P4jRlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

On Mon, Jan 12, 2026 at 03:30:34PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Many places call copy_from_user() to copy a buffer from user space,
> and then manually add a NULL terminator to the destination buffer,
> e.g.:

6 is not many

> 
> 	if (copy_from_user(dest, src, len))
> 		return -EFAULT;
> 	dest[len] = '\0';
> 
> This is repetitive and error-prone. Add a copy_from_user_nul() helper to
> simplify such patterns. It copied n bytes from user space to kernel space,
> and NUL-terminates the destination buffer.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

I checked the cases you've found, and all them clearly abuse
copy_from_user(). For example, #2 in tlbflush_write_file():

        if (copy_from_user(buf, user_buf, len))
                return -EFAULT;

        buf[len] = '\0';
        if (kstrtoint(buf, 0, &ceiling))
                return -EINVAL;

should be:
        
        len = strncpy_from_user(buf, user_buf, len);
        if (len < 0)
                return len;

        ret = kstrtoint(buf, 0, &ceiling);
        if (ret)
                return ret;

See, if you use the right API, you don't need this weird
copy_from_user_nul(). Also notice how nice the original version hides
possible ERANGE in kstrtoint().

Patches #3-5 in the series again copy strings with raw non-string API,
so should be converted to some flavor of strcpy().

#6 patches lib/kstrtox, which makes little sense because the whole
purpose of that library is to handle raw pieces of memory as valid
C strings. One would expect such patterns in library code, and I'd
prefer having them explicit.

I find copy_{from,to}_user_nul() useful for objects that must be
null-terminated, and may have \0 somewhere in the middle. Those are
not C strings. I suspect this isn't a popular format across the kernel. 

On the other hand, adding the _nul() version of copy_from_user() would
make an API abuse like above simpler, which is a bad thing.

Can you drop copy_from_user_nul() and submit a series that switches
string manipulations to the dedicated string functions?

Thanks,
Yury
