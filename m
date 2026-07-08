Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17063420876;
	Wed,  8 Jul 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491857; cv=fail; b=gN2zuPLs2EWIcL2MAWOq++2c7LuWtlV+EIXyPySR+n033KsPeArnKoz4cq5Gtm8HOkpISJ+oCYTNhDkC0NpIZ0PrKLHaFKNmvLR2UBp0YWdbXN6wvMwETRt3HsQmMllLAUo4KEjueHQzJivRwG8cQRUbJJKRmjZ2XRXpYAfUZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491857; c=relaxed/simple;
	bh=TtQnR6KL3QqYB9/5aJvxMvKV71Qx/N4bcQTL44O6bfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbGel7gIrBuoEqD7hYA8IC3mYOGEDncpdBnPSNjNQ52vFoi5huPQtUkm+DlgPdz7ytV6Czz919YoMYX5xBkehbdrDA3KzEJNPQycDqP85/d6oo2NYxc9rW9VlfJMKiCXyN9fTA5OxGXQWhRxeX8l8smyKcu+Xo+xAm/g5NHsPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=CPHJRHBL; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="CPHJRHBL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc4nSKoB3d0Y92G1RJvMuPc7Qp8xgpGa9MxoK65/as+2poLzW3Rx0gXVGSVyuLFU4wOC+0K3hKrFyryG6R20xdLTsF4qbuqgKScUnjtQ4TjVIdUjLOSGI2So0mbHAgB9GolCkk/E93p/u/UqksBnuYKpQEaDtUfnIINhlcd4pWrcN9nOMYbASCzjvzUGCUDDC+WOtvVewwSUXDUTdIVB6HyQfePWWa8v9ChimEtIdXWCSiiP6WH0qhuly+317B2gvPAr3xK7h6Dz+yjnVSWSW+O70RIrModYmrM5lgacHEI/r/B6QeLB9qodS4eHY0hoDIgQWCuVWPeJ3aWV0+Br4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5mdw1fx2V8SscsSLKQWRkTfJRfSxzjtmSHYuMkp3P4=;
 b=QZnZ47qANQvG3Hw/nm6zE05yzGto/bUW0mXkeDH+N/RWCM+K2c8L2JYdIB49ML2mn8TnG9aKvTTzaCDREf1JoAAYLR5P0lxB4jxAvuh4AKSJTLZDravL+53mZdtZ8ocQy3l0tRA9nVKEILS+jkG0kgONlVh3FYxLL/MLGcovfVyOXIaUbCEGbpjO19xTkPiQneFjCIwNPdA1IuGwKv3bBw57BjeyjEC0Qhcx78qEMXrMTYu2EjGV08gePtjY0iPRQslSRXIrFOpZZZZnNNosHEGdQlpCFuvKZhIk6qW3rpGQD+PqGgTn84PuJLBMC+swJjJ6tcBcW3igj7A2i6yubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5mdw1fx2V8SscsSLKQWRkTfJRfSxzjtmSHYuMkp3P4=;
 b=CPHJRHBLAqDKob8vARBsGH8Jcwp0iOoR8Xs+49sqImY3KMoXWys/yWR1pzVwzRifchv78kwlBDIsZBBT7qa8UgCBPcgz2gewCbo3GKMcfyfPxgPx6udxc8NuwgQSjJPlUoZzleB83CHy43rMzG4KQbsC/0eoF77allTwvncMtmRcebFIJ+Z/TEeI5N4pnEcPrDhGaj4ZpjZMRQonc3HZUQsYlNQU1yR6dxZ6f5s4cxcXwU+NzAxxxs8kSMDawMEKKlZaSa2sGdASRkPCuE5B1lIhaC0OzpdpFyIj+YPsTtSiC0LNz4Zaq4IoqCbIB984jsDZ3sycTFrCh7tSy3/MJQ==
