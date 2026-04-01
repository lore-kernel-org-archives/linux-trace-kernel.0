Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911C33A9CF;
	Wed,  1 Apr 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056595; cv=fail; b=Oh1sAApF7K2YH2WwkflIOPJiV8wz+KHfuw2Q/ES8t+osiSW8BZplaGUI/m5sCjWKwi5g1/0agfMpgzWaNDqFrDwWT4FLVbtcd0xYueENsX9wxlPqLfMxvCZu9ZWMLAFRv1nWpikblgS7bWkP73kF47qKCtNTJIaEs/QVX0YAbOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056595; c=relaxed/simple;
	bh=x2NMzsmDvLwnojKiM1+PjmgqTBmuN9XZreZZ3av69S0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud7ZDaoXjPPniu4cqcQr6Rq25JiNflGQrIWIcSww8bKFtlCIifBacwGmgtd/g95eDD6riqxgr0O3DRgLVsmujwzxKH6/3SXgULIhCbfCdJAXpfgFFzfWsIAQnIzwdnb7lIOrtYCqKjEfLpLCGo8OnxajkwCJWbpE81uKARoScMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FWb+47bj; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FWb+47bj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpRH/8qTGowq8wTk7e6gZK05hdTDq9RWP6Apgt13BaCSJC2D2kXLJJemX8a8eUI/ahpdROi0ZgQv+QKDFGhj/klFDEavM2krUdCysCROuqvdAc7Y3YMZ6lbvrSZxuXMQvD2PVN7oAaz9hQQ/zncLZWdYburCXv0UcHnjejWK+grM5iXN7yvCX75vmgBjcNKIrh9UMvzDzAA3xSUyAy5aemzTZ7m+Wlm3HSxN6Mdyq6JRigMhh8p3LnWpG7jstrCRMo60n7mtEedLSlNpdonn2HT4dZMCa6tt0DJ+eQZTAe0CcgIHnDuw8UDwuPPMDHpyu5rBk1nudJQr6LzVXybcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+9k8JR0Ma+fU77OX2G1VmdHTeBqJ7vzDnkf43am6Zs=;
 b=Xqf8XhhcEp4psCMi/Af5EMPdwjgeHy0JDwSyNYXTB8NqhBDJEJ28MDJy1tikXnqF2TKg4+1QLz8jceH9v5iShNKq39gBEyljHOx8mNZOGgMpWY+vBEnZOzfM3L1DefQDjWIgT6XZtaFmQvSdQbPNOyvH8PrINMxpE7Phlw15C8NlhOyB9y7WAiWtJ13l1HHBWGX+IkEsDhqO25IB4ipDNOYLHLrCmutqXUsbOyOJfcWX2E7zCVn+Hd4OkvmfK8N+2CSDdD+hbg1OF3F/ciSHSYViFLDO7/FFGA3x73uJjUD460CoaqLOKg/d+JUw+CUZte0jnc482rKfdmYRnO5sEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+9k8JR0Ma+fU77OX2G1VmdHTeBqJ7vzDnkf43am6Zs=;
 b=FWb+47bjFKXeXDde3tKB0z8gHotXO6r2s+QPw0GnH+EWuYOuSnsARujou4nZz2ACsblrlnJZfydz8+NDw3p3YYocs9lo8W0CyApmmS/ciRIhAfqySx+LNpAlvePz5Y7Wahj1Nyv5T1Xk5Si0D2YSz7l9o2c8GEfZHwSd+NTeJMI=
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 15:16:29 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::1d) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 15:16:29 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 10:16:28 -0500
Date: Wed, 1 Apr 2026 10:16:11 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <aik@amd.com>, <andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ira.weiny@intel.com>, <jmattson@google.com>, <jroedel@suse.de>,
	<jthoughton@google.com>, <oupton@kernel.org>, <pankaj.gupta@amd.com>,
	<qperret@google.com>, <rick.p.edgecombe@intel.com>, <rientjes@google.com>,
	<shivankg@amd.com>, <steven.price@arm.com>, <tabba@google.com>,
	<willy@infradead.org>, <wyihan@google.com>, <yan.y.zhao@intel.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <suzuki.poulose@arm.com>,
	<aneesh.kumar@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
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
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH RFC v4 07/44] KVM: guest_memfd: Only prepare folios for
 private pages
