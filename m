Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023135.outbound.protection.outlook.com [40.107.159.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EA442387
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772095; cv=fail; b=S5ODPUUDXZayqUgJcYUiAKFi5Ltb+Xfbu3qS+HE2SnN7Gz/KXYlVY+6EVRhYQ9+x9J5pEGZa6GSjfDLxBH5Zsozc4XCKHmqeTjZKmHflGXrEy0xMt22TDYzfh89l1uWoJzzBWbIyXjZIm29znvJMBQErSEFgAj+WSgM+FIO7p3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772095; c=relaxed/simple;
	bh=L8Bedn1fmlk9fqllz6UzfMKq49K3XgDqTu6fovX2Y8o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XV81HQvpS5J3JrwUAjZ7XYeYMRjDSA7ir9mP08jGt+faUONw/+soJPnduvC8YaL2rtJrdg3CvOw6PdrMbB2joRecv/L4HTa1Nw0ZBvulvmPPFxtq5NrCTuq9PzuWds7NVQNp+t71JyQ5qW25QuARdEnd5eo3DmTnCjKcEjQzy+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikerlan.es; spf=pass smtp.mailfrom=ikerlan.es; dkim=pass (1024-bit key) header.d=ikerlan.es header.i=@ikerlan.es header.b=fzbrPxul; arc=fail smtp.client-ip=40.107.159.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikerlan.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikerlan.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ikerlan.es header.i=@ikerlan.es header.b="fzbrPxul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7ZFJALRGAQg1EtR7yS2jgjhrHu3vZ63SpH9ZTl0sgFgUzT+R8cAt052KU3BSIg6Bs4GhxzALriPpvLZwT6yOti/zj6CdNb46Zfhg2fwir5eyQKJx7f5gBZ1PX1GK46aOSXmDsBUgzsV9e433Op0pFt/mzIuKZNiDW3/sCcLdz3NdPeEWxoFoc8BlQHu6XF16ip5P/fyNzM4AqG+q93nYKqf2bdYgZw56FdAO2ZGURCZmG3QLPNCYDrPFhwv2T2jSOrgOKGGhMO3GfhvHzBrjKB3LLD+8gswY8IoZSrJQFtJeBQrF2inAMq5MchVLH+/SEK7cR6cJeCxKakLLK8ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93tonlTP6mC9XrPqKw6f52lebI/rikZVnejs9eyKrNI=;
 b=G4ZZOzWmIM8K2Tk0Q09MmQUPrgVvTHIx2B4pPt/LtoYnxXrO9/9irRE9yhun9327hV2YDSE7jxJXr7fVYvuHStNuw3W4mapSg2JuIf/VRxpowQTSBH69fqEbopxfSmL01hFR8m37zszIiAbr7/zIVkO/xseNlG1gP//8lPquusMj5xaAJnLlt3SwJQxa7nY+ZAcNYqskdoxY/LyOpNGBAjebEXG/jwkHx2cW67sSkw5vdMwrZ5fOYIqY7C0SXsiTYUlWqknZASKQwofAbg3Ud4OvexoyJjgcqQkLPqofPXypfIaEUlXoj8K7J1eju5vh+kZKSxayvU7IhD0Fg95hFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ikerlan.es; dmarc=pass action=none header.from=ikerlan.es;
 dkim=pass header.d=ikerlan.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ikerlan.es;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93tonlTP6mC9XrPqKw6f52lebI/rikZVnejs9eyKrNI=;
 b=fzbrPxulepT6OxPC2+nrxBXm/Qss0HSArWALchgpjH94kW4rBC0hWW4UQY5EYCHz04HCVLGwa15zcuTrk0fCRMp+BDylbduIn/Q9dRg9E2ohTx6Ri3/9T8VEyDiM1JH34zCRAUhVdCKA3YJyt3Zw5ZNV5P9HTOWbIAh6QBYHtgI=
Received: from PAWPR03MB9213.eurprd03.prod.outlook.com (2603:10a6:102:330::13)
 by GV1PR03MB8687.eurprd03.prod.outlook.com (2603:10a6:150:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:07:58 +0000
Received: from PAWPR03MB9213.eurprd03.prod.outlook.com
 ([fe80::8022:4f2b:847c:d3a8]) by PAWPR03MB9213.eurprd03.prod.outlook.com
 ([fe80::8022:4f2b:847c:d3a8%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:07:57 +0000
From: Lahoz Fernando <flahoz@ikerlan.es>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>
CC: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: [BUG?] tracing: unexpected behavior trying to keep IRQ code away from
 traces
Thread-Topic: [BUG?] tracing: unexpected behavior trying to keep IRQ code away
 from traces
Thread-Index: AQHdPELAHW3WRQNeNEeXNtt/mWTpKQ==
Date: Mon, 7 Sep 2026 09:07:57 +0000
Message-ID:
 <PAWPR03MB92138194E34B81962AA24738A2B52@PAWPR03MB9213.eurprd03.prod.outlook.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ikerlan.es;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR03MB9213:EE_|GV1PR03MB8687:EE_
x-ms-office365-filtering-correlation-id: 4d0e23bc-ed9f-49c8-b911-08df0cbf8241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 ZrMtwnz5ZWqfgJd1oexUwIIIq2/NlMZSeOUByqi1nVnpi+QjiMaxoeGfprsXh5JnCv9B+WHVX4jsMbQ75BaXwkmMamE3+Ui8Low4KpY/LOayvpVdPxt1xCLe4NCdC8to+KHm2CG2dBe27B4iK2huixvt0DW3jZGJpjzsXu4gPx2oB1ukwizmHQOqOxYCPGBfMtUOzlpLEKQQx+mefpFK1T+bAF6uU8+vf6Ss6MAE5R7613MM6oTvPDNzawdfrixqdOO+Eg0iGP1yqAWsUg2hvrTDl2oyREzJiStuhC0IEJ+LmUIK7zD4SQYZs2FQbcNNcSHrY/42jPe9a1T01N3/8Svr/EGilam0AOmev8HQx/cpGcxB/0QPGcIVpH22kFapSUwqrJ59rvkqsREmyP8UqI4RRl3bAgbbXRn+qwAYpm10FfxBebu6U8yhcd3L09nxXbMN4APjDa+uZa00naURQPYc2rp4VLkXyS+rdNaeogKHjEIw9qzAiLRwfBpaWatzPQAx6gzw/embt1tBgncK6I6fi6FetZyjZsSC17RS78m8CTx5wltorrx4UfHLvgraC9iYojdtFAD35bHGgqAlWqgRBBf8nzX3/Ku0XqbPldOFc29wUe0vizf2qb8ZQFxDSBh3aY4vgd76kGOnWRpsLyfaUWJQkI/CFtf2GkJ1tGCTeetgBNnKYKHBYIUVsVmytNFuIIWTtoorCI6Fmg6flg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR03MB9213.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jlLzdoHDcdHAI2P6R215Nu22T5GBez6id/VNDUhdIkwzoVfslBhsnP8OZk?=
 =?iso-8859-1?Q?eWqmEj725lC0A34jvbcuFFtjg46Nee0ScZko3kooweQsEaI1XOzLnuyTtp?=
 =?iso-8859-1?Q?OFi7tJmMziGNODn6djZJxNhaa+HgVBTeqY/JKiFMK5NmGhNEVzUGuyXv5h?=
 =?iso-8859-1?Q?YCCldJ3fx4eJmc+vQI1CSB2SrI/I1qB25XooD2P8RSVWBGEi4kfPJNUPGN?=
 =?iso-8859-1?Q?AZXsLE3G48gFG/Ht6IadYUWlozl2sAAGqQvwtaz1DqhUTUHwU1+D92sa1p?=
 =?iso-8859-1?Q?lvS3fU9uFI6ADDPhAk4br3fQrY9nj7nhsglYxV0ZsUBSrogmeDsnIMc2W1?=
 =?iso-8859-1?Q?kTa7pR/CApISt0mspX4yB/0iyRcnkJFcWBWbE21vfVA41bhRZbmP4aSdK3?=
 =?iso-8859-1?Q?lnis//lhhFoNZNPTCvr0wWmcNBlHqd4UNapTf3uixxqTpVkUlFIqkTqvPv?=
 =?iso-8859-1?Q?q4Kkowyd8EAeMjSy3w8iDKl/TiHDn14LeDw8dugtz5NizuXqmaOBr/WLvo?=
 =?iso-8859-1?Q?NkIe2x8OEALJM5iaL7lN0jCKMz6nskd5w7uGlQLKQue7zkNHcfkmoZC2JW?=
 =?iso-8859-1?Q?L1xpWCl1/Qxa42GC8UezPEF59GAJNeJc7ejGWuLf3Icue8+5Wsnxk2ag9u?=
 =?iso-8859-1?Q?IeCjVRz8GWXnAYjnW3MJ2nzKAy3wI8q9BJre3s7VsNiX5ZLJ9BXTH2p6xh?=
 =?iso-8859-1?Q?qG1ortwP9x3iS+Y6d7uGckVieMauVG27k/eZwfQqKbqnJVjf0dfWCaCxlZ?=
 =?iso-8859-1?Q?rno4MtE3GAy440Aqyf6zld1ys/HIJ0MM585akuL9cohpecuowMM2e5CwGf?=
 =?iso-8859-1?Q?OZzInLZ2HbJxDjpjmXOcdYm+nTLXTNPJkd25U1yk9xEljMtV3NxyQUf4nY?=
 =?iso-8859-1?Q?XY4RqyxL8/mjTZMyw2sa79J0aicdiz9Xn+8f8p7DiBB55qhGSZEIVJErsV?=
 =?iso-8859-1?Q?w9sAjQrKGfU8M0CCAxe3iS5VG8/o7V7mFbNQdKagyIYa61QlOg0cDTQBcQ?=
 =?iso-8859-1?Q?G+YMvp+HXXfxh+9StvU1Ep98CPv2YQvKkHzIsVwY40lQHIbwUDCqfpjuUK?=
 =?iso-8859-1?Q?N+ASg9wDEThVGTSeH4CGL5kbeHugq6wsWgWpOBoROdDPtX5jyN0gcR6it8?=
 =?iso-8859-1?Q?xUTJ19v3H79b3yfASgquQ3oIU8jfaxyNrQkvQfCmsQl7bNibCTwo4aEcH5?=
 =?iso-8859-1?Q?aIiIU6NgC3jy9zRBr6DPXUYDiqywIjBA9LUKpsKwU+JOS57AOB68h+IJto?=
 =?iso-8859-1?Q?ENYk8YcPTKnltPpXZc1Q3qRFIaSq/MhFaAxi17vAg9YDySzQA5+PQk5/lu?=
 =?iso-8859-1?Q?jAI/PczUpTZo12zIxo5StKlcEkkqR20wwzIivxs+80ZkaTid33PlIKrrJu?=
 =?iso-8859-1?Q?YQFf5q5K1oH9VDgZNsjcFZTVXUQMR9HtUfSleW8UB93dudGD09GHyLDiPK?=
 =?iso-8859-1?Q?lzK9UDaSVx2Mch34G5GsMS9agjw1MSXWv/DDk9RqU5ccqrXH2BRuzItJho?=
 =?iso-8859-1?Q?sl2g21G+3Rfw+zSsyKysvQcFunbulIJb7otZfsv3t/Y6PCaeyuUq62/bqA?=
 =?iso-8859-1?Q?xD/Lz/hGV8FAXInEnQ09Q33t610yWetyDM1qKaxOZNh05OXiY9H16vEPdV?=
 =?iso-8859-1?Q?fm5qPWwdUQw4rwzfiDMSosAVU+RBz4qOTCzLxq7bCXS32qajE3ei3ZKiWk?=
 =?iso-8859-1?Q?hx6WKaYn2Uq2XZRUssbhBGl9Fe2FBZ/sKWFD6ilCS0wHHc1xHDXQq2Uy6G?=
 =?iso-8859-1?Q?VEMRwmwK/tOAukmrAenCQxi8RtyeP7FaL+aWKCOBHHSksH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ikerlan.es
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR03MB9213.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0e23bc-ed9f-49c8-b911-08df0cbf8241
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:07:57.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 910ac815-f855-4a08-bf29-90b46552cf11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QESU2vZ2eUTprhP0VRXFA+xbCU5M2ptXsOKS5xjYlOyxRdqadankDu03ieJ6yOM6idYqfmC1CwkLGGrFrmk27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8687

Hello,=0A=
=0A=
It seems that code executed during IRQ entry/exit may be traced as task con=
text=0A=
because HARDIRQ_OFFSET is not reflected in preempt_count until irq_enter_rc=
u()=0A=
is called. As a result, both in_task() and in_hardirq() may incorrectly cla=
ssify=0A=
some IRQ-entry code, causing IRQ-related functions to appear even when IRQ=
=0A=
tracing is disabled.=0A=
=0A=
=0A=
I've been developing a minimal syscall tracer using ftrace's api from a ker=
nel=0A=
module. During the process I've tried to prevent interrupt-related code fro=
m=0A=
appearing in the trace data, therefore I use the in_task() macro to filter=
=0A=
everything that is not in running in "task context". However, some function=
s=0A=
executed in hardirq context bypass the check, as they are executed before=
=0A=
preempt_count is updated.=0A=
=0A=
I was not certain whether this was a bug on how the flag is set or the inte=
nded=0A=
behaviour, so, I traced the same code using the function-graph-tracer with=
=0A=
'funcgraph-irqs' option active, but I saw the same behaviour.=0A=
=0A=
=0A=
I'm using a fully preemptive kernel, compiled for both aarch64 (this one ru=
ns=0A=
on an evaluation board) and riscv (this one runs on qemu). I have not check=
ed=0A=
if it happens in any other arch. I first saw this behaviour in v6.15.5 with=
=0A=
aarch64, but it's still present in v7.2.2. I have not checked older version=
s.=0A=
=0A=
=0A=
The root of the problem seems to be that there is instrumentable code that=
=0A=
executes on every IRQ before and after HARDIRQ_OFFSET is added/substracted =
to=0A=
preempt_count, so function tracers cannot correctly filter IRQ using in_har=
dirq().=0A=
=0A=
	(All the source I show comes from kernel v7.2.2)=0A=
=0A=
	In file: "/arch/arm64/kernel/entry-common.c" (lines 501-513)=0A=
=0A=
		static __always_inline void __el1_irq(struct pt_regs *regs,=0A=
		                                      void (*handler)(struct pt_regs *))=
=0A=
		{=0A=
			irqentry_state_t state;=0A=
=0A=
			state =3D arm64_enter_from_kernel_mode(regs);=0A=
=0A=
			irq_enter_rcu();  // <-- `preempt_count_add(HARDIRQ_OFFSET)`=0A=
			do_interrupt_handler(regs, handler);=0A=
			irq_exit_rcu();   // <-- `preempt_count_sub(HARDIRQ_OFFSET);`=0A=
=0A=
			arm64_exit_to_kernel_mode(regs, state);=0A=
		}=0A=
=0A=
I've tried to wrap this function between preempt_count_add(HARDIRQ_OFFSET)=
=0A=
and preempt_count_sub(HARDIRQ_OFFSET), but kernel won't finish booting up.=
=0A=
=0A=
Similarly, this also happens in riscv, as it can be seen in file=0A=
"/arch/riscv/kernel/traps.c" (lines 424-445) that irq_enter_rcu is called a=
fter=0A=
the equivalent function to arm64_enter_from_kernel_mode.=0A=
=0A=
=0A=
Test using function graph tracer:=0A=
=0A=
As I said, I wanted to check if IRQs also appeared inside the trace file wh=
ile=0A=
option funcgraph-irqs was disabled. Ftrace's documentation=0A=
(https://docs.kernel.org/trace/ftrace.html) decribes this parameter as foll=
ows:=0A=
=0A=
	"When disabled, functions that happen inside an interrupt will not be trac=
ed."=0A=
=0A=
so I expected it to remove every function called inside __el1_irq from the =
trace.=0A=
=0A=
I isolated CPU 3 for it to run the test program alone with taskset.=0A=
I traced with the following configuration:=0A=
=0A=
	TRACEFS=3D"/sys/kernel/tracing"=0A=
=0A=
	# Stop tracing and clean buffer=0A=
	echo 0 > "${TRACEFS}/tracing_on"=0A=
	: > "${TRACEFS}/trace"=0A=
=0A=
	# Trace only CPU 3 with 1GB buffer=0A=
	echo 8 > "${TRACEFS}/tracing_cpumask"=0A=
	echo 1048576 > "${TRACEFS}/per_cpu/cpu3/buffer_size_kb"=0A=
=0A=
	echo local > "${TRACEFS}/trace_clock"=0A=
	echo function_graph > "${TRACEFS}/current_tracer"=0A=
=0A=
	for opt in 'funcgraph-proc' 'funcgraph-tail' 'irq-info' 'nofuncgraph-irqs'=
; do=0A=
		echo "$opt" > "${TRACEFS}/trace_options"=0A=
	done=0A=
=0A=
	# Clean filters and trace only syscalls=0A=
	: > "${TRACEFS}/set_graph_function"=0A=
	echo "__arm64_sys_*" > "${TRACEFS}/set_graph_function"=0A=
=0A=
The resulting trace shows only syscalls code, being sometimes interrupted b=
y=0A=
code inside __el1_irq:=0A=
=0A=
 ...=0A=
 3) randbyt-14268  |               |            mntput() {                 =
 //__arm64_sys_openat=0A=
 3) randbyt-14268  |               |              mntput_no_expire() {     =
 //__arm64_sys_openat=0A=
 3) randbyt-14268  |   1.180 us    |                __rcu_irq_enter_check_t=
ick(); //IRQ CODE=0A=
 3) randbyt-14268  |   1.900 us    |                irq_enter_rcu();=0A=
 3) randbyt-14268  |   1.340 us    |                idle_cpu();=0A=
 3) randbyt-14268  |               |                tick_nohz_irq_exit() {=
=0A=
 ...=0A=
 3) randbyt-14268  | + 13.072 us   |                } /* tick_nohz_irq_exit=
 */=0A=
 3) randbyt-14268  |               |                raw_irqentry_exit_cond_=
