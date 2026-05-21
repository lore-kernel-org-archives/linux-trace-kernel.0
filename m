Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4127FB2A;
	Thu, 21 May 2026 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779338021; cv=fail; b=RuSSmNWHwJkgEw+nROPRbjaQHSTtGn/wS2RaV/gZUj+vnqt0RiPGdCSs6VO46fpYZ4gYIFFBNlMhkAhESdagNEKiSsIJ0DADMHlahuGIuoeXfTg2zfugYUGE3AkTXTH85Ek9avb30HZekT8vfOOXupoyIJ8mfwJ4tbzR3ubS0lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779338021; c=relaxed/simple;
	bh=5mosfp1jgcj6wkmbCL2Q8Zx3tJbEuKMeWdiRAHlJL+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHzVyboVrKrgkcxH5k4soyxMX34CfHBvuJY3ZKbzkXnjb1mrBkg1U8JSf3OL23XvC4wEqFMt7ui/4wB9yv+WiOYZ67pSZjTpiy03B7ogiNu5aFlzLyvALOmrYmOaFdL1iYTjxU5B3YxXFrHjeHqsmyqUUYwP58XAtuQ+Cnm+QRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQku8lDF; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQku8lDF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifbGnCvaTt1/uvsb45GsgUBd6QxZvBRDxU5tf+E3o6Lc7jZPL/wx978kQdJdaPB5XNre0ZF9eV97rJWVkDuJKMXxD6Gdtt/Nf1TSI+8sC/oTzKYAfSG18yEXtHkJ0s9tsP/vOzautZIaVDf4k9S6Jiru+9+coldzs6/Lc3aRkovSvcal1gAriq83gzZ9hrZBGVVG+ZLJevQwkni91XDpmJT3BMn3ln5w/aoQhguTGC5wJA6xrWXB6DGX1bpy/jRbluxL38uQf5OIlmRZOpiVORfZhBtl0KkNzE9lnF+yjwx7E/+M7vf0LPG3TREeXMFuBl8bPIm6w0XBm+v3CwAllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mosfp1jgcj6wkmbCL2Q8Zx3tJbEuKMeWdiRAHlJL+8=;
 b=UIXCgI+roMsZAgViEwNFqQ0ktUZkxs3hIpZ3XTPXDYPVCq3jYeoi4ScPxsk5Iw8GYLnl3iAIuRr1cpqHQL6T1shp+hqVgzon8oxd0k1AiMlx6d83e+L4dM5th65ZISfmvbuLX6/OieXEkknKLf33QvFOQlAFDK+p8sZHPRKt8WleGJjnh4Hg7+MfuEQ0WMF5LcncqoYQAr5ldCEYU9mtNfx3quU4qyJtoi8mV21SCbvSWvze+RN0ZL6oG1s/m/2stUkhpV1cBQV/djKhrVMtMmd+COZ/gA96s4zQG2r2maEToV5iHzmrNZqCEeHujzY5z00fs1r9CEWeQ118g6Jh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mosfp1jgcj6wkmbCL2Q8Zx3tJbEuKMeWdiRAHlJL+8=;
 b=AQku8lDFsjZ/Jmd6V6pE7FyeS2Kuk/E2M64LDgeVul21tJzn/OTCI1AFdFOeLBUtXLoOOl1YuS0e75mLOTFNXAi1pSuL0idfuF+ZH++QZ/phQpwSaGVwH9T1gRsjvJ5Ua3P2LPI2+CFO4WduSF2xh4cVZglgH3wd8M3FrAUrLoI3b490znTmIzScfRR3Y2Ah2sU041W782SqU6+kvuVlCA5QWTcgxsPOZkaBGQ6YRUOzPHCmB/wz7goeUkgK+htKivByj8nphoX2o/0EqOJ6R1gO1gJnZnRNLYill98NcJixt94QX9U4cwgaXRV30FKmGa/apC+j1xXCx+txmys5IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 04:33:35 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:33:35 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Date: Thu, 21 May 2026 13:33:24 +0900
