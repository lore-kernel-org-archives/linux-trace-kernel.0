Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCC37C0EB;
	Fri, 19 Jun 2026 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872127; cv=fail; b=XWNkq5Jqc6+GMopqY6UqKb/7EUdob2YZ0DnR+CVUDM2gH3c9KMX3NyCIFmUp/WeFboRngjqfknZ20ttkML+00retrO/NlY8UCI0yRfjBpmJV/4PPZzOZHCn7Q9XnrhyDv0iLfiSCkRY+r2J4Xoeptut5xgbkpsFLbTfqDlDI0DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872127; c=relaxed/simple;
	bh=nJ9SXX/XqEA6odIdnx8Pez0EeASgbcxp5gk0fRLbvcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D2D8A1zsyFNjyuNUZeAJCTfhT+7NF3dd6lyHH+tinRCOtNySBg5eN99A+ID3wJam/eMpE8hcc6HmfOPO25FbL7g1u6lEzzKaZnRQTvuWB3dpc0abfFrLe3xYWakO3Tb7ItM0yc7f4USsz4ZON1odAw3iMgrr3XOGrlleB6ROFSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rBGmarN/; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rBGmarN/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD9iWBPdKxb+1fAZ+ybj8FnSVW46NXf/LGgYnDzOBg5f4AUyjOBD5/QFAFE7fGnTO7MJHu++B9vvpTogWWRdf/CI31URBBCLGg45Zh0AbftEFCqDYMdQdQojcwEdACfzWYVT86RWEjMKGtfCnOOa5D/2DdAuQ9APJAnJ1h+4v820QGsn3MM1uCd2HLWjpK1dLHXa6YTGrQqNKMGsAvYrTcOyzSubmAMY2A0Oo9jQRrUqYVmYAptagfn+QWTiHeWM56pZ4ZvIm3TYiIpPE5iBgOVdEzBPQ0nwimdIHRVxkAB+8kooV5OO5wrQaoLRSA1gQ9Tc8Oe7lV++jyIkQtzc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf4FqwlcijwPGq7fC2/hHTWvNyP18M4EUm8vq3o4lzI=;
 b=mIHJ6RRIZbLSR6TiE4N78aX7HnfDiwkGWuTJCikOSop+tpvkGq/XZC/sPvAinUhpnG5apDYtpYa3vdZThKNwBSfHMX4s1pxUmF5KoTPWB2vdbQSAHz+hb6eeOTtEIggaGUZTnDch13mLh2yuFTaWxUzDK7mcDtCkGLLxOZXzwIpdu0GLfwGS/6HsBhLoxIX96bH/SeiQyXLG8dM72GlE371OjZQoJxrtdBJf55Qgg+VyqpUkq/9F+RpS5yd72XTveICsOVYHNU7iosW4vMihaeJVoFg8MRuHt+GRiHs1tAP99xVpneMbUd7nCEdULWlCW8+HSHCyut/pKt9aIg4BIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf4FqwlcijwPGq7fC2/hHTWvNyP18M4EUm8vq3o4lzI=;
 b=rBGmarN/ENMU7QFN8jCF80eMlgww+4yxbR+YhkOlhgymFAkPMRIdgdC4Qm06ppY1Hdghnhgi3BYIukT9e6re7YXAR4W6qN4r2zikbEfbRs4qb4avchQZ2pUsMIjbaoyom/2omx2ks9Ra7I0mwcguh1Hnr1PLiViOCBEg89BQvSE=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 12:28:37 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::10) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 12:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 12:28:36 +0000
