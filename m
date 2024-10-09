Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0CEDE;
	Wed,  9 Oct 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499842; cv=fail; b=dYxQwQxRMjk8oJ9bgbTvENreQLXXjiu1ciwSNbLZic/g6liFlgzVkntM2euxxV/5ZLqfoo4BicYbb8IOxu/6zNdcvlpsFZiQYsIKRtOihshw7ZHeReO54hkYxEpEfQ/MbdWuh/y8hds7kOqBKsAEGgtI0PnPCDA0/GQm7d/Iq8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499842; c=relaxed/simple;
	bh=skUf9kRAdNGcRMAXhQeln7rP1WLPnUsWzunS0FC/TRQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=KgmEDVZ6p/JwkhtPoI1u8SixTJG3LBFc+MpGCGCzAUXunNLmiRkLoCYPTuVhjQH5bgHJA+G21zuiA5LKqx1fQoWFFm04vlRuRrjFckhRScD2FsLMYZvXDh281/H0GiWNyIiZ+oaarOkH6p1XZYSQoVfOu+Zi9rc6xmDo5rj4WAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hsmw976T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jBHzL1wN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hsmw976T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jBHzL1wN"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIXhL030138;
	Wed, 9 Oct 2024 18:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=yWWNKsZz+87aXLRXiD
	w357SUxHPdQU7hNO3y9uWWj+o=; b=hsmw976Td+AjbELaFqlNgHOQofn+jCcBXF
	j40nMg6KiKI0g4oPIJmTUag7AHkxsGemY3uZ/WOqN0mRBThqMUj0gwrJxpYVdcL4
	2rp7ZcHudkYDGA5m0xnvIbPwuOJC26pWVg5b+S0+o9ZAXwNhvhTQhzwJz0c9Jr4e
	eODxlj1ibKnP+Dw0HQP5h0IgOIK0xbCjlgvDTTQo207mLcpa0ruc7NRBvDfDP82A
	SqNDymEO+d4ZChxlkqQFlB7sFiYJuAsF+aCMck0PLQCPAisyUV8ryBINkYwnagOJ
	o3laYcM6+IPbVEovErS/oIX4HK//cdJPjSib7P03jLkhODk9dj2A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e16x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 18:49:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499HMBRx015316;
	Wed, 9 Oct 2024 18:49:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw91fvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 18:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQt8yOXFyvSKXyekNBV3AOXCZXja3++nXwtK+ULrFUEFlxBxf4Se4vB/gEB8pbRTglh0dI3bomVl+lECx5JRf3Dgu0BTW7HTthOMkHRNGF/bzYVpMjH/pYZAfPCw+sz4OAe3Sb/xgoD/9jIxNwZsQw9DsUUQmBZHJxmU1bRpjUuMj0KV+xT/mV3XCmPkYxqQOX773mJYQyPrjA5Y4ZfZAucYkU/rryd56brFLksnAQz7mArJJH5MakxB9w2vm8T50occpXkfF1q3IQqVwlxmfSkngDM8QmKdo1xT5FV0xrDB/huIjLa7web/g3lYMc7YPT9N52DDxX+qjkR+JksXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWWNKsZz+87aXLRXiDw357SUxHPdQU7hNO3y9uWWj+o=;
 b=oh7d8uIT97rB8tiTnCTVJxkxpgZw39yhpYTtqISdO/37Pa4e+fPCBYv8InADBX8uhIQ/P9ewHlWfkLGldY3cTnLqTwe29zyxwD+8M2jPFnV9Oa/cCjCINyPO0SYbTnNAxbFqDZ6s285H4DsB+FsokKuQdCHkTajgoA0jcBhVcuJTXqTZAVwWj4tB8qEGMoee2dYc6L/rci9sPTOPXiMxEl/iY2FeHYFJdp2iYjfJu/BfgglcsFhVOEmC1j0hflsOKzO7Fmbh2xfFX1L4VBVN/jVbw8NIXZLUW1wR06R0inA6l+VKrWgZgy45SO2VUkg3tlkemRMkO6Rk5SEOLcaO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWWNKsZz+87aXLRXiDw357SUxHPdQU7hNO3y9uWWj+o=;
 b=jBHzL1wNHIh/jn0GSexGNYdYl6D5EjGqCWlqGTdaS+ZHUzcl6N3VrSyN5Euid5jyXSWkgtYHkuVrmf3AcXSmTiBodF007bVzAz6f0NQyu0jm2oztSzQWkOtuQpGA/PyWdu61E1ZX0pr2sBaRDPw2/Q1jVuJ9Pk0GhQtphksEGD4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6765.namprd10.prod.outlook.com (2603:10b6:8:10f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 18:49:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 18:49:44 +0000
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-3-bigeasy@linutronix.de>
 <87iku1b2vf.fsf@oracle.com> <20241009133328.23fc671c@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter
 Zijlstra" <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, efault@gmx.de,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
In-reply-to: <20241009133328.23fc671c@gandalf.local.home>
Date: Wed, 09 Oct 2024 11:49:41 -0700
Message-ID: <87bjztaz7e.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c554b3-0584-4c70-e6c3-08dce8932440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPFQXj18z6qIRiv7WoKiazMZgsDNBs0iW9ZXqzd19rONc7cpUFUuZ1dH8eC1?=
 =?us-ascii?Q?qv44KbBzESG//wFikgvKyVxyq7+peXTzLLKojG0YXDLdA1v0Q7c5u0b+YgDu?=
 =?us-ascii?Q?XJMCtFVYwYjJ4q/+hvLNCiSkqcUSUSiWNITv37a4tKW+GitnUJHDIlU6s1Q8?=
 =?us-ascii?Q?bxWLa98vzC5z2lNeSPZ4eLntQUQLNgNTxzbsvdKkJWKwub6pIM6FeeTvyRV4?=
 =?us-ascii?Q?Z9eckukw4Yhb3jSPVx9v8ehzxVyNXIqe7+myXcPcIVLF+Ihe4Hb1rjyL+fGl?=
 =?us-ascii?Q?DPuecR637nWwBeXboyQbJ0Sdh223Je1P9p2A/A/cbQDNyJt5ZtxvBWnhSApj?=
 =?us-ascii?Q?z1e91pPTqSMxPFL/NYrrhZHGqOE/cGB/3EGso8zcReZbnVmAAnlDgEKcFnwg?=
 =?us-ascii?Q?rnavWbUA5sgvaC66XE9UuEyUsvcJI7gYHHcOQzGmgO0LU4nwyZKi0mr8UlHO?=
 =?us-ascii?Q?QIrYf494zXjQwGKebFNMoPXv5Vzpt7ZI3fCZe/KUwMbT9QqDmkhIktBvCQT7?=
 =?us-ascii?Q?9nkkv2EgUrUASF/QWTV4cT2ZPA9wp1Pybtr8yhUqvzomEhq2jEX3oU0/R+QU?=
 =?us-ascii?Q?t+qFjW6Uu8OiMVfCduQz1m8gEpPMiuK+o6IjSzfACQBzwdKF9sXd1/SUbzDO?=
 =?us-ascii?Q?IGLZ2XOBIyulzaCEH3aQTqBPd2QiiMlYeTvG+jwThUw76dFKRI4Zv7d8ku6Z?=
 =?us-ascii?Q?5NvEATBquXUmT78stsgNu+fNjXPOM7uBvW8y60wdnclSnSHHnuQjiIphuQMi?=
 =?us-ascii?Q?HP3n+EmiW1g+FAfJrhFm1WVIc1oKoiRdI0fLdZDGvgwVLlJU4ylY9dVJNpIK?=
 =?us-ascii?Q?2QC65QAqg5iB60aig3ebojRHSzlZwpjIXzmaOhSHhtjA8AB8zsmREQ9mcryp?=
 =?us-ascii?Q?1kj8MXHILPvpf2j8H5pzmBBmPNoMhoSJMFNM1VsxAbrXCfoy+Pyevy9/tYk5?=
 =?us-ascii?Q?4+Hx2x/mWLlti7CZPuRequDPHjNL48HcjhUy3Tult6IQdM2P5VnrUh6wAkWs?=
 =?us-ascii?Q?BqA38OdBtehfAMzfDJDqGC5UFmYk+GwGTcKzLwH9pSbq4zyqKWpAVkO9Lw6m?=
 =?us-ascii?Q?VmctdGaKoTDNtE+5Orjydpg2QjbbMiRw8IE9OKWvlHLWcRgj/o+lYH88he+7?=
 =?us-ascii?Q?9UBzc/4egcZyoP9XjrGKVi6rB9U4aiKgj9Y9k1xvC8n5+7kan9l7FcjMGWLN?=
 =?us-ascii?Q?d1S0vTqOClFpIwWEH1nuQ5PkBGh1EanIha81//DiQCbgDSH7uSIhGWUmQewr?=
 =?us-ascii?Q?xxpzSfh3gsn18PwudQZPXfNKimkPvb4okyXDZW+dEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1itY7a3AlxL/xxPzZNwUxrkPvHtgi91A37JY2q+SmEfYJ5pZ/skx9CUiP62j?=
 =?us-ascii?Q?k9uZXWlaioBivwexo5Kgz68iheGJxUm9DJ0gN84mObU8XmQchUG6srXzzlRh?=
 =?us-ascii?Q?DXHOEw8sahzKMhE8X4Xvs95gzFgRqTJlps37Cr+So7BX+iPEWxsOyVBzdqlm?=
 =?us-ascii?Q?4LZti70TUyU+3m1VffYp/SHu+KJLGa0hFa3mEu5IP/XMFPCIF5PWAcZEsZoO?=
 =?us-ascii?Q?Ox+Nd2d2ThrISbWDwxSEP1hdELS+j0lkItv9ydhS5LrwkY1xkANSroql3DQL?=
 =?us-ascii?Q?SgY6oiLNebP3GVFuw/C/bi13dI/jUVdJmf980lDYp4047sVNR5M1mDcNpaS8?=
 =?us-ascii?Q?1VzzlhAevXipta/qxsbzWqdxs+d+KKXklOMcVj27rmNkIvNX4GChtw/5pttV?=
 =?us-ascii?Q?X6nOcZucvTXNDqGyKbLRUoQ5M1dLmAXDVi08xdKToRuZ2yt9wqg8MN7edLtJ?=
 =?us-ascii?Q?JXt/dg/Thf+nwXKviDOLN+Q32ePNK78haWf7FNMvmO8LPiOGkygPY8OLRfFo?=
 =?us-ascii?Q?nhh958bGs6qAsmarIrNfVvk/gul+Nyckuh5grA/0M1aGBkEP2iHCIHkIOMdo?=
 =?us-ascii?Q?9HM6wXvSf4QsOqK33Ff69/SNuw6FfEdxpjF0V21kOZ6/L9+AQq9Thn9oFV4h?=
 =?us-ascii?Q?MKypIMe0DV4eq2OtVN0CReCn6JtJsLSa3UmPXtaydlDsNHVQq/peZa88VWmF?=
 =?us-ascii?Q?9Xb6Sw+38gMt8a8WpIS0QB4NDdiWeiZEtQvV78D89CZbXJXJMoqTJqJKpLWu?=
 =?us-ascii?Q?rlTPAwO2zGXlhvjLL6makwhAJwQbQAQ74tpMaO+PDeowKp69sK4oUSv0KszI?=
 =?us-ascii?Q?3gBVEJ66bZj6uOciMeSrn8PhWx6Q3QejkL1aRWx7Nr71ejj+Up/jdvatFRA9?=
 =?us-ascii?Q?F+8UannoCBIDg8MlK6L0vI+l9Lp86dSzFAvTf8wFmOxYmPmnve+TIrFx70qU?=
 =?us-ascii?Q?LU0YwnhrkPsK0Lzi1khbNtGsNj7Jghpne+UnzRmg3mIg5WFvIN9cedEQVW+l?=
 =?us-ascii?Q?4wix8dv+ZAXu3TSoLXwpMwM7edrlQynmxKqZoC+duFdqcz1Z9UcYAWVcuqoQ?=
 =?us-ascii?Q?JE+xCah8VT4K75b7mHiUt0VBuUz9XIw3MWP/ueLFQzEhOWNMTyFmaxB3dDsF?=
 =?us-ascii?Q?zFB3k4Pd4pVxbjwyt1GDutaew6OFsi1ARkriKJNsl5Zda3rKHMyL/JmMK/IF?=
 =?us-ascii?Q?16BpTe6DC01GoRMmQIfPcUp8yMCyDJTypZPu7q/HjfwgsJMX9jARi7QR/Suq?=
 =?us-ascii?Q?FVFa/2sYr8kYdBTuAjXtN8BPS0ZloFIdSSIlTWX69e5xlr/aNkAeVgermbVc?=
 =?us-ascii?Q?o10kbtgxs7YhYuXbKd6Or9KxYPnjZwFWH2hfa4icMwpSNSaA6vgi8/qpe6rB?=
 =?us-ascii?Q?SXOQYT6K5eD6XPe6MSn9UkYf57bfGZBclchD0PoYLcvBsi0BxifHrn1LQLVd?=
 =?us-ascii?Q?iueOy15CWZzcq9i+V+KsIevSOZCYslCacopmH5CTOMvvSk36g3bSiI0JqpXD?=
 =?us-ascii?Q?r9Xw4b/XI9jk7Bwug/YmiolXNYjyONtQmKkMo2YtUnk4LsNUCofu6PFhyWlh?=
 =?us-ascii?Q?TKlO5I357/KF7qGuBkzY2a1yzOFXHjq42VXR+TVNuMC+jNaOekHMRKgyPPk5?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xp9YUxuOpKGc4wAtIjAp5Kq+4uKNcIviIcslcUNWEiWKwkocfbMC2n4lmoBm8XVqufWum4HyYrCyFAW+AeQCCgb4CO9Cb4ty4zq2z/8sNedEUabC7GJZo98mCFyCfD9hz5Gf7HXbinQ2AMYTK22fjRe8VQcyohLE6cNjY/PUvNGQlJobTxr68aKs0UtpqvqHqiR7eucvwWx+E/x/GWNIb/MxzHVnylDEnX0wfzZspOLRIiXnMal5RF2txciawlvhrRBw8MfhzDqTfIDcjWagw6PoAnpO00ttTHUBD0Q/Dj/wunT8RHCjjhCmmSYRKTi3twqHzjAdjRzNnSvKHldabo7HwwhPrBWRLeC4Dmd4UjDMsoUV6X5kJCbtpXdPMJ0WEeMgGf7zsbkIxWVrWFTfpENpucJIS9zvMCIGBCasXSBuo2MCB/0bmYJ1H3pJKnX/Zu7eyw9nqiVCPFxgPA4OHyb++d/HRkLmIAkk8UWtzr+I9su2GkAY7yox6r54rV2BBfMB1I0BS3gpTG379CC1SGWblDgSe/AoeWT9BLnjwh8xk8mHkjCiAqBN2qZaiQkkmZw4NwirCY7y++zX0KBmxqForOXNG8DSu2gF114zxw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c554b3-0584-4c70-e6c3-08dce8932440
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 18:49:44.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgXAUIzL2JUa/5UnoEY+ue1mFtq3BNiHyrBGYjtToiJqvVuDK/8dFpiJkos/Yyg8Q6KnOGi0jJvQYn8qOuoZaA+T7HfNyu5KKekZK74cse4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_16,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=802 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090117
X-Proofpoint-GUID: KRHUhBsXXEf6FTMG44gCOy-FSy3dFb4S
X-Proofpoint-ORIG-GUID: KRHUhBsXXEf6FTMG44gCOy-FSy3dFb4S


Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 09 Oct 2024 10:30:28 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> > +++ b/kernel/trace/trace.c
>> > @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>> >  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>> >  	if (test_preempt_need_resched())
>> >  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
>> > +	if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
>>
>> TIF_NEED_RESCHED_LAZY falls back to TIF_NEED_RESCHED without
>> CONFIG_ARCH_HAS_PREEMPT_LAZY. So, you might need to add an explicit
>> check for that as well.
>>
>> With that,
>>  Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
>>
>> Ankur
>>
>
> So this should be:
>
> 	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) &&
> 	    tif_test_bit(TIF_NEED_RESCHED_LAZY))
>
> ?

Yeah, exactly that.

--
ankur
