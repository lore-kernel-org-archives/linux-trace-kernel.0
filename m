Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3328C5CB;
	Fri, 26 Jun 2026 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481383; cv=fail; b=YmAYHCBThYrcv57tRMfy7Zq920o2njYiMBi3N2R+tn2Ck3Dmnrj3dmdpBHXO9qSrjLPokNm1KmiDu7M92YRBqKHp0/fegY0ZEAnb61ctGXz7k97Op21Tmu1cRiRfIWvE3XmrJkcg0VWjbOfPMSe/OihQg8pRVIoFgCgZuIZbucU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481383; c=relaxed/simple;
	bh=/v8RtTuUhAVhVkuYqvQ1O0ftda5O0TPmEj8Ehm7Dl/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRXm7VEZ5UKAMcDp9hK3F6KWXzzSi58O9+mQa2ITBKXAijbEs3tcaY1Z9W9khwMrAYendMkaRFa2TBqojw8LR06IoI+9h+40kkB2hH7qpgn0NZ2p9YZFsfUPnRIpRlFWZQawQXfQE5Lr8lWHP1bM7XqhWoLX4xlHRWmZmdwBow8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=NZUtMs/g; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="NZUtMs/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txrpnqgirYlpA1OE9RKUptgsKAlC9B1QyDOAUllDGbXvgAxv1afBWmeeeQWx3INPD0Rz6wa67bZd3oOQ62ijU1UvG3NJeq2MpWN5JT/ITIyYivBL+Cjp1IL+oqMkpKnWfsdBldWF/eCbBo2J7XTUViLoF6tuiMsmStEU27CYcTzCu4VO/Cpc/Y0Ip7ETPmCPVuQIhvyH9/hCCNMQroskpsUiSWcGxPHACtyg7882ehKIKA2zn2p3QUGOwtB8IArtUH3bjYDE5c1h/8zLT16hq83VQ18tFhiy8Wn49qpuyqgQGFBGYCvRMbDSgdF38h+pWOvBvfXea5HEIvKB34qcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhjfHRkIf3517tVmDO540fbMJ+KlLZSCmh4lihZgtO0=;
 b=Zl4JhHpYGqEf2Dowm5u7OoS0UotIJ4xDbhpmm8TLKxKEuinkcnmsj9OHkXmjGIru/N4T+AnQKWd2hpXoqyNr0H/YsEaDFdFIWspjQa5EHT5yNrUZrBGdQAdZ9M3h20PirqfmNjHFZL85utRJmMe7trKHC0pegART5xJbWk7s1hbvE+pynb3GnBQBa0/00wwIRAAOeaJnUhICBci+PJ7E8eEu/GQV0/60z2IIQZ3aoQLFG5dgcj0Nq7lRigbtsVzbReou4tZjopvQeChY6lJILzdvQjgHsHycG+IkykmJOe70HLYfCshtvM+mq+Ldpnz6NKDF5OC5myHwsGvhaNf14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhjfHRkIf3517tVmDO540fbMJ+KlLZSCmh4lihZgtO0=;
 b=NZUtMs/gTwosP1orlpZFV9MYCZEXCbScQbJsb0Xs0S0czfmye0zlZHmpHydJW3yuYP/RhomxWnxmfIzIWKUeKKUMimsGXD4DWJFMHopITE/Yrw4A6FEdDHutqeya9epimR4ar6/VcTwgeasC/BmTrIE3BdDgLGV7NnxBjIpWzrm1K5iCgLTWSSjOZBngbmmh5aIPgvrKyY9OH8URTWBPaeYpvLAPsYGRlxJYYZKFvT3UHzqbWb/PHhh+8Aog5B/qf2NjwRiwc/sLeoP0wxSbsbtgOMeB6nq+TpRr0arV3gvET1cp3TPP1IkwEah19f9gpouqX3QfQGeNcND1teT3WA==
