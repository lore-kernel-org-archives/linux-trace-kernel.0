Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78A381E9E;
	Thu,  2 Jul 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021890; cv=fail; b=UKxhDk8vtcC7SZcXFaxeJcib9waMpj1hnFyu/ANPQBM8Kg9cV0sZzK8XmjVu/kHCcwSISmi2HS4gTXcmCQGbBlAjQk6E89yJHY39xiB1WKXdQbAUXmsPixXoHmVuINmP+FIqCFtIoDcDFov0xgCqISKT9zUzfdI7sYcvMVhoFHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021890; c=relaxed/simple;
	bh=C/P3ixrL+ddigFKh9Hfk0MM8cQ2P5g5/z0WHX0X5au0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tb8AyaiQTsQD4WzF/dvDT5VDvLZxL7oJ6viVcJd2sgj5DrSd3RT2uADNGCcwzhonrcfcLZbS4WYWzGoLdNMHbbnVV34BctBOuLibgFY4CQzA+zRm4fpILA2LyGd5M9NZvKeY79VmuolyQe6FlAF79W7ulNuyFFdu/WHHN3TggGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qs7F26Ul; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qs7F26Ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAcd3PBMKTLA6RtsT+LmBkpnk/dHp+ML8r0rG7/nFsMAgG5z1JFCpzHhD9itbVnf7BUix0cBRoHAGF5ouFg/cR+a4PkYqZW6bb2VFUoCy9dUlISVYG4GYp/kl8HQDz6P8h5zMepzt1HMYPmmB/O8FqRKFHP7UMNyAIHBWJ2r3+FE6bj+KfrmI/Pmc0HtdkySiAQ5OyzzMgSIiFjF1qeDIaTsBJ4VCxxY3FqHJqDEVnv58QxIxwpyDUmXfWsMmjeB+19NJ+0rGjm6xTmu/UM8JeLrejfmZhn7b8THuAitDP927b+laQsuh2Y8nS4TEM7w4qYlbZa2mGokmOFMzAddPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si5mvJi/SH6XZFMUgqmK+yr+2xef1L+NPBqHkFGaTdg=;
 b=VFYDYLHin6YW6SIW7q9TwyCpns+7r26MyaOIrQ4laWqpl8dQcW0/Isb/0hvuY09uy+5plM0tstVAE8qqNMTwIAH8i+ti5YJzgyK9OXy53B6iYsXHiYloOGstJXjGB/zcQ/x3k6jC9AzM5AOlaS6/H3cnnoMTEaxqKS5KeJ6h8rZhMdLdHsiHGopIHnI9bH1J8eYHx7bJO3Wf0N+xyfU+HgRHuqekGzIlATf79l05A11jy/MXMNiY9XbRooMqUMBihjLpXMMdPxDfPN721EQoavv3jWmJsPckDRmqtoNo8zTEJe+DYazIA77qNzt4L27HUKBTAqUb/lL+/GcZxoldLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si5mvJi/SH6XZFMUgqmK+yr+2xef1L+NPBqHkFGaTdg=;
 b=qs7F26Ul8U8nzQx4RYqcDQyKcIN3wR8poxlwr3l227dgutfkOJy1aJQfCT2dPiaP7t/q/7hFuNKYjHM29fPcRpkiJfFKTGroxhr6TbPYtWVULlzKQPrfjHo/yJSPH2EaZiTbLibfR10/+fIbJSJrUG5uE/3dNc31QeXfFg7+zFg=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 19:51:19 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::a4) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Thu, 2
 Jul 2026 19:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 19:51:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 14:51:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 14:51:17 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 14:51:09 -0500
