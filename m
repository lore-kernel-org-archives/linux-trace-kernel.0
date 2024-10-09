Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7F137C37;
	Wed,  9 Oct 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495058; cv=fail; b=anpBOhWa1sEQAmBxUyMvx/Onu3CQBrU/KRrvb1/slk0MpM7Xz6l5p7XLyml2ZIG2ZUk4GMMAyFGwYvr0Z+lGXlgE/BYOmSptd9OlcTQs8hs7J4fQugWeRrZSSHiP0jja2jWw9JyCuVJP58UUhV66iqnU6t33e4+aUKVCqw1SHvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495058; c=relaxed/simple;
	bh=jlLfffBYXtfaS4SNbM+YdcxAsIgA/KFUJkowpoy6S64=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=djhfseA5iAG1hYXHE8pBv8XXq+3cd+bbxjZOL7boWeMdbtQuxhkcuqzOm0jEwBSoI5EJW4BU5ZJb+XbC2gTB+ALqF0ZJD/RGNpS1D8g2cVugRkUw6QXu8l3a0yf6CJkGhrAAo7BitnPObEpULXXMZAWfMuVTtFSUUueE1joR+Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlxYFcIy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EQKVPR5r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlxYFcIy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EQKVPR5r"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBdjl013574;
	Wed, 9 Oct 2024 17:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jJUc08FQFrPUXcWqbA
	BK7C1XeZJ+szwUZlskspXWXkU=; b=OlxYFcIy/mUqMxPBl+Y4GKNV7PzhZaYXHl
	JYhnVWFQONBH0uZKd8H0cJLVkEYaqwJYmGzjZY0Jddqedwg11Azka54q0RwaKngp
	096eMnV44gR3FVr/Q8DaQ5peBO0zYjiBdun6yJQ0JbW+FtlqEnJj/fCgmb6xU2Bb
	wU5n4RdFO9yBjuXPtjbwVDF/drpUbamPhoFpE9R4Si2anOutwWoJpGRTYze2UFRD
	nZPyOYa4Vf2kw2MJ4Fgcjn9aEAy4wt8tjw35fU/RL3NYcSte1Xll404ekj4RYVWQ
	YVlUMjKBsTAiHvzl+eOVvP1X8MuCz4aOO/Zfh76pU/BuvRzn+2tg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e100p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 17:30:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499H4Fap038398;
	Wed, 9 Oct 2024 17:30:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw90kbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 17:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gteb2tIPdAlik4aRAez+Y5NP5T/E5YOPI4AQE4GCB7Oy2uHUxCDq2KZvRyX+8Av871i0tQx5KXeliXSvxWpCrrfJeid7msC7Pos+0wpGTf/svyG09S7kihvzS4Hh/tgL6GE8dfrQmz+NftA8YvJew4uXHb5ODH6RlEAJqY3mhJKuyoF2dSYhLVfwdK7COoVcHhRJZR637HNBV7BnUywY7FhC4nuC56LpedTDnZKCsZx8peKrsXEqNPaa4GBegvBBZG8pzdgciGq2jl3wg3z6aEz4oh/Rys7VcPnSRomSv+oN/oLjffQG2vY/jf5kNZj5D0/aW7aYp3P8aZUo5FviKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJUc08FQFrPUXcWqbABK7C1XeZJ+szwUZlskspXWXkU=;
 b=xanqbMPFYcE1U3XjLIxGO3SuD9VWr4aggiRuPWCqGATAjr30k/gJNROhQKMUUFqumNwOq8AtoM8LIhgEPnyDZilQdY03Z/tR7Ss0Xv3o8iS8WidxcAgxxGiaavGxGYdlhFZARuVTvDhLKlcHwwZO6lJzY3pjXpXIrSgwukJUbvWO+j7IiL84hnaPsl0oqdkdyc0Ipt3TbxN6InxRkTsI2xyL3linW3mx8DFPSuUrNphRfVdKyFT/+Z6AIBrbmz5/j3wj1BA3HqqHz154Fx7rvF7V0dUs+A3vjqwlJpdg62CloUCuwgsPFalqfG+vTtguTQUdeKXdCFYvjZ4plg53xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJUc08FQFrPUXcWqbABK7C1XeZJ+szwUZlskspXWXkU=;
 b=EQKVPR5r+GB76vpMSvLn3qA4Hkwh0imTrylgwO3IkwkOm1hwdANvfcYaOQ8u48dO26hmxZKKLkyh82I0N//96C9OCSLBe7aoM3OhAb2gtb2Apwh13tG2l9Cl95at+pBKp0su8Y8k0F9H/rWF1oWQzIeNDWQKoUewP1IoK1zZSWo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 17:30:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 17:30:31 +0000
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-3-bigeasy@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
        efault@gmx.de, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
