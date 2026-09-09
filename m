Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAD2D7DEF;
	Wed,  9 Sep 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965532; cv=fail; b=hjmqvu4uBHgjzLvcNmwKgJpgVbabPxFDziPTl7hm8bcQumGOedryCNhxdwMwP24kutMnm1URm7/zMnH84vvWLI1kmnJDtzYz9Cg+qGMhiZrrJLk/13ykkWYgm6eHa6Oi+ClN/j4mYpUb8xrem7Tgk3SbedYt19A2JMGc6IK1vJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965532; c=relaxed/simple;
	bh=xhOdL0eNYZDq7k6XSPwwqAwQ35bCdgAstsd+lEygBr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpPQDHeXeWmHhBbqdJrjj/QQWh6GclMPW01flGQMKooij0t/qATusjEeHlmumCRCkZamTMwQ6S6s4C+zbdq1wyDWelBAfw74JpKQ/8UMJe3hzzdA931r2ho0hRioqoYVTQ1NhWXbV5gPpCwBbqHRkpx8gtCjh+KX7KntfSRkdm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtAo661v; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtAo661v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fef+jeWrJXCQEY5PNi9uoBBhuN1mQOQ1t48oE2N9EOl0QshJUg6icRBOZXvTiDWNKdCFOHD8SjopEpRni7NCC6OFyCoB9uOiZuF7cdthOOK3K52+rT0UcSNHOBDZsw2/RbckBhH6vYM7v9x48yKZX1aigHEJecmnVMDNlfIREneUiSMAJnOednIUuHuhlA7OswfzqKgw9ClY5/YNLlg8ud3lCyFWaUE0sZSL323qJWDhSq1fgTa8jDqQT5JfiNKimUPI4JjzkbOvYjKkBhKTH/6ZESc2SJHINUrZgSP/Yy0tmNq5P/cagAwygZ95ojYZLfWTJIpnFB8EiVoOUmcS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EBE/7JKLD+6t0plNbBz6LslD9y1KBo3Hgr3QkGm7GQ=;
 b=N6wAXVMzmLEG1gjUYSdBvZE/k/3wgSL7/5Ifs0joe7miPUhLDOF3ax/m18LI870w5JX18/PuyvOi0JkdtnqibXAQ7J72msAYeZRlmeFGcRbq8F5P9uUCNe3zkZ1yFddNYNRjA2bDJOE/9Vg4seBoLkeP0CMMiJDcc3Ji+SHlem3nv7uVak8VQIKyONjKrLvcy4O6U4QsfOURw/ZsQevFCLkptjIV+lilRX2bxSINgfNHac8lmepUCbeo17al7ZI0aXFrFHkYRGFa4YEvMnxUkw3KPIacFwVLVemuEtCFvV1plKz0aDuHg5rjb8jeP3NA3S3b/KVz0ul2cO8Igxuxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EBE/7JKLD+6t0plNbBz6LslD9y1KBo3Hgr3QkGm7GQ=;
 b=LtAo661v8LbHsfTeG4Vfv+sgRhWEdgbsfa/I2Nvg2xgndR1Is9mcEobG3XvrmOit9uvevDyNhi+hbl346w0K1xzAwruhFo47a5VxZymHs6tixpvAlNIYMaLSYJ7K+0qnkXPQoN1/a5GWH8YkzY4P2Jzxne4DHQiW/35duwD2hmx3zQ6Fs29769ubSqwCKIfgMbensobYJZEfVUEuCV7N4xSVLx6ybYMjNu17p9SJg2JVOZj18HYuKHAIJzyFVnyNnRMGVlywI88Id4jCTn7XE1b1aCJNJm7/QRoNtuOQIZXCD7HMZkS6e8e5KWC5FTMhIFq8X7DQnH/omgLMevHx7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DSWPR12MB999176.namprd12.prod.outlook.com (2603:10b6:8:36f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:52:00 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 14:52:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/14] mm/page-flags: remove PG_private
