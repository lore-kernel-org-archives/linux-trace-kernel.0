Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F43CB2EC;
	Tue, 14 Apr 2026 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209916; cv=fail; b=pfniDKtq9g3nhiuqO9OVfes7mzYSjDU9sO3Mz9c0rpaFp7+XZjrTZfI94CktZLU1vNqQDO7lcSgScKdvp0kLfzgl94B+tw6jjBIr+2ZGy2QbpvNVghoIVPKmU7Q/upImvkuPBIJGF1R3MCeIM70xyAXNg5bugcoWaOJCIVxIEIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209916; c=relaxed/simple;
	bh=QH6ybq6nzZXAWB+3VcquMDMn8xF6d+0Z/XziO+1q1Uk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPuneH9b1S3ORn3A4qjvfuKsRPf3Np9dD4EHRXenbSv+qJPjT2D+5VaPGVZaHeQco2bNN09J9Poj2yZz3NTWYHqwHN3VWGcvkkWcN0LpYtaZlrClGLQU+uTXIPjHX3f/fPp9wc9Sl1gKhLpRSeEnNpSC0HeLlWBFC27+kcp7Y3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kxl0BsN0; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kxl0BsN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfY+AS2Q2Nue+D6Li89mh5eRfH2MpTj6BtFgwoaSzfY5TE8f1xwQ1/7PlVQJqJy7az54ZdC/bCCLTh5j2IykGn+BtuL2XmlHrZ81wFW/3SVMHsfsXieSQZ9KFJxt61Ay1FyfMf+vsYBN2MbzgoHiASIZiCasWDDhuquKtNp1k+ivz7iSKh0UjOsENgUWjmGMYno8uNYbTyJ3N1sjeHsZ+Wfi2ahNXjfNPXYsRykSDlxThW0vx2G3hb9yu/1b+bauVeSSMKWI3kElZfqV58kpHqMmu718I5U/2wEnlfZKn88bchUrsoF1VgOP5oEtMkqd4CW/iiOHmEEvi8zEWwIVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQZV6DXglvF+U23BzePtiGc0FKpBMuAPNbSOWy2UM74=;
 b=a+9RiFdmrImikg+XJDUsyLTZc2EHf8cGdaKO0EzGxm/RDNdQFuE9+8gyW23UVsD7c58F0KddAVI2m2whuY8NBbWbElwVS3s3Unj35x4iEhuPaYC0iu/hf9p0nesTzwihld6Sh0BGXy9Dj6DE7cgREMzun80gWwMNuzJlsUG3vC1k/MGKEd0QgaOFVQaehHy5/HwWjNzdUodp3BtXGvhlTteyVe8vEZaPl4y/+4oiKNz7CJPW0R7HjhUVTNfBzQZ1JqAp7UCk19d4dQpUWAHXp5AftKpN6K5QuvIyvysKjyNkmg3Px9/zPzjtKUHII2hmSyr/9omM4New05oXg2uw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQZV6DXglvF+U23BzePtiGc0FKpBMuAPNbSOWy2UM74=;
 b=kxl0BsN0LPYzov225g2HuHphtIZ8OjkpPBwOKtGOWXurxRKgfTNE7qgm58iaipglQiEMMi0wedwHOpBn6lJTf6X0hAYBR1md7goZOuKjclGrWMrV3040qYe/rI8o91JIF1QSuiPgaLgGMfEovFauoLfVzQeXwcSOxW7LBpNU2lk=