In-reply-to: <20241009105709.887510-3-bigeasy@linutronix.de>
Date: Wed, 09 Oct 2024 10:30:28 -0700
Message-ID: <87iku1b2vf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d18538-c87c-4dfb-5865-08dce88812b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXdAtPieCTiB1+g+pJLHjrXKSIoLL6a0kvwcbZo75eVDHwXzsAHOQMLTIesU?=
 =?us-ascii?Q?DQsBp4Co9NTby1jJv7vF2Cz1Jn5vSPdd+UqCK9BoNMV7f78f6aHoHMx955UI?=
 =?us-ascii?Q?SVfhie6EAb3lmdQWefeWVa7rEioSFdWTP7nJxxz8MLDM0WfRRUMmGaXmgkd/?=
 =?us-ascii?Q?nv8YNKGGBjSFABqnnHuJ7+8A1ZKIXyAiGR7ygonUG07oO//CUS/ztfhSPS6i?=
 =?us-ascii?Q?FnZta3G1PaXTL88G64yxiwhMYhkIRWqZksb7EQuZCW/YFsfvie4ibHR1XdWq?=
 =?us-ascii?Q?sIF0yJoEPiOAq2mVuBCE5Cc2DiiGZ4B/be5e/nZAXKHnRl54dgaVjBz/nHdZ?=
 =?us-ascii?Q?T381xvSrQZeKwTsD8UReI6gDg9ujuwtSuIjiMBxsPwC/6xgkdnrjuLm6qS0z?=
 =?us-ascii?Q?BeNxuaIaxhkPTdNeWLjXO9LUpNkRwpCmYS7dw0wqEOxyDCSImDuQh/mT6pDx?=
 =?us-ascii?Q?C0HqiQ1fYs8J/LG8mazuVBG5dp+bD3RvmtqvX6l80hmaJxTrlfKnJTLKovw9?=
 =?us-ascii?Q?nCnw8Ghyh13jxk+MhylZ03GzMqhnIMqu7232y8ERnrAs85C5GPEryRPTv/fh?=
 =?us-ascii?Q?XjfI/Lm6ozM8v6B0pstFjbZ3wz6xpXKv7oMrRaMu7eRyAwDxOFWG77/2UOvb?=
 =?us-ascii?Q?bZZUB2zDKXrl0XplKdVKxZodEeXCUzbSEmX2bLtbEBZB6bVJqszD1ZAZgwQS?=
 =?us-ascii?Q?69mSAnGVgRaMI6ZTCQXmrrmJxX4lSw6+1eaq0ZS0wjTGEL/QQMiL5iJKoVJS?=
 =?us-ascii?Q?nN5S4E1IjE3LXZV/oVx69AD2DVB9t7NJdsQIBCawSvUuVSznDaXnN4AZgxHH?=
 =?us-ascii?Q?VU7V/NY5saNP1zM1MVNZvJd94q501pk76i8c3hoIA3UVc9SKC5XGF76OPOoG?=
 =?us-ascii?Q?JyZ/72fa1JUag7qE7/M/5dufEm5D8tGjByXaJX2t9WFiDZuMNWGd6BfPiOE4?=
 =?us-ascii?Q?vBvB2Lk4H81WB7YotgUoJkdvUGb1yDaTvs9h6d9g0xyQqhaLk5OBs3QdfD+G?=
 =?us-ascii?Q?vqK/15Rn3cjc8yxqXs6Hx8HpnRIBqO/Dl6PIki6YsqTjKd2iArsvCZnXOTOL?=
 =?us-ascii?Q?6jVHOYzy9FF6hfjWotkAHVPUEnVqAd/fl4dBS5cVfzVGsrgcwWXkVOc4Jf0s?=
 =?us-ascii?Q?YTYJpm+1Rywiqz1Byq9/Nari/MJf+n/Vtvrr5AnGx7kLGfhsidQX4Tk7343L?=
 =?us-ascii?Q?0dFjW+KPZi4EwcE8Px4SqZiBm9EgrN1KZ9i8TxHnrKdz6ePi0vQa7Mr0evTm?=
 =?us-ascii?Q?En5GeTJsbXP+n2BMZQ1qmjmaVUFfTfm+NdSP3yi0zw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkxI/7ARj9kuUC3Bx4rUFcA2CosjsXid7vlrNToRTRpsAQNS0Zp9saqh0pDG?=
 =?us-ascii?Q?fsFQeqKRFDZ+axKdJzHgfWYU/HkoVWgaVM9zDOkPXTigv0BbMIQcJfbc8WDr?=
 =?us-ascii?Q?m0EUhDrCA0UyWweayNa+S8x1hy9S/UJ/odcKdAFGZWFKLu72eyCbGZFIt/Eg?=
 =?us-ascii?Q?zqs5yGJZsNCAIJlZG6HQtNqOHAgDO/vGKxc4934cStu3krRUX9Hdj7qw148Y?=
 =?us-ascii?Q?GeQQnVEBsLNQySiGpfGn7dXqWGvGeQ8KppDJTsniMth1bPzDjUUMbJJV56PB?=
 =?us-ascii?Q?NjY1x0tYjm6RVLot76tOXX/TxJRjgoKFJp6RSQtUW9V91NJK2Y2FMFIPfGKy?=
 =?us-ascii?Q?oAbVzE0FOZeTBqRj+906jGv1whYnnmv8TfoB1fqq23xEkRPdoS83SpvGPni2?=
 =?us-ascii?Q?icZ4TxX/X17wDldcpYnyDU0Eb/Jn+qmT4r5jFevRsAtrrG0T1eQnok9Wi8S3?=
 =?us-ascii?Q?cO48a/YZ67sWDYGnrjwEGBk73S9LJ66ZbYfjP889pw7V4Ib3C8+kQAWwiJqu?=
 =?us-ascii?Q?Gidl3sSaEB+66ChkJ1jAgCgSLH6fkXrJnAhk2vY8/goCN+dPLOnCXa754Vxe?=
 =?us-ascii?Q?QoMzcSb8eL1iNR/NOrD0f7RKsl5fVuC+6jaQIhUMdRbA9konl0ao9c+xZaMq?=
 =?us-ascii?Q?YycXugZamKDk54SbVe81Qd7iXeOvs+2PX106zpMKa56kjV8q2SyxTapmH1h/?=
 =?us-ascii?Q?Uor2OsQEVVEAsNB3QPooqWyjdB8wCa7xC48HF/3i4Nym8kWuzXHcfxSXn7jF?=
 =?us-ascii?Q?bXCRnEldn28nsLG+a8DDvFBWIK9Fh6RtWVPfPb6OieIJrhGs6jPLJ4j5vtgw?=
 =?us-ascii?Q?vQiSoXaahczN3Q3B72oxlQ4qqjGHbQlbyYuQbvJMqLLu8/I7tyYHXL+Z2aLb?=
 =?us-ascii?Q?R53nUwHCi6vOu+2fBsoE9Mks7HHbz4E0UcFKVvHmpBFMdCpupfEZkX0sU4Uy?=
 =?us-ascii?Q?Mf1CCiGpH9NugMAAVaBRHPAjmC7y2R+2+bkK8AoMPyiRKi+ddq5AEAotyDdg?=
 =?us-ascii?Q?0DXGKp1l6iyHp0OkkZT9rvLZY6Ci/RPvZuDEMRfiQTGjGNvWfjN8LAXocdbq?=
 =?us-ascii?Q?bo9352MrHFyAz0NhZZa2ORKBbJRszAP4MJbsZfMlDXSXbPoLwkJY9MNENXIE?=
 =?us-ascii?Q?7O4wfDYZfF3Q8/qtzeprjU9WujOAetXw+asiYsfSXLjDQh4rKNPUGGhBs8sD?=
 =?us-ascii?Q?ZkiTSmGuyyGOcGYiZomRqPlkzQlNXweCFW1IQKScCe+M03LY9tHzBH8MMzRz?=
 =?us-ascii?Q?OBVmzPUUZGyUW2ph1E/oQ0PsRNly06uMVXO4BaktW2heu9jEIWpu+5mYoGnX?=
 =?us-ascii?Q?DwX0QAd6lYqSsNAxDlHnA1vrWDlLJLTv6q1IItZ039lhellfAwttUOsd+umF?=
 =?us-ascii?Q?UTfPtdyHQ7MNGldQdh6fl5FZXA9NOJldK2tVfO5xxAhCm4mY0oire2NegNis?=
 =?us-ascii?Q?zgdoe5N1ZzNQI1ZE07g55I6u1BcQjQnUT7TnonR/cChSXRcdULqyHvWkXubQ?=
 =?us-ascii?Q?Poe3MsKfFiWGFqFHyAqgPL6SlHozytpEXxCrBzEOQ3IVrq7Rs7PvALif1X0Y?=
 =?us-ascii?Q?2ERPEq4Lnk/0ifYdRjApjX2N0Dv7ajdf6/TSpm+VT36vsW5cWjKwT0HZU9U0?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Euka6np90l+oam3HfXkl02yzWwg5vdTIB0RJI1WdZ7G0ujVkz6ezzzrlHgEOfAFW3ru2Hh3ENFxO0FsDXG+KWwtuGO0+7DO/xtSPT3ogHQAlOtoI8gFRWww/WlE90Dr5g19lSwQEiEdnTVjRA0FxqnVezkM15b/tibg8pmGSkuFDNA6ieaf96H120bD8QFoxpimDhaj6vVBuLftN6fYb8vMCcJp26TL5Wbx5GPF6dQ7dp9oj7Z9K2oYAIhZiLDUlXnYRQRaHuiW5UMPZRWxCTSfWiCDPTOZNr/xf0uNDjTogD8R/dALnG/Vyt1isGhimIfRjpcMxdU6OExy3uh2cUrc5t8YLivHIn2svQ2i54GyqpMEtRpab5JJ9aAk5wa+0HPxbOyAHzXJjJvn2hcJC2whFfACQo+r9XnXpBczhEYyzg8rVj4mHA7mc+BWYw1mkfDPq8xnchwUxPHUkdF7VYiK6geXPAsjQkcF+TwkGJBgWc04oLoa/Tf9wcbGSg+jh8F2p+dD+4amoCKkzKtvdVCZ69eWhCFGcMd2wiDBXlN/39ZdQkfi0puUA9JoX91j0lvKIEuNaylMa/EUu7gPt9f/wPqbwb7CtdXkGOB69AuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d18538-c87c-4dfb-5865-08dce88812b7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:30:31.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0LdXrznv7Tkm3MXQUNnTxXVUuoyjiYUokFBTfq+KfambOhL5YJsPy4gokZP55YU4uIr0iLdB96L1mTIPcNKpKvqmBdMc+6nSQOgxRTeZ8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_16,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090111