Date: Wed, 09 Sep 2026 10:51:54 -0400
X-Mailer: MailMate (3.0r7028)
Message-ID: <C4E561DE-2E7E-4B8D-AF9D-D9E7418AB530@nvidia.com>
In-Reply-To: <08c2d8b3-da89-47d9-87b7-fdc179ec4793@kernel.org>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-14-6ae22f9d9272@nvidia.com>
 <d8e9b629-4198-4281-a3b2-d54445201fd2@kernel.org>
 <1BF58667-A9AE-48AA-BA04-F02FB6D5ECF4@nvidia.com>
 <08c2d8b3-da89-47d9-87b7-fdc179ec4793@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: CY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:930:10::13) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DSWPR12MB999176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce0dee5-40be-45a0-8bb0-08df0e81e6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2UwLiT+xxgfAoW6/YKB2QLQvVTzHj+4yCYlMyPrv4L1WsJ1jIqV73/sezcK2kzhPKZfJvc4RFvlk+PBc2Ap9WegrNtsTQ+PdAwPG8ruRKXq9wgivVRRlCBVPbU6T+Oobbi2oWViU1+vTPgiQdRQc9GTJKZ841wqtiO5l8X3qurwmN833f60fxXYwswDXnocP2VSYr8jKPfgphc/wwm1RfGfcU5oHUy6Pnbh/CX7OujGs9sHzOHoPOM9qSy909KBqdvKqzgpQ/u+uqlLnkVKiBx9hnoHQctdqpAuCj72KUw2qOxfXAsqh6BOOw3c1Wh759d9QFuUJ3zAxlrJGTOCcwS/Ursp0qZBcxIUMPGfzUaQMpl8TdagQHWhfVWdEI3QtEqZ5k8iYdak66V2b23i3e4FmFMkUArpND5DHzsS6Gk8inpythCABlPsHqfdyjYFQPgU7oYr951740rBAbZOzmIVWxAVpEzntyv0DSC7ciG+Hg6WJirTLfzkgRHIiKmRZon6gtwFaodpBu6JLfJ781i70s9MVEv1xTsNwl9ntSlp2SQhk1hniGmDW/83vCCx8dAag/2xNWByXjoTKsCvPtUnqTSlGjZvwLnAHNE3HxLP/gdCo/Gb3JjeQW81oHnzdTftt06oV10VUcZvtfPGqJ3tH8uuRNPaw35t4r3SMcLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qewnI/61kyWgnTgmEenmdZsFrmApSPD6xsE539iO5jTsJDcKeRcTw19Ryilv?=
 =?us-ascii?Q?sE7a2qczcWW4t3k3H6OAKvFgH/POWFU/hehxIE0g2D25q4bhCajM6BzbbtAu?=
 =?us-ascii?Q?pvZMy2CxxBEUekzggFA8HYVJzn7FslSDam7VagAzkK0EW5r/V6nEbfi599wH?=
 =?us-ascii?Q?d3wSq70CjrEncfvax9Qp6CppgRfnsLLHR06+13Z0IbgWmaUxL0oFPGbwx/QL?=
 =?us-ascii?Q?idhc/NDJ+l0R+4GrhPHCm+2iERoiII9QUC13QSF8RqRzvjovKgRXHxDkIUPR?=
 =?us-ascii?Q?tldN1IyAYfCx/hyNxpqHRZZWYWBIB/fePuwMWba4779Z9e3mGj6TEQYo/LCu?=
 =?us-ascii?Q?jlV0sJNmFimJMp4CJzb9gmxJspkvPJaVB0nbJZmVAQYUCfGM7Wr0NYjDBKro?=
 =?us-ascii?Q?xd7z6iaBsfHrJHSMZecfadkGglW9E1Sk7by8yPnexaRckLOyYdYo8P1xOI3o?=
 =?us-ascii?Q?Qu2X9thbZPaKLFslgyyyrRUZpvr+FTRTbX/lrwR/YG6mCcJ7IdWSmdF/R0zb?=
 =?us-ascii?Q?lIUjYB+evDyy2hwkqb9IcZ5ee6ENlmPKQ7Nig740a/SFH3wBi+ibo139ofOt?=
 =?us-ascii?Q?yO+STubAoUZzJcYKeBc8Zgpcz6r4WA2mv4UvSY3CCPN+qDkxZEqeuRJR+okJ?=
 =?us-ascii?Q?L/WUMgDa78eY+aBKbBoi4vLK1QkXXw5unJIXhXrW7Kwu2T/ci/bPxusyPK9J?=
 =?us-ascii?Q?hC4MeiLQSpwcWH5bLZyTTSk/x0v6SbJfIx1ytf7RNE/OmWpq8DDOUTcSPJ0D?=
 =?us-ascii?Q?m+R2e4gJ42C6jgL8t1akC+RtAbluBfU2kI4sDwgZ46+fSGp/XkVr4yVxj3p9?=
 =?us-ascii?Q?cP8XFDGVdbhZDddQ/BHqSzyhbrAn/AVFpa/ZC+twm8KS1GONPwH+B8GGMdJ7?=
 =?us-ascii?Q?nIc0xY36H4fe7Zxu397rL8SB5djxRRiwmyxDSiG3RDLQlo4DWi7o5aeX/2YJ?=
 =?us-ascii?Q?/fzYNRe+OGHK9fnLLh/ahICvBYBy4noTmxe/hRCqRamO/qfbzJBRLe2+3P9+?=
 =?us-ascii?Q?vdOyoCde9YZHWxrX2bfgXlpVCXBtDiL/6OnQLtyQphIg93donIbj6D1sufJs?=
 =?us-ascii?Q?CLgVVC+JBQHRmoUpbT0j+EEi2kmSdlgdq7tq2QX5iVYCtczUBDjuKDDcjdt/?=
 =?us-ascii?Q?19cJp2j0UJGldo5V7yqmWsd4eGammtOaHB9LmO0G5Xh73S7kyCUQxxxSNfxB?=
 =?us-ascii?Q?T99RbvHx9QMGGL7FiTipUnGl7tbrGBjgUuKWwrbRGIMA+XT8SAUM2AGTnTMO?=
 =?us-ascii?Q?M0556iztWeaTiEIZwLK2nxyQDWbF3aVI9a3+7ty30Br9zPH2NEk5Y3TTzVxq?=
 =?us-ascii?Q?Z92e12CVNN6RqUchYKqHL+pxH5sdqwr4FGKUVArg6397d5SfLoPv0Kk2Znd1?=
 =?us-ascii?Q?4t6fxzU8kwr2AVEwBz/AIhGOLVk3M/lWRQxxSRnvk0Yk5n/UHkSqRvQAsB5V?=
 =?us-ascii?Q?XtPzMIE9B/zv/WBE5w2zBIBIh53U09+kXq2/5KvlDMfMAIgDZo3LevUSy4z3?=
 =?us-ascii?Q?yeycntjaIEGQJ+u8MY0ANhduc+U93psNx3sL1k1VTjyzr0SfJxMKJJN5jH0t?=
 =?us-ascii?Q?YV7Ybfud8uv/cijhObC5NIXKuFGe50RDBoOo/BdIc97/PINyBwbNxMDdkJHS?=
 =?us-ascii?Q?+Ga9wNbTSBxojmjs8k5zBOMa/R/qQhVXOaGnFaOxHUqNtUZA4QqMUz2OsjAe?=
 =?us-ascii?Q?yxojv7+KuybXrNDpfeQBso6lSdq/CBqQVli0KI/IqQ9bNi6j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce0dee5-40be-45a0-8bb0-08df0e81e6ef
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:51:59.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaH0+KOviNSRCdr7EZsWKpLZOz7AN2eiZEQEO/jX7ljsgnpssYqzKCUkebiq21Hn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999176

