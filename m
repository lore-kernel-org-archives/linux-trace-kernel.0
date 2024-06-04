Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67E147C90;
	Tue,  4 Jun 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517112; cv=fail; b=mQyXQ/ufni7FyT37h4aFkB1XZ5cs/cvo1PJT+Z3bezzfNsaBoacDzJtUaBhfI6PuPGSomxN4oJn33vPEHpFmOrrRix2+1Am6AJHIBXdkg3p/VG+cM98R5nNqEXJtn4lDcFkIEmebcHdgxXKwmEbixDQPGYp0O8kRWIkLMuaKnF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517112; c=relaxed/simple;
	bh=Gxh7XxsI4nF/xnm5pBoKyStNfcmjkLGsPWVrnGE7ptc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSR424iVgW06VTKICxfQkWFDd8BL9JKLL8EZePb3GtCjgpwon/lrKLspDP/8zedoV8mz81tofO50xaKe+RuHxtyBO7lhDmF+F4AbjTnK33fvSbczuLXaxqdbBhlHScredkab0VZ5hEW6NGbkOOvw4h5tt+YfVnMR4qs43Am/fj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXwTyxx2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXwTyxx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717517111; x=1749053111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gxh7XxsI4nF/xnm5pBoKyStNfcmjkLGsPWVrnGE7ptc=;
  b=GXwTyxx2a4edUs0fov72b6x6IhxRL1BnleJzAdGghvbjPZMJpvRbul/3
   Yjzda5f0sryvWg94Vh0cbd8v4wHh6uu/4A38fjvb7ePkgyW7TiWYh1/ew
   FHkVVmlJzDERt5XyoUEg0CGvNqQUhi2cJN9lib6QNFPBdaG8W8sJo61xr
   Ufwvcr6YOu8bG2sUv14RV5rFSsUNhpCKCzUBbUk6IUnieHS/R6tqk92N2
   NAW8UGwd5X2qCKflyAWX6Ea2cnocFm8SC0+kgzEF51C/G6Y+WXrWAWyvu
   +B/+OxTUJny+n+IXq5FxF8s6x2S5IfCwosfwnom1c7pWrIjPK5z7BuK3e
   Q==;
X-CSE-ConnectionGUID: 2HOD5M94QA6kbauWj3bAtQ==
X-CSE-MsgGUID: 5ZmdWuP9QiKM3/iKni1ukA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25189951"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="25189951"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:05:08 -0700
X-CSE-ConnectionGUID: zWq0NlTxRveOnYp/2MDcmw==
X-CSE-MsgGUID: evv7mJQNS+6OuEv2Plrxcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42397203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 09:05:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 09:05:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 09:05:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 09:05:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 09:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG9LKGpyv1TRudnoD62LfgCtc4uDEwX6G/xdCTm3SN0iDezlNNziACF+peOMTSg/XThuUz0JI6bKs8aH0KMg+j7ssZfmV+OjtW8fNzt5Ap1R8UsxU9qK2n29jkN+/rfVlPzNntg8RAHTX0OYE07FDvEE3DZc/9ewb1bfyvW7gIbCqFFg+jS2sEzyyllKFFZtWOGom6KBgsZ/h6zrLdDGGqaxezew2uIqRAxw6JE7c4qkdJgt74Ki+862OxsdklPLeGH5GkTnWG08tZFrpwHssjXMRQ7ydpYmwUVGFuzCyCN3TYUb4J/6+trpew8PwKGkbcyyYRP0zt8dpN4YUhJRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxh7XxsI4nF/xnm5pBoKyStNfcmjkLGsPWVrnGE7ptc=;
 b=eGZJE0ogr3btvlXI4r1tODaAORTB4s3GXB3apRcMDN/fu5PTieuJHLsNdNfLT25XBsXLqJskxTNxsuAZw2s51931fJsdak1pgc7xSXCcoRWko2tb8ExVM7QEj1ABqBb2pKvz/4OeFFUU/bX54JgB7vsXoCdyDtJtHStySq7NdPenn7taqm4nWi9g41BBAiI6HISAiDDMvgUfA9cSba3XsZbieVgRH1Fk13dsBYOpQqebc40S/BAhwCGfbVSPzBoNQherDYrMqWs9eXoZBAZMJ7AkbKZcUZOZsvOoysi5cUlFUsayeJqxi++9UiPr9oJAfOn2YZZUaYpH95VmCMmRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Tue, 4 Jun 2024 16:05:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 16:05:04 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Kees Cook <keescook@chromium.org>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Ross
 Zwisler" <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
	"Vineeth Remanan Pillai" <vineeth@bitbyteword.org>, Joel Fernandes
	<joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>, "Linus
 Torvalds" <torvalds@linuxfoundation.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mike Rapoport
	<rppt@kernel.org>
Subject: RE: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Thread-Topic: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Thread-Index: AQHatg66UtKkQZOCdkSWurZarbYoMLG3HdcAgABVFgCAAFHiMA==
Date: Tue, 4 Jun 2024 16:05:04 +0000
Message-ID: <SJ1PR11MB60836B1DBD5C41BF22A66430FCF82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240603233330.801075898@goodmis.org>
	<20240603233631.452433539@goodmis.org>
	<CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
 <20240604070826.030c5202@gandalf.local.home>
