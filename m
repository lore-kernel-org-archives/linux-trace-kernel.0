Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295B231A2A;
	Fri, 11 Apr 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392933; cv=fail; b=NxrXgQFoTgE4lpnPsanuYHICF812zajP6nxUHJ12UDyiV2upjS57KdljbDN5vJxyz7efDX+fuQyiUtSaQ6F2g8yMt519B5g2kwCSCdxruSJa7NpuQI/PcpeMtwnHJ+eL52sT59SGi9MsXQw29ZUiJMxDfAJcv+t646UybHx0nNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392933; c=relaxed/simple;
	bh=dl8ew0ZBoK8xOVxJBbGsRrhxuNlKCaXsu4Mso/SCQ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FFoyxEGPRLpx6cEMIP+G3OUgA0eeoMuNJe+n5lHkpvMcFz+RwPywo4b4/pbGL8AIE6b89pCZpyG69OB2Vq8H3Gud1jYZcORVd1Ye3n+eHKvFf4ODxHX2UOaLRLeuc0THZntmU706jqrHio7yDRiqkOFOL57nThLIOOy9Ytdm+J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSk3MDOQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BMRo/AeT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSk3MDOQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BMRo/AeT"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGvCpK001668;
	Fri, 11 Apr 2025 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=T6HHXUqylJLIQqWW
	IZRJvQkxI2aF2gLOseYX/kPTR5Y=; b=dSk3MDOQbDEjD75mK/Ty/3jiyKlsSSqr
	HrlHSg4tqr3LxPbJIo7y3d4/WCB2x9GOSdk2TFYFkIAxe2uiJPvl3wUhrjJFGQGh
	yFibiGFTCm7+v1AonKnkomwZMGHPeWYCKo+1dZpPOZkKs+6G0WtsDrSV3K8YeDxV
	JyuLeKUzq8YxjcD4tKD2jeWC7/MEGR9AzmVM8an2OeLfDTZpQgeJL0gEYSQVHe6a
	xdS/+jpDqXbQ4PTiKRsGrOa5Lr4yIJ1t3pjDlQWH3vybrox4D3OQvMj9UDc6/GOv
	H2PLLbFhr/ZwfZvWMvlR4/yiG/6uC1/G497/mVkguQD0VvHjjD9n4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7218245-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:34:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFs9uo022183;
	Fri, 11 Apr 2025 17:34:51 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyepxfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAoBdYvR7Es+ZmCwINi+Xao+vniQDamwvso/BQwaKNHRwZXcKXdKE/AP4O64Z+OuLveFHRmO01RBy+EAQBnazOG/3qYsA/5FTay9Ut+DBfzbqsiLwVXbxPIXSkKkq+yCXuePK+f7IBD0RmKB2BdoR74ha1Xii+KKxTRMmuPGfoU5vkCiXGuvzqQ9WhiWtF1cnWPXOxGgJiRMxoMU/7dNJ+comsKJhnE5ptbfgv+K2jG8LU75A9T5qNNVy1zG4YCdK71S1F8XI4OO4cHEkDUzoatiiibm/9uJYCybGSMKjHx7iFmVvmxTnY00tWQEYfVLATnxnauDehTcvhPVG51Acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6HHXUqylJLIQqWWIZRJvQkxI2aF2gLOseYX/kPTR5Y=;
 b=l2NVPkhack1IxbZrf+Wd8ssm5M3rzWHg1asFroioV+66uCJBC6oYZIUkne5h+XzIxl6fi4XLhjpIL2V7mLBBNuE9gMGkUSgPXV6fBzZGilyU+tZJ+ZnkTKaa97TpeNifZWEDoQibnI5kRjbFyB4IQspM4emkuZ9fj+Pb9SZNHndFfyUBpo1GL4CbEw0WztL6OL8fG2IOC9H3If09RAiGnu8Ompb7xoQ5/cSIFlgP9y4xxVkWwdhLx7dOWl+Flaq8hW9qnHUUhMEWJ/hvjCcbocuv3V+wyr4vIEUloGuZo3uDPwvhe2u7mbbbAPZjrgW6iTdM9zc8gXjqzQtmXa/9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6HHXUqylJLIQqWWIZRJvQkxI2aF2gLOseYX/kPTR5Y=;
 b=BMRo/AeTDoUGA28OVuz+mqprhUYDFgLX+eNxALOCsT0UIheH6Q4Ca2ex8py4OiZCAP9CmMbPuGNN0TlKHdXYZ17PAVwyjyxyf5wh9BlvLgAgs0iqctzxgP1zIKKSMUaNSQ9v6o8slNy+jDHmg7NmQx95zCL9CVUJcf8mJoH0v10=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:34:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 17:34:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