Received: from PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:63::22) by AM8PR01MB7930.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:3d9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 13:42:56 +0000
Received: from PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 ([fe80::7c4:3143:57b7:cc04]) by PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 ([fe80::7c4:3143:57b7:cc04%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 13:42:56 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: Wandun <chenwandun1@gmail.com>, "Vlastimil Babka (SUSE)"
	<vbabka@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jackmanb@google.com" <jackmanb@google.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "david@kernel.org" <david@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>, "liam@infradead.org" <liam@infradead.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, Hugh
 Dickins <hughd@google.com>
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
Thread-Topic: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
Thread-Index:
 AQHc88tI1dDVY1j8J02KOQzrNPN747ZDLUoAgAEaZICABitEAIADOO4AgAL622mAABC2gIAAQ82L
Date: Fri, 26 Jun 2026 13:42:55 +0000
Message-ID:
 <PR3PR01MB6666EC8D53E75F742B37270282EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
 <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
 <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
In-Reply-To: <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
Accept-Language: de-DE, en-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2026-06-26T13:42:54.929Z;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=1;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR01MB6666:EE_|AM8PR01MB7930:EE_
x-ms-office365-filtering-correlation-id: 19c92112-1a6a-4309-e674-08ded388d40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|3023799007|38070700021|6133799003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 4nl0H7r7TBdlZXmWo+6lcu25N/HSiQ7JJguVc1AeOtAYK4T/FTCnjHiC7CyO+6LgLT3mFgxHWBRmAjvInStzdfobzBdZbVXTZuhY90+BJPLq4sergYPV7kY/XcKbHkQ+foELpHllq1VkZf095s4AatV8QN6SL3mCRfr4iZVJVKRRmbKyJ2a4lQlOOJ7kgkZ0kTFGCpkU4pi+IqaXh4Y0msBdqDEvfz7vymRf//9bSK2wElAIuRnSLhscg30IZ605auWeI3Yh4hi5FGDgMZoiBbS314HHCIwg0RPsOeDjv3p+LxcYK66Ob4knla5GplFoXdRUSf9STOEzfnQjukUjo6efO1CDqKsYvOhyTXKoi/Xq6x8IgHxZBkwTA8CtgDfey2AG97Wo31/cWXu8VRGTSl/MW3kwgsq92oknrEHrUwocEOQLiZD0Ng5BfD40AHsz9OsGrn5oHmYQQxJoucKksPD1E9RLfOp6QNRBROKc8S/kzX03bFgOoFTA3qFHWdKCV6BWEcJJVwG/gNtbrDI34P19vdCYuCBb4T59XWqL3PQzr5XmHMQhrwrT2KRUHoE46HH0RgyjzDbww6r3uOW7VygtGpB1C4LinNIvrBjlWGpI+hguPkPl8UiowTR6lTFYXjCJNYiMrsS5rlA48ZnF6NC+OS6IYM62Z8O56m1E0lkN+rDfpkxl1a8eLRDfednTxYUcNTTwIWguImQpjZUtmnx2ORovvYw7dJbA5R2ChM0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR01MB6666.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(38070700021)(6133799003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+PxdPxwWaBQoyFlxeZslL9Urq+oD6N4IVNRYTxDSx69Rnalt4bACsqQkok?=
 =?iso-8859-1?Q?/kbHAIlg9X5hc/zve1m2S5AoXmklo9JMbIWn3sRZbo8S3jSGVjy3Al+doV?=
 =?iso-8859-1?Q?/KlV45qn/e/ScT5bU0OwpjGE1+AqGV0b3tn3Lntfp+2HxfF9ixIB5WL085?=
 =?iso-8859-1?Q?F7+1k1eBemeqQmRKEOkQcbGw94o7yQbNyU9UpODSMA0x3HUFFeVUjRi312?=
 =?iso-8859-1?Q?leHSKTpm3L54yolU3atr1DmwZ0gKjhzUsc0JQnclKP67LH9Z5hTNMFSRF/?=
 =?iso-8859-1?Q?XOQl6ikJWZG/f5CBdPwicTNPVEf/ryV+3h3HVyiGeEuhyTsySEyXs6+v9/?=
 =?iso-8859-1?Q?GXjqAujdKkPpJmLIL+bLIFdedPU3IYszSBrNDdZX6XYj0vazcM+g/dIVQA?=
 =?iso-8859-1?Q?CB5GpzM8owi9r2jWaji7pDe7jstbQvXnBV8zZGsFf0RjFx1QaSXYZbuyAX?=
 =?iso-8859-1?Q?Ce0v2sh77NF4zmH4+70eCuhfOlhzCdEXGzkeQTuZL8DIajshOz8O+jX1P5?=
 =?iso-8859-1?Q?cfO9/hjY4NvKec4+woewUbgIGjmfVGYFAzkPe/I3pEpwfcyiIaBR2a3pYF?=
 =?iso-8859-1?Q?+BkJY9c/Fo+FczdE4cLvOsho7xhXXRJq3YxTEIEuqOsJ3n3/N5JF+AIriH?=
 =?iso-8859-1?Q?opsbfaySiCukBgzj9Rk6863j7+a/5JFl8Lg74s9xVTqhHfg+7K0X0uhFVE?=
 =?iso-8859-1?Q?7z+3ZS2jg5DQubIf8QFf+AHJEp6gU5vP50d/nG1QedDqOaSIXTJc4zCMzY?=
 =?iso-8859-1?Q?8frj56e7TsmeK4PxCvmLMJ66RP+I+f1ki+5F5EHvGKqmxfpVnvKbMss97x?=
 =?iso-8859-1?Q?ijdPpVrPSznemoZ4OnUH5A5Y/be/LRPTu77Y0T4XUhjtpRCLABQ2UkVG0X?=
 =?iso-8859-1?Q?jK8F2zFsQc8YpgBvo/yQuwgwCSdw2WQpNKNa7qsEf7QP4Ofv1kDBgKu4kL?=
 =?iso-8859-1?Q?S/gsKFN+ggbiXtF/tO1RmOYFFFP5+XdxGgNx107Y9o9SC7tKh4gtjQlg96?=
 =?iso-8859-1?Q?Wh0LB5jIwuYIIvXXIW1ypF1J6fkqBRMyqTJKC8FjYXxf8cWvfOfZK69503?=
 =?iso-8859-1?Q?6gKxps6bY6FcfPc4/Sg9B1M8J9n2HwV73327ZZTkukS3VkCPc9Rfcc3gKG?=
 =?iso-8859-1?Q?7/n8T95lAEfTeQhJ7/u5t4mH7rqD4ClnvjKDKQ4VoVHXKVbSK2nk6nhIr7?=
 =?iso-8859-1?Q?6WKterJ9f+NUctbIZOAFRbTZDiv+saHhl1JUMQJNtMBEbMD4d/+1kEu9L5?=
 =?iso-8859-1?Q?DK7/qetSgJYSkLcF0HbwyBr48wFJbwvWcNi5N5MVMDPMDC+Da+S+UhqnDg?=
 =?iso-8859-1?Q?9IDlV/oSzWF9Fnuw18PS6zQhhjcCYypy/YTVBv3iYVnaiViSH8581Ek5iH?=
 =?iso-8859-1?Q?QehfRWl/LMZkOUN5y65RhsnZ/4AaH1YjfSBcFCR1eccmp+s3R9LhXXVexs?=
 =?iso-8859-1?Q?2a0A100e8UBaV1SKxj9//cu9V0+UcTB65WjRtEDTIrxHRrzy9GEfdNSQTS?=
 =?iso-8859-1?Q?dbLuPlSg+vg+VIrQbCSb4Jw7NuJ7mw2ETuALBC39xuZuXabN+AKJq1ecvx?=
 =?iso-8859-1?Q?GEAZtIKKgL+6AAX6+phfVz4Mv0R1QbQLd6lp5J7Dr+HOXcDsSzMJutYknE?=
 =?iso-8859-1?Q?5QjltuQvt6UF9u8fpSuA/4nWWJcijducf9efkpzOHBk2aUrVhgvLl8NeQK?=
 =?iso-8859-1?Q?w8ckyKAcQ0tYCKhx5ZL3ff4+C/rFVOUvEMR9yXLosAaVFMrAeu2EzFkT7K?=
 =?iso-8859-1?Q?b3BoAufZkD9GR6FVA3PjJa0lHUhSNkXij3O6nUnAIQ39fsqWZyGUbRZ9OG?=
 =?iso-8859-1?Q?KUheZ/4fIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR01MB6666.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c92112-1a6a-4309-e674-08ded388d40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 13:42:55.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2m66vkxbWtsKFI4tvY3BwCj3yZ31AeQkPImlw2bVCCpZqYqhxp5SD6dBm5bPHvKuDQ8TwZ6UdJoUgTGmGZ1tqJEVDEbjiQ9gTtKhyw75Q4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR01MB7930

On 6/26/26 11:38, Wandun wrote:
> On 6/26/26 16:45, Alexander Krabler wrote:
>> However, we were not able to reproduce the actual race
>> (mlockall() process waiting on a migration PTE),
>> not in the past, not now. Might be hard to trigger that race.
>
> Not hard to trigger that case, I added a debug message, such as below,
> lots of messages occur in a few second.
>
> diff --cc mm/memory.c
> index ff338c2abe92,ff338c2abe92..6552b3b14f78
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@@ -4768,6 -4768,6 +4768,8 @@@ vm_fault_t do_swap_page(struct vm_faul
>                 if (softleaf_is_migration(entry)) {
>                         migration_entry_wait(vma->vm_mm, vmf->pmd,
>                                              vmf->address);
> +                       if (!strcmp(current->comm, "repro"))
> +                               pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D hit =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
>                 } else if (softleaf_is_device_exclusive(entry)) {
>                         vmf->page =3D softleaf_to_page(entry);
>                         ret =3D remove_device_exclusive_entry(vmf);

I have a kprobe on migration_entry_wait set and logged into a ftrace buffer
(including kernel stacktrace).
Yes, this function is hit, but only inside the mmap-syscall, which is okay,
memory allocation is not realtime-safe.

           repro-2090    [002] d....   811.129549: frt_migration_entry_wait=
: (migration_entry_wait+0x0/0x100)
           repro-2090    [002] d....   811.129553: <stack trace>
 =3D> migration_entry_wait
 =3D> __handle_mm_fault
 =3D> handle_mm_fault
 =3D> __get_user_pages
 =3D> populate_vma_page_range
 =3D> __mm_populate
 =3D> vm_mmap_pgoff
 =3D> ksys_mmap_pgoff
 =3D> __arm64_sys_mmap
 =3D> el0_svc_common.constprop.0
 =3D> do_el0_svc
 =3D> el0_svc
 =3D> el0t_64_sync_handler
 =3D> el0t_64_sync

The original race was an instruction abort interrupt out of nothing due
to the migration PTE set by kcompactd.
And these kind of races I see quite often on non mlockall()-processes,
but can't reproduce on memory locked processes.

Example:
          podman-832     [000] d....   812.447820: frt_migration_entry_wait=
: (migration_entry_wait+0x0/0x100)
          podman-832     [000] d....   812.447823: <stack trace>
 =3D> migration_entry_wait
 =3D> __handle_mm_fault
 =3D> handle_mm_fault
 =3D> do_page_fault
 =3D> do_translation_fault
 =3D> do_mem_abort
 =3D> el0_da
 =3D> el0t_64_sync_handler
 =3D> el0t_64_sync

Thanks,
Alexander

--

KUKA Deutschland GmbH   Board of Directors: Michael J=FCrgens (Chairman), J=
ohan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914

This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure or distribution of contents of this e-mail is strictly =
forbidden.

Please consider the environment before printing this e-mail.
