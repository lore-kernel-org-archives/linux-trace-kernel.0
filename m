Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226003672B1;
	Mon,  1 Jun 2026 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355679; cv=fail; b=id2t/cISsIxi/74VvEwMf7d+SL6nM6bsiOqRQA8f6PiMEwLqPcHs7Qw4HlG6ReLjxql6SeMjIjkaV9DAkjLI/qp3TwKM5OFPLindlPh03bhn3oLxWymyzgK+e1IOWd8QDbhMdMBsGO4c4/sxNqQ3268EuCpY6N9iASO1yekbU/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355679; c=relaxed/simple;
	bh=XxevPaap/qVmpBvGBZ7tEqGBws6ciKg+fYWvHk8jEFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHXChr7ar0xftzIT5weNNY0oSrepWczZrRa8pfWvSspTluuSOzFWcAvg9Dl5ucrG9WImN+oAk2x/VznyPzK+tmsYus1EMMC/Dg24Mq+Igjo427ADypP5p/5eGdvEZYGR2ljedJKkH+VIKNrze+RdXAs72vRUo46xtkOfjdDs4NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kczWyw0O; arc=fail smtp.client-ip=52.101.57.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kczWyw0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1ws3C4d8FtjeSqHou/rs2ywL6PiLHcf8CbVODwMwUCVhvA2EAOQKvVBbRh4DOjrHEsDCERlxazEEpP9zDSzaAMnYIJpBsGMrTkqw3QPIHxD3Fye+DUmyymgwDgfOAv9azTakKz6tOXNvRFsOu5pDFulhbSy+zaO0y89n/ETFniJI+W0BuxbZkM9OxB1B2OFYKPUpqq+hNAGbh5JK41eMrQwj2tepmQFGxHnKT1vVLRlU3BaSwcjJ1sb9zkcAen6cbQ54p1vbZ+85Cn/P1QHRXfKbJyS9lXzmqm6STBC743s0O27vj+WMICkYK6DHi1Wrf4N4tV07GsxD1FvyTpgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnJeCLflkAoPvPkWfy5OufvEuMhfaeU8rj4zr8bm4Nc=;
 b=NNiAdUcCm0lP29dKq2l4vbL5FKuam+9T4RWyO1C0S4HFB7GTGfp+n+h6J+KgdPgzLQ8+L6J7ZCw0smoUJCzlv0MufkOAgpH46vcsas5dvbY1Aioj1Hb8kD6nNaLkFU7QnrWD7HZQqOlot1pBIQv7L7um4uHlP7wuc09XrCH7vPEvnikF9oHyPF3FV52BoXf6OQ11o/XgzxGL69z7V42EflZPJCyUbPB/vR+J8dxa2d/sB9KQETOsDsmQMVszqmiUvF+OIqBFc0Um7cQYUH/w86ZEYMJFxrG13P+iTbKZ9weWOR5yhluqxJlOlTgsWF8gketFLidNhdnTDJxkJ2qi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnJeCLflkAoPvPkWfy5OufvEuMhfaeU8rj4zr8bm4Nc=;
 b=kczWyw0OQivz43PsgWrXZjvove99pIfDWZ+38bFIzLfZIXISld/po8KzcRazIjDR2E47vRrF/ZChrgZK7+SnNH+zf62NN73ZqUdeKaR683CSeZslTdt0nZFK8p4RAx87zdn/0H2bqUzEvxWqBMWoOwEy3tCV3VZd8Hs+P7WuaMU=
Received: from SA0PR11CA0146.namprd11.prod.outlook.com (2603:10b6:806:131::31)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 23:14:29 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::2e) by SA0PR11CA0146.outlook.office365.com
 (2603:10b6:806:131::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 23:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 23:14:29 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 18:14:28 -0500
Date: Mon, 1 Jun 2026 18:14:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: <ackerleytng@google.com>
CC: <aik@amd.com>, <andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ira.weiny@intel.com>, <jmattson@google.com>, <jthoughton@google.com>,
	<oupton@kernel.org>, <pankaj.gupta@amd.com>, <qperret@google.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <shivankg@amd.com>,
	<steven.price@arm.com>, <tabba@google.com>, <willy@infradead.org>,
	<wyihan@google.com>, <yan.y.zhao@intel.com>, <forkloop@google.com>,
	<pratyush@kernel.org>, <suzuki.poulose@arm.com>, <aneesh.kumar@kernel.org>,
	<liam@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Youngjun Park
	<youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v7 09/42] KVM: guest_memfd: Add base support for
 KVM_SET_MEMORY_ATTRIBUTES2
