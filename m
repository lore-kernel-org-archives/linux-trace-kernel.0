Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59837F002;
	Tue,  7 Apr 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599784; cv=fail; b=XEDn1cp92lvWYaFA7Rb5eSGG+/84UTJCARHgQDI/IfnNyatxtG5+ABnDTr2cTdJidCGAR3CqZtD659D1Ia/5cWDlA6upmFn//vt9BaRLKJiiE0ZAXPKaicUU9lrM6vDgIxPxdIHebLWafYGSOQxmR1qYIH7FPFaU5xY0ALxNIZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599784; c=relaxed/simple;
	bh=hIbazfkvhKkMN7eK0sFTNpvvIz7zKMuWZfuEoetloqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv8RYbY+y9RdFk1kqqqlxAtHSlSSkKHIAhb9fwirjMi4DkQWnTQYDaYpK89Y1KBLtx2rPNaKOPurih68Y/NnEsp9tYUZZVNSo86kVp/l/DkcuTjMxKV35plya9AO7vmKMNy/6DkUnml7fo1e5xP+IlBrLVHucQwC/XZyo50vrW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z8sBslOR; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z8sBslOR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKscgOwy772QYrptJ7Q56qeoC/OoSk6L4ARUvcaLrZI4mPnxa9lGixXkfsfOrkRvqWr4kzUrj2UNyTp+DJdV1nJIbf4PlhH7qMLwqVa+7RYv6F2Ssz/yt+hiomqk8lEh7fwwD+GI3rqhT42X1sCT2IiguA9bwZHXydAl0bh8schjF5ug92lXzMJgU82e2MHenXga86UDuu9JEptxEEHCBMKYTTKmTInJkIRCuOhuuVdqx2GWYOq/ap14E+enaSZGkvhjRcFOppfwgMpktO2P7Ty1PwcTlUZqt7z4CUsgVZL6A0uEeID5xYW25Cnjg5N9F980XQnwQk6G+DdunT3Qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpwgURsGif++NwlmwmcFVsRDZj4yvtebz13zoDCSkF0=;
 b=UPIrvliZ6QIzKdh5ZzkJB0rXXqGi23ICIXj7WCZ/Ijbv1dup+j8RxQxyDot9+erimpFVr7j8I1AYcLW3ao+AHGcyYy/xwarhsZ5s5CYSXEjX7pz89aTIrqInpgzKYWSTS+66TVHOCxTJOO8XyzT48oj+LZ71aAUmR6/lav0Oz5HkbTkrssDTOL6RAWHaxdjLjWbpKyT/UdRh1dSqSiFRVllARmCCBXz8exsEBnnpgFCDzl1pmmCrrsuajxGeYLH6xUvlzWwvXxLIWElsWgxVv6bxIkmkeCBK6FRwnEiVPl+pdiSATQFQoI5Xk//V4B1j0hPkWU9zBlpKY+3OQ16zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpwgURsGif++NwlmwmcFVsRDZj4yvtebz13zoDCSkF0=;
 b=Z8sBslORORBQmKGw4CUGxISTEXXciCdIc4WqyYgw5bBazD0fFwaAHQQPQKOakk0NPREPBdSIsQgsMarTyVgQx1zx0NKs3mml2YnWCdl5cg6UguWkLS0ssn+92aoh9JwuzUGQxCHt2n4FWByh7Fr/gOBXHPz0leacpN9SI6vY3g4=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 22:09:35 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::db) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 22:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 22:09:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 17:09:33 -0500