Received: from PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:63::22) by GVXPR01MB11760.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:24:09 +0000
Received: from PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 ([fe80::7c4:3143:57b7:cc04]) by PR3PR01MB6666.eurprd01.prod.exchangelabs.com
 ([fe80::7c4:3143:57b7:cc04%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 06:24:09 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: Wandun <chenwandun1@gmail.com>, "Vlastimil Babka (SUSE)"
	<vbabka@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jackmanb@google.com" <jackmanb@google.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "david@kernel.org" <david@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>, "liam@infradead.org" <liam@infradead.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, Hugh
 Dickins <hughd@google.com>
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
Thread-Topic: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
Thread-Index:
 AQHc88tI1dDVY1j8J02KOQzrNPN747ZDLUoAgAEaZICABitEAIADOO4AgAL622mAABC2gIAAQ82LgARqnwCADaV0gIAAUV22
Date: Wed, 8 Jul 2026 06:24:09 +0000
Message-ID:
 <PR3PR01MB6666D83ED3532AB3A0122DE782FF2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
 <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
 <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
 <PR3PR01MB6666EC8D53E75F742B37270282EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <05d7369e-341c-49f4-ae13-df3d0ad930d7@gmail.com>
 <e4761ca0-21d2-41d5-8d0f-ec14d0a5d3b9@gmail.com>
In-Reply-To: <e4761ca0-21d2-41d5-8d0f-ec14d0a5d3b9@gmail.com>
Accept-Language: de-DE, en-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2026-07-08T06:24:10.634Z;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=1;MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR01MB6666:EE_|GVXPR01MB11760:EE_
x-ms-office365-filtering-correlation-id: 09799fa7-b40d-420f-9c3a-08dedcb9851d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 HBL4Y5ZO67iSvjFkQEZ8DS9avTp7f3Daw9c8EHNcDAm7NBCILO/UF24CvfEptXvn6waCVvV/xK7PXwvTYunr/NtmZN2cZ6YlNy8lhZIgtd7AOnDvQN8PEVutYP2BNioPhnWs7YuJkL6sWb37uqk8IPMNS7dcwZCjzYHM7D6sp1umbY5qryYsrH0y7+V7Td8oyrGlken/8S1y95vBRJTopjaJSmBFwlx8u1pfmwEGqM8+07iItEMdfAiI8qpJW7fAaNlztRC5b2vlCjeitkcjORAn4Ls4Nic6GdOKbkw3xis+wR+LlEei3lmJAzqSXhn6+xrSRsC+s1N+E1OGV3/mOo7KnSD5t2INNLaZT8kLmGQvKGunPazGzOjvFVoQZ+sd7lUgmqY/JrUpgYNNZgrq2erXTpUG3uGjvvfSiqekKfTuV8snNlidtqnXoEspFKJ8DtdNleeRXVN5RHxOpewT0xMZbpyfSDN5Xbf+TZ1tL0G52WgaNusMRqgDLaX30qaSdM9yuKVIxLI++5RWeZADSo+XSIZR+Q0Mn3xtITVJktAbJD3Q5PjU7VpMpFZRS3XGQsw8eFE4cBXbY4770T9RgZCtqeR8amWp/UwnUYekNKwRqK4RW04HpxtpdlcHbAtSiJpHaV/82bDBSzGO22mEvRllZEkcdKYVHRAI44Rc0VAGg7LjqwmBoqHhHKolGDJghWO2TLFcpxWS0UfGChrD2zxhRLT/ae/53ea+ZAjqIS0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR01MB6666.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rgAuDz6y09Gvji4I/CCsIGdiV8tjxjTyKT5LM0bcRB2Dvb84lTU9FSOlmW?=
 =?iso-8859-1?Q?vXibWda2gWVXH/jBNl5tk0ceoa3NjW5cLGwh57ARLK1PBEQyPAXqvkxf0n?=
 =?iso-8859-1?Q?fOayfE20Vmw3dHr0f6SUKXN104jY7ustmVGuVnsZSt5lkFEH1xIInwv9m/?=
 =?iso-8859-1?Q?9zmzygkxKJRLWNKdmRXXcxaA32MBPr3uy8b4euguodpcSteJoZ5tIFrPwP?=
 =?iso-8859-1?Q?fH+XXMRPhKO5TmU/YAN4lIzuYGlf87fXgJof2MmPAo3nZnO3NFkZRXbbmX?=
 =?iso-8859-1?Q?1J342deaO5USueSNSdPA0AbFZ5UXyXEfhg9XycESKt7aKzewLkGQ3ZKNzV?=
 =?iso-8859-1?Q?GGaM2ZPjAPJAKTQOgd/q3VdV9m8MCVtehbAkYdm8hER9bMHB0O3fBSnFXH?=
 =?iso-8859-1?Q?rzktylI6v3bOyY74tT23HGKfKZTLX9VoMYmKw8LQLWxwb79MSczyfk2Qx9?=
 =?iso-8859-1?Q?DsvkbCMdi1CjH7U42+LQ3tQVBU6co5i5eU2lGZE4/t4KA12f5sCLXoPfOo?=
 =?iso-8859-1?Q?q7Q3Gl/W2LjKFgFkmqaDfnBtL5hP39cXZ5w3eLM0egVj/8In6B3d0TtjJp?=
 =?iso-8859-1?Q?4mJNqR3+GG3U8sof6PiXnUldrgLv+dcKWAOwHvKg70WQCVAT3aUytdU9NE?=
 =?iso-8859-1?Q?+jQgUcsjgo7BHwB5i0obquvCERTB1XEpQNThA1z/2JugEm1h75ARbDurKG?=
 =?iso-8859-1?Q?0W3+acdfOOA7BTeDXrRPZ33GzMRzySIslkaxPysJ5CfaAkmNkcaGUALZa2?=
 =?iso-8859-1?Q?Ldoe0rRKvOiDLzNNiGLiSyjircvOWKAmqMEHD5/fIyA4XMaqMa769VeN9l?=
 =?iso-8859-1?Q?paz9AAEiedqF6ahkAxo5SmgQYta0JUn2oA/AMHEvhDcav6+xDsHwCQ3x2S?=
 =?iso-8859-1?Q?09SQJarrDyqfDXwWUlPNhQk6hC5+TwSd5LLm0VNZB500aaGYFh1+FlXRX3?=
 =?iso-8859-1?Q?cPzLNykayh+CF+eeq6tH7f7Wi9v0HqtRCsp2v04oa1GYwHAOIH3SmGsHhs?=
 =?iso-8859-1?Q?zDQFZqu2M7S5dy49n6QIT2KEZAjrpTOx+LHGYLsVUgRumf9c+MGd91ckS2?=
 =?iso-8859-1?Q?QeaCXvSV/8E7bdtdcb17tFGckJcAYdqVXg9IUyK/X88lgV5b+KfrGX1cEM?=
 =?iso-8859-1?Q?lG3fQUPxs0o3gtvcTYFI2ugNwx1roBw0pQQex3RoDqojaNEWSuvM375B9F?=
 =?iso-8859-1?Q?6KUPCvzs+Nr5tPtIIYAbhfGIy/y0hpzdfUJFbR0NVEK8sO9FyR2+W3M9DV?=
 =?iso-8859-1?Q?Y2RatOn9sAzarvui/Onf35B4E7qJy/SWXDCNM00SBtnPrDhjo2pJu2uKZR?=
 =?iso-8859-1?Q?+XIHp8e226tK6IE+D8wYfMLHZWUcULkNw6Rj1Xy8DP3HEiaLAMiEGVt2+y?=
 =?iso-8859-1?Q?fBbDtNJyxjLidB1SYHPLDpl66KRRrg6/LvF7e02Xc1ixqk8cxOa5FW4xaZ?=
 =?iso-8859-1?Q?G4LfMuwkN+ilJtAx+rQd6PtKXJpV6a3nYVWsItE8gjD+BdnZtSabVa9pIC?=
 =?iso-8859-1?Q?zfjUxYkY6+BOLgqWfWAR/1IWeRrbOcott0WU4hQ+duq4ivPZsNHJ+NnRdg?=
 =?iso-8859-1?Q?p0NOonCazFOr3TTyvwQKzn8d6CK3FAA4Yr3euDZCSnWK3SzZKaAkV4Dq45?=
 =?iso-8859-1?Q?PF1Iy3NlZ5aHn5otIr6q0CcgmfoLvrBiUlK47bKq730q6bjycXaVVirhdm?=
 =?iso-8859-1?Q?Q+AvZI9C8B29E4ljs3s5iY/hXHrbmQBNbK/bLF1kTPucfgTujAGANzffQq?=
 =?iso-8859-1?Q?KgH5FoiozG8kPGMWiASUjXA5cy4QsqwZhqMgv+X9wYoy45n6+CYgh5IvqK?=
 =?iso-8859-1?Q?pnPTrLzgUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR01MB6666.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09799fa7-b40d-420f-9c3a-08dedcb9851d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 06:24:09.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgX0W6lf+JpTRTuEF8PZFi4HwoPTUNgJHNruyKdA9c2GCP8Z4fdW/cjN0J3nKgEF35q4eyNPsVcbhs3qmou8MxcL/gFKmHCDizjwxjoTAYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR01MB11760

On 7/08/26 03:31, Wandun wrote:
> I found there are false positives in this reproducer.
> I modified the program a little,  the diff is as follows,
> the problem can still be reproduced
>
>
> diff --git a/repro.c b/repro.c
> index b1b34d5..59cb417 100644
> --- a/repro.c
> +++ b/repro.c
> @@ -15,6 +15,7 @@ static void *worker_fn(void *arg)
>         int fd =3D (long)arg;
>         size_t len =3D NR_PAGES * PAGE_SIZE;
>
> +       mlockall(MCL_ONFAULT |  MCL_FUTURE | MCL_CURRENT);
>         while (1) {
>                 if (ftruncate(fd, 0) < 0) {}
>                 if (ftruncate(fd, len) < 0) {}
> @@ -24,8 +25,6 @@ static void *worker_fn(void *arg)
>                 if (p =3D=3D MAP_FAILED)
>                         continue;
>
> -               mlockall(MCL_ONFAULT |  MCL_FUTURE);
> -
>                 for (int i =3D 0; i < NR_PAGES; i++) {
>                         for (int j =3D 0; j < PAGE_SIZE; j++) {

No worries, I can reproduce with that program,
but I still think this is different.
The reproducer passes the MCL_ONFAULT flag to mlockall(),
delaying the actual memory allocation.

However, this is not what I would do in realtime programs and if I do,
these faults are basically memory allocations, where I can
not expect realtime performance guarantees.

If I remove MCL_ONFAULT, I did not manage to hit the migration_entry_wait
with the reproducer.

My guess is, that it only triggers when using CMA,
but I'm not deep enough into that topic to proof that.

--

KUKA Deutschland GmbH   Board of Directors: Michael J=FCrgens (Chairman), J=
ohan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914

This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure or distribution of contents of this e-mail is strictly =
forbidden.

Please consider the environment before printing this e-mail.