Message-ID: <vvk2ehd6perpmq6dotkj7tqpev77jtn7asiaclskj6ub3tfb7k@pdg2p4v2z2pr>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-9-2f0fae496530@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522-gmem-inplace-conversion-v7-9-2f0fae496530@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 893ae207-3246-4aa0-1c46-08dec0338813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FJOpFPKapBBU0ZDj3axAyxEz+mdSIyclSiSzmuZ8RigKcbDk5Jv6A/Us8D9vUh5VzQhPSOcHFjjzLerZp4185D+Wf6O88cUdmt4hxSDERqgwA8EMuR32vqmun8imNYloteU7MYvUwvcmRPTylFJFg5vWUyT+BgNruV8XjDNIK/XGB/eOJwzDMUJpQNcLJNX134OwhRLP3/82Qj1Vry8UgIlZVHs9XGYZ1NkEeUohOPrcui+bTaC0lY1ZviQ/W60wCkwpwtDe3a93x0jzcov2oaC18QlDQHos47q7IXaLLGG/VttcGF0zQnIer3WPYzhC33kBAOCT5jxCL/+3luX5uHvCvvd0GFLr0Ebe4R1tv7RWPqS7ozx/b62cCH2lYXZXRWgv/c0I+SP/NcIfVbnXvAmBCVQ2kd3O/aBM1wk29Cz/W/xmd+ydjEdX/b1Gv93Tz0l9oW8yXJNK6Vvx4d9Ggf8p5cSapFc2uD+SoXLJ1LGbfkfJl+XJUVunS4MZAB4x0EoarWE9zyceZEocLal6S7vqX1jN478nk5BqYd7rjXrIjlxiFipGaeoE4Y5FOuYiBkISx9S5m/YMoHCdzogZFhHtuq7HXVFuNHQBQGYKOvlqe/xQBHasD9NtG7DTkuVbwO5g4Cru9NVrVrgSrFgWp/z4pkYmTLyeh3JArJJ287M/WJw5Q3xsZahe7FR9apR4H2PQ06iDnADbNdE2ILb1eMuZtBqT4uJp9er4aqcbBTg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vRidApn08tACHk08VabFLrUapZ+QIjdciCJmhzozVEEtvO5gw5AYEA0Jzwjg7iv1rLf2/U/na4x8QompFY3KarSkyf3Z+9p+FTRPvrl9WUFWLzZZ0MkiLOxo4i9FUl4vgoeC9ECHSSvJAjGbRQhkKw1KFbCcOssRbr+nqDx3ywd169oYnjmJoAv33HhAnaiK7S3NKsazH4iNtxCK6ySZff4f4sJxcwXZ/R3OFPKGuHTIjxfJe0vBau4WXuqiBgAQO7likw6XaSCDVq8zZQ211J/vcnHYH5SCGX7tPHt29pWAhj+msJfsL+z0Bs5sz4CnK6BAkgwRD9eNTBx44fODNMACXJpdTEna+NoM6C4uzearzrO4+vqR5ojg5Npi+w42zSY4yb+WXZystKQjaoI4AYO4KtxONp12Uj7hC3NR6KQCMsXs2c0883gf9SFrGDWo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 23:14:29.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893ae207-3246-4aa0-1c46-08dec0338813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892

On Fri, May 22, 2026 at 05:17:51PM -0700, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
> just updates attributes tracked by guest_memfd.
> 
> Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
> by making sure requested attributes are supported for this instance of kvm.
> 
> A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
> KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
> details to userspace. This will be used in a later patch.
> 
> The two ioctls use their corresponding structs with no overlap, but
> backward compatibility is baked in for future support of
> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
> ioctl.
> 
> The process of setting memory attributes is set up such that the later half
> will not fail due to allocation. Any necessary checks are performed before
> the point of no return.
> 
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christoperson <seanjc@google.com>
> Signed-off-by: Sean Christoperson <seanjc@google.com>

Typo on the "person".

(Sent this earlier but looks like some of my emails never hit the
list so re-sending. Apologies if this is a dupe).

Thanks,

Mike

> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