Message-ID: <pQKtL-t0RKO7KsvRTAIQ_w@nvidia.com>
In-Reply-To: <ag2iF9bZJcBQ93lh@orome>
References:
 <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
 <20260519141059.77435501@fedora> <ag2iF9bZJcBQ93lh@orome>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 37387c44-d33c-45ad-a867-08deb6f21ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|56012099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	sDp6QtFlSVvnfIlNwI+CkNsNumTfR/DvdWQhejzJegl1BDZ7YYfN7/X0BZl9TnJeBebpKGHaMODvl/vrnr+DmTDQKhZSWt9Tyklf+Zw5UtIA1Cf3uMTT4qD5j6/F3vtEyjfvMSgy1D4uwJF5ryS4RdYr0CTv9g1MqEsbjdmzVEgrPkiNNrjbFvdckbMRo8IOYon+oZqFWy9Snkb7gq7nvGeHAUn6tMpZEFhU9VDX9sfgvHaiy1AX7heOgd2zDRixRNzcOKzh3eeDOCRisXzMnDouZh4Nzo2kgNWk+9Fr80oIS89GohwJGlFuuMPbV1spGNc7LXg3zfwtWAPlyhNQ0vFxMIzVuoLr93NyknoBUlOWk2dMxrvDl5e2XkbI5iD0R+vxQBvoLtZ87X2VlIaC5gtpU8br7y6wnQdrxjK1baGxze1215z3mf2qzYqudRauHiLr6Nm0nwOYkrNfCi7BPr2lPNx5qaTwF0DvjEys1+ojPxE4gn6ZR0E6qXhNJy7nSg81qzsImCYmhRRzhcuKY5ht7GHaCoiB2+uolBS7ls+SEayqouSyxqbW91F83FY3PTqkdxi6YqG+DMTNp3q5/Xtx9AWyK7egvQSqGhEEBvrQJ5N5hQDGQbDkzbX/w+T+qZc6hy1uKR6gmC9bGRUbwgvnQ79FxWXFBypQr3rxZVBjc8eG9Yxyfg48WBNcTXsK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZTS3lTZ21hdktMY2cvK0hEYkdtM05UVVArK0QyYk1JL3d6NUdNWFRKZjJG?=
 =?utf-8?B?RWZkUHgrMjlnSkRnaFM3SExZNUhRTzhna2RFOGowQThyYjZSRG5PY1BSZjNz?=
 =?utf-8?B?QkJXQU8vb2M4THkvam43bTM3MjhPcTVES3lDYmt1cWFpQTh3TEJmMU1rLzEw?=
 =?utf-8?B?bTVsQTUydVplbU5uMExiWUVDSXM4dWhnOS8xdWQ1TFpmeVZGc00xS1VVOGla?=
 =?utf-8?B?MVZ3Tys4bGZIUlozdzBlOXpvOHRndnRhOHFTRzhjS1oxQ1JzaDM5WFRmVk5r?=
 =?utf-8?B?Y2N4MHpVdHV3MUx0dmFHQkhIVTQvVUdEM0p2TnV2WURnZjB6emJZNkFnN1I2?=
 =?utf-8?B?Z2ZhNSs5YWtxckw5anA5YVoxY3ViaTJkUXdVUDNPSGVjemdUVDJyc1NnSm83?=
 =?utf-8?B?TW1aZWc5aGg0S0VyVm9uRTRRSmlBZW0xN3RUVis0VUp4ZmFkSG1MTkdMa0Jh?=
 =?utf-8?B?UWNZOS9YT1o3UG1DbzBxWWZHK09WcG4yOGsvSWtpRjNuWVpyZlhESzBZdTRD?=
 =?utf-8?B?d1ZYU0pBd2xqZkpKUVJtdlk3VW9XaHJmbXp2RDBXdnF2VjI5cTlwYVFrUlZX?=
 =?utf-8?B?WDhoenRjUG04Z1BycDlnRVdQVlBNem5ZMnpHYU5PNjU3YUNJT3p2QmxqQmVl?=
 =?utf-8?B?ajYwalRpVEVmRGVQWkl0TjM4MThUK0V1N3BzTGdRWXhnSVhDVTlvUTdOMTZE?=
 =?utf-8?B?U3lSSEo0NERFdlVtTlNLY0NKWHdOaUg1Vll6OFNLWDlsenRYem9zY21lR0tM?=
 =?utf-8?B?RWQ2dEJtTENtaVNObWNjTzVJVVMzaTJZSGx4WS9nOFptVGVwRXVoWlRvd1RP?=
 =?utf-8?B?NEl0UENFSHFSNzlCWjRIb1g0VExvMldqRnpPQ0ljaXl0M2N5V3lpMkIrQXlT?=
 =?utf-8?B?bi8xbDlTS21Nb3BEdTMzRGY0RHFxYnFBcmlNZFdzbTFHY01vOCtGNkdTb3lw?=
 =?utf-8?B?MWQwa25MNFdrY3FvY3AreGRDMFhzdDIvWUxyOWhPWlM4SCtiTlh6cjlvN0Z2?=
 =?utf-8?B?SzM0R055NjFSaDdVdzZhYVlTZnpObHVDbkZxQWhDNisrZFYxS1hFTzYzWmd0?=
 =?utf-8?B?cmlCcU5zWEVXZDJtMVM2ZEUxRUxMMUhXZllXc3ZRWmhGeUpYMlVEbVRKV0pq?=
 =?utf-8?B?UGJOYnArZ0F6RjJXZ1FvbW5RR2Uvb2s2eWozSkZUcmhZaFNUOGJhM3NKK0dT?=
 =?utf-8?B?Mjd5STc1VG4zdm9sRUxPeHB1UmE4WElJNkk0WjRVOUMyYmN0K2pXYjZHaXp1?=
 =?utf-8?B?RCtEaVV6WUFubVFEMlRYUXpGak1ZZlQwamQwVUdjK1M5bEwvNEc4WVpnTm1j?=
 =?utf-8?B?VTJxdWZTMGhrejU2YldxMDBsUlBnQk1NaURpemEwYmxYV0d1N3V6ZnJ1NmM4?=
 =?utf-8?B?dEZIME9CNC96VEN0aUFCaUlwWnBZL2R2MXJTa2l4Vk5aZHhsYlBWelRmWUMv?=
 =?utf-8?B?TXc5UVpNUUppY2dzTkozejV4ODV2SWkzN2pNVU5LT2xiUG5aYk96Y0puRERS?=
 =?utf-8?B?R3dlSWdPa1k5ckdwSzdiSG5JbG1KL0NiNXVBWCtIbWE2QVUzcmtDVnhGUHdE?=
 =?utf-8?B?VGt3NVRzZjJFMWdZMG9xRDRtcG5RVVNDRUQwdVphVmpEZ2ZES205UTlXNzNp?=
 =?utf-8?B?L05aZDBRd1IxWHhLNkdlWTczaGxIM0pVeGJseWRzMlNUTXF6eS9HMjQ2RTZ1?=
 =?utf-8?B?cmRkeEJxQXVnTWYwWExSU2E3d2NvZVdHTDJoV2pBb3NldWxzajBLS1ppZVJj?=
 =?utf-8?B?RGQ2YUt2V1hZWXB5T2N1Y1UrZDBzb0xTMUNvQnhyRG1KaG9uTU5MNXkzeGhi?=
 =?utf-8?B?US9MYzJUeU5NampGbU5hR2xHSGJxcU5nZmIrcFc3MHhkclp1dDl2MTJ1OEJn?=
 =?utf-8?B?YzlRQm5BOEFqQTdPWGd6TmNCQnFFL0JSYjN0ajZ6YUx0VjFZVHdWT0JGaXpy?=
 =?utf-8?B?NjN0Qjh2WjA4Umk1cnhNVm9wbGUrZkVNemJWYStXN3JkUC9Ta25LdVZYY1VU?=
 =?utf-8?B?RmxHTjBsemhycU9BQW5HQmFkV0xYeUFVWFd6dnlFVmx5d3Mxb3E4dzMvWFFu?=
 =?utf-8?B?aXZEZ25tYnF5amFQUkpyRW5OTlJrZHAzOU9DVHF4czUwODdiZlFVMHFnZGhw?=
 =?utf-8?B?MmlDSFNoTDlpR3FWdHFrK2RPTjJsR0wxWHFMbkpGb0xNL002M01Ya2hpQzZj?=
 =?utf-8?B?UDBzR1FWQXpydTcraEZLSHFxTWlaY2JOS0h3aW9sMmJQZzRzUnZhbjZ1Qldj?=
 =?utf-8?B?ZnFMYlFGQzAybkJSZkpHRWxiUDBxWkJQNGsvSWJuRU14RDc0VDhoZzcwRVVK?=
 =?utf-8?B?WmJ4WkpTTVgzY3pKZjlGNmRNU0dWTUZ5V1ZCTW9zQmFYd2dVcXFaRk5YNHRn?=
 =?utf-8?Q?Y4ZxbdfDaBZc+4pd7U1011YcwdlaWb6zSKEV6GX5YU8vg?=
