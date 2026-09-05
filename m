Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DD19CC14;
	Sat,  5 Sep 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649541; cv=fail; b=sqVwEhQ6GXh8Y3/M17+i0IsMIqXAJz3AB+b9pmLw+gVVMSPIl/psoiAIiOncb8h2fRmpslhi99xAyp7/P0wWCkioOCphk1CqbQRdQLRdIiKcjbbE+t4XfP5KX43w78t1QqHnI6R0hun7ww1C82AXlcFo8j8AFAl3XsVLWedKUvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649541; c=relaxed/simple;
	bh=X0T8nZdG2exmpKaSu8mBBXP+zRbxoXt8iVYHR1Ny1L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDLleYML7oFZT1aHJBMEhoNX8twByb78NNQlzJslRCgBFCQ4Zy3Zp6zypJtTRXfndarQWaQFl3jD0d2kiTLVxKK3WDQvrCxcVef0oqjSEty8Ai29viEkGiQ/U3yzJwq6elZ2sdIrhXss/CwWkkWNyoAmvOr0ah7iKjCtcB67yHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMZlp06RM0M7GI4WgP1hRG8qHS/WtiKteWWxt5vr7OdOkfR0Mz3JZxbtvqc+o1fiZtjw3dmNOX8iZORJ9D63LJe6ulCw3X9pt++tUCCl/oYDoNYyf1CncWZG7+oq7weu1tSV41fyPtWdKl22oHA2lw3tZQKdTEeKaf9iZmPQDvnOYp1D6jA7q02/x4lYzHuny/9KXk4iku/dfNE/PEnzdSqiweKWQCK5d53mGPlPHpVP31cSdp+qNLyMgGTIFy0MFgfbPoTCOkt8pnJgHTRJx7415er9y5Xzg7dDtfJ6vm/3b6ROckf9pUDx99YshDja0OWlxGhWIKhisoILu+zjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2hVFSsbIc+02wT2FfoREKpJPStfxNIiuhwhUx6pSqK4=;
 b=mnW4R2aAua3Yl5TH2/jRrKOalD/PZnbgDAMEzEnUlAd+76E3c/hBssgsT0H75FrVMS2wUrfszzsI4til9i//qvLphJxIe9KQvGz5qQVdI4bwh6R38ah0kuFBY2DnvIMyQDjPf5Ong7KPF4eONjNzgiXDxxIQkjZMLbxohkKtHd3LUgvCeVBSq9mbE7OFhQqiK3cMITAZlck6jShieyZPZDDZOfKuifXXk8sQ6QFCQp9BpmuUPA55nxi73nJCIZgjLKYoxWa2NOVXjMpIN4ryPuIlbz+2wmFZ8KQYXVkBtfetekWQa01uY1g/nct/m6csD4SrteNqo+KOloRyHTYLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4224.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:165::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sat, 5 Sep
 2026 23:05:35 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:05:34 +0000
Date: Sat, 5 Sep 2026 19:05:30 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	osandov@osandov.com, neelx@suse.com, sean@ashe.io, marco.crivellari@suse.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, leitao@debian.org
Subject: Re: [PATCH v2 0/3] Add telemetry tracepoints for CPU hogs, distress,
 and BH budget yields