Message-ID: <6c190305-4137-411f-ba25-e0a2d8484db7@amd.com>
Date: Fri, 3 Jul 2026 01:21:03 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] psi: Introduce in-kernel PSI auto monitor feature
To: Pintu Kumar Agarwal <pintu.agarwal@oss.qualcomm.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<hannes@cmpxchg.org>, <surenb@google.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <peterz@infradead.org>,
	<mathieu.desnoyers@efficios.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <pintu.ping@gmail.com>, <nathan@kernel.org>,
	<ojeda@kernel.org>, <nsc@kernel.org>, <gary@garyguo.net>, <tglx@kernel.org>,
	<thomas.weissschuh@linutronix.de>, <aliceryhl@google.com>,
	<dianders@chromium.org>, <linux.amoon@gmail.com>, <rdunlap@infradead.org>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
 <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f36f8a-037f-4c82-26e0-08ded87348d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|7136999003|56012099006|11063799006|5023799004|4143699003|6133799003|921020|11062099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	naOBwK6GMeWD/5qguSBEYI2Z7inTRjeqXwQZSXXWM1PzeArAtQZqIyKrsHtSZU9ZaZuz5ly6CLkg9KY5QiMnh+8VArI+ybZXVjd0k7A/C9LVOgHatFEeIpLhvHylH9EjIf2nVIW/CShxo/GaXTmx+mU1GlTnojikxZyEs3RUCfGjUYwG1+kPmXpcXcaBS7ulZp8F7bU5yJRcjoQ4p5r/47ilx7PUAx4sGWrj1lotaL2gvmS+RBPTfSHCqairRoKJSeqHk6ovh/RDYSX4+tsT+4VcdROrJUUW5H6ZyO4bDfB8+C7n2n3T1TBrXKHry8BLtwEjBbinnKrjp4zh0L+z0kNIWt+wgDdwJh2F8VW3o2GkgcLZcAvYd/mCpIE/D1BltM3YAgHVMpSMkXBe1km1Zgs8vpqB0VxM6ij6nZqcRY1ZQWhivANPlfvreJYTOZOlMChm/+1LtkYiFF1tsUG7J58XYHbmT+6TApfTX7+TDeMqykZzTTOE2A2UD10WDF9UPdnd67T6W01ZIjiP+c+bBdQWPtEBP2GoQ6l18jTLpuDu80GkI4LJjKzfhOZLiF60RQhZ7+Vn8Ek0Gmz5ndJSwAgPF67k9CEcv2JTbRbcSlJ16kaSrgcwA7AlUMNaBkcJolv1PmTwSVPecG71z0Yf/xKmReO/wc8kpccs3qC3EvxV+WzINCyBDRkC0aukdXNZpz7pmERjiM6xf/5sY4bfGiKY/NPJ38qfD3T5LXoPlJOpGJbdEN8IQRAWhcPVv1fP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(7136999003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(921020)(11062099010)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EjfcwvBcbrKMzDDTofVgemtCm0J5IEHVOIHhO8SInhpNEe7s4yGyJUwmXocb7466Xx8SsRbMAGHRXpYYHbZCG6JTGgD/76rNqu/ssaLa07Qj7EyJLBwP4aWzU8v17F7J9N3C7i7BECxY8/aX+GjJGKc9jQoZAB6YchOcv5/z7TdoZwdUYc3S+ie6qJECD5PZYqDoRBZknNK7z73k7jXbY05YnoKlfi40xXG/08MYYkLxi3WlalmnuqIf43v8rY5QXGHmQW/52tPaIS2Ie0gBUUsW2iPr0y1biyqgfowzNnCMZNJlfcuSmMbot91BJwpoEtaRwm0A65RJCbjVveUmoh1wL6SWJo/j+ORT6IbVIaYVSjcGt05MhZEdITJdLcybCR9RuqlOQUylUhTuHT1ALwOmkchroorusjK0+ejOof3xuhG3okhkwDcwbus1j05n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:51:18.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f36f8a-037f-4c82-26e0-08ded87348d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866

Hello Pintu,

On 7/2/2026 10:46 PM, Pintu Kumar Agarwal wrote:
> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
> index e2cf3b08d4e9..30e9800ce947 100644
> --- a/kernel/sched/build_utility.c
> +++ b/kernel/sched/build_utility.c
> @@ -104,3 +104,7 @@
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  # include "autogroup.c"
>  #endif
> +
> +#ifdef CONFIG_PSI_AUTO_MONITOR
> +# include "psi_monitor.c"
> +#endif

Isn't this a module? Why is this being included as a scheduler file?
Based on a quick glance, nothing in this module needs scheduler internal
APIs (and nor it should) so tools/sched/ would probabaly be a better
place to put it in if there is interest for this feature.

> diff --git a/kernel/sched/psi_monitor.c b/kernel/sched/psi_monitor.c
> new file mode 100644
> index 000000000000..e929a0c05494
> --- /dev/null
> +++ b/kernel/sched/psi_monitor.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PSI Automatic Monitor with Weighted Task Ranking + Tracepoints
> + *
> + * Periodically samples system PSI (CPU, memory, IO) and, when any
> + * configured threshold is exceeded, ranks tasks using a composite
> + * score based on RSS, I/O activity and CPU time, then logs the
> + * top-N tasks via printk and a tracepoint.
> + *
> + * Sysfs interface:
> + *   /sys/kernel/psi_monitor/cpu_thresh                 (percentage)
> + *   /sys/kernel/psi_monitor/mem_thresh                 (percentage)
> + *   /sys/kernel/psi_monitor/io_thresh          (percentage)
> + *   /sys/kernel/psi_monitor/monitor_interval_ms (milliseconds)
> + *   /sys/kernel/psi_monitor/rss_weight
> + *   /sys/kernel/psi_monitor/io_weight
> + *   /sys/kernel/psi_monitor/cpu_weight
> + *
> + * Author: Pintu Kumar Agarwal
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/workqueue.h>
> +#include <linux/psi_types.h>
> +#include <linux/kobject.h>
> +#include <linux/sort.h>
> +#include <linux/jiffies.h>
> +#include <linux/time64.h>
> +#include <linux/sched/cputime.h>
> +
> +/* Create tracepoints defined in include/trace/events/psi_monitor.h */
> +#define CREATE_TRACE_POINTS
> +#include <linux/psi.h>
> +#include <trace/events/psi_monitor.h>
> +
> +
> +/* Sysfs tunables */
> +static unsigned int cpu_thresh = 80;     /* in percent */
> +static unsigned int mem_thresh = 80;     /* in percent */
> +static unsigned int io_thresh  = 80;     /* in percent */
> +static unsigned int monitor_interval_ms = 10000;
> +
> +/* scoring weights */
> +static unsigned int rss_weight = 2;
> +static unsigned int io_weight  = 1;
> +static unsigned int cpu_weight = 5;

Insanely configurable but what makes it easy for developers to know
the right configurations under severe pressure as you put it?

> +
> +static struct delayed_work psi_work;
> +static struct kobject *psi_kobj;
> +
> +#define TOP_N 20
> +
> +struct task_info {
> +       struct task_struct *task;
> +       unsigned long rss;      /* pages */
> +       unsigned long io_kb;    /* kB */
> +       unsigned long cpu_ms;   /* ms */

Isn't the suffix selfexplanatory? Do you really need the comments?

> +       u64 score;
> +};
> +
> +/*
> + * psi_avg10_percent() - derive a rough integer percentage from avg10
> + * for a given PSI state (e.g. PSI_CPU_SOME, PSI_MEM_SOME, PSI_IO_SOME).
> + *
> + * psi_group.avg[state][0] is the avg10 window in fixed-point notation.
> + * The conversion here is approximate but monotonic, which is sufficient
> + * for thresholding and ranking in this internal monitor.
> + */
> +static unsigned long psi_avg10_percent(int state)
> +{
> +       u64 avg10;
> +
> +       if (state < 0 || state >= NR_PSI_STATES)
> +               return 0;
> +
> +       avg10 = READ_ONCE(psi_system.avg[state][0]);
> +       if (!avg10)
> +               return 0;
> +
> +       /* Convert back from loadavg-style fixed-point to an approximate % */
> +       /* Just consider the integer value and ignore fraction */

Why two single line comments?

> +       return LOAD_INT(avg10);
> +}
> +
> +static int compare_score_desc(const void *a, const void *b)
> +{
> +       const struct task_info *ta = a;
> +       const struct task_info *tb = b;
> +
> +       if (tb->score > ta->score)
> +               return 1;
> +       if (tb->score < ta->score)
> +               return -1;
> +       return 0;
> +}
> +
> +static void log_top_tasks(void)
> +{
> +       struct task_info tasks[TOP_N];
> +       struct task_struct *p, *t;
> +       int count = 0;
> +       int i;
> +
> +       rcu_read_lock();
> +       for_each_process_thread(p, t) {

Thats a ton of work every 10s.

> +               struct mm_struct *mm;
> +               unsigned long rss = 0;
> +               unsigned long io_kb = 0;
> +               unsigned long cpu_ms = 0;
> +               u64 score;
> +
> +               /* Ignore tasks that are not on run queue or idle */
> +               if (!t->on_rq && !is_idle_task(t))

Condition doesn't match the comment. Tasks off rq that aren't idle will
still go through.

> +                       continue;
> +
> +               mm = get_task_mm(t);
> +
> +               /* mm could be NULL for kernel threads */
> +               if (mm) {
> +                       rss = mm ? get_mm_rss(mm) : 0;
> +                       mmput_async(mm);
> +               }
> +
> +               /*
> +                * Approximate I/O activity: sum of read + write bytes.
> +                * This uses the task_io_accounting fields in task_struct.
> +                * Values are best-effort and need not be perfectly accurate
> +                * for our ranking purpose.
> +                */
> +               io_kb = (t->ioac.read_bytes + t->ioac.write_bytes) >> 10;
> +
> +               /*
> +                * Approximate CPU usage via task_sched_runtime(), converted
> +                * to milliseconds. This is cumulative since task start, but
> +                * is still useful for comparing hotspots at a given point.
> +                */
> +               cpu_ms = (unsigned long)(task_sched_runtime(t) / NSEC_PER_MSEC);
> +
> +               score = (u64)rss_weight * (u64)rss +
> +                       (u64)io_weight  * (u64)io_kb +
> +                       (u64)cpu_weight * (u64)cpu_ms;
> +
> +               if (count < TOP_N) {
> +                       tasks[count].task   = t;
> +                       tasks[count].rss    = rss;
> +                       tasks[count].io_kb  = io_kb;
> +                       tasks[count].cpu_ms = cpu_ms;
> +                       tasks[count].score  = score;
> +                       count++;
> +               } else {
> +                       /* Maintain a simple streaming top-N: replace smallest */
> +                       int min_idx = 0;
> +                       int j;
> +
> +                       for (j = 1; j < TOP_N; j++) {
> +                               if (tasks[j].score < tasks[min_idx].score)
> +                                       min_idx = j;
> +                       }

Can't you just cache the min_idx and re-compute it when it changes
instead of taking a O(20) iteration for every task?

> +
> +                       if (score > tasks[min_idx].score) {
> +                               tasks[min_idx].task   = t;
> +                               tasks[min_idx].rss    = rss;
> +                               tasks[min_idx].io_kb  = io_kb;
> +                               tasks[min_idx].cpu_ms = cpu_ms;
> +                               tasks[min_idx].score  = score;
> +                       }
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       sort(tasks, count, sizeof(struct task_info), compare_score_desc, NULL);
> +
> +       pr_info("psi_monitor: logging top %d tasks under pressure:\n", count);
> +
> +       for (i = 0; i < count; i++) {
> +               struct task_struct *ts = tasks[i].task;
> +               unsigned long rss_kb = tasks[i].rss << (PAGE_SHIFT - 10);
> +               char name[128] = {0,};
> +
> +               if (ts->flags & PF_WQ_WORKER)
> +                       wq_worker_comm(name, sizeof(name), ts);
> +               else
> +                       scnprintf(name, sizeof(name) - 1, ts->comm);
> +
> +               trace_psi_monitor_top_task(ts->pid, name,
> +                               tasks[i].cpu_ms,
> +                               rss_kb,
> +                               tasks[i].io_kb,
> +                               tasks[i].score);
> +
> +               pr_info("psi_monitor: pid=%d comm=%s psi_flag=%d oncpu=%d cputime(ms)=%lu rss(kB)=%lu io(kB)=%lu score=%llu\n",
> +                       ts->pid, name, ts->psi_flags, task_cpu(ts),
> +                       tasks[i].cpu_ms, rss_kb, tasks[i].io_kb,
> +                       (unsigned long long)tasks[i].score);

This will unnecessarily dump to dmesg even if you have tracevent
enabled. Why?

> +               }
> +}
> +
> +static void psi_monitor_fn(struct work_struct *work)
> +{
> +       unsigned long cpu_pct, mem_pct, io_pct;
> +       bool trigger = false;
> +
> +       cpu_pct = psi_avg10_percent(PSI_CPU_SOME);
> +       mem_pct = psi_avg10_percent(PSI_MEM_SOME);
> +       io_pct  = psi_avg10_percent(PSI_IO_SOME);
> +
> +       if (cpu_pct >= cpu_thresh || mem_pct >= mem_thresh ||
> +               io_pct >= io_thresh)
> +               trigger = true;
> +
> +       if (trigger) {
> +               pr_info("psi_monitor: pressure high: cpu=%lu%% mem=%lu%% io=%lu%% (thresh cpu=%u mem=%u io=%u)\n",
> +                       cpu_pct, mem_pct, io_pct,
> +                       cpu_thresh, mem_thresh, io_thresh);
> +               log_top_tasks();
> +       }
> +
> +       queue_delayed_work(system_wq, &psi_work,
> +               msecs_to_jiffies(monitor_interval_ms));

If I set monitor_interval_ms to 6 hours, and then change it back to 10s,
it'll only take effect after this callback has fired 6 hours later.

> +}
> +
> +/* Sysfs helpers */
> +#define PSI_ATTR_RW(_name)                                             \
> +static ssize_t _name##_show(struct kobject *kobj,                      \
> +                       struct kobj_attribute *attr, char *buf)         \
> +{                                                                      \
> +       return sysfs_emit(buf, "%u\n", _name);                          \
> +}                                                                      \
> +static ssize_t _name##_store(struct kobject *kobj,                     \
> +                           struct kobj_attribute *attr,                \
> +                           const char *buf, size_t count)              \
> +{                                                                      \
> +       unsigned int val;                                               \
> +       if (kstrtouint(buf, 10, &val))                                  \
> +               return -EINVAL;                                         \
> +       _name = val;                                                    \
> +       return count;                                                   \
> +}                                                                      \
> +static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
> +
> +PSI_ATTR_RW(cpu_thresh);
> +PSI_ATTR_RW(mem_thresh);
> +PSI_ATTR_RW(io_thresh);
> +PSI_ATTR_RW(monitor_interval_ms);
> +PSI_ATTR_RW(rss_weight);
> +PSI_ATTR_RW(io_weight);
> +PSI_ATTR_RW(cpu_weight);
> +
> +static struct attribute *psi_attrs[] = {
> +       &cpu_thresh_attr.attr,
> +       &mem_thresh_attr.attr,
> +       &io_thresh_attr.attr,
> +       &monitor_interval_ms_attr.attr,
> +       &rss_weight_attr.attr,
> +       &io_weight_attr.attr,
> +       &cpu_weight_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group psi_attr_group = {
> +       .attrs = psi_attrs,
> +};
> +
> +static int __init psi_monitor_init(void)
> +{
> +       int ret;
> +
> +       INIT_DELAYED_WORK(&psi_work, psi_monitor_fn);
> +       queue_delayed_work(system_wq, &psi_work,
> +                       msecs_to_jiffies(monitor_interval_ms));
> +
> +       psi_kobj = kobject_create_and_add("psi_monitor", kernel_kobj);
> +       if (!psi_kobj)
> +               return -ENOMEM;
> +
> +       ret = sysfs_create_group(psi_kobj, &psi_attr_group);
> +       if (ret) {
> +               kobject_put(psi_kobj);
> +               cancel_delayed_work_sync(&psi_work);
> +               return ret;
> +       }
> +
> +       pr_info("psi_monitor: in-kernel PSI auto monitor (weighted + tracepoints) loaded\n");
> +       return 0;
> +}
> +
> +static void __exit psi_monitor_exit(void)
> +{
> +       cancel_delayed_work_sync(&psi_work);
> +       if (psi_kobj)
> +               kobject_put(psi_kobj);
> +       pr_info("psi_monitor: unloaded\n");
> +}
> +
> +module_init(psi_monitor_init);
> +module_exit(psi_monitor_exit);

There is nothing here that warrants putting this in kernel/sched.
Also this gets included by default when config is enabled and starts
dumping a bunch of stats to dmesg without anyone asking. No?

Afaict, almost all of the detail used here is also available from
procfs and people can easily put together a userspace tool if they
need it. Why do we need an in-kernel module?

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Pintu Kumar Agarwal");
> +MODULE_DESCRIPTION("In-kernel PSI automatic monitor with sysfs, weighted scoring and tracepoints");
> --
> 2.34.1
> 

-- 
Thanks and Regards,
Prateek

