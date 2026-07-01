Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF43DA5DB;
	Wed,  1 Jul 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908102; cv=fail; b=bY+GkPcZNg74Wqo1+U/DN5h5YfCdcMX418prsK/4XqtChxUpIHERFz0sURrlGfjJxBw5es9QjlwSR8Gjv8nsRqSFafVUdXaXlqRVyM8TH1TsieypiBdvhMUV11ay+ohX+UNwgRZ5Uc0VvsEaTxjqcYj9ntRf2FzoeGW3wY1xG7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908102; c=relaxed/simple;
	bh=kR/87zySmyrQZ6CEf8O6jDuMoU0iujD9jEPOk8iXtWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q29mXoEv+ryE1iOb6I5kbL0d/lycJcSjzJiY3xl0tcuVSDSgjIjO8yWIjtkT3iegwXMD5TQqQphCqio1WJfl8gOGl+o+0p5aADl+/1VT6O2ciS1Q6lQzB6/2GCuj9/hxzUntOsfjZJXo0DLTTaDgPV82PdFHbnBVMmdlyrL2CX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Ulpd6K4o; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Ulpd6K4o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK8g6Pn4OCgszMC18RgTda6wWjNd9O3ZebWAhCeIJuASkyXJxkgUHOKZYDoCL4oIz8Rl4XW8FJAxVfDp7scVijbUelrM//DDPf/3R30XJ2i1l8GGr3kNMkubAbMyvjvpDnX929Bqu2dMkK5TCX4IcStr4VoCstIcg+kF9Tsw3757u44v6F9fEaOhFSTCZtA/EvsSSFJ9Rb354Iu/7R7x8t4H74lJL9zNmFgKJN49hUhVvrqfAeSgdUE8zCJ/dM9dpnbX51AtrQ8DWyQKIRYLVOjSfBe/2XNvGjP9tZqihHMtWHcNBaGPaNBGj+fsGUHR9b6zDlqe0Wkx52NKZKh9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkCKz1HfQvMfbxECygHhMrwl8T4eVRAFNwjGavGmZPk=;
 b=ARGciEe0piHgWV3eRpNzZKrjQMw5CEJN1oE4NaJpiSjq268xG9P4rEXhqzfzjZMozxfiWhZtOY65RVVHHtcHBXQVFhPeZpGMiI5sMfHCVdqwewsxtxb2L7Y7ZCQF35grSllIwbXAD932g3k2Ac75mWnXBqI32DYMuPqb2Ih9DlnH4XzkbihaFQj6rQUesiYqfknbtNwxJrqOn8qaaCYYllsWleRNmj9Kf7zIt7fj278dHv5neDlCaukNxQsvTON/SI3I0Y8wtiuJ1ZE64UaESDZYZM5IpHTAkchZ3TSBMQ1tT10CxbwOd27S6p2K9wQ5AHVzqLRoBV1bPvFZ/uZkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkCKz1HfQvMfbxECygHhMrwl8T4eVRAFNwjGavGmZPk=;
 b=Ulpd6K4o9znuU3htCWC8OIcXe2xA/20IJOxFfVAfLSjRvvGSvZn3VaeS0LJHBQo8jsyAPdPcd0S0G8hbbNe9zpKiLJyCbRZJgWT3d8Dy20KdrQ/IoA+Z11SJGcJrQfu8Yh7fpFp6E7Acf9WNVNmPH/OoiYLorQzuGkFP9MVWawc=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by SEZPR04MB6573.apcprd04.prod.outlook.com (2603:1096:101:ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:14:58 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 12:14:58 +0000
From: Pu Hu <hupu@transsion.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "naveen@kernel.org" <naveen@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi
 Li <jiazi.li@transsion.com>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: Pu Hu <hupu@transsion.com>
Subject: [RFC 1/2] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Topic: [RFC 1/2] arm64: kprobes: Do not handle non-XOL faults as kprobe
 faults
Thread-Index: AQHdCVM7HLrAaqg1XUaD3E3iABCOTw==
Date: Wed, 1 Jul 2026 12:14:57 +0000
Message-ID: <20260701121448.3926-2-hupu@transsion.com>
References: <20260701121448.3926-1-hupu@transsion.com>
In-Reply-To: <20260701121448.3926-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|SEZPR04MB6573:EE_
x-ms-office365-filtering-correlation-id: e8964b4c-fe8f-497a-ca3b-08ded76a5e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|18002099003|22082099003|38070700021|3023799007|56012099006|5023799004|11063799006|6133799003;
x-microsoft-antispam-message-info:
 Grz6jS8IqeKm4cqKCq1empTSDAy9LwW/AlRQ2lgI+ZFoguJDu7NFfnrMewmv+pjrWffIs09RnXyBTaQUNileDHb5ZWlb4szzfOVe3QTihd6+hJEJfotX65OF5o2HPFwBl3S+kLFB3YQfAXUDhbWjtabc4OnSC7ikZoNXPQG6elxO33eIegf1yFXR0GSnOPAgS0gLsJI3zLseisxLPtDZarcaMOXv0QWm3+PB3oF54WN072/1ef1wF3UKcYc5UnaTrmn0ijMaccZ3vecywv8OyNKG/iFE0eo8TkWMsgGxvzq41pqGB/cMWSnGUy8zSjinZ95WYMTODspxrupLhujq36Jra1nnVaJ1SHrgZm/W1FeUcEB5Kdk0H/j/uDAChGwR0P57fMf2UFFicLSqJHsotPmrB+awUnORVfGSxiYOhjSQKtxgqoCx1/th8gLcp5LIvDOmo2qGWrZC5SRrvKmHAW91/h8tQfLOLwp9Ll0Pzu+A1rYlCJSe83Z9/KYiJa2YVdKIMvONzf6YppzWViVemGxGyPg2WA6rSBONHlYprf4DsmvDzJEo77fdMvBpHWOO4u5J2sIxNt/kxYya0Wa6yjTlzOkgrhGUBRBjPiHHc7vPJCZrKoLp+SKmf6IFe3/TQSa1rvMNrd53kvQl3yYGsiBJB30tMyYFvFSWlTPD/clvwbeBllj8rqBApfVT2JpK1r9WcfveCG6TtOCSSUpzJm/jxyVSOv42TywIGTmeoJg98vhQcsRoFtt90gvOAvIN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dDd8n2g6uwApckWKbYc9g1eomm9zpbX+S/StK6kuOlsjQEgZ07rMdLrgR2?=
 =?iso-8859-1?Q?qIuTVPKoopW20GWuGn3fpGVU0sFqEneY0LWcRwBCKUiu7Cwh27l5gtLqUW?=
 =?iso-8859-1?Q?23NEtisfNezTSuFfDPLl4efm6TweyNCRo7HH1qUXqa9YGfYcAP9KTBA3cA?=
 =?iso-8859-1?Q?PUBNNa2UOBC14CxXepGTj1Gt/jkwAAU6UiCpBMIzokeJC0+Km0zwATzbqg?=
 =?iso-8859-1?Q?z5Gc7mhyG+RlY3bi7KlXpVPIvTVBLpIap9kfuKe45IQz8FOhZtEW4Opccs?=
 =?iso-8859-1?Q?7C5FetB/u7WL745++Lq8WiBv/pVHWsomCJV4sedYy9db9WaRx8Z5lyBsHC?=
 =?iso-8859-1?Q?2SUkXkvkUvlPGgVkWb2z2QjLg+ETgg1EgH5w8Us+QC6bFdMdiTsaKOkS9s?=
 =?iso-8859-1?Q?EsExaxC8d9xn1RVLxVv9M7xfaNT44EA98lU4DVhbTxW9SVULaTrpRLDlgV?=
 =?iso-8859-1?Q?03bLJIezSFfpL7BcJz4WPwT/us+2KtOrf2ojDOVhwF/wRhW/mhtcF/svgj?=
 =?iso-8859-1?Q?os/QrVQn1lchNTwhlfQH+bRq/5fF0E7irM7Y0wX7qKOsEdFKAMNO0xiDUV?=
 =?iso-8859-1?Q?qJUbYT9ctz+pOLgU0s2eVW+VQqB2EJwsUQWqMFGbpQQkgv97vWDtMOgaTL?=
 =?iso-8859-1?Q?Jux/G6CM7ipybKo5NuRVeWvWpdVQaHNPoqviIKE6MUk4r+05r9AFYyzvZM?=
 =?iso-8859-1?Q?J1DV7mw90RxI8EIrGFWMoxd0hhf9ooeeai7l+9YmclxnD97Vd7ffmeBa/b?=
 =?iso-8859-1?Q?edsN8VkQI6iGFSPf7Ip+l4O+TcOjJsJcTQMTCAlVYtCkmaP7Nw/sh6fPeg?=
 =?iso-8859-1?Q?Jf4qgwEgJF9xbGx3vJV3hApW/eLuszY0gI9MbCKuopijltvgb5Yho2petE?=
 =?iso-8859-1?Q?0CDMbXkgn6x8c9WLNo3ZeGw1ptybvgQ+z3HIIGbuP9lmU5waC4SJDXqNfQ?=
 =?iso-8859-1?Q?luEJ2h7CFkxxYsMe0Wf55foaGTNkEkrpeZDkwUzpwt9RPUxYIShi5J7S8O?=
 =?iso-8859-1?Q?4t4oQEHz2iAds3bOJv5xMvFb+0sCS0X5HZ3F+WI2dDZldvjuUWElTjJ45C?=
 =?iso-8859-1?Q?IIM0kMoDQPqROuwZy/sCV5JiWUI5cVO7+xP4aLhQjfMN3s8LGbVDtZLB/u?=
 =?iso-8859-1?Q?NrPFXnL/6gvy+rSyUJzWrUvDicljRKv7YipMg9Y8MKeU5ufqzfBzsb9J/c?=
 =?iso-8859-1?Q?nMoMB4eYjw/5JElgnausfrqLF/DxAavfvuVvB3YGXsNaMlT4AMCYSYn2ZN?=
 =?iso-8859-1?Q?N3Ny0kvyu9lI80iNDCDO08Zjm6munzyx4NSkz/sFYXCZIRD3RGJkSTC5HS?=
 =?iso-8859-1?Q?BVLi8M7ZYx52IJBAaOCOXCKZ9mJEXMhEU+TVTW6JuM+IfRApheXoJhBdNS?=
 =?iso-8859-1?Q?R3GDUL1HDQZFp8Feg/+XPDumXOsS+aEahyfxEVLVSDZ/LSipoRAnrzUqrF?=
 =?iso-8859-1?Q?4yTAMmCXvl/m+vWPNlr8OOHF2uEqckThrI/GT71Zc6z24aFe5hboMstHVx?=
 =?iso-8859-1?Q?oYbfrGoBCpwKTYrHWHLlCljKHLn7TE2AJG1D74rsdd43W355hv0jkkPd0N?=
 =?iso-8859-1?Q?IVA56cmn/bt/gTnpwTOmSwkLOXN5LpwcffHfoUc9FYfU5oLQFh5+At/HoV?=
 =?iso-8859-1?Q?eQdYsgTznqJ1SrXR/H9IHFn7H1XhdLovs487sgNk1680CPIBLVivu+dzPe?=
 =?iso-8859-1?Q?hTe3RMJwEU0CtlJocYtb6Oeg6g1sKzktwj8xR53gJcaMj8ckXMg4DQuYQi?=
 =?iso-8859-1?Q?fvA3hT3Kcdlfj3Gsx23mL80GaDSwemUeBb2fhTa0gp5HsD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5648.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8964b4c-fe8f-497a-ca3b-08ded76a5e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 12:14:57.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSrn8gYReAPTMybZja3Eorw44GBNrZPJsxXa/FrSdBUvIb7E+QjIFsR5zdeh0Myi0WITQk3H28HyJjW4Z67TKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6573

From: hupu <hupu@transsion.com>=0A=
=0A=
kprobe_fault_handler() handles faults taken while kprobes is in=0A=
KPROBE_HIT_SS or KPROBE_REENTER state as faults caused by the=0A=
single-stepped instruction.=0A=
=0A=
That assumption is not always true. While a kprobe is preparing or=0A=
executing the out-of-line single-step instruction, other code may run=0A=
in that window. For example, perf or trace code can be invoked from the=0A=
debug exception path and may take a fault of its own. In that case the=0A=
fault did not happen on the kprobe XOL instruction, but the kprobe fault=0A=
handler may still try to recover it as a kprobe single-step fault.=0A=
=0A=
This can corrupt the exception recovery flow and leave the real fault to=0A=
be handled with a wrong PC. A typical reproducer is running simpleperf=0A=
with preemptirq tracepoints and dwarf callchains while a kprobe is=0A=
installed on a frequently executed kernel function.=0A=
=0A=
Fix this by handling faults in KPROBE_HIT_SS/KPROBE_REENTER only when=0A=
the faulting PC points at the current kprobe's XOL instruction. Faults=0A=
from any other PC are left to the normal fault handling path.=0A=
=0A=
This follows the same idea as the x86 fix in commit 6381c24cd6d5=0A=
("kprobes/x86: Fix page-fault handling logic").=0A=
=0A=
Signed-off-by: hupu <hupu@transsion.com>=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
---=0A=
 arch/arm64/kernel/probes/kprobes.c | 14 ++++++++++++++=0A=
 1 file changed, 14 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/=
kprobes.c=0A=
index 43a0361a8bf0..e4d2852ce2fb 100644=0A=
--- a/arch/arm64/kernel/probes/kprobes.c=0A=
+++ b/arch/arm64/kernel/probes/kprobes.c=0A=
@@ -285,6 +285,20 @@ int __kprobes kprobe_fault_handler(struct pt_regs *reg=
s, unsigned int fsr)=0A=
 	switch (kcb->kprobe_status) {=0A=
 	case KPROBE_HIT_SS:=0A=
 	case KPROBE_REENTER:=0A=
+		/*=0A=
+		 * A fault taken while a kprobe is single-stepping is not=0A=
+		 * necessarily caused by the instruction in the XOL slot. For=0A=
+		 * example, tracing or perf code running in this window may take=0A=
+		 * an unrelated fault.=0A=
+		 *=0A=
+		 * Handle the fault here only when the faulting PC is the XOL=0A=
+		 * instruction of the current kprobe. Otherwise let the normal=0A=
+		 * fault handling path deal with it.=0A=
+		 */=0A=
+		if (cur->ainsn.xol_insn &&=0A=
+			instruction_pointer(regs) !=3D (unsigned long)cur->ainsn.xol_insn)=0A=
+			break;=0A=
+=0A=
 		/*=0A=
 		 * We are here because the instruction being single=0A=
 		 * stepped caused a page fault. We reset the current=0A=
-- =0A=
2.43.0=0A=
=0A=
