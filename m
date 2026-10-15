Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29D3EB0F2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080049; cv=none; b=EN1bMbn7IwMg97XhMkI24muD9IySskW1IZPeAprj40fdHOHm4fMBb/sAf8ZK4qd9lVNYHtlDlVnWGMJCcNAay7hn1VdjF4gJhBLJwID2Kvv4h0IdaNWZXLrA5ltEbfXVAPRh4G58pZKHe3tnSthP6yLbop1hw8+I83CHobluwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080049; c=relaxed/simple;
	bh=Q8kItJVsWWmsGFjBSW5i/8M3gtH3LqujXVXYI7nhe84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s//hIT0nO+/9T14VaHSb8EkKXQdOZTiCUVsJ9OjK5jTHzYzIkpiL1+s6mHtZpj4p71TtU/SYmPlFCuEblsxC7kliZ2D4OcjV+1VyqZ4rKWTEEHYt5hRXL0U5uSr7FaozhFquS6+NC5Fg8IZpNcnHqpV2OBLHpMZYTwpvaCghn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z17711Tz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z17711Tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792080037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69I5z43SNpWpQOCMT7NnKODZLMO9VTaM22ZCdgeumX0=;
	b=Z17711TznNkCKzeF57h7djhp+4xvTRaD3XwIb9pz8F8OJf9wsgdzDuSjXnMJLwc1jnfCdo
	sRDObDpcKGY2dOCmNv2wG4USPlvmobVFAUnzS/n8Kj1Z7/O3SIKWRTcS2G6jhNaEE4C7vV
	KUHZ1IK5W5dU2YxGvm18JcrwmVJnD7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-x93ERWNBN8yYwCEjMNbQuw-1; Thu,
 15 Oct 2026 16:00:33 +0000
X-MC-Unique: x93ERWNBN8yYwCEjMNbQuw-1
X-Mimecast-MFC-AGG-ID: x93ERWNBN8yYwCEjMNbQuw_1792080031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 668C01944B00;
	Thu, 15 Oct 2026 16:00:30 +0000 (UTC)
Received: from [100.91.18.181] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7963D180057F;
	Thu, 15 Oct 2026 16:00:26 +0000 (UTC)
Message-ID: <8d10bb84-d312-4be0-8c43-ddd602850a1d@redhat.com>
Date: Thu, 15 Oct 2026 12:00:25 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] tick/nohz: Add runtime control of non-idle tick
 suppression
To: Peng Wang <peng_wang@linux.alibaba.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 He Rongguang <herongguang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1792067271.git.peng_wang@linux.alibaba.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <cover.1792067271.git.peng_wang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 1cm8eOAw_jNrwuh44Cq7fYrHR134c5Y4-pg3BLdi5FA_1792080031
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 8:43 AM, Peng Wang wrote:
> Workloads and their need for periodic ticks can change after boot.
> This series lets userspace choose at runtime which CPUs in the boot-time
> nohz_full set retain the non-idle scheduler tick and which are permitted
> to stop it, while preserving the existing isolation configuration.
>
> The first patch adds a per-CPU tick dependency; the second exposes a
> sysfs CPU list. Permission defaults to all nohz_full CPUs. Revocation
> uses the existing asynchronous kick. Idle tick suppression is unchanged,
> and policy persists across hotplug.
So you are basically setting up more nohz_full CPUs than the system 
actually needs to use at the moment and so want to disable nohz/tick 
part of nohz_full CPUs that don't need it. Can you elaborate more about 
the problems solve by introducing this new behavior?
>
> Existing cpuset partition modes do not express this independent tick
> policy. Feedback on the proposed interface is welcome.

We are planning to eventually extend cpuset partition mode to change 
nohz_full at runtime. This is still a work in progress.

Regards,
Longman

>
> Thanks,
> Peng
>
> Peng Wang (2):
>    tick/nohz: Add a policy dependency for full dynticks
>    cpu: Add sysfs control of full dynticks policy
>
>   .../ABI/testing/sysfs-devices-system-cpu      | 40 ++++++++++++
>   drivers/base/cpu.c                            | 46 ++++++++++++++
>   include/linux/tick.h                          |  8 ++-
>   include/trace/events/timer.h                  |  3 +-
>   kernel/time/tick-sched.c                      | 62 +++++++++++++++++++
>   5 files changed, 156 insertions(+), 3 deletions(-)
>
>
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053

