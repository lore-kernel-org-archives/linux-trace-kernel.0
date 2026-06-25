Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6339BFE6;
	Thu, 25 Jun 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385048; cv=fail; b=t9RM5DW4MRZ0qB4yWxA42hLc+WBL0EWwQfcYtR4LA0+7ybzycNNQZZveVYk/KzmZP37EP/uxOVnsuojid8FGhdJfbQ/szIqaVj0SLPUC/E4L+k1hVBCWyRCv0Q0EN0mulBc+2I8LphwYsOH20qUBA08FV+c2MTXBNY8alU0AlTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385048; c=relaxed/simple;
	bh=iGbAkbxCzJBGafSfgZoovlG7DJfYg6hRnOWkKqPwC8Y=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qiCC6UXo8APsk5/U7QEe4kgEZSMHGKmgLp+GfAuaC8CyIOQyHF02SuLeJztqEFOsDPNlRrNNB7xXiKvSr/tUBjYvIDBkd/r+sAzM5YMnympwdb8xMftkPYwt8PJQ8N4y6R2DZqAzri1T3yv7SWphAh5FbPbVmPdFAtaS4WV7Fu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZeLdhOf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZeLdhOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782385037; x=1813921037;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=iGbAkbxCzJBGafSfgZoovlG7DJfYg6hRnOWkKqPwC8Y=;
  b=HZeLdhOflazvS3q0tfOz//kKPNrgXyKberVxLJMNH+tTiI/Sgdrj1qE6
   LkWcOWuEfJMpjiMnGuFyzQF5GGTa0NMLUFJ3fHlW7KYZPfTpy7gIHjvez
   udYHFKgkEUczsDX0tUg4yP9J/Xtt/STxB4W1MJd5sbsmcc6KdwXn/1FgJ
   1pIqxRCRMmOxkRgdaR3twtC55Xf7UW5+NgpaEymFMQwvw3V5nhoxbUO39
   tTJz8cV7jp2IiUyaQpt5D6FSKGiUEuGFMAen7h/aoCsViU41xVT5Xm2uu
   rCa/BxMwH+//SQlRAcMoXh7V7VfhV4+7veK8r3ISpuLtM9YL+GgU+D7k1
   g==;
X-CSE-ConnectionGUID: welEnYQNRk6VxS0KWvNm3Q==
X-CSE-MsgGUID: Nu9+4XAwT1yGBY2sO0lNXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="70670118"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="70670118"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:57:14 -0700
X-CSE-ConnectionGUID: MARXhMBZRVaREccIo5SIwQ==
X-CSE-MsgGUID: NxyjzuQPR6eWLlnqD5TMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="255502498"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:57:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:57:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:57:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqJAxFJ8SZTQpDKcMlmXotIH+GmOIaz1tGwjV6KtbVHn5AVrl03Eb0DAB1PU8ltmUcQGofk/y+NKiYs1PA1Z3Apt6Iqj11NGaH1Nzb9u22jA5wQP8VXkPDe67EsLeKfJd2j2WbNmRVnUhm4wNvdgQY+SXhcwuSJ7bEG9zFvo6L6ZaDPYZykJFojDO8WCv9cO7bl/S+Vd9AJ57hvxxdo0K0TyZXH2Wqk69Uh1zX1/HFCsv5melRZDQDfbSPgNj0b8nABA6jDaPI/RS4QZPqmGLiTxB7IkfNJxsBSgQUax3eJKsdLCElDsFMC6kLCPKI11SAOvvhgrJ2Wp/+Pt+WsMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFLOWfvbaCySULf+iRiOxhVKWbU9llNmCf4Z+snew+s=;
 b=Fkz8XNDLk/YkpuRpxHdtxfz+UdXcLfHzwROaYnopw4b2FLW5+SRV/ujYhAAztQnCvPrTfkekk+HI0ace21nvfvikcbKjiEzBXGoIoVZjWBQp3m/QiBz6pIP4oHGWRk9aOpznrtkNa0KaASTBXavjZg+OLyLIQVpmq/e1PMyg+ZU5BcTUSPQk4sjw5MgjHPT0LU+9FwbwLoE5rzgg0Bnh+VJjZUb7c2R1et7DGQmzrAJhz+ZkEw8vNzb6PJEcBq8+v3KHcvxUny15fgJMnscEmg5oi/dofN4eI9N0JnURUHCrnH8/3jPa6+3soaH/PdLOFsXUaxSEZ8FWssupgG+Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 10:57:09 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 10:57:08 +0000
