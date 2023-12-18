Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BAA2D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="U4JXkzQp"
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIKlhNw032476;
	Mon, 18 Dec 2023 20:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 to : from : subject : cc : content-type : mime-version; s=campusrelays;
 bh=c4vrCY4hZY8buSEw1wtJ5MvdQCQ1fIKSft3w2l3GZWo=;
 b=U4JXkzQppKAWSskz/x045q/cmboacb/YdwVnApuRwhyitXA38WYyx0LJ88ceVnc63LFg
 L8nXfNmdcpAcEx9aTi4j/mhgiVq19fgktjp7PAQlO+5knxrQUgdgT1jPCw5rZV9nj3rM
 E0+GpRZuWM+NAOlhc95AZxjuf4cFDckjuAHq7koSRhhoRpdP5MyPUllz1swNEEvKunrw
 xSU7CU9MAcjv+6pnGG/ucbEULBdXBC3epLdptCXW9qRsDWWYJTup0F+sHQJe63t/anuT
 LkEdOCLaeJEy+EeKJfrwxogHz7Bwr0a4JU1bl1RQ7u3zuG4BGQFd+Y9wkrMdLffnkvJH ng== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3v128rmyjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 20:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4VOPbG5PkJqeEmM0Wj3AtC/fiCvxbhLElTZSIxIxaCvlXKe3C92nrXWPHBrTD/UR0VLgg5C0eX1tmrkRv5kZcYAL1LppGm/dZGsuSJl1kb+5XLwpLvpPSTR6pzDYFMz9ga3Qr5JkdH36RZjkTZsZjXEX8TP90+xcRdpH+pJnZt7rFHSYmVQvpU0uW4a9zK13HmFn+FPgd+bDQ9zqM0eT1A6HadIBmNeL60oYn/NgCKBM8nTWeyWD5/tdBArGliEnY5xGYWKkwnmF06YjiSXUX7M+dkGyTAYSknOs7EJfK9P6zZmBHLsSbXfH0Y3W82hjW8sHPjZ+f+NpMqw64X6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4vrCY4hZY8buSEw1wtJ5MvdQCQ1fIKSft3w2l3GZWo=;
 b=JUEtFJljqYEueQrXgqrmlUGD/jgZXQnQxS626wakVpaY8eM11yYIa3XUMqpEzkl9aXeHEJcM9WrTcc+V37Hur68cloyGoRGvG+sGzs635dAhiof8s1GQwB7IRlpV5c2yH4QPDPE8Ihxav0r4Wl9cYSoIVHMCNGPU1XhRj0DnWAowANDnf2J3ZqB05OYI3S9uUvtcPTfJ63f0cV88RJzgzOcC1Aiobrp6JYeROGMSc5LTusb3ac7LEHgGK/DtSUNEmlEIV9pdJTvPZBaJ18ngdkavzvyUJmGdiC8bsaqz1h1cGffxAf1N2PMeQI3AZ+poc4X3uK7T0khYV32Mi9E20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 20:56:36 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::9a5e:6239:2adf:deab]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::9a5e:6239:2adf:deab%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:56:24 +0000
Message-ID: <01a21be1-6911-494a-a300-cd3be0efc858@illinois.edu>
Date: Mon, 18 Dec 2023 14:56:22 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-trace-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
From: Jinghao Jia <jinghao7@illinois.edu>
Subject: [RFD] kprobe: Use cases on further optimizations
Autocrypt: addr=jinghao7@illinois.edu; keydata=
 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
Cc: Michael V Le <mvle@us.ibm.com>, Dan Williams <djwillia@vt.edu>,
        Tianyin Xu <tyxu@illinois.edu>, Salman Ahmed <sahmed@ibm.com>,
        Hani Jamjoom <jamjoom@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pSEiV5ljAMfznTL9hlLAc4E9"
