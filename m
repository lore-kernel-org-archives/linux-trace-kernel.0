Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AF343D91;
	Wed,  3 Jun 2026 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494927; cv=fail; b=ar3wMjlj0dc7A5dy4TLhcaMdLQeJ7zIpqRxuYLFMJW8sriMlcjx7orXAWYyjNcS8X0XCzzHqWFQbUW68gqv1Y70lhZw736IVAIAUFzGEMKp7ZwZCy8EraweaVnCma18mtnI2nkX/LbtZVq49n6llcVoMimId02zhQuVt0TYTxAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494927; c=relaxed/simple;
	bh=Mt6FKdA7oaX0EmWf1el2N4/cUGTbGmA0KMP6ZuPByhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cESPc66YP2jwySEEwH6Uj5fFhW65I0i6qjeasmO3E3vSmf3TDKafRI5fkN2jgLIr2I2AJQLdJrG4W0LaUefvw/glcGhYl1kqKW3Ny/+PldBFR2oXlfC+zgcnJpdPB+KEZtbW6XacXk21FQ+qe+5xC+qFt9OgouJsRzj/+50nV9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=42gugWY2; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="42gugWY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LexPDtBMIFjaN48llagl/EqL8Jcnx4tRMYBOxi5+BRFQVcd38vHXJAhTNVJwK9OMRdMZ3Zf05Cwi+jQHlW4gyCSImM1cdnv9Xw64Kx3/PnV5H1tOQ3zaYUzrr9Qxt6t/86hw9hqTPxp5dr/Hl2mMhboYSEFbe+YGS/wx45P3ilck1cR1o+HYyIu/X5dB3OwTGmgTUZDIKVTFnitm+pbwCa2LmgvujcNrsJc6uLrrC5nsm//rl2vtv+3daglKe/ZwtkZo+8WfCY7sifdSOXCEDvUbH2/ANKkZN3HdXjMD61lzf9KYSxN5AOiNPa6I/J3WZvD/2mwRESEmPwGvgsBe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE/McTSOOrB36ftjLqW2xMrfuoTeBjIHK1FVOjhQgvo=;
 b=HNU8iHI9bVysrIEJhlWrpgx9ZV0BPUtyiVQbK7AUq36HmubsB7n5ah/G8s2xDPcpWAWnT5Ozlqyspf+3D3ckHA2TmpfN1fguUWO2fxOV1sFf22dArOoObkcJEVSGgdeb6u1h4Ycpl3jKApTz3V4o6TXx76bWvsjDRUQZLaXIUjnRLfXd/K7q20xSCT0ragi/LCB+LFOiVjJRYodlQyWg9dBllVqw8x4VYLqOJUal9zRfaRTuJAvplVualkwrbTmlmCLTw82vo5zKALA4YmniqbU+Ya54SGN9OFZCRSMuvYfy55P/lGgMz0lpm0/PJDr5hTzheTMaWfBBfukNsiczxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE/McTSOOrB36ftjLqW2xMrfuoTeBjIHK1FVOjhQgvo=;
 b=42gugWY2obuVzaZLzMirH+Avhivm+Y//HcknNF1gnDxxdSUNyN1VIGQgSULpE5+OefQweuCHFZdwY/73VA8PpjgUitet3RbwGaRLJBbqCoQOc9sjzEu8zEkI4HLip5x/g3Hr3b6Y38XP5gskY6dr6S3V9T0BDkp32L8q3mcj5c8=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:55:16 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::4c) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 13:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 13:55:16 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 08:55:14 -0500
Date: Wed, 3 Jun 2026 08:54:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, <aik@amd.com>,
	<andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ira.weiny@intel.com>,
	<jmattson@google.com>, <jthoughton@google.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <shivankg@amd.com>, <steven.price@arm.com>,
	<tabba@google.com>, <willy@infradead.org>, <wyihan@google.com>,
	<yan.y.zhao@intel.com>, <forkloop@google.com>, <pratyush@kernel.org>,
	<aneesh.kumar@kernel.org>, <liam@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, "Vishal
 Annapurve" <vannapurve@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Youngjun Park
	<youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
