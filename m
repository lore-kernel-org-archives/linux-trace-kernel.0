Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2085.outbound.protection.outlook.com [40.92.62.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A946556
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421513; cv=fail; b=fPuvy1PN9vhItycDnbp3WSxG0Cc7RaT/9ZWKq1mE83+CnzlQgHJnFOXhdjjzugqQkrSKfUjpZl+e6S32sNtfi5FYzCM3DuEgiyCegHWFPEOUr9bF0g1ML5TisViZnBcirR10jQhPp41WiBAm23Qb0tNtOO3qsVEWROw6vp2eSnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421513; c=relaxed/simple;
	bh=fYqlErhYAVdP24LRBD6+Bb0IIQ41fnGLlT9M2k5RUOY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GBqrNRYagUKSSCnlZHEAhh3av8USTtXpHMs7i9k/4OyfegAB/NWwkSmwcQ5zcMi272KxT8d1du9d3d6YLVcs+p7g2+qXvmQNlQT5oJtJIVoPL+/99TtDFVqUIg9CN1lNU2t+bkOQTVJjiKl3iVrl7S6a91cA1gkbVnKHlDP0DUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OJ0F+etv; arc=fail smtp.client-ip=40.92.62.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OJ0F+etv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIzTobjnudGFShZnMFzbVKC254dM7xyUxzJoOIebkDtd8xnGarsfSEQcwM0WeB6xxImC6X6c7UZeFtteBiCGa9tqFuQvzbTC+Au+QIgDIHx7Ss2TX9oBbM5G3fuYw+aYplWP5kMWiicz+E4ppT78V2cpwgK78IEAa97C/93Nt1ZkKI8N8/9Z8qPzRfBtCEnZqqQsfWnHdLlmLmm6OiJfmwolyQ5jPKjHqmrQrm9S2jh58I0VMSvZsS6hyLpYOc+b3CLKrhNI8A8wlatHnOiUnTYTzUPU22E2alvCBSVsRI9I5e+hDq2jJqSO3qT6toH/qu6v2d6ZNKlChikSjMqSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcFTQZSvKbLAMgPBJh2/ESPsspqXNXVDa3EK60NdT3Y=;
 b=onthdrgfHMS0ZLPmEwu6h3ZVEiRfI1DfTwAJun5gEMRDTPa3m9mAUQ1wERKFjZyGh2AEmWclwxt62G96Nvfr4+Y/a7Rk/WxjCjDnr9wSLoAFIPjhYqPcdnx5CfBy1n0RJzIBmXUfeV+MlRWaiChCG7bnl2OJGiw2OpBGdPNUYEAfS0RgNLYlDFxvNFuhEDGHQ4QTg8eAtj205pqZ/0PIj4SHqeeKs1TzLu/hMSljVl4yKI8e0JQknIzueJpVJDYsucE8Cp7toxziYRxC7RpkxA9vkqJqd4FWlp3xQ87Tqrxs2zH117QW72Mlkcdv6fTZVARsJEpZ49xo0UH0BU/ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcFTQZSvKbLAMgPBJh2/ESPsspqXNXVDa3EK60NdT3Y=;
 b=OJ0F+etv3OLuiTmJzHXnN3FF+N5uoXIFiU2oa8GDfPnUra68f5jN301cwOSjVT0rTdpS0KSPPDWV+WdPJY0ubcKn2GgfeZqkg9kpglIf/TOwTFnvZF0pKhKM2OOcgKsMyhEjAD1FpYg2gzuXObVTH5pl02xUrPmvnmB8RLnsWlWWXhC5OtQeLpakjoPL8pvb3dvk0/DjOzpGH2jL+xZCUQ3Dd9SpZiGehTwp3Q933Gq6c/WY6+aXnqJsKIn9VvFlRua4oZcSO8Xe6OO+quCpWb6Y/ds30KWmFs0nYU0HZRlVHJK0i3NK0rZQYQvqVuMW+Nvxm6SJx7SUGTwew/sWWg==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY2PPF2E967C861.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::38c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:58:27 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 13:58:27 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org,
	Tianyi Liu <i.pear@outlook.com>
Subject: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Fri, 23 Aug 2024 21:53:00 +0800
Message-ID:
 <ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [LP/6AAPC6vHOruLTBg5rwGbpqOFEklhQHWiDQVTH4RoeO8teDBX0bw==]
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240823135300.14827-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY2PPF2E967C861:EE_
X-MS-Office365-Filtering-Correlation-Id: 779dfa1c-05e0-499e-cc47-08dcc37ba955
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|19110799003|8060799006|5072599009|3412199025|4302099013|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	eCb0A6WXPUl6q6Zem+PCsTt//OotZz1lgMDlyWZW//ESDVZ66udqI8HiMx2Kh13wog6smfxVw4YhBAO49a7+Vd/mGsU8Hg167nfvnWqqcQAjgH4fhmWlNJM1G8vSNAQGWURSDVSWfBoCbeWN0Hnyq0fltqsPROgUZX6Vc/JeZFsqM3Ev8+dzGfVw5PAGOOnOgLfIQmRVFemH+mvnBAw7jSpecMjqs4R560ZRJtwFsMR+eaE9AgR+pCHp8jaDDMSjJ9y11PtWOhzpsg44OlZ7T9GKwVpoN9Ct37lsU+9FEilNjpjLPX+zkILzQWzCC/Bgab9DeQYWrzTh5uUJVpPId8uX2GooNjfSlNOwid2QgjtdUfCrCz0r59QDlfTpGdAU7by7D8FLbFz6B1j1eXRJ8PoePPrkl0rJgUsfaC6XZsKHymKSX/PNQBd4vJs4038YSE0aDvUUIUWRJjivb/73ijEbz3YKhSbuR2a3wGTw7vTkGmEUeSgjnRP3Pq7rwXWOdS2QCTDBOckKyaCNxftpNo+wPxonyo0+JIwCmULwBbmld++FQhDtR4+nqIwaJY1tZCeuvhN8pGNy/HU2XoEy/2EfCnMHa+DvEK/SXjhvW+awYL0tLGKYtBTg3cPaDO56TCJT7YNuXVoIlHcfm0eBB4r5Saae2xBC5EoTd5SK0yFQBlnOj3Sjefecvc5N82A5k0bILE9LBfgfW07P8SaNOrXelwI0j4Qr6EnQaTFfuWdgtOOybJLilio9e32A6BqD5+xQozxqKgZOf7JAR4Y+6HacoBhtXr+CxBniMfTYCXSVdMfo1GYv9xr504nxoXE8o60fzmrSMHTyiXs9QH2X/OHdxu5Q844HuZYA71pF9Xkji3Yo4/bXe+xaqYrAugKJk6f4w1wPr0OchlqUemw6bQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ytTWPSSR+k8CZ1/f+NnBnC0eUIXs8NeOskTTBui4HR6vpqMrnJzImwiYdTk7?=
 =?us-ascii?Q?i6IMR9X8ElxMaTyMAbTNVtSYrAx9PPfBBsqoEFYessOeBJ0u+SmTp7CU9ZRE?=
 =?us-ascii?Q?zZR3qObtu5L8lwre3qE/qpC8ohTt1fge0ykCQPTf7DNkBTulGYE+2af/LCCz?=
 =?us-ascii?Q?+QwKTPcJI78fWKGF53Zd7ouljnWFCjdwmfqLpaYu+I9yo3sGytiFSgIaznNn?=
 =?us-ascii?Q?qMzQ/fBzni4fXwKEvhSQ+9PXHQPWrUF4rsgrL6dpSy5bzxsLypUEEQXc8zmi?=
 =?us-ascii?Q?8sFlAwgJnuVybIBXWgujKXc9FtHiZG5HC+VWFcahWPHFMsD8ErgVEqiHBt5u?=
 =?us-ascii?Q?2LLBrZmvwZCgxienBNn6gz/cw4Mi3K7agxrQIbCg5hUE2x17yorneRuK94VI?=
 =?us-ascii?Q?cmEMn4HkcM4RNSgCQHHBun07GjMgqiLjw5GY2ooah2oi9tLKbiN9FYPunQFg?=
 =?us-ascii?Q?di7Kypii1kitPjDj9cHQ4PLKMMcasGLQWtmUOQiU5ieuOvw2uoYo4jNHFJSV?=
 =?us-ascii?Q?VHbV0M6dNekIW9sQJtzWM5tDMbZmJH8RvJnvnLAz7Qg+TNxkJvT9zWYB9b24?=
 =?us-ascii?Q?tFWACzoGEvEyqzvTMmHtdI93Ce+k7q1DKhIlbnD23aomTebBeulxTKNCBfc7?=
 =?us-ascii?Q?gC+ha4Qm00+w9oU6mH6k0zbZTAGVBymv5b33XR3Yo1CCs6rtjXT4yFd0D2SZ?=
 =?us-ascii?Q?sem2pg6AFwCXBw/57c9Ax21rnJZmDFdpkMYrzqnEwWpNHgO0QHi8F3QqsVbf?=
 =?us-ascii?Q?Baj+Nvb+hlkFwkzE5QUAI3ap1w5eawaVzJ2FhZJnRE2oDpZLDlFBIcI5GA8R?=
 =?us-ascii?Q?ABTkVjPqkYb5z55GIHZg/6uDdMvXt7D0IflQWZlrcW0f0zYh6r2Pp9TXCHSq?=
 =?us-ascii?Q?OngyFSql8fCv8VzJpR6Wep014nQVZl1kUo5WNjmw8ABUE//FYJFtb9sm/dMR?=
 =?us-ascii?Q?ayG4CPMxPU4X9Dkp6yALsaB0rk82tmSesq8b2ly8S77QyUgMDMqeFjNOrbdG?=
 =?us-ascii?Q?bmDeJQlsqZTkIWuXco+uD4cI3TfhWR3fb3PEYUl7wgvR43rdCMBPpoiW+ui2?=
 =?us-ascii?Q?pZn7CplbvBoJJ1qmQN8RqhjnPgUDw9AM48Qe6IP0zbgNKNKRoYbYtZmqB2BY?=
 =?us-ascii?Q?zikhASJD0Qxiai3nrTIB7889GutRB3D5sl+W2Us2pzZhBwc7lGMS3YoAbHbY?=
 =?us-ascii?Q?D8AQKh81WR9wVyF3XQWi2TSzRzjt2uZt3pRT5xo7rPE8U9KV3yufcFxIznVZ?=
 =?us-ascii?Q?aEkD1/Zq4xwNu9PCuCWQasmPtvRVij+ezFz9lpOrzg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779dfa1c-05e0-499e-cc47-08dcc37ba955
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:58:27.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF2E967C861

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

Before:
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

After: Both bpftrace instances will show the expected behavior, only
printing events from the PID specified by their respective filters:
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

Fixes: c1ae5c75e103 ("uprobes/tracing: Introduce is_ret_probe() and uretprobe_dispatcher()")
Cc: Alban Crequy <albancrequy@linux.microsoft.com>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
Changes in v2:
- Drop cover letter and update commit message.
- Link to v1: https://lore.kernel.org/linux-trace-kernel/ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM/
---
 kernel/trace/trace_uprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..c7e2a0962928 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1443,6 +1443,9 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
 				struct uprobe_cpu_buffer **ucbp)
 {
+	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
+		return;
+
 	__uprobe_perf_func(tu, func, regs, ucbp);
 }
 
-- 
2.34.1

