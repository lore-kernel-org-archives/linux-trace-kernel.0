Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2011.outbound.protection.outlook.com [40.92.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161C1D12E4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348306; cv=fail; b=XU7weHEttrxFBuTTCAzH9dJEEfcKjupYENdPO7W66Z3xsRwTp4M1JdDG4tw5RK1jcZzswoisbu2kfFAF2Gq4z90YkE/IHjuu+EXuWw7AGNQGgnAjg17ilcKWcKt9oCiJJ3M9HRBXYVPoJgeVAxS73SdkIQ7nL9ORiOcUtjdQ5Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348306; c=relaxed/simple;
	bh=501iqLH7MZ9cSjc95qpqE3vBk0CkI1R2JgtUaJH8auk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lcGHH9ggRBNGxmBZ+bqrxlP220mHcDlpVKRiyjFqe7L/PvNiHq9cigr6Japnui00ZqqmZ090nsdeLjQmZWhXcA4uc16sILx9O57y9mWeJyFwr/TQv5oXwg6WWTvuqM+5+Ghd4JFXvYniDisP2mYGiKPfaVqzLvmF6es6So5ZfIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fem6dIXb; arc=fail smtp.client-ip=40.92.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fem6dIXb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIfRD2fGOE6wp4Lqb+Gsdk4+Db4aZ5hZ6kfWuIz3/wR/x7qAXToUxElkwwXBtJIpE6MQ9bfINwZIJbdVJMgQ3XY1ujclYjP7O/bw5B+jji1Sy13E61sTN4aCnN+/JHgoJ/weXk6+FkBBdn6Un3YJUTEu7qMJUnCG57n6r2SS/qWZbp3VwPXlpHjbLATz7+pVJteqeTJ91xxoVsd4EMNIp+yV74nmNF5ZEBqksYixfvIgRThf/hKzARHBfcAqZAcUw9NMCtQ7nmF5k+FjI964OYc4mLQ+SfhOdM6nl708FGKwcc1kYM2sQkME8QibAT8QcFkIVsjXXsafBOEsHqe/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcCVOY/oyKKRlc1sO4g4LcI6+KjNbvj5yMd0OtYwlKM=;
 b=FSHT3DSLi/IpkgCF93cv8SCEjH+jsmDChMTpFOA6ynZQfuAzils8v9CHa8oDxID0hzGjIQIl2oB6BEoYYlTPGyaFkSUwImAtLKQzmOoZzHoz8tfYjt+C8/8KIsS8CHmbM/hd2XT/u1+RclisoH1TMHaBDYQ8Tv6tmtm3xyxzw+NVyPk/qbCvuS3KBP5Nrqrwhe/faJgpkrZ9v7wBIa1fi7z+6LucqNAy/nqPOlbmYew171rW4UbFncdrEmyumusc4YFrbMcxAoaq/bjQJ6h7/beQKZLTI3sa9LkEaq1/hFA/Ll0yUNAQFv/uS2Th1OzEGGQmhAbQg2uuMiloGs/SLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcCVOY/oyKKRlc1sO4g4LcI6+KjNbvj5yMd0OtYwlKM=;
 b=fem6dIXb6RkN7dX9NVKABQzGlp83aLPcxcCQr2vf0bzGq5wsW0vajTmbinOPDehMqMjv/zAiRNmkSwQEZu8gbZLYLWP2Xi22S80OMoZNTX0yNhGZeZtf9gMwjPoA+mJmL0pzb8xjeCbb4BsS3uZ8wL0dW7Uya6ErtQyccZn/YmkXG1z1sN3KdjVHDsOTowWBltS6IkPD5jAV/OI1G4NJGLlxpKhbSTLM1WBJux5U9WJSe/ZG2Y/C4Y9MxZ04GasemFEt76QqDrnpR+KRnASCOSfoPi0I0Qs53G1EbQK97zbeNJLcDpRnJl5V9l7W60s7qd2/QKqfWn7glhasYi+xEA==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY0P300MB0722.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 17:38:20 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 17:38:20 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org,
	Tianyi Liu <i.pear@outlook.com>
Subject: [RFC PATCH v1 0/1] tracing/uprobe: Add missing filter for uretprobe
Date: Fri, 23 Aug 2024 01:36:20 +0800
Message-ID:
 <ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [6ywmg4sKzVO8bmcvx6hwZr56XxOuyIAJ4IRuUNSPEWM3FG6mOTpCdw==]
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240822173620.2865-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY0P300MB0722:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e9bd4c-bf13-4f96-62fa-08dcc2d136d3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|15080799003|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	yW9bBEs+9kPXDV/7gZqZe+8i25SqHfxsbP3lf1sIyIzmLNzIjNxVzRtngQhQMjZHN5tXkfIGAcMdsjROL2OYX9C6+q7F3BmaQ9RC/+PCXyZax5AgxiqYCZ2UbwtYFZmCs0kI144HxUHNSGboHXCBZdxtRrziAf0rcf/Yam044SvnW3DduAT8EiPENyCiKLoqp5b/OHkkZIQOxnuG0SheKQrJonza8kcqJlJU4WOENXXXRRDMVF+Q5cuCbOHyMKbsGdAby+CSuE0YuXnOwJEy4XmcySy0T69QnMGdo6Px9ugDbgCB3iehORsb1mAM781K3ooFqfqdqN0RBlCp/xNhC2JbDLQ15xZWemceM18auHtGEDlUQZnP8NWulBKZlVKs2dn3N8jwPPmxpxlWVy3lsyMj0/kwPwrVXAaBx5ZiPlcMW91VIE/XdBPht3u3CFTMEbykcd4kUnt+pyUw68e1FHR2pqz/TBkxCAuc8XNT/OMrXhw+UZ2vuXZpvIYdiT9rhIHMqBnCKIuY2iFuV5xr7wHf7shmjb0N0bWOUhk68134Ey/VoBydq/Gf+xDqHdIR86fmsgwKNtJqMrS/1fyj9U08llrFPAaOyGWav+VA9yRD43Isyqh1j1Qbom9VsFbj1ScwIL8SxbyqA/DrTSwGtLnBw3vI2gFpAJhOmSLAE9VUwdKt48+pxtTXI0Kic/lDy6ECWTldjfxJJj5Lt34UcuGQNESGqKC3GJepkN2YtRQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HujzmX5qRO4DjtiUS5i0FPKsLDcyirJWXax5WtujOOJVBdEWU4JW9ohZPEey?=
 =?us-ascii?Q?LT+4ayYhzVzo2zWq1WakQ8GjfPdbQqCvAX7cMvPEhKrA8a02pqLqlDExHDms?=
 =?us-ascii?Q?4D55DQqpwjazCqjCwKIcNsa29s0rlIBJLat1BC+UvmSiJvr+Dji+2R9xzONw?=
 =?us-ascii?Q?fxrZolV2xkBoGViJGsMVZo0EI0M/l3T1icDRYB6DradsXZPpbOe6R25E0gTx?=
 =?us-ascii?Q?D6ErTg+pwdWKqwCjz9gWFusMjaSkLPC4P0EhhGMd7ENFAqBPO1dRX8xuhfMU?=
 =?us-ascii?Q?4gXeOCEKQxEV9HEHe7LkgErlMFgX7+CMsYBXSyra/izivqpJzdCX5CnkfwXA?=
 =?us-ascii?Q?Le92mHflzC1FCEWSQRVqO6xzjRID18z5/rQD0y99C8afNyI332WB0RYnANyr?=
 =?us-ascii?Q?bR7pvBuR9iFyZ/RkBg2FAG3GlgOttJM0VN22RiK4IrJyJ4pVyx8s10f8ZifT?=
 =?us-ascii?Q?MU4hwAH/ab6HmyFcyuWMzVB7bi1qSMbc0jqhy1QfgyXP8SBzgkoqQ9krhYUD?=
 =?us-ascii?Q?WzJ5H+Oq0AEv4n/dNi4WkFbFQQiqQPfDdIoS4JGv29ruHR1VoCge4LMdXC88?=
 =?us-ascii?Q?a5qGzSiPJS8iMFC5jkD7MKOdvMLF+n534nCFO7n2uC/TW+umgHicpWfta2FG?=
 =?us-ascii?Q?nJ8ZxzBALbRpfK8WUYqVQf4Xu6NvtoTrM6jd0aWvT8yOfnymfETNU2R6i1ZX?=
 =?us-ascii?Q?GfGMig3FQQ2NeoY/7JXEJ9s4VJXiZiR6AmDPmTNe37ECIYIkLvhNQXRQWA6v?=
 =?us-ascii?Q?WYeBEeYDlOZamfwon6fBLkY8yEnOPyATvw/sqUL346LaHenmhUllgmjUX0IM?=
 =?us-ascii?Q?3DBTIqzpRPJ4uIMW1jlzpqhgZE+2f/YMy52SU0uwp52dDcNdkJveauje5XAi?=
 =?us-ascii?Q?9YzzErlNMnYc5DsJ4SLP7+wdc1lkksRuXJOmwYtneUAGBjDdI9jQTwQwlQyl?=
 =?us-ascii?Q?pasiBwFqAN4c467/GlQUrCrkDf4TSIDMhuNldYOgVfD97/7Wm1aecgO6lA3M?=
 =?us-ascii?Q?UjBSPcGLrnwHhFeiyRKTccmSp0AytdgTRJ+1m14x21VKYaYM9CiFkDi6zE0Y?=
 =?us-ascii?Q?60vV+OQFAERuVuwvuScQy2e547vJg9UAlMXNPA3Xhkg2MBac4A3Sod9gK9de?=
 =?us-ascii?Q?c4tP5bZyQW+jBf5cwHFGrWJ96Gnl/OStTy4yUVwrZcNmcSvLPE/vKuca5bHG?=
 =?us-ascii?Q?tCrEMyMp5Rs7z+dQELjQPtXPZGXS5JK7iOyuXBaBpDh8JaRPVnlKuncIVEqk?=
 =?us-ascii?Q?bSjeiN6nD0BIFA+JV6XRP61JTzZXe/ZGkM8PK9xW3g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e9bd4c-bf13-4f96-62fa-08dcc2d136d3
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:38:20.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0722

U(ret)probes are designed to be filterable using the PID, which is the
second parameter in the perf_event_open syscall. Currently, uprobe works
well with the filtering, but uretprobe is not affected by it. This often
leads to users being disturbed by events from uninterested processes while
using uretprobe.

We found that the filter function was not invoked when uretprobe was
initially implemented, and this has been existing for ten years. We have
tested the patch under our workload, binding eBPF programs to uretprobe
tracepoints, and confirmed that it resolved our problem.

Following are the steps to reproduce the issue:

Step 1. Compile the following reproducer program:
```
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    printf("pid: %d\n", getpid());
    while (1) {
        sleep(2);
        void *ptr = malloc(1024);
        free(ptr);
    }
}
```
We will then use uretprobe to trace the `malloc` function.

Step 2. Run two instances of the reproducer program and record their PIDs.

Step 3. Use uretprobe to trace each of the two running reproducers
separately. We use bpftrace to make it easier to reproduce. Please run two
instances of bpftrace simultaneously: the first instance filters events
from PID1, and the second instance filters events from PID2.

The expected behavior is that each bpftrace instance would only print
events matching its respective PID filter. However, in practice, both
bpftrace instances receive events from both processes, the PID filter is
ineffective at this moment:
```
PID1=55256
bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
Attaching 1 probe...
time=0 pid=55256
time=2 pid=55273
time=2 pid=55256
time=4 pid=55273
time=4 pid=55256
time=6 pid=55273
time=6 pid=55256

PID2=55273
bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
Attaching 1 probe...
time=0 pid=55273
time=0 pid=55256
time=2 pid=55273
time=2 pid=55256
time=4 pid=55273
time=4 pid=55256
time=6 pid=55273
time=6 pid=55256
```

After applying this patch, both bpftrace instances will show the expected
behavior, only printing events from the PID specified by their respective
filters:
```
PID1=1621
bpftrace -p $PID1 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
Attaching 1 probe...
time=0 pid=1621
time=2 pid=1621
time=4 pid=1621
time=6 pid=1621

PID2=1633
bpftrace -p $PID2 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
Attaching 1 probe...
time=0 pid=1633
time=2 pid=1633
time=4 pid=1633
time=6 pid=1633
```

Tianyi Liu (1):
  tracing/uprobe: Add missing filter for uretprobe

 kernel/trace/trace_uprobe.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1

