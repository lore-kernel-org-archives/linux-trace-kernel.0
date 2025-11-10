Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6101339A4;
	Mon, 10 Nov 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783700; cv=fail; b=Cha0zN1nVgiuruWWodib7aaByd5tqW/zx96DvuaJO6Zn9mbr8FWsa/n7U64IBeXeJ7P087EJffLyrW/8WBOYWmGxEy1Kl8nGUjCkFP1H6sMDvQF1oWlCsTItZKqSBAfUKrlKDEcVRfvh8E9EuQwmULU/lr/qjW3lUC3d9AR1e/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783700; c=relaxed/simple;
	bh=BwAxXgqZnMg/XQesuZ8Sw79i6oRng0YVSf8w3Q0QIF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tCrzuZUazngWCuLwZT/imY4V5CeQ+GLjeizJZp5a4CNiAnSjO65vOWgPLWjXT29U72C8RWfH8Lq9JAXuNyEKz3VJJVjKDt2Tjy7FIA/n9j6B1WqttMT4tTgbdQJv+63vZ4Syp0BxWyBuQjXUZb6XTNHpSwmbj9W+Nk8Jxf89exA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onYh5bg+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IxgsWFXC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onYh5bg+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IxgsWFXC"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADawSZ021487;
	Mon, 10 Nov 2025 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=59TC0qwGSoevDdy4jR
	Bm554TDNc/Q9WZgL7fOjv6POY=; b=onYh5bg+HLimtg+YHudk5HdQDSumEm+29Q
	jZab8DHA8y3jFdzgeL6Ym/W6qxO5jz6dB4o7+ZYdZC6+MyDsG4Z8zaeOmKgjLFRv
	bi2HkHBsnnezL50RjSlNSNKiYQQnr5lTys+p8QL6IJzof3tsNHfuMdeL7kcuIgXh
	0vtprZ0jc3apbe8IW5oCCaCwBI/LITVtuNHRSOLS0SQOXqzNplUcfFWsiUDoWQgC
	OTY2h4kXSVoOwytwz2anQvcKp6QviJCjM8PXvA6MAppgOo/nGAKnPPJI0Vd1MLB3
	aTMrAO+bHV0lAkdhhX1kfPvJqmsBf5r2/gEVfflpGvmnA13+7Unw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abfp7g83u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 14:05:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AACfSNQ040076;
	Mon, 10 Nov 2025 14:05:45 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va86jum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 14:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtY2DpnKR7nXDVx5tIrc8is4xACtPgIgshA5hGZnomO14UBEgY9RSVFwsY4UWWPOXdrIqKJAx9eytJYj0XMwbO2XzO1FFuaAMnuPQWKVY+VH4c+c0rq93PBTmmgxmxbFcjdphtFz8ZKFZ1/ni3d/w81GlSWjmjTVYFnMGm8DQepUUtk7lE2w5MCutpD75iU5xtTn9xogKmAgjcvz7Ef4eB5QMB3oCtZJnEfHSvuYZtF4g7mJjvo4GmA9KZ94QnY9dCwolTGRSj4R3oNkIzahbRM/pA+eon4QDHtR01aqqKZdQrG/eRwGbgMz6RaLetYP706naZuZLWhI2SZ233ELRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59TC0qwGSoevDdy4jRBm554TDNc/Q9WZgL7fOjv6POY=;
 b=wXwbqvu9JQdvb7gcoTbdWSw9FU67cq4skmuwlhKj5sJGMxy9ef3oJ4R6Vld8b4r1njv6JRZiudORcIg8c+fTpvmZpY3xt1io71vc9Q0J4DGLadP0+osu01hniJjXKL9A8ClktkG7LdOHuxYWL3kuofTMnDXynG0CA4yMD7BL7xqv/o4rvbHDDHKYg4Z7cW6et4ycYMwLntGsDe8C/AyGtMWImDiejtfOGHyTJ/vsl2XB7MXDARBW3+E5aAdWqbxANVgFUGMxOtBe9an32oZMNis/lEWMVXhczmYz8ly0rJzeBc68PNB9WyibtptkcRszN0TRHwgPCRWvxz/e+OZ4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59TC0qwGSoevDdy4jRBm554TDNc/Q9WZgL7fOjv6POY=;
 b=IxgsWFXCdtveLbn2QL2EQlR0BazczHuGk4Cc2q+HzRYpIuIf59lZjA//kfEk32uNxmlgPLq+D7SVavzg0fpRteHexgnpJbyCo2PVmVFyJPFCvvfRERSLAn93eDkQ4GgxHNHs8q0dn4qphD5OrOrruF0RvHbMgdIvwiMJ2hhXIb8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:05:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 14:05:42 +0000