Date: Thu, 25 Jun 2026 18:57:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>, Ackerley Tng
	<ackerleytng@google.com>, <aik@amd.com>, <andrew.jones@linux.dev>,
	<binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <jmattson@google.com>,
	<jthoughton@google.com>, <michael.roth@amd.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <shivankg@amd.com>, <steven.price@arm.com>,
	<tabba@google.com>, <willy@infradead.org>, <wyihan@google.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <suzuki.poulose@arm.com>,
	<aneesh.kumar@kernel.org>, <liam@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau
	<kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default
Message-ID: <aj0Jf30PS2f7x1nt@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com>
 <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
 <ajx5Vrz9ma--hrGH@google.com>
 <ajyJhZcgfYFtGfS2@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajyJhZcgfYFtGfS2@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW3PR11MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: aa957d38-60a0-464d-e8f2-08ded2a88087
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TfvcWT/8EzoEt64Bm702iujOuBpJBnYrE/KKD3O067gBFLpV6JZmooukODUVVxmEkXInOU4k09kkdnkYkvE6YPK36GFTnroUtHiQbRhBs+Zct6G9tNKSE6rF8lurT8xeWf/HCp8JnPa8N74+02wxSB+Np1BfRYRKxY6Nd1kN4FP3PLY2fJwJsOncd6FGWYlOvED5sGHkQh8O0pB+mr3bIO15aXWjOBlequrGpqU22dd8TROM+YshlxqAoVNVgx6F1lJ28GFECfoGdvKDDYuRR3x8WDYaXDYplcKEyFWFNGCM/YSqIuP0SUeJYekEqD84yo4z/Xx4hqBHoCeZD3jadVLfMHOoFLbCY9SU8aYYRwGe17uk5K4Bvx6PU61j99ZmMdVfu5GNaOahxHWNqLpSEdd2uEKnB133sWXY3HVpoQWiUA7ev4Vg1VCErPbmK61DTwbYjZyRraY8cwNQ/+ZbZBeTr4jKTz2OkeTEDO1Kecdn6DHW/19g8EuVpjrkAamg85vb5OlaBxYEEYGZ5zYNAlWxvdqzbZD6XmiUK7fzqO5LQx0LbPoIE1sN/8mZLYZ7EIW4ad9iW+YkdUyo3cDzTErji/4IAjUi1F02UHIxvK01YHM3EmsLgOAal9YO1krG6OCoHYG5kByZCHnlHCpKwy+7WxWxslEYwjY7Fs1yTvIs05nvYHUsRzY/EmSNJdlCVMpJdAEd2qBP0OIcClbnEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?66uR7vdaym8uSD3uotezzFaJqinGKOLtH2UsN6vX+RLoBDqWRzu5h+/oQftn?=
 =?us-ascii?Q?HCP8RjN6hQf+FHv70jwhcx0FVxVq7aNA9c3EGL8YQhMmNfkr9DUn+TcxM1T6?=
 =?us-ascii?Q?JUQz5FW63MZUNzP61TOkycQHr2RGhiUdbGBegN3S/7krkGswo/WGqEZQc9Mq?=
 =?us-ascii?Q?QyHP1+xOEEkz/d9s1XdgcaC3hjGpeTg0ZqE0O3tGNomxe/+yniL7lB5lHkOq?=
 =?us-ascii?Q?y/+dyWUY8q/9X4e4g1d9OnpVizrd1Z/y3yEJqcN1VTQdHi7V49jE3XDsSmz5?=
 =?us-ascii?Q?xEAYSnOo+rvTpo7dMe6QwqhRlZhrh87gbLviP6N2n7eR+yCFtjZcs1SeywvB?=
 =?us-ascii?Q?OR95bNvJKIB+U7v84/n7fkN4Ao5K43/i7DyzbdKcjo6XsYdglVDbOluMS7Px?=
 =?us-ascii?Q?RsTy1dYN3YocXvDcxW+fqx8lB3kIy2u9O/IPeXg60zDYdwdWa0rVEsgmlIqv?=
 =?us-ascii?Q?GK+3EKfTHz4bXYQmHqqHgLMyI2SbxQyXJaorNfoWvhulUyxY0wD6Da7AM0zp?=
 =?us-ascii?Q?6y6MPOyu+51jw/WQh6Hf/L3NZEzTCbdtJNNS8pjJK2i8uHiZQx1oANab90t8?=
 =?us-ascii?Q?eN3Ou/d55sF14xR5Oz6ALbhKkosRAIED5qw3F/ND2gnh0eXCpeR38ijezc67?=
 =?us-ascii?Q?wkwQnilGSuLKfUhENlOitdl9B0nnllxnEEzNFT5IjNkJBx19yo7FyGBctznQ?=
 =?us-ascii?Q?acCFK3QMr/vOGOeWL6W5qVFibutG1j1B0jqdkYLNulCUuT8OB+mFTbHO9mYz?=
 =?us-ascii?Q?RboLLOnUo2j9WuBruqIejSUXLcJCpvLt3Bme5HWmHXfDbxSdHqwFUVxZ7YAD?=
 =?us-ascii?Q?MUh4YI/KzcAVtO7PCg1aLm7Sp5Ir0fCrQYC9bwb5l/1gIUBSFNx+/0Eb44Oi?=
 =?us-ascii?Q?dnr9wH/oanZOe2+tYW43JZGR9++CFrWG8I1fRtpOPwezBza2JTKDQcGYnPFq?=
 =?us-ascii?Q?PnYqqKJQ6qAyLJ4UJpN7f1zBwTZtcYUrZ1p9XgT0yOQ8EqAxJnnERJXheFnd?=
 =?us-ascii?Q?OqQN4LLdcluzoiNTKoNy98PGmER+epduFFV9fgSbSulv3a2MDResroaFeQnS?=
 =?us-ascii?Q?Q2YnpxRMmOo0MQZiMzcoz08645f77O2TqnW0AVQTKm4iALoYUBPXtRT155S4?=
 =?us-ascii?Q?Odi1LM3My6egnBj58LAK5UmocpDdedeTGHdLcVxxq5/hcKtMQqbJyKudBLfs?=
 =?us-ascii?Q?dd4H3V1W+xrPXTZNXvg8f0G/nOYqcmDYLlbjvuzcLtKCwYUSBfPb8F1HIkdl?=
 =?us-ascii?Q?uGSFCXQ45ulJyXdoOh7CPttTN62GvXGk9cv+Vqn8Y3pc0yOiVJXI3zaljA1U?=
 =?us-ascii?Q?rccCAhJscWYAnnHWac7KpgoAansbXT9OpA3BNCyVwKewQKf8F9kVe+eZm2ZA?=
 =?us-ascii?Q?Le8wzVZKUyqRdfXc0WRAfjxk9oe5gZqxDdyGpxL4B6Wj93yUtGNX5+Xxk7ak?=
 =?us-ascii?Q?KsLmwj4WVQ3S7yh0tfPTI3dS/BAUQ6uBfkaHocHhGQ0JUIthI8LQCzBO0Fuk?=
 =?us-ascii?Q?CA4eKXhMXwKiCCkOm5lvxzCT6E1Yct7StiN6XBxAXG3IMg/Y2Ee+aRDgRwqF?=
 =?us-ascii?Q?25NQLZ37s6YuRskPPBZe6t0AduhN4cXjaHw8OcBPmN9pnUmI7ztweRpNB/8C?=
 =?us-ascii?Q?WwhrVoEy1Ku+VUwbp4Yq/B1KDaqKviE0POJCrhoekEGxORi7NXgOYdN5+A7P?=
 =?us-ascii?Q?XZ3hI/8ljoDOKSZ31SVwYViWSIrWdQd/Nwr5Ib1S6FMp8a/CdZqcgdPQNcZ2?=
 =?us-ascii?Q?vKwBuyky1g=3D=3D?=
