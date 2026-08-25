Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C73AE6E9;
	Tue, 25 Aug 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683628; cv=fail; b=JXgOZfQEUf28bpyJ2Ua2eBhO2HvAJLR+etctvlN4TC4Udh1OyokFKpV5RwcJ5tS9DpIybs9dckk2b/Q/kdm7zPwXEpPVnkycRPvyDDnaiWpPBJFYpPfr9N6W8VeWeLS2JcSO3pEfEPkp03OjjYjYpaVMfTNp9j7ZiO96b1PCVzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683628; c=relaxed/simple;
	bh=mCQLagRMZL3/KwtL0e0SeRDPhObyOHHj9wLImSH2tCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOaos1bOeq7BpDDgbsvF4FIXVvK0r1uj4B+r1ekaiXwu8NULjQgJ++HBQXkqhEcx6H4JVLPSgMhri7jygpl4w6IyO0enchswcXdyCEBR+ygcIHW1wF8ym9IjNxbM4XWY8K24xxwUoekVeKeSOXmCvEZHSCnXqdr42ldGfp77/60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mxDaf1C2; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mxDaf1C2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG1fmq8ipHxiMUch0NlRgcnroWaq3nlnhOWs/9FFhFbwlCfeYRTKIBmrRNCPhQgJq0/a+w7nrcc42bcwv3yex9g3EosdoN3zca69Qi6WWePeakRVCYH8bzaOa3hdg1swPkS0JBwgR+z/Hk7T2upGdVHiWFHJkuoSePBeX6kjXk7eap+inokMCP1WNY4TpEIxMKOM41U8128/pCFUW4B6VimuwnOdrcrRnebFFimg3kyad+ltq4Jmh2A6JyBt/wOcQf/qvo4xTy39+GM/WyHdkLHqeG+GN2y7kE7ZBX0gxpsU8fHoulmBnXxQbPxNJq07ZmBrbGXd0mTmX80ZNtwfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twnTciSsy62EOXtZ4bUfR/0vvmTWRjqLV9h8tQ1xAp8=;
 b=Vbhtb5Ch5TD12I+gxQqZhOSf7RpIi3Of43lFpJwOGcJl03Fpe7mSpbZigdaWSotKwHwOFoQx3WQKGJdBKmuU70ZZK8GOjUJYHHO8JuwSZ45RH1wkERj7FE9I/YKLfDmbmOprBeur7Eh5HW/L4uAkQ1J5zI765A3UCXPH8idRcezgjBO1Q6PW1xerdML2pm0xwPMa+6YXlLR0q4G4p9dWLDLP4+8oN8a/Pfb3/uoer2MQRl3VQYyT/UGRZ0mlbX7dd6vMnRpEWiRDTGY3fmZisVD/2CBx9uuhpacFHNtdBLCIn/Sl8D3fBMc1nJtN+Nw1+abGlaO/sIH6ZhrImqmnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twnTciSsy62EOXtZ4bUfR/0vvmTWRjqLV9h8tQ1xAp8=;
 b=mxDaf1C2zzQMNfPRhuyVxYk1bOQ0TDw8gz5KMdnfKKisAzJTSHYx243A5Ob0B3CigU48P/Ji43IsubO78NZlL7XhwUOFoyvaL81l5VSny91ncierqCZEK7Qzoi5JVCD6O5Be1JTomDQaUaeeBlPwVbLPK19R+uMjhl9Y3PUtduc=
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 18:46:56 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::9d) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 18:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 18:46:56 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 13:46:54 -0500
Date: Tue, 25 Aug 2026 13:46:36 -0500
From: Michael Roth <michael.roth@amd.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Sean Christopherson <seanjc@google.com>, Ackerley Tng
	<ackerleytng@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>, <aik@amd.com>,
	<andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <jmattson@google.com>,
	<jthoughton@google.com>, <oupton@kernel.org>, <pankaj.gupta@amd.com>,
	<qperret@google.com>, <rick.p.edgecombe@intel.com>, <rientjes@google.com>,
	<shivankg@amd.com>, <steven.price@arm.com>, <tabba@google.com>,
	<willy@infradead.org>, <wyihan@google.com>, <yan.y.zhao@intel.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <aneesh.kumar@kernel.org>,
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
	<peterx@redhat.com>, <tarunsahu@google.com>, Vlastimil Babka
	<vbabka@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
