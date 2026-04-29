Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E724EAB1;
	Wed, 29 Apr 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504943; cv=fail; b=MebdubJIBdDW4+AkGlH8gEHFESi2O9F+fGb6P64ntCZN2ftNBtP5YbumX9oU2e8NDTP01P423yevXLEw/z3H01moI+aykMp82Tav899VFWnETzyygCAdq/xeES3vhfty1p7XWQvwH24TIUg3v75yfT/CKBIDO6lPIfax17n+nqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504943; c=relaxed/simple;
	bh=KDa4OT7zWA9ip4FQktzdvoB74UkW+jm3S6Z36dQc4FA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs9hZO4I9afhLIuRQ4zhj8n3fBgl+ZJXd3qgyT0hG+Oh9Tk8y6jxTY8jXfEsKubA+tcrayVtvjCfxT81OC0hrOj+fXNCb5u64r4jlCg3d3goz5emC/9ByIz8fqCJcLVPBN2XP850qokEXyAqKI5vS2tPfVhlEsFW0F5/G3Pi26A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1WOCJc93; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1WOCJc93"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjM5FP0LkDvOrZKevfESA+b6m3nkgZwsAmbkUQwTURoeE/14navYZIBgdgwe+deprXe9zrYA826Lw2m3fSk0/IugmsFLj6NsHaHfHFabB1WScRwaGPxo7wmvy4dd8xLDLoCtdO0dZfsLjk38fqpzGze6Cp2V+0OugRMFnQD5crPjFXKZirrWvgDczRyfC3Fn8fnBlVPC+dqDZOe77iLej24/X9TbGdNq0TyYReanvE2Y3XwGx48CqSbJW/RDDlvHWIJb9ZTzH6oMXPT2/iNKBatqDFxU/tQrkHjruebwob2dSS9yDUjFBJsBKj9zWdEp+18rwdwCwXH4ofM13U8lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1rJItAU+CKsV98tcrZ0BfK2zyiexu+0UrQC7zrCtbk=;
 b=BlYx7LK4EMYe+6E1VfdT32jX/7/OrPf4+Q22ni8cZVLx6GxdXVZmPDpPyO+yMLuQ6Xi9P8g5+IYBqM8CYGqKJnM9GVAe16RDN2x2MSg2RFoBzQH1a7wn2oR545THkPVzUaw6WeiB18P4gAP4U7ylcWe/+T23e6PaZxy2bgmSX8+raPwu63mhJAzFRWQT9/f62s39eGA1cfAD72UgYLH2tMkBTwjTN0u3scbfEpIOVooBBcB/xqYFqUvhPKkFB/pt7LMRJo70FYNz0EUcSmXbQhQe8+Vsip6gGURHkqH0ZcP3AIT8sVzHyiYIsOktxCn+zqT1FT4RLafn6TSHtJ0Uow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1rJItAU+CKsV98tcrZ0BfK2zyiexu+0UrQC7zrCtbk=;
 b=1WOCJc93RC7Ov/h52aevy6hzLbwUIt07Psejc8PeFUFVG6sDuhkZUoKlKbEaI/KsAjc2GN+SpU/4TjxFZLXpJMTijS9skT02R4DAFSelk+WFchdjeS4d7N8bJyQJs1pQj2kCLqvCl64HlSmGRKN9GbnvG81eJ8W9TPyuggKJBTs=