X-Exchange-RoutingPolicyChecked: RWV/m08GyNBW1UAbsNCHLkNCVqKhSQ5nR3qYHoaqzsr2CkpmO55jNYxsi0cU5Shi6F3Q2ezEH5PgclpOTBGUeXeB+ulcMRL/sqk2voQwQXGt+hjhJHdDhvprjl/LNUkJGDih1hUZkGNkajp7cSu0Z3k//zYqEv5L/TEvwsQAJ2UKiKhkNPNDFYn+3CI5tJAJcdP0ytKlcrKmqzTDbcnZmlk8f4hHrULtPepYxvtr2xsfJv4YF+7QUHNEGT6mU/VphENPeEzfWPpRf9QAlGhGUZg9U9IvEXd/7h58Gm+ImVc9G2Yivs3afIHM4dyEyt7BVDMwBVrmhFfPVZOYNfSCXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa957d38-60a0-464d-e8f2-08ded2a88087
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:08.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2/o5zzBFqbOrQKSaeZzvtZIvwXBXG5n4Sl0cwd0RtDLG3J39zwdqMJ8ju4g6EZ8BnTsVKDf5BIFFph9o1cnjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 09:51:01AM +0800, Yan Zhao wrote:
> On Wed, Jun 24, 2026 at 05:41:58PM -0700, Sean Christopherson wrote:
> > On Wed, Jun 24, 2026, Ackerley Tng wrote:
> > > Yan Zhao <yan.y.zhao@intel.com> writes:
> > > > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
> > > > MMAP flag. In such cases, shared memory is allocated from different backends.
> > > > This means this module parameter only enables per-gmem memory attribute and does
> > > > not guarantee that gmem in-place conversion will actually occur.
> > 
> > KVM module params are pretty much always about what KVM supports, not what is
> > guaranteed to happen.
> > 
> >   - enable_mmio_caching doesn't guarantee there will actually be MMIO SPTEs,
> >     because maybe the guest never accesses emulated MMIO.
> >   - enable_pmu doesn't guarantee VMs will get a PMU, because userspace may elect
> >     not to advertise one.
> >   - and so on and so forth...
> > 
> > Yes, there's a small mental jump to get from "KVM supports in-place conversion"
> > to "I need to set memory attributes on the guest_memfd instance, not the VM",
> > but I don't see that as a big hurdle, certainly not in the long term.  And once
> > the VMM code is written, I really do think most people are going to care about
> > whether or not KVM supports in-place conversion, not where PRIVATE is tracked.
> Sorry, I just saw this mail after posting my reply in [1].
> 
> I'm ok with gmem_in_place_conversion=true just means KVM supports in-place
> conversion, while we can still create VMs with shared memory not from gmem.
Or what about "allow_gmem_in_place_conversion" ?


> Though it still feels a bit odd to require TDX huge pages to depend on
> gmem_in_place_conversion=true when shared memory is not currently allocated from
> gmem, it should become more natural over time once gmem supports in-place
> conversions for huge page.
> 
> [1] https://lore.kernel.org/all/ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com
> 
> 
> > > > To avoid confusion, could we rename this module parameter to something more
> > > > accurate, such as gmem_memory_attribute?
> > > 
> > > I asked Sean about this after getting some fixes off list. Sean said
> > > gmem_in_place_conversion is named for a host admin to use, and something
> > > like gmem_memory_attributes is too much implementation details for the
> > > admin.
> > > 
> > > Sean, would you reconsider since Yan also asked? If the admin compiled
> > > the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
> > > admin would also be able to use a param like gmem_memory_attributes?
> > 
> > No, because it's not all memory attributes, it's very specifically the PRIVATE
> > attribute that will get moved to guest_memfd.  I don't want to pick a name that
> > will become stale and confusing when RWX attributes come along.  The RWX bits
> > will be per-VM, while PRIVATE will be per-guest_memfd.