X-MS-Exchange-AntiSpam-MessageData-1: y5sxUDGzQt1elg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37387c44-d33c-45ad-a867-08deb6f21ec5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:33:35.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj1GvlVJ8uFQw4CuFozvT9H+a2RJKz/zQMfipmfmjpWmr2TXi2ef2ZmTp1LI7pZpDwFqDGF7g60qg8heYdB3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

On Wednesday, May 20, 2026 9:03=E2=80=AFPM Thierry Reding wrote:
> On Tue, May 19, 2026 at 02:10:59PM -0400, Steven Rostedt wrote:
> > On Tue, 19 May 2026 12:16:43 +0200
> > Artur Kowalski <arturkow2000@gmail.com> wrote:
> >=20
> > > Use __assign_str and __get_str as required by tracing subsystem. Fixe=
s
> > > string fields being rejected by the verifier and unreadable from
> > > userspace.
> >=20
> > Does anyone use these tracepoints? The fact that they have been broken
> > for 5 years and nobody noticed makes me think they are useless.
> >=20
> > I rather remove them than fix them, but if someone thinks that these
> > are still useful then by all means apply this patch.
> >=20
> > Acked-by: Steven Rostedt <rostedt@goodmis.org>
>=20
> I know that Mikko used them a lot early on, but this driver is pretty
> mature now, so we rarely need this low level of tracing. I'll defer to
> Mikko on whether we still need these.
>=20
> Thierry

Yeah, these have been quite useful in the past when debugging why a job
is failing. Without the cdma traces it can be cumbersome to find out
exactly what is being sent to the hardware in some cases.

My preference is for keeping them for now.

Mikko