Message-ID: <gptpa36wo37exevwwjriw5flw5f7uqs6o56hl4aknygyqg5jp4@zfvahiz5t6gr>
References: <20260904193447.247502-1-atomlin@atomlin.com>
 <d742c094937b76304fe055d06d7c8cab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d742c094937b76304fe055d06d7c8cab@kernel.org>
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: f52265d6-73f6-4dc8-8fca-08df0ba230f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	5rMYaUrJmlOClkNd8Bg/ORX/pQwwf5Je4XatKIDZSNJxoVC8L/ipdqWUx15Vi7oGhheyefaI7VvpHw+AcF6iKE363IMqaYS0pBgFnz2xgGkXckes3wolGqKQeG/vA3RlsOVK5Sfu0/AMn3RWUSHo2oHgGvj+OpX1BCCBRqd7mCD8GscQGYJlvm3Cxc0sO4zo3vnA/RuWxWAuKwmqZpEzPzzhWZ46vX1jYybasmiji95+9VwBli9V8hffFt7Sq2mpcTnQk6kX4UX+jOxVT/FDCA1rTUVjHZsg1JG1OOFEMSYYoMo9tXvlD7vn/XlPZpq4TzMaeOuFiOEdSm9vIem7uhXAHEstSMRlxngMZyJPkNhf01bswTN1sx2MtSvf5NilfEtYRLcYyCnSvlAwJzkyPRq+qRzpnAJabHlzxae5rd1IU0uzL66JZR3yq1RAQXAPxtl2iugY9lP22HZ8fWZN871I343rXUfWngImWyCzMZkbCZTrK6CDVDvdt3hP4uAeoPZtccbEhGdQBf+Q5uyW7Ar/cwA0Zai7m3NmDbF8gnNtv5Oav+oCgDJTzhm0SMEphMb48cepgTUnBE2837ZOX7oX5SiGFq/y0M8l+0u82m/yZtA50N5wmrMjZbdbfCK8ON6HMFwGH2AEd4zv5WuURIXcbsGYIwEzGvJ/WqqeqjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlHSnV3VTRwTG5lWjhYUHhkVGI5MDQ1L0tBNVU3TGtKNkJpYWJiWEQyaVZK?=
 =?utf-8?B?NWdlZzg5cDBnWEkxNGlkUEZsVWVhNEtncVJrbFMrQVUzRFpISFRtSWZuT0w5?=
 =?utf-8?B?YlJQM1YwWW9aZkRhYlhNQkNnTmJwSk1GSTE5WGhtdlEya2JXZitkalJaajdE?=
 =?utf-8?B?MnI0YmtNSFI2NjUyKzU1NDRCVWVQbFdNVTViVklYN05nQzVTSjZxL3dBZkJE?=
 =?utf-8?B?UnlJVGIxSVRCRjZYUWhXdkhuTzRNQ1FBdDBhVUdvS1RjNU5TUWNIQVZoWUNJ?=
 =?utf-8?B?NlpRQlFyYTlJT1NCdU5MQTlrZC8ybzFSRzUyamJmM2l4VDUrVkxJa3VZTW1B?=
 =?utf-8?B?ZDRURGMvQldoWDM3dXMwT0wzYVdoc1FBMThMK0lzbmdKR25MSXZnRWdoWmwz?=
 =?utf-8?B?WkFRRFFSV3BlRVF5K045RTlzUW1OcGp3UzBYS3J6OVRpcEkwSmZjb0VGNzZG?=
 =?utf-8?B?YkJLVVJ1S3NSaVZCQkJoWGNQUUtvU1l4clVGbVQyNlJLdXdNektQNU10VEVv?=
 =?utf-8?B?clhMUW1TQk8rakpUSHRyWlNpVzFGSmhpRDYwcW5oRnhrM2JHSFh6dzM0ZkRn?=
 =?utf-8?B?THJVVkFjUEhQWVNSNW1ZYW9GRkx0Q1FBS1dlNGIvcnltUGJhVi9IRTBFNHUr?=
 =?utf-8?B?Wk0vK1NOcnBQamh6UHY5cW1CZDROK1RUWW1rUVJuQjZKVHE3V0ptZFZhMEE5?=
 =?utf-8?B?d045c2VhZWpHcXNCMHlQYmZ2dlNFNmxXNUUxTUg4UytNcGc5cWQvMSsybmVU?=
 =?utf-8?B?cTBVYUZNbExsRjFoQ3hzZ2V0dTdDVDR2YTRzS1UrRlJ1c004bTM1SDhYVk15?=
 =?utf-8?B?QmpGNVRJZXp6VGFmT0loZ1JiVUxtenlXYklGMWdzWTFLS0sxZGlkamEyU014?=
 =?utf-8?B?SlkrY0ZvK1BvYVcxbmFxeTRPTTRNeWc5WFhYOWFTSEpxVmpIeVBBdzFYRjFC?=
 =?utf-8?B?ZXl6SnVWOXhBVzE3MkJxWVNHZ0dRNW93Z3k0dDhDSEdkUFh6WWxFQzVZcTFK?=
 =?utf-8?B?Z3prN0ZSRWxyYUx5RVlXQk9wWENaOE9iaWlTSTJPK1czUEZibGRsV2xHWWJW?=
 =?utf-8?B?R1pOSlZBam0ySFQ4cThnNVpRZlJhNzFTUW5NUUJYWHI5L0dPT1dWZHZUQW85?=
 =?utf-8?B?Z1piWERYUHc5MFF4aWxHcmd6S2luNnIrdWNGK2o1VDFHRU1RT01leWtPaGpt?=
 =?utf-8?B?TXJDcXR0R1lzUEx2c2xxamxTZUhMdG9jc05UQWgvQXJtQ1NnaG9UN2c2elZH?=
 =?utf-8?B?OHZsTTB6elNwMzZ1YUV2dDhOdWRIbjR2R1RCT1Q4NGZ4amNQNkdOcm1QTnJJ?=
 =?utf-8?B?c3ZTYWV2VWEzaDAra0s3QytGU0VCMkxMOEl6dXFpb0tMTWpOVEtzZVUvcW13?=
 =?utf-8?B?NWRTTklNZkE0cVJQMG1oQjZvZG45c1diYUl2OUR6cXkrMEUwZUpqVVlNWDBP?=
 =?utf-8?B?YXloTy9oWVZudWxIVjdJa1lmQ2kyVVZkNkRTcElTYWNSZ2VSODJ4dWZtVkNZ?=
 =?utf-8?B?M0RnY0tGM2xjVGdFeVY3VnBVR05qSVNiTkhMaGtaU2VGQUlpQUNuSVNTVTVG?=
 =?utf-8?B?NTlIckZ2WWszN3dQa1RtR3U3RndTL2dHaW93U1BZbjF3ZEpYU2NsR3pReVpt?=
 =?utf-8?B?UkNiM2RtaTd2SGVLVUY3VkJkOTFCZ1NybzRCVlpWa2RCeEJtM2hwRk1MV2hK?=
 =?utf-8?B?Z2pGVWxJbXA3b2RZQkxhZ3d0N0ZydGxKN2FzVjMvNkhkV2JqRkxwTkRMZWNN?=
 =?utf-8?B?a0JGVDRXMHlXYiticENtOENabS9iTkw0VHFkTHF1WHQ0RjFvSUtNdFlyR3Zw?=
 =?utf-8?B?eTRhSk8yQ1F3VlRsblh5eXlwZ1V3TDNETHljOGJjME1ZR2lEWEN2NVo2K0dI?=
 =?utf-8?B?c3RxVHQxeW9tRXdnUjhkSHVvWGtvQzYxRUFuYWNFb3J6OEVqSDFFRTkvMDJj?=
 =?utf-8?B?TjNTWVdmTm5GVnJmSzVPK2pPQUU3bzFTTG1JRlRsRDdVcVBTRnA0WG1zeXox?=
 =?utf-8?B?M0JSNWRIR0hCZ0JreHAxYW5wdk5KOXdVcFZvK09SWlBKdjcvZ3czVGZUbWNh?=
 =?utf-8?B?WWxld1Nxd2ZJWVFFdXUvVCtqN1A5WjJUM2NDVzZGbW4wTnN3TElIMzZqajgx?=
 =?utf-8?B?MVNKNERZa01Fc0NwVUhKRnNDRnNJTUd3RmVhVHlRek9WaEJrSWg0NlUzM1pF?=
 =?utf-8?B?dnhHWjFlWGlUd2xFMXFCNmUrWDRlRU05bGpwMzlVa3pueW1WMVVGa2ZibGs2?=
 =?utf-8?B?YTBHTlFuRnZxZDFEUFNyazAyMlBESDhQNnhLUkdxVmlaa3k4TEV5b0I3clY3?=
 =?utf-8?B?V0NMS3phMU92TkswVlJFZ2I5YmI0YjNEakY5dXBQOFNuUVBpMkttZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52265d6-73f6-4dc8-8fca-08df0ba230f1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:05:34.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wid7o/nKIrbdmaN2/nIGfI9s12J/EzIPTOkBYNw+8ke+KnMA0u23T0xXl0i4C48uI4ZkP3v6pM6YNHb7AREHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4224

On Fri, Sep 04, 2026 at 10:22:45AM -1000, Tejun Heo wrote:
> Hello, Aaron.
> 
> > Aaron Tomlin (3):
> >   workqueue: Add workqueue_cpu_intensive tracepoint
> >   workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
> >   workqueue: Add workqueue_bh_budget_yield tracepoint
> 
> Applied 1-3 to wq/for-7.4 with the mayday interval references removed and
> "executing CPU" changed to "pool CPU" in the BH tracepoint description.
> The comment adjustment is below.
> 
> Thanks.
> 
> -- 
> tejun

Thank you Tejun.

-- 
Aaron Tomlin
