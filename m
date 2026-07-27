Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023129.outbound.protection.outlook.com [40.107.44.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DC405C25;
	Mon, 27 Jul 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155157; cv=fail; b=sGWWYn9kkcp39lOCzQZfgs0SuvWCCoI04Et4x+2OOp79YXeElfigGTCeLRxvOYSVLT/hmTmopKqL+6h6TwDcobtbjjdFanf/Tf3bAxOnfhYspvLwqM/dJmDmm6+CHm+r5HrtWDfTZOE64RN+P8wlPU2com2sLnBT7inS3uDyYp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155157; c=relaxed/simple;
	bh=0DOkqAG8UjvRpKCo4KB/MmBoqBG27yKxATKwxjtOcOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uh+cvfakt5agNHayaJ/pfgV9KZT1RmDSvWP6YZaKYeDdvYgUplaedneQx70J+2xA0uc/atxRwEyrdiCl9f6XV7nEqt80TeMkoZV3ttMyB61WVl44G5zspkxIUYAhn9oaxFvH4weZ1VXjbfsUtcP8M8p1Iy5f1740ukJYTx3lpWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=NTVEOsUc; arc=fail smtp.client-ip=40.107.44.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="NTVEOsUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht/EHav3yf2pKMcaFJ0QGDegWfF0lw7qUj6eWJijalKaSbISqufrQW87CpI3l56B7wpD45SgBOs5Isc1lGy9kfsbMgthnvvruM8TFZDRIeKcGdu4Y7Kx5V3T9HAOHwt8gJccQ8xXOAHKdnYZglmKNkHobLy1i6qnFOxCyZQYn/2q6aisuW8GvCFMrM4h7QSS1eWCnAUJndRvD9PjlBc0BF2nmU+jkatpv6eM96Uz8VFG/wjs6bkjl3zFYxYxavOIGZYyjyUlq7uBgEjZ3TKEV1zhFCzx0Is4YPH8m4n7C+hKpslq4J7HSE4Aw3j6Z2Hkh5bBiIRBUBjuYznFyv9zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkDK9YxlxfACMs2dXWNaZujqmL3nFzsNssF9dz81le0=;
 b=feP+Juxykkd3Ysk73I9EhBGJNHSnoHBOryiub1RJoZarpMSCxEJuTDsOkvwo60Ir8e5Mf6iBb5dTpO/4wPJ6A78aRKJO/64oxMPvTv462QWsK+DamvJH0sXbuAIwE4nG/dvMLfrHvVIqo69loEWaD9ZHsrLgwPSXU6wL023U+tn7tiLusFf6y6lR6na0JbDuosw0aNW4euv9y/vUU6m0QOOIP05GTDNXezYFPVJYJxXrk+Mv6km7KA5gD+c5gpri8MfrDn2PkWZ9zC/MXJ7w20s25c4OktPk0ecN6aZ/ZQ/6K4l+l5ts2gGg8vGLglIGNeue2leJL/ft0LBM0kZYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkDK9YxlxfACMs2dXWNaZujqmL3nFzsNssF9dz81le0=;
 b=NTVEOsUcnXsEM+/rMgjjbLFjsZf/I3fK/P1nXwUxyuqMEc38s2D63cAZVGkpj6clr4cLuKZyAobhCw0T/LQxW5YXCHCAdETbJAi1nogfOLkv+Ja8K1g6H8aiFL4tiQnkWZcxjxOoDRw6fzAarJzfsNTUCEe0FpA/hw/Dapfj+Eg=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by TY2PPF7B73AC350.apcprd04.prod.outlook.com
 (2603:1096:408::add) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.8; Mon, 27 Jul
 2026 12:25:49 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0270.009; Mon, 27 Jul 2026
 12:25:48 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov
	<oleg@redhat.com>, Naveen N Rao <naveen@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
CC: Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Thread-Topic: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Thread-Index: AQHdHcMO39AcF/TaiUWqS0RapTlJlQ==
Date: Mon, 27 Jul 2026 12:25:48 +0000
Message-ID:
 <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
In-Reply-To: <cover.1785153469.git.hongyan.xia@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|TY2PPF7B73AC350:EE_
x-ms-office365-filtering-correlation-id: bea42550-5a6f-4c93-875d-08deebda30ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 32aJLD0EhwrZZ1sgZ3eO2HQFTxW7UR6waJA7xXggEevXs2i7F4taXBWE4EP/edM+T2RxWna30f/GL91mkmBpNyga2utzeLMmWyXouarEI0k3w9gOiKp2+Z8oLTqYFIh9zcXLA4bqp6XMkpyWPQ5TQ2VD8qh55tFmp6kZ0JKxw4lBdML0miOWfXKWWSlhZncws7WbgRl0BDTuj5zAWpX9yP98Ia/NwDCLjLqzBobGcdgsTYkYG2m02nk4Dza9hmRewLzRNJS0EIUK0xDOujQ6T21cJuGqbvPKc1N+yfXxYnvckCFC7ni0Ec2z7ITBUtfQBtVXtKx3p+0o9y7PorDZqVCIPtCCuMcnSLVj5yfNfS15/KyoYQUtUr14FXHvE9oSipfyUiR6wD6oIiOIbtaU2n1dOWZSnMl6iEyWdHeUNTR6hOBOYFOiO/TQv65d5cwhnpv6+/pESmnV1GE5jyndm0o/dTfVjBiMR1qtQBBc50zRD4DnIwcHIy1WeLSfKrv86DA3Ia+DgEBjcMeZheVab9/ar4rJobqf+/1vXlQCpdVa8JlSnu2DJjvOsQtKAhgXhMUmHNvjwGAYLzvD55Rnz2gCL63HrAtK8KVBl7H3PrzhrhL9pFyYjWagtuvPMUZ0U93YdX1biuB52CoXxN8SiLGfAMzCcJ5gYCt6C/Qo8q4ltHX+N+gV/Ld9lB623jKqEBwtdTwhc7XitHKEUSeZmyrWxSLrU4KKrohrN+5qX4jw6oJh7M4esFLAIKPM9Pqe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9z880sOpwqxsSgPcg6EtGMw25SwxyZ3E++SZZ0iw57MGfdo74zvaJ0G+pW?=
 =?iso-8859-1?Q?HQ11YnhfeyPXrCw88BRZ3V+9uylGKcK0ntQINgXTVgam7zYO4wq1U5Kd02?=
 =?iso-8859-1?Q?xAmr6FpNdpJ2pslxcQJ52ZEXJmy6VTJPXvH7JJ+MfskQci1ULGHh7CTJEM?=
 =?iso-8859-1?Q?i4gdtF30Ak+WTPWRqEYprGVUlPXDhL4Zs8JeikOdAnw9RO8mH5ji6AhPtt?=
 =?iso-8859-1?Q?Aql7VxMzJJL5iNkE7Xagbs5ga4Vi8NJ6+kKGhBD17ajUhFt2B+QWQAlyeR?=
 =?iso-8859-1?Q?RadXS7MhDf+RWpcqzgaGns+Dc+xovWSO/jOh9J24u3R2kKQMDitTYfrveJ?=
 =?iso-8859-1?Q?QXaR0eNOuo6Kg5adYFdyROKFhU2/eRvvex2CqAbfLAoAD9B55S2AYqbt8j?=
 =?iso-8859-1?Q?xbYZrnWhmXlNnDoud4T3SUrfzZYFt36D/O5pH+NmYFCpq6GVLed0wvfkcA?=
 =?iso-8859-1?Q?UoHS1o4KWBk3vyFM/DnL2SJj+oFe7Ehu7UbYisH9An4eWDkub1FJHfhOOI?=
 =?iso-8859-1?Q?Tq6JsCwziqroPrwGWdcKVoKY5wm014YGHcJ2zD2Oq+dxtuG1gLn/r7KRse?=
 =?iso-8859-1?Q?YfVaZqYW4LSGg4AkFtu+Sff9YuW0UIFwS4sgOGC5tmdcHdajXtR6PBpYjb?=
 =?iso-8859-1?Q?709D/g0rOz3MKrvIaTP2o7pQyyeyTPa357CTWvAaOGOvEAGdhBDarnpJjq?=
 =?iso-8859-1?Q?pvFRF1apkR8hsU3KtvNLA3vYMVnjItSAp6TvnjDi4qPFOyDaHzhDGtVU55?=
 =?iso-8859-1?Q?QDgQlskDd8p/8c+3YXbOCEsT89L8KhV+Nky0Ue+QllGAUBohQSQz8d55cM?=
 =?iso-8859-1?Q?QsbNvFGTNUcR7GuVf5xuW0EA5Oq/95KyTGkvSw6puiG55E7miOVyUASg18?=
 =?iso-8859-1?Q?pM8zJ1roOqudgwnkdlOCK7Ra+DUmDrwjRHR5Omp5qGriBD0oTv0bys/48B?=
 =?iso-8859-1?Q?2yFO+eIaJ6LB9WUTJ5DkMJUqLC0uEapMS0EOQTLfQNrrzRf/oMtxaratmc?=
 =?iso-8859-1?Q?0glCMqih/SLFpb8csb8Cb36XK65SPNZ3ObvpV/nvAYIG6CBhMfyT+mct86?=
 =?iso-8859-1?Q?BqrR5+p1V+3ZYAELEYE948i82D9fC1kxUZEVxEvkRp7JdwskiXJRLXkP10?=
 =?iso-8859-1?Q?1blZ8RpqwDam2jb5wczeOsZRb8JLVemw+NLJLO3SUYIJTPhOeQFieB9EMl?=
 =?iso-8859-1?Q?x8BBvpU3rhGcN/wIBsA9enRwVX5WziW/WoTSkHpu3lmVFwGl5bCLILM8Fb?=
 =?iso-8859-1?Q?HSJckwzNqBpep0fecpJyvv85jf2W5efEUV5+Rvl1Es12op/SGZd7S1kJ6W?=
 =?iso-8859-1?Q?Ue+8id+5uDCzdX2WmOolthhSeDYzrfof3qNA/wbaQUcfkbslKE/bDWtGOI?=
 =?iso-8859-1?Q?PKbW6v46dCpq6lIkUuaqL+9qnlNuA2VHD+SNl5BCAwY4OK2ZOII4SnD42Z?=
 =?iso-8859-1?Q?54ywoXscX1apjur3nkriCKDPr2lkS7ajkzqOt/3sDG2y8elLbpaEYaopbQ?=
 =?iso-8859-1?Q?d241XQcCvuzyyXZM95itYJGklMcYeTb5G3302MDPCUnOMPKJHEqFaJp+vK?=
 =?iso-8859-1?Q?xpEk1YRmhd1Gb0wIZcVNmiOpAcOTVrMe3b4duLg6W2fnC32QzkVFX7bynh?=
 =?iso-8859-1?Q?/UdzcJOJngQpnCFNW7STWD2lbxm7w+BRia4un3miqqfX+83lPFz5W6ajxP?=
 =?iso-8859-1?Q?pab3HfUo4gkPt8IC0ft2I6f8+lWg8OCvNqdVAwJJh3Rx/B2mpzm2kVr1a8?=
 =?iso-8859-1?Q?YbxqlNFpHr9vRzSj3JxRITGK8pnWw3Vez5m8qNpjdl8h7yTGAwFmqL/RKi?=
 =?iso-8859-1?Q?C9fT2RUu/g=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea42550-5a6f-4c93-875d-08deebda30ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 12:25:48.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmJtaqrStCuOU9AZlTHaANYEljGKmiZg/teVXiplGzOf0cq5Tqtc912RozZTEBWgurdfIZxIRTXdBzH32N+Gmf1AH4dQLon2K7d60f3+ba0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7B73AC350

From: Hongyan Xia <hongyan.xia@transsion.com>=0A=
=0A=
Static inline should be enough to actually inline functions for most=0A=
compilers, but my Clang-19 somehow thinks it's better to outline them.=0A=
These tiny helpers then live in normal .text sections instead of=0A=
.noinstr sections, violating noinstr.=0A=
=0A=
Mark them __always_inline so the compiler can never outline them.=0A=
=0A=
Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>=0A=
---=0A=
 arch/arm64/include/asm/esr.h       | 2 +-=0A=
 arch/arm64/include/asm/percpu.h    | 2 +-=0A=
 arch/arm64/include/asm/preempt.h   | 4 ++--=0A=
 arch/arm64/include/asm/ptrace.h    | 4 ++--=0A=
 arch/arm64/kernel/debug-monitors.c | 2 +-=0A=
 include/linux/kprobes.h            | 8 ++++----=0A=
 6 files changed, 11 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h=0A=
index f816f5d77f1a..a75bfdb7e5fe 100644=0A=
--- a/arch/arm64/include/asm/esr.h=0A=
+++ b/arch/arm64/include/asm/esr.h=0A=
@@ -437,7 +437,7 @@=0A=
 #ifndef __ASSEMBLER__=0A=
 #include <asm/types.h>=0A=
 =0A=
-static inline unsigned long esr_brk_comment(unsigned long esr)=0A=
+static __always_inline unsigned long esr_brk_comment(unsigned long esr)=0A=
 {=0A=
 	return esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;=0A=
 }=0A=
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percp=
u.h=0A=
index b57b2bb00967..d4cae47fde8c 100644=0A=
--- a/arch/arm64/include/asm/percpu.h=0A=
+++ b/arch/arm64/include/asm/percpu.h=0A=
@@ -29,7 +29,7 @@ static inline unsigned long __hyp_my_cpu_offset(void)=0A=
 	return read_sysreg(tpidr_el2);=0A=
 }=0A=
 =0A=