In-Reply-To: <20240604070826.030c5202@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6454:EE_
x-ms-office365-filtering-correlation-id: e8c7cb3a-d79f-4a96-2df8-08dc84b01897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?MZ7mKIfE9Wx3Qd4X7jA0yVPB1SCQpTx7X0weOnxF4dwDtlJJnoAXgKG8wQwp?=
 =?us-ascii?Q?I9I84+BVsa1uaYcx5axvnelDgFaRgi4BrlaruNrcUrG1oHKP/O4b1/sy5m2u?=
 =?us-ascii?Q?W/ZZmSXxi5mHGDtoS9nOYRhDz9Kpr2lYl4ZhjLMkDg9PO/c9WUap6vGNktE3?=
 =?us-ascii?Q?tI6yhlG3NGc1Ilhes08/3iz3wIx4JU7E4mhRrvy4aivlhuoEP1U7iBtGO450?=
 =?us-ascii?Q?uZpd+IU1LAoiSDVq3n4TwmBTxMBnNPPDW1csuaY3ROBeFuovFTyaJNB88/XP?=
 =?us-ascii?Q?13qCbufXCVM4fLvYljJvDaA3Xp0msmrQZcK+1SSKCEHX0sILNWDGlJSP+5Is?=
 =?us-ascii?Q?l3qVFzJq0zovKawRacBnwAMXJmPAMaajW3ecEsiW2L/++Ym6LhQPwfyPOiKf?=
 =?us-ascii?Q?0tZsdhh6Nxp7TbsDWkWW7mVtI2ujEFGSpBQjvC3xQHnHn7bTWaTgdTiMBMGO?=
 =?us-ascii?Q?G8m27AZ91eK/awQCbadb1mC+EMpLxkFTXdkSGOYryxmUvr6AvLytJ6HCqE7c?=
 =?us-ascii?Q?MTqdPw0A7FFxN+/Dq3SykC5T6MwattGxchXx+RTwa9SA4Y5vE20ylgHfPvDH?=
 =?us-ascii?Q?0DXUDS0oWFkNRog5DddfgQDURaEw76JtW9jvbBRhQCNRwrPGZ2w6nJLTffLq?=
 =?us-ascii?Q?rKtKKlYQToZD70xQ76pnCaNHKaThV86Dr9C2sL7V1dfOzb51EocZ4F91x9Bl?=
 =?us-ascii?Q?hHS40fSQE9s+RcQnbSloSqBK8CirS51ln3I05XIaGyYWVQ7vcXh+VMoJO4I/?=
 =?us-ascii?Q?hsRtpyYMwLdiWcfabPh22WngONmyO8WOR3BAsbssmo8f9cAwDyrKPv+fSeSB?=
 =?us-ascii?Q?6uMe8pHpf3ryDaWiOnOlTcf2I/Le1TSLVQoCjyU3T0gEbWN7OwdeUAaJ52bZ?=
 =?us-ascii?Q?vB8pBiDJrUV6NtlT1q5yd97gOwUB2/tvR4jAxofzKNjt6HXZHImzue0HC7+Y?=
 =?us-ascii?Q?y5DKHQkd8UChAQmZMXdLIXmkfHGLWe/G0m3o2u6YT0s2Nkqf/c/jNaZWNmyU?=
 =?us-ascii?Q?MTPT7TrWqscQRiDbm0pgwR0caOaopR92iv0pLbOtCyubO3FBw668V5JzH0zl?=
 =?us-ascii?Q?eoG2dhAjpLJRzBQiVeNfHVUccd7z9mDbWt7s6Ry0CaruHIlxLDNd6nYY1q9U?=
 =?us-ascii?Q?GMCLfg4Jl/twHxYBf6Zi9RN2rnOK6VAyQpTJBac8y3H8dJMoaPlbqfuv55Ks?=
 =?us-ascii?Q?ZsrNTw+b77Qa9OCUll/WABZ08aWh1Fwg2ASRoLNMYzThSehnak5l2XVgQ8vO?=
 =?us-ascii?Q?8CkAX8MYMFfgEcXdPmP7UACj+yq8uT0svL4IQLK3kmgXoCTc9+tALLdHQLf9?=
 =?us-ascii?Q?/e/jYeYbbewDvnoMwDe9TC+E3cFxENkT4CRF7lY+VtfCzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJe0hwFMyqTQKchk4rfX2/djQpVHC8WWhSKPk3Piao6VzcKeNjGpiRWjBr5Y?=
 =?us-ascii?Q?SzfHiHs0grZa6x+0uObAalVw5XVYq/fjuhQHz1vh5jTmheR0vZyL/qS+2bQg?=
 =?us-ascii?Q?Y+L0N0mlyD32Ga3LmDjUd1s/WXMLxocGcRYnZp++m9UBXeCu+vxbxKRN/LFJ?=
 =?us-ascii?Q?vZY3F6WWARzQTEqwpidsRHKzK1ySy8zkflhzSpSKgU33q3ZyNPPIaQoMhIN1?=
 =?us-ascii?Q?MreJ5RJo/uH/N+LhxdV0aoFHG3I9fo2h9Kglc84273q/4a6PQ9FAOdFCGP+m?=
 =?us-ascii?Q?nExEMFk7BV8X88qq6ikSnZbwryA/g9HcVM8/bEN0OsWCN//vqNetBxB8lolm?=
 =?us-ascii?Q?EjZc/gbgsH9eLm4r7mi3Yude/hsHXN1iMLZR/z2RHqPvosLJcrg8qbPSBCuZ?=
 =?us-ascii?Q?aiOsAsHENEA3Rt8afBrAPbjLUvyYXAcn1yOGMCKqeT7ZgMbXZrz2ztwEg10d?=
 =?us-ascii?Q?hILZCpiifPkTc0lTUlCoH6eZ1dpH7L3i+D0gvYp5P8jXwlTaSokixcGFWLcq?=
 =?us-ascii?Q?y1UgVVgVc8Z/wtbT9OEl1ZsV7P0mCiK9TSGdpGZ5P1ol+XXaxgyfz9hvquRn?=
 =?us-ascii?Q?j2nVi+DEZQ4NwZMIUpRDN1LRIgig5/1gPwhPvb5y38GKblEoqUOhO4zfup/J?=
 =?us-ascii?Q?lcOhhte9fFosYkpejMDewt3rzBPIljzLbKzo/mKJLr8LNfAx/S+mBnZtj6Ek?=
 =?us-ascii?Q?9V37rDA9Gn1NkzNhBQGTB0N8u22y7L0DrKU1CeszAnplpqwdZPDESXLaHEB3?=
 =?us-ascii?Q?8hwBPAPz8oMe8ZJUqtj36p2eV0f62wZk3ukBuShr4zlaPs2vmjOS4cLbTP6c?=
 =?us-ascii?Q?KxolzoKIQmEjNwPpb/uurV9d3VhF7oEY9OlQntlM7REMUdCjhF+7MFMAMtmZ?=
 =?us-ascii?Q?7xUr+7YVaPP3Xe3kpZwuySZM1k46kfjm8t3sTXPVvpl9hd9srbenXId6hI0B?=
 =?us-ascii?Q?N0S8Kv/6ItRBL7Cf1LQTFMxZ2/mNTa6lb7QCP5Mn9XzMRLDWlAh8MwdybL4w?=
 =?us-ascii?Q?RC8TfplycH9wGCtF7BrskRVPA0TL8hohwdizE9pHq954hyycBDWtXgON4JOb?=
 =?us-ascii?Q?xaEwSQsAInABMvV8d9XoayQ9X2FV74HfWfSeVE5qs8Xzgmvns+GE/6QrCEVf?=
 =?us-ascii?Q?7deefjdpYLswwIhCT5Th4ByxScJTmkalGItOT55T1/96OZSdpeJCycSvXEPD?=
 =?us-ascii?Q?YyKgZmxlJCNIdSanPn+S6eu5P6IJakV5nvonuKd2sjdltnLUJsdM/vhdO2Rc?=
 =?us-ascii?Q?mLhpTfovFY9go38J++zXTDfJAif0evXeFKZMuO4QolSnMxldITQcMoC4a3gT?=
 =?us-ascii?Q?SylceOF+RWc2tlrXL8iswF/rmwGRXPVmVd/ieNoHMFuaZkzOmZEstWsPsCFt?=
 =?us-ascii?Q?Z/FgwWy/YAR2RxaaSzDWhHwvzEDk6jr79ServHSIl9dnQN8HRuxTrQsQjOrO?=
 =?us-ascii?Q?Yi9SwNID4BCwDFiwPwkvB5plzKTE7FGquUUXqh3i/GbESCkS9U/fn5NqoX4s?=
 =?us-ascii?Q?ZIopyxA3NzboCiHPUZWJgxgZFIZxY5G0PAbk3B5umvQS5BOiT7S368Kjdl6s?=
 =?us-ascii?Q?TDbace7RiAwwFGa5WsgwZRrp6QrAP2wum7QgwPUD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c7cb3a-d79f-4a96-2df8-08dc84b01897
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 16:05:04.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLvPUhzyE46WhlRgcieK9j8/ACRhCrSZbIevEhJ+tCuJ0I9Yhlq6Rc6ec+JDwxHDO5TtWm97djn+7XA6N1dyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

> I have been using this on two different test machines, as well as a
> chromebook, and it appears to work on all ofthem. As well as for VMs. I
> plan on adding this to my workstation and server too (they use EFI).

I think that BIOS on Intel servers with ECC memory will stomp on all
memory (to ensure that ECC bits are all set to good values). There
might be a "fast boot" BIOS option to skip this (but using it leaves you
vulnerable after a crash due to ECC fail to hit the same error again).

-Tony