X-Proofpoint-GUID: Yw34Xa_WuDM2JFa_pf3PHqcCc7q_Ck_w
X-Proofpoint-ORIG-GUID: Yw34Xa_WuDM2JFa_pf3PHqcCc7q_Ck_w


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
> part of trace flags and expose it in the need_resched field.
>
> Record and expose NEED_RESCHED_LAZY.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h |  1 +
>  kernel/trace/trace.c         |  2 ++
>  kernel/trace/trace_output.c  | 14 +++++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d5c0fcf20f024..4cae6f2581379 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -185,6 +185,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
>  enum trace_flag_type {
>  	TRACE_FLAG_IRQS_OFF		= 0x01,
>  	TRACE_FLAG_NEED_RESCHED		= 0x02,
> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
>  	TRACE_FLAG_HARDIRQ		= 0x08,
>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c69ca1f10886..29d7703751aa9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>  	if (test_preempt_need_resched())
>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> +	if (tif_test_bit(TIF_NEED_RESCHED_LAZY))

TIF_NEED_RESCHED_LAZY falls back to TIF_NEED_RESCHED without
CONFIG_ARCH_HAS_PREEMPT_LAZY. So, you might need to add an explicit
check for that as well.

With that,
 Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>

Ankur

> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>  		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
>  }
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 829daa0764dd9..23ca2155306b1 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
>  		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
>  		'.';
>
> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
>  				TRACE_FLAG_PREEMPT_RESCHED)) {
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'B';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched = 'N';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'L';
> +		break;
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'b';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED:
>  		need_resched = 'n';
>  		break;
>  	case TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched = 'p';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'l';
> +		break;
>  	default:
>  		need_resched = '.';
>  		break;


--
ankur
