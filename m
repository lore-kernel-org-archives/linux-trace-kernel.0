Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA21EB194;
	Thu, 27 Feb 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642025; cv=none; b=GKJ+izkCfBOpGUZ58UmJH5Z+IEYWtfaLb4pEvD5WEXoQdWU9i9NZqUOcTB6vd9DMi6WPjkKnPtF55Qi1t08tmWlXm/4RfbRACemcJ8iAbKphHzNK74cxC/7Q1tbYLpB4BSgl2bt/rH0ahaKZFLswTyLa4Zg62ccynYK5LnLCE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642025; c=relaxed/simple;
	bh=WMGQuwmearbfXq1r1dLFq4ZBgsgMa2MFUxPv9CTWNh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6OIG3MvBBbM+XapbwgKNqOn3Ce+nNtQbrcgEh3keIH0CVSep6bDg4eA2R5Pm0P0NVSDEkptvk8LqPv8mae7Qj33VWnsGZadiQ1nVU7AEi8m1SeuI8dts+dSUzp0V+xnFgZEhQWLrzTSEnet4T8a6wLXW3u8NHSYECG0c0VCA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cpTyQdXf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cpTyQdXf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R20cNY004317;
	Thu, 27 Feb 2025 07:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Uzbd6eYLQtGBC5B0KdNg2qY5tKIBGR
	REdJbQmt7JDQ8=; b=cpTyQdXfL80ESEuug+JBpJ06BwOHK8zdZCP9kIO66uiiQ0
	T/e1O1JFa0zIVx+jzbxS0Ib2aTpg49QF9woD3ol2OPMA6Kh3ZYTFAfSudrGybA02
	zzw/mDPYdzTIk/fEmql8QTc/FHhSGJTWXLJE7OGYbDPBdHVUy9QcyZQ7uRv25NUU
	8HUlxzSQMl+CL1by990q3J9T6nbSCo3eGlCXgGkjwx/3Xwzh2cX3RuyZvBPq34vo
	Ofn3xTfYvIFqEZNIF6BI/LPgRYHkNO+hn9xyFgOlzAXclW/ZHw+Q4v+FHC+kmIzT
	+wpPm69JRt9h2rigiGONgbaeFHZ83o/8W+prU6Aw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0h6vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 07:40:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R7UxGo030363;
	Thu, 27 Feb 2025 07:40:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0h6vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 07:40:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R7OjKT027333;
	Thu, 27 Feb 2025 07:40:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum26xk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 07:40:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51R7eD6J58392834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 07:40:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7817020040;
	Thu, 27 Feb 2025 07:40:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E8A220043;
	Thu, 27 Feb 2025 07:40:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.223])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Feb 2025 07:40:11 +0000 (GMT)
Date: Thu, 27 Feb 2025 13:10:08 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ranxiaokai627@163.com, rostedt@goodmis.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn, yang.guang5@zte.com.cn,
        Wang Yong <wang.yong12@zte.com.cn>
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for
 cpus_read_lock()
Message-ID: <Z8AW2Ny1NrKNh_dZ@linux.ibm.com>
References: <20250225123132.2583820-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225123132.2583820-1-ranxiaokai627@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C5y69yw7p7oN9PyN6rs5g30i44MPJys3
X-Proofpoint-ORIG-GUID: IYp1q1T8vT2yHZLj68_uEdTfsG9O5MHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270056

Hi,

On Tue, Feb 25, 2025 at 12:31:32PM +0000, Ran Xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Lockdep reports this deadlock log:
> ============================================
> WARNING: possible recursive locking detected
> --------------------------------------------
> sh/31444 is trying to acquire lock:
> ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
> stop_per_cpu_kthreads+0x7/0x60
> 
> but task is already holding lock:
> ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
> start_per_cpu_kthreads+0x28/0x140
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(cpu_hotplug_lock);
>   lock(cpu_hotplug_lock);
> 
> Call Trace:
>  <TASK>
>  __lock_acquire+0x1612/0x29b0
>  lock_acquire+0xd0/0x2e0
>  cpus_read_lock+0x49/0x120
>  stop_per_cpu_kthreads+0x7/0x60
>  start_kthread+0x105/0x120
>  start_per_cpu_kthreads+0xdd/0x140
>  osnoise_workload_start+0x261/0x2f0
>  osnoise_tracer_start+0x18/0x4
> 
> In start_kthread(), when kthread_run_on_cpu() fails,
> cpus_read_unlock() should be called before stop_per_cpu_kthreads(),
> but both start_per_cpu_kthreads() and start_kthread() call the error
> handling routine stop_per_cpu_kthreads(),
> which is redundant. Only one call is necessary.
> To fix this, move stop_per_cpu_kthreads() outside of start_kthread(),
> use the return value of start_kthread() to determine kthread creation
> error.
> The same issue exists in osnoise_hotplug_workfn() too.
> 
> Reviewed-by: Yang Guang <yang.guang5@zte.com.cn>
> Reviewed-by: Wang Yong <wang.yong12@zte.com.cn>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/trace/trace_osnoise.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 92e16f03fa4e..38fb0c655f5b 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2029,7 +2029,6 @@ static int start_kthread(unsigned int cpu)
>  
>  	if (IS_ERR(kthread)) {
>  		pr_err(BANNER "could not start sampling thread\n");
> -		stop_per_cpu_kthreads();
>  		return -ENOMEM;
>  	}
>  
> @@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
> work_struct *dummy)
>  		return;
>  
>  	guard(mutex)(&interface_lock);
> -	guard(cpus_read_lock)();
> +	cpus_read_lock();
>  
>  	if (!cpu_online(cpu))
>  		return;
> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
> work_struct *dummy)
>  	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
>  		return;
>  
> -	start_kthread(cpu);
> +	if (start_kthread(cpu)) {
> +		cpus_read_unlock();
> +		stop_per_cpu_kthreads();

Is it right to call stop_per_cpu_kthreads() which stops osnoise kthread
for every other CPUs in the system if a failure occurs during hotplug of a
CPU?

On another note, since stop_per_cpu_kthreads() invokes stop_kthread()
for every online CPU. It's better to remove stop_per_cpu_kthreads() from
start_kthread() and handle the error in `osnoise_hotplug_workfn` 

	Vishal
> +		return;
> +	}
> +	cpus_read_unlock();
>  }
>  
>  static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
> -- 
> 2.15.2
> 