Received: from PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::32)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 23:38:27 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::31) by PH7P221CA0076.outlook.office365.com
 (2603:10b6:510:328::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 23:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 23:38:27 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 18:37:25 -0500
Date: Tue, 14 Apr 2026 18:37:00 -0500
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
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for
 KVM_SET_MEMORY_ATTRIBUTES2
Message-ID: <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1c4a6f-9fa0-4503-5b46-08de9a7eed4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|18002099003|56012099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	PbBhOMyNNmD5llc6UmW++rxqCagqLoVd9lhHyyhsLCKCLED7oe0NmHrqzbyBxrTnuRyHGfiYFx40k06a3WL0CRr/zBQ36Ea5g2CsC/fe+nV+Qz7rzGEk7uBOR57akzzy1kGCwZryK6077qi83U1Wfpjhp/M1kStIh5tu+5OLLkTyuIrC7C2rbieDtViFbJ580SzFAvT9VfJxecxpZFEQo5alDYJARb3D//kfhIF0IeeRc2ezyxgbF8hC9VrxIW7J3fiPcbcZIXpWypdyqqk26reEQEJW8+Sk4w6DgCQ3X6D8Y8EJzclwu/OlDnfDH8QWwGAz4tbZrgdtUZ5zcrcYtfpANb+wskKzH7iBGqQFqpKF3gwLo8yenFMJaZcCRVcUn5AnfV9QIYQUdKXoEuS2KrwgFo7EP5y7zjL8eMrnaUbLWxlPwb6TUgpMV/HNWFbnFkjvrZchRJ4PPSeQ/CiQCO8fYEaH6V0yGzA8H/3jaJaDg9XK3UJujd6t0lncrYWBuh7UHFm5EWzWom0S2ob7DtDrS+E6a28eUz6v1//aO9WYAzGqOCws/w9aTrzZkPOb0jUtJrzHbP6ULeB8SNQhr7IgBH1uve2AlqhyoGMvBGRviz1x/IxXdQj/NOJUvYZIksyBkKJv7NhVZV/ZiSRb20KQMpmah8yt/DYhvR3dlUl68/NW+m89JhAUJY1J1qmgX9RLKFpPiJFoN6jEuK3rwaM8tgKZSDkyKCch1CD5cGVNMgl6Xvub6K5F2NI7nlQn39TjQrDsPJRNf+6Qzd1NHEZugMg0GWqoD59wLivnHrA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(56012099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d9hGQy/bRYA2R7+0jF4qfJY6DLe7JA3LpOTCg/lzsMSZK9U3EBnTLnbkFB/hQGMFYtdTobJNHRSas9Q151SGzyZ1x+Eu8rss7hXk3M/OjWAGQzEVMvp0EXpBbnWOaxm2x9/RDzsEulBKh06befZZz7p98qGjiw87KtQ2dtxLbvEGFXuKIaJ8fKDTEzi8j0AkJ75Mv05GdSOnYHVHF6rxcFcNGEFr1sGa3+1dgolIolt4qWFqLx+RW4HKxLh+NOn39B2Ht2tkQaKRKQaBuameb3XDptCIQHePoqVcPv2OIun5b0Goh0QhCKDpWUJmhymMRv120YAEAjZGeo262ap+AtPT8UpO0fbPn51qxB8E6Qh8GbyBoo94rlCS9nLZ3ZSiCOnMGtKfWUVaZlw75I1hQ9PzA2FFOvGiz7J4lIXDXLTs4SGMRjq0hpz6dHFi4d/G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 23:38:27.0133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1c4a6f-9fa0-4503-5b46-08de9a7eed4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

On Wed, Apr 01, 2026 at 03:38:12PM -0700, Ackerley Tng wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> >
> > [...snip...]
> >
> >>  static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
> >>  {
> >> @@ -2635,6 +2625,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >>  		return -EINVAL;
> >>  	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> >>  		return -EINVAL;
> >> +	if (attrs->error_offset)
> >> +		return -EINVAL;
> >>  	for (i = 0; i < ARRAY_SIZE(attrs->reserved); i++) {
> >>  		if (attrs->reserved[i])
> >>  			return -EINVAL;
> >> @@ -4983,6 +4975,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >>  		return 1;
> >>  	case KVM_CAP_GUEST_MEMFD_FLAGS:
> >>  		return kvm_gmem_get_supported_flags(kvm);
> >> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
> >> +		if (vm_memory_attributes)
> >> +			return 0;
> >> +
> >> +		return kvm_supported_mem_attributes(kvm);
> >
> > Based on the discussion from the PUCK call this morning,
> 
> Thanks for copying the discussion here, I'll start attending PUCK to
> catch those discussions too :)
> 
> > it sounds like it
> > would be a good idea to limit kvm_supported_mem_attributes() to only
> > reporting KVM_MEMORY_ATTRIBUTE_PRIVATE if the underlying CoCo
> > implementation has all the necessary enablement to support in-place
> > conversion via guest_memfd. In the case of SNP, there is a
> > documentation/parameter check in snp_launch_update() that needs to be
> > relaxed in order for userspace to be able to pass in a NULL 'src'
> > parameter (since, for in-place conversion, it would be initialized in place
> > as shared memory prior to the call, since by the time kvm_gmem_poulate()
> > it will have been set to private and therefore cannot be faulted in via
> > GUP (and if it could, we'd be unecessarily copying the src back on top
> > of itself since src/dst are the same).
> 
> Could this be a separate thing? If I'm understanding you correctly, it's
> not strictly a requirement for snp_launch_update() to first support a
> NULL 'src' parameter before this series lands.

I think we are already sync'd up on this during PUCK, but for the benefit
of others: Sean pointed out that if we don't then we'll need to add yet
another capability so userspace can determine when it can actually do
in-place conversion for SNP.

Right now, this series effectively advertises in place conversion at the
point where KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES reports
'KVM_MEMORY_ATTRIBUTE_PRIVATE', so I slightly reworked the series to
include the snp_launch_update() change prior to that point in time in
the series. Thanks to prereqs and changes/requirements you've already
pulled in, it's just one additional patch now:

 KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE 

I also did some minor updates (prefixed with a "[squash]" tag) to advertise
the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVED flag so it can be used by
userspace for SNP/TDX in the kvm_gmem_populate() path as agreed upon
during PUCK.

The branch is here, with the patches moved to where I think they
should remain (or be squashed in for the [squash] ones):

  https://github.com/AMDESE/linux/commits/guest_memfd-inplace-conversion-v4-snp2/

I've also updated the QEMU patches to use the agreed-upon API flow and
pushed them here:

  https://github.com/AMDESE/qemu/commits/snp-inplace-for-v4-wip2/

To start an SNP guest with in-place conversion:

  qemu-system-x86 \
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1 \
  -object sev-snp-guest,id=sev0,...,convert-in-place=true \
  -object memory-backend-memfd,id=ram1,size=16G,share=true,reserve=false

To start an normal non-CoCo guest backed by guest_memfd with shared memory:

  qemu-system-x86 \
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1 \
  -object memory-backend-memfd,id=ram1,size=16G,share=true,reserve=false

Thanks,

Mike