Message-ID: <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org>
 <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com>
 <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f9c75d-1801-415a-576d-08df02d93ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4vF0dehcAdq99xXMo9LEZHPmjZu2EMp9ScyODm1e5fbmP2xZ4s6IZK+Wx/DP60N63ihJMZuMVkDRiO/Q6Agr9NoAMUq2Om/aJJNwtyS/roqG4LOUIX6RO0w1OozYKhseu2WUaXnlDHS5Wm7T17/tpvvWGAFQpq9eGNUtqWnwYx4wFbS96+zoJ5wdmUtYsG/xSj9tDKa5IMbv9nlwWGosUGi846q40OGtNhtB+2pDKNRLhoQwXliouFtoEqJRJjGZVPKTbF73zWCxMx9kjvQ8u1KM6ojxQoXXdol/6tUaJqyptq+VlCMowLzbGYbSyeyzo17QN+LZvRKnr9n1s7fxWEVZB4zFSzDK+tvNQKwXtW+zR0jhFRFZVBMGnabhbPd6SQn7GOsMQnUmYhqE+zgg8GDV1muVAHTLL01+tltoTiFrEpqGv27Tm845IZqz82sU9lNb35CIykSnSygIWYbx39MWixvznTnidSixK04/nTiS+WtXX7x8gfND1N3odhJKfzU5Rv9jgWxZpPhBFl7fpJ3nFOExIip48mzBgH6TbiE8SVf82oXHBg/9m8ouIxza0+un37ibwxz8WxGjNEhyxaMK13zd5+rJjfzxeBHgXSEyTgIwzk7uBhR6vX/9i5UyCRVyqc1Bg3AxXBYoKwFixF2DNe5yxv+AzBz6rsdJdx2/8vK7NZDo2DRQgj4RzToj4BjFRGkF9p3H93RmyR8Rug==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	49P3BRFYdeQ80SRUj5SruX+ouw7dbOtWbYAFruLiuBegSy9/mhXhB8gAJ8kQtf/k0Ymogm0iXcsoTsubbu02tfZj2ELAjnk3Sp1FhmtSev57ZPDaRWJwFRdWEEGpi5xN6v+O5qZa7QnkfZktuc7GO6Ia0rVOQQADWgpjbH0u5lXwHk+FzI9fEPG9JL1npx0fCAD5Kly4nHP1clWAqsCbg6ukiD3N1jaWPrtimJqf7jLULlm4x1t9FhyDOFfKcNZVCmNS2p3A2l5M2+jLBrm9LJ8veN16Rf03jJ3RpY1dBItIE6jJnVy2jEwO31d+zAf5rwBCq9KK+bnbsbFt+7phfC+xq4Batg0BfBF5ikRoGlGsxH8xOdsHtNOUkAA36O5a1Izp5N/kgau6IGbly1y+mMDh+BbNGUBonhBBY9A0Vih/r5w0U/nmuh0i/ghbSUYq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 18:46:56.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f9c75d-1801-415a-576d-08df02d93ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Wed, Aug 26, 2026 at 12:13:47AM +0800, Xiaoyao Li wrote:
> On 8/20/2026 9:32 AM, Sean Christopherson wrote:
> > And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
> > using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
> > PRIVATE mappings (of a different gmem instance).
> 
> I'm wondering now how this could happen.
> 
> the requirement for PUNCH_HOLE on gmem to trigger mapping invalidation is
> the gmem is bound with the memslot. But how can a memslot bound with two
> gmem instances?

I think this is for when userspace uses an mmap'able guest_memfd instance
to handle shared memory, and a 'normal' guest_memfd instance for private
memory. Each instance is bound to the same memslot/GPA range, and
KVM_SET_MEMORY_ATTRIBUTES handles switching between the 2.

-Mike
