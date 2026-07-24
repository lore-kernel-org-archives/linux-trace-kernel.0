Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023106.outbound.protection.outlook.com [40.107.44.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F541A930;
	Fri, 24 Jul 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908813; cv=fail; b=mXO5r/A9mutLhcN6bXphaBK0S7wNp9ZDYkkgorb8Alk+hjZ9IhC5n2fDwyy1yPXTOya8bS8bDIValWfFCM9WLswF3CAo63qICSwA4WZXeMvTL7NEiLO/DkcILY7Om9rEKwbsadFr51nyb+yby8yjP/7yB1Z1iEUo0esycIWl/bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908813; c=relaxed/simple;
	bh=xZyUSH1291aRgYD9RItNX2N000rM5lEFejlCf3nBzrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdQSEUISyBjC1gbE+cGjhGqizNTYMVHIvmdnNN+HuKWYfiPh/vApmRasUxH6PoUcNm5LgUClqmrIFC5XZARiVMMuhYCeWQe6ANpdZYolhNyrLMQZueNzf7eocjE1WeuHI6cDbhYTbQlJ6ZKc+BhVAk71ycuej/9B70wzP4EAHaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=fail (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=e+B8ORW5 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.44.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="e+B8ORW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5bhmHycZQHnWOsr0Yx+rhF0xSoY49+ws4SyRjCkJD6r0oSrTxWjaixxN0yFjIB/b75eLdDUX41RCuFa1pZct7KTnvIHrlYSYxo0AdgnWTUy48GDCk6VQ1LX1AaNPsPNpllLqWlwqJrd7xivjwogMex0OPb8E402qRzLCfOlpEWajQyfZKDR/bJeO6V3y3rI+WjR5fKCWO7hFvSmZjjRXpApnXrCARNA9rrIigEYrG3uQcrQAwH0WSVhdjYxmQLZfdZeH71Srf2PfWpMAql0HsjpkO4VNN4OkC2eNxQ0ABOS1gFKQuYElOaINeDbTQxMjERocHHm3zuEffbK2Oh+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npSSi8HKBaH77OTyCVfhB474EtZ9DAsUJq/C3wp5b3A=;
 b=bBtXoE0N2jVUI3AAJweY3TpUt5piICVtytp2JxAWODyfH5BOqCgrtDH6wYAmLUH4CkePlXCKSOo2tnYr65bzR/GdLWlMpmqiX29i9yi07CF38vqXXmtgPh/pA+57qV9fvkScSLuPmYDTO/8vxJygUxQaHzObVu6ZrVq/b/crYhMJTPQRyXCk6kN8+hBxiL5VigARAsYGnaVlbh9SfFQXs/jqB+Mb0w1Ci6eFcd1GChjwXTnxfgDtGKbOFXw0wD+sBZ2+5VmLP6BG1wnm6ujk0wIBbuJYKhSFNoHfoc6wCElNU6KTDnxOF8ArH5XXwwjKNkPFxvjS86BNNbz3iEs7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npSSi8HKBaH77OTyCVfhB474EtZ9DAsUJq/C3wp5b3A=;
 b=e+B8ORW5Z7iepQWnnsoZcXPdD5JxmWzzdO+i8ccSej5l8uOvxZxim9LavFCoa4JO5uPu7eb3qQ3HmW05jMumhj5rTzzAQKnIvlwUlu0HXbfPlyxKEDiPsKDTY8MTxLjifYFDaeEceD+BUtZSufMeJGglnaeaJwTDec9XWhEmBHnOfm2yVMe8hyC6MZWQA183gpcCTKUWOwsI7c31r0Mpj5jFeru4MUgJbErCjxjpOlVCTVO5+SQ/3x7mDE5lYtJXRRFH2AT/vQ1JcpthLhXF9YY2NpIGk8DvOFkkgmI6NLir28EIKy3emWzKvfX6nyGeB+NaPpGbaN0gTjl86/w/aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE2PPFCC21B04CF.apcprd02.prod.outlook.com (2603:1096:108:1::82b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 16:00:07 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 16:00:06 +0000
Date: Fri, 24 Jul 2026 23:59:59 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, lianux.mm@gmail.com, lianux.wang@processmission.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Documentation/rv: Explain epoll and aborted sleeps
Message-ID: <amNlh-GZO-RcbpiL@ChaodeMacBook-Pro.local>
References: <20260722045706.85633-1-chao.liu@processmission.com>
 <f2679e058fa3904db3534a5f75d1339a4065018f.camel@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2679e058fa3904db3534a5f75d1339a4065018f.camel@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE2PPFCC21B04CF:EE_
X-MS-Office365-Filtering-Correlation-Id: e57f279a-390e-4e7a-abcb-08dee99ca149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|34096008|376014|22082099003|18002099003|56012099006|5023799004|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4D9WGSywa/lvCriHhDg8wohasSsx27TgB1meJFOTWr22StgoF2qeXdCll7jSQ6f6VX427R/mK9EgVNYsRJryacBHwPvPZswykq2dY+FOYjo+zaImNneem0HuXgDNfqXHCSEnQj73B7+dhQ3vg8J8x7TOpejPR4qtISENIVQKUdzOMA0peqgOqsUWhe2BIzS4fmSM2vnbh7UCms9Uv3xGvBuOgGlCUGgkmcp7zyqc1+wfKhANz8kBPIL5iz+uzLktUUlg51X2XgGjfUSSG7Jhiexe8tqbPnsPKqyWhz9+x9vKa1F7DhlfCpU5uh60IpoXIAG/4bxb5p+5n7Oup3ZZTBcv7kjiFl9hZ+Wc8Xx24BoZtD8/H3qtgY1HQ3YWUOy6ez4tagUeplBTyz104e7aZ3YUfI07NPjbv2QkwYd9wJWcx4n3zvTGTTwuDNRQSDZ81SSbqVbtJYEmr8DRZWQy9cJUt/5tG5OcDSkkLlcgJXCsR/RMYciY/bjMmu7KVOnsOav2aWaei6e+hIhtMwTIcmwXNrODnT7VUbksaznXqIuSQurUKKuk/6G6JIfuuPswnCJzQtL4SYZBGkpirRclPTyF4wGKjZozs9sKbYPo2reS4qB04Y5dcyLG7ABADcir
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(34096008)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?0l5TR0carZkxA850CbM4HJEiWHe9BGysvpbiMRuy6q+xl6Srn9TRbi6iM1?=
 =?iso-8859-1?Q?OuEc4VlGj/ZGPqPfL4jsI4U2LHQNQ3JHSWAAneMzYkYYB84del7nOmUzJH?=
 =?iso-8859-1?Q?IB/VNiRqbB5z9ggNjo2wFNCFXpfRBzDxmCV2SQF6YI03kSVtkSaPau22gx?=
 =?iso-8859-1?Q?DxKLI33dMjwdnXhpYtbukQtajR17DUMAXT+V6BeACK349TVQkG+18XrbcV?=
 =?iso-8859-1?Q?JQw+PGrmmKEgCpeKvjjF+2MMor5nW5lQ4egV4M86zqhjr/Yv6+DxlPqvTg?=
 =?iso-8859-1?Q?cWzaJR55WCtH/7UYhLvV3w/S4AVIAZqTRhEAJ8tVJUIqhX9en9Q6ZlPry/?=
 =?iso-8859-1?Q?iPgt4l5Dxn+uSiOGvTnubPtEOjzx4PWwb0ZOFl+fupBeBLZNdjrvs7WUqY?=
 =?iso-8859-1?Q?l2rvXZbrDT1AWnugwpIFhKn2tQBLgVrghwEiDunX8Od8Rk/fNmsPq4y6UN?=
 =?iso-8859-1?Q?qziAgGk+uEh4iyurpZ68EbDhFpWqkyT4YPdBJeMIOVpIzwgLI1OAbQqR41?=
 =?iso-8859-1?Q?3l30daoGT3HQLMa1nSf83ck/JT7d6m/OKXvG5iNGbFoeQQPtFjtJzFt3Fa?=
 =?iso-8859-1?Q?NmVzwTPqL3kM9rQ6rEDQm4tINYKWfhbRIK6UH29rbhsSi+G8Qs+pdI+4oI?=
 =?iso-8859-1?Q?cxjok2Gx5znkKXRWYoW34Gv3AV7D2wdLLpHDZ+O9AcOp8ce4ZG5Jhl5/DB?=
 =?iso-8859-1?Q?Rwt+0BB2fGtha0xQwWx5RiOkdGmvNOTH6Ct8R8kKySuVJUZU9+XzvUxFwQ?=
 =?iso-8859-1?Q?smzef24OHsyq8T0oBPKVbWe6O6ytnv01gphjZZh+m6sRSm5dHHCqAOT5Ni?=
 =?iso-8859-1?Q?l9ck1/V1LdJK47MwIP7uDQnfPihIrRyolpcTVuAogXccv70MCOOwSf4fec?=
 =?iso-8859-1?Q?lvty2Ueu2iTy3WAhnAiJA9AJGVcDhLZhVeF08dHAe7p28XvInw8Fydzv7Z?=
 =?iso-8859-1?Q?Dx0y0xdpX2taBgYGyJh5nGmYQIGDDpvYLcENpB5+MJ7BtsR+qvGS98ttz3?=
 =?iso-8859-1?Q?qzaQO5oW1m0Hmo1xVgY0Z++0DyODIu60lwkkT/Yy43kzZwMMDIBRMaStdh?=
 =?iso-8859-1?Q?8nYVw3eB7x5lC/fXE0ZlrZv6ymvrsexziy81HZaMCoIkx2WPNtJ+hKeAw/?=
 =?iso-8859-1?Q?b/eC818DOCj92BaXUX9qwQYkBSd2HNX83us4rxexc5QKIOK0K2lWk8kdZF?=
 =?iso-8859-1?Q?LwnZfBU4kt0O+RYkROEUxyth0puIL9aIliHlJZTN4yXiWK80g1YkOElwxp?=
 =?iso-8859-1?Q?J1YJlv8ouxHRVMvI0pEqZOIP8vZanBbEBpC9wLfsHYXDMkKg0YvpQyMihQ?=
 =?iso-8859-1?Q?/phG7p78jGpbDUglMX+80iWEYWEt1NotVvahOoZGSYOc0z7JHCn0kX3rv+?=
 =?iso-8859-1?Q?QSKiGCA5qGus9L+Zrsv681ELdb1WwBg3bmx+scw4POleD6fSdiEEMDHRo4?=
 =?iso-8859-1?Q?4Bl4T1aOc7GeyHqQq/D9tqx4qgONAfzLGNChRNtF5GQ8tMNdm0N3G5QCzB?=
 =?iso-8859-1?Q?WtQhuIlKUcCUUsOW/kyE9TI+bDMLfGRrvR23MEu55TQIqmHs+9ParuPDPO?=
 =?iso-8859-1?Q?w5pF2/QkgiaL1/4y4S+i1LXnLWdRlR+RLFGgez9tifJ9AUEDKfj5hUDe0r?=
 =?iso-8859-1?Q?cnjYn6ic6koxjv4eSgbERtxQQjU/G73xQ81oHE7MChGf1XxM7SXV5qMLxu?=
 =?iso-8859-1?Q?lPMwHeH4pLALhRYDZb2Jbiq+FXjMoyMFJbUx472chA7kXeK8GjFOKBidBt?=
 =?iso-8859-1?Q?yoZJvTrlqluYNRw4EuQ5PMPum/KjFILjhbHPUC+xTudx/LMyhDmM5bE3Bv?=
 =?iso-8859-1?Q?CQ1nCxEtomHHWKbJqqj0p1L1j+4bHEs=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57f279a-390e-4e7a-abcb-08dee99ca149
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:00:06.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zfXm/6otQSQCL6eyc2FDEDpcHoI3S/QjiAw56Ss4km166Qom9bFfP/Ezb6WmerU0mDU4LzeAAXpu+eDGGS3xVO15rSZsbSgyiGxNUb3HiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFCC21B04CF

Hi Gabriele,

On Fri, Jul 24, 2026 at 09:20:44AM +0800, Gabriele Monaco wrote:
> On Wed, 2026-07-22 at 12:57 +0800, Chao Liu wrote:
> > The rtapp sleep monitor accepts epoll_wait() as a valid sleeping
> > reason, but the prose only discusses clock_nanosleep and futexes. Add
> > epoll_wait to the list of valid sleeping reasons.
> > 
> > ABORT_SLEEP represents a task restoring TASK_RUNNING before entering
> > the scheduler, but its meaning is not described. Explain why the
> > aborted sleep attempt is valid.
> > 
> > This RFC is based on Nam Cao's pending "rv: rtapp monitor update" v2
> > series:
> > 
> > https://lore.kernel.org/r/cover.1781852967.git.namcao@linutronix.de
> > 
> > Signed-off-by: Chao Liu <chao.liu@processmission.com>
> > ---
> 
> Thanks for the contribution! I have a couple of comments, we want to be
> assertive in this docs: in general, let's not say something like "this is valid
> because the monitor thinks it's valid" but "this is valid because it is rt-safe
> for reason X".
Thanks for the review. :)

Agreed. In v2, I will update the documentation and the commit message
body to say directly why each case is safe for real-time use.

> 
> >  Documentation/trace/rv/monitor_rtapp.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> > b/Documentation/trace/rv/monitor_rtapp.rst
> > index 238b59395ff5..234ed4d581ac 100644
> > --- a/Documentation/trace/rv/monitor_rtapp.rst
> > +++ b/Documentation/trace/rv/monitor_rtapp.rst
> > @@ -67,6 +67,8 @@ thread to sleep for one of the following reasons:
> >      variables as safe for real-time. As an alternative, the librtpi library
> >      exists to provide a conditional variable implementation that is correct
> > for
> >      real-time applications in Linux.
> > +  - Real-time thread waiting for events using `epoll_wait`,
> 
> > + which the monitor accepts as a valid sleeping reason for real-time tasks.
> 
> Not adding much value, try:
> 
>  which is a real-time-safe syscall for sleeping as it uses PI-aware locking.
> 
Agreed. I will use this wording in v2.

> >  
> >  Beside the reason for sleeping, the eventual waker should also be
> >  real-time-safe. Namely, one of:
> > @@ -114,6 +116,10 @@ The monitor's specification is::
> >    ALLOWLIST = BLOCK_ON_RT_MUTEX
> >             or FUTEX_LOCK_PI
> >  
> > +`ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` before
> > +entering the scheduler. In this case, the task does not actually block,
> 
> 
> > + so the monitor treats the aborted sleep attempt as valid.
> 
> This sentence is a bit vague. Indeed an /aborted/ sleep is a valid wakeup, as if
> the task woke up itself without even sleeping, saying "the monitor treats the
> attempt as valid" adds no value.
> 
> You could rephrase it to (full paragraph for clarity):
> 
> `ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` before
> entering the scheduler. In this case, the task does not actually block, so it is
> back to runnable without any wakeup sequence unsafe for real-time.
> 
> What do you think?
> 
Yes, this is clearer. I will use the proposed paragraph in v2.

To check my understanding, I also put together a small eventfd/epoll test
and ran it on arm64 and x86_64. The test code, configurations, patches,
serial traces, and reproduction steps are available here:

https://github.com/zevorn/rtapp-sleep-monitor-lab


Test environments
-----------------

+---------+--------------------------+---------------+------+------------+
| Guest   | Host CPU                 | QEMU/accel    | vCPU | Kernel     |
+---------+--------------------------+---------------+------+------------+
| arm64   | Apple M5 Pro             | 11.0.0/HVF    |    2 | PREEMPT_RT |
| x86_64  | Intel Xeon Platinum 8163 | 11.0.0/KVM    |    2 | PREEMPT_RT |
+---------+--------------------------+---------------+------+------------+

All three guest kernels used the same v7.2-rc4-based source baseline.


Test design
-----------


Phase 1 (P1):

P1 runs one epoll wait per iteration, for 2048 iterations, on
two vCPUs:

  - vCPU 0 runs the SCHED_FIFO/50 waiter (`PID_WAITER`). It starts each
    iteration, waits on epoll, reads the eventfd when epoll returns, and
    acknowledges completion.

  - vCPU 1 runs the SCHED_FIFO/60 writer (`PID_WRITER`). It waits for the
    start signal, uses a different short delay in each iteration, writes
    the eventfd, and waits for the acknowledgement.

The per-iteration flow is:

  vCPU 0: waiter (PID_WAITER)        vCPU 1: writer (PID_WRITER)
  --------------------------------   ---------------------------------
  set go = i
          |------------------------> wait for go == i
  enter epoll wait                   apply delay(i)
          |<------------------------ write(eventfd)
  epoll_wait() returns
  read(eventfd)
  set ack = i
          |------------------------> wait for ack == i

Because the unmodified arm64 monitor does not recognize the
`epoll_pwait` entry, each wait that reaches the monitored sleep path
produces a P1 error. The test makes 2048 wait attempts, but an iteration
that sees readiness before setting `TASK_INTERRUPTIBLE` does not produce
a `SLEEP` event.

The PIDs are assigned dynamically. During P1, the `event_sleep` and
`error_sleep` filters use `pid == PID_WAITER`; `PID_WRITER` only supplies
the event.

Separate vCPUs let the event arrive while the waiter is preparing to
sleep, covering both normal blocking and ABORT_SLEEP. The writer has the
higher priority, so the normal wakeup is RT-safe.


Phase 2 (P2):

P2 is the negative control. A fresh task (`PID_NEGATIVE`) on
vCPU 0 performs one relative clock_nanosleep() without TIMER_ABSTIME. The
trace filters are switched to `pid == PID_NEGATIVE`. The expected
error_sleep confirms that the monitor is active.

The RV monitor tracks tasks, not vCPUs. PID 1 enables the sleep monitor
and the `event_sleep` and `error_sleep` events. After each phase, PID 1
stops tracing and prints the trace buffer; `scripts/summarize.sh` counts
the records in the serial log.

For example, the tests can be run and summarized with:

  $ make initramfs-arm64
  $ KERNEL_IMAGE=/path/to/Image ACCEL=hvf \
        ./scripts/run-qemu.sh arm64
  $ ./scripts/summarize.sh serial-arm64.log

  $ make initramfs-x86_64
  $ KERNEL_IMAGE=/path/to/bzImage ACCEL=kvm \
        ./scripts/run-qemu.sh x86_64
  $ ./scripts/summarize.sh serial-x86_64.log

The complete build steps, including the arm64 mapping variant, are in
docs/build-and-run.md.


Results
-------

The first two rows compare arm64 without and with the experimental
mapping. The x86_64 row is the unmodified cross-check using its native
`__NR_epoll_wait`. The arm64 rows enter through `epoll_pwait`.

Each case was run five times. `M [L-H]` means median
`[minimum-maximum]`; a single value means all five runs had that result.

+----------------+------------------+------------+---------------+--------+
| Case           | P1 err           | Ep abort   | PI block      | P2 err |
+----------------+------------------+------------+---------------+--------+
| arm64 baseline | 2043 [2031-2047] | 0          | 0             | 1      |
| arm64 mapping  | 0                | 26 [20-28] | 355 [308-399] | 1      |
| x86_64 native  | 0                | 31 [25-92] | 201 [147-204] | 1      |
+----------------+------------------+------------+---------------+--------+

The columns mean:

  - `P1 err` counts `error_sleep` records from the Phase 1 epoll test.
  - `Ep abort` counts records containing both `ep_wa` (`EPOLL_WAIT`) and
    `ab_sl` (`ABORT_SLEEP`).
  - `PI block` counts records containing both `ep_wa` and
    `bl_on_rt_mu` (`BLOCK_ON_RT_MUTEX`).
  - `P2 err` counts `error_sleep` records from the Phase 2 negative
    control.

These are records retained in the trace buffer, not syscall totals or
rates. The P1/P2 error outcome was the same in all five runs. The
`Ep abort` and `PI block` counts vary with timing.

The per-run summaries and validation checks are in
results/revalidation-2026-07-24.md in the repository.

From the traces, I see the following path for a correctly recognized
epoll wait:

  sys_enter(epoll_wait or epoll_pwait)
          |
          |  native x86_64 entry, or arm64 experiment mapping
          v
  EPOLL_WAIT = true
          |
          v
       ep_poll()
          |
          v
  TASK_INTERRUPTIBLE -> SLEEP
          |
          +-- no event
          |      |
          |      v
          |   schedule() -> RT-safe wakeup -> SCHEDULE_IN
          |
          `-- event found by the locked recheck
                 |
                 v
              skip schedule()
                 |
                 v
              TASK_RUNNING -> ABORT_SLEEP

In the abort case, `ep_wa + sle` (`EPOLL_WAIT + SLEEP`) is followed by
`ep_wa + ab_sl` (`EPOLL_WAIT + ABORT_SLEEP`), with no `sch_in`
(`SCHEDULE_IN`) in between. This matches your wording: the task becomes
runnable again without blocking or going through a wakeup sequence.

I also observed `ep_wa + bl_on_rt_mu` while epoll wait was active, so the
test did reach the PI-aware locking path on PREEMPT_RT.


arm64 syscall-coverage gap
--------------------------

The arm64 run also turned up what looks like a syscall-coverage gap. The
current epoll support checks only `__NR_epoll_wait`. arm64 does not define
that syscall; its epoll wait enters the common implementation through
`__NR_epoll_pwait`. I went back to the review of the original epoll
support:

https://lore.kernel.org/r/58674d7f10c260369f5cb78599ba6ecb3804358f.camel@redhat.com

That reply discusses the `ltl_atom_update()` detail. I could not find any
discussion of cross-architecture syscall entry coverage there. In all
five unmodified arm64 runs, every retained `SLEEP` record has a matching
P1 error. Mapping `__NR_epoll_pwait` to the same atom removes those
errors, while P2 still produces the expected error.

This points to an instrumentation coverage issue rather than a difference
in epoll's real-time-safety. I kept the mapping out of this documentation
patch. Once the intended scope for `epoll_pwait`, `epoll_pwait2`, and
compat syscalls is clear, I can send a separate functional patch.

For reference, this is the experiment-only change:

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index aa5a984853b5..bf9ca4b5414e 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -136,8 +136,11 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 		break;
 #ifdef __NR_epoll_wait
 	case __NR_epoll_wait:
+#endif
+#ifdef __NR_epoll_pwait
+	case __NR_epoll_pwait:
+#endif
 		ltl_atom_update(current, LTL_EPOLL_WAIT, true);
 		break;
-#endif
 	}
 }


Thanks,
Chao