On 9 Sep 2026, at 10:50, David Hildenbrand (Arm) wrote:

> On 9/9/26 16:48, Zi Yan wrote:
>> On 9 Sep 2026, at 10:31, David Hildenbrand (Arm) wrote:
>>
>>> On 9/8/26 04:56, Zi Yan wrote:
>>>> folio->private !=3D NULL indicates a folio carries private data, rep=
lacing
>>>> PG_private. All PG_private users are converted. Remove PG_private an=
d
>>>> reserve the space as __PG_folio for future use.
>>>>
>>>> __DEF_PAGEFLAG_NAME() is added to show __PG_folio.
>>>>
>>>> Also update files in Documentation. hugetlbfs_reserv.rst is outdated=
 and
>>>> left unchanged. It should be rewritten.
>>>>
>>>> Assisted-by: Claude:claude-opus-4-8
>>>> Assisted-by: Codex:gpt-5
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> To: Andrew Morton <akpm@linux-foundation.org>
>>>> To: Baoquan He <baoquan.he@linux.dev>
>>>> To: Mike Rapoport <rppt@kernel.org>
>>>> To: Pasha Tatashin <pasha.tatashin@soleen.com>
>>>> To: Pratyush Yadav <pratyush@kernel.org>
>>>> To: Jonathan Corbet <corbet@lwn.net>
>>>> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>>> To: Jan Kara <jack@suse.cz>
>>>> To: David Hildenbrand <david@kernel.org>
>>>> To: Steven Rostedt <rostedt@goodmis.org>
>>>> To: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Dave Young <ruirui.yang@linux.dev>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>>> Cc: "Liam R. Howlett" <liam@infradead.org>
>>>> Cc: Vlastimil Babka <vbabka@kernel.org>
>>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: kexec@lists.infradead.org
>>>> Cc: linux-doc@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-trace-kernel@vger.kernel.org
>>>> ---
>>>>  Documentation/admin-guide/kdump/vmcoreinfo.rst |  2 +-
>>>>  Documentation/filesystems/vfs.rst              |  6 +++---
>>>>  include/linux/page-flags.h                     | 19 ++-------------=
----
>>>>  include/trace/events/mmflags.h                 |  3 ++-
>>>>  kernel/vmcore_info.c                           |  1 -
>>>>  5 files changed, 8 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Docume=
ntation/admin-guide/kdump/vmcoreinfo.rst
>>>> index 7663c610fe901..5f1df6d080508 100644
>>>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>>> @@ -325,7 +325,7 @@ NR_FREE_PAGES
>>>>  On linux-2.6.21 or later, the number of free pages is in
>>>>  vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
>>>>
>>>> -PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_ma=
sk
>>>> +PG_lru|PG_swapcache|PG_swapbacked|PG_hwpoison|PG_head_mask
>>>>  -------------------------------------------------------------------=
-------
>>>>
>>>>  Page attributes. These flags are used to filter various unnecessary=
 for