Received: from localhost (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 15:09:33 -0700
Date: Tue, 7 Apr 2026 17:09:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, <aik@amd.com>,
	<andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ira.weiny@intel.com>,
	<jmattson@google.com>, <jthoughton@google.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <shivankg@amd.com>, <steven.price@arm.com>,
	<tabba@google.com>, <willy@infradead.org>, <wyihan@google.com>,
	<yan.y.zhao@intel.com>, <forkloop@google.com>, <pratyush@kernel.org>,
	<suzuki.poulose@arm.com>, <aneesh.kumar@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, "Kairui
 Song" <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for
 KVM_SET_MEMORY_ATTRIBUTES2
Message-ID: <nmy5polcxfnn3hoircsiqarxmzlulwwq7w34okanccntp32v56@h2eac44agovv>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
 <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
 <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
 <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: c805bb39-ec17-465d-7d67-08de94f25999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y7YGok+I3ne24oRYskjhQPCS/R2zq7pxofdIRXtkrsTnuByTuZumfRQwsvWOnMdldga1wUWQpWWHmAiiCLCn332M3d1uoOQ8eDrQdUaoIIJ7Knpi1Cf+mxj4uq4PCb8qBDEYBbHCFkvCUqfRUqcCHXnwKa1vW3eClCszf/a+z7kSgsEFxg7s1boP9ky/J3AR1y0syc6cciqBWLYcP+knLo2w3i3hFvcDCnFVMpFC66/CAl6l+FfJgY4Yxsx+BX2w7wZYyriTpSLRV8DoJ2HgLSJMTh0kKKp2HrAxH2r0rzGzZht8MilbDabOqWMzuFBr5YYDD7Z/ElNHKeGBUlUpp/jmunPOOZJjkbdTO8tDsWXKqQvNPQx3ZJFL9naWDZSW8UgEZGZn6LlbMNiDRYAMIhOQRM5DpGjVEQjtqRloAfC7l0MtR7d3LtGNcBicmMpKZhYJa/QUbEEXIalrm4c1uu0xmNu8/t+bz1Mv77FqBeXRHS7J9RRKl4xL4VHEFD4GMVnPF1iac7Y8TdvhtyZyfztM2yFUFzWfVhgxUiXf94lJI+o580Rf9ZW21T9+ZWjE//jbPh8NgfEHH48so9qznm2VeRThpBjX5eB4cQTKAZohLZ1LYChZAsQja0Y/9jghpAzQ2BQRsW8R+5zb48fTJJNZhKzzMThJE+raR6nPBuIy4R7qfnBnURft6EFSyB3Xi2+04x9up/hYD5zeD0AHfcTVS8Mtp94FLsVvPNHdoF8cROfscqry4FVmvNKOULxSVIGxQeP17rE6pI3yqzXt3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ds55EE6KOzPK9lpPKGcYt6rLreFqyZuoSQEk9wcvkpfAVjuPpds8Q5iuvNmtb0On04kfAZkGz27wYyLUjLYVze4eCufG3KJtmoWdTezqu0Utk2V6E3KZhHuIElwwc+PgqTrDQr57iDAU6mxQM1H5iot2CKwKGHukPGUYdfZIjMbdG7XFusRCbzAwM+CqELQB1w2H3v6nuHcOKAMaJdhIT3b0VcEBFNeGuE/PA9/ELMjulvAEjG8C+/t2Li1ueOPnD79vV5vOmAWbt4U/e0zf3J9O5+11dovnv6+k2zBf2FvHBP2138rZWxZdgPjhWAqbeerudb4/DqHXvNSZdFASAWzsKN4wadLFmReezmv/dVjjHwHPGoaDtl4UMReAuFd1kYVMOeMmAfDAc5e8M9AN2tLYJHkWNBVjlNYzrmjDZywPrcmAmpMrxsXSTGW/JKaf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 22:09:33.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c805bb39-ec17-465d-7d67-08de94f25999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

On Tue, Apr 07, 2026 at 02:50:58PM -0700, Vishal Annapurve wrote:
> On Tue, Apr 7, 2026 at 2:09 PM Michael Roth <michael.roth@amd.com> wrote:
> >
> > > TLDR:
> > >
> > > + Think of populate ioctls not as KVM touching memory, but platform
> > >   handling population.
> > > + KVM code (kvm_gmem_populate) still doesn't touch memory contents
> > > + post_populate is platform-specific code that handles loading into
> > >   private destination memory just to support legacy non-in-place
> > >   conversion.
> > > + Don't complicate populate ioctls by doing conversion just to support
> > >   legacy use-cases where platform-specific code has to do copying on
> > >   the host.
> >
> > That's a good point: these are only considerations in the context of
> > actually copying from src->dst, but with in-place conversion the
> > primary/more-performant approach will be for userspace to initial
> > directly. I.e. if we enforced that, then gmem could right ascertain that
> > it isn't even writing to private pages via these hooks and any
> > manipulation of that memory is purely on the part of the trusted entity
> > handling initial encryption/etc.
> >
> > I understand that we decided to keep the option of allowing separate
> > src/dst even with in-place conversion, but it doesn't seem worthwhile if
> > that necessarily means we need to glue population+conversion together in
> > 1 clumsy interface that needs to handle partial return/error responses to
> > userspace (or potentially get stuck forever in the conversion path).
> 
> I think ARM needs userspace to specify separate source and destination
> memory ranges for initial population as ARM doesn't support in-place
> memory encryption. [1]
> 
> [1] https://lore.kernel.org/kvm/20260318155413.793430-25-steven.price@arm.com/
> 
> >
> > So I agree with Ackerley's proposal (which I guess is the same as what's
> > in this series).
> >
> > However, 1 other alternative would be to do what was suggested on the
> > call, but require userspace to subsequently handle the shared->private
> > conversion. I think that would be workable too.
> 
> IIUC, Converting memory ranges to private after it essentially is
> treated as private by the KVM CC backend will expose the
> implementation to the same risk of userspace being able to access
> private memory and compromise host safety which guest_memfd was
> invented to address.

Doh, fair point. Doing conversion as part of the populate call would allow
us to use the filemap write-lock to avoid userspace being able to fault
in private (as tracked by trusted entity) pages before they are
transitioned to private (as tracked by KVM), so it's safer than having
userspace drive it.

But obviously I still think Ackerley's original proposal has more
upsides than the alternatives mentioned so far.

-Mike

> 
> >
> > One other benefit to Ackerley's/current approach however is that it allows
> > us to potentially keep hugepages intact in the populate path, since
> > prep'ing/encrypting everything while it's in a shared state means gmem will
> > split the hugepage and all the firmware/RMP/etc. data structures will only
> > be able to handle individual 4K pages. I still suspect doing things like
> > encoding the initial 2MB OVMF image as a single hugepage might yield
> > enough benefit to explore this (at some point). So there's some niceness
> > in knowing that Ackerley's approach would allow for that eventually and
> > not require a complete rethink on these same topics.
> >
> > Thanks,
> >
> > Mike
> >
> > >
> > > >>>
> > > >>> [...snip...]
> > > >>>