resched() {=0A=
 3) randbyt-14268  |               |                  preempt_schedule_irq(=
) {=0A=
 ...=0A=
 3) randbyt-14268  | + 73.637 us   |                  } /* preempt_schedule=
_irq */=0A=
 3) randbyt-14268  | + 75.938 us   |                } /* raw_irqentry_exit_=
cond_resched */=0A=
 3) randbyt-14268  |   0.960 us    |                __rcu_read_lock();=0A=
 3) randbyt-14268  |   1.070 us    |                __rcu_read_unlock();   =
 //IRQ CODE=0A=
 3) randbyt-14268  | ! 146.225 us  |              } /* mntput_no_expire */ =
 //__arm64_sys_openat=0A=
 3) randbyt-14268  | ! 148.385 us  |            } /* mntput */             =
 //__arm64_sys_openat=0A=
 ...=0A=
=0A=
From here I suspected that funcgraph-irqs' implementation relied on the sam=
e=0A=
flags I checked in my custom tracer, so I searched inside the graph tracer =
code=0A=
and found this early-exit condition being called from graph_entry:=0A=
=0A=
	In file: "/kernel/trace/trace_functions_graph.c" (lines 209-217)=0A=
=0A=
		static inline int ftrace_graph_ignore_irqs(struct trace_array *tr)=0A=
		{=0A=
			if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))=0A=
				return 0;=0A=
=0A=
			if (tracer_flags_is_set(tr, TRACE_GRAPH_PRINT_IRQS))=0A=
				return 0;=0A=
=0A=
			return in_hardirq();=0A=
		}=0A=
=0A=
Both in_task() an in_hardirq() macros check preempt_count, which has the fa=
ult=0A=
of not being fully set before any code executes on IRQ context.=0A=
=0A=
=0A=
I do not know whether preempt_count is intended to provide precise context=
=0A=
information during IRQ entry/exit transitions. If not, would there be a=0A=
recommended mechanism for tracers that need to distinguish task and IRQ con=
texts=0A=
during these early entry stages?=0A=
=0A=
For my tracer I patched __el1_irq in aarch64, making it noinline instead of=
=0A=
__always_inline. That way I can catch its beginning and end registering a=
=0A=
ftrace_direct routine with the minimal changes to vanilla Linux.=0A=
I have not tried any fix for riscv.=0A=
=0A=
Is this behavior intentional, meaning that code executed before irq_enter_r=
cu()=0A=
is considered outside hardirq context, or is this an unintended limitation =
of=0A=
tracing based on preempt_count?=0A=