>>>> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/files=
ystems/vfs.rst
>>>> index d3a93eec3945f..dec7816303c6a 100644
>>>> --- a/Documentation/filesystems/vfs.rst
>>>> +++ b/Documentation/filesystems/vfs.rst
>>>> @@ -649,8 +649,8 @@ Writeback.
>>>>
>>>>  The first can be used independently to the others.  The VM can try =
to
>>>>  release clean pages in order to reuse them.  To do this it can call=

>>>> -->release_folio on clean folios with the private
>>>> -flag set.  Clean pages without PagePrivate and with no external ref=
erences
>>>> +->release_folio on clean folios with folio->private set. Clean page=
s
>>>> +without folio->private set and with no external references
>>>>  will be released without notice being given to the address_space.
>>>
>>> This reads like it would belong into patch #13?
>>>
>>>>
>>>>  To achieve this functionality, pages need to be placed on an LRU wi=
th
>>>> @@ -674,7 +674,7 @@ filemap_fdatawait_range, to wait for all writeba=
ck to complete.
>>>>
>>>>  An address_space handler may attach extra information to a page,
>>>>  typically using the 'private' field in the 'struct page'.  If such
>>>> -information is attached, the PG_Private flag should be set.  This w=
ill
>>>> +information is attached, non-NULL 'private' field will
>>>
>>> Same here?
>>>
>>> Likely this could have been restructured to cause less head scratches=
=2E I'd
>>> expect any documentation that refers to PG_private to get removed bef=
ore finally
>>> removing the bit.
>>>
>>> Not the end of the world, just a bit confusing while reviewing.
>>
>> Yeah, I will fold the document changes into the corresponding code cha=
nge patches.
>>
>>>
>>>>  cause various VM routines to make extra calls into the address_spac=
e
>>>>  handler to deal with that data.
>>>>
>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h=

>>>> index ce7fccd90367b..7b7783c0a5216 100644
>>>> --- a/include/linux/page-flags.h
>>>> +++ b/include/linux/page-flags.h
>>>> @@ -44,10 +44,6 @@
>>>>   * Consequently, PG_reserved for a page mapped into user space can =
indicate
>>>>   * the zero page, the vDSO, MMIO pages or device memory.
>>>>   *
>>>> - * The PG_private bitflag is set on pagecache pages if they contain=
 filesystem
>>>> - * specific data (which is normally at page->private). It can be us=
ed by
>>>> - * private allocations for its own usage.
>>>> - *
>>>>   * During initiation of disk I/O, PG_locked is set. This bit is set=
 before I/O
>>>>   * and cleared when writeback _starts_ or when read _completes_. PG=
_writeback
>>>>   * is set before writeback starts and cleared when it finishes.
>>>> @@ -105,7 +101,7 @@ enum pageflags {
>>>>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>>>>  	PG_arch_1,
>>>>  	PG_reserved,
>>>> -	PG_private,		/* If pagecache, has fs-private data */
>>>> +	__PG_folio,		/* Do not use: reserved for folio identification */
>>>
>>> Do we really have to annotate it with __PG_folio ? I'd just keep it s=
imple and
>>> have the comment. That also avoids __DEF_PAGEFLAG_NAME just for this =
use case.
>>>
>>> (sorry if this was discussed in previous review rounds)
>>
>> No one complained about this yet. :)
>>
>> I do this because I do not want to change PG_* values after PG_private=
 after
>> PG_private is removed. And they will be changed back to their original=
 values
>> when I add PG_folio. That PG_* value churn might be a headache for kdu=
mp?
>> If I add PG_folio the last page flag, it can be a one-time change thou=
gh.
>
> Sorry, I meant that you just use
>
> PG_folio,		/* Do not use: reserved for folio identification */
>
> Without any further churn. Or is there a problem with this?

Probably not. Let me do that.

Best Regards,
Yan, Zi
