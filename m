Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F1513569;
	Tue, 29 Sep 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686986; cv=fail; b=ugCWlWdViq/APeApau3XdoozGKDB1keYfDDUGcwkwvFxM7pjaXcEW7nLipkWqHKuwFyzN2gtJInxovoLGP1wMv1LH8RDlsR10V8DH4Tqf23GJXnQj2nnFHE4o987DGlO2Ek9hBLjf0u36rHRXOHqzwi7gbZ0AmuMCEd4jIcjE1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686986; c=relaxed/simple;
	bh=IjU61hAZhSL/ARSmqUWcBOAIIu16YxAZC7P0+S/3Xf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO0JAvAT5CyuzVVDa9u2z5qupgDmVtJ0X3yxihM5fHN9g+FpLB4LW21gmRMFil++c6Qd/uOLjoENnvifKkOyHvQd9M3KSWuKOFc6eQjPdts2axrB2V2pEpXjwd/JjuBDS3q/+xS6GhLkbUPBU0yg3igLEyfjy2yTHJbGah8pVyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyIi5Iph; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyIi5Iph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwmsI7nkYU0EbY7fR9vh3X2nOY8uHbs94pepgvSMqjKkMVmYHe0IFSK4uM17cMTEUBW4Z30y5WUkGMzy9OOlNWwvD3aqdSSS/xc5OPavqG9nvdoHQ8+JSfBm4qS7M6usmYtJBDlFwvlybMN0HwoA5NW8hu4rb64roFLOVZn1RhXUrpT1DBcxD+HO8RHutBk43H1fqdff57m6A2uCR5P1U43ePygM+J3d5/CemM4Cdk1c4DYAMxGUn6RFfL1vMVffLBUYRm0PU15kuF764VEt3UdUyxghW7272vqCewrV/ju0EtQs9/Q8wfnnc6w9Uyl2bjyurhxSXNkv5XuAoE0FUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnSdzzN2KtF34pEHk0SHXphMi0ngC3E/N96I0h1J5v0=;
 b=M63B+6VzUQonXALtWkdWhcemgZ7EDPHv0kTOMvpJostPqsFJS9pYlPe0AS+N5wAVkzww55DHRtDWh17XzXhrsyRrB38OJxhtLj1t58K8Y04ZvTW5iPd29n007RND3i1S+0pw8dNV4cpChVgeQMQ/4YOgLqfK1xbZffh7OtR1VqkbU7Q3mXgBVV+AdYW5i4xyYP83CDJZyvjOt8obKUz58M5zcdTL5oq1eRffuhvpcvYQFyj7QjZcJSNCBw3P7NBr9VFRa1ot3KUmI8xxXBhuRV2aMR5i4wjNCapxTc9COMdoYWhoty00hKUtsmdpLFt7LP/axnAdPZG6WuGR7MBASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnSdzzN2KtF34pEHk0SHXphMi0ngC3E/N96I0h1J5v0=;
 b=LyIi5IphMxmsTSIX0pmkU1h6YHu20rqcnbjZ9Zzd4ZrORPX2p1v8+BR14nCd3etjaGKDYXYdNoWEru4N3AWS/e7vEHE5znjURRlMQsYHGSXwAog1KNnTmntJ0sbDywZ9qSRE+TjFAkBEdcGp12o32ycm/+GeumfXFfMl1cJTYZw=