Message-ID: <p33thsff5tucnebtya6e5h2rwb6c3f3szs7tfm3dtko3ajmlam@osbwd3neuktn>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
 <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
 <CAEvNRgGzOnA34WyOHtkOx5MZDZhOHaXAe+nD75AiJsZ-PsTSFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgGzOnA34WyOHtkOx5MZDZhOHaXAe+nD75AiJsZ-PsTSFQ@mail.gmail.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2450ac83-b963-462f-32a6-08dec177bdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	DBaCMzf+9vkWjRKtMZA4ov4QTb7BhoHEFrx7UZ05foVtL/hgw1VRha1iGr+H7aAHdakmFidBJ93V4hTfPxH2MV5SpnfnustqG0k387tY40M4VOB7RVdC5tpVDhKyodSwFzUZkom5HSTWW/hgJs6x+Zl55UhBCLmqZ6Eqce4p7SwvuxZPsl9k1N0W7Ur2sLz7aVbFTBZSy0L41GVW1B/3K/IrQo3nJqIFOnMaxVQ5TdOUs3UKcX7WtDmIBA/ZZo1XrTtJiKjWuTxAm2NG3/zcynbnRGQkcOVFisp/tOtjLtQJNxCWuLmPix+b376n6p8WTVO8YbcAxa2jmO/avWZ8efuhvXut5+rloti9ImuQtkMiA3nC/6SyppPaSZmwLh1k/mggEbnPChHpirexw5APhHT4Cs/Bx8reMlWwMxobujp5P3lc5mzbZE4hTwPICHDaTttq/Zb6IB/x6n4O5o4tqVbSkkp//Qnnh57QAhLwpm15BAoJowQKchZ192SE5I61mIUpoP/PeRuzG9Y9o+Nb9sVV+v/7TLftrBFcIfxxkCJFEu6/6iEI5VvdUvYoEEYYv3yMnuLU055c7i2u3wh48kzKXzqAFsKngEhxDwqwTaHg/2HNpd30Q1QaHKQYfTtahEYsyI/eDT0PRNsrJ9It8EUW0kWc4j9d8q+b4ItQL48k+ZML6/02e/MOhK512Wkw11xJ5qxAGdXF2urKwzCOpi81CZMOpWb1V8rrZlRhV5c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xAHgQEoY9Mk28nMO1K9H/+gpANYI6S9l3DnxVzdVO2BoRVZad81bXZwr+30PkEnDR++uKUKXKofcywZ2E2Ie0hopL2u1LHLGfxiq5jqOw05wA9vV1Lln5/ArIHtlq8FtkDNUhmHWMr8hGMWZdmsf3c1yrTjbva6VbnPKmi2gCT49b7obcs2lOaLFIaNihvmSsVTWaKiNX4tVEb+CYGzxAalWOqPbBJrcDA2ZAksYVWr8bQO3J14q17c1mN/l/kTpApeTiv6W6/V9eXI+cGlZSrh63E8gRZLmV4/raJeNJOIsCLBOuKTLZny+urJYAEXAdaNtN189JpT2W/MeHQkNtrtPUK8nwh6Dxc6OS0ETCvokorHvwISc47x2/LqBjMTr/LDqBh5XlKyONrjL/9ywn2oHe4m8xnJ3SsAEeLEupTjb5Cn4zwRuIH0IwxuT/4qr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:55:16.2050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2450ac83-b963-462f-32a6-08dec177bdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On Tue, Jun 02, 2026 at 01:46:09PM -0700, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
> > On 23/05/2026 01:17, Ackerley Tng via B4 Relay wrote:
> >> From: Ackerley Tng <ackerleytng@google.com>
> >>
> >> All-shared guest_memfd used to be only supported for non-CoCo VMs where
> >> preparation doesn't apply. INIT_SHARED is about to be supported for
> >> non-CoCo VMs in a later patch in this series.
> >
> > nit: s/non-CoCo/CoCo ?
> >
> 
> Yes, thanks!
> 
> >>
> >> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> >> guest_memfd in a later patch in this series.
> >>
> >> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> >> shared folio for a CoCo VM where preparation applies.
> >>
> >> Add a check to make sure that preparation is only performed for private
> >> folios.
> >>
> >> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> >> conversion to shared.
> >>
> >> Signed-off-by: Michael Roth <michael.roth@amd.com>
> >
> > nit: Missing Co-Developed-by: ?
> >
> 
> IIRC this should have been
> 
> Suggested-by: Michael Roth <michael.roth@amd.com>
> 
> IIRC Michael suggested this on one of the guest_memfd calls, Michael
> please let me know if you remember otherwise!

That rings a bell. Feel free to add, or just drop the stray SoB, either
way.

-Mike

> 
> >>
> >> [...snip...]
> >>