-static inline unsigned long __kern_my_cpu_offset(void)=0A=
+static __always_inline unsigned long __kern_my_cpu_offset(void)=0A=
 {=0A=
 	unsigned long off;=0A=
 =0A=
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/pree=
mpt.h=0A=
index 932ea4b62042..326f221c3f56 100644=0A=
--- a/arch/arm64/include/asm/preempt.h=0A=
+++ b/arch/arm64/include/asm/preempt.h=0A=
@@ -41,14 +41,14 @@ static inline bool test_preempt_need_resched(void)=0A=
 	return !current_thread_info()->preempt.need_resched;=0A=
 }=0A=
 =0A=
-static inline void __preempt_count_add(int val)=0A=
+static __always_inline void __preempt_count_add(int val)=0A=
 {=0A=
 	u32 pc =3D READ_ONCE(current_thread_info()->preempt.count);=0A=
 	pc +=3D val;=0A=
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);=0A=
 }=0A=
 =0A=
-static inline void __preempt_count_sub(int val)=0A=
+static __always_inline void __preempt_count_sub(int val)=0A=
 {=0A=
 	u32 pc =3D READ_ONCE(current_thread_info()->preempt.count);=0A=
 	pc -=3D val;=0A=
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrac=
e.h=0A=
index 39582511ad72..460726224299 100644=0A=
--- a/arch/arm64/include/asm/ptrace.h=0A=
+++ b/arch/arm64/include/asm/ptrace.h=0A=
@@ -336,11 +336,11 @@ static inline unsigned long regs_get_kernel_argument(=
struct pt_regs *regs,=0A=
 struct task_struct;=0A=
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);=
=0A=
 =0A=
-static inline unsigned long instruction_pointer(struct pt_regs *regs)=0A=
+static __always_inline unsigned long instruction_pointer(struct pt_regs *r=
egs)=0A=
 {=0A=
 	return regs->pc;=0A=
 }=0A=
-static inline void instruction_pointer_set(struct pt_regs *regs,=0A=
+static __always_inline void instruction_pointer_set(struct pt_regs *regs,=
=0A=
 		unsigned long val)=0A=
 {=0A=
 	regs->pc =3D val;=0A=
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c=0A=
index a970ab6327cd..66cb8151f5df 100644=0A=
--- a/arch/arm64/kernel/debug-monitors.c=0A=
+++ b/arch/arm64/kernel/debug-monitors.c=0A=
@@ -146,7 +146,7 @@ postcore_initcall(debug_monitors_init);=0A=
 /*=0A=
  * Single step API and exception handling.=0A=
  */=0A=
-static void set_user_regs_spsr_ss(struct user_pt_regs *regs)=0A=
+static __always_inline void set_user_regs_spsr_ss(struct user_pt_regs *reg=
s)=0A=
 {=0A=
 	regs->pstate |=3D DBG_SPSR_SS;=0A=
 }=0A=
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h=0A=
index 8c4f3bb24429..5880445ed0f0 100644=0A=
--- a/include/linux/kprobes.h=0A=
+++ b/include/linux/kprobes.h=0A=
@@ -384,17 +384,17 @@ static inline void kprobe_ftrace_kill(void) {}=0A=
 struct kprobe *get_kprobe(void *addr);=0A=
 =0A=
 /* kprobe_running() will just return the current_kprobe on this CPU */=0A=
-static inline struct kprobe *kprobe_running(void)=0A=
+static __always_inline struct kprobe *kprobe_running(void)=0A=
 {=0A=
 	return __this_cpu_read(current_kprobe);=0A=
 }=0A=
 =0A=
-static inline void reset_current_kprobe(void)=0A=
+static __always_inline void reset_current_kprobe(void)=0A=
 {=0A=
 	__this_cpu_write(current_kprobe, NULL);=0A=
 }=0A=
 =0A=
-static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)=0A=
+static __always_inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)=0A=
 {=0A=
 	return this_cpu_ptr(&kprobe_ctlblk);=0A=
 }=0A=
@@ -449,7 +449,7 @@ static inline struct kprobe *get_kprobe(void *addr)=0A=
 {=0A=
 	return NULL;=0A=
 }=0A=
-static inline struct kprobe *kprobe_running(void)=0A=
+static __always_inline struct kprobe *kprobe_running(void)=0A=
 {=0A=
 	return NULL;=0A=
 }=0A=
-- =0A=
2.47.3=0A=
=0A=