Received: from DSSP221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::14) by
 BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 23:22:13 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:8:3d5:cafe::be) by DSSP221CA0008.outlook.office365.com
 (2603:10b6:8:3d5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 23:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 23:22:13 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 18:22:03 -0500
Date: Wed, 29 Apr 2026 18:21:48 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <aik@amd.com>, <andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ira.weiny@intel.com>, <jmattson@google.com>, <jthoughton@google.com>,
	<oupton@kernel.org>, <pankaj.gupta@amd.com>, <qperret@google.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <shivankg@amd.com>,
	<steven.price@arm.com>, <tabba@google.com>, <willy@infradead.org>,
	<wyihan@google.com>, <yan.y.zhao@intel.com>, <forkloop@google.com>,
	<pratyush@kernel.org>, <suzuki.poulose@arm.com>, <aneesh.kumar@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for
 KVM_SET_MEMORY_ATTRIBUTES2
Message-ID: <foi2zvv5qrfdcspnx4fstrvzl74m6xp6zrsw5omlbprxh4jrhx@vxnwk7fr46gu>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf>
 <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
 <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 500d6850-0b33-4e80-aec7-08dea6462504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4W3BHvPVy/Ic1HuR9ncBNyMOhaVhm4Wn44a4OsHt4hwMszhl8iiAnwekV7Hkyotdd4ckEDPrFljk5gDj3XemwVhh2n0Kw9NUQFPFGjOK6HuTVWnsn8uvH/qeOUaxqdVorr7foHCdp/0D9ytJLoOfM7D1QOFO+VJNxaABiNq45USb8jzWHl4DbLsFCyLz6Qwjc1mV/Le29jGfzfAC4QiLGj9LQqvkoE+OPmCLrURSPBGwkbj+VNIv4UDXlO/vIR/oY/46VFlrHnGv+Lmsqx0MEbRBc0BncfsvYOPYfBtSx+2qa1X9ziTHs5Gamjpofwpb/f+7EFcAR4Y+aCACc59wNF/J8M1DNgFIulOkeSir93onh09pnVHzs/k6CTFL+2UvlyRI9Ez0VxWG6/XH8Vr2RO4ZcjuqUJAATu3EQ4L9jEADt4JDKMi7tiEmeuJqmZYj2rFYJZuDa6vF+2B+iZ8ymE14GfnTp6aRS2xoS8rKdXhYHRVlFhX2moGH8wGuatqWJJH1bXuXfIQW3S3lpcpz2s6s27abLSFgoc992GNyJJ6HxnnmVwlgMiwjj9Ist93glkuybvQ1xT3MY/AT3S/ULRrsxEHs1b+VDXNQb56uF9aZelSkk1SvvgHPBy+xXByTsNi0wZ1udCcqyO1wMyW98Wng3YsMaD+QmvgfmzRziayKoOLHJxjl/TE3s+b/U54/sZfaDpdmQBCj3f/lqjUyuE9dQXkD4V9pFyY6MaMTl/tbj/4StWKsbUkjD2ESawIe+dROogRrk9oizWpyMWwh/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ggrMGTzSnPB829yb41d8c0xYIndsy10JUzvPV6QoRSM/L2fcN5nIQh73F35DTrHm1f9Q0+IN6YIyHJvV2CgnrMtf4tAo3WKjqWqviokKq+nuKgsGv4Hmqgn8Gruw+Mia1cl0YbD92ydSVz+mQWa0kBC98ZGb9mrkguOrZvU88LqxkZiAGoKIuJgzdnPfbsCBRydYeRLqgJuDb64mxR0czU0yoOd6JLpRWtIFcCgNUWpK71uFZUyNtCz+UAMPNn1Z+8Eug4ssjY1ilbc6WWaNYTYyNdPmCPRLtvJ0Rkwoty71UKsNuH/wZiim9Y/29UHRsGzg6qB/6o5mIkcH3n9MNaYGAHz3YA4qsIXGnOwLtfgdIS/ghGuhlH27FLJRzmiaXYDLfykFBGyfUtju1K5078TqlR9u85RCi0BkRhjN8cbhYDn3+ghifBt2SOp7+XLV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 23:22:13.1377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500d6850-0b33-4e80-aec7-08dea6462504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

On Fri, Apr 24, 2026 at 12:08:45PM -0700, Ackerley Tng wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> Thank you for your patches!
> 
> >
> > [...snip...]
> >
> >>
> >> I also did some minor updates (prefixed with a "[squash]" tag) to advertise
> >> the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVED flag so it can be used by
> >
> > Though I'm not sure how we deal with it if SNP/TDX at some point become
> > capable of using the PRESERVED flag *after* populate... but maybe that's
> > too unlikely to worry about? If we wanted to address it though, we could
> > have both PRESERVED and PRESERVED_BEFORE_LAUNCH so they can be
> > enumerated separately from the start.
> >
> 
> Not sure how likely it is, but if SNP and TDX can honor PRESERVE
> semantics after populate, I think we could implement support under a new
> flag like CIPHER.

That works, but it still makes things *slightly* awkward due to special-casing
the PRESERVE semantics for 1 guest type vs. another.

For instance, for the QEMU patches what I'd like to do is be able to
issue conversions with the PRESERVE flag set, and it makes sense that
when the function that handles that gets called (in this case,
guest_memfd_set_memory_attributes_fd()), it asserts that QEMU
checked for the corresponding capability/flag (via
KVM_CAP_MEMORY_ATTRIBUTES2_FLAGS) earlier on during QEMU init time
and stored that into kvm_supported_memory_attributes2_flag to check
against later in cases where we try to use PRESERVE:

  https://github.com/AMDESE/qemu/blob/1308d4bcd8dd8acd151243e96ff0be4098389b93/accel/kvm/kvm-all.c#L1655

but that check is sort of incomplete: for use-cases like pKVM it makes
sense to allow conversion+PRESERVE at all times, but for SNP/TDX we'd
ideally have an additional check like:

  static int guest_memfd_set_memory_attributes_fd(..., attrs, flags)
  {
      struct kvm_memory_attributes2 attrs;
      ...

      assert(kvm_supported_memory_attributes & attrs);
      assert(kvm_supported_memory_attributes2_flags & flags);

      /* SNP and TDX only support PRESERVE prior to launch) */
      if (vm_type_is_snp_or_tdx() && (flags & PRESERVE))
          assert(vcpus_not_yet_started_and_LAUNCH_FINISH_etc_not_yet_called);
  
      ...
  }

maybe that's fine, but there's just some asymmetry in the fact that
the capabilities checks are essentially self-documenting/self-enforcing
in this regard, except for PRESERVE+SNP/TDX where userspace needs to
sprinkle some additional vm_type-specific logic.

So that's why I was sort of thinking PRESERVE might deserve a
PRESERVE_BEFORE_LAUNCH or something so the kernel can enumerate the
support rather than userspace needing to read into the documentation /
implementation to implement finer-grained checks/etc.

> 
> CIPHER can then be used to mean "do the encryption or decryption", and
> for platforms not supporting encryption, they'd stick with PRESERVE?

It's all theoretical, but I'd imagine that *if* SNP/TDX ever added
support for allowing userspace to write encrypted memory into a guest
range, it would be something like:

  - write plain-text data to corresponding GPA
  - issue shared-to-private conversion with CIPHER (or PRESERVE) bit
    set, which will then be augmented to make some sort of firmware
    call to encrypt the memory with guest key and make it visible to
    guest

So, at a high-level, if host writes 0xbeef to shared memory, then upon
completion of the converison ioctl, 0xbeef then be visible to the guest
via encrypted/private memory, which seems to match the semantics of
PRESERVE perfectly:

+``KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE``
+
+  On conversion, KVM guarantees memory contents will be preserved with
+  respect to the last written unencrypted value.  As a concrete
+  example, if the host writes ``0xbeef`` to shared memory and converts 
+  the memory to private, the guest will also read ``0xbeef``, even if
+  the in-memory data is encrypted as part of the conversion.  And vice
+  versa, if the guest writes ``0xbeef`` to private memory and then
+  converts the memory to shared, the host (and guest) will read
+  ``0xbeef`` (if the memory is accessible).

So it seems like a waste to have to add a CIPHER that would essentially
have the same semantics (even though the architectural implementation
details are different), and then complicate the documentation of
PRESERVE to have vm-specific behaviors that userspace needs to account
for, rather than leaving PRESERVE as-is and adding a
PRESERVE_BEFORE_LAUNCH that neatly encapsulates the specialness of the
SNP/TDX flow without complicating the more generally-defined flags like
PRESERVE that could in theory become usable by all variants in the future.

But then that sort of has me wondering if PRESERVE should be
PRESERVE_AFTER_LAUNCH (to cover cases where maybe SNP/TDX gain this
ability in the future, but can only use it post-launch, where other
architectures might allow it both before/after.)

...but that seems to be getting into a more general issue of how we
determine what is available before-launch/after-launch, so maybe instead
of introducing new flags, we just have 2 capabilities that returns what
flags are available at each particular phase, e.g.

  KVM_CAP_MEMORY_ATTRIBUTES2_PRE_LAUNCH_FLAGS
  KVM_CAP_MEMORY_ATTRIBUTES2_POST_LAUNCH_FLAGS

And then userspace can easily probe/lock down what it expects to be
available prior to launching the guest vs after without any vm-specific
logic, and we can continue to just stick with PRESERVE/ZERO. (and if
we do end up need to further distinguish pre vs. post-launch behavior,
this gives us some flexibility to handle that as well).

> 
> Should we redefine the semantics of PRESERVE to be "ensure that memory
> contents don't change while guest_memfd tracking is being updated" and
> avoid making a commitment on how the guest should read the memory?
> 
> The above update would be aligned with ZERO not being allowed for
> conversions to private (because KVM/guest_memfd does not make guarantees
> about the contract between the host and guest.

It's a little awkward here too, because PRESERVE is sort of making a
contract between host/guest: we are providing trusted data to the guest.
However, there's an attestation proces that allows the guest to enforce
that for pre-launch and ensure we are following through on that
contract. PRESERVE for post-launch...I'm not sure how that could be
enforced, but I think this is further reason to allow pre vs. post
launch flags to be enumerated separately.

Thanks,

Mike

> 
> This way, all of those (ZERO, PRESERVE) will focus on KVM's interface
> with the host.
> 
> This lines up for SW_PROTECTED_VMs too, since reading memory that didn't
> change in the guest is the contract between SW_PROTECTED_VMs and the
> host.
> 
> >> userspace for SNP/TDX in the kvm_gmem_populate() path as agreed upon
> >> during PUCK.
> >>
> >>
> >> [...snip...]
> >>