X-ClientProxiedBy: CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::23) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|SJ0PR11MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 60919a4f-ee3d-47bc-970f-08dc000bcba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F6LJDcu8fAAll0OcnKZjimG99eA/vapACh021JBDVMTY2K4r+t3oJ3A1ToMWuEJmmUAQkLWzzfLU/Ex0DwCwQp2eTehRhZX5kHUianyV1dt/0sJMk+hT0u61GyaVu8RFOKfFPlPJPkmcpvHMzDNriTPoUuJtNr7Bywz8xq7xwl53zeUZP1yaSz1/R6m6rK5TbCK5vMC2FE6FJwJe1nE6JNncTNukHaq5BCnYlNXYXGhUhgKkbtYCbeG/V0b73UKUqu6EiimosZKFraxLWa7okWaFOjZCDB/+DJ4O2kf4hdz92N7kc5hrXgCm0prMrEl6IBPLIF3h/lqkstNVXRN0i5AjgsUd/qtMxlyJGCexRbAhWY0c6FKOx4Df7dMc+4mYYYNM82As0pehO4QDwWrXKbXepWeAS803YseATONfC6kEVIo7JaY3XZyV07Sy7YZozIH0DxyUCgqSuQiM0kPI5htz2BTVAmPqvGb+Cax0OHL5uVJ+OhIUkC+BYrNvq1pAUQl/82dtFXAHQ5IMD2oJwlWInexjHVVFyN0elc5HXX1mEXrrJmXQOEBs+Oje+iQLpTpwQ1NXpf/vYeREjJ8xmWDvznrBL9Vk+mq1cpEW88qd6HspcfiWPBb3u6hVNPo2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(75432002)(33964004)(2616005)(6512007)(6506007)(38100700002)(36756003)(86362001)(31696002)(8936002)(8676002)(4326008)(110136005)(235185007)(21480400003)(83380400001)(478600001)(2906002)(5660300002)(6486002)(41300700001)(66946007)(966005)(54906003)(786003)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnR0NHI1eEdyRklUTWw3emdCaWFOd2N3TTNIVWF0Snk4M1Z4MXUvUkpwbVQw?=
 =?utf-8?B?dTJPbWNSUzR6bHZrWW1tYzJnd1hSYmZqNWtXU3dGN1hZQjkzTXhDbWFPOUQz?=
 =?utf-8?B?YkE5YnZJRzAzYytWbmxDanpEcUx1MnJISjB1YitsVGMvMzkzVktCWTZpL2Qv?=
 =?utf-8?B?Z2lUenk1R2NsZnkyNmZqOWV4dVJFcWk1Ky9YLzVJZE9QT2l5SnduczJRUm90?=
 =?utf-8?B?OExwcXZsSmt5YnlScWdra2pkbk53c2JQRjgydW4xK0hqVTRKQ0Y3Y1g0Z0hK?=
 =?utf-8?B?bm9GN1FDQXZvR2pRdmJpekJoMmtoNTdRWnhQdng0VklPSkNSVkVYZmttZW03?=
 =?utf-8?B?Z3BKa3lMbHRLOEdtc295ZEhxbnFpQnd1RE5Nc0NkYk5IZ05QU0M2K2taTitj?=
 =?utf-8?B?bUhheWQyYjRLKzQ1ZElVRDc0YUpqK2lMRGZmbHl3S2VhRVBiMVJBWWlTMzFN?=
 =?utf-8?B?Z0o3NEorWGRERXhnalFQMDlGRjFnQXdqbFNvTE85eUVDN24wUWlCWlpRYUV3?=
 =?utf-8?B?OUJ6aVY3blBpYUgzU3IwdlMweFNhMUw4UGlBOGJzcStMNkhjQjlRZVllVDRk?=
 =?utf-8?B?czliR1hxdU9MSHY1Q0lnR0U0M21VK3BMQThjbE4wc1lLS3liR1IyY2pJRmp6?=
 =?utf-8?B?eTAvYXVYK2F2Qit6cVkzMFFaTXM1eU5nOG96bVU0eXlneEhKcFhXYUdOdG1i?=
 =?utf-8?B?TER5WnVIM0FxUGVBZktCYkZyN0lmVWlxTDJlRzRmZWxFbW5FanJPVWhYR3lz?=
 =?utf-8?B?d013SzljNzRrOGZIb25iN1BIRE4yb21nUEVZYnl2allyczBPK2sxNEF6VTdP?=
 =?utf-8?B?bWpXRmwrV3JtL3lJL3hmc3YwUWVXamkxY3YyS1ZKcFREd25nZFg0a1hpWXRU?=
 =?utf-8?B?MkZZYVpDVXE5aWJVSFRGUDVHM1dYNlZRaVN1YkliS1U0RGNEMTEreDd3L1Zq?=
 =?utf-8?B?d3lmbVYvZ2MwSWpNcUJQQy9CTWpuVVo2VDBqejlPTi8vL1ZXL24zWERFRmlj?=
 =?utf-8?B?MnRhYzlEOWxRdVltc2pWcExXdDcxYnBzbVA4Qy84b255TDl4MTdXSTlsYXMr?=
 =?utf-8?B?eTQwaVFaZ3Z2SlBvK1FyYVNtdUlSZkdkZFNVOTdDUVpWK1R0Ulc2dzd0eXBy?=
 =?utf-8?B?QmhuM2xmc2RGTmpVWjJPNmRERmFvOWVkNEY1MGJSdS84Y04xZXB0cWhwdDlM?=
 =?utf-8?B?bGE3WndaMGxDY2xxMDl5UHpPQ0dCQnFUSXcvcncrTXdxcUk2b0YwcFVaQlRi?=
 =?utf-8?B?NG9BanhGNlB5bWJaYmtzOVVLWGhDcGNndFBwVlEyYVBxV2pMdUF0aW1GRXZp?=
 =?utf-8?B?bzlnUWc5dzZySXJkdmZTZW9haDBPclZURHZzWHQvN1RVdzJhUXNzaTQydHFv?=
 =?utf-8?B?c2xjckYxT0Ixck85bUdBK2hRemxjdERoMU5CQXljNmROTXh3TmQwYVRGUjNS?=
 =?utf-8?B?TVpkS2tOckFqaHMzK0diTmgySmdkRmZVSXBnd0thVGNwSnpGNll1d0R0UFRC?=
 =?utf-8?B?a1VSOHc0UVMzVC8rOGJIdGp6TmRIY2Y1eU1lOEFFNHJKenpmekUxa25GbW9D?=
 =?utf-8?B?Ym80c2phNDE5SnFCR05sNUxxK0hDWnhoTzNwZndEMUtYbU9wbWJBZXEwbHZV?=
 =?utf-8?B?VGRmOHlpWUlRZjF5end4Yk1HT3hlb0JIU0pqQlNsUThUVDFpTEo1QThZU3Jm?=
 =?utf-8?B?SncwVE1hQmJvREtoQnk5c1JBSnIxSkxKU2tRR1dUT2VZWkJnNTZpTFp0bWVu?=
 =?utf-8?B?WjY5ajR5MkpCWU5IUXpla3dkS2RrNHVkT0V5b045bXI1SnRmUFpDdVV0YzNY?=
 =?utf-8?B?VlNOMTA1aTJuNUtPOWJwV2grUjF2RnBaemZNekxlek5PeGN3UlJXWng5TmpC?=
 =?utf-8?B?V2JKdTRPQUI1ajBrTzl2RnRWNCt2aGNrVjFzSExEMm5ub2p4bGZrNEU1bzE2?=
 =?utf-8?B?b0tTaElWMzkybmp1dTNVM3dzc0NSNzNucHlWVFFsbTd2Ris2aXdrdG5FelJy?=
 =?utf-8?B?MWdzQVBJNkRKbGQvSWt5MVZCZUt3YTBUSnl5cCtpQVVPRHozRDExcjM5WVMv?=
 =?utf-8?B?azluUkFXUFdjRDlnNGdKOEdldm1XY2tPQnhPNFNwOUtHdUZZTkpYNy9WOFR0?=
 =?utf-8?B?ektTcytMWnBxdGdtbEFPV05qczV2UG1xUHRQb3NwMnF4Z0lhTmsxVExyS0xE?=
 =?utf-8?Q?tlO27V7iYQZczzHvVuCMhK8aLS44bjn+QzVo75T2u0Cs?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60919a4f-ee3d-47bc-970f-08dc000bcba1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:56:24.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35NjHwLEWnyWpsT27pZ5yWKM4XFs9MY+JgJWSjacEurY9Bzt6i8ybMNAQeLbvY3eKhzSSg4pGEGKK6ydcosFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