Message-ID: <s4dbqrv2c6yzt4nsflfarnggtl25xlz6mzg74tfeg3eskceno6@6l5hpfmcbju3>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
 <CAEvNRgF+FjJ1EWSR_rzD1=N040ZitiRrM2O3N0Kj5yN5rT3h+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgF+FjJ1EWSR_rzD1=N040ZitiRrM2O3N0Kj5yN5rT3h+Q@mail.gmail.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: ff40745b-b42a-494c-3951-08de9001a639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mui79d6WuBdwGPubUtn7BNSU3jT282Dhswk6ENFdhnDCc9ZI8zlPlr73kshxh//pWhss6OcsMg5zHvXhxwrUSpIlnTIaPkKy7aOTuwsign9ECxrbbJcVf2j5xCrBMT7meU1CV/ChOjqkM8gTfQnJ3PLQNgJqu9VWeyjmWKJm9Of0fsltOBRrnWr0JssZ4SAelkWvbZzaCYHjI3hxLLS0tVm2TsSShHbbQO2HAFRgP2todtk3Z0+cAJ1U0UJjXYpNdZLMlqov6uMiI59nvrofXy6nJeLgFPULBjT7YJaTkXZicRaQtUp/lfjXm1krIOneTxqIAFmGKRD4UWTM0FGVB0hVy405FF9BGRGn1pzd+v9IRvB6vTrag6bq0cOQyo1NAcszcawZNhREoX1+FDjOYXzGiTiCpBC6sYeIT7hh6Ei07SCagTlzn4r9axGOoNLVj6bejksqoJDoO0d3TAFhZfQvrUrAMethbT2q1HjSp5zOG7w4I0PcLHsy4mvJ19K2EmDnYTI7hCEKZlViRanMXRtSwDyYmPr75hCAu0PxtcEgBeaE0prXuHdDt6FsirfDjoLd9PDzSVsUIUnmixFa3yGoNtpaedR1EJP98l5pUIq5jitqmmiFfuqGGt0KtcNbuVJU5zwzTRkdmpeM8OHxBf6baQYwNzdOJV0/QNhOjOPUT6c/n4CksnZ5ZNvjKUUwBLzYJiZ92VwrN4YKlxr1cEr5+XB7q41x36BhiDuiWqa9V8G5uXCuc4g8MSEoTxWo09k48ActffrteUeNfwfS5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6j0hghzGGfUdhgvFuRXBlwdLqgPU+otHpxr1M7O7RokP7WQ8mPd4l79jTc5H90IqV/NkKXvpi3PJH8AYLdpcP7vjdB10HSAwSyG7aAK7cHVuFYq5IKnDqP5Mb1gsIVNmjXD/UDU6f+6FxDQU2MtiumT6n3evwWvFAcgX0g0p5lpk9OT+SAHTjAUt8tqvg5Cxy0FyXs+WY3Cz0RtVtnU9+/xGSfxc+zwo+/Hi9hPf8Xu1kHMPpm4UH2pBDy7yNNFDBAFMY/GBKwZkrLW1RxBpI8W6h3cpUrbz8gJGVb12cxBfSz76JXXFMOoEcJGmgjQYO/oEg/V/D/74m8oMMyec3kP+IHaey5Fd5ybIdoY9CogEDAzI781QP4r7wYTguMG9uWHZ6w1mMZZoA7a9Sasces9jKAOgrKWrXKzJ7nub54kZ61mu+gPWAjyegATcwOvB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:16:29.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff40745b-b42a-494c-3951-08de9001a639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

On Wed, Apr 01, 2026 at 07:05:16AM -0700, Ackerley Tng wrote:
> Ackerley Tng <ackerleytng@google.com> writes:
> 
> > All-shared guest_memfd used to be only supported for non-CoCo VMs where
> > preparation doesn't apply. INIT_SHARED is about to be supported for
> > non-CoCo VMs in a later patch in this series.
> >
> > In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
> > guest_memfd in a later patch in this series.
> >
> > This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
> > shared folio for a CoCo VM where preparation applies.
> >
> > Add a check to make sure that preparation is only performed for private
> > folios.
> >
> > Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
> > conversion to shared.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  virt/kvm/guest_memfd.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index b6ffa8734175d..d414ebfcb4c19 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -900,6 +900,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  		     int *max_order)
> >  {
> >  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
> > +	struct inode *inode;
> >  	struct folio *folio;
> >  	int r = 0;
> >
> > @@ -907,7 +908,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	if (!file)
> >  		return -EFAULT;
> >
> > -	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> > +	inode = file_inode(file);
> > +	filemap_invalidate_lock_shared(inode->i_mapping);
> >
> >  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
> >  	if (IS_ERR(folio)) {
> > @@ -920,7 +922,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  		folio_mark_uptodate(folio);
> >  	}
> >
> > -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> > +	if (kvm_gmem_is_private_mem(inode, index))
> > +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> 
> Michael, I might have misunderstood you at the last guest_memfd call:
> sev_gmem_prepare() doesn't prepare a page for being a shared page,
> right? Does this work? That prepare is only called to "make private"?

Hmm, I guess your guest_memfd-inplace-conversion-v4 branch is out of sync with
these patches?

I have the below local patch based on top of that for SNP-specific enablement,
which is basically identically, so suffice to say: yes, this should work
for SNP :) If any architecture pops up that needs to do some prep in
advance of mapping shared pages, then we could potentially plumb the
shared/private flag through to the arch-specific prep hook, as was also
suggested on the call, but it doesn't seem like that's needed by any
users for now.

-Mike

  Author: Michael Roth <michael.roth@amd.com>
  Date:   Mon Oct 27 07:58:32 2025 -0500
  
      KVM: guest_memfd: Don't prepare shared folios
  
      In the current guest_memfd logic, "preparation" is only used currently
      to describe the additional work of putting a guest_memfd page into an
      architecturally-defined "private" state, such as updating RMP table
      entries for SEV-SNP guests. As such, there's no input to the
      corresponding kvm_arch_gmem_prepare() hooks as to whether a page is
      being prepared/accessed as shared or as private, so "preparation" will
      end up being erroneously done on pages that were supposed to remain in a
      shared state. Rather than plumb through the additional information
      needed to distinguish between shared vs. private preparation, just
      continue to only do preparation on private pages, as was the case prior
      to support for GUEST_MEMFD_FLAG_MMAP being introduced.
  
      Signed-off-by: Michael Roth <michael.roth@amd.com>
  
  diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
  index 3acc6d983449..4869e59e4fc5 100644
  --- a/virt/kvm/guest_memfd.c
  +++ b/virt/kvm/guest_memfd.c
  @@ -1249,7 +1249,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
                  folio_mark_uptodate(folio);
          }
  
  -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
  +       if (!kvm_gmem_is_shared_mem(file_inode(file), index))
  +               r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
  
          folio_unlock(folio);

> 
> >
> >  	folio_unlock(folio);
> >
> > @@ -930,7 +933,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  		folio_put(folio);
> >
> >  out:
> > -	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> > +	filemap_invalidate_unlock_shared(inode->i_mapping);
> >  	return r;
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