Date: Mon, 10 Nov 2025 14:05:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
        Shivank Garg <shivankg@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Branden Moore <Branden.Moore@amd.com>
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
Message-ID: <2e6153c9-1729-463a-86b5-0973b3f56ea6@lucifer.local>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
 <aRHwv3XzI4XHcLPP@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHwv3XzI4XHcLPP@casper.infradead.org>
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2af47e-fc7f-48e1-6e7a-08de20623c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhLhRavZGXiL9Q6YEngrcD1wtROrY0O3LMcYAEYMhJQ6Drpe/252CFYZVjo0?=
 =?us-ascii?Q?f9iDrt8kKA/Wh2HK3yP4jjB4LQGgnljKDnnli4qYuYg1twSa2DjRFtOrL0Ay?=
 =?us-ascii?Q?eRoIRABwDdn4DMdXc+oeTJzPdkf0hewG8j/OggFS0kBFbJ+M5PMtMvcNXmHG?=
 =?us-ascii?Q?VIDvwEOCh4fQI3Z/gsl79mmGInqy9U0VbsOQjKmh0ZXZKsnMVkeuy5xfxhG2?=
 =?us-ascii?Q?9w5oLE6js3OKWKwrFkzr7+9Pkhrqqk7Ac/bx/k5H+9Kh3jp5wQsBax+VurrQ?=
 =?us-ascii?Q?eeP71pTEUje98lF891rEk+EcTNTn7yhvJqgVRRCoiGTcrH+uiZyxUHS6ZnoH?=
 =?us-ascii?Q?oWNpNGLm3lLZvJe4Lzbkd2Q/jjU8VB8VCJvnFRceZeZHdMs3KtD4xyBhTddJ?=
 =?us-ascii?Q?RmxTTVa+1ph0HuInnXViiRmM36uXgcfD8nbEEhuODP+si4SsbrrxInYNthC8?=
 =?us-ascii?Q?chP9NaLMjXqnRJr4xOjSDYcwjtKYqRPxyQ7uCG8K2MaU9qtfsQF7mpP/XKU1?=
 =?us-ascii?Q?aEuDiXyF9xeNMNi4ie/Qr8dNK/thBN3CsoO2tBOGgwvs4u1S/zUXo3+j/oUq?=
 =?us-ascii?Q?zBHmvVWB2BJV5CzdH3kGMKubP/WA8lxmoURQPQ6ejO713e5yC45VvPurrn2A?=
 =?us-ascii?Q?UHpxqCTRnIx4xcRI5oDwwkyZ6pagfzM2q4qE/jjrZafXURB0z2weFnUePLFG?=
 =?us-ascii?Q?CMh9841awTd7zNfnJ0zGHQ1YIPpBTVa0BWi/IKKiDFKqbiva8vyM6NMr2ioV?=
 =?us-ascii?Q?D4ToOqygR7lqvsKOd8TQnQ87k4IGqqjm1y4C2EgsnL+mZuPyg6uemdKMcdlL?=
 =?us-ascii?Q?lHTdvsChJzeo1g7/3egdBMGWKo/6JkmK0qVlu/KJ+LCxH4HkUrK8eFuqrwsO?=
 =?us-ascii?Q?+OIXDiGU7RbPJwAZw8najkji+lG7vVDRX3fdQhQJPP5KpjlgTAluo80kq1UK?=
 =?us-ascii?Q?PAGOtNhL/WeExpMVAa/lU/OSJjbsFA9htks3qnldF9jbGDr/6IQ95r5dEuIk?=
 =?us-ascii?Q?0Eoggs4PuK+78jVgYTy1Kty8jLq75ZGR4D2tNEqQpfxU2mv5XpDXBsjDimqs?=
 =?us-ascii?Q?GdWG9ohLCGw3RZ+FA9DPQ2zFvidUBSazF94JC2ZOYcvgsoyuUVWBaCygO6ve?=
 =?us-ascii?Q?1NnFDXdfFdfzBmVQQ687tkx+DoDBJEQqZ1r2F8wAUjpwmZcxMOTmsvDuxo2V?=
 =?us-ascii?Q?dJpeaAp+Ba4bPaz9Q8OgT0Vsv0pHkCXZv0baWq10NV42i1uFvq28oPQZtrXj?=
 =?us-ascii?Q?mHy41lKLtegWrScauTDoCelG1y4EZ58JYd5H266VriKpd7JzU19kXELpaAcM?=
 =?us-ascii?Q?+ARsW2UZOm9pES/Nzh63DgA+jKRFKTlKaaF/8oAQyYMixmpEWANl7t2AN0+Y?=
 =?us-ascii?Q?uWWUl0hCncJIMy3foWlOpWahXSoddrfM5p8c6X+4kmRgP6b0TcX0avlaF2I7?=
 =?us-ascii?Q?nD4+0zj9EiRL2cothvdz5YLj8/FRONeF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPbvMiw7FI0L4yxOfGLvnw1ETmOLihx/LyUZDDzXMeeEOuG4bXVTvkWTlD1O?=
 =?us-ascii?Q?iAkBLQOKiD7eeysv32SaVzjLHatU+vvV+qH2Dt95CCiaPERkwvuI/0l/lfRv?=
 =?us-ascii?Q?xPPYJyMBgA5Ghc/1OzL7+Ab/m9rriXqJO8yqUgtOMV86dRMcpjlly6zUyo7T?=
 =?us-ascii?Q?AsMQFG8GQMakLCQFxbmkzkYEso6NTd5k2HTVD/WQzyEtXzGqjqyMfFTLCsbN?=
 =?us-ascii?Q?Whj675QmjD8eJTgoopERdiYrWmTMpkxcRkkfMxZJ9DoIsFAzFW+cXWat9joE?=
 =?us-ascii?Q?yj+xt3xZibMmSCSwxgLHms5Ku+o5YnWZs7Ai9+EPwntfoAjCcBQtePenEQ0s?=
 =?us-ascii?Q?8G8z+aiax8LE6BNiGZ5749G6PeIGhTyGWA5YJQ9yTNBfz7hOzzV/WYXJUHnJ?=
 =?us-ascii?Q?RMnT4SMygCPFd9hJnaJW+IoCNRa6TP78WAaZxlV9bhjx4wBcQWW54xytM8PB?=
 =?us-ascii?Q?OlUUjjvTt2/M/Eq8C4fmXQ8o+SwMDQLRITEV7/TCNSki9/7y0eHtMaFoPYC5?=
 =?us-ascii?Q?+6dds33hEI+1LzYjHiTVQvLL8BEc938Oz0si8uaxP8uJN6mPrUYmxgqyAF6/?=
 =?us-ascii?Q?cYTCf5aKeZrVxbS9OmNOnn3TEY48rq/lUdKBvAFoNVOgyNpWa+ax4xQnAkLZ?=
 =?us-ascii?Q?DQdJnK3oUtegxkIhksnioP5C6dJQkvRVCzvuWOKPH5tXe846mBIVrwekK0DV?=
 =?us-ascii?Q?IeXfrzuB7MIzFVb+u4SJAhYxQsfNtyFHpJ3zf/rUlHGWcCZDZs6vXCBoNBW1?=
 =?us-ascii?Q?cXJwNMOAT6XdX9w3o0q+KXQeYNDKk3fgu4q1Gx5xxo9IVhwMmx7a27nI5ZTh?=
 =?us-ascii?Q?EcAy0q779KlGhS7UUj48YdI5MymZammGgVFLuBLZL6BHijRTlw2bneFC3GH+?=
 =?us-ascii?Q?K48NMEBuuOdehampHI9PB+cVae2mIXl5Fyoe8C9Ln13iWEBRopRnAU1KGISo?=
 =?us-ascii?Q?3B0kQz+JWNOr1mP4aN3ofymKXlHx2pCENMaaN121ttGgWIvOekczHcG1jkWk?=
 =?us-ascii?Q?M8/0dOLjCpWBAfAc4ZRPrqD8LmhAce49i5vabkiEgIzLBLtSgLKd9TW3+tXr?=
 =?us-ascii?Q?4bIbpltkVntCSUWd0i5Wotx1afb4Wt05CeuIC5ph9uaC5a4MHJZ3alBOBJCo?=
 =?us-ascii?Q?YDVwouiKSJdpi6jqG7MTr2hAQFNGn4kmNidGOlzA113xxaP5i9FBLtO7mmW1?=
 =?us-ascii?Q?vTv5tAt6fnyGP0f26vHwAXBvSHRN8UZh7oFqd7HEHinYwPu+pnbKWy1g9VeO?=
 =?us-ascii?Q?xOsN0jMKtXn/sd4SJ6et73PnAYwwSTsu4pivyXPbOSSuFjYDhqGbTP2/Giay?=
 =?us-ascii?Q?bTeUA3F2P5yLWhtOv8CkSHwXm7pberrzuS+co2VN8HB3NZukWAcc1fRt/ERt?=
 =?us-ascii?Q?fWYk5ONBSjsh/tzRxqpbnqyhVym+JsnNmzfcUQJ887a834NqYhAj+4LJ6JMn?=
 =?us-ascii?Q?1qFE84o9jbIfJsFf3j4mecpO4lhiwbTfTnfcW4Uxb4HTcfm+vIVXnCS8l3Cp?=
 =?us-ascii?Q?KD1/Y05Wbs6xtiXNfoMk4OPWneDSabYVl14NFbcWVBjuHBnbaQo15cB/zpgn?=
 =?us-ascii?Q?Vg4vTfzxq3UAvm1ybaDrAMRCW1O07Q7oql9+8oqmYXfBRqVcRE20kMSDJF5D?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yYWHzWzEAe6+RSZn2IHZ0V4fmhBBfyMyjWpTLepPFDPFBpDAJSeEnU0ez180hL56aPsZ31fDQcFi4F79tLFFzAoeeJXBRw6S5LDJzmZCU7RVFssFXuvxHLYHpGPzZon+/SUo8GRoSJB3wbaPLHeOGoJYjG8QoC8w3Cuzi4+aPm8uO9abtGNdFPt3RAUjAG96ighNuluq9FMJJ9pIV+UES+uJ2NeiATHb6uWztJNdQjMBFA45mF68nRP8nRwbE82r8rILCAxVBkJhO8VF+R6QI4zeNdHb73k1n3IqM9/GZ8M/04N1lVgJdEHQUfUiziJB8RJUJYUoiAlsBHX6p7O+WLql/wg7gD4VGBv12C2HxsSOcUYLuVMZV5k0egpPIyKq7jIIHNf7hbfqSfBN1oWM8MhlOdZtZoyF+G77tok9qvTZHxJjPU9QQMzvi68ZvRIu/dxsHfBIfP+s6OrDirp6LtZUF7M/1T2WCYE5q10nAEugwKOm4N/NpTZkyaHqb//KlICzl4HhQEklO9+Tca4B+C3pX9pgZ9YGqjTmV2oRwMKmIpRMG9jjOL0vam2/ZozuW+lrav5WW6csJvZKonwhJBDSlhvs6KEnJ0ZcrIRP6j4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2af47e-fc7f-48e1-6e7a-08de20623c22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 14:05:42.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l9zlc7bohBLFYScq8Rste26hOOT7FcnqgPJ+iIPtgpmOK2iucOrHrV+pXz2g2g3sbxtVG46Q2sDFQWTZteCHb3KFAFL1ZH7D2/kZ/Z8pP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwNSBTYWx0ZWRfXz0oK/5JAOsx2
 NKoIq7Ne/W/Nk4W3LKRL0xsWjcoY3oLJVWeOYm7U2m1S4ivkzS86A03JqFCgbW0ekzEKfcC43sz
 PXSD1ctTu/3MAAI94dISEIDw1Eh4yyszm7mScEqj+LinbbGQpT7GACrm/jbgzkyQerptXRH1Pn7
 RKJc0bkHIfYMziYW53tXgWUszSkhMumrviNtJ2xJMqG+1GDwKUm5i+d7FceR7+C7910w4LWstdv
 CP8TToO+O2lovEGh8VeUjzsV8FbG40nfDHVA48qFuMnTy7uWVxKUFz/hPHy72B3bjwUf3cGRvaG
 EX1r7n96raLxxh2rqU4A9eMrwQDmsWWPyZuWlEhy7KTAUOgOQrzURyLjKn9x8o8HLohEquH8WMy
 JpQSI1paaXgIIzw8Seicfj0tnw4lDg==
X-Authority-Analysis: v=2.4 cv=Ye2wJgRf c=1 sm=1 tr=0 ts=6911f13a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DD-9RX_BhaU6idm2K8wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6-iH65B5mpesnWoiQF7c8DlaOVpuy8yS
X-Proofpoint-GUID: 6-iH65B5mpesnWoiQF7c8DlaOVpuy8yS

On Mon, Nov 10, 2025 at 02:03:43PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 10, 2025 at 03:00:32PM +0100, David Hildenbrand (Red Hat) wrote:
> > On 10.11.25 14:47, Matthew Wilcox wrote:
> > > On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
> > > > When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> > > > text sections), the pages may still be dirty from recent writes. The
> > >
> > > That explanation derails my brain entirely.  Text isn't writable!  How
> > > can the pages be dirty and file-backed text?
> >
> > Files are writable :)
>
> Well, if you're root ...
>
> -rwxr-xr-x 1 root root 158632 Jun  4 11:14 /bin/ls
>

gcc foo.c -o foo && ./foo

Is more the issue I think