Received: from [10.128.112.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 07:28:22 -0500
Message-ID: <a6373206-60b6-454c-9aa9-9d52f9d84de3@amd.com>
Date: Fri, 19 Jun 2026 17:58:19 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
To: <ackerleytng@google.com>, <aik@amd.com>, <andrew.jones@linux.dev>,
	<binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <jmattson@google.com>,
	<jthoughton@google.com>, <michael.roth@amd.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <steven.price@arm.com>, <tabba@google.com>,
	<willy@infradead.org>, <wyihan@google.com>, <yan.y.zhao@intel.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <suzuki.poulose@arm.com>,
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
	<nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau
	<kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-coco@lists.linux.dev>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2866c2-1d07-4e9a-730d-08decdfe493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|13003099007|22082099003|18002099003|921020|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jOWGJb30pE2KbyriwilkFoCGJllUemD+QC4E91CEbqnn0sHvbseiyTTafmMEVcK5Hpvp3JO9YoL+o9aOcT3W7meeTu6udm/gLzLh7PvP1vRtMTceK8GNgK9paPCHnkZcWTOPTK0PM8xQSfeRY1mc0CdbyZJIb8sv8osO64HpGoQvthjUKy2Cn2eSa4NiJjK4Vtn9maum1sVu6YMQi3FaiQfF8JTIcN0f7J+RFlhsMtBD+j2t0bsmMWwWCPXxqgzlf8I2XLPqYg0ODoyWvlo9NhKAuXZMNi25bRX+/1zxjTuZIKS4D31RF27mCAfhM5n5QaXkeDVBOtperdRLWipQ1igGTg0n5EEHRW1cIvseCNoPYdHU9ODQTdRftu0Cp6L+6HmqwtA7Gg0952Szp8i9X8x2JffMlU+IJjIltu/sjlqUVmUDKfX5gK34Zs+UotN8xTkE6TSUdGiHubrdyrAeV1Ds4sosuGS4ApxHrNJ5yuOhr7IqNHqbRsaiVcZDh7duYTmD3avMvlUtzM538eoJHdlIPYHqY/pfW8Gyu0PHs7e+PgWyfYoGimybB38LiDzgQDJoDVLito4XxUmtCZ8NIGHGHykugpis9ep1hYtUDc8voXd8D+5ol68g6cQpI0pc0xu+4aXIU/siDcQuOzcWT15KeuAkByuy/qNfzHQBJlqyuO8pQ2CMLsW3OAuQZMDIS9KwGyCFMVYyjgfV9BiM3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(13003099007)(22082099003)(18002099003)(921020)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jTAbi/Np9VYwZiygxUapcrPx7ngDG5oan0qBlEZsSedn0LOPo8Hz/fKDXCTlue6froZU3hHN/1m1yqDoLFs4Zm9RfPtaFYyj/zPkY6VTMkvOJFi5D/7pearTmzRKBCOgggj/nmkfGrcja79L13JLpyZaPduQM4XNBJz3muDP7AVOEZHUqN65q4dDCrhtCAuP1Qtua//x4gNqZcd4xQZCPPYB/coPEQQnCpUeUILuo+4olNDUCA245vCsfsj2jQKv3ufu1SC2triolR4BHzm/wM4e0nDs6yiIqguvXdoSPMfELmTwXG1NnPHfEHA5wN8ss3vAFSALlw79DZ8V6RBZcxRFK1aWyelrZSvJMMEuZHD66SkdHRA6AKN8VCYXfjCdVUhyy3GWxFOYUi2xhznywArYo9iQtaPAw+Tco9g2a2hCDv0MIGPRZBhVgJJwEcT0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 12:28:36.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2866c2-1d07-4e9a-730d-08decdfe493b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442



On 6/19/2026 6:01 AM, Ackerley Tng via B4 Relay wrote:
> This is v8 of guest_memfd in-place conversion support.
> 
> Up till now, guest_memfd supports the entire inode worth of memory being
> used as all-shared, or all-private. CoCo VMs may request guest memory to be
> converted between private and shared states, and the only way to support
> that currently would be to have the userspace VMM provide two sources of
> backing memory from completely different areas of physical memory.
> 
> pKVM has a use case for in-place sharing: the guest and host may be
> cooperating on given data, and pKVM doesn't protect data through
> encryption, so copying that given data between different areas of physical
> memory as part of conversions would be unnecessary work.
> 
> This series also serves as a foundation for guest_memfd huge page
> support. Now, guest_memfd only supports PAGE_SIZE pages, so if two sources
> of backing memory are used, the userspace VMM could maintain a steady total
> memory utilized by punching out the pages that are not used. When huge
> pages are available in guest_memfd, even if the backing memory source
> supports hole punching within a huge page, punching out pages to maintain
> the total memory utilized by a VM would be introducing lots of
> fragmentation.
> 
> In-place conversion avoids fragmentation by allowing the same physical
> memory to be used for both shared and private memory, with guest_memfd
> tracks the shared/private status of all the pages at a per-page
> granularity.
> 
> The central principle, which guest_memfd continues to uphold, is that any
> guest-private page will not be mappable to host userspace. All pages will
> be mmap()-able in host userspace, but accesses to guest-private pages (as
> tracked by guest_memfd) will result in a SIGBUS.
> 
> This series introduces a guest_memfd ioctl (not kvm, vm or vcpu, but
> guest_memfd ioctl) that allows userspace to set memory
> attributes (shared/private) directly through the guest_memfd. This is the
> appropriate interface because shared/private-ness is a property of memory
> and hence the request should be sent directly to the memory provider -
> guest_memfd.
> 
> Tested with both CONFIG_KVM_VM_MEMORY_ATTRIBUTES enabled and disabled:
> 
> + tools/testing/selftests/kvm/guest_memfd_test.c
> + tools/testing/selftests/kvm/pre_fault_memory_test.c
> + tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> + tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> + tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
> 
> Updates for this revision:
> 
> + Updated the series to _not_ deprecate all of VM memory attributes, but
>   only deprecate tracking of the PRIVATE attributes in VM memory
>   attributes. This takes into account upcoming RWX attributes support,
>   which will be tracked at the VM level.
> + Reshuffled the earlier commits that deal with preparing KVM to stop
>   seeing VM memory attributes as the only source of attributes.
> + Addressed comments from v7
> 
> TODOs
> 
> + Retest with TDX selftests. v7 was tested with TDX [12], but the setup there was
>   wrong. Conversions were successful (no errors), but the shared memory being
>   tested is actually in a completely different host physical page.
> + Retest with SNP selftests. v6 was tested with SNP, I ported that to v7
>   and those ran fine too. Just need to double-check for v8.
> 
> This series is based on kvm-x86/next, and here's the tree for your convenience:
> 
> https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v8
> 
> Older series:
> 
> + RFCv7 is at [11]
> + RFCv6 is at [10]
> + RFCv5 is at [8]
> + RFCv4 is at [7]
> + RFCv3 is at [6]
> + RFCv2 is at [5]
> + RFCv1 is at [4]
> + Previous versions of this feature, part of other series, are available at
>   [1][2][3].
> 
> [1] https://lore.kernel.org/all/bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com/
> [2] https://lore.kernel.org/all/20250117163001.2326672-6-tabba@google.com/
> [3] https://lore.kernel.org/all/b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com/
> [4] https://lore.kernel.org/all/cover.1760731772.git.ackerleytng@google.com/T/
> [5] https://lore.kernel.org/all/cover.1770071243.git.ackerleytng@google.com/T/
> [6] https://lore.kernel.org/r/20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com/T/
> [7] https://lore.kernel.org/all/20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com/T/
> [8] https://lore.kernel.org/r/20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com
> [9] https://lore.kernel.org/all/20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com/T/
> [10] https://lore.kernel.org/r/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com
> [11] https://lore.kernel.org/r/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com
> [12] https://lore.kernel.org/all/20260605134153.204152-1-ackerleytng@google.com/
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
> Ackerley Tng (27):
>       KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
>       KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem is defined
>       KVM: guest_memfd: Introduce function to check GFN private/shared status
>       KVM: guest_memfd: Only prepare folios for private pages
>       KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
>       KVM: guest_memfd: Ensure pages are not in use before conversion
>       KVM: guest_memfd: Call arch invalidate hooks on conversion
>       KVM: guest_memfd: Return early if range already has requested attributes
>       KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2 ioctl
>       KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion safety check
>       KVM: guest_memfd: Use actual size for invalidation in kvm_gmem_release()
>       KVM: guest_memfd: Determine invalidation filter from memory attributes
>       KVM: guest_memfd: Zero page while getting pfn
>       KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
>       KVM: guest_memfd: Make in-place conversion the default
>       KVM: selftests: Test basic single-page conversion flow
>       KVM: selftests: Test conversion flow when INIT_SHARED
>       KVM: selftests: Test conversion precision in guest_memfd
>       KVM: selftests: Test conversion before allocation
>       KVM: selftests: Convert with allocated folios in different layouts
>       KVM: selftests: Test that truncation does not change shared/private status
>       KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST
>       KVM: selftests: Test conversion with elevated page refcount
>       KVM: selftests: Reset shared memory after hole-punching
>       KVM: selftests: Provide function to look up guest_memfd details from gpa
>       KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
>       KVM: selftests: Update private_mem_conversions_test to mmap() guest_memfd
> 
> Michael Roth (1):
>       KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
> 
> Sean Christopherson (18):
>       KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings
>       KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
>       KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
>       KVM: Decouple kvm_has_arch_private_mem from CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>       KVM: Rename memory attribute APIs to prepare for in-place gmem conversion
>       KVM: Provide generic interface for checking memory private/shared status
>       KVM: guest_memfd: Wire up core private/shared attribute interfaces
>       KVM: Consolidate private memory and guest_memfd ifdeffery in kvm_host.h
>       KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
>       KVM: selftests: Create gmem fd before "regular" fd when adding memslot
>       KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
>       KVM: selftests: Add support for mmap() on guest_memfd in core library
>       KVM: selftests: Add selftests global for guest memory attributes capability
>       KVM: selftests: Add helpers for calling ioctls on guest_memfd
>       KVM: selftests: Test that shared/private status is consistent across processes
>       KVM: selftests: Provide common function to set memory attributes
>       KVM: selftests: Check fd/flags provided to mmap() when setting up memslot
>       KVM: selftests: Update private memory exits test to work with per-gmem attributes
> 

Hi,

Thanks for this series.
This works well for me on AMD EPYC 7713 (SEV-SNP enabled). I tested:
1. KVM selftests: all tests pass.
2. Using in-place conversion QEMU branch [1]:
qemu-system-x86_64 \
  -machine q35,confidential-guest-support=sev0 \
  -enable-kvm -cpu EPYC-v4 -smp 8,maxcpus=8 -m 120G -no-reboot \
  -object memory-backend-guest-memfd,id=ram0,size=60G,share=on,host-nodes=0-1,policy=interleave \
  -object memory-backend-guest-memfd,id=ram1,size=60G,share=on,host-nodes=0,policy=bind \
  -numa node,nodeid=0,memdev=ram0,cpus=0-3 \
  -numa node,nodeid=1,memdev=ram1,cpus=4-7 \
  -object sev-snp-guest,id=sev0,policy=0x30000,cbitpos=51,reduced-phys-bits=1,convert-in-place=on \
  -bios "$OVMF" \
  -drive file="$DISK",if=none,id=disk0,format=qcow2 \
  -device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=true -device scsi-hd,drive=disk0 \
  -netdev user,id=net0,hostfwd=tcp::8000-:22 -device virtio-net-pci,netdev=net0 \
  -kernel "$KERNEL" -initrd "$INITRD" \
  -append "$ROOT ro console=ttyS0,115200" \
  -trace enable=kvm_convert_memory,file=/tmp/convert.log \
  -nographic -serial mon:stdio

   The guest boots successfully and run memory hogger. With this, I verified the
   shared <-> private conversion logs (trace_kvm_convert_memory).

3. Additionally, verified the NUMA placement for SEV-SNP. With this series,
   NUMA mempolicy support for guest_memfd [2] now works for SEV-SNP as well.

[1] https://github.com/amdese/qemu/commits/snp-inplace-rfc1
[2] https://lore.kernel.org/kvm/20251016172853.52451-1-seanjc@google.com

Tested-by: Shivank Garg <shivankg@amd.com>

Best regards,
Shivank