Date: Fri, 11 Apr 2025 13:33:28 -0400
Message-ID: <20250411173328.8172-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0227.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::9) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca7814d-22d6-4789-8acb-08dd791f284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnGgNsvWTk4NuQYPFGdoMUrNT4hgQqVfc+NrIFSygL5VBvAoBjkksfgFDY1a?=
 =?us-ascii?Q?ToBqhM/KaRf/EzfNHVo0q/wlD8n7OpixtlCAKn4bdv/l4HJlW+ztuMLiLe5q?=
 =?us-ascii?Q?UNjtRGfmGEw1PBr0ZWgt3qtxyl9U5wUW+MJsj3vMa5h3PjvB4v646mFrwjnF?=
 =?us-ascii?Q?hMXTNdrjFKuSWexdBSIg1UA6+BbfDtKS3TnwXi4Z2VA5+/0hEpxbaFu9xXv+?=
 =?us-ascii?Q?zfkZhyo/wHg++ZUhU4x2zDga2573spwMUAcHlXt5Jj6zwAAGYneK1zRJMSBi?=
 =?us-ascii?Q?GoxJLVn/jlcaBIcVsdpW1PdA02lua/egazlzIpctBpY27/Wxkn5XGPiyiWjP?=
 =?us-ascii?Q?SqrgQgXL9V2qnrwAa1bHijuz3yVvrEmj4uoGmRufsbMX22FBSoJ0Wf2atI43?=
 =?us-ascii?Q?6lGZ/QPvTAVz4HTdA5d3oj/YfOnvdYZV48l07mFN8kvqfat9i8ewI5IVseOF?=
 =?us-ascii?Q?7z42RU/zXohQTwJ/gOQ0/f0KCxsqr5vuQvfjT0bGodda6ne5zS4fFWMU5s5m?=
 =?us-ascii?Q?jr1cnej1BRxRx3hanUzfP6Ttkl5iHWdaDpJ1PA64V3AKeHpLc4GmOQSBOGWa?=
 =?us-ascii?Q?/MbWwpzKofBjcs88j4HP4v4D+v/0zv1rlTSMntYi3SyejqezuZ0R32KuRRFO?=
 =?us-ascii?Q?gbwDBqac518dr9GHWc8fZS086rJKntK7XcNnKQ1ramxQgVPaaY+CrlcDhybr?=
 =?us-ascii?Q?gWyEnVb2OXEMZQGv52LCdxayBZ9/k+9iOvt7KgMs4QSoIPHOJxk7dAVnzYu0?=
 =?us-ascii?Q?axv6WP40lQArxpZTC3jVHkm4iU6vy3TfVf1GzckMM4f0CmWrYS2tVeNoXJTn?=
 =?us-ascii?Q?R8axywWu4mbj3WlObYPbT8b5ATORcZogoK669//XQDaHAalEuiD9Mj0T9FyG?=
 =?us-ascii?Q?ZbbJMeJ13LUgVk7TxIypX4QnkmAb3xczhfnxlDIuDRGWKi689brN/obeNkzc?=
 =?us-ascii?Q?gS1I9geBT87zg7xHSr4HQ85iSiOaspPvOKpTqn1DPPsFeseJqF1IxKblKri+?=
 =?us-ascii?Q?Xrz1uhc+6npF1cc63mlfOw61fPbVFenFJXyYDd5TK8JIjbag7aZfugB9vfBm?=
 =?us-ascii?Q?lUwUBBhkZ8OVVj91cIvwOu/hZ05wzE9+Qj78Ns5dGN48cGh5ntxBKCz/JKf8?=
 =?us-ascii?Q?swRDiatPWobl9n7W5IByLZxhKb73FG9a5yrirayJrf6ycnd/U1jYPvy4hIXy?=
 =?us-ascii?Q?z4vT4gCWJMH4ZWiA382xGbTmxmkgeAstCgd0K7PFujjfh4t7JUoMD3sBEZ63?=
 =?us-ascii?Q?XbbtFQ4gKdf4wFbSGIm08i1KSbnTaCarMz8kMhWTwLO4fWf81wK5IExLD4mG?=
 =?us-ascii?Q?bJd7E4vrHAKd42/3psRyM7w8beQvj6C9vB+ToDMw5ybmcSdsxfPF0U00sYsM?=
 =?us-ascii?Q?f+jx4M8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nh+Sy8XKgVJ0WR6H5PTM9Ps/7o94Ygt2itR1wFt9YccUGPI+HBfLLdX14Yr?=
 =?us-ascii?Q?6TqNScYrcGmM3lvtyhyZ8+m98ylXzGrpxWbssGdOwWmFTYRSfqA3YvRP5Qd5?=
 =?us-ascii?Q?ry5ffCfb2prSjMV0FkJ5y8jiYps+G08jqSyNp+0jukY2a3ti6dePShA5nVGF?=
 =?us-ascii?Q?9Lv2xzT7z55ommGZNC5KAfpVbfrC3kKcomBCkxeSlvgJwMlt0u5MX/wJpnkv?=
 =?us-ascii?Q?REBdgOoq/fFHwto80Gr6LdmIfZOSV2QxqvscMMbHQDncq9q3jRL+HbVdMX/C?=
 =?us-ascii?Q?lbmoWHheJXAIcEqZkgA58V1PLJQbtdinf4XeYU+4XvufV10URJQpgoYS2inl?=
 =?us-ascii?Q?FuIJJ4hGnIimyow/aUriH2RHQPlBsoBC/NpBql57FHRRZz5gkqDWrvkpg9Kp?=
 =?us-ascii?Q?XNqSoxcLIssVxsb69IRpSZ4b5QC9AJ36lnUI657XBf2baJ+WP1XOPwHSK5Pv?=
 =?us-ascii?Q?hJ6Vcn2w/uQFq2wbm3NCwHG+h6ATDzwc7s3josR4RAmVOD/8/E03XZmVKKT0?=
 =?us-ascii?Q?Mb5VxL//sanH6OWCgK4GLVmDREtAiCHfqfzbjv5CSlBMrZD8AUCQYjiV0Hl/?=
 =?us-ascii?Q?GMK+04XFTfLBexeg8j0IOe5qdhF0UhNUu2ZuvLU98vv8pOHfnwbMADOTZo1k?=
 =?us-ascii?Q?/HxLOySDD0S+Ok53zF5oOSUGMzOq0rc09FFNWzUxmqPXCIjYvPJSQoTaTPsE?=
 =?us-ascii?Q?QfV6HV6kIZ1PAvHbvhQIlbIbrWrJLSF/G33tHewmtwldQA8idVwDjO/M+cDE?=
 =?us-ascii?Q?hvgC5Xvo/qKigmGxcr/5VTO3b/5ZMUYlHq/YuVfKDdORT87+HsJ/CYrJn2P2?=
 =?us-ascii?Q?tc/biruOZS7ANDrFOjy1ivPmebUQi1NVyeqmUNiYgtm0LLnHF5Z+YpwJ0kXZ?=
 =?us-ascii?Q?AVj8gTXzMCARFpbvT/Glytd5NGIBzD0Vqv2NoWlXU68XDyaUaXkdBVXwq88T?=
 =?us-ascii?Q?L6Yi0aFPB5Nwx9mgiWG2ZGsBNyTVZvN+JnoIqCLIRyfjO60kS02yLYgd+57x?=
 =?us-ascii?Q?NsSPy1qdTtvY8UgAttwYO3lOm8Oz9h/EBqkm21p+jQ3+kW8dFXAuoG5YffuT?=
 =?us-ascii?Q?DFoDqSUqXbphzt3v2jJK1CAtXpDOxkDJYNp/kfqw1+ShGJlnBdF24QO4aDEP?=
 =?us-ascii?Q?K2CljDE81dx8mv+APbi1kiBcuBLDIs7OIbxBAb4CHBepsVXqOmjv9wtQ0exK?=
 =?us-ascii?Q?y+Ul2pCL0tB3lYrxZd5qi5Zlz9MNheq4yaVsokqSbliczyGpiDckr38PRUrP?=
 =?us-ascii?Q?NgEyHUvAmNIVfU/Ow14jXlpXhRu5n1QendNsNPRfoeqLyKfFqYcO3d8gCJ+t?=
 =?us-ascii?Q?cau7OxgYPMA+yaruw6K84v3lgxYRZwxWdRRydaCcaAy9ODGCJxRGwNpEdapR?=
 =?us-ascii?Q?l2MGEfZqEp4ffJPned6uJsWS/AJFl+p87GBGjXToKvR7G+AHwCcMT1p597aO?=
 =?us-ascii?Q?+U4mBI4E3GLDV9YXX9lWDT+XxvRetYijAB1siZfSsQgXZBEAJ9nI7wxJ77If?=
 =?us-ascii?Q?JZGG3oYYX+4BmKQLcdM/q6fqjiSHcwfAzIZygxXI5Ml5b1xjX4srx3DfIWEe?=
 =?us-ascii?Q?yY8ok23v/2r/Ci3i3pvg8bWYZWBQtPaIMVviujZ8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ekLoDF01uZR5sakq0etSxYeuXoNX9PJ37ZNX2YDDs++zAaklmMh6/C106u7ufy6CshO9Kch2UNYEXHFa1TK6zF/chJTCsM5Qh1NQvhWVa1Mvmiecm9hLJ15lWXEsybqjz2HB6o/8P/ZrrAgwjTbt6gHyrrkgZJLKI0L5O6CJPWnKyswVNE4B59cYaswzDK4VLRTXQL+VqabemIZ7Z8ux9+JaJ+L0m6hIyEWMwvVHPbnyC9DkOOQsscfTQsCGzOFBJqqdIuzKRB1SFI8nKVwURkKAsrglr9pjbkEEqgBLz7nJzP2CXfnb4ZqAam0PMZeXqOUH1WW+8mhsI28Pva81gTE4qq1BEVmj3QjH2Lr0qsVwu24VDKT0uYIO/qyemRX9f51iYHKzigMjjLgGC3agUDjU2IZo4eIjf2+o+lBcZiZD4hAHRWvqfaixzMVFgpPd8kTzwoaEzSPT62+D15UKheYXfgWX1xvrzuUihv7Gdzp0XVjSRz9O9vgdOTf1Nfq3LCgICE1hJs3w1YrZtzCYghC7e7f1LWYA9Ga+qsQw7E5Ody50h6or4LTNtrD+Mkuz9Q25QITWxQraNyZc6U25uiYh0l2ENBkuFJ41oXQfJqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca7814d-22d6-4789-8acb-08dd791f284f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:34:48.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKvwit3+7kPrsBa2sbMN/EWw+BVahMIgMIcp3bBT8rGOUHnDANvA6Xu6PJmcEd75RB7XUhPkfq6IuV5zgKgjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110110
X-Proofpoint-GUID: XesIksY9kk2NWmJoq8-Ln6uaJYk6xMeQ
X-Proofpoint-ORIG-GUID: XesIksY9kk2NWmJoq8-Ln6uaJYk6xMeQ

MEMORY MAPPING does not list the mmap.h trace point file, but does list
the mmap.c file.  Couple the trace points with the users and authors of
the trace points for notifications of updates.

Cc:Andrew Morton <akpm@linux-foundation.org>
Cc:Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc:Vlastimil Babka <vbabka@suse.cz>
Cc:Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c7fdc41a6bfb..d8e9a10adc81d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	include/trace/events/mmap.h
 F:	mm/mlock.c
 F:	mm/mmap.c
 F:	mm/mprotect.c
-- 
2.43.0