X-Proofpoint-ORIG-GUID: XlDGZ79rLLkCRLKtGY1yDKx7cnZEIJAe
X-Proofpoint-GUID: XlDGZ79rLLkCRLKtGY1yDKx7cnZEIJAe
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=434 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180156
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

--------------pSEiV5ljAMfznTL9hlLAc4E9
Content-Type: multipart/mixed; boundary="------------UcR5aMk00s062qknlNmD2Zj8";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: linux-trace-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael V Le <mvle@us.ibm.com>, Dan Williams <djwillia@vt.edu>,
 Tianyin Xu <tyxu@illinois.edu>, Salman Ahmed <sahmed@ibm.com>,
 Hani Jamjoom <jamjoom@us.ibm.com>
Message-ID: <01a21be1-6911-494a-a300-cd3be0efc858@illinois.edu>
Subject: [RFD] kprobe: Use cases on further optimizations

--------------UcR5aMk00s062qknlNmD2Zj8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

We are looking into a way of implementing a fast-kprobe that allows users=

to instrument an instruction in function bodies without a trap even when
that address cannot be jump optimized with existing techniques. We were
initially interested in these optimizations for our KCFI project [1], but=

would like to ask if others have use cases that could benefit from a more=

general kprobe optimization (e.g., for instructions that may be call site=
s,
RIP-relative instructions, others that can't be boosted...).

[1]: https://lpc.events/event/17/contributions/1591/

Best,
Jinghao

--------------UcR5aMk00s062qknlNmD2Zj8--

--------------pSEiV5ljAMfznTL9hlLAc4E9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmWAsfcFAwAAAAAACgkQL9huahcPNUYF
7BAAxWoU1DA39RoFNGQn0uSDNjwsWM8ORy0m5SyVMF/cZZsD/mK32ShNiV7XEas6qiYF55QsAOsI
Gm57jsDx8y/2obxyMO4llRYXYDy7jWUWG1Tj29IlI/StvyIscsgH0utmdyMAQYd1Mbt2XuAGmjTe
tqPK/40GPF58mPvsRgCH9LznHkdV9fFKUs2SvK8mnyP712r1yqM2KqGCcXabMgD5XT45SAayOD0I
WaQAA+Gj/ZqzN1vHYISsP136z2HlHltHLKI8F15EKTKW3SlyaEnKju9oGAJ8AnZVdP/3pQPlFY+k
BgDAm+hVLR9NZn8nzFl0p+AXB4ZBos79zTV1397GtgUvIRGRH2NszuS8HNCOAUnuxPNeKGcuWJ2V
WzNnmzrvVh097AO4sVUkGZjtAdTLxoUmijmxVhVPnquSahn2zz7mB7Aw+ErYZNAl1LtZKgTz6utP
EPVAbEG0IBJ8hBHiYpUIidazDBHfUjIBgz89jaKoSKiN09WenkwYXgwwb473DYLbv+1gPL1u2Epv
eT+qq8aR7eDG+yUM/Sym6kfF8gvUTlfb/eNo56Z1HSY3JOWZ2Pwlt5eqQ3YaphTB0AAk5QeGY9UU
XSCUy0ukWSppl3YlXXC8aBEPVo8PrEkyr3qG7/OXN24QTPYvIyXmaA6EfY+3kHyKHq04Uz0lpHG4
8Xs=
=X8O3
-----END PGP SIGNATURE-----

--------------pSEiV5ljAMfznTL9hlLAc4E9--