Received: from SA9PR13CA0156.namprd13.prod.outlook.com (2603:10b6:806:28::11)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 13:02:44 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::54) by SA9PR13CA0156.outlook.office365.com
 (2603:10b6:806:28::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Tue,
 29 Sep 2026 13:02:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 13:02:43 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 08:02:42 -0500
Date: Tue, 29 Sep 2026 08:01:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: Naveen N Rao <naveen@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Ackerley Tng
	<ackerleytng@google.com>, <aik@amd.com>, <andrew.jones@linux.dev>,
	<binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <jmattson@google.com>,
	<jthoughton@google.com>, <oupton@kernel.org>, <pankaj.gupta@amd.com>,
	<qperret@google.com>, <rick.p.edgecombe@intel.com>, <rientjes@google.com>,
	<shivankg@amd.com>, <steven.price@arm.com>, <willy@infradead.org>,
	<wyihan@google.com>, <yan.y.zhao@intel.com>, <forkloop@google.com>,
	<pratyush@kernel.org>, <suzuki.poulose@arm.com>, <aneesh.kumar@kernel.org>,
	<liam@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
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
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
	<peterx@redhat.com>, <tarunsahu@google.com>, Fuad Tabba
	<fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
Message-ID: <gqybhgtzeufmbohckesirsbu3ftn4s4i3uhjhaestphuppvth5@zx7lqsldosbc>
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com>
 <art6ARechyK0iytK@blrnaveerao1>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <art6ARechyK0iytK@blrnaveerao1>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: e671748e-6ee7-452b-8aa1-08df1e29f37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|7416014|6133799003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DJtHg4PFlipWrHbxcdFUSMHqx7Ma1/j+fW+CyNEsBUrhHuZYSa7axyVNY5SR7wDJDDLLkscqhh27rOW0pVoIaQlM2kI+/MBLbe6PNNkBhfiAJ7XtiUtk7P3sQCNAO9auhk7an4zN7+IU8p5mpk2r++/tMdOBQmj1TUczl8sG2Nvg5d2lsyFKO+xPZLBhGHKid4yWkvWD8q7TxYvMO2khCY8RJhejLcL95yrdmbrOQwoXB2mc2zyRFBuhy195IIMkbppwIJwoecTgk28WQZKRDFWgxB165+N16lE7WmN4sSB8h+hZoo9JGQQnSNsPInVDM492dq3oDlZdzmnSbNjit5lxtZRTaiQ+eLUYVhPF9GIzf5SBMB2zD+xIoYwXlk+OnST9tqD7f7yIyiPrgqbB6ESucsnep2bMtd0G5yYU4BwUh5D/A1hTgrglwTZNY8lpBhi56tGslpCb4dBC4y0LdBC9vpoPBZ9TjrbbDiAZFKiQ9oQn47uw/0EiWgHwrT5KemhvXl72/2BG73qyekOUpIg+UZoYfJleNniTOZXf7R3ccPd3wj61FAAaZfmGV6Ufor0poz/8H/EZcwTpxmTsgIxMJRHGfNsKHjoHKQOS2kGmD69AG40mnoEI75Ft2inNcP5xwM8FnVSRpsFwbalZsI59yOzbXpRN2nvNvfbe4K6Q+F5q1cJ654waXA/hK6RwhKhq9roGZ6kY2nCFbfyHDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(6133799003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UWlox5Y/EVZy1WWCuGEaAcWf56XUyzgX2z8LRuO/TxyEqqs8ezTuT8ci0SrxvyPdQj0d60xAHRmZSR1axWhhE1brf2mTKMFL7Ss7tW/0ggzIX8o8yGwgFMH2zS0zUN79PPhSbfDst7drXMtaXd2KDXkhOFiwsj35qFbP+/TmE/O4jpnAOFZDZlB8ejpkNiNc32oruly1QmLpa2csBbARw9P1RdSNSpteFttfctszfFgPDbTgxgdlkXLqdWZ/E+YoY4ZLoBfH2jEdl3vzoMeF+3qU0hc9fXRyQ2SRwAfhADlbdOFnvHDL5sZPGCJPkXMa0fgsCITi866q94UsWHAmDjmbMa7rwVSzqAgiRgNYsRGbYZVA5Kc0YzcX683JJtMV62aKJN79Di1PKwpBcUDcBXlXJL3/liDQaZpNQ+UStvbBwng1X4vXUjY1qdXCE0Ed
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:02:43.6921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e671748e-6ee7-452b-8aa1-08df1e29f37f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695

On Tue, Sep 29, 2026 at 03:10:41PM +0530, Naveen N Rao wrote:
> On Wed, Aug 26, 2026 at 12:44:40PM -0700, Sean Christopherson wrote:
> > On Wed, Aug 26, 2026, Ackerley Tng wrote:
> > > +
> > >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >  				     size_t nr_pages, uint64_t attrs,
> > >  				     pgoff_t *err_index)
> > > @@ -624,7 +661,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >  
> > >  	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
> > >  	kvm_gmem_invalidate_start(inode, start, end, filter);
> > > +
> > > +	if (!to_private && kvm_arch_has_gmem_convert())
> > > +		kvm_gmem_make_shared(inode, start, end);
> > > +
> > >  	mas_store_prealloc(&mas, xa_mk_value(attrs));
> > > +
> > >  	kvm_gmem_invalidate_end(inode, start, end);
> > 
> > The real reason I responded...
> > 
> > Thinking about the Secure AVIC mess made me realize zapping NPTs for SNP VMs isn't
> > strictly necessary in this path.  The PFN isn't changing, just the attributes, and
> > that's (obviously) tracked in the RMP.  KVM doesn't need to zap SPTEs to induce a
> > fault, because the mismatched C-bit vs. RMP status will cause an #NPF(RMP), and
> > AFAICT kvm_mmu_page_fault() will do the right thing.  A misbehaving guest could
> > continue to access the shared data (assuming we stick with lazy conversions), but
> > that should be fine?  E.g. it's not really any different than implicit conversions.
> 
> Brilliant idea!
> 
> > 
> > In other words, couldn't we do this (as an on-top optimization)?  The only wrinkle
> > I can think of is that it could delay reconstituion of a hugepage, especially if
> > we opted for eager conversion (because the guest wouldn't hit #NPFs to trigger the
> > hugepage promotion).

I suppose gmem could selectively zap if a range switches from mixed to
all-private. For non-confidential guests, it might even make sense for
mixed to all-shared if there's some way to avoid the forced
hugetlb-splitting in that scenario.

> > 
> > diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> > index 62f751952ad8..61f3e270ab61 100644
> > --- arch/x86/kvm/mmu/mmu.c
> > +++ arch/x86/kvm/mmu/mmu.c
> > @@ -1670,6 +1670,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
> >  
> >  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >  {
> > +       unsigned long shared_private =  KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
> >         bool flush = false;
> >  
> >         /*
> > @@ -1683,6 +1684,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >         lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
> >                             lockdep_is_held(&kvm->slots_lock));
> >  
> > +       if (gmem_in_place_conversion && !kvm_has_mirrored_tdp(kvm) &&
> > +           ((range->attr_filter & shared_private) != shared_private))
> > +               return false;
> > +
> >         if (kvm_memslots_have_rmaps(kvm))
> >                 flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
> >                                                  range->start, range->end,
> 
> Can this be a problem with gmem hugepages? Not sure how that is going to 
> look like, so this may be covered in other ways.
> 
> But, as it exists today, if the guest converts part of a 2M page to 
> shared, then this skips zapping the SPTEs from the call in 
> kvm_gmem_invalidate_start(). sev_gmem_make_shared() then issues PSMASH 
> to convert RMP entry to 4k entries and we end up with 2M NPT+4K RMP. If 
> the guest then writes to any private page in that range, 
> page_fault_can_be_fast() returns true, fast_page_fault() only checks 
> permissions with spte_permission_fault() and does not do anything.  
> sev_handle_rmp_fault() also does not issue a zap since it finds that the 
> RMP entry is already 4k, and we end up in a loop.

In Ackerley's hugetlb series, gmem will split the underlying folio to 4K in
that case. I assume, if we end up adopting Sean's proposed optimization, we'd
update the attr_filter to force a zap if there's a demotion, similarly to how
kvm_gmem_punch_hole() handles it in this series.

I think as a general rule of thumb though we'd decided that guessing
too hard at what hugepages will need is best left to hugepage series
itself (TDX prep work aside), because it always ends up different than
expected :)

Thanks,

Mike

> 
> 
> - Naveen
> 
