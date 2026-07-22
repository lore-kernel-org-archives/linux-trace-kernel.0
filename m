Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022091.outbound.protection.outlook.com [40.107.75.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E02492520;
	Wed, 22 Jul 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712609; cv=fail; b=WYGa7/NI19JIGBxV8yUYfoZheH0fkJMtpdbgpIj1Ph3C9M3OpTmD292qhk/HuJceijdNd368qbGIOSgcAYMZl5i754ID2KGdjNO3mAlFizFtNjzxllh0NE/y4qaQslZfv3yZNAzltJ0hoY9Cn8Dvi4kN/UmJ7COnBKzq7yVhQ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712609; c=relaxed/simple;
	bh=9ED3ugLIZVKasdB65NQz0C5AuRrL93qiFSA2ksRHN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UzFe1VG6IAzUo9BhdJywy/BTvy8e/+taBfZ5zHe7Lspex9jsu/OAx7CmTCN390VW2p4uGpNk9rqI3Ce77yPTT8cXcljUGTGGCACHAX85OJC73L1zwE24WsLRgOF6fvfTbc1g8xB3BQmklpDDt/NAD3HP9NT4baKif1cwNTaec/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=s1BHc7GB; arc=fail smtp.client-ip=40.107.75.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="s1BHc7GB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0iDNBsKh2qRuTmZK/TLwub3stMFFSNIh4IhWtVvx1QJHVBCHpHz5MIQ58bCAdcZHmgD/Z8Ug/AeMB8cYd586XmrXRvCQVrLXYM6/X+bZz9mW/sOqI0bBHXCO0PvtiqpgLIA4iwJlbNy8agjQMUOqMd2sPbCKU6MGoB1xOpPzKuby8jt/kgZmchjOLAmA3r+pA1r6oAbiyZRLOSGwG4JJ/PX6LwIDCoKSVd1hTNf+NIVnsdPpQ/J7qL4y86e1paGRIjCLrJ6wocxJOWfQIXYtBd/l2uqNcizTepYzCtS/sPDGmpr0wXni8hvO3NSFuE+Bz6Dll1vAe6x7VB/10WA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+QlAb3AN4V/kTEVmncX6VieyKqlY5O+pcUjKJeYvAU=;
 b=JGNaUTzaR9rgWbhc5yItYi4im0OWZDDh2lRyPcpuq/HdM4u24mOdu4IOJSGAG6OmuTVUBJoTamMtq0w6GE8yd5ZFqor+YYCEoHvlgrCcHGSxAI8TShgB+yb+zH3freCbybetr4vYI3C6r8Ver9pH8iBgZ9p44gbT8jY169QK1aqoos0Y3/lmUHR1+svedU0+tei4Fg/1PJDGBakss0cbUT+sICMFTKBJ2d+xnR7Jv8MtYwym6Evyi1spYKKrqkgc17h5h7pyP7HC8lcdGRanzzhz8dYgP7nN0s/osyWU4x/vJ+jtM6rr1d2Pm4VxaeLP74SilJF3rt+oABWnMpwcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+QlAb3AN4V/kTEVmncX6VieyKqlY5O+pcUjKJeYvAU=;
 b=s1BHc7GBnKnLZxDcv8MmKkVqNDLlHVBdLlpZWNxXRel9vfl5U00Sag1qWD4CcA5cLpdNRMZp4xIOrgXtvxMANPk48/jNA/r2B9dZEdeOqtJTvjSlXN+hmZ1L1EyVXdSLdMwq0zsZCNDhqxYCgEOCAGghJNMFePHOLNfptEluEepP7l5NkKxKgU9T0Sa8EKEymPwcNEnOhFzX8Gz8dxsqrS8I/GHvfIiPHFfbTRIOgm5HnCsd2UbMqPfCxXlDmKbe3gHdNM+VwumqCrv/JqRlYgkqpqMHEhJ4FM2oQDTFcCzuCCKTLigO/HlBaLJIjpRrdtcYsCQk3XU9u52sr02a9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI4PR02MB9722.apcprd02.prod.outlook.com (2603:1096:4:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 09:30:02 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 09:30:02 +0000
Date: Wed, 22 Jul 2026 17:29:56 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
Message-ID: <amCNfEoWsjIXs3Lp@ChaodeMacBook-Pro.local>
References: <cover.1781852967.git.namcao@linutronix.de>
 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
 <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local>
 <87y0f3wjuk.fsf@yellow.woof>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0f3wjuk.fsf@yellow.woof>
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI4PR02MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f097096-9035-476d-fb2c-08dee7d3ce5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|34096008|23010399003|366016|6133799003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qDdOUWDOl0Y7JU20RUjFRlwYiU3/Rv46PtgNB/MJsHgpezksBNMKu5cJESFetLCMqTReVTMsw//xxCe7dgTzMe+dS3eOJ1pW9F01Y4/7FlvZ5AnK4X3l5/ciodBCHCOxkMAlMD3szh2hX8N+XSDIO/am8bHDqOAiy7YAceuniRH4J2ZX6yO5MX0AphWw4LLInAF2WNKq6KYizGgIn+DIkJnGbU65VkTUNTtKUlERHf4/LGEOT6tTEogHapXGAQqlcLqKK0TrPn3be0dmNvQWclAI4hs+cGlOmwy4bq5aml2DgElRtjPOT5MoKqblLlfiPKXdnyFBEiIKpTMez6gSbR6pMMMBFR2DBUMkP+u3if8CcJvl9vFDKmjfbBNCYXilT8fQ66vcDVDLFguQgAa5tcgbm1F2pAPG1CJ/CN2NjfAD40P4ytULivL8SNf17euBx2wQGzZo9M/isXfhDfb0css4NMAwYKluyu64DA2+Ir8SgpJK8TS4Dmht0a8mAq99ztdUOt1jONRVIdqYj9bfeqplavGAPQXJ8k5NktnLdm2al50KZP6McvcYLhYiEvw5v2giCGfUoHh8lJqBv+OVlcetFKipbsa/b6dZzynJfIlDRGKl/2y1Uvpv+1bfkOFMYYXyko9nrEyPcLA5klbMJmVXJ0EdJzGt+gkbdQgBa+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(34096008)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHoVYer8AQXSlbq/X/TReX/ut532IuDPo/dJ1t2u+9PZblpb7hWJErvyY376?=
 =?us-ascii?Q?PH5XjeUoEC0H/jHbz6tU0iEZSPsokpIoTyY84o29RjoBPFtbV6Vv7Vu7e5Sf?=
 =?us-ascii?Q?ble9sLbTaE1ugTlzFLzf3W4QPLZPtLwW879mUbWFFxDwLrBE70HoY7Vhklzm?=
 =?us-ascii?Q?X/0P3l9RicNcFWIpDDjpeTWfpOF2V/vJzv1jOi2WWS306g7R1UNALNX67t+H?=
 =?us-ascii?Q?lMqdN9bIwPDFsLagPZa2mcM8JHV6Qd6yTrNPQ5jbUxCJ9S4TivbhCWMox0oG?=
 =?us-ascii?Q?PePvRxzfZMjGfCHXZKOD7xrejE5QUXtiTTj6Q2FFk7aeKwMFwlEa9kI/emTg?=
 =?us-ascii?Q?jQRsYtwGMIv+TXf6wmIil/zufdKnNxO8jJ8GJFoKgva3ZeyxvY8mkqpB7Z2Q?=
 =?us-ascii?Q?ehSiuF8vfnVqjVWs33PrHlRXJKzqlcgesz6GZL0qyU6TtugUt9Xu1ACPl/Nr?=
 =?us-ascii?Q?GPjR8jJM5Nji1U+IwogyMPX2ztK5MFw83rDboAKeJhyijDFVzLBnIaXro3fe?=
 =?us-ascii?Q?O8Y0EkFcCIlyILDP1PP4hUlphGGiWQV11lQg8ryb8yeoqr2Px3KzWW5eGMqj?=
 =?us-ascii?Q?eKW/VGGYnoqz1J49LX1LAnOmBA7evQnwDlLm9nRbcTF4NcIdUoFLyvCN7jSF?=
 =?us-ascii?Q?ThBSJzyrypuP2v2VuZgTfpTtT+5HBvHerbNk+PvvVQpO3SUkGB0ib4ypm74+?=
 =?us-ascii?Q?IplAEnbSJjaWeTYD52u6I1/T5GWVoTDeZVk1a0OuQK4sf7YfHymZX0YOI3Ga?=
 =?us-ascii?Q?0C0tkNCjtCIvRwUGxFZ12wTm67L9GGHX5ZkL/EndHJ78bHIxBocVR1/I17+c?=
 =?us-ascii?Q?mswKyGhoTj5s2QEUHusMxLPlii6KqQkr1tue9j/ltEvG1Ye3zkPlgdUBX+uF?=
 =?us-ascii?Q?KAaJIuipUChh9mRN3/KHDzbVama7BREKrUKdrwMH6RfecZZGC2RiUQEQJj8w?=
 =?us-ascii?Q?IGKWo9E4oW040hjIXo65k2ZXSBeqeKnAdR+nBxcmq8XPVqJxtnsIjlKMJind?=
 =?us-ascii?Q?ny6EnJ9hf0jk78YrbVuSsS1X2FoG4//lZK4jEvnE30+9FkD6ROv+C1v0lnL8?=
 =?us-ascii?Q?OjOBfFnOkT4uLFrNwpK3LJI6mzg62ub/3PPXzeEzdmOnIK5wpbdKrKrir6CO?=
 =?us-ascii?Q?MW9jRYg73Cwr5uTpR5qFjSBgmq3e6QVfjztu2aDzqZoZ3r4/UeaxaqQQzPRq?=
 =?us-ascii?Q?U6sz9D6sYlQFA9qvLnfgLWUgLIukIXzzCN1rBtDtFdNBPn9bmhZvjKt6OSGF?=
 =?us-ascii?Q?Q0zqZVWr2qFdj6w737kuYwcdMIbuhde5P6dLXBqrs8q7tK+trCU7X4BZ01Xh?=
 =?us-ascii?Q?MdQg6qpq233U07HaI2UAmjT0npoW1wf5U6GlBCTmaPjAC0Ioaic3SHCJKz1p?=
 =?us-ascii?Q?fyY5uigU1YGLhIOrnSAHriUioLXpbexJcAK51LZLv77fvHt36Cpkp5iNHRTP?=
 =?us-ascii?Q?L5dMfGczRMkuHP6yuZCJWAgZYR7xcO+TRnkm4m8jixdzlUDG0L7i0bqwuxXO?=
 =?us-ascii?Q?vgneh+tr1mdmYqXdxPoB3eTcZjYYEy8NiNV7rmiY9ivOwZDe6PdxKy1O5rH/?=
 =?us-ascii?Q?A5h7VduLTVrR4Bzs51LuZgi+1zRDpt2Z/wOCOAjxfi03h6Uon6PDBemEWiXH?=
 =?us-ascii?Q?l0vDNdaucPX9un8y5elxg3bKIPQIGn8Ax2cAdlF4aOWj1St2fCaIbt+y1os+?=
 =?us-ascii?Q?WuydrRRuPz1HIV6MZchJB9kiY3KOfj5HTneN0X9pyteS0wjpfztIr6blzG1V?=
 =?us-ascii?Q?MWbhpn2xxxjwTAEzEPMahE5RLmHfCS0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f097096-9035-476d-fb2c-08dee7d3ce5a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 09:30:01.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3Hlzshuj3fG5o4N9b2+7lgxBoiZhnhmJaHQRT5AWotVzWeptxUEAwQ3Y1zTqkQeCmvRSjEuhJjDZ6GCAZin+0n7DCNh93v/+QOy3EcyssQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR02MB9722

On Wed, Jul 22, 2026 at 09:42:59AM +0800, Nam Cao wrote:
> Chao Liu <chao.liu@processmission.com> writes:
> >> +static void handle_sched_waking(void *data, struct task_struct *task)
> >> +{
> >> +	if (in_task()) {
> >> +		if (current->prio > task->prio)
> >> +			ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO, true);
> >
> > The implementation also reports wakeups from softirq context through
> > WOKEN_BY_SOFTIRQ:
> >
> >> +	} else if (in_serving_softirq()) {
> >> +		ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
> >> +	}
> >
> > Should this description mention softirq wakeups as well?
> 
> Technically, on RT kernel, softirq is a SCHED_OTHER task. On !RT kernel,
> softirq can also be executed as a SCHED_OTHER task, which is the cause
> for concern.
> 
> But explicitly mentioning softirq does not hurt, I wouldn't oppose that.
Thanks for the clarification. I understand it better now.

Thanks,
Chao
> 
> Nam
